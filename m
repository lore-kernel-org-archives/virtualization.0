Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7323E146D76
	for <virtualization@lists.linux.dev>; Sat,  1 Feb 2025 02:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738376258; cv=none; b=bIR3W6M1Q9Zee6nwx/IoHOHK0AG07ds4f94XYLCAjLMRvamx6KlkKUlvWntsPVY8YmHlVC7wIW5QgQ/i+TFC+IRnAOAjREdx6054AKj7K3nvazbo8PoFTkuAV44V0vtxmkgrFZIbY6Y9azhnIAXKxbjA/2LqsFUW/g8AIb4nrd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738376258; c=relaxed/simple;
	bh=0aeg6fmcALkQCcWUWMu3ttM1q1g3Byn2iNg3RXSwUWU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EhQb5JVfO9FVSBMznau3Nj0Ur4veUct0D6jm7RuVrV8e8krUOznIQApw2ZNIVtoloWC1JgNyrQlXTi3jfxSZ6QZWHK25pSDwiVv93Bwa0m+HYWclyyR3WaamwXU9RpfY39xJAume85WkouYee/yTQXcaMBxDgb4kHvG6tQ456p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VfgvhgaM; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VfgvhgaM"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2f46b7851fcso7304441a91.1
        for <virtualization@lists.linux.dev>; Fri, 31 Jan 2025 18:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738376256; x=1738981056; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Jjc0FDt1SDUJCzq8fzQuxH7Yk0FUL+T40LhhOPtkSdY=;
        b=VfgvhgaMDHAT1HD1VlmVHRUa1vpHqZpZ+Oi5N/eCLw8bNzPH0xHc7Zrx+iaC+1BHtB
         k1E0ZpWnW57166b35oKkTSa7r0ydLTchHybI2aaXzA6A+R3QJUpjv0M6iY+MwPS2XnkK
         Se3zMl7MyNlNZh0mm/Tgt9JrBjwyfIQ8qYBIVBFRxDrceUeTvRfsVtZ8SXo7ZeLY0W18
         zfo3IeCt+/XUHmUi04k4yyIzhPYX+/5dUh7ew46M02SZr6zR0NKgwPfP23AdN+MJSSln
         7aRl8pJuKOOOuQB8zqHULOvJmE3Z4fkcBHZinClR6tC7dQdleBGQJZJ2jNdW8b5NXWxJ
         is3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738376256; x=1738981056;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jjc0FDt1SDUJCzq8fzQuxH7Yk0FUL+T40LhhOPtkSdY=;
        b=trrMqgcARqhxdSDtoAfj2FEHFZXFXghV/jC/PmMMt0uEoyg4hQ9tDHs/mp2e3uyzRK
         imNeAsF/YtXgLoeNC30fl9J2t0Mb/X6NtdpOUSqyuZj54sTpPh4stgo2wbGT8S1bXL6/
         IzEi+pnFNB6ORLlOXLhRXv8DXbnhVXSXJ0SB/zjRt/ytsWh5f8Cjkn+GDiif879+2uNB
         RLHtvej07FY28vTiEaDP2LdTyvAS5WuNGIEq2BUa6vIdDtGNY+mIf1OWhFVpqEtQ5/uq
         B4Gc3vRa0zea0mxPA0SUzpFqwK6ft4s0dRI1eaojguFv3DOvDhSNWUNu9kJEVypUn5k1
         EJSg==
X-Forwarded-Encrypted: i=1; AJvYcCXoGTP6fFPzUKGuVMCCKf+rF532YtUnPY/hntpnBF8FMyBmy4YXymSx1ZD2QsG9W19lk/jhveJMPwrbEbfe9g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzvUBuAWhMzNeE6AyhM1yJTbdLbPyRtjx/rBWZ8Or3zTEdFgrD2
	Vb3Kv4x8XTOoGI0tTh2Gtpq10yf5D5C1oPrn3kJiMFnwRsXpZFAXlHvdwZA0RigmHgLUze6H5oH
	5jQ==
X-Google-Smtp-Source: AGHT+IHNY7VvQQRT0KSmjAH4FP26r3GzVfaLj1GKx7+F1yhKWmFMaX6hkP/CltwMml7T2BlNCnyUm1qLLO4=
X-Received: from pjbsv5.prod.google.com ([2002:a17:90b:5385:b0:2f4:3ea1:9033])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c03:b0:2ee:d18c:7d84
 with SMTP id 98e67ed59e1d1-2f83ac17ebemr18755620a91.20.1738376255998; Fri, 31
 Jan 2025 18:17:35 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jan 2025 18:17:07 -0800
In-Reply-To: <20250201021718.699411-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250201021718.699411-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250201021718.699411-6-seanjc@google.com>
Subject: [PATCH 05/16] x86/sev: Move check for SNP Secure TSC support to tsc_early_init()
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Juergen Gross <jgross@suse.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Alexey Makhalov <alexey.amakhalov@broadcom.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-hyperv@vger.kernel.org, 
	jailhouse-dev@googlegroups.com, kvm@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Sean Christopherson <seanjc@google.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

Move the check on having a Secure TSC to the common tsc_early_init() so
that it's obvious that having a Secure TSC is conditional, and to prepare
for adding TDX to the mix (blindly initializing *both* SNP and TDX TSC
logic looks especially weird).

No functional change intended.

Cc: Nikunj A Dadhania <nikunj@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/coco/sev/core.c | 3 ---
 arch/x86/kernel/tsc.c    | 3 ++-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index e6ce4ca72465..dab386f782ce 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -3284,9 +3284,6 @@ void __init snp_secure_tsc_init(void)
 {
 	unsigned long long tsc_freq_mhz;
 
-	if (!cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
-		return;
-
 	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 5a16271b7a5c..09ca0cbd4f31 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1514,7 +1514,8 @@ void __init tsc_early_init(void)
 	if (is_early_uv_system())
 		return;
 
-	snp_secure_tsc_init();
+	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
+		snp_secure_tsc_init();
 
 	if (!determine_cpu_tsc_frequencies(true))
 		return;
-- 
2.48.1.362.g079036d154-goog

