//: Playground - noun: a place where people can play

extension String {
    func index(of pattern: String ) -> Index? {
        // Calculate pattern length
        let patternLength = pattern.characters.count
        guard patternLength > 0, patternLength <= characters.count else { return nil }
        
        // Skip table
        // To determine how far to skip when character from pattern found
        var skipTable = [Character: Int]()
        for (i, c) in pattern.characters.enumerated() {
            skipTable[c] = patternLength - i - 1
        }
        
        // Last charater in pattern
        let p = pattern.index(before: pattern.endIndex)
        let lastChar = pattern[p]
        
        // Scanned right to left, skip ahead in string by length of pattern
        // startIndex already point at first charater, so minus 1
        var i = index(startIndex, offsetBy: patternLength - 1)
        
        // Step backwards through both strings until we find a charater that
        // doesn't match, or until we've reached the begining of the pattern
        func backwards() -> Index? {
            var q = p
            var j = i
            while q > pattern.startIndex {
                j = index(before: j)
                q = index(before: q)
                if self[j] != pattern[q] {
                    return nil
                }
            }
            return j
        }
        // Loop, until the end of the string is reached
        while i < endIndex {
            let c = self[i]
            
            // Current charater mathes the last character ?
            if c == lastChar {
                
                // Possible match, do backword search
                if let k = backwards() { return k}
                
                // No match, skip one charater only
                i = index(after: i)
            } else {
                
                // Charater not equal, skip ahead
                // Skip charaters is determined by skip table
                i = index(i, offsetBy: skipTable[c] ?? patternLength, limitedBy: endIndex) ?? endIndex
            }
        }
        return nil
    }
}
var str = "Hello, World"
print(str.index(of: "d"))
