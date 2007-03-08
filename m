From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC/PATCH PV_OPS X86_64 04/17] pavarvirt_ops - apci header updates
Date: Thu, 08 Mar 2007 01:02:02 -0500
Message-ID: <1173333722.25848.5.camel@localhost.localdomain>
References: <20070308054422.820010000@redhat.com>
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
Cc: Chris Wright <chrisw@sous-sol.org>, Glauber de Oliveira Costa <gcosta@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

plain text document attachment (xx-paravirt-apic-header.patch)
This patch updates the apic header file for switching =

apic_read and write for use with paravirt ops.

Signed-off-by: Steven Rostedt srostedt@redhat.com
Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>

Index: clean-start/include/asm-x86_64/apic.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- clean-start.orig/include/asm-x86_64/apic.h
+++ clean-start/include/asm-x86_64/apic.h
@@ -37,16 +37,24 @@ struct pt_regs;
  * Basic functions accessing APICs.
  */
 =

-static __inline void apic_write(unsigned long reg, unsigned int v)
+static __inline void native_apic_write(unsigned long reg, unsigned int v)
 {
 	*((volatile unsigned int *)(APIC_BASE+reg)) =3D v;
 }
 =

-static __inline unsigned int apic_read(unsigned long reg)
+static __inline unsigned int native_apic_read(unsigned long reg)
 {
 	return *((volatile unsigned int *)(APIC_BASE+reg));
 }
 =

+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
+#define apic_write native_apic_write
+#define apic_read native_apic_read
+
+#endif /* CONFIG_PARAVIRT */
+
 static __inline__ void apic_wait_icr_idle(void)
 {
 	while (apic_read( APIC_ICR ) & APIC_ICR_BUSY)

--
