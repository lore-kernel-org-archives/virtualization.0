From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH 8/9] ask the hypervisor how much space it needs reserved
Date: Wed, 20 Jun 2007 16:17:34 -0700
Message-ID: <20070620231853.295485100@goop.org>
References: <20070620231726.834538992@goop.org>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=xen-dynamic-topaddr.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Vivek Goyal <vgoyal@in.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, v12n <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Ask the hypervisor how much space it needs reserved, since 32-on-64
doesn't need any space, and it may change in future.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

---
 arch/i386/xen/enlighten.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

===================================================================
--- a/arch/i386/xen/enlighten.c
+++ b/arch/i386/xen/enlighten.c
@@ -1085,6 +1085,17 @@ static const struct machine_ops __initda
 };
 
 
+static void __init xen_reserve_top(void)
+{
+	unsigned long top = HYPERVISOR_VIRT_START;
+	struct xen_platform_parameters pp;
+
+	if (HYPERVISOR_xen_version(XENVER_platform_parameters, &pp) == 0)
+		top = pp.virt_start;
+
+	reserve_top_address(-top + 2 * PAGE_SIZE);
+}
+
 /* First C function to be called on Xen boot */
 asmlinkage void __init xen_start_kernel(void)
 {
@@ -1134,7 +1145,7 @@ asmlinkage void __init xen_start_kernel(
 		paravirt_ops.kernel_rpl = 0;
 
 	/* set the limit of our address space */
-	reserve_top_address(-HYPERVISOR_VIRT_START + 2 * PAGE_SIZE);
+	xen_reserve_top();
 
 	/* set up basic CPUID stuff */
 	cpu_detect(&new_cpu_data);

-- 
