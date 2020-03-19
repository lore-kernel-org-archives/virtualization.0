From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 57/70] x86/sev-es: Handle MWAIT/MWAITX Events
Date: Thu, 19 Mar 2020 10:13:54 +0100
Message-ID: <20200319091407.1481-58-joro@8bytes.org>
References: <20200319091407.1481-1-joro@8bytes.org>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200319091407.1481-1-joro@8bytes.org>
Sender: kvm-owner@vger.kernel.org
To: x86@kernel.org
Cc: hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

From: Tom Lendacky <thomas.lendacky@amd.com>

Implement a handler for #VC exceptions caused by MWAIT and MWAITX
instructions.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
[ jroedel@suse.de: Adapt to #VC handling infrastructure ]
Co-developed-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/sev-es.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 6bd8bc9f2e66..0ccbcc02e6f2 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -723,6 +723,15 @@ static enum es_result vc_handle_monitor(struct ghcb *ghcb,
 	return sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_MONITOR, 0, 0);
 }
 
+static enum es_result vc_handle_mwait(struct ghcb *ghcb,
+				      struct es_em_ctxt *ctxt)
+{
+	ghcb_set_rax(ghcb, ctxt->regs->ax);
+	ghcb_set_rcx(ghcb, ctxt->regs->cx);
+
+	return sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_MWAIT, 0, 0);
+}
+
 static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
 					 struct ghcb *ghcb,
 					 unsigned long exit_code,
@@ -763,6 +772,9 @@ static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
 	case SVM_EXIT_MONITOR:
 		result = vc_handle_monitor(ghcb, ctxt);
 		break;
+	case SVM_EXIT_MWAIT:
+		result = vc_handle_mwait(ghcb, ctxt);
+		break;
 	case SVM_EXIT_NPF:
 		result = vc_handle_mmio(ghcb, ctxt);
 		break;
-- 
2.17.1
