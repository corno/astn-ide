import { isPositionBeforeLocation } from "./isPositionBeforeLocation"
import { ITypedTreeHandler } from "astn-typedtreehandler-api"
import { createHoverTextsGenerator } from "./createHoverTextsGenerator"
import * as tok from "astn-ide-api"
import { getEndLocationFromRange } from "./getEndLocationFromRange"

export function createHoverTextFinder(
    positionLine: number, //the line where the hover is requested
    positionCharacter: number, //the character where the hover is requested
    callback: (hoverText: string) => void,
): ITypedTreeHandler<tok.TokenizerAnnotationData> {
    return createHoverTextsGenerator(
        (annotation, getHoverText) => {
            //console.log("LOCATION", range.start.line, range.start.column, range.end.line, range.end.column)

            if (!isPositionBeforeLocation({
                positionLine: positionLine,
                positionCharacter: positionCharacter,
                location: annotation.range.start,
            })) {
                if (isPositionBeforeLocation({
                    positionLine: positionLine,
                    positionCharacter: positionCharacter,
                    location: getEndLocationFromRange(annotation.range),
                })) {
                    if (getHoverText !== null) {
                        callback(getHoverText())
                    }
                }
            }
        },
        () => { }
    )
}
