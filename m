Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DB337F8AB
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 19:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872830; cv=none; b=kEhx9iYaqB/4aW5N+/tTZxU6tlsaKpAReZSZG44LJ+zctZZABhtq5pVmT/fACuXNC4byHg46A4y9Tm0Tk+Uw5fHXh4wFVt8V230X0pUyYR8aJSCSCrkneEqHScbdasm8nRvNzLVDpc3F5OARI6x+TdP3kWCOUGt+WgfQOEiFN6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872830; c=relaxed/simple;
	bh=EM4Aa/jhLL0HBAZa7II73CeQqmh6W0AY88xO0q2PZyY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U/ZYoVByJfHI0Qj9uINAQJ94chPNJ2tXKDPnW1r467y9KJhamhNxzDmktSVy85SydoXeEGBMZRJf70SuRqAablVRHDqhYZfcvv/FNId+Cmj8deFUgSbAIEkwpazsmLjvz31aLB5DqXMpMN8mT633cp11DXsrNUtqjZpK+xvee0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t/jBs+Fg; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t/jBs+Fg"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82fd55bf6cdso177610b3a.3
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 12:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872828; x=1779477628; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=f8J88NcF7oH9XUSV/4XAna5n7NY6XY4d9JdR9Rumg2w=;
        b=t/jBs+Fg4bXRL/xgRHWFyd+ESNkbHT+d4OkB6ZUpRDv1njkazvSjCAMyM1CPuTOKVc
         0X/O9MuK/lhCKeAecEUbBrqRb+CpQYwmncWgcp7c62pk8UMelNEWGa3k4Rt6w9ieLR8j
         7udp7k1XjC6QeqgIDWzvpnzB6Jya+df34VDJi5hbLv9XrIhZsObI5VqmRqmPU/OSoUBs
         DzvLBIk/2lRAG10hHyFEoY6NtynUnmroRpr5SZ2EqKHLUe5o8Px+CGja37tds5aBJiQw
         GxlQDH9N14T7Q3wvfVhZszXUXgyOVouvHMl0ovuGzyCGIBks9DUw3IIjuYPxhR6A2sBh
         03XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872828; x=1779477628;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f8J88NcF7oH9XUSV/4XAna5n7NY6XY4d9JdR9Rumg2w=;
        b=DadfolCFBL95CM3ud2KfgteEup+NFAGPvpGhdPexDBARjbStwMu8XPxU7In8thU0Ql
         1fDKq47ggxRar16c9ly/ZfLWm0yeO+j4U7EqO4P5ovqAiIKvenAutwBeBuYbafdCYTFX
         6p3BSEDQteFRaj4XjrokqtonrEl//+vStUiL4v24kGCzFsrgIW5Z2YH1mhHvaBu44WsW
         6Aveao959Dm0Mn2KzwwCCOGosaSHsGIHFYpI3aH2/PLI1dDmv4CQsCzcxodbYyHaN1ep
         g0rt/exof9zCxmk5QSXYlHE9GSFfVHMQ7ZgGl6iyMVy2pShiSqEvuzT+4rgHr/BtvDMd
         pcLw==
X-Forwarded-Encrypted: i=1; AFNElJ+xiS3YG3JxGrid+vxJJD4ZUOoHuRAC2uSpFmUZ6V7BMOUKEPjhqi8z/go5OKuffqyTgitzb4EjHqJoimnF7w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6lnegBLi1ha1+Ix0nbbiOeDuw0Wey/kDYKxEaWB5ZXXmTMuX2
	eEQehjW5PdJ+MX1zCUDUjYgtOCWeoJoRIXLVS0ou/U9mTUu/YXvvssgQsh63uWXncUZmunM0ovM
	r7V00kQ==
X-Received: from pfch22.prod.google.com ([2002:a05:6a00:1716:b0:82f:6a26:5f78])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:12e4:b0:835:405a:7e68
 with SMTP id d2e1a72fcca58-83f33d9dd83mr5936320b3a.32.1778872827310; Fri, 15
 May 2026 12:20:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:04 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-4-seanjc@google.com>
Subject: [PATCH v3 03/41] x86/sev: Mark TSC as reliable when configuring
 Secure TSC
From: Sean Christopherson <seanjc@google.com>
To: Kiryl Shutsemau <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, x86@kernel.org, 
	linux-coco@lists.linux.dev, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"

Move the code to mark the TSC as reliable from sme_early_init() to
snp_secure_tsc_init().  The only reader of TSC_RELIABLE is the aptly
named check_system_tsc_reliable(), which runs in tsc_init(), i.e.
after snp_secure_tsc_init().

This will allow consolidating the handling of TSC_KNOWN_FREQ and
TSC_RELIABLE when overriding the TSC calibration routine.

Cc: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/coco/sev/core.c      | 2 ++
 arch/x86/mm/mem_encrypt_amd.c | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index d27cf8f8b025..14ced854cd83 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2041,6 +2041,8 @@ void __init snp_secure_tsc_init(void)
 	secrets = (__force struct snp_secrets_page *)mem;
 
 	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
+	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
+
 	rdmsrq(MSR_AMD64_GUEST_TSC_FREQ, tsc_freq_mhz);
 
 	/* Extract the GUEST TSC MHZ from BIT[17:0], rest is reserved space */
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 2f8c32173972..6c3af974c7c2 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -535,9 +535,6 @@ void __init sme_early_init(void)
 		 */
 		x86_init.resources.dmi_setup = snp_dmi_setup;
 	}
-
-	if (sev_status & MSR_AMD64_SNP_SECURE_TSC)
-		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 }
 
 void __init mem_encrypt_free_decrypted_mem(void)
-- 
2.54.0.563.g4f69b47b94-goog

