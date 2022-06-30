interface Array<T> {
    //pop: () => T
    push(v: T): void
    forEach(callback: (e: T, i: number) => void): void
    map<RT>(callback: (e: T, i: number) => RT): RT[]
    //includes(v: T): boolean
    //length: number
    //join(separator: string): string
    //pop(): undefined | T
    //concat(array: T[]): T[]
    //slice(position: number): T[]
    //sort(): T[]
    [n: number]: T

}
interface Boolean { }
interface CallableFunction { }
interface Function { }
interface IArguments { }
interface NewableFunction { }
interface Number {
    //toString(radix: number): string
}
interface Object { }
interface RegExp { }
interface String {
    //readonly length: number
    //substring(begin: number, end: number): string
    //substr(begin: number): string
    //charCodeAt(index: number): number
    //split(splitter: string): string[]
    // startsWith(str: string): boolean
    // replace(str: RegExp, rv: string): string
    //toUpperCase(): string
    //padStart():
}

interface Error {

}
//export const x = 5

declare function isNaN(v: any): boolean

interface ErrorConstructor {
    new(message?: string): Error
}

declare let Error: ErrorConstructor;
