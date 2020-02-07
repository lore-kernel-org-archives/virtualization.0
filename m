From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [RFC PATCH v7 08/78] KVM: x86: add kvm_arch_vcpu_set_regs()
Date: Fri,  7 Feb 2020 20:15:26 +0200
Message-ID: <20200207181636.1065-9-alazar@bitdefender.com>
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

This is needed for the KVMI_VCPU_SET_REGISTERS, but without clearing
the pending exception.

Signed-off-by: Nicușor Cîțu <ncitu@bitdefender.com>
Signed-off-by: Adalbert Lazăr <alazar@bitdefender.com>
---
 arch/x86/kvm/x86.c       | 13 ++++++++++---
 include/linux/kvm_host.h |  2 ++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ff0c12a9322d..d0104adf7906 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8646,8 +8646,15 @@ static void __set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 
 	kvm_rip_write(vcpu, regs->rip);
 	kvm_set_rflags(vcpu, regs->rflags | X86_EFLAGS_FIXED);
+}
 
-	vcpu->arch.exception.pending = false;
+void kvm_arch_vcpu_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs,
+			    bool clear_exception)
+{
+	__set_regs(vcpu, regs);
+
+	if (clear_exception)
+		vcpu->arch.exception.pending = false;
 
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
 }
@@ -8655,7 +8662,7 @@ static void __set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
 	vcpu_load(vcpu);
-	__set_regs(vcpu, regs);
+	kvm_arch_vcpu_set_regs(vcpu, regs, true);
 	vcpu_put(vcpu);
 	return 0;
 }
@@ -9059,7 +9066,7 @@ static int sync_regs(struct kvm_vcpu *vcpu)
 		return -EINVAL;
 
 	if (vcpu->run->kvm_dirty_regs & KVM_SYNC_X86_REGS) {
-		__set_regs(vcpu, &vcpu->run->s.regs.regs);
+		kvm_arch_vcpu_set_regs(vcpu, &vcpu->run->s.regs.regs, true);
 		vcpu->run->kvm_dirty_regs &= ~KVM_SYNC_X86_REGS;
 	}
 	if (vcpu->run->kvm_dirty_regs & KVM_SYNC_X86_SREGS) {
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 62f5bf82adc0..c7ef69015050 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -855,6 +855,8 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs);
 void kvm_arch_vcpu_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs);
 int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs);
+void kvm_arch_vcpu_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs,
+			    bool clear_exception);
 int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 				  struct kvm_sregs *sregs);
 void kvm_arch_vcpu_get_sregs(struct kvm_vcpu *vcpu,
