From: Zachary Amsden <zach@vmware.com>
Subject: [PATCH] Fix preemptible lazy mode bug
Date: Thu, 23 Aug 2007 22:46:48 -0700
Message-ID: <46CE70C8.2030005__29375.9319036782$1187934835$gmane$org@vmware.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090502080601000103010309"
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
To: Linus Torvalds <torvalds@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Jeremy Fitzhardinge <jeremy@goop.org>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------090502080601000103010309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I recently sent off a fix for lazy vmalloc faults which can happen under 
paravirt when lazy mode is enabled.  Unfortunately, I jumped the gun a 
bit on fixing this.  I neglected to notice that since the new call to 
flush the MMU update queue is called from the page fault handler, it can 
be pre-empted.  Both VMI and Xen use per-cpu variables to track lazy 
mode state, as all previous calls to set, disable, or flush lazy mode 
happened from a non-preemptable state.

I have no idea how to convincingly produce the problem, as generating a 
kernel pre-emption at the required point is, um, difficult, but it is 
most certainly a real possibility, and potentially more likely than the 
bug I fixed originally.

Rusty, you may have to modify lguest code if you use lazy mode and rely 
on per-cpu variables during the callout for paravirt_ops.set_lazy_mode.

I have tested as best as I can, and am trying to write a suite destined 
for LTP which will help catch and debug these issues.

Zach

--------------090502080601000103010309
Content-Type: text/x-patch;
 name="i386-paravirt-preempt-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i386-paravirt-preempt-fix.patch"

Since set_lazy_mode(LAZY_MODE_FLUSH) is now called from the page fault
handler, it can potentially happen in a preemptible state.  We therefore
must make all lazy mode paravirt-ops handlers non-preemptible.

Signed-off-by: Zachary Amsden <zamsden@mysore.(none)>
---
 arch/i386/kernel/vmi.c    |   14 ++++++++++----
 arch/i386/xen/enlighten.c |    4 +++-
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/i386/kernel/vmi.c b/arch/i386/kernel/vmi.c
index 18673e0..9e669cb 100644
--- a/arch/i386/kernel/vmi.c
+++ b/arch/i386/kernel/vmi.c
@@ -555,21 +555,27 @@ vmi_startup_ipi_hook(int phys_apicid, unsigned long start_eip,
 static void vmi_set_lazy_mode(enum paravirt_lazy_mode mode)
 {
 	static DEFINE_PER_CPU(enum paravirt_lazy_mode, lazy_mode);
+	int cpu;
+	enum paravirt_lazy_mode cur_mode;
 
 	if (!vmi_ops.set_lazy_mode)
 		return;
 
+	cpu = get_cpu();
+	cur_mode = per_cpu(lazy_mode, cpu);
+
 	/* Modes should never nest or overlap */
-	BUG_ON(__get_cpu_var(lazy_mode) && !(mode == PARAVIRT_LAZY_NONE ||
-					     mode == PARAVIRT_LAZY_FLUSH));
+	BUG_ON(cur_mode && !(mode == PARAVIRT_LAZY_NONE ||
+			     mode == PARAVIRT_LAZY_FLUSH));
 
 	if (mode == PARAVIRT_LAZY_FLUSH) {
 		vmi_ops.set_lazy_mode(0);
-		vmi_ops.set_lazy_mode(__get_cpu_var(lazy_mode));
+		vmi_ops.set_lazy_mode(cur_mode);
 	} else {
 		vmi_ops.set_lazy_mode(mode);
-		__get_cpu_var(lazy_mode) = mode;
+		per_cpu(lazy_mode, cpu) = mode;
 	}
+	put_cpu();
 }
 
 static inline int __init check_vmi_rom(struct vrom_header *rom)
diff --git a/arch/i386/xen/enlighten.c b/arch/i386/xen/enlighten.c
index f0c3751..2dafb8a 100644
--- a/arch/i386/xen/enlighten.c
+++ b/arch/i386/xen/enlighten.c
@@ -251,7 +251,7 @@ static void xen_halt(void)
 
 static void xen_set_lazy_mode(enum paravirt_lazy_mode mode)
 {
-	BUG_ON(preemptible());
+	get_cpu();
 
 	switch (mode) {
 	case PARAVIRT_LAZY_NONE:
@@ -267,11 +267,13 @@ static void xen_set_lazy_mode(enum paravirt_lazy_mode mode)
 		/* flush if necessary, but don't change state */
 		if (x86_read_percpu(xen_lazy_mode) != PARAVIRT_LAZY_NONE)
 			xen_mc_flush();
+		put_cpu();
 		return;
 	}
 
 	xen_mc_flush();
 	x86_write_percpu(xen_lazy_mode, mode);
+	put_cpu();
 }
 
 static unsigned long xen_store_tr(void)
-- 
1.4.4.4


--------------090502080601000103010309
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--------------090502080601000103010309--
