Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B2E47796
	for <virtualization@lists.linux.dev>; Fri, 26 Jul 2024 18:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722019769; cv=none; b=t06SUvenI0A9XAN2kEn+0eK+W4RVwixqsAc/maSX6esGOyVtDc3+SPF6vhKEZrtFQitnaqkdt/NMqb3NUEqTFl0ATvP/z//HovnUrDMNNUmw1pLksSKx2f4CgCSSCp6RU908RXv2JV0iUDpNJbvfZCqlnyD3fJ6Lx75JKCyJoec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722019769; c=relaxed/simple;
	bh=F5uTvikwGa469CPiqSv/UwSQuF/Im5tcCJwBQMDUZRs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ok0FI0a9B/VPoz85SLxtYgziLpBZ+GXZ+Gu7O3is4h2QVua2cU+D4bW2zzkNkCBFeWDxcDeHfRXg0vA88mi6TKppiySDi8qh2oCFWWRZPohlnlHlkCAOrrGNz0NSl7zfO4kj83asP7sem3spOjQQHQBlD0wRQ+JTOBe3HaRL7XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OehfhKWM; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OehfhKWM"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fb3b7d0d3aso5988975ad.2
        for <virtualization@lists.linux.dev>; Fri, 26 Jul 2024 11:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722019767; x=1722624567; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SP8XMNFql20U92EUMwQ8uLQcBAxfl5BFzyB/ky8QH4M=;
        b=OehfhKWM3qZUx5psVKDm//P7IRY5fxmEz+2roGgsZcHz8Y54x9IXadOmX8trYSq4Km
         NTlKFis3vNLHC+OXdmJ1d+Fpve1LGl6NkvxDgajUGJbXyzseZiFrOSRzrikJ22v4QI9T
         lndB+Ur76BV3IW/OLcDkclfCxyNGh6i6z4B+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722019767; x=1722624567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SP8XMNFql20U92EUMwQ8uLQcBAxfl5BFzyB/ky8QH4M=;
        b=PcRrQDoqfBLhzk3LVZTsyagUp6rbWgyRV1EM5KpKETndr7edJV+icygMFlezavHzfW
         uXzDJC6+n1WVV61XxlKlB6hn3z6uaxHOqyIrlo6vr3nlpLBdmyxq53oQDp+YEVjNMDpd
         X6CMScv47Oq6DA3mUy9ZbXhUlw2okzcYViBGLBl27xtkRnAe8oSC4yOlCHrT1zxUKXgA
         mj8DU6QHSnHt5+JiwVK+sHLkUpVsaWDRAxFau5adphDYyeKw+e+e3NnF7hDpFH6u9S3n
         JeAzLZDlLgKWyXvHt+Y9RXgTNeSebh2s9cc2U71DINlhI4lfOjkSVKL6HviQLmZRzsql
         aF3w==
X-Forwarded-Encrypted: i=1; AJvYcCX9DtmRQ1u2uQLlIp6q0Vweor3jfity33bjyIAA5aOkKgEazhGQ2w3i+mNOkaJEt8RC0wQ+58RHxSCEZLRzTKw7t8G70sjhTtRtK+en1/c=
X-Gm-Message-State: AOJu0Yx+wOVjhOPA8Drjy/8wMYuQBv1znJvGjcp/IwA2yqEASCRjdxMe
	ov5STWRzk5xOdYMETIRsXMlySzcAfDHpw42zdzAZGoEYVlvVJ0C8REpM8UrOWQ==
X-Google-Smtp-Source: AGHT+IHqeFWXvj6c9AvP0XqWmwcnueQalx00FQi4Am7FJWKWloEtv1/6XY/0WZADAvL3M2Abx2ARRQ==
X-Received: by 2002:a17:903:1245:b0:1fd:93d2:fb76 with SMTP id d9443c01a7336-1ff04852a8emr7839905ad.31.1722019767356;
        Fri, 26 Jul 2024 11:49:27 -0700 (PDT)
Received: from ubuntu.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee8494sm36285245ad.159.2024.07.26.11.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 11:49:27 -0700 (PDT)
From: Tim Merrifield <tim.merrifield@broadcom.com>
To: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Xin Li <xin3.li@intel.com>,
	Tim Merrifield <tim.merrifield@broadcom.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Kai Huang <kai.huang@intel.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kees Cook <kees@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev,
	alex.james@broadcom.com,
	doug.covelli@broadcom.com,
	jeffrey.sheldon@broadcom.com,
	kevin.christopher@broadcom.com,
	aravind-as.srinivasan@broadcom.com,
	ravindra.kumar@broadcom.com
Subject: [PATCH v2 2/2] x86/vmware: VMware support for TDX userspace hypercalls
Date: Fri, 26 Jul 2024 18:58:01 +0000
Message-Id: <0599d2f477dd07483d31a9d1aabdf64d69d29570.1722019360.git.tim.merrifield@broadcom.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1722019360.git.tim.merrifield@broadcom.com>
References: <cover.1722019360.git.tim.merrifield@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change adds a handler for tdx_hcall in the x86_hyper_runtime type for
VMware hypervisors which will ultimately invoke __tdx_hypercall. The
handler (vmware_tdx_user_hcall) does not reuse the existing
vmware_tdx_hypercall for a couple of reasons.

First, while the few hypercalls that are invoked from the kernel expect
uint32 outputs, this may not be the case for every backdoor userspace may
call. So the existing interface is not sufficient. Additionally, we don't
require the branches based on output arguments. Finally, the
VMWARE_CMD_MASK employed in vmware_tdx_hypercall is applicable to only
hypercalls expected from the kernel.

Signed-off-by: Tim Merrifield <tim.merrifield@broadcom.com>
---
 arch/x86/kernel/cpu/vmware.c | 51 ++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 00189cdeb775..e379facc3a5b 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -494,6 +494,24 @@ static bool __init vmware_legacy_x2apic_available(void)
  * TDCALL[TDG.VP.VMCALL] uses %rax (arg0) and %rcx (arg2). Therefore,
  * we remap those registers to %r12 and %r13, respectively.
  */
+static inline void vmware_init_tdx_args(struct tdx_module_args *args, bool is_user,
+					unsigned long cmd, unsigned long in1,
+					unsigned long in3, unsigned long in4,
+					unsigned long in5, unsigned long in6)
+{
+	args->rbx = in1;
+	args->rdx = in3;
+	args->rsi = in4;
+	args->rdi = in5;
+	args->r10 = VMWARE_TDX_VENDOR_LEAF;
+	args->r11 = VMWARE_TDX_HCALL_FUNC;
+	args->r12 = VMWARE_HYPERVISOR_MAGIC;
+	args->r13 = cmd;
+	args->r14 = in6;
+	/* CPL */
+	args->r15 = is_user ? 3 : 0;
+}
+
 unsigned long vmware_tdx_hypercall(unsigned long cmd,
 				   unsigned long in1, unsigned long in3,
 				   unsigned long in4, unsigned long in5,
@@ -512,17 +530,7 @@ unsigned long vmware_tdx_hypercall(unsigned long cmd,
 		return ULONG_MAX;
 	}
 
-	args.rbx = in1;
-	args.rdx = in3;
-	args.rsi = in4;
-	args.rdi = in5;
-	args.r10 = VMWARE_TDX_VENDOR_LEAF;
-	args.r11 = VMWARE_TDX_HCALL_FUNC;
-	args.r12 = VMWARE_HYPERVISOR_MAGIC;
-	args.r13 = cmd;
-	/* CPL */
-	args.r15 = 0;
-
+	vmware_init_tdx_args(&args, false, cmd, in1, in3, in4, in5, 0);
 	__tdx_hypercall(&args);
 
 	if (out1)
@@ -539,6 +547,24 @@ unsigned long vmware_tdx_hypercall(unsigned long cmd,
 	return args.r12;
 }
 EXPORT_SYMBOL_GPL(vmware_tdx_hypercall);
+
+static int vmware_tdx_user_hcall(struct pt_regs *regs)
+{
+	struct tdx_module_args args = {};
+
+	vmware_init_tdx_args(&args, true, regs->cx, regs->bx,
+			     regs->dx, regs->si, regs->di, regs->bp);
+	__tdx_hypercall(&args);
+	regs->ax = args.r12;
+	regs->bx = args.rbx;
+	regs->cx = args.r13;
+	regs->dx = args.rdx;
+	regs->si = args.rsi;
+	regs->di = args.rdi;
+	regs->bp = args.r14;
+
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
@@ -586,4 +612,7 @@ const __initconst struct hypervisor_x86 x86_hyper_vmware = {
 	.runtime.sev_es_hcall_prepare	= vmware_sev_es_hcall_prepare,
 	.runtime.sev_es_hcall_finish	= vmware_sev_es_hcall_finish,
 #endif
+#ifdef CONFIG_INTEL_TDX_GUEST
+	.runtime.tdx_hcall		= vmware_tdx_user_hcall,
+#endif
 };
-- 
2.40.1

