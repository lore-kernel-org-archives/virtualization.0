From: Ian Campbell <Ian.Campbell@xensource.com>
Subject: [PATCH 1/5] ELFNOTES: use a preprocessor macro to define the
	ELFNOTE helper
Date: Wed, 23 Aug 2006 16:09:27 +0100
Message-ID: <1156345767.12949.121.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

There are a bunch of issues with defining elf notes using assembler
macros, as described here:
http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D115633393226158&w=3D2

Therefore I replaced it with a pre-processor macro.

This is a new patch, it should fit into the series anywhere after the
-mm patch. It's been submitted to Andrew M so hopefully it'll get picked
up for next -mm.

Signed-off-by: Ian Campbell <ian.campbell@xensource.com>


diff -r 4b7cd997c08f include/linux/elfnote.h
--- a/include/linux/elfnote.h	Wed Aug 23 11:48:46 2006 +0100
+++ b/include/linux/elfnote.h	Wed Aug 23 12:44:27 2006 +0100
@@ -31,22 +31,24 @@
 /*
  * Generate a structure with the same shape as Elf{32,64}_Nhdr (which
  * turn out to be the same size and shape), followed by the name and
- * desc data with appropriate padding.  The 'desc' argument includes
- * the assembler pseudo op defining the type of the data: .asciz
- * "hello, world"
+ * desc data with appropriate padding.  The 'desctype' argument is the
+ * assembler pseudo op defining the type of the data e.g. .asciz while
+ * 'descdata' is the data itself e.g.  "hello, world".
+ *
+ * e.g. ELFNOTE(XYZCo, 42, .asciz, "forty-two")
+ *      ELFNOTE(XYZCo, 12, .long, 0xdeadbeef)
  */
-.macro ELFNOTE name type desc:vararg
-.pushsection ".note.\name"
-  .align 4
-  .long 2f - 1f			/* namesz */
-  .long 4f - 3f			/* descsz */
-  .long \type
-1:.asciz "\name"
-2:.align 4
-3:\desc
-4:.align 4
-.popsection
-.endm
+#define ELFNOTE(name, type, desctype, descdata)	\
+.pushsection .note.name			;	\
+  .align 4				;	\
+  .long 2f - 1f		/* namesz */	;	\
+  .long 4f - 3f		/* descsz */	;	\
+  .long type				;	\
+1:.asciz "name"				;	\
+2:.align 4				;	\
+3:desctype descdata			;	\
+4:.align 4				;	\
+.popsection				;
 #else	/* !__ASSEMBLER__ */
 #include <linux/elf.h>
 /*
