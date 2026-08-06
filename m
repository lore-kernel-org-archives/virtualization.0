Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C6848F839
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 23:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059410; cv=none; b=ZUvGz6XoS/1XCiQysX01PjV6lEZAtrLEjIFJxJOUP6eF4+idpvAkWMk0wxo+aGV5z1btykxK5ptJW1XqR3qSFic59IvtebWppdf0JogCUtILI0pX72YA53B+/vcZ5Lz+khRJKLxU3lO2XCKgYD7kZhr4gsOZi5YnLrZhRoDuvIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059410; c=relaxed/simple;
	bh=1uALf830n7JEUnTGzELSb3OUZCMrXoPiNs3kWl6RzcI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Glb6TLHEUDESbWZqELkYdlbL6OtejHFvqnv/ZKXDSW+i7BEVBnbEaW7IpkKS3pF2cM257OBg7bMCYUSAj6CPWnkQ20o5ppfGoMQYr1Kv+U5vG3D4TxKqDg9r85rBV8FhVba+984q5VTWr655t1pL1fhK8zsKmUUcsRGU8FMtwqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZcXME66R; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZcXME66R"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84865f326efso3250015b3a.0
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 16:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059406; x=1786664206; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bafmbn4x7WGy8QY/EzYypINgs3wQBC6UPHmanD+knFs=;
        b=ZcXME66RYM3dccIxJyFgQHxWm5xiLfdbtnRvL84ofMUCQmf+xiZRrigpX3OTT59hbl
         THsh2jvEq8VPtPqyGGtxpyrm4CxhJmNwX8NWwQ24UwM4bjTB5a4Dl7VRevh6c3iSsf+T
         RzZgzHIn/C0uzph1LKdAwASKvgv0xY+KIEB0JGaPTY6BOC6jLADIcXVgH7MvaxfPIi1f
         TUP2qI1lUITRhc7NkTP1kJab25fCyUgqxDuZfIiUoMFVwQEjDJX7+SsaV3/OCk5bc+Up
         h9zzrWTnmWoFPpZJRDusQiHF3G1KNIb62NMSnw6+FsZl7cjSQN2p8Ed0SKRCEkQszYOz
         OHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059406; x=1786664206;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bafmbn4x7WGy8QY/EzYypINgs3wQBC6UPHmanD+knFs=;
        b=jUH3bb29TMDsb/XDWxGCKRvH7sBKHXT2WvlRPvk3ZOiIV4lB9nxzkWh0zfOE4QfuRO
         XyAzn8MWVe4u4zGf9f6KXBErFDo08FhrOqUrRlM7Eh5dp/1/j0rpwAmld+ABIEFgwWxW
         Qi8DSP8oOo9q+Nk1Cq87Qv4qbFqwPrKc8EiW0kKFi0Yb/KsUryXooLiabYDQHlYxrEg3
         9BRKtCBoHvJbk6TxY6S3ObugNMnswN3n4ayt8pAJIy9Q6Hu4bc7mzGJu+kT6GAU2K5B2
         +po5w9wOpifjfqlciXW8z6zhE1RVBGvTwqFxmF+cS1MtzGIVeuVZi6Ga1A3SWsXc1RvH
         hxGA==
X-Forwarded-Encrypted: i=1; AHgh+Rop2yn9Qe8CmwukK4GZcSFP3Vmop/AxH00+3AN4/iniQ8SjCoMCMUZnHCpDOjU769IQvz68u774AlD8J2RCyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxxA2HnwlizKsjsfa0M94OZ2/QMjDP1WNPiYDI+8DNfkFqIZonH
	GehlM4uOIde5eo8EO1W2GePUg/OamJWcJm/Uypa97Pl0Vbplm1l1pe8PmFrTWuYtr1t3YnzPmYR
	CLre2wg==
X-Received: from pfks7.prod.google.com ([2002:a05:6a00:1947:b0:84e:2400:dc7d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:409b:b0:842:5b63:6112
 with SMTP id d2e1a72fcca58-84f2e12d036mr22581852b3a.32.1786059406261; Thu, 06
 Aug 2026 16:36:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:35 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-19-seanjc@google.com>
Subject: [PATCH v6 18/51] x86/kvmclock: Rename kvm_get_tsc_khz() to kvmclock_get_tsc_khz()
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

Rename kvm_get_tsc_khz() to kvmclock_get_tsc_khz() in anticipation of
adding support for getting TSC info from PV CPUID, i.e. in a KVM specific
way, but without non-kvmclock.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 35a879d33e9e..061a22d31dea 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -136,7 +136,7 @@ static inline void kvm_sched_clock_init(bool stable)
  * poll of guests can be running and trouble each other. So we preset
  * lpj here
  */
-static unsigned int __init kvm_get_tsc_khz(void)
+static unsigned int __init kvmclock_get_tsc_khz(void)
 {
 	return pvclock_tsc_khz(this_cpu_pvti());
 }
@@ -146,7 +146,7 @@ static void __init kvm_get_preset_lpj(void)
 	unsigned long khz;
 	u64 lpj;
 
-	khz = kvm_get_tsc_khz();
+	khz = kvmclock_get_tsc_khz();
 
 	lpj = ((u64)khz * 1000);
 	do_div(lpj, HZ);
@@ -342,8 +342,8 @@ void __init kvmclock_init(void)
 	flags = pvclock_read_flags(&hv_clock_boot[0].pvti);
 	kvm_sched_clock_init(flags & PVCLOCK_TSC_STABLE_BIT);
 
-	x86_init.hyper.get_tsc_khz = kvm_get_tsc_khz;
-	x86_init.hyper.get_cpu_khz = kvm_get_tsc_khz;
+	x86_init.hyper.get_tsc_khz = kvmclock_get_tsc_khz;
+	x86_init.hyper.get_cpu_khz = kvmclock_get_tsc_khz;
 	x86_platform.get_wallclock = kvm_get_wallclock;
 	x86_platform.set_wallclock = kvm_set_wallclock;
 #ifdef CONFIG_X86_LOCAL_APIC
-- 
2.55.0.679.g6767b8d81c-goog

