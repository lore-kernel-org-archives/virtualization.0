Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BED3412281
	for <virtualization@lists.linux.dev>; Wed,  1 Jul 2026 19:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934382; cv=none; b=CSfjW8Yx2rL6HR0TSPJYNnroZ+77H4B0k73QG2CYQhWpjJ/cvefknm3LQ/qNjDxusZ95WxsJuVi6duh2CkJ6rU8woTXn5GMRTMwLTJ3UYJf+HUUvRQz6BKUcmy3qoR4ang8iFUTICHp0xaaWvPPdd2p1k0GtpCBsH96NkPPO+W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934382; c=relaxed/simple;
	bh=tCV4PY2Cjyqd7ro3RVQKSLWulEUjgqTY5Nrfa61b3sE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DUBMuHyxvafR9vHj4c1DFjwvvVYS2g+mPsLRETvMcrdt5f/jfZ+3DAUhEuuA6oXgj9w0C3mEzSWRN74MigaD/OIQrrkQjLseU7CHu8QXzDixWnvhPcJBqYX+5zDTDumK/CR6Mr6B9bkiQZBmrJY/T6VpdCk1J/rn0lCFcmwIbPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PGEvX76y; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PGEvX76y"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ca53c486f2so12830205ad.3
        for <virtualization@lists.linux.dev>; Wed, 01 Jul 2026 12:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934379; x=1783539179; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=D8RMEeRf8IO60ymrjMFeZrqFOqn/98Ma8JhKdrpIeKM=;
        b=PGEvX76ycGrAP8591v1qAbtSRpjBcesL/XgMOQ8E81ZmetTwgDjk6Jr7oONq7z+H3Q
         hzZ88KX/mvZDgJMpBCF20X6Ps1vhVbOnLs77jfgnlLw5EPChQOQNett0+HeAF6tS+5dT
         teb17CoAzQIqvGluTDP0eq00Dpb5vdsjaFaelI92mzG3yi45bj5nfqmB7ehSNKC8l9tY
         OzxdTxA+nm+VoqDSLWfJqrZ1hrXpDR1Iawki6bZiwKBpL79MBogjLfQ/15vJeHtx/26v
         kTLna2G7vfSfgzu6BFNS4EzCV/GknOO+HhV5cvYpf+IOabv3SATB8yR1Ye/UPz7w6P3w
         iyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934379; x=1783539179;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D8RMEeRf8IO60ymrjMFeZrqFOqn/98Ma8JhKdrpIeKM=;
        b=X4oCY49TQaXz+QFy8fSbwbhiwyZOm0ibXU2AdVk4CKMTQJBcA6y3eJasRw4ory0qHb
         AsWeS3TYd2huKIgWAdy1LQBgQpZnQs40WwtLSZTn1tqw30/e4MByHoX4gbbAcpiHgBHS
         Iz1k0Yzi+/yEiZL0D+7aRvEOeHjXjx9bSgsfDMk8M4c9mNRYhBMjKg9T4TLXjxQCMssC
         GOqNNLlfD8PJSQuipHYthGyt3yqL1ZoTKtgobTeHfGcfVAB0RCVIOOoZVeNU9eWTGly1
         EsKk/1+/QyB/Qncvx8Lrn/aaop4xDednlb+wcBx8hi/RDE3FGh0Dhq2YzC6sWZMm0Du3
         sCiw==
X-Forwarded-Encrypted: i=1; AHgh+RpP6lEfUcaaTxGuWlOM+L20K/S9Ry1jCmmf3I/d1N7oJsiAj5k3c+vfYPuvkvMLM5uXttO/bDFpL+MPq/F4Hw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzYuVaVftGTAhd5rXZUvxnVn8g9vDG6R0U5BkcU1u05GJ9qJCGY
	YsSzoSuxWN1GKY/zOQyCDsucX2ZarGsBynlTIIbzktJThsLew+t8K8wmRhaQA0mm4sKSpsd1UP6
	OgtwV0w==
X-Received: from plkp8.prod.google.com ([2002:a17:902:6b88:b0:2c7:ebed:f6e8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3ba4:b0:2c1:ee75:56bb
 with SMTP id d9443c01a7336-2ca9117aa06mr20678475ad.20.1782934379169; Wed, 01
 Jul 2026 12:32:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:48 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-28-seanjc@google.com>
Subject: [PATCH v5 27/51] clocksource: hyper-v: Don't save/restore TSC offset
 when using HV sched_clock
From: Sean Christopherson <seanjc@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sean Christopherson <seanjc@google.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Now that Hyper-V overrides the sched_clock save/restore hooks if and only
sched_clock itself is set to the Hyper-V reference counter, drop the
invocation of the "old" save/restore callbacks.  When the registration of
the PV sched_clock was done separately from overriding the save/restore
hooks, it was possible for Hyper-V to clobber the TSC save/restore
callbacks without actually switching to the Hyper-V refcounter.

Enabling a PV sched_clock is a one-way street, i.e. the kernel will never
revert to using TSC for sched_clock, and so there is no need to invoke the
TSC save/restore hooks (and if there was, it belongs in common PV code).

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Acked-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/clocksource/hyperv_timer.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index daa8cbfe61ee..220668207d19 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -544,9 +544,6 @@ static __always_inline void hv_setup_sched_clock(void *sched_clock)
 #include <asm/timer.h>
 
 static u64 hv_ref_counter_at_suspend;
-static void (*old_save_sched_clock_state)(void);
-static void (*old_restore_sched_clock_state)(void);
-
 /*
  * Hyper-V clock counter resets during hibernation. Save and restore clock
  * offset during suspend/resume, while also considering the time passed
@@ -556,8 +553,6 @@ static void (*old_restore_sched_clock_state)(void);
  */
 static void hv_save_sched_clock_state(void)
 {
-	old_save_sched_clock_state();
-
 	hv_ref_counter_at_suspend = hv_read_reference_counter();
 }
 
@@ -570,8 +565,6 @@ static void hv_restore_sched_clock_state(void)
 	 *                - reference counter (time) now.
 	 */
 	hv_sched_clock_offset -= (hv_ref_counter_at_suspend - hv_read_reference_counter());
-
-	old_restore_sched_clock_state();
 }
 
 static __always_inline void hv_setup_sched_clock(void *sched_clock)
@@ -579,10 +572,7 @@ static __always_inline void hv_setup_sched_clock(void *sched_clock)
 	/* We're on x86/x64 *and* using PV ops */
 	paravirt_set_sched_clock(sched_clock);
 
-	old_save_sched_clock_state = x86_platform.save_sched_clock_state;
 	x86_platform.save_sched_clock_state = hv_save_sched_clock_state;
-
-	old_restore_sched_clock_state = x86_platform.restore_sched_clock_state;
 	x86_platform.restore_sched_clock_state = hv_restore_sched_clock_state;
 }
 #else /* !CONFIG_GENERIC_SCHED_CLOCK && !CONFIG_PARAVIRT */
-- 
2.55.0.rc0.799.gd6f94ed593-goog

