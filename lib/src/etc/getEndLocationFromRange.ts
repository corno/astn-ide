import * as tokenLevel from "astn-ide-api"

export function getEndLocationFromRange(range: tokenLevel.Range): tokenLevel.Location {
    return {
        position: range.start.position + range.length, line: range.start.line, column: range.size[0] === "single line" ? range.size[1]["column offset"] + range.start.column : range.size[1].column,
    }
}
