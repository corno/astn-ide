
import { ITypedTreeHandler } from "astn-typedtreehandler-api"

import { createCodeCompletionsGenerator, SerializeString } from "./createCodeCompletionsGenerator"
import { isPositionBeforeLocation } from "./isPositionBeforeLocation"
import * as tok from "astn-ide-api"

export function createCodeCompletionFinder(
    completionPositionLine: number,
    completionPositionCharacter: number,
    callback: (codeCompletion: string) => void,
    getEndLocationFromRange: (range: tok.Range) => tok.Location,
    serializeString: SerializeString,
): ITypedTreeHandler<tok.TokenizerAnnotationData> {
    function onPositionInContextOfRange(
        positionLine: number,
        positionCharacter: number,
        range: tok.Range,
        onBefore: () => void,
        onIn: () => void,
        onAfter: () => void,
        getEndLocationFromRange: (range: tok.Range) => tok.Location,
    ) {
        if (isPositionBeforeLocation({
            positionLine: positionLine,
            positionCharacter: positionCharacter,
            location: range.start,
        })) {
            onBefore()
        } else if (isPositionBeforeLocation({
            positionLine: positionLine,
            positionCharacter: positionCharacter,
            location: getEndLocationFromRange(range),
        })) {
            onIn()
    
        } else {
            onAfter()
        }
    }
    
    let positionAlreadyFound = false
    let previousAfter: null | (() => string[]) = null
    //console.log("FINDING COMPLETIONS", line, character)
    function generate(gs: (() => string[]) | null) {
        if (gs !== null) {
            const codeCompletions = gs()
            //console.log(codeCompletions)
            codeCompletions.forEach((codeCompletion) => {
                //console.log("codeCompletion", codeCompletion)
                callback(codeCompletion)
            })
        }
    }

    return createCodeCompletionsGenerator(
        (annotation, intra, after) => {
            if (!positionAlreadyFound) {
                onPositionInContextOfRange(
                    completionPositionLine,
                    completionPositionCharacter,
                    annotation.range,
                    () => {
                        generate(previousAfter)
                        positionAlreadyFound = true
                    },
                    () => {
                        generate(intra)
                        positionAlreadyFound = true
                    },
                    () => {
                        previousAfter = after
                    },
                    getEndLocationFromRange,
                )
            }
        },
        () => {
            if (!positionAlreadyFound) {
                generate(previousAfter)
            }
        },
        serializeString,
    )
}
