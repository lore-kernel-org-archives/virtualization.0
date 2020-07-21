From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [PATCH v9 84/84] KVM: x86: call the page tracking code on emulation failure
Date: Wed, 22 Jul 2020 00:09:22 +0300
Message-ID: <20200721210922.7646-85-alazar@bitdefender.com>
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

The information we can provide this way is incomplete, but current users
of the page tracking code can work with it.

Signed-off-by: Mihai Donțu <mdontu@bitdefender.com>
Signed-off-by: Adalbert Lazăr <alazar@bitdefender.com>
---
 arch/x86/kvm/x86.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 02b74a57ca01..feb20b29bb92 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6911,6 +6911,51 @@ static bool is_vmware_backdoor_opcode(struct x86_emulate_ctxt *ctxt)
 	return false;
 }
 
+/*
+ * With introspection enabled, emulation failures translate in events being
+ * missed because the read/write callbacks are not invoked. All we have is
+ * the fetch event (kvm_page_track_preexec). Below we use the EPT/NPT VMEXIT
+ * information to generate the events, but without providing accurate
+ * data and size (the emulator would have computed those). If an instruction
+ * would happen to read and write in the same page, the second event will
+ * initially be missed and we rely on the page tracking mechanism to bring
+ * us back here to send it.
+ */
+static bool kvm_page_track_emulation_failure(struct kvm_vcpu *vcpu, gpa_t gpa)
+{
+	u64 error_code = vcpu->arch.error_code;
+	u8 data = 0;
+	gva_t gva;
+	bool ret;
+
+	/* MMIO emulation failures should be treated the normal way */
+	if (unlikely(error_code & PFERR_RSVD_MASK))
+		return true;
+
+	/* EPT/NTP must be enabled */
+	if (unlikely(!vcpu->arch.mmu->direct_map))
+		return true;
+
+	/*
+	 * The A/D bit emulation should make this test unneeded, but just
+	 * in case
+	 */
+	if (unlikely((error_code & PFERR_NESTED_GUEST_PAGE) ==
+		     PFERR_NESTED_GUEST_PAGE))
+		return true;
+
+	gva = kvm_x86_ops.fault_gla(vcpu);
+
+	if (error_code & PFERR_WRITE_MASK)
+		ret = kvm_page_track_prewrite(vcpu, gpa, gva, &data, 0);
+	else if (error_code & PFERR_USER_MASK)
+		ret = kvm_page_track_preread(vcpu, gpa, gva, 0);
+	else
+		ret = true;
+
+	return ret;
+}
+
 int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 			    int emulation_type, void *insn, int insn_len)
 {
@@ -6960,6 +7005,8 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 				kvm_queue_exception(vcpu, UD_VECTOR);
 				return 1;
 			}
+			if (!kvm_page_track_emulation_failure(vcpu, cr2_or_gpa))
+				return 1;
 			if (reexecute_instruction(vcpu, cr2_or_gpa,
 						  write_fault_to_spt,
 						  emulation_type))
@@ -7029,6 +7076,8 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 		return 1;
 
 	if (r == EMULATION_FAILED) {
+		if (!kvm_page_track_emulation_failure(vcpu, cr2_or_gpa))
+			return 1;
 		if (reexecute_instruction(vcpu, cr2_or_gpa, write_fault_to_spt,
 					emulation_type))
 			return 1;
