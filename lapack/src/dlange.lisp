;;; Compiled by f2cl version:
;;; ("$Id: f2cl1.l,v 1.209 2008/09/11 14:59:55 rtoy Exp $"
;;;  "$Id: f2cl2.l,v 1.37 2008/02/22 22:19:33 rtoy Rel $"
;;;  "$Id: f2cl3.l,v 1.6 2008/02/22 22:19:33 rtoy Rel $"
;;;  "$Id: f2cl4.l,v 1.7 2008/02/22 22:19:34 rtoy Rel $"
;;;  "$Id: f2cl5.l,v 1.197 2008/09/11 15:03:25 rtoy Exp $"
;;;  "$Id: f2cl6.l,v 1.48 2008/08/24 00:56:27 rtoy Exp $"
;;;  "$Id: macros.l,v 1.106 2008/09/15 15:27:36 rtoy Exp $")

;;; Using Lisp International Allegro CL Enterprise Edition 8.1 [64-bit Linux (x86-64)] (Oct 7, 2008 17:13)
;;;
;;; Options: ((:prune-labels nil) (:auto-save t)
;;;           (:relaxed-array-decls t) (:coerce-assigns :as-needed)
;;;           (:array-type ':array) (:array-slicing t)
;;;           (:declare-common nil) (:float-format double-float))

(in-package :clml.lapack)


(let* ((one 1.0) (zero 0.0))
  (declare (type (double-float 1.0 1.0) one)
   (type (double-float 0.0 0.0) zero) (ignorable one zero))
  (defun dlange (norm m n a lda work)
    (declare (type (array double-float (*)) work a)
     (type (simple-array character (*)) norm)
     (type (f2cl-lib:integer4) lda n m))
    (f2cl-lib:with-multi-array-data ((norm character norm-%data%
                                      norm-%offset%)
                                     (a double-float a-%data%
                                      a-%offset%)
                                     (work double-float work-%data%
                                      work-%offset%))
      (prog ((scale 0.0) (sum 0.0) (value 0.0) (i 0) (j 0)
             (dlange 0.0))
            (declare (type (double-float) scale sum value dlange)
             (type (f2cl-lib:integer4) i j))
            (cond ((= (min (the f2cl-lib:integer4 m)
                           (the f2cl-lib:integer4 n))
                      0)
                   (setf value zero))
                  ((lsame norm "M")
                   (setf value zero)
                   (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                                 ((> j n) nil)
                                 (tagbody
                                     (f2cl-lib:fdo (i 1
                                                    (f2cl-lib:int-add i
                                                                      1))
                                                   ((> i m) nil)
                                                   (tagbody
                                                       (setf value
                                                             (max value
                                                                  (abs (f2cl-lib:fref a-%data%
                                                                                      (i
                                                                                       j)
                                                                                      ((1
                                                                                        lda)
                                                                                       (1
                                                                                        *))
                                                                                      a-%offset%))))
                                                     label10))
                                   label20)))
                  ((or (lsame norm "O") (f2cl-lib:fstring-= norm "1"))
                   (setf value zero)
                   (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                                 ((> j n) nil)
                                 (tagbody
                                     (setf sum zero)
                                     (f2cl-lib:fdo (i 1
                                                    (f2cl-lib:int-add i
                                                                      1))
                                                   ((> i m) nil)
                                                   (tagbody
                                                       (setf sum
                                                             (+ sum
                                                                (abs (f2cl-lib:fref a-%data%
                                                                                    (i
                                                                                     j)
                                                                                    ((1
                                                                                      lda)
                                                                                     (1
                                                                                      *))
                                                                                    a-%offset%))))
                                                     label30))
                                     (setf value (max value sum))
                                   label40)))
                  ((lsame norm "I")
                   (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                                 ((> i m) nil)
                                 (tagbody
                                     (setf (f2cl-lib:fref work-%data%
                                                          (i) ((1 *))
                                                          work-%offset%)
                                           zero)
                                   label50))
                   (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                                 ((> j n) nil)
                                 (tagbody
                                     (f2cl-lib:fdo (i 1
                                                    (f2cl-lib:int-add i
                                                                      1))
                                                   ((> i m) nil)
                                                   (tagbody
                                                       (setf (f2cl-lib:fref work-%data%
                                                                            (i)
                                                                            ((1
                                                                              *))
                                                                            work-%offset%)
                                                             (+ (f2cl-lib:fref work-%data%
                                                                               (i)
                                                                               ((1
                                                                                 *))
                                                                               work-%offset%)
                                                                (abs (f2cl-lib:fref a-%data%
                                                                                    (i
                                                                                     j)
                                                                                    ((1
                                                                                      lda)
                                                                                     (1
                                                                                      *))
                                                                                    a-%offset%))))
                                                     label60))
                                   label70))
                   (setf value zero)
                   (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                                 ((> i m) nil)
                                 (tagbody
                                     (setf value
                                           (max value
                                                (f2cl-lib:fref work-%data%
                                                               (i)
                                                               ((1 *))
                                                               work-%offset%)))
                                   label80)))
                  ((or (lsame norm "F") (lsame norm "E"))
                   (setf scale zero)
                   (setf sum one)
                   (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                                 ((> j n) nil)
                                 (tagbody
                                     (multiple-value-bind (var-0 var-1
                                                           var-2 var-3
                                                           var-4)
                                         (dlassq m
                                          (f2cl-lib:array-slice a
                                                                double-float
                                                                (1 j)
                                                                ((1
                                                                  lda)
                                                                 (1
                                                                  *)))
                                          1 scale sum)
                                       (declare
                                        (ignore var-0 var-1 var-2))
                                       (setf scale var-3)
                                       (setf sum var-4))
                                   label90))
                   (setf value (* scale (f2cl-lib:fsqrt sum)))))
            (setf dlange value)
            (go end_label)
       end_label (return (values dlange nil nil nil nil nil nil))))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::dlange
                 fortran-to-lisp::*f2cl-function-info*)
        (fortran-to-lisp::make-f2cl-finfo :arg-types '((simple-array
                                                        character
                                                        (1))
                                                       (fortran-to-lisp::integer4)
                                                       (fortran-to-lisp::integer4)
                                                       (array
                                                        double-float
                                                        (*))
                                                       (fortran-to-lisp::integer4)
                                                       (array
                                                        double-float
                                                        (*)))
          :return-values '(nil nil nil nil nil nil)
          :calls '(fortran-to-lisp::dlassq fortran-to-lisp::lsame))))

