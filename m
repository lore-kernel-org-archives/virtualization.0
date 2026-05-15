Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA3D40F6EE
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 19:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872880; cv=none; b=ZDHCSH4F2w6QVbBElTJ1yzd7hBg0iDOod2cSHtIcfi7MWo8UHbiPx15WC29fIu3b+GdBBBlBV7Hwu2zvF3KP39Q2aZve34H0nEEsu8XjEq3IUH6NrbjNwKnhpeso4mlNnzaoLeuLoLVKALZc9zFNI2NaYqjGGPXFyXkkFHy6f/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872880; c=relaxed/simple;
	bh=m/luZgSg5MFPZdvcg1lGftNBA8eVB0LHHzknRLffplY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d1LfhKDPGVoDRu6E4NXdQIPW9Wcpvfk4+GbIHQlSOhR/mVqtRKDF5TwrNeznKEIkv6ApuYB/5PqhDwqZq6FIdFwfRJ7GwYkWcff5WnIijukV42sZqlKd4tLRZgMXDZoFtC9aaH1IVXa/R1eThgAbzFMfVZO1w+Y8uXdwjimkIXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FDvVzU/G; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FDvVzU/G"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82fa7c6699fso329533b3a.1
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 12:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872877; x=1779477677; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=E3je6rXVDqS2RblPlDEIDkn7XwnxqvqokNa5l9m4jL4=;
        b=FDvVzU/GlGwaJyT7w2Na9lZ9Yp086p8+cqdxHpTt8VLzagtjez0EB99v7K6Q4EsN//
         0Fl5AvKfv8ZVx4s8CGxLnZwyDY1kXzHBwPzFkcUgBlgqIlSN4Qs7AIX1K6k1hig1DIBB
         03GyoNAu7Q6GonpZX8bJXZ/hKNspWyVOMBLZhOGwNHLp6sXibZDkGZ0OFArK5qFTkIOX
         2VgV0fKdq39A3GLg8urJWBlnt+UMEMEhCRmiP5uBqnip9Q3G08AlDMdknON/lWZmjQof
         sud6cwC5u0YfkBWJeOQ5/0riTUn8f7cU9Lc97AfvSJCKFc2XxNch9DYa9a2iz+22wyJa
         c9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872877; x=1779477677;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E3je6rXVDqS2RblPlDEIDkn7XwnxqvqokNa5l9m4jL4=;
        b=VxR7dZ+cJiKPjj+vwk1quhez+fFJEmOeEuGvyLeuqGJCDFKen3bQQ7RqNtEhJwmpWY
         98uMMrOemcAwthCivXV+CVTewKO7pOuyBUu+oGlLaoPY71g1N9qoewwz73egvevVnmD4
         JuqpRQmvZLSnVsypES/9PT/vRBR3XsVMbIrw5bUTlANhtSO79BoaW6aDqV0m8cQk7474
         oa3LLWh8fL3zBAmDRh01K3jT4CEvKyBz+lWkrjkv5tbVUwg45kG37dLKrrAZgew2oGwg
         XHFniDcBrxqok2mPmfemUYvW0+VtAnhdgS5au83EBT0RLmrERx5gyc8MDTD6Kn02+Kua
         qwPw==
X-Forwarded-Encrypted: i=1; AFNElJ9VuSEGxiwu2XcSET1YLbIcDPObSIlSlVH6c37D9ARK05927ekP79nY90XI/4FoWc/AmNuzJcI8ajZPHOH6Fw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyWZ00MXlteBDvCu6uuvrCelasN0jRuBbnFuS0ObuRn0PL6bYMw
	/8tLcGukfwb2ZxxwZHHayrTe3DRBM8OOiqsZRvCKF0HUFWXByloRBPPGPUjbNyziaag5mct+gfB
	wdVF7NA==
X-Received: from pfbmd16.prod.google.com ([2002:a05:6a00:7710:b0:82f:c134:e67c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:8d1:b0:82c:6aee:b21a
 with SMTP id d2e1a72fcca58-83f33f2a54fmr5839384b3a.45.1778872876956; Fri, 15
 May 2026 12:21:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:38 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-38-seanjc@google.com>
Subject: [PATCH v3 37/41] x86/kvmclock: Use TSC for sched_clock if it's
 constant and non-stop
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

Prefer the TSC over kvmclock for sched_clock if the TSC is constant,
nonstop, and not marked unstable via command line.  I.e. use the same
criteria as tweaking the clocksource rating so that TSC is preferred over
kvmclock.  Per the below comment from native_sched_clock(), sched_clock
is more tolerant of slop than clocksource; using TSC for clocksource but
not sched_clock makes little to no sense, especially now that KVM CoCo
guests with a trusted TSC use TSC, not kvmclock.

        /*
         * Fall back to jiffies if there's no TSC available:
         * ( But note that we still use it if the TSC is marked
         *   unstable. We do this because unlike Time Of Day,
         *   the scheduler clock tolerates small errors and it's
         *   very important for it to be as fast as the platform
         *   can achieve it. )
         */

The only advantage of using kvmclock is that doing so allows for early
and common detection of PVCLOCK_GUEST_STOPPED, but that code has been
broken for over two years with nary a complaint, i.e. it can't be
_that_ valuable.  And as above, certain types of KVM guests are losing
the functionality regardless, i.e. acknowledging PVCLOCK_GUEST_STOPPED
needs to be decoupled from sched_clock() no matter what.

Link: https://lore.kernel.org/all/Z4hDK27OV7wK572A@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index abcc5b36ea1d..0578bc448b1b 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -416,22 +416,22 @@ void __init kvmclock_init(void)
 	}
 
 	/*
-	 * X86_FEATURE_NONSTOP_TSC is TSC runs at constant rate
-	 * with P/T states and does not stop in deep C-states.
-	 *
-	 * Invariant TSC exposed by host means kvmclock is not necessary:
-	 * can use TSC as clocksource.
-	 *
+	 * If the TSC counts at a constant frequency across P/T states, counts
+	 * in deep C-states, and the TSC hasn't been marked unstable, prefer
+	 * the TSC over kvmclock for sched_clock and drop kvmclock's rating so
+	 * that TSC is chosen as the clocksource.  Note, the TSC unstable check
+	 * exists purely to honor the TSC being marked unstable via command
+	 * line, any runtime detection of an unstable will happen after this.
 	 */
 	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
 	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
 	    !check_tsc_unstable()) {
 		kvm_clock.rating = 299;
 		tsc_properties = TSC_FREQ_KNOWN_AND_RELIABLE;
+	} else {
+		kvm_sched_clock_init(stable);
 	}
 
-	kvm_sched_clock_init(stable);
-
 	tsc_register_calibration_routines(kvm_get_tsc_khz, kvm_get_tsc_khz,
 					  tsc_properties);
 
-- 
2.54.0.563.g4f69b47b94-goog

