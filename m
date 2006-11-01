From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 4/7] paravirtualization: Allow selected bug checks to be
	skipped by paravirt kernels
Date: Wed, 01 Nov 2006 21:30:43 +1100
Message-ID: <1162377043.23462.12.camel@localhost.localdomain>
References: <20061029024504.760769000@sous-sol.org>
	<20061029024607.401333000@sous-sol.org> <200610290831.21062.ak@suse.de>
	<1162178936.9802.34.camel@localhost.localdomain>
	<20061030231132.GA98768@muc.de>
	<1162376827.23462.5.camel@localhost.localdomain>
	<1162376894.23462.7.camel@localhost.localdomain>
	<1162376981.23462.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1162376981.23462.10.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andi Kleen <ak@muc.de>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Allow selected bug checks to be skipped by paravirt kernels.  The two most
important are the F00F workaround (which is either done by the hypervisor,
or not required), and the 'hlt' instruction check, which can break under
some hypervisors.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/cpu/intel.c
+++ b/arch/i386/kernel/cpu/intel.c
@@ -107,7 +107,7 @@ static void __cpuinit init_intel(struct =

 	 * Note that the workaround only should be initialized once...
 	 */
 	c->f00f_bug =3D 0;
-	if ( c->x86 =3D=3D 5 ) {
+	if (!paravirt_enabled() && c->x86 =3D=3D 5) {
 		static int f00f_workaround_enabled =3D 0;
 =

 		c->f00f_bug =3D 1;
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/bugs.h
+++ b/include/asm-i386/bugs.h
@@ -21,6 +21,7 @@
 #include <asm/processor.h>
 #include <asm/i387.h>
 #include <asm/msr.h>
+#include <asm/paravirt.h>
 =

 static int __init no_halt(char *s)
 {
@@ -91,6 +92,9 @@ static void __init check_fpu(void)
 =

 static void __init check_hlt(void)
 {
+	if (paravirt_enabled())
+		return;
+
 	printk(KERN_INFO "Checking 'hlt' instruction... ");
 	if (!boot_cpu_data.hlt_works_ok) {
 		printk("disabled\n");
