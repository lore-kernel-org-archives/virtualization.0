From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 5/10] Make hvc_console.c compile on non-PowerPC
Date: Fri, 09 Feb 2007 20:19:20 +1100
Message-ID: <1171012761.2718.40.camel@localhost.localdomain>
References: <1171012296.2718.26.camel@localhost.localdomain>
	<1171012458.2718.30.camel@localhost.localdomain>
	<1171012693.2718.37.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1171012693.2718.37.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, Stephen Rothwell <sfr@canb.auug.org.au>, Paul Mackerras <paulus@samba.org>, virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

There's a really nice console helper (esp. for virtual console
drivers) in drivers/char/hvc_console.c.  It has only ever been used
for PowerPC, though, so it uses NO_IRQ which is only defined there.

Let's fix that so it's more widely useful.  By, say, lguest.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/char/hvc_console.c
+++ b/drivers/char/hvc_console.c
@@ -48,6 +48,10 @@
 #define HVC_MINOR	0
 =

 #define TIMEOUT		(10)
+
+#ifndef NO_IRQ
+#define NO_IRQ 0
+#endif
 =

 /*
  * Wait this long per iteration while trying to push buffered data to the
