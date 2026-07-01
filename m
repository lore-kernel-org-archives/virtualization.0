Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D1C42C4B8
	for <virtualization@lists.linux.dev>; Wed,  1 Jul 2026 19:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934411; cv=none; b=GwgKham3TzF5kjGdt/7z+yHs8WAbLpnRMTSyKhyYuEw8dduY2r2OGGOINyujnWVFnbHa0EJ8R88atHqeRYScLKi8MuKEyYPLNxKEZmuHCj1GjDhqyH1LvcxC5zBZhPI9wcTX29ImAt5+BuERgK3qQ1x/etQhlw+12lePtE/sfeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934411; c=relaxed/simple;
	bh=eWWyL7UaDO+jO5zpybHvT2ywbxk2X6+2Y5u8hqaq4xo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BIvNJwmwoR5Uy2ClN/zNDAlH6sFM2U9+4ZgYeh9lCgiSdprBTcUO0oeYUSd0fReQ31kYYrw7SrGOXaC+NI2DwWsooCg6m46kVjM2Ep0l3tNjRnwPDblfQXEk+23fwJ5e8HMa7YPaM8RC7NU4ussp+waHoLZuAIjZlMPIUcGKihk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D1lJwJLE; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D1lJwJLE"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-37ffaca522dso716948a91.2
        for <virtualization@lists.linux.dev>; Wed, 01 Jul 2026 12:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934407; x=1783539207; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BBdglu7Hd/NWIo80QzRStfEHhLuTnQAY4zgBWN5WaBQ=;
        b=D1lJwJLE+Pj8h2fjTWNcl6auRv4Uia8mNG6JzESHj96qjZv5WShm1XdO6/9JAYVRtz
         2aF5uLjKiDJ3ldl9jdxwQPUEdSofEUq7aBhGmLDIs39+ks76QN4yAb1eMl1ydRCHPlDH
         95X2iXybMQf9hQTvVatjQe9euWAwpGfi1VOzVnxGbICdiPw5KgK40UE+fnOrlzv0dKky
         dXvMgypZxr9F1rMM9IXOOgMdV94AYsmTjvne8HEd3x5j4/ZMX2yjySjm4aCr/UzTUGhd
         bR87vkg83j7KG9LdvAuLHlKwO+Any0z5kk/TsS/kX4wp0b7mJcymOdsR3jtANVQufyyn
         xR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934407; x=1783539207;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BBdglu7Hd/NWIo80QzRStfEHhLuTnQAY4zgBWN5WaBQ=;
        b=ECH997eEuHpdj8jG+RniU/ROyvoIJus7gmlTEto9cols5ZZgzecu+MOy7cy1atzXS+
         KxDKiE6pX4cGRfdVQI7+W8POOV3FOVfOjjP5jApmByWBVDWwrWbJCUZNzulty/FVuZ1c
         vYXXOEPhbAA3/gwW13Q0jLMlPybZVA58fXhhfUz3Ly8DliMY0tC9xAikr9AROxD5Z0BB
         ScLh6ZEPInHu5HgO3onTf6n79bflCxk6y+NROfReidqqeeUnQ+uEVPJ/ESRm1GpAAxU0
         /A+qVehQHpLLuP82pm9MHeFIAqpXLFz+Fo/djo7Nr/t+yYwawb0C1JFsabSPU/MPWgKK
         h/8w==
X-Forwarded-Encrypted: i=1; AHgh+RqzH0evF/Fd+eX3kqtThmEGG3Adk3VH2Of7A4sdjn377rZGBBHI1FSI3wPppAIFROCSs8EWXI108LagBnhlIw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxHS9NjBI0QBt5loWDUNZkrTo1LJ5OQWwGP8vYeT43d9rH3ih30
	1WrrfVLE0KzdgpR3fu3IMIWuJrgBS9V2t9FaYYKcU1B3EmzZE+98m3rYKxstnHT9KeXLEOc07cC
	PRe0nBw==
X-Received: from pjbmt23.prod.google.com ([2002:a17:90b:2317:b0:380:79f2:a916])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3a47:b0:37e:2005:6507
 with SMTP id 98e67ed59e1d1-380ba84865cmr1899432a91.15.1782934406994; Wed, 01
 Jul 2026 12:33:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:32:11 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-51-seanjc@google.com>
Subject: [PATCH v5 50/51] x86/paravirt: Move using_native_sched_clock() stub
 into timer.h
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
index a146fc7b5e74..564be4faa5a0 100644
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
2.55.0.rc0.799.gd6f94ed593-goog

