From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [RFC PATCH v1 24/34] KVM: vmx: trigger vm-exits for mmio sptes by default when #VE is enabled
Date: Wed, 22 Jul 2020 19:01:11 +0300
Message-ID: <20200722160121.9601-25-alazar@bitdefender.com>
References: <20200722160121.9601-1-alazar@bitdefender.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200722160121.9601-1-alazar@bitdefender.com>
Sender: kvm-owner@vger.kernel.org
To: kvm@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?=C8=98tefan=20=C8=98icleru?= <ssicleru@bitdefender.com>, =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Ștefan Șicleru <ssicleru@bitdefender.com>

All sptes, including mmio sptes must have SVE bit set by default, in
order to trigger vm-exits instead of #VEs (in case of an EPT violation).
MMIO sptes were overlooked in commit 28b8bc704111 ("KVM: VMX: Suppress EPT violation #VE by default (when enabled)")
which provided a new mask for non-mmio sptes.

Signed-off-by: Ștefan Șicleru <ssicleru@bitdefender.com>
Signed-off-by: Adalbert Lazăr <alazar@bitdefender.com>
---
 arch/x86/kvm/vmx/vmx.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 3428857c6157..b65bd0d144e5 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4367,11 +4367,19 @@ static void vmx_compute_secondary_exec_control(struct vcpu_vmx *vmx)
 
 static void ept_set_mmio_spte_mask(void)
 {
+	u64 mmio_value = VMX_EPT_MISCONFIG_WX_VALUE;
+
+	/* All sptes, including mmio sptes should trigger vm-exits by
+	 * default, instead of #VE (when supported)
+	 */
+	if (kvm_ve_supported)
+		mmio_value |= VMX_EPT_SUPPRESS_VE_BIT;
+
 	/*
 	 * EPT Misconfigurations can be generated if the value of bits 2:0
 	 * of an EPT paging-structure entry is 110b (write/execute).
 	 */
-	kvm_mmu_set_mmio_spte_mask(VMX_EPT_MISCONFIG_WX_VALUE, 0);
+	kvm_mmu_set_mmio_spte_mask(mmio_value, 0);
 }
 
 static int vmx_alloc_eptp_list_page(struct vcpu_vmx *vmx)
