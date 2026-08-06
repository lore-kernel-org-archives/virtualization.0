Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A840431A30
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 23:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059396; cv=none; b=gKftSGhJBz6VsPiOYYPU1BzWVEEJdUI7WyQ9jFyOSgeQp4hbiLqV4YgXVAlNZhEQKEuopdrZ8NXOsrkUXthr89ZVyVsV/MdkQw4waevIirDmbVMfHnJ3pgWVQ4Kzse7J6hACnhwUnwkwPXcg6EGGYT+zycPIi69TQeUa+xj1LsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059396; c=relaxed/simple;
	bh=Lm8aNsZHGOuUIlXcj3KgaJkbvcxgm3rvJuJfaBGztsM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i8WVl5yL2cpGNQoN3lHj7YLjA26DF5auRFIJBpJzpn0+H43nGR2HBm6rUOkOva+niVFmq0vw8KSpQWrx//DyAXPCGEq021ugZt5A0W7s0w9ieS6WyCdfCGMAsayT9c74t5NVmU/rv5dAHlQK02z1QRed3VJq7/hIFzej28VMgDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KSZanuwi; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KSZanuwi"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8484f26852dso3084109b3a.1
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 16:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059392; x=1786664192; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tcL8w1SVbwtFzoahyKqy3HGwkprj7A9nnDUrJsX64pM=;
        b=KSZanuwi0gHw8U+hp9HzfCuBntWZOTuY1cOpT14oIlJKBcZezChAdzVvRfCUzLDXLL
         eZqfId5Sf7WLLxiOS3GO4CXq1l7EekGBFqE/LWfTSv6m/Q2fkgfQhhqLnu/e5hAL6fNy
         HuYMlKU2gvS6Pk9p/KgYmIE/28fhSX46zT0Noa22co1GswS2aj8BkR8YEKpxd1tuJWiJ
         Grg+9P2OSFDTEfCL+ooZ6Br7bJ/Ovx6RfGAiwhUtS5hQwRxjA/eDW+zZ0dIBaYQEh00W
         lz1t3eEJP+Jl/SSUf14P2/UIZpP/qoHWJCs9DA6l4gk1vpa+fx+sxooI2lyqH/HLtODk
         j6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059392; x=1786664192;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tcL8w1SVbwtFzoahyKqy3HGwkprj7A9nnDUrJsX64pM=;
        b=JPdKB0QWL7NU1StSGY2sXypGD/5SlcL3jDEewgR41MLcuZ174Mvd0byLLbBLY7j+4v
         hzNx25vcn1b9jlPybr32HhkO06V2NrGQSyS3bkE1Jzl0DRsduqbtG2bx/CRxD/vhdU1C
         01S26hSKa9soBVkTY/wex+bTWZUrSkMYdBzuSN7SGVa7duOnXYh1GyyCwKh7MoAIM1fo
         MH9YL5Ya7Eo/3qndOb2Ez4iofBO1J97zBKjuZjIgFdQOaplkV2QgUucJ1ENExbBUSIK0
         Gm75CH7EIl4oU5KGAyXJtWPvjDLxhytgL7vzsXqHLf3Wwjo3txLRnmQduFmMbuNd6n0Q
         IoSA==
X-Forwarded-Encrypted: i=1; AHgh+RqkQX/OHT4Ru/jcMFT8A3HhzuAcrWwldh3DBgsdoOHOPTWo54G2Lp8rr5Uu9DI5OcPw4e90Hh9tCVpq0GLXGw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy8IX4YnfCRaJwYKxKiq5VoqtVt9dHyp5Nue7zmopGpbOqJnUqp
	bL/p6wTLR0fggQPlxWiZ1htN5bzffVg2DkTzkR8r5EslV+igB0mGlIQdYNLIuh1i1HrBS7y49vy
	Z5pt1fw==
X-Received: from pgmc14.prod.google.com ([2002:a63:1c4e:0:b0:cbb:8a1e:efa4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:10cd:b0:848:8445:6956
 with SMTP id d2e1a72fcca58-84f4fe9f90emr5350899b3a.18.1786059391731; Thu, 06
 Aug 2026 16:36:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:23 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-7-seanjc@google.com>
Subject: [PATCH v6 06/51] x86/sev: Don't override CPU frequency calibration
 for SNP's Secure TSC
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

Don't override the kernel's CPU frequency calibration routine when
registering SNP's Secure TSC calibration routine.  SNP (the architecture)
provides zero guarantees that the CPU runs at the same frequency as the
TSC.  The justification for clobbering the CPU routine was:

  Since the difference between CPU base and TSC frequency does not apply
  in this case, the same callback is being used.

but that's simply not true.  E.g. if APERF/MPERF is exposed to the VM, then
the CPU frequency absolutely does matter.

While relying on heuristics and/or the untrusted hypervisor to provide the
CPU frequency isn't ideal, it's at least not outright wrong.

Fixes: 73bbf3b0fbba ("x86/tsc: Init the TSC for Secure TSC guests")
Cc: Nikunj A Dadhania <nikunj@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/coco/sev/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index ed0ac52a765e..665de1aea0ee 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2046,7 +2046,6 @@ void __init snp_secure_tsc_init(void)
 
 	snp_tsc_freq_khz = SNP_SCALE_TSC_FREQ(tsc_freq_mhz * 1000, secrets->tsc_factor);
 
-	x86_platform.calibrate_cpu = securetsc_get_tsc_khz;
 	x86_platform.calibrate_tsc = securetsc_get_tsc_khz;
 
 	early_memunmap(mem, PAGE_SIZE);
-- 
2.55.0.679.g6767b8d81c-goog

