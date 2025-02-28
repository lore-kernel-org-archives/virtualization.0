Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14544502A
	for <virtualization@lists.linux.dev>; Fri, 28 Feb 2025 01:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740707063; cv=none; b=vE3S2pG65Nx8yr8BvVlFhl6gv91xU18HFI8DNas7HLlqVUc59523wxIDKEMV4NXTeWxoAIPbTkY6X7AkSYkYjVhQWjqMBfNY63MZvhHFaXeW+YnZpQbHbW4OzgAgczUjVHtTvaNrOOnwQnRcOKnwKO1q/CzXLNnavMuxsrMHTcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740707063; c=relaxed/simple;
	bh=a+hhsISpwSOV3NLgMMWxmhkEHZcRYIqr8+kcQE1b/fo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Scv9u2wYKoN7B3M+sGe8V2yE0AfFvAjlAZFNS7hGC+jpu7RAAOhIqDYxy7zHiU4tvaGtJZOinbjGLj28LfBllia1lxMbKl9/rbaSezJdngew3YB6q33QDzIJYxzSHxRRBa9qmMHqOBGVIgRyac7QYtwF6/hmI3yKM7Ur9xaEa0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zu7xENw4; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zu7xENw4"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22367f4e9b9so8364065ad.0
        for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 17:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740707061; x=1741311861; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FqF8Q8XFXYncfUenWuJBDSsEIDlyEuKebDS/PZCwdMY=;
        b=zu7xENw49oNm/RYv3na4SD211KvfOadZHVRIoLY2hl9i0aeAadys2aDjYudv9eS602
         WCbLgHs4JJRK26vW9io+46q1IWyrwxAAAquh+tb+dqrNmtUXOq4cs+RPblIzUEJfkhRD
         PWWL6PTTSV9YwqvsgYJuzTsYCa+cwLXquDVlM1oPlyqHDztjLLw1TfkoSJqGX3r7E1z1
         MORLtk3cIAjaBj9YAOJ+GGNyokohbPINI/O/+Pop9PDSXHMryIZb2cwH3wYS4eMbq8D6
         hOeX30zTKBA+A3Umves/0rPB4YaH4J+uNrV+puiVZ24Rq/ZvLoz5HhsM4DNbGIHglpQ8
         NQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740707061; x=1741311861;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FqF8Q8XFXYncfUenWuJBDSsEIDlyEuKebDS/PZCwdMY=;
        b=XSLkZxaxmmUDSRFp4L8At7DIIiPSdesx5XDoaYjh/3s0OmUgQx7bKNk4TWcWW9du7W
         m9OPfeqqey2Tu8M9WZ0QcVtG8j0cIksYv3bdxfyIlaOKQMHp5ihap4JAWRiWwbLAYlqd
         UeXt0MpkJjxx6pAdfZna3y38ZO8/hRqHXqvBg8akVGO4mJJpRSABdc8wa6Mag8YwZZEf
         bfh/TKccjuloozMn/Ppt8qLg5ChRUPdLXS2rn8aGK3+Ub+nkybRQaYLUcHbx5nqW9dvZ
         kWCu09ffEG268noTwVloVGkZPvBCnTVFO17pECpucDz/yQ+Q+jECC+n6roOaPyxyv1NU
         3bBw==
X-Forwarded-Encrypted: i=1; AJvYcCU4yeLmkPno+rrdOXcRijhbNXvdfmgcLPOpl8CG2iG9dqfRL3A5QQ+uCrABA6kNWnDPTVHSiWJEHKc0Vdazkw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxrvD7jC89y7CdIp+k0av1E0pne6CfEmdUe5tDOEQ61v4GpWcNL
	cd5deKqcb33M0k6jD4G5SxNNEv0NZIyw3EqXgl2zMu+BY2ftR4ofPDXhwXePCE43xLI6VVZ4qO0
	wVdsu0WGWC/Ic1kB8GQ==
X-Google-Smtp-Source: AGHT+IHq3/FYvnhcHmzR3dKBMJGYwE2w4qWoTkMltxQfzf+L6EUDYcTCBM+hlhmazTHObSb1r5X3Jip2Rwz7uXpy
X-Received: from plble4.prod.google.com ([2002:a17:902:fb04:b0:216:25a2:2ecf])
 (user=vannapurve job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:298f:b0:21f:3e2d:7d2e with SMTP id d9443c01a7336-22368fbc80emr20133165ad.27.1740707061150;
 Thu, 27 Feb 2025 17:44:21 -0800 (PST)
Date: Fri, 28 Feb 2025 01:44:13 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228014416.3925664-1-vannapurve@google.com>
Subject: [PATCH v7 0/3] x86/tdx: Fix HLT logic execution for TDX VMs
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

Changes since v6:
1) Addressed Kirills's comments.
2) Fixed a build failure.

v6: https://lore.kernel.org/lkml/20250225004704.603652-1-vannapurve@google.com/
 
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
 arch/x86/include/asm/tdx.h            |  4 +--
 arch/x86/kernel/paravirt.c            | 14 ++++++----
 arch/x86/kernel/process.c             |  2 +-
 8 files changed, 78 insertions(+), 40 deletions(-)

-- 
2.48.1.711.g2feabab25a-goog

