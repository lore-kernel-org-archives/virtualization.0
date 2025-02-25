Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D9A4C83
	for <virtualization@lists.linux.dev>; Tue, 25 Feb 2025 00:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740444440; cv=none; b=EF39jz3DPBmhN7JCMQ/ogf+FGEtHMz7jaa7rLZt0Eh3h72YZwWv42VKrShPAzQBtodHizhNuXqfYy1d46IkPREfBrigZ9aiVZEeBqDuFuo7+CTB4/EdmFZlKVchEPAyiUQoA23vOceubNa566BX5C9a9CruA4CeXkOl+05WHYeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740444440; c=relaxed/simple;
	bh=Bti+4WFdsQWdwawsSlCRg6Upf2HmU0CDyT4BY606188=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=i8RVpdwYXtdgCe+EJUvNq3r15TgNBrKQIaQxncnPwtte6VfgK2FV9JwhBm6ct92L9ifXYwgCNu/+G/GMLODUG8p7JtegDOOhPAJpV51dBSbs/ZAs1UQbuP5mXsqlBLtquHvksWbLndFm1VElnOzbDoXSDET/i6D83CFypikXodE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sD+HgV55; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sD+HgV55"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2210121ac27so105308095ad.1
        for <virtualization@lists.linux.dev>; Mon, 24 Feb 2025 16:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740444438; x=1741049238; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I5KMzQoVShSgVrtM4DxTTsmM2BWrfSX+7bpV0asZP4o=;
        b=sD+HgV55drMpGED4TGzvi1AO7i/SLQ7gBOLy+RV9qHdIDwInHwXvFlSsRrSDDPMZ2O
         QUXDAQarhG9lxX9OBu8JaBMhKtREAVk45ptCwPzz4wGtotMQT4dkJpYIeWOk7kfP0Orx
         yaUMy2zB0yBtK+qXXW8yxaJ5obfIfz3UYmb9nzu5E0BkLietFX/oAo7yGauPPPbni7CD
         aNnQjMCkHZoBQ9Q1Cs7r284LY9Z9W8Dq/AkF1c20Ng7K+7VETTDImhZhRpZ3T0DUofVL
         3t/uUXurJ8pZRDk9AeFGDyrdxqNOaoabWGw3NHAriSU7Qa9/VXzSHwagKbQk+ipqlQbw
         L8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740444438; x=1741049238;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I5KMzQoVShSgVrtM4DxTTsmM2BWrfSX+7bpV0asZP4o=;
        b=M+EJ+xNXNmJfJfZS2q+JUqY44cxW1YPnr8+tZVOU4JFkrcmMcdA5zIu1ucESQbjYXU
         CB90Vo5XMKSfb4XSBZvEWAMbBKKpdadkcvBfM9ra9j7htHy0Y6d+w4uvK0udl96HxOj6
         NeHaBjwhAPYaPsAKjIn+h+0hck5da5eg+qH2EVcIh8dquaoVdWDqWLJufZORToc9Mez3
         uhzStcjeBkEB88QyMZhKSt3QYHEH4p/gp8aQA2FdxC8BevL4luZ4nytC5miforIqRoFX
         j+nb11DG8Nutmdgddoie7dfnXcC42ZPqSIlWZPRjxuRa2lGve8QbuEmW5ffyd4jqlXL6
         FTmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRKncVqo3SBkE/R9PA3v6/TmNP+f/CMw8XtxadEGR1VS2bKHAAFXKqzuwxCvnP0FKiwAfLRPxbMEqFpYPODQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwR602W5mANgE6SMjd/ohkM29yxS9U+Dj28RqULZm4dQS/tmIom
	AyYDf7Q7uydVPsixWt0FC6kkqleK8QOx/IgJWT/2KRTX++vnU76Nl/Nf62QlRmIawkSYgyj/d71
	KA3eK/KSoL7vr1Xitsw==
X-Google-Smtp-Source: AGHT+IHpAVDfWrqEo9rKctpl0ggmR96y2poe6zx51fhSxaTxTg/nRaaD77F/bbkyc7Y8iGsQ0zvHJqrkdR2Dr46s
X-Received: from pfbfa9.prod.google.com ([2002:a05:6a00:2d09:b0:730:8566:41dd])
 (user=vannapurve job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:9215:b0:1ee:7c7d:e66a with SMTP id adf61e73a8af0-1eef3ca2d1amr25377522637.23.1740444437979;
 Mon, 24 Feb 2025 16:47:17 -0800 (PST)
Date: Tue, 25 Feb 2025 00:47:01 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250225004704.603652-1-vannapurve@google.com>
Subject: [PATCH v6 0/3] x86/tdx: Fix HLT logic execution for TDX VMs
From: Vishal Annapurve <vannapurve@google.com>
To: dave.hansen@linux.intel.com, kirill.shutemov@linux.intel.com, 
	jgross@suse.com, ajay.kaher@broadcom.com, ak@linux.intel.com, 
	tony.luck@intel.com, thomas.lendacky@amd.com
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, 
	pbonzini@redhat.com, seanjc@google.com, kai.huang@intel.com, 
	chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, erdemaktas@google.com, 
	ackerleytng@google.com, jxgao@google.com, sagis@google.com, 
	afranji@google.com, kees@kernel.org, jikos@kernel.org, peterz@infradead.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	virtualization@lists.linux.dev, bcm-kernel-feedback-list@broadcom.com, 
	Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"

Direct HLT instruction execution causes #VEs for TDX VMs which is routed
to hypervisor via TDCALL. safe_halt() routines execute HLT in STI-shadow
so IRQs need to remain disabled until the TDCALL to ensure that pending
IRQs are correctly treated as wake events. As per current TDX spec, HLT
#VE handler doesn't have access to interruptibility state to selectively
enable interrupts, it ends up enabling interrupts during #VE handling
before the TDCALL is executed.
 
Commit bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
effectively solved this issue for idle routines by defining TDX specific
idle routine which directly invokes TDCALL while keeping interrupts
disabled, but missed handling arch_safe_halt(). This series intends to fix
arch_safe_halt() execution for TDX VMs.

Changes introduced by the series include:
- Move *halt() variants outside CONFIG_PARAVIRT_XXL and under
  CONFIG_PARAVIRT [1].
- Add explicit dependency on CONFIG_PARAVIRT for TDX VMs.
- Route "sti; hlt" sequences via tdx_safe_halt() for reliability.
- Route "hlt" sequences via tdx_halt() to avoid unnecessary #VEs.
- Warn and fail emulation if HLT #VE emulation executes with interrupts
  enabled.

Changes since v5:
1) Addressed Dave's comments.
2) Dropped the cleanup patch for now, it can be discussed separately.

v5: https://lore.kernel.org/lkml/20250220211628.1832258-1-vannapurve@google.com/

Kirill A. Shutemov (1):
  x86/paravirt: Move halt paravirt calls under CONFIG_PARAVIRT

Vishal Annapurve (2):
  x86/tdx: Fix arch_safe_halt() execution for TDX VMs
  x86/tdx: Emit warning if IRQs are enabled during HLT #VE handling

 arch/x86/Kconfig                      |  1 +
 arch/x86/coco/tdx/tdx.c               | 34 ++++++++++++++++++++++-
 arch/x86/include/asm/irqflags.h       | 40 +++++++++++++++------------
 arch/x86/include/asm/paravirt.h       | 20 +++++++-------
 arch/x86/include/asm/paravirt_types.h |  3 +-
 arch/x86/include/asm/tdx.h            |  2 +-
 arch/x86/kernel/paravirt.c            | 14 ++++++----
 arch/x86/kernel/process.c             |  2 +-
 8 files changed, 77 insertions(+), 39 deletions(-)

-- 
2.48.1.658.g4767266eb4-goog

