From: Ian Campbell <Ian.Campbell@xensource.com>
Subject: [PATCH 5/5] XEN: fixup APIC accessors when !CONFIG_X86_LOCAL_APIC
Date: Wed, 23 Aug 2006 16:09:52 +0100
Message-ID: <1156345792.12949.127.camel@localhost.localdomain>
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

OK, not strictly in keeping with the subject of the patch set but I
needed this to build ;-)

Should be merged into 02d-xen-apic-esp0.patch

Signed-off-by: Ian Campbell <ian.campbell@xensource.com>

diff -r 6fdbec59813e arch/i386/paravirt-xen/enlighten.c
--- a/arch/i386/paravirt-xen/enlighten.c	Wed Aug 23 15:08:37 2006 +0100
+++ b/arch/i386/paravirt-xen/enlighten.c	Wed Aug 23 15:08:37 2006 +0100
@@ -310,6 +310,7 @@ static fastcall void xen_io_delay(void)
 {
 }
 =

+#ifdef CONFIG_X86_LOCAL_APIC
 static fastcall void xen_apic_write(unsigned long reg, unsigned long v)
 {
 }
@@ -322,6 +323,7 @@ static fastcall unsigned long xen_apic_r
 {
 	return 0;
 }
+#endif
 =

 static fastcall void xen_flush_tlb(void)
 {
@@ -422,9 +424,11 @@ static const struct paravirt_ops xen_par
 	.set_wallclock =3D xen_set_wallclock,
 	.get_wallclock =3D xen_get_wallclock,
 =

+#ifdef CONFIG_X86_LOCAL_APIC
 	.apic_write =3D xen_apic_write,
 	.apic_write_atomic =3D xen_apic_write_atomic,
 	.apic_read =3D xen_apic_read,
+#endif
 =

 	.flush_tlb_user =3D xen_flush_tlb,
 	.flush_tlb_kernel =3D xen_flush_tlb_global,
