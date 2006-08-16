From: Chris Wright <chrisw@sous-sol.org>
Subject: [PATCH] remove overwrite_paravirt_ops
Date: Wed, 16 Aug 2006 08:51:37 -0700
Message-ID: <20060816155137.GU10348@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>, Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

It's not used, and we can be explicit in a paravirt_ops about which native
pieces are preferred, so it's not needed.  Also, the loop is a bit dodgy
(works ok, since sizeof(unsigned int) is 4 on x86, but...)  Before I
commit, any objections?

Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

diff -r ea8912509a0e arch/i386/kernel/paravirt.c
--- a/arch/i386/kernel/paravirt.c	Wed Aug 16 09:49:27 2006 -0400
+++ b/arch/i386/kernel/paravirt.c	Wed Aug 16 11:34:12 2006 -0400
@@ -402,18 +402,6 @@ static void __init default_banner(void)
 {
 	printk(KERN_INFO "Booting paravirtualized kernel on %s\n",
 	       paravirt_ops.name);
-}
-
-/* Overwrite ops struct with non-NULL ops entries from this struct. */
-void overwrite_paravirt_ops(const struct paravirt_ops *ops)
-{
-	unsigned int i;
-	void **src =3D (void **)ops, **dst =3D (void **)&paravirt_ops;
-
-	for (i =3D 0; i < sizeof(struct paravirt_ops) / 4; i++) {
-		if (src[i])
-			dst[i] =3D src[i];
-	}
 }
 =

 static int __init print_banner(void)
diff -r ea8912509a0e include/asm-i386/paravirt.h
--- a/include/asm-i386/paravirt.h	Wed Aug 16 09:49:27 2006 -0400
+++ b/include/asm-i386/paravirt.h	Wed Aug 16 11:34:48 2006 -0400
@@ -110,9 +110,6 @@ struct paravirt_ops
 		__attribute__((__section__(".paravirtprobe"))) =3D fn
 =

 extern struct paravirt_ops paravirt_ops;
-
-/* Overwrite ops struct with non-NULL ops entries from this struct. */
-void overwrite_paravirt_ops(const struct paravirt_ops *ops);
 =

 /* Non-paravirtualized implementations of various operations for
    back-ends which don't need their own version. */
