From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [PATCH v9 21/84] KVM: x86: vmx: use a symbolic constant when checking the exit qualifications
Date: Wed, 22 Jul 2020 00:08:19 +0300
Message-ID: <20200721210922.7646-22-alazar@bitdefender.com>
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

This should make the code more readable.

Signed-off-by: Mihai Donțu <mdontu@bitdefender.com>
Signed-off-by: Adalbert Lazăr <alazar@bitdefender.com>
---
 arch/x86/kvm/vmx/vmx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index fed661eb65a7..cd498ece8b52 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5361,8 +5361,8 @@ static int handle_ept_violation(struct kvm_vcpu *vcpu)
 			EPT_VIOLATION_EXECUTABLE))
 		      ? PFERR_PRESENT_MASK : 0;
 
-	error_code |= (exit_qualification & 0x100) != 0 ?
-	       PFERR_GUEST_FINAL_MASK : PFERR_GUEST_PAGE_MASK;
+	error_code |= (exit_qualification & EPT_VIOLATION_GVA_TRANSLATED)
+		      ? PFERR_GUEST_FINAL_MASK : PFERR_GUEST_PAGE_MASK;
 
 	vcpu->arch.exit_qualification = exit_qualification;
 	return kvm_mmu_page_fault(vcpu, gpa, error_code, NULL, 0);
