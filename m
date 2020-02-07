From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [RFC PATCH v7 07/78] KVM: x86: add kvm_arch_vcpu_get_regs() and kvm_arch_vcpu_get_sregs()
Date: Fri,  7 Feb 2020 20:15:25 +0200
Message-ID: <20200207181636.1065-8-alazar@bitdefender.com>
References: <20200207181636.1065-1-alazar@bitdefender.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200207181636.1065-1-alazar@bitdefender.com>
Sender: kvm-owner@vger.kernel.org
To: kvm@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <sean.j.christopherson@intel.com>, =?UTF-8?q?Mihai=20Don=C8=9Bu?= <mdontu@bitdefender.com>, =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Mihai Donțu <mdontu@bitdefender.com>

These functions are needed for VM introspection (get registers commands
and all events sending the vCPU registers to the introspection tool).

Signed-off-by: Mihai Donțu <mdontu@bitdefender.com>
Signed-off-by: Adalbert Lazăr <alazar@bitdefender.com>
---
 arch/x86/kvm/x86.c       | 10 ++++++++++
 include/linux/kvm_host.h |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index cf917139de6b..ff0c12a9322d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8615,6 +8615,11 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	return 0;
 }
 
+void kvm_arch_vcpu_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
+{
+	__get_regs(vcpu, regs);
+}
+
 static void __set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
 	vcpu->arch.emulate_regs_need_sync_from_vcpu = true;
@@ -8710,6 +8715,11 @@ int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+void kvm_arch_vcpu_get_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
+{
+	__get_sregs(vcpu, sregs);
+}
+
 int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 				    struct kvm_mp_state *mp_state)
 {
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index e826e874b998..62f5bf82adc0 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -853,9 +853,12 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 				    struct kvm_translation *tr);
 
 int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs);
+void kvm_arch_vcpu_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs);
 int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs);
 int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 				  struct kvm_sregs *sregs);
+void kvm_arch_vcpu_get_sregs(struct kvm_vcpu *vcpu,
+				  struct kvm_sregs *sregs);
 int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 				  struct kvm_sregs *sregs);
 int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
