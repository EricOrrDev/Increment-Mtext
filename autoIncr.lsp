;; global variable to store the current value of startingInt
(setq newInt 0)

;; function to retrieve the text from a selected MText object
(defun retrieveText()
  (setq obj (car(entsel "Select Mtext")))
    (setq objData (entget obj))
    (setq text (cdr (assoc 1 objData)))
  text
)

;; function to split the text from an MText object into two parts
;; based on the last space in the string
(defun splitText(inputText)
  (setq stringLength (strlen inputText))
  (setq spaceList (findSpaces inputText))
  (setq lastSpace (car spaceList))
  
  (setq stringLeft (substr inputText 1 lastSpace))
  (setq stringRight (substr inputText (1+ lastSpace)))
  (setq startingInt (atoi stringRight))
  (setq resultList (list stringLeft startingInt))
  resultList
 )

;; function to find all the spaces in a given string
;; and return a list of their positions
(defun findSpaces (str)
  (setq i 1)
  (setq pos-list (list (vl-string-position 32 str)))  ; Initialize pos-list as a list containing the first space
  (while (< i (strlen str))
    (if (= (substr str i 1) " ")                      ; 32 is the ASCII code for a space
        (setq pos-list (cons i pos-list)))            ; Add the index to the front of the list
    (setq i (1+ i))
  )
  pos-list                                            ; Return list of space indices
)

;; This is the main function to place an MText object
;; and increment the integer to be concatenated at the end
(defun c:placeMText()
  (setq text (retrieveText))
  (setq result (splitText text))
  (setq stringLeft (car result))
  (setq startingInt (last result))
  (setq newInt (+ 1 startingInt))
  (setq newText (strcat stringLeft (itoa newInt)))
  (setq insertPoint (getpoint "Pick Insertion Point"))
  
  (command "mtext"  insertPoint  "J" "MC" insertPoint newText "")
  (princ)
)
