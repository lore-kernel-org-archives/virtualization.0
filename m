Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793069808;
	b=hEM9wCw3wcQpAouX57r6a2dkEu05nRmjFMcq9dbtPLknLGLakZNPzZaTk1rFwvIRoFKs
	 jceeek9R3J942hiMlzyz6YGeglJvoBHptcLbCbRmy6DC99p7NlYp17lyljxyazv8FgK11
	 WCjIMtBWh/2p6sUb+y/W/7uM6+2Ew5oVh/IqrAL/ZEpjUdmJZnhO/JhSxOuZ2CN9wmxvU
	 +0g+y0sxXfvxLIg1KKZ2vRem5OzMpj77c6kZp5v054/yhoFyWvj17hnVBnFotv+KIUQt5
	 OpwS7hcE92E6q0h+RjzG9MEK473Oa/3OTeyfnSsUvARLje9Zdic9eo2MK3qXGm7sORA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793069808;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=U1tHH5Mqf99jycLltqjXTRn5xKYAyrIr2aHOwRziEw8=;
	b=v0VhwJ8ZIPUhmPGqth2Pi9NFVGsdoQLc1fr8YHtlsaQh80+w/fCc72yJ/+H19/Nb1Lks
	 MYHfvCGlAriN74h4AOTm3twTgs9RceQXswzs/xgFK4J38H4VP19lBnSmnESFjLuH7TCFk
	 9nt2pLq1WxsLjzkbeMz6yYhzmxVSGXYpFrLMum6PEy7rJ96JQ/0urfDHmjhoUT+7B+L8s
	 T5FZEUKV5mom4M3cbcpD/+xD1eMvEhgnlzRpxLle7UdyzNCJGgrJqxT1TsUy+dn2ktKOm
	 Ti9FLepTZuMhawQ/Mhj2zMxZo+hM+dEOo/8TP6wANaNSLdZpeB8iD5HGDDaxYu5E70w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=VoFP301k;
	arc=none smtp.remote-ip=209.85.161.70
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0828E606A31B
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 02:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0828E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=VoFP301k
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-6f56f3638afso4019889eaf.3
        for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 19:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793069807; x=1793674607; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U1tHH5Mqf99jycLltqjXTRn5xKYAyrIr2aHOwRziEw8=;
        b=VoFP301kfSK5sJU1AIpXiN6bjwaVOr48eQ+3N+os/Hrnn1zkOKSEbc9UwfBPcYB4NV
         XJQWhSKQmy79dvsQZuS0jLWfzUiMr88w2HX1ptyriq0t+FcIn5EuHMiTBZ3oepN1sB/S
         zzDwVxvHWAdmBwD3E5+oY4OYhgrXTF2pucZ88HQE0ZNFGYJzgh8gIGcma6UFIqtus13n
         52htBp9Ql/xXGDwzvw225cY/gW67Ao4/uiROqxPSN/iEboX7gfw89g5wEJ/bYlC05azg
         +4yfoOx3uIroF7IWN1i/lZTdSyrGZgHtaLQkUIiZES5cRapffgECmP58wn6U4S8KVomX
         yebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793069807; x=1793674607;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U1tHH5Mqf99jycLltqjXTRn5xKYAyrIr2aHOwRziEw8=;
        b=BYrw+M6/ppPY2C6LrwDYjYXU9z7d6w99EoPV3vZpTiL+JdKeebVi3CCCP/CNzSaMTR
         hokhpoBuYwep+L812/Wfi14Po7ziBzh5Psp+L0fnAYaIQlrYG/J9ORo2X5gWjVORuMcx
         ITLCSrA7FoSkLp3Pa4IJpqnPEtIDEGSqkoZ8Rm/mXNC38vJ3sVZzrr6kLy0XrTN7Cccq
         shsgupn4QTa6JVFo30BIVW1j4ttA8MNiLQUeuqcIHzMeGngVgIE8Nlnegp1/JM4cdgA2
         0hB2aOgTQddwdVdpDtHticNSHKwdkAk+BSQwppHhLASaSs32dxIYEofCLKV1FI4KeUyM
         tB0A==
X-Gm-Message-State: AFq9FYJnkVmbgiAUyRnA7gMEsiHrr/SwxZHCvJjLqGkhWPF2PLx2ItMV
	zoayj2+Uz6P//iCdhF0T9IiElm75KtpcK62NiLOIEw8bhsoQiDfdWidPT2i87Pp1XoG2CaCUtqU
	ACcdsJ5ZAu1DfU+RRkhAwj98nCF+qCpwrxw==
X-Received: from ilbeu28-n2.prod.google.com ([2002:a05:6e02:2f1c:20b0:516:ba98:55b6])
 (user=kevinloughlin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6870:3929:b0:494:396:1205 with SMTP id 586e51a60fabf-4a83f49fec6mr6444601fac.14.1793069806655;
 Mon, 26 Oct 2026 19:56:46 -0700 (PDT)
Date: Tue, 27 Oct 2026 02:56:07 +0000
In-Reply-To: <20261027025616.1632690-1-kevinloughlin@google.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261027025616.1632690-1-kevinloughlin@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027025616.1632690-5-kevinloughlin@google.com>
Subject: [PATCH 04/13] x86/coco/sev: fix zeropad #VC on unaccepted memory
From: Kevin Loughlin <kevinloughlin@google.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@kernel.org>, Jason Wang <jasowangio@gmail.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Kiryl Shutsemau <kas@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Alexander Duyck <alexanderduyck@fb.com>
Cc: virtualization@lists.linux.dev, linux-coco@lists.linux.dev, 
	linux-efi@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Sidharth Telang <sidtelang@google.com>, Punit Salian <psalian@google.com>, 
	Peter Gonda <pgonda@google.com>, Ackerley Tng <ackerleytng@google.com>, 
	Jacky Li <jackyli@google.com>, Steve Rutherford <srutherford@google.com>, 
	David Skidmore <davidskidmore@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

When dynamic memory unacceptance is active on AMD SEV-SNP, an accepted
4KB page may sit immediately adjacent to a 2MB block that has been
unaccepted via PVALIDATE(validate=false). Speculative unaligned loads
across the page boundary via load_unaligned_zeropad() (such as in
dentry path walk) trigger a hardware #VC exception with error code
SVM_EXIT_PAGE_NOT_VALIDATED (0x404) or SVM_EXIT_NPF (0x400) on the
unvalidated neighbor page.

Define SVM_EXIT_PAGE_NOT_VALIDATED (0x404) and invoke fixup_exception()
in vc_raw_handle_exception() when an SVM_EXIT_PAGE_NOT_VALIDATED or
SVM_EXIT_NPF #VC exception occurs in kernel mode at an EX_TYPE_ZEROPAD
instruction before dispatching to vc_handle_exitcode(), matching the
existing EX_TYPE_ZEROPAD handling in the Intel TDX #VE handler
(ve_raise_fault()).

Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
---
 arch/x86/coco/sev/vc-handle.c   | 29 +++++++++++++++++++++++++++++
 arch/x86/include/uapi/asm/svm.h |  2 ++
 2 files changed, 31 insertions(+)

diff --git a/arch/x86/coco/sev/vc-handle.c b/arch/x86/coco/sev/vc-handle.c
index f25d302efceb..1ed00771d87d 100644
--- a/arch/x86/coco/sev/vc-handle.c
+++ b/arch/x86/coco/sev/vc-handle.c
@@ -18,6 +18,7 @@
 #include <linux/io.h>
 #include <linux/psp-sev.h>
 #include <linux/efi.h>
+#include <linux/extable.h>
 #include <uapi/linux/sev-guest.h>
 
 #include <asm/init.h>
@@ -872,6 +873,29 @@ static __always_inline bool vc_from_invalid_context(struct pt_regs *regs)
 	return is_vc2_stack(sp) && !is_vc2_stack(prev_sp);
 }
 
+static bool vc_try_fixup_zeropad(struct es_em_ctxt *ctxt, struct pt_regs *regs,
+				 unsigned long error_code)
+{
+	unsigned long addr, fault_addr;
+
+	if ((error_code != SVM_EXIT_PAGE_NOT_VALIDATED &&
+	     error_code != SVM_EXIT_NPF) ||
+	    user_mode(regs) ||
+	    ex_get_fixup_type(regs->ip) != EX_TYPE_ZEROPAD)
+		return false;
+
+	addr = (unsigned long)insn_get_addr_ref(&ctxt->insn, regs);
+	if (addr == ~0ul)
+		return false;
+
+	/*
+	 * load_unaligned_zeropad() faults when an unaligned word load crosses
+	 * into an unaccepted page; round up to the crossed page boundary.
+	 */
+	fault_addr = (addr + sizeof(long) - 1) & PAGE_MASK;
+	return fixup_exception(regs, X86_TRAP_VC, error_code, fault_addr);
+}
+
 static bool vc_raw_handle_exception(struct pt_regs *regs, unsigned long error_code)
 {
 	struct ghcb_state state;
@@ -885,6 +909,11 @@ static bool vc_raw_handle_exception(struct pt_regs *regs, unsigned long error_co
 	vc_ghcb_invalidate(ghcb);
 	result = vc_init_em_ctxt(&ctxt, regs, error_code);
 
+	if (result == ES_OK && vc_try_fixup_zeropad(&ctxt, regs, error_code)) {
+		__sev_put_ghcb(&state);
+		return true;
+	}
+
 	if (result == ES_OK)
 		result = vc_handle_exitcode(&ctxt, ghcb, error_code);
 
diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index e80676185092..38b8e0c2f5e2 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -101,6 +101,7 @@
 #define SVM_EXIT_AVIC_INCOMPLETE_IPI		0x401
 #define SVM_EXIT_AVIC_UNACCELERATED_ACCESS	0x402
 #define SVM_EXIT_VMGEXIT       0x403
+#define SVM_EXIT_PAGE_NOT_VALIDATED	0x404
 #define SVM_EXIT_PML_FULL	0x407
 
 /* SEV-ES software-defined VMGEXIT events */
@@ -237,6 +238,7 @@
 	{ SVM_EXIT_AVIC_INCOMPLETE_IPI,		"avic_incomplete_ipi" }, \
 	{ SVM_EXIT_AVIC_UNACCELERATED_ACCESS,   "avic_unaccelerated_access" }, \
 	{ SVM_EXIT_VMGEXIT,		"vmgexit" }, \
+	{ SVM_EXIT_PAGE_NOT_VALIDATED,	"page_not_validated" }, \
 	{ SVM_EXIT_PML_FULL,		"pml_full" }, \
 	{ SVM_VMGEXIT_MMIO_READ,	"vmgexit_mmio_read" }, \
 	{ SVM_VMGEXIT_MMIO_WRITE,	"vmgexit_mmio_write" }, \
-- 
2.56.0.307.g5fe7bd680c-goog

