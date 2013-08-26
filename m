From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: [PATCH V13 3/4] kvm hypervisor: Simplify kvm_for_each_vcpu with
	kvm_irq_delivery_to_apic
Date: Mon, 26 Aug 2013 14:18:35 +0530
Message-ID: <1377506916-26946-4-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
References: <y>
	<1377506916-26946-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1377506916-26946-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mingo@redhat.com, hpa@zytor.com, x86@kernel.org, gleb@redhat.com, pbonzini@redhat.com
Cc: habanero@linux.vnet.ibm.com, jeremy@goop.org, drjones@redhat.com, kvm@vger.kernel.org, konrad.wilk@oracle.com, peterz@infradead.org, torvalds@linux-foundation.org, linux-doc@vger.kernel.org, ouyang@cs.pitt.edu, linux-kernel@vger.kernel.org, riel@redhat.com, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, andi@firstfloor.org, srivatsa.vaddagiri@gmail.com, tglx@linutronix.de, virtualization@lists.linux-foundation.org, chegu_vinod@hp.com, avi.kivity@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

Note that we are using APIC_DM_REMRD which has reserved usage.
In future if APIC_DM_REMRD usage is standardized, then we should
find some other way or go back to old method.

Suggested-by: Gleb Natapov <gleb@redhat.com>
Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Acked-by: Gleb Natapov <gleb@redhat.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kvm/lapic.c |  5 ++++-
 arch/x86/kvm/x86.c   | 25 ++++++-------------------
 2 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index afc1124..48c13c9 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -706,7 +706,10 @@ out:
 		break;
 
 	case APIC_DM_REMRD:
-		apic_debug("Ignoring delivery mode 3\n");
+		result = 1;
+		vcpu->arch.pv.pv_unhalted = 1;
+		kvm_make_request(KVM_REQ_EVENT, vcpu);
+		kvm_vcpu_kick(vcpu);
 		break;
 
 	case APIC_DM_SMI:
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1e73dab..640d112 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5502,27 +5502,14 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
  */
 static void kvm_pv_kick_cpu_op(struct kvm *kvm, unsigned long flags, int apicid)
 {
-	struct kvm_vcpu *vcpu = NULL;
-	int i;
+	struct kvm_lapic_irq lapic_irq;
 
-	kvm_for_each_vcpu(i, vcpu, kvm) {
-		if (!kvm_apic_present(vcpu))
-			continue;
+	lapic_irq.shorthand = 0;
+	lapic_irq.dest_mode = 0;
+	lapic_irq.dest_id = apicid;
 
-		if (kvm_apic_match_dest(vcpu, 0, 0, apicid, 0))
-			break;
-	}
-	if (vcpu) {
-		/*
-		 * Setting unhalt flag here can result in spurious runnable
-		 * state when unhalt reset does not happen in vcpu_block.
-		 * But that is harmless since that should soon result in halt.
-		 */
-		vcpu->arch.pv.pv_unhalted = true;
-		/* We need everybody see unhalt before vcpu unblocks */
-		smp_wmb();
-		kvm_vcpu_kick(vcpu);
-	}
+	lapic_irq.delivery_mode = APIC_DM_REMRD;
+	kvm_irq_delivery_to_apic(kvm, 0, &lapic_irq, NULL);
 }
 
 int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
-- 
1.7.11.7
