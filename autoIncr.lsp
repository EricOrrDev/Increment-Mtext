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
  (setq lastSpace (last (find-spaces inputText)))
  
  (setq stringLeft (substr inputText 1 lastSpace))
  (setq stringRight (substr inputText (+ lastSpace 2) stringLength))
  (setq startingInt (atoi stringRight))
  (setq resultList (list stringLeft startingInt))
  resultList
 )

;; function to find all the spaces in a given string
;; and return a list of their positions
(defun find-spaces (str)
  (setq pos-list nil)
  (setq i 0)
  (while (< i (strlen str))
    (setq position (vl-string-position 32 str)) ;;32 is the ASCII code for space
    (setq pos-list (cons position pos-list))
    (setq i (1+ i)))
  pos-list
)



;; This is the main function to place an MText object
;; and increment the integer to be concatenated at the end
(defun c:placeMText()
  (setq text (retrieveText))
  (setq result (splitText text))
  (setq stringLeft (car result))
  (setq startingInt (cadr result))
  (setq newInt (+ newInt startingInt))
  (setq newText (strcat stringLeft " " (itoa g_startingInt)))
  (setq insertPoint (getpoint "Pick Insertion Point"))
  ; (setq mtextData (list (cons 0 "MTEXT")
  ;                       (cons 1 newText)
  ;                       (cons 100 "AcDbEntity")
  ;                       (cons 100 "AcDbMText") 
  ;                       (cons 10 insertPoint)
  ;                       (cons 11 insertPoint)
  ;                       (cons 72 1) ;Horizontal text justification,0=Left,1=Center,2=Right,4=Center,5=Fit
  ;                       (cons 73 1) ;Vertical text justification,0=Left,1=Center,2=Right,4=Center,5=Fit
  ;                 ))
  ;(entmake mtextData)
  (command "mtext" insertPoint insertPoint newText)
)

