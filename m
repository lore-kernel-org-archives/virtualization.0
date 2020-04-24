From: Mike Stunes <mstunes@vmware.com>
Subject: [PATCH] Allow RDTSC and RDTSCP from userspace
Date: Fri, 24 Apr 2020 14:03:16 -0700
Message-ID: <20200424210316.848878-1-mstunes@vmware.com>
References: <20200319091407.1481-56-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200319091407.1481-56-joro@8bytes.org>
Sender: kvm-owner@vger.kernel.org
To: joro@8bytes.org
Cc: dan.j.williams@intel.com, dave.hansen@linux.intel.com, hpa@zytor.com, jgross@suse.com, jroedel@suse.de, jslaby@suse.cz, keescook@chromium.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org, thellstrom@vmware.com, thomas.lendacky@amd.com, virtualization@lists.linux-foundation.org, x86@kernel.org, Mike Stunes <mstunes@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi Joerg,

I needed to allow RDTSC(P) from userspace and in early boot in order to
get userspace started properly. Patch below.

---
SEV-ES guests will need to execute rdtsc and rdtscp from userspace and
during early boot. Move the rdtsc(p) #VC handler into common code and
extend the #VC handlers.

Signed-off-by: Mike Stunes <mstunes@vmware.com>
---
 arch/x86/boot/compressed/sev-es.c |  4 ++++
 arch/x86/kernel/sev-es-shared.c   | 23 +++++++++++++++++++++++
 arch/x86/kernel/sev-es.c          | 25 ++-----------------------
 3 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/arch/x86/boot/compressed/sev-es.c b/arch/x86/boot/compressed/sev-es.c
index 53c65fc09341..1d0290cc46c1 100644
--- a/arch/x86/boot/compressed/sev-es.c
+++ b/arch/x86/boot/compressed/sev-es.c
@@ -158,6 +158,10 @@ void boot_vc_handler(struct pt_regs *regs, unsigned long exit_code)
 	case SVM_EXIT_CPUID:
 		result = vc_handle_cpuid(boot_ghcb, &ctxt);
 		break;
+	case SVM_EXIT_RDTSC:
+	case SVM_EXIT_RDTSCP:
+		result = vc_handle_rdtsc(boot_ghcb, &ctxt, exit_code);
+		break;
 	default:
 		result = ES_UNSUPPORTED;
 		break;
diff --git a/arch/x86/kernel/sev-es-shared.c b/arch/x86/kernel/sev-es-shared.c
index a632b8f041ec..373ced468659 100644
--- a/arch/x86/kernel/sev-es-shared.c
+++ b/arch/x86/kernel/sev-es-shared.c
@@ -442,3 +442,26 @@ static enum es_result vc_handle_cpuid(struct ghcb *ghcb,
 
 	return ES_OK;
 }
+
+static enum es_result vc_handle_rdtsc(struct ghcb *ghcb,
+				      struct es_em_ctxt *ctxt,
+				      unsigned long exit_code)
+{
+	bool rdtscp = (exit_code == SVM_EXIT_RDTSCP);
+	enum es_result ret;
+
+	ret = sev_es_ghcb_hv_call(ghcb, ctxt, exit_code, 0, 0);
+	if (ret != ES_OK)
+		return ret;
+
+	if (!(ghcb_is_valid_rax(ghcb) && ghcb_is_valid_rdx(ghcb) &&
+	     (!rdtscp || ghcb_is_valid_rcx(ghcb))))
+		return ES_VMM_ERROR;
+
+	ctxt->regs->ax = ghcb->save.rax;
+	ctxt->regs->dx = ghcb->save.rdx;
+	if (rdtscp)
+		ctxt->regs->cx = ghcb->save.rcx;
+
+	return ES_OK;
+}
diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 409a7a2aa630..82199527d012 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -815,29 +815,6 @@ static enum es_result vc_handle_wbinvd(struct ghcb *ghcb,
 	return sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_WBINVD, 0, 0);
 }
 
-static enum es_result vc_handle_rdtsc(struct ghcb *ghcb,
-				      struct es_em_ctxt *ctxt,
-				      unsigned long exit_code)
-{
-	bool rdtscp = (exit_code == SVM_EXIT_RDTSCP);
-	enum es_result ret;
-
-	ret = sev_es_ghcb_hv_call(ghcb, ctxt, exit_code, 0, 0);
-	if (ret != ES_OK)
-		return ret;
-
-	if (!(ghcb_is_valid_rax(ghcb) && ghcb_is_valid_rdx(ghcb) &&
-	     (!rdtscp || ghcb_is_valid_rcx(ghcb))))
-		return ES_VMM_ERROR;
-
-	ctxt->regs->ax = ghcb->save.rax;
-	ctxt->regs->dx = ghcb->save.rdx;
-	if (rdtscp)
-		ctxt->regs->cx = ghcb->save.rcx;
-
-	return ES_OK;
-}
-
 static enum es_result vc_handle_rdpmc(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 {
 	enum es_result ret;
@@ -1001,6 +978,8 @@ static enum es_result vc_context_filter(struct pt_regs *regs, long exit_code)
 		/* List of #VC exit-codes we support in user-space */
 		case SVM_EXIT_EXCP_BASE ... SVM_EXIT_LAST_EXCP:
 		case SVM_EXIT_CPUID:
+		case SVM_EXIT_RDTSC:
+		case SVM_EXIT_RDTSCP:
 			r = ES_OK;
 			break;
 		default:
-- 
2.26.1
