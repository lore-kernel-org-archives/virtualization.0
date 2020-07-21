From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [PATCH v9 08/84] KVM: x86: avoid injecting #PF when emulate the VMCALL instruction
Date: Wed, 22 Jul 2020 00:08:06 +0300
Message-ID: <20200721210922.7646-9-alazar@bitdefender.com>
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

It can happened to end up emulating the VMCALL instruction as a result
of the handling of an EPT write fault. In this situation,
the emulator will try to unconditionally patch the correct hypercall
opcode bytes using emulator_write_emulated(). However, this last call
uses the fault GPA (if available) or walks the guest page tables at RIP,
otherwise. The trouble begins when using VM introspection,
when we forbid the use of the fault GPA and fallback to the guest pt walk:
in Windows (8.1 and newer) the page that we try to write into
is marked read-execute and as such emulator_write_emulated() fails
and we inject a write #PF, leading to a guest crash.

Signed-off-by: Mihai Donțu <mdontu@bitdefender.com>
Signed-off-by: Adalbert Lazăr <alazar@bitdefender.com>
---
 arch/x86/kvm/x86.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e973ffe04d54..23bce3ef26d8 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7714,11 +7714,15 @@ static int emulator_fix_hypercall(struct x86_emulate_ctxt *ctxt)
 	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
 	char instruction[3];
 	unsigned long rip = kvm_rip_read(vcpu);
+	int err;
 
 	kvm_x86_ops.patch_hypercall(vcpu, instruction);
 
-	return emulator_write_emulated(ctxt, rip, instruction, 3,
+	err = emulator_write_emulated(ctxt, rip, instruction, 3,
 		&ctxt->exception);
+	if (err == X86EMUL_PROPAGATE_FAULT)
+		err = X86EMUL_CONTINUE;
+	return err;
 }
 
 static int dm_request_for_irq_injection(struct kvm_vcpu *vcpu)
