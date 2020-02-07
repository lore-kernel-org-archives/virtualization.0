From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [RFC PATCH v7 34/78] KVM: x86: intercept the write access on sidt and other emulated instructions
Date: Fri,  7 Feb 2020 20:15:52 +0200
Message-ID: <20200207181636.1065-35-alazar@bitdefender.com>
References: <20200207181636.1065-1-alazar@bitdefender.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200207181636.1065-1-alazar@bitdefender.com>
Sender: kvm-owner@vger.kernel.org
To: kvm@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <sean.j.christopherson@intel.com>, =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

This is needed for the introspection subsystem to track the changes to
descriptor table registers.

Signed-off-by: Adalbert Lazăr <alazar@bitdefender.com>
---
 arch/x86/kvm/x86.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8c6a8d03e41a..6e665341cc80 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5450,11 +5450,14 @@ static int kvm_write_guest_virt_helper(gva_t addr, void *val, unsigned int bytes
 
 		if (gpa == UNMAPPED_GVA)
 			return X86EMUL_PROPAGATE_FAULT;
+		if (!kvm_page_track_prewrite(vcpu, gpa, addr, data, towrite))
+			return X86EMUL_RETRY_INSTR;
 		ret = kvm_vcpu_write_guest(vcpu, gpa, data, towrite);
 		if (ret < 0) {
 			r = X86EMUL_IO_NEEDED;
 			goto out;
 		}
+		kvm_page_track_write(vcpu, gpa, addr, data, towrite);
 
 		bytes -= towrite;
 		data += towrite;
