Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0D04A1C8E
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 23:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059415; cv=none; b=J30sYIk82JZHriSq36ZlJyoK04QpBvIhrO7sv9iKKGp0vkm55IvXDWLLKaWuhx93rUWSgLT23Ab0Kt8UaROxElqOWLqeFjwjN/D4+JIMStp1WMcJDPUAA7AzT+z76Dq/lkEGt+Vi1sVddB06lvuxXn5RRFLz8Mx1QWDAZVOlEFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059415; c=relaxed/simple;
	bh=d2IlR+xJ3s7i3winERsl12oMi29cZLvPJvIMStFX9r4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XJpyH5j9qyAorc6MsNgWroBh4UPB1cUY73UjZk9qoa76y0jYgl3eZ9p1vxsP8eLaxqKvvAJqPgHY8oUtcXui40UxqWYRSo8pWe1GiGuHqf9KhiHB2rdY0dHP63pVFkpXLyYJA3JOjvjguA8LTCaFWrb0gRXu2Gi74BI1eshVe+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tlpT86MF; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tlpT86MF"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38dd87656d3so3225321a91.2
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 16:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059412; x=1786664212; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9lHEbI53WDwynue0wsp+pOzdIE1KL/OlJm0qjHY+exI=;
        b=tlpT86MFp0MA4GJes6IchBBcTGlNA6zpFTdXf9TjcUnVC+Zsne4jBqqU7yT0n5FqIH
         XhTal7YiO4M51NCYDru4v+W2+n027WNNHRH+PYu7PwbTMZwUbF27GGW0uOn744+Xopk/
         70fUBvUSdGoq7AL7N+HuOsE24KeSEHzp5ouNNyjSRdzX2HtWZfv4xBqag7iaXV3bdAy7
         cZYJolAuwP1rZLsZhODHmMPoI5f0RgxKKSsDAl5ghpl5T+9ZV23hBUgZO9fYIlTJfERN
         u58fr+wTY1geuDbWg1ZmmQR+EHkgwNBv+eQLQCPVxfCnUR2fG0BD7dh1I60NVYdLxQq4
         rG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059412; x=1786664212;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9lHEbI53WDwynue0wsp+pOzdIE1KL/OlJm0qjHY+exI=;
        b=c/dnmW43jxM/1r5wKTe7MK/+hnyVqxyFGn5m8rfP+7ndKsdDBodOFJUnYAULBdsxxw
         C9D3f2vdusvgDJ+KTd2ezxpdlcpfuw8E7lZribYAc54XhICc3SP411yMjgXzwwTU80I/
         bmOJX6o4mSE9NpjzR9/PBbj5Yqug9L4twPBwzFRMNzhDfwVM/6xbscTVjPW6JMtqTHqw
         qPZe5xCa2dqe3PB/lboNTeMlGFXu3r4JDlQDU/Zd0+rijjEe+wr3AuT35VdcjYkSsPll
         mgx8QpLyIgT5cPJVBSLMD35LIvmtm1sFYhTvVKzCZSTgfqnkWLvjcI72ByYosXUahzZ9
         lhCw==
X-Forwarded-Encrypted: i=1; AHgh+Rr7FZNAl/lKYgOxGwcCWCQXeosPaDirajwUNkwKCzRA1L0uwbauePxZcRr1+j+JKJvmgfFRnS3qsqzY+vPoAg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwMte8Gb4m1Iryj/LlveFLhdfAqR26wYZmIPjFw22R8SHRfHljC
	O2MlR7KjaO16aWQGcQAc1i5mYaL+RwQyt8QNnxZ13RUx0Nk/+foMG6Y/TL/pv8VI7PCqqCdMV/X
	4Oneitw==
X-Received: from plpn24.prod.google.com ([2002:a17:902:9698:b0:2cc:ae2b:c324])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3d0d:b0:2d0:4021:bb6b
 with SMTP id d9443c01a7336-2d0ca15c87amr222771235ad.0.1786059411603; Thu, 06
 Aug 2026 16:36:51 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:39 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-23-seanjc@google.com>
Subject: [PATCH v6 22/51] x86/kvm: Mark TSC as reliable when it's constant and nonstop
From: Sean Christopherson <seanjc@google.com>
To: Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, 
	Miroslav Lichvar <mlichvar@redhat.com>, x86@kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, David Woodhouse <dwmw2@infradead.org>, 
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
index 8ed02f4f5775..255a24a99f28 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -980,6 +980,7 @@ static void __init kvm_init_platform(void)
 		.mask_hi = (BIT_ULL(boot_cpu_data.x86_phys_bits) - 1) >> 32,
 	};
 	u32 timing_info_leaf;
+	bool tsc_is_reliable;
 
 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
 	    kvm_para_has_feature(KVM_FEATURE_MIGRATION_CONTROL)) {
@@ -1042,7 +1043,16 @@ static void __init kvm_init_platform(void)
 		}
 	}
 
-	kvmclock_init();
+	/*
+	 * If the TSC counts at a constant frequency across P/T states and in
+	 * deep C-states, treat the TSC reliable, as guaranteed by KVM.
+	 */
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
2.55.0.679.g6767b8d81c-goog

