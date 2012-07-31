;skeletons.el
;The author disclaims copyright to this source code. It is placed in
;the public domain. In case this is not legally possible I grant anyone
;the right to use it for any purpose, without any conditions, unless
;such conditions are required by law.

(define-skeleton copyright-gpl-3+
  "Insert a GPLv3+ copyright notice at cursor."
  "Program name:"
  comment-start
  str
  comment-end \n
  '(copyright)
  \n \n
  comment-start
  "This program is free software: you can redistribute it and/or modify"
  comment-end \n
  comment-start
  "it under the terms of the GNU General Public License as published by"
  comment-end \n
  comment-start
  "the Free Software Foundation, either version 3 of the License, or (at"
  comment-end \n
  comment-start
  "your option) any later version."
  comment-end \n
  \n
  comment-start
  "This program is distributed in the hope that it will be useful, but"
  comment-end \n
  comment-start
  "WITHOUT ANY WARRANTY; without even the implied warranty of"
  comment-end \n
  comment-start
  "MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU"
  comment-end \n
  comment-start
  "General Public License for more details."
  comment-end \n
  \n
  comment-start
  "You should have received a copy of the GNU General Public License"
  comment-end \n
  comment-start
  "along with this program.  If not, see <http://www.gnu.org/licenses/>."
  comment-end \n)

(define-skeleton copyright-agpl-3+
  "Insert an AGPLv3+ copyright notice at cursor."
  "Program name:"
  comment-start
  str
  comment-end \n
  '(copyright)
  \n \n
  comment-start
  "This program is free software: you can redistribute it and/or modify"
  comment-end \n
  comment-start
  "it under the terms of the GNU Affero General Public License as"
  comment-end \n
  comment-start
  "published by the Free Software Foundation, either version 3 of the"
  comment-end \n
  comment-start
  "License, or (at your option) any later version."
  comment-end \n
  \n
  comment-start
  "This program is distributed in the hope that it will be useful,"
  comment-end \n
  comment-start
  "but WITHOUT ANY WARRANTY; without even the implied warranty of"
  comment-end \n
  comment-start
  "MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the"
  comment-end \n
  comment-start
  "GNU Affero General Public License for more details."
  comment-end \n
  \n
  comment-start
  "You should have received a copy of the GNU Affero General Public License"
  comment-end \n
  comment-start
  "along with this program.  If not, see <http://www.gnu.org/licenses/>."
  comment-end \n)

(define-skeleton copyright-public-domain
  "Insert copyright disclaimer note at cursor."
  "Program name:"
  comment-start
  str
  comment-end \n
  comment-start
  "The author disclaims copyright to this source code. It is placed in"
  comment-end \n
  comment-start
  "the public domain. In case this is not legally possible I grant anyone"
  comment-end \n
  comment-start
  "the right to use it for any purpose, without any conditions, unless"
  comment-end \n
  comment-start
  "such conditions are required by law."
  comment-end \n)
