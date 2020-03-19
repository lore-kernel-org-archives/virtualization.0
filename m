From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 60/70] x86/sev-es: Handle #DB Events
Date: Thu, 19 Mar 2020 10:13:57 +0100
Message-ID: <20200319091407.1481-61-joro@8bytes.org>
References: <20200319091407.1481-1-joro@8bytes.org>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200319091407.1481-1-joro@8bytes.org>
Sender: kvm-owner@vger.kernel.org
To: x86@kernel.org
Cc: hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

From: Joerg Roedel <jroedel@suse.de>

Handle #VC exceptions caused by #DB exceptions in the guest. Do not
forward them to the hypervisor and handle them with do_debug() instead.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/sev-es.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index f22b361f6b60..bc553aae31d2 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -752,6 +752,15 @@ static enum es_result vc_handle_vmmcall(struct ghcb *ghcb,
 	return ES_OK;
 }
 
+static enum es_result vc_handle_db_exception(struct ghcb *ghcb,
+					     struct es_em_ctxt *ctxt)
+{
+	do_debug(ctxt->regs, 0);
+
+	/* Exception event, do not advance RIP */
+	return ES_RETRY;
+}
+
 static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
 					 struct ghcb *ghcb,
 					 unsigned long exit_code,
@@ -766,6 +775,9 @@ static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
 	case SVM_EXIT_WRITE_DR7:
 		result = vc_handle_dr7_write(ghcb, ctxt, early);
 		break;
+	case SVM_EXIT_EXCP_BASE + X86_TRAP_DB:
+		result = vc_handle_db_exception(ghcb, ctxt);
+		break;
 	case SVM_EXIT_EXCP_BASE + X86_TRAP_AC:
 		do_alignment_check(ctxt->regs, 0);
 		result = ES_RETRY;
-- 
2.17.1
