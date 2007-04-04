From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] Lguest32 print hex on bad reads and writes
Date: Wed, 04 Apr 2007 15:14:31 -0400
Message-ID: <1175714071.9371.31.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.osdl.org, Glauber de Oliveira Costa <glommer@gmail.com>, Rusty Russell <rusty@rustcorp.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Currently the lguest32 error messages from bad reads and writes prints a
decimal integer for addresses. This is pretty annoying. So this patch
changes those to be hex outputs.

This is applied on top of my debug patch.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.21-rc5-mm2/drivers/lguest/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.21-rc5-mm2.orig/drivers/lguest/core.c
+++ linux-2.6.21-rc5-mm2/drivers/lguest/core.c
@@ -220,7 +220,7 @@ u8 lgread_u8(struct lguest *lg, u32 addr
 	/* Don't let them access lguest binary */
 	if (!lguest_address_ok(lg, addr)
 	    || get_user(val, (u32 __user *)addr) !=3D 0)
-		kill_guest(lg, "bad read address %u", addr);
+		kill_guest(lg, "bad read address %x", addr);
 	return val;
 }
 =

@@ -231,7 +231,7 @@ u16 lgread_u16(struct lguest *lg, u32 ad
 	/* Don't let them access lguest binary */
 	if (!lguest_address_ok(lg, addr)
 	    || get_user(val, (u32 __user *)addr) !=3D 0)
-		kill_guest(lg, "bad read address %u", addr);
+		kill_guest(lg, "bad read address %x", addr);
 	return val;
 }
 =

@@ -242,7 +242,7 @@ u32 lgread_u32(struct lguest *lg, u32 ad
 	/* Don't let them access lguest binary */
 	if (!lguest_address_ok(lg, addr)
 	    || get_user(val, (u32 __user *)addr) !=3D 0)
-		kill_guest(lg, "bad read address %u", addr);
+		kill_guest(lg, "bad read address %x", addr);
 	return val;
 }
 =

@@ -250,7 +250,7 @@ void lgwrite_u32(struct lguest *lg, u32 =

 {
 	if (!lguest_address_ok(lg, addr)
 	    || put_user(val, (u32 __user *)addr) !=3D 0)
-		kill_guest(lg, "bad write address %u", addr);
+		kill_guest(lg, "bad write address %x", addr);
 }
 =

 void lgread(struct lguest *lg, void *b, u32 addr, unsigned bytes)
@@ -259,7 +259,7 @@ void lgread(struct lguest *lg, void *b, =

 	    || copy_from_user(b, (void __user *)addr, bytes) !=3D 0) {
 		/* copy_from_user should do this, but as we rely on it... */
 		memset(b, 0, bytes);
-		kill_guest(lg, "bad read address %u len %u", addr, bytes);
+		kill_guest(lg, "bad read address %x len %u", addr, bytes);
 	}
 }
 =

@@ -268,7 +268,7 @@ void lgwrite(struct lguest *lg, u32 addr
 	if (addr + bytes < addr
 	    || !lguest_address_ok(lg, addr+bytes)
 	    || copy_to_user((void __user *)addr, b, bytes) !=3D 0)
-		kill_guest(lg, "bad write address %u len %u", addr, bytes);
+		kill_guest(lg, "bad write address %x len %u", addr, bytes);
 }
 =

 static void set_ts(unsigned int guest_ts)
