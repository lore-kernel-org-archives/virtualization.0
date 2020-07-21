From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [PATCH v9 28/84] KVM: x86: extend kvm_mmu_gva_to_gpa_system() with the 'access' parameter
Date: Wed, 22 Jul 2020 00:08:26 +0300
Message-ID: <20200721210922.7646-29-alazar@bitdefender.com>
References: <20200721210922.7646-1-alazar@bitdefender.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200721210922.7646-1-alazar@bitdefender.com>
Sender: kvm-owner@vger.kernel.org
To: kvm@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Mihai=20Don=C8=9Bu?= <mdontu@bitdefender.com>, =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Mihai Donțu <mdontu@bitdefender.com>

This is needed for kvmi_update_ad_flags() to emulate a guest page
table walk on SPT violations due to A/D bit updates.

Signed-off-by: Mihai Donțu <mdontu@bitdefender.com>
Signed-off-by: Adalbert Lazăr <alazar@bitdefender.com>
---
 arch/x86/include/asm/kvm_host.h | 2 +-
 arch/x86/kvm/x86.c              | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 487d1fa6e76d..e92a12647f4d 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1556,7 +1556,7 @@ gpa_t kvm_mmu_gva_to_gpa_fetch(struct kvm_vcpu *vcpu, gva_t gva,
 gpa_t kvm_mmu_gva_to_gpa_write(struct kvm_vcpu *vcpu, gva_t gva,
 			       struct x86_exception *exception);
 gpa_t kvm_mmu_gva_to_gpa_system(struct kvm_vcpu *vcpu, gva_t gva,
-				struct x86_exception *exception);
+				u32 access, struct x86_exception *exception);
 
 bool kvm_apicv_activated(struct kvm *kvm);
 void kvm_apicv_init(struct kvm *kvm, bool enable);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 5611b6cd6d19..0bfa800d0ca8 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5498,9 +5498,9 @@ gpa_t kvm_mmu_gva_to_gpa_write(struct kvm_vcpu *vcpu, gva_t gva,
 
 /* uses this to access any guest's mapped memory without checking CPL */
 gpa_t kvm_mmu_gva_to_gpa_system(struct kvm_vcpu *vcpu, gva_t gva,
-				struct x86_exception *exception)
+				u32 access, struct x86_exception *exception)
 {
-	return vcpu->arch.walk_mmu->gva_to_gpa(vcpu, gva, 0, exception);
+	return vcpu->arch.walk_mmu->gva_to_gpa(vcpu, gva, access, exception);
 }
 
 static int kvm_read_guest_virt_helper(gva_t addr, void *val, unsigned int bytes,
@@ -9332,7 +9332,7 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 	vcpu_load(vcpu);
 
 	idx = srcu_read_lock(&vcpu->kvm->srcu);
-	gpa = kvm_mmu_gva_to_gpa_system(vcpu, vaddr, NULL);
+	gpa = kvm_mmu_gva_to_gpa_system(vcpu, vaddr, 0, NULL);
 	srcu_read_unlock(&vcpu->kvm->srcu, idx);
 	tr->physical_address = gpa;
 	tr->valid = gpa != UNMAPPED_GVA;
