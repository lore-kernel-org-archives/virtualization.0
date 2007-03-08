From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC/PATCH LGUEST X86_64 11/13] x86_64 HVC attempt.
Date: Thu, 08 Mar 2007 12:39:12 -0500
Message-ID: <1173375552.32170.13.camel@localhost.localdomain>
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

plain text document attachment (lguest64-hvc.patch)
This is a start to try to get HVC working for x86_64.

Signed-off-by: Steven Rostedt <srostedt@redhat.com>
Signed-off-by: Glauber de Oliveira Costa <glommer@gmail.com>
Cc: Chris Wright <chrisw@sous-sol.org>


Index: work-pv/drivers/char/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- work-pv.orig/drivers/char/Kconfig
+++ work-pv/drivers/char/Kconfig
@@ -595,6 +595,12 @@ config HVC_CONSOLE
 	  pSeries machines when partitioned support a hypervisor virtual
 	  console. This driver allows each pSeries partition to have a console
 	  which is accessed via the HMC.
+config HVC_LGUEST
+	bool "lguest hypervisor console"
+	depends on LGUEST_GUEST
+	select HVC_DRIVER
+	help
+	  Totally fubar
 =

 config HVC_ISERIES
 	bool "iSeries Hypervisor Virtual Console support"
Index: work-pv/drivers/char/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- work-pv.orig/drivers/char/Makefile
+++ work-pv/drivers/char/Makefile
@@ -43,7 +43,7 @@ obj-$(CONFIG_AMIGA_BUILTIN_SERIAL) +=3D am
 obj-$(CONFIG_SX)		+=3D sx.o generic_serial.o
 obj-$(CONFIG_RIO)		+=3D rio/ generic_serial.o
 obj-$(CONFIG_HVC_CONSOLE)	+=3D hvc_vio.o hvsi.o
-obj-$(CONFIG_LGUEST_GUEST)	+=3D hvc_lguest.o
+obj-$(CONFIG_HVC_GUEST)		+=3D hvc_lguest.o
 obj-$(CONFIG_HVC_ISERIES)	+=3D hvc_iseries.o
 obj-$(CONFIG_HVC_RTAS)		+=3D hvc_rtas.o
 obj-$(CONFIG_HVC_DRIVER)	+=3D hvc_console.o
Index: work-pv/drivers/char/hvc_lguest.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- work-pv.orig/drivers/char/hvc_lguest.c
+++ work-pv/drivers/char/hvc_lguest.c
@@ -25,7 +25,6 @@ static int cons_irq;
 static int cons_offset;
 static char inbuf[256];
 static struct lguest_dma cons_input =3D { .used_len =3D 0,
-					.addr[0] =3D __pa(inbuf),
 					.len[0] =3D sizeof(inbuf),
 					.len[1] =3D 0 };
 =

@@ -66,6 +65,12 @@ struct hv_ops lguest_cons =3D {
 =

 static int __init cons_init(void)
 {
+	/*
+	 * Can't initialize this in the const declarations,
+	 * since __pa(inbuf) does not evaluate into a constant.
+	 */
+	cons_input.addr[0] =3D __pa(inbuf);
+
 	if (strcmp(paravirt_ops.name, "lguest") !=3D 0)
 		return 0;
 =


--
