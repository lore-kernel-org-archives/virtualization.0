From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [RFC PATCH v1 29/34] KVM: vmx: make use of EPTP_INDEX in vmx_handle_exit()
Date: Wed, 22 Jul 2020 19:01:16 +0300
Message-ID: <20200722160121.9601-30-alazar@bitdefender.com>
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

If the guest has EPTP switching capabilities with VMFUNC, read the
current view from VMCS instead of walking through the EPTP list when #VE
support is active.

Signed-off-by: Ștefan Șicleru <ssicleru@bitdefender.com>
Signed-off-by: Adalbert Lazăr <alazar@bitdefender.com>
---
 arch/x86/kvm/vmx/vmx.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 96aa4b7e2857..035f6c43a2a4 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6269,15 +6269,21 @@ void dump_vmcs(void)
 
 static unsigned int update_ept_view(struct vcpu_vmx *vmx)
 {
-	u64 *eptp_list = phys_to_virt(page_to_phys(vmx->eptp_list_pg));
-	u64 eptp = vmcs_read64(EPT_POINTER);
-	unsigned int view;
+	/* if #VE support is active, read the EPT index from VMCS */
+	if (kvm_ve_supported &&
+	    secondary_exec_controls_get(vmx) & SECONDARY_EXEC_EPT_VE) {
+		vmx->view = vmcs_read16(EPTP_INDEX);
+	} else {
+		u64 *eptp_list = phys_to_virt(page_to_phys(vmx->eptp_list_pg));
+		u64 eptp = vmcs_read64(EPT_POINTER);
+		unsigned int view;
 
-	for (view = 0; view < KVM_MAX_EPT_VIEWS; view++)
-		if (eptp_list[view] == eptp) {
-			vmx->view = view;
-			break;
-		}
+		for (view = 0; view < KVM_MAX_EPT_VIEWS; view++)
+			if (eptp_list[view] == eptp) {
+				vmx->view = view;
+				break;
+			}
+	}
 
 	return vmx->view;
 }
