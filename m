From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: [PATCH RFC V6 6/11] xen/pvticketlocks: add xen_nopvspin parameter to
	disable xen pv ticketlocks
Date: Wed, 21 Mar 2012 15:51:49 +0530
Message-ID: <20120321102149.473.80864.sendpatchset__32265.3706920848$1332329554$gmane$org@codeblue.in.ibm.com>
References: <20120321102041.473.61069.sendpatchset@codeblue.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120321102041.473.61069.sendpatchset@codeblue.in.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>
Cc: the arch/x86 maintainers <x86@kernel.org>, KVM <kvm@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Peter Zijlstra <peterz@infradead.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, LKML <linux-kernel@vger.kernel.org>, Virtualization <virtualization@lists.linux-foundation.org>, Andi Kleen <andi@firstfloor.org>, Avi Kivity <avi@redhat.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Attilio Rao <attilio.rao@citrix.com>, Linus Torvalds <torvalds@linux-foundation.org>, Xen Devel <xen-devel@lists.xensource.com>, Stephan Diestelhorst <stephan.diestelhorst@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>

Signed-off-by: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
---
 arch/x86/xen/spinlock.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)
diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index 0e4d057..5dce49d 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -223,12 +223,26 @@ void xen_uninit_lock_cpu(int cpu)
 	unbind_from_irqhandler(per_cpu(lock_kicker_irq, cpu), NULL);
 }
 
+static bool xen_pvspin __initdata = true;
+
 void __init xen_init_spinlocks(void)
 {
+	if (!xen_pvspin) {
+		printk(KERN_DEBUG "xen: PV spinlocks disabled\n");
+		return;
+	}
+
 	pv_lock_ops.lock_spinning = xen_lock_spinning;
 	pv_lock_ops.unlock_kick = xen_unlock_kick;
 }
 
+static __init int xen_parse_nopvspin(char *arg)
+{
+	xen_pvspin = false;
+	return 0;
+}
+early_param("xen_nopvspin", xen_parse_nopvspin);
+
 #ifdef CONFIG_XEN_DEBUG_FS
 
 static struct dentry *d_spin_debug;
