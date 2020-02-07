From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [RFC PATCH v7 35/78] KVM: x86: disable gpa_available optimization for fetch and page-walk NPF/EPT violations
Date: Fri,  7 Feb 2020 20:15:53 +0200
Message-ID: <20200207181636.1065-36-alazar@bitdefender.com>
References: <20200207181636.1065-1-alazar@bitdefender.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200207181636.1065-1-alazar@bitdefender.com>
Sender: kvm-owner@vger.kernel.org
To: kvm@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <sean.j.christopherson@intel.com>, =?UTF-8?q?Mircea=20C=C3=AErjaliu?= <mcirjaliu@bitdefender.com>, =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Mircea Cîrjaliu <mcirjaliu@bitdefender.com>

This change is needed because the introspection tool can write-protect
guest page tables, exec-protect heap/stack pages and let KVM emulate
the instruction that caused these violations.

Signed-off-by: Mircea Cîrjaliu <mcirjaliu@bitdefender.com>
Signed-off-by: Adalbert Lazăr <alazar@bitdefender.com>
---
 arch/x86/kvm/mmu/mmu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 5f0ddc6b67de..d28b7425c4f1 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5636,8 +5636,13 @@ int kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gva_t cr2, u64 error_code,
 	int r, emulation_type = 0;
 	bool direct = vcpu->arch.mmu->direct_map;
 
-	/* With shadow page tables, fault_address contains a GVA or nGPA.  */
-	if (vcpu->arch.mmu->direct_map) {
+	/*
+	 * With shadow page tables, fault_address contains a GVA or nGPA.
+	 * On a fetch fault, fault_address contains the instruction pointer.
+	 */
+	if (vcpu->arch.mmu->direct_map &&
+	    likely(!(error_code & PFERR_FETCH_MASK)) &&
+	    (error_code & PFERR_GUEST_FINAL_MASK)) {
 		vcpu->arch.gpa_available = true;
 		vcpu->arch.gpa_val = cr2;
 	}
