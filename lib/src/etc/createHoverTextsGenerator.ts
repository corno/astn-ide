import * as pl from "pareto-lang-lib"

import { ITypedTreeHandler, ITypedValueHandler } from "astn-typedtreehandler-api"
import { AnnotatedToken } from "astn-tokenconsumer-api"

type GetHoverText = () => string


export type OnTokenHoverText<EventAnnotation> = (
    annotation: EventAnnotation,
    getHoverTexts: GetHoverText | null,
) => void

export function createHoverTextsGenerator<EventAnnotation>(
    onToken: OnTokenHoverText<EventAnnotation>,
    onEnd: () => void,
): ITypedTreeHandler<EventAnnotation> {

    function createValueHoverTextGenerator(
        name: string | null,
    ): ITypedValueHandler<EventAnnotation> {
        function addOnToken<Token>(token: AnnotatedToken<Token, EventAnnotation> | null) {
            if (name !== null) {
                const cn = name
                if (token !== null) {
                    onToken(token.annotation, () => {
                        return cn
                    })
                }
            }
        }
        return {
            onDictionary: ($) => {
                addOnToken($.token)
                return {
                    onClose: ($) => {
                        addOnToken($.token)
                    },
                    onEntry: () => {
                        return createValueHoverTextGenerator(null)
                    },
                }
            },
            onList: ($) => {
                addOnToken($.token)
                return {
                    onClose: ($) => {
                        addOnToken($.token)
                    },
                    onElement: () => {
                        return createValueHoverTextGenerator(null)
                    },
                }
            },
            onTaggedUnion: ($) => {
                addOnToken($.token)
                return {
                    onUnexpectedOption: () => {
                        return createValueHoverTextGenerator(null)
                    },
                    onOption: ($) => {
                        addOnToken($.token)
                        return createValueHoverTextGenerator(null)
                    },
                    onEnd: () => { },
                }
            },
            onSimpleString: ($) => {
                addOnToken($.token)
            },
            onMultilineString: ($) => {
                addOnToken($.token)
            },
            onTypeReference: () => {
                return createValueHoverTextGenerator(name)
            },
            onGroup: ($) => {
                switch ($.type[0]) {
                    case "mixin":
                        break
                    case "omitted":
                        break
                    case "verbose":
                        pl.cc($.type[1], ($) => {
                            addOnToken($)
                        })
                        break
                    case "shorthand":
                        pl.cc($.type[1], ($) => {
                            addOnToken($)
                        })
                        break
                    default:
                        pl.au($.type[0])
                }
                return {
                    onUnexpectedProperty: () => { },
                    onProperty: ($) => {
                        return createValueHoverTextGenerator($.key)
                    },
                    onClose: ($) => {
                        addOnToken($.token)
                    },
                }
            },
        }
    }
    return {
        root: createValueHoverTextGenerator(null),
        onEnd: () => {
            return onEnd()
        },
    }
}