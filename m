Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2673032A
	for <virtualization@lists.linux.dev>; Fri, 26 Jul 2024 18:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722019763; cv=none; b=I1KmQAGEJeX9354Tpo5IZL14dvAMlf1hD9Hv1Tt7qzcn97JydSV5pVFphFn1XjZTvgAN+jk744eFMVoregWqJARO1/NrZv09/hqhbCii36cMFm04fkVl/3XWWbPvrDC6Bg3EO9MYnR65Fac/a/czcYIkgdgakjBSBC1yELPSwnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722019763; c=relaxed/simple;
	bh=+jXBXwXFxiuC99QH+zysxgb6L+b3Y4nclJxTDtnzuw0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UWMCYkTvBGnP5KO1I41NEX9pfa7AyfT6umogaYbn5PpRAgIWRieRPCvJJjP50O41Xxg3FsCWuJyn+Jsqsrdo38QMq1Sh1lz4NkBoDs9gyub3H0mr2OQm2eSODuAt4jF9YVUHXl8t6SIkmlBQb1ZWW67QvSO4CXcp5SFg6UNBXhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=f3WfUBIW; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="f3WfUBIW"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fd640a6454so9997965ad.3
        for <virtualization@lists.linux.dev>; Fri, 26 Jul 2024 11:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722019761; x=1722624561; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uBPU4xCiDMUET1E9lH81FLL0ftccfgyXUuc8LswKkX8=;
        b=f3WfUBIWwXJ1Qu1ftd9LtxuFzfzd4A4GMWeIOhYrtAZ2bBCSDEp/RS3Okr2/HjUrWv
         CnMPLmthomBCAAKWuKzq+EyXuZ2VwLow2ANa9XfjAQzXacb3t4snviAA9pl++1RkfgBx
         eIE32sQZSoXYiEmwPH1QBSbnWuXcdk1fzaS+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722019761; x=1722624561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBPU4xCiDMUET1E9lH81FLL0ftccfgyXUuc8LswKkX8=;
        b=A2+DzPdLo3v9a0Fl/GP10/ilor4f2gzR+9ezYCXNwkj16QLIqMqF7nnX/U88jqEf/i
         SHf3yzB+BnPBetUOD1FazZz3kv5vpkcFnRTKoSD7uOQa0twmH2LZDzodsG89GgoN3XqT
         VabXQHEhH7loUs/4uq7O0lrQkdZ7FGRDL2G0dCzD4e9wb7l2hEg/4F8n6HnAjdVhwWin
         XD8TAWj74YhZf6a5ci7bNqRtiEWMmpXftnE50ZuFdmd78Li5Onw6FcZVDL0P2rfjnHf1
         X7+uI4ajDJwm5QvWnf6M2IfIBt1KyfQQjx7LkXsd2u6Vrq3patZ/Qrt7LfSYjpL+5g2F
         5LYg==
X-Forwarded-Encrypted: i=1; AJvYcCXZNMGRHa+1gSVXMBWdgKm6iQfztw0ojJ+aJTAKDzH2A+JdTaHFWyfu+IczLmoGu2nBVc5HExMYpLqf33juERkunHpxuUUvMxBoSF23kjs=
X-Gm-Message-State: AOJu0YwWdcLf2kDSvLZ5mMc3EWSgJbILytsP/Wfu2AplIo63tiUOmMni
	TwXj4FjziqFVL3nxXLaG49dBsNARDriCcIRslVqY0xhuc1wU5Aa9GgZn8i0Feg==
X-Google-Smtp-Source: AGHT+IE9uV09xvmdLWuwpCgIzme9syDA93eFLaDIt4RDokMKMeMZxVrXf1S5Y4/8KFjApTy74m3UmQ==
X-Received: by 2002:a17:903:2445:b0:1fd:6a00:5837 with SMTP id d9443c01a7336-1ff048e5c16mr6628325ad.42.1722019760999;
        Fri, 26 Jul 2024 11:49:20 -0700 (PDT)
Received: from ubuntu.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee8494sm36285245ad.159.2024.07.26.11.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 11:49:20 -0700 (PDT)
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
Subject: [PATCH v2 1/2] Add prctl to allow userlevel TDX hypercalls
Date: Fri, 26 Jul 2024 18:58:00 +0000
Message-Id: <651ceb5a89721621d522419e8a5d901632a78a22.1722019360.git.tim.merrifield@broadcom.com>
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

Add a new process-level prctl option to enable/disable user-level
hypercalls when running in a confidential VM. Add support for
checking this flag on VMCALL #VE for TDX and transfer control to
a hypervisor vendor-specific handler.

Signed-off-by: Tim Merrifield <tim.merrifield@broadcom.com>
---
 arch/x86/coco/tdx/tdx.c           | 23 +++++++++++++++++++++++
 arch/x86/include/asm/mmu.h        |  2 ++
 arch/x86/include/asm/x86_init.h   |  1 +
 arch/x86/include/uapi/asm/prctl.h |  3 +++
 arch/x86/kernel/process.c         | 22 ++++++++++++++++++++++
 5 files changed, 51 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 078e2bac2553..02580fcf6157 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -238,6 +238,7 @@ static int ve_instr_len(struct ve_info *ve)
 	case EXIT_REASON_MSR_WRITE:
 	case EXIT_REASON_CPUID:
 	case EXIT_REASON_IO_INSTRUCTION:
+	case EXIT_REASON_VMCALL:
 		/* It is safe to use ve->instr_len for #VE due instructions */
 		return ve->instr_len;
 	case EXIT_REASON_EPT_VIOLATION:
@@ -634,6 +635,26 @@ void tdx_get_ve_info(struct ve_info *ve)
 	ve->instr_info  = upper_32_bits(args.r10);
 }
 
+/*
+ * Handle user-initiated, hypervisor-specific VMCALLs.
+ */
+static int handle_user_vmcall(struct pt_regs *regs, struct ve_info *ve)
+{
+	int err;
+
+	if (!x86_platform.hyper.tdx_hcall)
+		return -EOPNOTSUPP;
+
+	if (!test_bit(MM_CONTEXT_COCO_USER_HCALL, &current->mm->context.flags))
+		return -EOPNOTSUPP;
+
+	err = x86_platform.hyper.tdx_hcall(regs);
+	if (err)
+		return err;
+
+	return ve_instr_len(ve);
+}
+
 /*
  * Handle the user initiated #VE.
  *
@@ -645,6 +666,8 @@ static int virt_exception_user(struct pt_regs *regs, struct ve_info *ve)
 	switch (ve->exit_reason) {
 	case EXIT_REASON_CPUID:
 		return handle_cpuid(regs, ve);
+	case EXIT_REASON_VMCALL:
+		return handle_user_vmcall(regs, ve);
 	default:
 		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
 		return -EIO;
diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index ce4677b8b735..626ab327e34c 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -16,6 +16,8 @@
 #define MM_CONTEXT_LOCK_LAM		2
 /* Allow LAM and SVA coexisting */
 #define MM_CONTEXT_FORCE_TAGGED_SVA	3
+/* Allow COCO user-level hypercalls. */
+#define MM_CONTEXT_COCO_USER_HCALL	4
 
 /*
  * x86 has arch-specific MMU state beyond what lives in mm_struct.
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 213cf5379a5a..04d43b91d32a 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -282,6 +282,7 @@ struct x86_hyper_runtime {
 	void (*sev_es_hcall_prepare)(struct ghcb *ghcb, struct pt_regs *regs);
 	bool (*sev_es_hcall_finish)(struct ghcb *ghcb, struct pt_regs *regs);
 	bool (*is_private_mmio)(u64 addr);
+	int  (*tdx_hcall)(struct pt_regs *regs);
 };
 
 /**
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index 384e2cc6ac19..37d154e503a3 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -16,6 +16,9 @@
 #define ARCH_GET_XCOMP_GUEST_PERM	0x1024
 #define ARCH_REQ_XCOMP_GUEST_PERM	0x1025
 
+#define ARCH_GET_COCO_USER_HCALL	0x1030
+#define ARCH_SET_COCO_USER_HCALL	0x1031
+
 #define ARCH_XCOMP_TILECFG		17
 #define ARCH_XCOMP_TILEDATA		18
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index f63f8fd00a91..198431919fd2 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -1042,6 +1042,24 @@ unsigned long __get_wchan(struct task_struct *p)
 	return addr;
 }
 
+static int get_coco_user_hcall_mode(void)
+{
+	return !test_bit(MM_CONTEXT_COCO_USER_HCALL,
+			&current->mm->context.flags);
+}
+
+static int set_coco_user_hcall_mode(unsigned long enabled)
+{
+	if (enabled)
+		set_bit(MM_CONTEXT_COCO_USER_HCALL,
+			&current->mm->context.flags);
+	else
+		clear_bit(MM_CONTEXT_COCO_USER_HCALL,
+			  &current->mm->context.flags);
+
+	return 0;
+}
+
 long do_arch_prctl_common(int option, unsigned long arg2)
 {
 	switch (option) {
@@ -1055,6 +1073,10 @@ long do_arch_prctl_common(int option, unsigned long arg2)
 	case ARCH_GET_XCOMP_GUEST_PERM:
 	case ARCH_REQ_XCOMP_GUEST_PERM:
 		return fpu_xstate_prctl(option, arg2);
+	case ARCH_GET_COCO_USER_HCALL:
+		return get_coco_user_hcall_mode();
+	case ARCH_SET_COCO_USER_HCALL:
+		return set_coco_user_hcall_mode(arg2);
 	}
 
 	return -EINVAL;
-- 
2.40.1

