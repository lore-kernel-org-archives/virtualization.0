From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC/PATCH LGUEST X86_64 13/13] Hack to get output
Date: Thu, 08 Mar 2007 12:39:17 -0500
Message-ID: <1173375557.32170.15.camel@localhost.localdomain>
References: <20070308162348.299676000@redhat.com>
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
To: virtualization@lists.osdl.org
Cc: Chris Wright <chrisw@sous-sol.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

plain text document attachment (lguest64-debug.patch)
This is just a hack patch to get output from the guest.
It calls lguest_vprint from printk which is a hypercall
to the host to do the printk for the guest.

Chris Wright recommended that I put this into early_printk,
but until I can get that to work, I'm posting this.

Signed-off-by: Steven Rostedt <srostedt@redhat.com>
Cc: Glauber de Oliveira Costa <glommer@gmail.com>
Cc: Chris Wright <chrisw@sous-sol.org>


Index: work-pv/kernel/printk.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- work-pv.orig/kernel/printk.c
+++ work-pv/kernel/printk.c
@@ -499,12 +499,17 @@ static int have_callable_console(void)
  * printf(3)
  */
 =

+extern void lguest_vprint(const char *fmt, va_list ap);
 asmlinkage int printk(const char *fmt, ...)
 {
 	va_list args;
+	va_list lgargs;
 	int r;
 =

 	va_start(args, fmt);
+	va_copy(lgargs, args);
+	lguest_vprint(fmt, lgargs);
+	va_end(lgargs);
 	r =3D vprintk(fmt, args);
 	va_end(args);
 =


--
