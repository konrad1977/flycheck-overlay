;;; flycheck-overlay-test.el --- Test utilities for flycheck-overlay -*- lexical-binding: t -*-

(require 'flycheck-overlay)
(require 'ert)

(defun flycheck-overlay-test-insert-errors ()
  "Insert sample errors into current buffer for testing.
Returns a list of created errors for verification."
  (let ((errors '()))
    ;; Clear buffer
    (erase-buffer)
    
    ;; Insert some code with errors
    (insert "Line 0: This line has an error\n")
    (insert "Line 1: This line has an error\n")
    (insert "Line 2: This line has a warning\n")
    (insert "Line 3: This line has an info message\n")
    (insert "Line 4: Multiple errors on one line\n")
    (insert "Line 5:\n")
    (insert "Line 6:\n")
    (insert "Line 7: This line has no errors or warnings \n")
    (insert "Line 8:\n")

    ;; Create error objects
    (push (flycheck-error-new-at 0 1 'error "Error at line 0 column 1") errors)
    (push (flycheck-error-new-at 2 2 'error "Error at line 2 column 2") errors)
    (push (flycheck-error-new-at 3 3 'warning "Warning at line 3 column 3") errors)
    (push (flycheck-error-new-at 4 4 'info "Info at line 4 and column 4") errors)
    (push (flycheck-error-new-at 5 5 'error "Error at line 5 column 5") errors)
    (push (flycheck-error-new-at 5 20 'warning "Warning at line 5 column 20") errors)
    (push (flycheck-error-new-at 9 5 'warning "Extra blank line detected at line 8 and column 5") errors)

    ;; Display the errors
    (flycheck-overlay--display-errors errors)
    
    errors))

(defun flycheck-overlay-test-buffer ()
  "Create a new buffer with test errors and return it."
  (let ((test-buffer (get-buffer-create "*flycheck-overlay-test*")))
    (with-current-buffer test-buffer
      (erase-buffer)
      (flycheck-overlay-mode 1)
      (flycheck-overlay-test-insert-errors))
    test-buffer))

;; Example usage:
(switch-to-buffer (flycheck-overlay-test-buffer))

(provide 'flycheck-overlay-test)
;;; flycheck-overlay-test.el ends here
