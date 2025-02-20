Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A387426461E
	for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 21:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740086194; cv=none; b=ePQwWrQ8kKRXfwB7WyyFEWtX8h6rOfL+eNee8gMbhpz39UkN6lgTex3JKNJGSk5mSRpDybgddoc8QTcnHXdSznZ56jH2PBUp9/nlT/R+jfFtcyPlYIgNlazzLQj5iDFGJwSsEvJM7FSzZn1H0QH8ynRy879gDwl7gN7hzu2bIZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740086194; c=relaxed/simple;
	bh=AKgJ4IGqSbL/a88cyY+H0QYMx/Z7oG6hVYBBX9CiYOY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pxUNwKHl8bNGB660WwzTEhBZhd+TYRpAZ7xenNAECzRVEkTswEzure8n7O3FB6dw5rQUmBaOVKTCSu7++ZSAx/UASmlCdr5NLsOVp2MPyTzex9EgB8eJCR5FgIYJqhKdsgF0S16Vfda45OTMMhx1HK4ofn/u5ZrcROIeZ+OJuLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AEcXL8TZ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AEcXL8TZ"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc46431885so4309089a91.2
        for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 13:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740086192; x=1740690992; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8qvrVN9kBrozRo5CUBDtUXOgIdzDynxQKxj+1pBd5xY=;
        b=AEcXL8TZ99XCX9LXM4MjDzbw1Pd5AGS8u77zPOXa+13zeteIi7epX9lCQc6VcFCEn1
         dBhDZvNsDEnyWV48wnwISCJC8r7VneC7uJi5nx4XZDxEBDZ7HkXgb9fztRezn+69/hYl
         SqQIy1sb1lYb9MoDKHKkd3a0O/Q79nFXZNKyg9gsJwM8M9vosJj8dqwx0wgEdmy9EGg8
         wHIAJjaR52jqyiuDHipKiVFWeMejWmQ3E5ujOM/drGld3qEE92qEZPJ77Tq97X9GQgIV
         NqrfVcqerC05DIMW8X7R7a81Ai5HqZyGsy8/olADXR17Mwokrncdq6fP5O5rQNKOOP3S
         Q/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740086192; x=1740690992;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8qvrVN9kBrozRo5CUBDtUXOgIdzDynxQKxj+1pBd5xY=;
        b=eOVnCnYJDfcHdzH8Gt/kj9pUTTCBsCS+/Kap7afMHyURgwchiM8aCcagSfSgPl6MqE
         00vYRV15rG+vJB9xdLwLYiDa2JCANtYrs17ZZLwrD+rOsOuaJVMjV4BAdxVU5mupAeAI
         1Wrq9KwxcEwD3MGej8gbP2rgDNmjyvqMvqodh++PekblZxgIVWQHowN6i9q1xBCNCsJr
         ss/+A6fu1pBCCAyD0AVgLVxiLj7le8rhVHh1sKvq5fTEoUljmFRM855tsw8cbpIlSqeo
         Jkszox2fr//U13nSd0GSMdEXd6n33fTx+4fVoquLpL3rSougPw0C7Qy3klrfS2dnlosv
         Pcnw==
X-Forwarded-Encrypted: i=1; AJvYcCUGlqX9rBpOYO/XNtcElRsIhxegwrJlbXDzfhIjouKL1ljRCeqmGH7pQ7wRlnlZ6dFX8L9Ziw93vC3u2kn3Cw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3sQkVaKmmy7gLDdJl8NCDRMNZZuS9ZkvuvIjENfgAnr/csnUG
	CtPKr2QR50tKSxQ07r+DRryIPRNaPN7bfNZZ63SUpll+8Wc3hFKK9Rtka+Kmor5rKcL80X/SEGi
	u5fCsVDfRxl2zlOUa+g==
X-Google-Smtp-Source: AGHT+IH/8YsBcP5uZYl0bmlmhw3cSkjvn5V2r10re47N885FbaitMXwjoVcr1y27PxvOM4eurK+/YRXaGJnRVEqq
X-Received: from pfbei26.prod.google.com ([2002:a05:6a00:80da:b0:730:b665:d832])
 (user=vannapurve job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3d0a:b0:730:888a:251d with SMTP id d2e1a72fcca58-73426d9ee22mr716372b3a.20.1740086191802;
 Thu, 20 Feb 2025 13:16:31 -0800 (PST)
Date: Thu, 20 Feb 2025 21:16:24 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250220211628.1832258-1-vannapurve@google.com>
Subject: [PATCH V5 0/4] x86/tdx: Fix HLT logic execution for TDX VMs
From: Vishal Annapurve <vannapurve@google.com>
To: x86@kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	virtualization@lists.linux.dev
Cc: pbonzini@redhat.com, seanjc@google.com, erdemaktas@google.com, 
	ackerleytng@google.com, jxgao@google.com, sagis@google.com, oupton@google.com, 
	pgonda@google.com, kirill@shutemov.name, dave.hansen@linux.intel.com, 
	chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, jgross@suse.com, 
	ajay.kaher@broadcom.com, alexey.amakhalov@broadcom.com, 
	Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"

Direct HLT instruction execution causes #VEs for TDX VMs which is routed
to hypervisor via TDCALL. safe_halt() routines execute HLT in STI-shadow
so IRQs need to remain disabled until the TDCALL to ensure that pending
IRQs are correctly treated as wake events. So "sti;hlt" sequence needs to
be replaced for TDX VMs with TDCALL execution followed by enabling of
interrupts.

Changes introduced by the series include:
- Move *halt() variants outside CONFIG_PARAVIRT_XXL and under
  CONFIG_PARAVIRT [1].
- Route "sti; hlt" sequences via tdx_safe_halt() for reliability.
- Route "hlt" sequences via tdx_halt() to avoid unnecessary #VEs.
- Add explicit dependency on CONFIG_PARAVIRT for TDX VMs.
- Warn and fail emulation if HLT #VE emulation executes with interrupts
  enabled.
- Clean up TDX specific idle routine override.

Changes since v4:
1) Addressed Kirill's comments.

v4: https://lore.kernel.org/lkml/20250212000747.3403836-1-vannapurve@google.com/

Changes since v3:
1) Addressed comments from Sean.
2) Included [1] in the series to fix the scenarios where
CONFIG_PARAVIRT_XXL could be disabled.
v3: https://lore.kernel.org/all/20250206222714.1079059-1-vannapurve@google.com/

[1] https://lore.kernel.org/lkml/20210517235008.257241-1-sathyanarayanan.kuppuswamy@linux.intel.com/

Kirill A. Shutemov (1):
  x86/paravirt: Move halt paravirt calls under CONFIG_PARAVIRT

Vishal Annapurve (3):
  x86/tdx: Route safe halt execution via tdx_safe_halt()
  x86/tdx: Emit warning if IRQs are enabled during HLT #VE handling
  x86/tdx: Remove TDX specific idle routine

 arch/x86/Kconfig                      |  1 +
 arch/x86/coco/tdx/tdx.c               | 30 +++++++++++++++++++-
 arch/x86/include/asm/irqflags.h       | 40 +++++++++++++++------------
 arch/x86/include/asm/paravirt.h       | 20 +++++++-------
 arch/x86/include/asm/paravirt_types.h |  3 +-
 arch/x86/include/asm/tdx.h            |  2 --
 arch/x86/kernel/paravirt.c            | 14 ++++++----
 arch/x86/kernel/process.c             |  3 --
 8 files changed, 71 insertions(+), 42 deletions(-)

-- 
2.48.1.601.g30ceb7b040-goog

