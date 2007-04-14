From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH 27/28] paravirt: little compile fixes for vmi.c
Date: Sat, 14 Apr 2007 13:42:21 -0700
Message-ID: <20070414204925.437167746@goop.org>
References: <20070414204154.871250608@goop.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753703AbXDNVU7@vger.kernel.org>
Content-Disposition: inline; filename=vmi-fix-ff.patch
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Zachary Amsden <zach@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Zachary Amsden <zach@vmware.com>

---
 arch/i386/kernel/vmi.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

===================================================================
--- a/arch/i386/kernel/vmi.c
+++ b/arch/i386/kernel/vmi.c
@@ -73,10 +73,6 @@ static struct {
   	void (*set_lazy_mode)(int mode);
 } vmi_ops;
 
-/* XXX move this to alternative.h */
-extern struct paravirt_patch __parainstructions[],
-	__parainstructions_end[];
-
 /* Cached VMI operations */
 struct vmi_timer_ops vmi_timer_ops;
 
@@ -548,9 +544,9 @@ vmi_startup_ipi_hook(int phys_apicid, un
 }
 #endif
 
-static void vmi_set_lazy_mode(int mode)
-{
-	static DEFINE_PER_CPU(int, lazy_mode);
+static void vmi_set_lazy_mode(enum paravirt_lazy_mode mode)
+{
+	static DEFINE_PER_CPU(enum paravirt_lazy_mode, lazy_mode);
 
 	if (!vmi_ops.set_lazy_mode)
 		return;

-- 
