From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] Fix 'arch/i386/kernel/paravirt.c:481: warning:
	initialization from incompatible pointer type'
Date: Sun, 05 Nov 2006 17:02:55 +1100
Message-ID: <1162706575.29777.33.camel@localhost.localdomain>
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
To: virtualization <virtualization@lists.osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Chris Wright <chrisw@sous-sol.org>
List-Id: virtualization@lists.linuxfoundation.org

Fix paravirt_probe() macro so that handing it start_kernel doesn't
evoke a warning (start_kernel is asmlinkage).

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdi=
ff --minimal linux-2.6.19-rc4-mm2/include/asm-i386/paravirt.h working-2.6.1=
9-rc4-mm2-warnings/include/asm-i386/paravirt.h
--- linux-2.6.19-rc4-mm2/include/asm-i386/paravirt.h	2006-11-05 15:35:55.00=
0000000 +1100
+++ working-2.6.19-rc4-mm2-warnings/include/asm-i386/paravirt.h	2006-11-05 =
16:03:41.000000000 +1100
@@ -147,7 +147,7 @@ struct paravirt_ops
 =

 /* Mark a paravirt probe function. */
 #define paravirt_probe(fn)						\
-	static void (*__paravirtprobe_##fn)(void) __attribute_used__	\
+ static asmlinkage void (*__paravirtprobe_##fn)(void) __attribute_used__ \
 		__attribute__((__section__(".paravirtprobe"))) =3D fn
 =

 extern struct paravirt_ops paravirt_ops;
