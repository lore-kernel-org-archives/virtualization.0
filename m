From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 51/62] x86/sev-es: Handle #AC Events
Date: Tue, 11 Feb 2020 14:52:45 +0100
Message-ID: <20200211135256.24617-52-joro@8bytes.org>
References: <20200211135256.24617-1-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200211135256.24617-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org
Cc: hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

From: Joerg Roedel <jroedel@suse.de>

Implement a handler for #VC exceptions caused by #AC exceptions. The #AC
exception is just forwarded to do_alignment_check() and not pushed down
to the hypervisor, as requested by the SEV-ES GHCB Standardization
Specification.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/sev-es.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 6bd2cae7eb9c..1b873d00e38f 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -375,6 +375,10 @@ static enum es_result handle_vc_exception(struct es_em_ctxt *ctxt,
 	case SVM_EXIT_WRITE_DR7:
 		result = handle_dr7_write(ghcb, ctxt, early);
 		break;
+	case SVM_EXIT_EXCP_BASE + X86_TRAP_AC:
+		do_alignment_check(ctxt->regs, 0);
+		result = ES_RETRY;
+		break;
 	case SVM_EXIT_RDTSC:
 	case SVM_EXIT_RDTSCP:
 		result = handle_rdtsc(ghcb, ctxt, exit_code);
-- 
2.17.1
