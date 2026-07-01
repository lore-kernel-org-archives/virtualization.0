Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E214F798F
	for <virtualization@lists.linux.dev>; Wed,  1 Jul 2026 19:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934378; cv=none; b=fCo9zLP+LIYFkvqSGwMobOUUFrzI+BbXm3X5XJBT/fQoYMs4R3vtEo4Jn1GyJ3QQrnuhsymLuqCD5jkqYcGmyd4fNS4Bd8qONE/t9LJxzaJXXsvWCDdIhwkvtG7Q7jrCz9ULiCEYkk7mPXCOH3oIbjitWvbn1m4OSIaXM5rM7R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934378; c=relaxed/simple;
	bh=9x/WoAyEJ+5eY0VNcPunpgzEF61GW0nMgcwZdXKTf70=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nX1EivFOAzfzaQu2Qc0PD7I04U8aMgsO/13Xj1+zIthUfNojMAFIYbw3DJaGFa9Cf+dlUMlv0qa22gyGWRQ/K1ipsZZI9tUmyqlZUjoYB73HxMSxhCz2V3YgF8Kt8Ehy6JgZKH94nLv9re/ekq3y2x7LridW/Mx0aBbH4gNb7Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uxaLrqAO; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uxaLrqAO"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c9d5a5b63c5so882755a12.1
        for <virtualization@lists.linux.dev>; Wed, 01 Jul 2026 12:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934374; x=1783539174; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=h0seWmgtqawiMKFH9SI3lPf42xnOLUsMbO7m+HkPiqQ=;
        b=uxaLrqAOjYKfAnb+JI8D8S9ihBlMdF3v+MIt8CRYrJLjJYlbLsR93x0Wk+UV2nszxk
         qEoC9XxxTYoqEyEZ/WJiY61A0VXmeMKCi0k2Q7SbAkfVnV2n6nqOcYBZeQIl6CzFn+TH
         CGvan01kxJIC74m12glcaTFx+2rp+rv8/Y+MnJvJoabKal7lAfiRlJpJv2Eten97D9wV
         NAUTof1yfzqUW6r3FaJodw+MQmDasdBXSXzugRZt7bgY/1omVcBAV/brubmNitvc/SM6
         Xi4WWzaY7SHW/Jga1ZRhIOoMAYqqWgVJUplEAy8TT1ZrjQo7zj5fEDB8KLk06xAfaXJh
         u7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934374; x=1783539174;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h0seWmgtqawiMKFH9SI3lPf42xnOLUsMbO7m+HkPiqQ=;
        b=POmAs2ofmHnG2G8VXuvzV0px/okdsM2KNSgSiV6t2aatSJ+KVQqKN3mo5uffZ2v5hV
         XyNyIbbcPj6ac78xTAyVcRtmTX504ucudd3fvMQ8bOFw1HcNXwQ390TwMIjfpj9Z2cP5
         R9cC0wYlcNMpBneK6LfrPBPMMKo0YMm85aYclH2N6ZCFqdOiGo04AcKnAPymBjRmS+TG
         WTXZ7Fbo9wbcFAqKPsBrTFKFnXwEKVCvlAbnHcIFIUg7IYqFQ4QKfoSRM2LMMusellV3
         l3BEGsLBwqgy3fHP2zyMA5Dg9jQWEvHGnELxM1Zec/6ok005Q+HpUcWmFoTKJ9K1ygH6
         XsUQ==
X-Forwarded-Encrypted: i=1; AHgh+RoERo4/smAuxgAY5sOioY7s041eRR4BHWaNruZNmUVkpIEErZ5QbwSqajhFrfSZWlPbxRYwI//FQaGXwKPDcg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFFA91uA4W3YGtMHI+xYjDrna6kYxc5RNZRuGw4oWqIvALnYk0
	Cr8QbWC/+yb3Ho/LIJ+i1Q7OEKfOwHFbGdwAlGXyGibHi6xuo+lHm1iBy26kMboQbjdnFttMZcO
	d7gLcJQ==
X-Received: from plll3.prod.google.com ([2002:a17:902:d043:b0:2c7:ed23:f47c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4cd:b0:2c8:1f58:55dd
 with SMTP id d9443c01a7336-2ca7e710f10mr31641185ad.9.1782934373673; Wed, 01
 Jul 2026 12:32:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:43 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-23-seanjc@google.com>
Subject: [PATCH v5 22/51] x86/kvm: Mark TSC as reliable when it's constant and nonstop
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

Mark the TSC as reliable if the hypervisor (KVM) has enumerated the TSC
as constant and nonstop.  Like most (all?) virtualization setups, any
secondary clocksource that's used as a watchdog is guaranteed to be less
reliable than a constant, nonstop TSC, as all clocksources the kernel uses
as a watchdog are all but guaranteed to be emulated when running as a KVM
guest.  I.e. any observed discrepancies between the TSC and watchdog will
be due to jitter in the watchdog.

This is especially true for KVM, as the watchdog clocksource is usually
emulated in host userspace, i.e. reading the clock incurs a roundtrip
cost of thousands of cycles.

Marking the TSC reliable addresses a flaw where the TSC will occasionally
be marked unstable if the host is under moderate/heavy load.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_para.h |  2 +-
 arch/x86/kernel/kvm.c           | 12 +++++++++++-
 arch/x86/kernel/kvmclock.c      | 14 +++++---------
 3 files changed, 17 insertions(+), 11 deletions(-)

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
index 909d3e5e5bcd..1cef54e1e7d9 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -978,6 +978,7 @@ static void __init kvm_init_platform(void)
 		.mask_hi = (BIT_ULL(boot_cpu_data.x86_phys_bits) - 1) >> 32,
 	};
 	u32 timing_info_leaf;
+	bool tsc_is_reliable;
 
 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
 	    kvm_para_has_feature(KVM_FEATURE_MIGRATION_CONTROL)) {
@@ -1040,7 +1041,16 @@ static void __init kvm_init_platform(void)
 		}
 	}
 
-	kvmclock_init();
+        /*
+         * If the TSC counts at a constant frequency across P/T states and in
+         * deep C-states, treat the TSC reliable, as guaranteed by KVM.
+         */
+	tsc_is_reliable = boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
+			  boot_cpu_has(X86_FEATURE_NONSTOP_TSC);
+	if (tsc_is_reliable)
+		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
+
+	kvmclock_init(tsc_is_reliable);
 	x86_platform.apic_post_init = kvm_apic_init;
 
 	/*
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index f55d0305d1f3..2e7ab54cb9dc 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -307,7 +307,7 @@ static int kvmclock_setup_percpu(unsigned int cpu)
 	return p ? 0 : -ENOMEM;
 }
 
-void __init kvmclock_init(void)
+void __init kvmclock_init(bool prefer_tsc)
 {
 	u8 flags;
 
@@ -356,15 +356,11 @@ void __init kvmclock_init(void)
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
-	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC))
+	if (prefer_tsc)
 		kvm_clock.rating = 299;
 
 	clocksource_register_hz(&kvm_clock, NSEC_PER_SEC);
-- 
2.55.0.rc0.799.gd6f94ed593-goog

