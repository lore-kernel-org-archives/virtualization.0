From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: [PATCH RFC V8 13/17] kvm hypervisor : Add a hypercall to KVM
	hypervisor to support pv-ticketlocks
Date: Wed, 02 May 2012 15:38:56 +0530
Message-ID: <20120502100856.13206.88245.sendpatchset@codeblue.in.ibm.com>
References: <20120502100610.13206.40.sendpatchset@codeblue.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120502100610.13206.40.sendpatchset@codeblue.in.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>, Greg Kroah-Hartman <gregkh@suse.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "H. Peter Anvin" <hpa@zytor.com>, Avi Kivity <avi@redhat.com>, X86 <x86@kernel.org>, Gleb Natapov <gleb@redhat.com>, Ingo Molnar <mingo@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xen Devel <xen-devel@lists.xensource.com>, KVM <kvm@vger.kernel.org>, linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Virtualization <virtualization@lists.linux-foundation.org>, Andi Kleen <andi@firstfloor.org>, Stephan Diestelhorst <stephan.diestelhorst@amd.com>, Attilio Rao <attilio.rao@citrix.com>, Linus Torvalds <torvalds@linux-foundation.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>
List-Id: virtualization@lists.linuxfoundation.org

From: srivatsa vaddagiri <vatsa@linux.vnet.ibm.com>

kvm_hc_kick_cpu allows the calling vcpu to kick another vcpu out of halt state.
    
the presence of these hypercalls is indicated to guest via
kvm_feature_pv_unhalt.

Signed-off-by: Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
Signed-off-by: Suzuki Poulose <suzuki@in.ibm.com>
Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
---
 arch/x86/include/asm/kvm_host.h |    4 ++++
 arch/x86/include/asm/kvm_para.h |    2 ++
 arch/x86/kvm/cpuid.c            |    3 ++-
 arch/x86/kvm/x86.c              |   37 +++++++++++++++++++++++++++++++++++++
 include/linux/kvm_para.h        |    1 +
 5 files changed, 46 insertions(+), 1 deletions(-)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index e216ba0..e187a9b 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -481,6 +481,10 @@ struct kvm_vcpu_arch {
 		u64 length;
 		u64 status;
 	} osvw;
+	/* pv related host specific info */
+	struct {
+		bool pv_unhalted;
+	} pv;
 };
 
 struct kvm_lpage_info {
diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
index 734c376..5b647ea 100644
--- a/arch/x86/include/asm/kvm_para.h
+++ b/arch/x86/include/asm/kvm_para.h
@@ -16,12 +16,14 @@
 #define KVM_FEATURE_CLOCKSOURCE		0
 #define KVM_FEATURE_NOP_IO_DELAY	1
 #define KVM_FEATURE_MMU_OP		2
+
 /* This indicates that the new set of kvmclock msrs
  * are available. The use of 0x11 and 0x12 is deprecated
  */
 #define KVM_FEATURE_CLOCKSOURCE2        3
 #define KVM_FEATURE_ASYNC_PF		4
 #define KVM_FEATURE_STEAL_TIME		5
+#define KVM_FEATURE_PV_UNHALT		6
 
 /* The last 8 bits are used to indicate how to interpret the flags field
  * in pvclock structure. If no bits are set, all flags are ignored.
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 9fed5be..7c93806 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -408,7 +408,8 @@ static int do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 			     (1 << KVM_FEATURE_NOP_IO_DELAY) |
 			     (1 << KVM_FEATURE_CLOCKSOURCE2) |
 			     (1 << KVM_FEATURE_ASYNC_PF) |
-			     (1 << KVM_FEATURE_CLOCKSOURCE_STABLE_BIT);
+			     (1 << KVM_FEATURE_CLOCKSOURCE_STABLE_BIT) |
+			     (1 << KVM_FEATURE_PV_UNHALT);
 
 		if (sched_info_on())
 			entry->eax |= (1 << KVM_FEATURE_STEAL_TIME);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 91a5e98..f188cdc 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4993,6 +4993,36 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
+/*
+ * kvm_pv_kick_cpu_op:  Kick a vcpu.
+ *
+ * @apicid - apicid of vcpu to be kicked.
+ */
+static void kvm_pv_kick_cpu_op(struct kvm *kvm, int apicid)
+{
+	struct kvm_vcpu *vcpu = NULL;
+	int i;
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		if (!kvm_apic_present(vcpu))
+			continue;
+
+		if (kvm_apic_match_dest(vcpu, 0, 0, apicid, 0))
+			break;
+	}
+	if (vcpu) {
+		/*
+		 * Setting unhalt flag here can result in spurious runnable
+		 * state when unhalt reset does not happen in vcpu_block.
+		 * But that is harmless since that should soon result in halt.
+		 */
+		vcpu->arch.pv.pv_unhalted = true;
+		/* We need everybody see unhalt before vcpu unblocks */
+		smp_wmb();
+		kvm_vcpu_kick(vcpu);
+	}
+}
+
 int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
 {
 	unsigned long nr, a0, a1, a2, a3, ret;
@@ -5026,6 +5056,10 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
 	case KVM_HC_VAPIC_POLL_IRQ:
 		ret = 0;
 		break;
+	case KVM_HC_KICK_CPU:
+		kvm_pv_kick_cpu_op(vcpu->kvm, a0);
+		ret = 0;
+		break;
 	default:
 		ret = -KVM_ENOSYS;
 		break;
@@ -5409,6 +5443,7 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
 			{
 				switch(vcpu->arch.mp_state) {
 				case KVM_MP_STATE_HALTED:
+					vcpu->arch.pv.pv_unhalted = false;
 					vcpu->arch.mp_state =
 						KVM_MP_STATE_RUNNABLE;
 				case KVM_MP_STATE_RUNNABLE:
@@ -6128,6 +6163,7 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 	BUG_ON(vcpu->kvm == NULL);
 	kvm = vcpu->kvm;
 
+	vcpu->arch.pv.pv_unhalted = false;
 	vcpu->arch.emulate_ctxt.ops = &emulate_ops;
 	if (!irqchip_in_kernel(kvm) || kvm_vcpu_is_bsp(vcpu))
 		vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
@@ -6394,6 +6430,7 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu)
 		!vcpu->arch.apf.halted)
 		|| !list_empty_careful(&vcpu->async_pf.done)
 		|| vcpu->arch.mp_state == KVM_MP_STATE_SIPI_RECEIVED
+		|| vcpu->arch.pv.pv_unhalted
 		|| atomic_read(&vcpu->arch.nmi_queued) ||
 		(kvm_arch_interrupt_allowed(vcpu) &&
 		 kvm_cpu_has_interrupt(vcpu));
diff --git a/include/linux/kvm_para.h b/include/linux/kvm_para.h
index ff476dd..38226e1 100644
--- a/include/linux/kvm_para.h
+++ b/include/linux/kvm_para.h
@@ -19,6 +19,7 @@
 #define KVM_HC_MMU_OP			2
 #define KVM_HC_FEATURES			3
 #define KVM_HC_PPC_MAP_MAGIC_PAGE	4
+#define KVM_HC_KICK_CPU			5
 
 /*
  * hypercalls use architecture specific
