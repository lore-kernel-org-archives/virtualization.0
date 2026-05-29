Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBB33FD155
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065914; cv=none; b=k8btrXR5OfShc9UP0D3GYqF3qoKgXx/QN6u3vJ+ouKljM8rKJwifj3O26fCZPOWoi9wWRPIDPcBJJuXsVhMBoHLdzd8u6OmJmp5zTjXeulGuEEbHgTH4V54VuaW+4hfBFxACYq8m0TUqQ8SmEMqQzqyvK8fklw0z+0uistv/TwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065914; c=relaxed/simple;
	bh=aXPPNHBYalh8o5ZMSQ8rkjd5K0rcgTOVXnv3ZNuU6kE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ibB2jWH3pmE5k+JPOK2ZLyVT29Krjs8L8kJdkg2YFKfA96nQC8/mkZFtl+ESK8/XpvajloCnfMTgL8iI0hlNv5SaDSUMraVjUpS9kdpV+goTbiV5Ot/4HmTaGrSa8t/XvfCrI4n4A8uAKNtQjdEKCR5yJUmBtUvoIi+pN2lT+fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k7WOHZ8Z; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k7WOHZ8Z"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf0d79d41eso13249075ad.1
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 07:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780065912; x=1780670712; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=3J4tSt2+/CTMv4tcKt5oCpoZW7w+XDXf08twJvjnqkg=;
        b=k7WOHZ8ZuOBAf4KYUZlJkSrTaDJpQc2XSew9xLBggB+czCIcNC6JXR702t8+nfy0pc
         kr0srCwz5jJXa4tyrBScHvNq312ORG8XHn1miZEW9OWvg9A9N8lWnztBN44kvuuJBcBB
         rl23dGccxFhHk4buod95yBpxI1XBWayxSwQ7sKyJDsgrmT+CqmwvwEo51+mEGcgd/+dG
         AzjjbMpXx9iBXOsDBGdqP445QM+tu70PqaV4Pilws7FSXdf+DtC/8Jlbc0k3KuMOKMix
         leYiQr8duOrJqndX0juZnRKPIf219uTKXaBj7lWQ/t5phPCm1i88c/PUMF/RWRM60jL/
         voJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065912; x=1780670712;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3J4tSt2+/CTMv4tcKt5oCpoZW7w+XDXf08twJvjnqkg=;
        b=OGqDSpG/nWdj7y5inOhvNJiBcXVZWOXa0Lbrbn5f3PZXdP7d5GY0fphAwf9gRrmRRU
         ZCdOv1oZzLOBoN03mPzO6HJ7hJG0QC7gVptWhzMcMVuk1jt61YT6xpvkXaBdIFkBCYz1
         gVjodfjjV7+Hy1wiVLtAl8aKSMR3Wd/mIVcK3HisBoYWBHlws3vFaOW0WX5HfUKDxhxW
         kqprxmQCWvi3FCa4S+ZPKs9KN3Y/Rx41SixJrYB5qL/S61LUoDhLA24L/5S4yUnkRwNx
         angIYrAFxNBSS4okeNyPDzebrorpt50N7FB8eJixTOvfsHuZPvJMXHZ6owfWQoDY6ruu
         k+Lw==
X-Forwarded-Encrypted: i=1; AFNElJ+gGvRPoNgN5Asfblkn0f//xM64KkjZug0alUkYS2/jxB/k1ifYEdZw+bNLR0eWKrNyDSIjR3b/rDE18iJXOA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxTjzDe91qEjqVRuGQ0M80CDkRKFhdVDporNmqA0LDP5x9plHEm
	xFeSGuica13dJR3QnsGUksJLEBRtE8PzP35wlHva5UzGmO84XbCuYsDGl1JaytJSQbWiAwF1jsp
	jXTRYSw==
X-Received: from plbkk16.prod.google.com ([2002:a17:903:710:b0:2bf:222e:c947])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:15cf:b0:2b0:ac1e:9737
 with SMTP id d9443c01a7336-2bf367c2eb0mr1549335ad.12.1780065912148; Fri, 29
 May 2026 07:45:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 07:44:04 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529144435.704127-18-seanjc@google.com>
Subject: [PATCH v4 17/47] x86/kvm: Mark TSC as reliable when it's constant and nonstop
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
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

Mark the TSC as reliable if the hypervisor (KVM) has enumerated the TSC
as constant and nonstop, and the admin hasn't explicitly marked the TSC
as unstable.  Like most (all?) virtualization setups, any secondary
clocksource that's used as a watchdog is guaranteed to be less reliable
than a constant, nonstop TSC, as all clocksources the kernel uses as a
watchdog are all but guaranteed to be emulated when running as a KVM
guest.  I.e. any observed discrepancies between the TSC and watchdog will
be due to jitter in the watchdog.

This is especially true for KVM, as the watchdog clocksource is usually
emulated in host userspace, i.e. reading the clock incurs a roundtrip
cost of thousands of cycles.

Marking the TSC reliable addresses a flaw where the TSC will occasionally
be marked unstable if the host is under moderate/heavy load.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_para.h |  2 +-
 arch/x86/kernel/kvm.c           | 16 +++++++++++++++-
 arch/x86/kernel/kvmclock.c      | 15 +++++----------
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
index 4a47c16e2df8..4a49fc286b4c 100644
--- a/arch/x86/include/asm/kvm_para.h
+++ b/arch/x86/include/asm/kvm_para.h
@@ -118,7 +118,7 @@ static inline long kvm_sev_hypercall3(unsigned int nr, unsigned long p1,
 }
 
 #ifdef CONFIG_KVM_GUEST
-void kvmclock_init(void);
+void kvmclock_init(bool prefer_tsc);
 void kvmclock_disable(void);
 bool kvm_para_available(void);
 unsigned int kvm_arch_para_features(void);
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 909d3e5e5bcd..4fe9c69bf40b 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -978,6 +978,7 @@ static void __init kvm_init_platform(void)
 		.mask_hi = (BIT_ULL(boot_cpu_data.x86_phys_bits) - 1) >> 32,
 	};
 	u32 timing_info_leaf;
+	bool tsc_is_reliable;
 
 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
 	    kvm_para_has_feature(KVM_FEATURE_MIGRATION_CONTROL)) {
@@ -1040,7 +1041,20 @@ static void __init kvm_init_platform(void)
 		}
 	}
 
-	kvmclock_init();
+        /*
+         * If the TSC counts at a constant frequency across P/T states, counts
+         * in deep C-states, and the TSC hasn't been marked unstable, treat the
+         * TSC reliable, as guaranteed by KVM.  Note, the TSC unstable check
+         * exists purely to honor the TSC being marked unstable via command
+         * line, any runtime detection of an unstable will happen after this.
+         */
+	tsc_is_reliable = boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
+			  boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
+			  !check_tsc_unstable();
+	if (tsc_is_reliable)
+		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
+
+	kvmclock_init(tsc_is_reliable);
 	x86_platform.apic_post_init = kvm_apic_init;
 
 	/*
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 404f60741aa8..69a15fbfb779 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -285,7 +285,7 @@ static int kvmclock_setup_percpu(unsigned int cpu)
 	return p ? 0 : -ENOMEM;
 }
 
-void __init kvmclock_init(void)
+void __init kvmclock_init(bool prefer_tsc)
 {
 	u8 flags;
 
@@ -334,16 +334,11 @@ void __init kvmclock_init(void)
 	kvm_get_preset_lpj();
 
 	/*
-	 * X86_FEATURE_NONSTOP_TSC is TSC runs at constant rate
-	 * with P/T states and does not stop in deep C-states.
-	 *
-	 * Invariant TSC exposed by host means kvmclock is not necessary:
-	 * can use TSC as clocksource.
-	 *
+	 * If TSC is preferred over kvmlock, drop kvmclock's rating so that TSC
+	 * is chosen as the clocksource (but still register kvmclock in case
+	 * the kernel doesn't want to use TSC for whatever reason).
 	 */
-	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
-	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
-	    !check_tsc_unstable())
+	if (prefer_tsc)
 		kvm_clock.rating = 299;
 
 	clocksource_register_hz(&kvm_clock, NSEC_PER_SEC);
-- 
2.54.0.823.g6e5bcc1fc9-goog

