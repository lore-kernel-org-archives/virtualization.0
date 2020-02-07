From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [RFC PATCH v7 28/78] KVM: x86: export kvm_inject_pending_exception()
Date: Fri,  7 Feb 2020 20:15:46 +0200
Message-ID: <20200207181636.1065-29-alazar@bitdefender.com>
References: <20200207181636.1065-1-alazar@bitdefender.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200207181636.1065-1-alazar@bitdefender.com>
Sender: kvm-owner@vger.kernel.org
To: kvm@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <sean.j.christopherson@intel.com>, =?UTF-8?q?Nicu=C8=99or=20C=C3=AE=C8=9Bu?= <ncitu@bitdefender.com>, =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Nicușor Cîțu <ncitu@bitdefender.com>

This function is needed for the KVMI_VCPU_INJECT_EXCEPTION command.

Signed-off-by: Nicușor Cîțu <ncitu@bitdefender.com>
Signed-off-by: Adalbert Lazăr <alazar@bitdefender.com>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/x86.c              | 71 ++++++++++++++++++---------------
 2 files changed, 39 insertions(+), 33 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index d216ed1a7c7d..77de935979b2 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1438,6 +1438,7 @@ unsigned long kvm_get_rflags(struct kvm_vcpu *vcpu);
 void kvm_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags);
 bool kvm_rdpmc(struct kvm_vcpu *vcpu);
 
+void kvm_inject_pending_exception(struct kvm_vcpu *vcpu);
 void kvm_queue_exception(struct kvm_vcpu *vcpu, unsigned nr);
 void kvm_queue_exception_e(struct kvm_vcpu *vcpu, unsigned nr, u32 error_code);
 void kvm_requeue_exception(struct kvm_vcpu *vcpu, unsigned nr);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 5e6327363207..64b4b6dde347 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7523,6 +7523,43 @@ static void update_cr8_intercept(struct kvm_vcpu *vcpu)
 	kvm_x86_ops->update_cr8_intercept(vcpu, tpr, max_irr);
 }
 
+void kvm_inject_pending_exception(struct kvm_vcpu *vcpu)
+{
+	if (vcpu->arch.exception.pending) {
+		trace_kvm_inj_exception(vcpu->arch.exception.nr,
+					vcpu->arch.exception.has_error_code,
+					vcpu->arch.exception.error_code);
+
+		WARN_ON_ONCE(vcpu->arch.exception.injected);
+		vcpu->arch.exception.pending = false;
+		vcpu->arch.exception.injected = true;
+
+		if (exception_type(vcpu->arch.exception.nr) == EXCPT_FAULT)
+			__kvm_set_rflags(vcpu, kvm_get_rflags(vcpu) |
+					     X86_EFLAGS_RF);
+
+		if (vcpu->arch.exception.nr == DB_VECTOR) {
+			/*
+			 * This code assumes that nSVM doesn't use
+			 * check_nested_events(). If it does, the
+			 * DR6/DR7 changes should happen before L1
+			 * gets a #VMEXIT for an intercepted #DB in
+			 * L2.  (Under VMX, on the other hand, the
+			 * DR6/DR7 changes should not happen in the
+			 * event of a VM-exit to L1 for an intercepted
+			 * #DB in L2.)
+			 */
+			kvm_deliver_exception_payload(vcpu);
+			if (vcpu->arch.dr7 & DR7_GD) {
+				vcpu->arch.dr7 &= ~DR7_GD;
+				kvm_update_dr7(vcpu);
+			}
+		}
+
+		kvm_x86_ops->queue_exception(vcpu);
+	}
+}
+
 static int inject_pending_event(struct kvm_vcpu *vcpu, bool req_int_win)
 {
 	int r;
@@ -7565,39 +7602,7 @@ static int inject_pending_event(struct kvm_vcpu *vcpu, bool req_int_win)
 	}
 
 	/* try to inject new event if pending */
-	if (vcpu->arch.exception.pending) {
-		trace_kvm_inj_exception(vcpu->arch.exception.nr,
-					vcpu->arch.exception.has_error_code,
-					vcpu->arch.exception.error_code);
-
-		WARN_ON_ONCE(vcpu->arch.exception.injected);
-		vcpu->arch.exception.pending = false;
-		vcpu->arch.exception.injected = true;
-
-		if (exception_type(vcpu->arch.exception.nr) == EXCPT_FAULT)
-			__kvm_set_rflags(vcpu, kvm_get_rflags(vcpu) |
-					     X86_EFLAGS_RF);
-
-		if (vcpu->arch.exception.nr == DB_VECTOR) {
-			/*
-			 * This code assumes that nSVM doesn't use
-			 * check_nested_events(). If it does, the
-			 * DR6/DR7 changes should happen before L1
-			 * gets a #VMEXIT for an intercepted #DB in
-			 * L2.  (Under VMX, on the other hand, the
-			 * DR6/DR7 changes should not happen in the
-			 * event of a VM-exit to L1 for an intercepted
-			 * #DB in L2.)
-			 */
-			kvm_deliver_exception_payload(vcpu);
-			if (vcpu->arch.dr7 & DR7_GD) {
-				vcpu->arch.dr7 &= ~DR7_GD;
-				kvm_update_dr7(vcpu);
-			}
-		}
-
-		kvm_x86_ops->queue_exception(vcpu);
-	}
+	kvm_inject_pending_exception(vcpu);
 
 	/* Don't consider new event if we re-injected an event */
 	if (kvm_event_needs_reinjection(vcpu))
