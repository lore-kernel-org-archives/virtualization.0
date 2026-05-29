Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6433B403EBC
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067319; cv=none; b=XwO71VbFk/RbxF0QPnWJm4/OKXn+/sCgNM/EnMiwTdo183Jg147EQ8xeBXiHe1ocY6m2cYokVoIHGBd/acWaToCrWx0VquMz276fqTlSnzLCG63efH91f9gnSeiWQd4QDngqgruGEVLOEVaZKqliPktwcoLr7Yuo+/wSxWVOrCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067319; c=relaxed/simple;
	bh=Z4oAOLUpAYbd1Tz0ygnPD0Nha8ewr7CaV2/fH3E4CC0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=os02i2PWv7y+EaglZpzEniFRQ10CbZNs4ms5nZ/fjV+XK7NPz7wxGSgHvhfh4ckTBOpy7pQcmgNsIQf11PpmW+RqThCRSPxkUKntUPBCUC2tqIyQhsHw7zCYLsYybUvZwg+kVEf7E0lkYM+lvZah085AV2qDwvJI1UjmpG43aJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iu9qKaYh; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iu9qKaYh"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-368f2d76b04so13502816a91.3
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780067318; x=1780672118; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=79xm+AEEzsSDw8ktlax8YEYwGg5Kvc01O7CLcLHBYus=;
        b=iu9qKaYhDu9VO9XIW2FgA2bO4DEan2Y1LWJqwfIPjnOiZ/pSOP11liEM1zQeAhKsvH
         7Qzsa0q726BmPa9FG+dpJBIGZ/zOkRY4W+m8ZoBKLRbciU9iDFoERofKqnCNr5y7nMPo
         LGLMvasTFiir23BamBaiGCy3dG7aPTZC2IlxJvNCpbebKukp5WGd0qqkhnaGv0OKFo2O
         7cbj3lRvJ6afLBnBiMEHUzOAB6lIrppY6ZVpcf7GgSHbhAodTq24nZh1wawfhSz65+0d
         yPEpoelQ37JhScnFW4aevK0mOQMtpr7UEe2f5GJ9lJoemttpivdX6P1bWf7PX8OBbj9v
         6URQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067318; x=1780672118;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=79xm+AEEzsSDw8ktlax8YEYwGg5Kvc01O7CLcLHBYus=;
        b=dBLgU/v61Y7B5HeN78oj0eT/p3KGLNnFlDjQ5Ef15ojYUf1FKhoyEgYjbnKVuY1dEu
         bxfIPWQKeRKgxXuFjuqw6NwuTTJ5vDX7z+ZvbwEIvgB06Ea76ub13hnb+MDiJY5lLwtv
         Arc42IPJUfPVTEzZJbwvGH1ly2q/EFSSXyX0zUkMMvhM7m2gNBdUUAsrj5IroKl/foeC
         PF4P4G6CwmSUJ4sLHAC+5TXGSPDNzBW/v936OgjUtFEVVueUMIZ3BzwowmTx53EhAVZp
         TFcuUql2lzzXu9uMVAFxx1wRPL2ylP6mx8RH6YX4kGXWsKD2VG5G6r4PZD7q1sXtB681
         KooA==
X-Forwarded-Encrypted: i=1; AFNElJ9r16jGg8+bWDRxHI+Wqgi2ZUNpuB1Kl9oJr0LZHZO4cchWQnKkpLM3drdnpOxVA2GZULGWRFQRve3bWUq5gg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7qLWX18YCqXbfIbRjbed3Wm1+8OSuUz9gGycpLf/h4/fj9GV3
	mCm0e6dY2i7ePwFgzY8uuYyzZwP5kSQuhayARu18UUdbshUj8BbuuT+XoiLU8PL1UVdP1jYHqgz
	Zt/1BYA==
X-Received: from pgh1.prod.google.com ([2002:a05:6a02:4e01:b0:c79:8102:80bb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:184b:b0:366:479e:63a5
 with SMTP id 98e67ed59e1d1-36bbcc160f0mr4139147a91.2.1780067317529; Fri, 29
 May 2026 08:08:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 08:08:35 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150835.715093-1-seanjc@google.com>
Subject: [PATCH v4 47/47] x86/paravirt: Move using_native_sched_clock() stub
 into timer.h
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	"K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, David Woodhouse <dwmw@amazon.co.uk>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Now that timer.h ended up with CONFIG_PARAVIRT #ifdeffery anyways, move the
PARAVIRT=n using_native_sched_clock() stub into timer.h as a "free"
optimization.

No functional change intended.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/timer.h | 6 ++++--
 arch/x86/kernel/tsc.c        | 2 --
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/timer.h b/arch/x86/include/asm/timer.h
index ca5c95d48c03..a52388af6055 100644
--- a/arch/x86/include/asm/timer.h
+++ b/arch/x86/include/asm/timer.h
@@ -11,9 +11,9 @@ extern void recalibrate_cpu_khz(void);
 
 extern int no_timer_check;
 
-extern bool using_native_sched_clock(void);
-
 #ifdef CONFIG_PARAVIRT
+extern bool using_native_sched_clock(void);
+
 int __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
 				      void (*save)(void), void (*restore)(void));
 
@@ -23,6 +23,8 @@ static __always_inline void paravirt_set_sched_clock(u64 (*func)(void),
 {
 	(void)__paravirt_set_sched_clock(func, true, save, restore);
 }
+#else
+static inline bool using_native_sched_clock(void) { return true; }
 #endif
 
 /*
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 036916953f4a..159d7d060204 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -302,8 +302,6 @@ int __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
 }
 #else
 u64 sched_clock_noinstr(void) __attribute__((alias("native_sched_clock")));
-
-bool using_native_sched_clock(void) { return true; }
 #endif
 
 notrace u64 sched_clock(void)
-- 
2.54.0.823.g6e5bcc1fc9-goog

