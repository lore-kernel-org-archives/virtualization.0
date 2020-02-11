From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 47/62] x86/sev-es: Handle RDTSCP Events
Date: Tue, 11 Feb 2020 14:52:41 +0100
Message-ID: <20200211135256.24617-48-joro@8bytes.org>
References: <20200211135256.24617-1-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200211135256.24617-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org
Cc: hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

From: Joerg Roedel <jroedel@suse.de>

Extend the RDTSC handler to also handle RDTSCP events.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/sev-es.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 485f5a14c3b4..d5a14f277adb 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -272,19 +272,24 @@ static enum es_result handle_wbinvd(struct ghcb *ghcb,
 	return ghcb_hv_call(ghcb, ctxt, SVM_EXIT_WBINVD, 0, 0);
 }
 
-static enum es_result handle_rdtsc(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
+static enum es_result handle_rdtsc(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
+				   unsigned long exit_code)
 {
+	bool rdtscp = (exit_code == SVM_EXIT_RDTSCP);
 	enum es_result ret;
 
-	ret = ghcb_hv_call(ghcb, ctxt, SVM_EXIT_RDTSC, 0, 0);
+	ret = ghcb_hv_call(ghcb, ctxt, exit_code, 0, 0);
 	if (ret != ES_OK)
 		return ret;
 
-	if (!(ghcb_is_valid_rax(ghcb) && ghcb_is_valid_rdx(ghcb)))
+	if (!(ghcb_is_valid_rax(ghcb) && ghcb_is_valid_rdx(ghcb) &&
+	     (!rdtscp || ghcb_is_valid_rcx(ghcb))))
 		return ES_VMM_ERROR;
 
 	ctxt->regs->ax = ghcb->save.rax;
 	ctxt->regs->dx = ghcb->save.rdx;
+	if (rdtscp)
+		ctxt->regs->cx = ghcb->save.rcx;
 
 	return ES_OK;
 }
@@ -328,7 +333,8 @@ static enum es_result handle_vc_exception(struct es_em_ctxt *ctxt,
 		result = handle_dr7_write(ghcb, ctxt, early);
 		break;
 	case SVM_EXIT_RDTSC:
-		result = handle_rdtsc(ghcb, ctxt);
+	case SVM_EXIT_RDTSCP:
+		result = handle_rdtsc(ghcb, ctxt, exit_code);
 		break;
 	case SVM_EXIT_RDPMC:
 		result = handle_rdpmc(ghcb, ctxt);
-- 
2.17.1
