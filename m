From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 6/6] Allow boot-time disable of paravirt_ops patching
Date: Tue, 03 Apr 2007 18:07:01 -0700
Message-ID: <20070404011453.879668615@goop.org>
References: <20070404010655.400913479@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=disable-paravirt-patching.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Add "noreplace-paravirt" to disable paravirt_ops patching.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>

---
 Documentation/kernel-parameters.txt |    3 +++
 arch/i386/kernel/alternative.c      |   13 +++++++++++++
 2 files changed, 16 insertions(+)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -64,6 +64,7 @@ parameter is applicable:
 	GENERIC_TIME The generic timeofday code is enabled.
 	NFS	Appropriate NFS support is enabled.
 	OSS	OSS sound support is enabled.
+	PV_OPS	A paravirtualized kernel
 	PARIDE	The ParIDE subsystem is enabled.
 	PARISC	The PA-RISC architecture is enabled.
 	PCI	PCI bus support is enabled.
@@ -1134,6 +1135,8 @@ and is between 256 and 4096 characters. =

 	nomca		[IA-64] Disable machine check abort handling
 =

 	nomce		[IA-32] Machine Check Exception
+
+	noreplace-paravirt	[IA-32,PV_OPS] Don't patch paravirt_ops
 =

 	noreplace-smp	[IA-32,SMP] Don't replace SMP instructions
 			with UP alternatives
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/alternative.c
+++ b/arch/i386/kernel/alternative.c
@@ -30,6 +30,16 @@ static int __init setup_noreplace_smp(ch
 }
 __setup("noreplace-smp", setup_noreplace_smp);
 =

+#ifdef CONFIG_PARAVIRT
+static int noreplace_paravirt =3D 0;
+
+static int __init setup_noreplace_paravirt(char *str)
+{
+	noreplace_paravirt =3D 1;
+	return 1;
+}
+__setup("noreplace-paravirt", setup_noreplace_paravirt);
+#endif
 =

 #define DPRINTK(fmt, args...) if (debug_alternative) \
 	printk(KERN_DEBUG fmt, args)
@@ -329,6 +339,9 @@ void apply_paravirt(struct paravirt_patc
 {
 	struct paravirt_patch *p;
 =

+	if (noreplace_paravirt)
+		return;
+
 	for (p =3D start; p < end; p++) {
 		unsigned int used;
 =


-- =
