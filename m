From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: [PATCH RFC V11 6/18] xen/pvticketlocks: Add xen_nopvspin parameter to
	disable xen pv ticketlocks
Date: Mon, 22 Jul 2013 11:47:59 +0530
Message-ID: <20130722061759.24737.84656.sendpatchset@codeblue>
References: <20130722061631.24737.75508.sendpatchset@codeblue>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130722061631.24737.75508.sendpatchset@codeblue>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: gleb@redhat.com, mingo@redhat.com, jeremy@goop.org, x86@kernel.org, konrad.wilk@oracle.com, hpa@zytor.com, pbonzini@redhat.com
Cc: gregkh@suse.de, kvm@vger.kernel.org, linux-doc@vger.kernel.org, peterz@infradead.org, drjones@redhat.com, virtualization@lists.linux-foundation.org, andi@firstfloor.org, xen-devel@lists.xensource.com, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, habanero@linux.vnet.ibm.com, riel@redhat.com, stefano.stabellini@eu.citrix.com, ouyang@cs.pitt.edu, avi.kivity@gmail.com, tglx@linutronix.de, chegu_vinod@hp.com, linux-kernel@vger.kernel.org, srivatsa.vaddagiri@gmail.com, attilio.rao@citrix.com, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

xen/pvticketlocks: Add xen_nopvspin parameter to disable xen pv ticketlocks

From: Jeremy Fitzhardinge <jeremy@goop.org>

Signed-off-by: Jeremy Fitzhardinge <jeremy@goop.org>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
---
 arch/x86/xen/spinlock.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index 31949da..ec9183b 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -244,6 +244,8 @@ void xen_uninit_lock_cpu(int cpu)
 	per_cpu(irq_name, cpu) = NULL;
 }
 
+static bool xen_pvspin __initdata = true;
+
 void __init xen_init_spinlocks(void)
 {
 	/*
@@ -253,10 +255,22 @@ void __init xen_init_spinlocks(void)
 	if (xen_hvm_domain())
 		return;
 
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
