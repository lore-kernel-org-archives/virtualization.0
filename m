Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC11264FBF
	for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 21:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740086201; cv=none; b=YTC/UZ7qCMmNHpbnQzvg+7kmtRluGzKIjKLxJ9p815FnRF2inJFE3Z1e49Tkfs9w64WI4lPQJaCbzILif+IZbXKeSJ0ISfeGeZhbfWmNdSkvF1lM3W/vmBvqSoLPQ5/7AYtGhwkf/u3epx/2LMBAH4WDqx3oJOLDGgylhKFmnjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740086201; c=relaxed/simple;
	bh=+PPj/zrzjSYqXXCy96C5yaPEmwdaRWz6IyB/osiEhO8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aiNAJ8TiCmHnR7lQ1I2mV+fXofYQ6Cbj+3rPxLzpM2J/T2m/fCSWHvv7wMg8OHySITJUZqVsFv5ZjW+jpLBav0uaOF/ohFMUEWWyHXVbSpqZObJRCEPTth/P60uRRm3FqCNz6IGgAvZvdcuK05UjLyXCtI3Car0unip59MvavaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LYChoPRd; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LYChoPRd"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220ec5c16e9so30750075ad.1
        for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 13:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740086198; x=1740690998; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M+TBBWdBjfmJP6Y5X3+NqIMZIzXEuRVkUfogK9DAPAw=;
        b=LYChoPRdJe4lKGyKm5ZCe+8lEJw2dxMBH0d5RCrHnxxgfMSV7nSbljPFXqQhoV4vBU
         Beq9ufKO1VVLr6Fk2CVBrVvnP8vAJn0d/BziseXmLWGpeBxh1bUvZ5d1KreBBGVyyV7g
         0yplCFrBRheij6+JueLSAezQE3zqnM8MsV2HYfKhzIOEMUrokdPfYD1ZCqwKNOAuteZC
         gYrxyQyrpoHNbHhxiWMILYbJX8N03gi2+0/BrBvV2Dpmfsgl4MsPrINj9rp9r26H793F
         JD2QuFJYhqchwFkUcluBjEcLvQ8+dxB0uRksd3r42BC0CCaloUvJeGIZagWCA2Vh8HI3
         DXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740086198; x=1740690998;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M+TBBWdBjfmJP6Y5X3+NqIMZIzXEuRVkUfogK9DAPAw=;
        b=E5zbawP69Vu63p7z5nkvjtTTDphy47eGMQ/3pc0BVcri7i8Glz5vt36t/k5KLKM+1c
         zogSea3iHrmohk20z2bX1q3uN0ghwz8Jp1OaAWjSUib+gYC9a26nEn5PP2hP+MDdz8kB
         lWbwrLNBMKeU0G7Ejdh9n51cwZOh0so2Mtzft7Ks+uPSW2Z7iJMh5Mb4ou6blOFprpnu
         xGT+Ka4XPybX6TmeMYVl5Xv9MdTiXDqJRrKjZkVcXK441sGeY1F7PinfTpv8YTPc/j58
         /N7LBzBDQXQnULDzt8E603U91RzYJl0AnorXBtOxdcIZ7RPQHei8EcVvN4eDVNx/NM0l
         ZOIg==
X-Forwarded-Encrypted: i=1; AJvYcCXDc1Rv8IdcdbBjlyqDfTlMJ5Pje0pkIxMxC+xmgmNugB+uVUYaabpMbv/BlO7/KgV0SulL4s5NI00TPu/39g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZYnLQuleQAYXlHX+aupuvhWl00ljMTWM5ADT3vdM5B/5eScdL
	A499plI7qaoeqMOE014f3l26gYcBP5Ofx09tUPkAigy3UZIC4NCazGV5x4Ggmb5bKBn+3tdMuxf
	880NZsnFQExU7jswE1Q==
X-Google-Smtp-Source: AGHT+IFBNlC2O2lCqWhKeQbyAtagcsPixzHArx3alpasUksoCuLOtkF4bpyxaKtp+sZkIRPUeSQUbnmVmkWHtYVc
X-Received: from pgbfe4.prod.google.com ([2002:a05:6a02:2884:b0:ad5:4620:b05d])
 (user=vannapurve job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3989:b0:1ee:dee8:5a21 with SMTP id adf61e73a8af0-1eef52c9126mr489345637.6.1740086198423;
 Thu, 20 Feb 2025 13:16:38 -0800 (PST)
Date: Thu, 20 Feb 2025 21:16:27 +0000
In-Reply-To: <20250220211628.1832258-1-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250220211628.1832258-1-vannapurve@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250220211628.1832258-4-vannapurve@google.com>
Subject: [PATCH V5 3/4] x86/tdx: Emit warning if IRQs are enabled during HLT
 #VE handling
From: Vishal Annapurve <vannapurve@google.com>
To: x86@kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	virtualization@lists.linux.dev
Cc: pbonzini@redhat.com, seanjc@google.com, erdemaktas@google.com, 
	ackerleytng@google.com, jxgao@google.com, sagis@google.com, oupton@google.com, 
	pgonda@google.com, kirill@shutemov.name, dave.hansen@linux.intel.com, 
	chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, jgross@suse.com, 
	ajay.kaher@broadcom.com, alexey.amakhalov@broadcom.com, 
	Vishal Annapurve <vannapurve@google.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Direct HLT instruction execution causes #VEs for TDX VMs which is routed
to hypervisor via TDCALL. safe_halt() routines execute HLT in STI-shadow
so IRQs need to remain disabled until the TDCALL to ensure that pending
IRQs are correctly treated as wake events.

Emit warning and fail emulation if IRQs are enabled during HLT #VE handling
to avoid running into scenarios where IRQ wake events are lost resulting in
indefinite HLT execution times.

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 arch/x86/coco/tdx/tdx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 7ab427e85bd3..16ac337df9fa 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -393,6 +393,14 @@ static int handle_halt(struct ve_info *ve)
 {
 	const bool irq_disabled = irqs_disabled();
 
+	/*
+	 * HLT with IRQs enabled is unsafe, as an IRQ that is intended to be a
+	 * wake event may be consumed before requesting HLT emulation, leaving
+	 * the vCPU blocking indefinitely.
+	 */
+	if (WARN_ONCE(!irq_disabled, "HLT emulation with IRQs enabled"))
+		return -EIO;
+
 	if (__halt(irq_disabled))
 		return -EIO;
 
-- 
2.48.1.601.g30ceb7b040-goog

