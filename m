From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: [PATCH V12 2/5] kvm hypervisor : Add a hypercall to KVM hypervisor to
	support pv-ticketlocks
Date: Tue, 06 Aug 2013 23:52:42 +0530
Message-ID: <20130806182242.2386.11175.sendpatchset__30473.1005606756$1375813053$gmane$org@codeblue.in.ibm.com>
References: <20130806182150.2386.95104.sendpatchset@codeblue.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130806182150.2386.95104.sendpatchset@codeblue.in.ibm.com>
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
Cc: habanero@linux.vnet.ibm.com, riel@redhat.com, andi@firstfloor.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, peterz@infradead.org, linux-kernel@vger.kernel.org, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, drjones@redhat.com, ouyang@cs.pitt.edu, srivatsa.vaddagiri@gmail.com, chegu_vinod@hp.com, avi.kivity@gmail.com, tglx@linutronix.de, virtualization@lists.linux-foundation.org, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

kvm hypervisor : Add a hypercall to KVM hypervisor to support pv-ticketlocks

From: Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>

kvm_hc_kick_cpu allows the calling vcpu to kick another vcpu out of halt state.
the presence of these hypercalls is indicated to guest via
kvm_feature_pv_unhalt.

Signed-off-by: Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
Signed-off-by: Suzuki Poulose <suzuki@in.ibm.com>
[Raghu: Apic related changes, folding pvunhalted into vcpu_runnable
 Added flags for future use (suggested by Gleb)]
Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Acked-by: Gleb Natapov <gleb@redhat.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/kvm_host.h |    5 +++++
 arch/x86/kvm/cpuid.c            |    3 ++-
 arch/x86/kvm/x86.c              |   37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index f87f7fc..1d1f711 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -511,6 +511,11 @@ struct kvm_vcpu_arch {
 	 * instruction.
 	 */
 	bool write_fault_to_shadow_pgtable;
+
+	/* pv related host specific info */
+	struct {
+		bool pv_unhalted;
+	} pv;
 };
 
 struct kvm_lpage_info {
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index a20ecb5..b110fe6 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -413,7 +413,8 @@ static int do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 			     (1 << KVM_FEATURE_CLOCKSOURCE2) |
 			     (1 << KVM_FEATURE_ASYNC_PF) |
 			     (1 << KVM_FEATURE_PV_EOI) |
-			     (1 << KVM_FEATURE_CLOCKSOURCE_STABLE_BIT);
+			     (1 << KVM_FEATURE_CLOCKSOURCE_STABLE_BIT) |
+			     (1 << KVM_FEATURE_PV_UNHALT);
 
 		if (sched_info_on())
 			entry->eax |= (1 << KVM_FEATURE_STEAL_TIME);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d21bce5..dae4575 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5495,6 +5495,36 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
+/*
+ * kvm_pv_kick_cpu_op:  Kick a vcpu.
+ *
+ * @apicid - apicid of vcpu to be kicked.
+ */
+static void kvm_pv_kick_cpu_op(struct kvm *kvm, unsigned long flags, int apicid)
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
@@ -5528,6 +5558,10 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
 	case KVM_HC_VAPIC_POLL_IRQ:
 		ret = 0;
 		break;
+	case KVM_HC_KICK_CPU:
+		kvm_pv_kick_cpu_op(vcpu->kvm, a0, a1);
+		ret = 0;
+		break;
 	default:
 		ret = -KVM_ENOSYS;
 		break;
@@ -5950,6 +5984,7 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
 				kvm_apic_accept_events(vcpu);
 				switch(vcpu->arch.mp_state) {
 				case KVM_MP_STATE_HALTED:
+					vcpu->arch.pv.pv_unhalted = false;
 					vcpu->arch.mp_state =
 						KVM_MP_STATE_RUNNABLE;
 				case KVM_MP_STATE_RUNNABLE:
@@ -6770,6 +6805,7 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 	BUG_ON(vcpu->kvm == NULL);
 	kvm = vcpu->kvm;
 
+	vcpu->arch.pv.pv_unhalted = false;
 	vcpu->arch.emulate_ctxt.ops = &emulate_ops;
 	if (!irqchip_in_kernel(kvm) || kvm_vcpu_is_bsp(vcpu))
 		vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
@@ -7103,6 +7139,7 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu)
 		!vcpu->arch.apf.halted)
 		|| !list_empty_careful(&vcpu->async_pf.done)
 		|| kvm_apic_has_events(vcpu)
+		|| vcpu->arch.pv.pv_unhalted
 		|| atomic_read(&vcpu->arch.nmi_queued) ||
 		(kvm_arch_interrupt_allowed(vcpu) &&
 		 kvm_cpu_has_interrupt(vcpu));
