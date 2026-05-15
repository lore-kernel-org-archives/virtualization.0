Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889483C768A
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 19:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872837; cv=none; b=VC1LiIobkSTpKF0CEVawMbXAh6e+5BT0xRp9nihi72FTD66ubITOV9tvElXnkHXPDjT6THn5BefOq/C3fxDWznloKeQzirrDIOz67/AcwXQ3P+CLHJ6K3YtkHe+K8M6aqQ+Tymr+mPxXKW96R78CLaYn6F5gDySMhzVDSR/JVUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872837; c=relaxed/simple;
	bh=5ZroqPTAiGiCjkjdUwgIH01/p3JgUmk9yrzxGnD97ko=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ed+7beUsU8ageQs6Jy1/n2xrKVjw8/Bqlgv1QUAaBIElooLqODiY1MzR2arLdUQQrqOtax0ZpIHlK0NIu5TTBU3tVQU4AWkHY9FCrws2V2qyBPGylhXEG5/EL+Cet1X6LDGPYZf3vUX384DZhhhlGrlm4Pf5MEzGyggpYlI4I+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CrM6/XrC; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CrM6/XrC"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-837d43e9ff3so95025b3a.2
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 12:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872834; x=1779477634; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=2d2hriGBYHFIT1h3oi40HlX5TSRUyuLIgvVXFrgjGyA=;
        b=CrM6/XrCTaonbnYohBMplDKdy9atCpT67ltgypGx0FahCU7xTWCCFyP25kZhTiO6je
         y/NIXAldJ01J1KWkyeohB9DTmpog6jwcq+o8T3ajYCmzsY4D3cKJLg9wE6VLXKkWb5vl
         G52Ia1uxNpkodzi0QLUOKX9Hj/ZqQ+vtwe/eQsldDsl+XgvqKwvUNNi5/lBi/igiV7db
         cqs9XjADdjIERdqRfTO0wHCXuYSqUttJOGKIRG0kHPlw0qf2DpGJ68O0BrzPFiI9KwEI
         8YfkOjknYpp3taCOQzuR82lcLKZVkCMI1M1rLynBXlggZPx5KFEuDaDdo9HucemY5MNJ
         mldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872834; x=1779477634;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2d2hriGBYHFIT1h3oi40HlX5TSRUyuLIgvVXFrgjGyA=;
        b=k1oEuEMxLJ0hVc/nj2MxXh47XhpOcDQbePx6T1TiL5wgmxQlOIRlEvJvpLXwnBx4wD
         qaGh9Xpe7UGThvCchHOJkhUczH4hWHPs2JrUxycos54AY7K8f328y0eu6kF4I+jxLd50
         SfRDS3jKYjhOfK/bfchIYDTb2bM6pSDnro9CNgUOPDWSiy9xnkwVMj7rJMrAA03kh78F
         v9JPSDZzdeyQaajiTSsZoo+flKUQkHUd4/iYrMlQq9ECNUDldXW2lsThRJ9RBPQCR3Si
         JsZbCHOdL2rq4b36kKKkz//mWrzsNFXYhJkng65t0pBODDFIVBQs3ns4YBQ86ZuCl64W
         vi0Q==
X-Forwarded-Encrypted: i=1; AFNElJ/a2+ruVP1iVdSuWFRyjz1t2toKq8k/37oWFHNb32KgkwaxDMJXTpNikLe9GZGLTt8PtFnm5ilrfURnEtMUYw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyLRlarygifknkJLom8GuHdpU5xC5jtlc0muT3U0MlvffWfl391
	T/6kRaCgUzrbsnxXoQzqxFTHJh7UtbqmYbnP3MVrZwURn8wbbf2LtfUhkLi+AOow79e5Olvz2Be
	kdDCuJg==
X-Received: from pfblg3.prod.google.com ([2002:a05:6a00:7083:b0:82f:bf29:61aa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1ca4:b0:82c:6b1b:7ad4
 with SMTP id d2e1a72fcca58-83f33bc808emr5114483b3a.3.1778872834057; Fri, 15
 May 2026 12:20:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:10 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-10-seanjc@google.com>
Subject: [PATCH v3 09/41] clocksource: hyper-v: Don't save/restore TSC offset
 when using HV sched_clock
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
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/clocksource/hyperv_timer.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 69c1c7264e5d..ac1d9f9c381c 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -527,9 +527,6 @@ static __always_inline void hv_setup_sched_clock(void *sched_clock)
 #include <asm/timer.h>
 
 static u64 hv_ref_counter_at_suspend;
-static void (*old_save_sched_clock_state)(void);
-static void (*old_restore_sched_clock_state)(void);
-
 /*
  * Hyper-V clock counter resets during hibernation. Save and restore clock
  * offset during suspend/resume, while also considering the time passed
@@ -539,8 +536,6 @@ static void (*old_restore_sched_clock_state)(void);
  */
 static void hv_save_sched_clock_state(void)
 {
-	old_save_sched_clock_state();
-
 	hv_ref_counter_at_suspend = hv_read_reference_counter();
 }
 
@@ -553,8 +548,6 @@ static void hv_restore_sched_clock_state(void)
 	 *                - reference counter (time) now.
 	 */
 	hv_sched_clock_offset -= (hv_ref_counter_at_suspend - hv_read_reference_counter());
-
-	old_restore_sched_clock_state();
 }
 
 static __always_inline void hv_setup_sched_clock(void *sched_clock)
@@ -562,10 +555,7 @@ static __always_inline void hv_setup_sched_clock(void *sched_clock)
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
2.54.0.563.g4f69b47b94-goog

