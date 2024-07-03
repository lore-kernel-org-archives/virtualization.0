Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E226D194C79
	for <virtualization@lists.linux.dev>; Wed,  3 Jul 2024 23:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720049324; cv=none; b=EBlbhWF5+2HHhYUvBO5NkR9W6VGGGs+mIhKZLsUg4tJA2Tdb5yVosl20m3LfhYID8sONhETTMKkzpUGjlEyCaVakFjWedaeX9yKJ6zR2FQfAlMj6/leVW5793RjumbBCU6GeiHRQnCpPtICAwlF/LmO0biw9AZAyJP5t//SCaRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720049324; c=relaxed/simple;
	bh=2rX1eM7IcyL+aaZE748iVd0kPixuWYIPt9NTa74r4qY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RI7B33CTkrty+Md+4yzQtGbecrGiJoUdnM8XJHyt6KG+sC3DODp/CyLx5qEHxfBAHTTMZN0MItOT9zDNt5Tf0mwxxE0TeZ2VKYi+xAwxPQepn/z3YAu9fT/1nFTqOKe7I77VloC4cCS+pREvxb4Hglc8CFw0uNBNMUAJLmFeNGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EQsHPJcJ; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EQsHPJcJ"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2c825f0b381so70581a91.1
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 16:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720049322; x=1720654122; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DMqe2BG7Tl+EbczXsabTlZUrjUbcGGCiv8T53M9QugY=;
        b=EQsHPJcJEE+MF8XfJ7BhI/g12VltqzTLQNQoXizI/s99+6kN5lRxL5p5HYCjVCzMDd
         tJVmXM5oM5tMQkcuQxtquM8JDVkM3lWrJDnPt2Bvf6L2+YR09c2QM30lcf1/G7H5GeFR
         L1biqzEs350GYo78tWrjJuKf2Z5PMx52idjVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720049322; x=1720654122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DMqe2BG7Tl+EbczXsabTlZUrjUbcGGCiv8T53M9QugY=;
        b=OZqzZxlj9rcvZsg+ynnfmCFCD45k+mlmzmTBx5YzcrgW9y9gYiFOjDyxo5SQbJ9/Ic
         C+MNjqrcFGTKTNe39XbL91kM3L0L1otQYqaXV+PSfp/aIRJknj0jc3eRIxEhKowB4h97
         j8x1a81lUH90lQfQuhUjFbifocKfMu6d1q63W07YwETURCTf+hBV3RN5v+fPlBETaazG
         mSYPRrC0X39dUca2MNYeSlefU9j7MSLvaBMe5z2IiHRVI8iMFeSG7ubHHrEVPFBN1ZyH
         AaAX5B32tzb+3JnBO8U+DLBPL6s6Z3UgBWAxYvcBVbvwSBkCEQhKP97XnbIthEfqRiFs
         xDjA==
X-Forwarded-Encrypted: i=1; AJvYcCXOgrlWoyLVyo/1MNkJ02cDn79oB8lwyyE4SGja0dwOmr7QC3W/iWIVKJwWZmNPlxnANo4hOHC8MEihRel9MR8JwmgTkFTeh9EVMd12+s0=
X-Gm-Message-State: AOJu0Yy5Equcz/2Ar1xPaSBHUqSotptRJux61YB9dsbwAHUUh3O/pLZ7
	Qm9Sq1xj0u0Qjrzso/CLuvjcz3+sXwNZr7vWX2cwmCWd5Iy0o2X35VGVioDpTw==
X-Google-Smtp-Source: AGHT+IGnGTNEJSPVIcneCMmD4X4a7gsV7nmqZFmM5q3Tdw7a+eMuok/DQQzMgjsieAlv0BO+nLBTFw==
X-Received: by 2002:a17:90a:ff18:b0:2c9:77d8:bb60 with SMTP id 98e67ed59e1d1-2c977d90022mr2511946a91.35.1720049322220;
        Wed, 03 Jul 2024 16:28:42 -0700 (PDT)
Received: from ubuntu.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a946fb2sm83793a91.3.2024.07.03.16.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 16:28:41 -0700 (PDT)
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
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev,
	alex.james@broadcom.com,
	doug.covelli@broadcom.com,
	jeffrey.sheldon@broadcom.com
Subject: [PATCH 2/2] x86/vmware: VMware support for TDX userspace hypercalls
Date: Wed,  3 Jul 2024 23:36:01 +0000
Message-Id: <7f57b0fe002291e3f4b27dfe9f502ed3af296bc2.1720046911.git.tim.merrifield@broadcom.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1720046911.git.tim.merrifield@broadcom.com>
References: <cover.1720046911.git.tim.merrifield@broadcom.com>
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
index 00189cdeb775..54759c5a9808 100644
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
+static bool vmware_tdx_user_hcall(struct pt_regs *regs)
+{
+	struct tdx_module_args args;
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
+	return true;
+}
 #endif
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
@@ -586,4 +612,7 @@ const __initconst struct hypervisor_x86 x86_hyper_vmware = {
 	.runtime.sev_es_hcall_prepare	= vmware_sev_es_hcall_prepare,
 	.runtime.sev_es_hcall_finish	= vmware_sev_es_hcall_finish,
 #endif
+#ifdef CONFIG_INTEL_TDX_GUEST
+	.runtime.tdx_hcall              = vmware_tdx_user_hcall,
+#endif
 };
-- 
2.40.1

