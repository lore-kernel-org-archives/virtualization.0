Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9519A4033EE
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 19:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872887; cv=none; b=eWFrB/NH2jL7BbeNuSHQA3oqENwv+vh08JYPqzxiuludQZkDfD55u3zfH+EhqLl5k1qu+5LM6OdkjT7TU+B+WQZ6Ef10OfcA8qXCy7Yh8Oj2IiTO5I1Q8RtibxN7gbmBzx+MhisF9f/edsLLeV3pzX7AqSxUyxy7/B6AiJbcFag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872887; c=relaxed/simple;
	bh=FAuTHtAqfIjKZiW/8ebxRcA6f3m9NrH7uZUAhFreD6g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PuIlwVv6hX/oQi6WJyvBrADZG+FXcqlLlyXmubstuCGds5v8Wjsr5GHF/ny9IOk3XnWkXnRqHgZC5kac5cfJrH4N8jCcjYRFK+ruRH5+NB97drO2cupXqtWF7URlypEz6+NXWF3YZKrv/hlSbPlvdEvfn/2AJZEm08LG9Q5Mzls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OWqnYwUS; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OWqnYwUS"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f85179263so251377b3a.3
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 12:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872883; x=1779477683; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=cGLSRPI8RMv865ATBw7wYYFL1PB8rGFTI0lK6a8u9vM=;
        b=OWqnYwUSIPkDidgdpKtbsb8QdVXf7a43pggK0aaFiMU6I+C4cERPOrvpFY7+1NpAVD
         A+DmYkqxZX/uKpNBWL+jYgkLE7VRPnElDdDRZDVMgTZRAzEun6IKirXqK6VRwgIPKmNf
         HhoSshFo1Ies7BmLlCoiVE02/0vtv7DMtUlQb9rjSIzvTkMlXf+OJXwr9CYABv6L4Zyc
         hhHrCDL6KwNn6/krLkf0If8ahOO8nbItW3CfMf7NbbIMbdwnsGlpQE8CROTpBouuul2N
         J9BFatk9tZEYV8mPAcviXUCEnaVCevwBJBBZOJGat96eG0hGl7f8VYMuno+0M6T007ve
         g1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872883; x=1779477683;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cGLSRPI8RMv865ATBw7wYYFL1PB8rGFTI0lK6a8u9vM=;
        b=KNgLETVaXYuWHs7lHMIY0iWNpjbXduDhUk/vgPK6spqiUG1ywOgLHQ19IYYEEtiI87
         wnq2SNQoiWDbd56Pj9+0lewEA4Q5JFb9nsQFt/ZoP3uDDVtwzwbs0JdQViRxX9MdcIfi
         SwGACRAJAdksL40kTrRo+Ed0+dxHBTr/BeDCv54mFkHeOHGdgxKwudkoEidXbF0qsoAM
         IepyZ7D8nVruS/OJ+uq78XA2cYzubppiLZ5436YQQdn7/US9XgNo2uktdaRBEwPtwp6W
         at02T+SWgoYCOjaWcJr0d7w+RxdWPy/FCSexNBDqCwgoiIwBuQh1Rr3GHW6e+DFoRcH6
         7Hsw==
X-Forwarded-Encrypted: i=1; AFNElJ9qdOj2heBmhsxZXArYk1ch/0FJb3aMWydpiB8A709v2Wk7AxRGGiKM3FSSLY5ZX71OjAyroOy8vEa0ELJpzQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7A16sBeeQQAlT8oZQPfDaJRJmUl4eiSalICvC4AfvOcS7mZpl
	wFyRmgagJtoK7gJ21lhrtgzfBd5V6CNRwS3Eg7EbK/G+O1z1rd8HkymdKVcXUmVDGs8iRjXIqnr
	2yV+hNA==
X-Received: from pfdc18.prod.google.com ([2002:aa7:8c12:0:b0:834:df9e:8e02])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:194f:b0:82f:355a:857e
 with SMTP id d2e1a72fcca58-83f33d0398emr5462972b3a.47.1778872883144; Fri, 15
 May 2026 12:21:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:41 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-41-seanjc@google.com>
Subject: [PATCH v3 40/41] x86/tsc: Add standalone helper for getting CPU
 frequency from CPUID
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

Extract the guts of cpu_khz_from_cpuid() to a standalone helper that
doesn't restrict the usage to Intel CPUs.  This will allow sharing the
core logic with kvmclock, as (a) CPUID.0x16 may be enumerated alongside
kvmclock, and (b) KVM generally doesn't restrict CPUID based on vendor.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/tsc.h |  1 +
 arch/x86/kernel/tsc.c      | 37 +++++++++++++++++++++++--------------
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index f458be688512..c145f5707b52 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -91,6 +91,7 @@ struct cpuid_tsc_info {
 };
 extern int cpuid_get_tsc_info(struct cpuid_tsc_info *info);
 extern int cpuid_get_tsc_freq(struct cpuid_tsc_info *info);
+extern int cpuid_get_cpu_freq(unsigned int *cpu_khz);
 
 extern void tsc_early_init(void);
 extern void tsc_init(void);
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 1b569954ae5e..745fa2052c74 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -719,6 +719,24 @@ int cpuid_get_tsc_freq(struct cpuid_tsc_info *info)
 	return 0;
 }
 
+int cpuid_get_cpu_freq(unsigned int *cpu_khz)
+{
+	unsigned int eax_base_mhz, ebx, ecx, edx;
+
+	*cpu_khz = 0;
+
+	if (boot_cpu_data.cpuid_level < CPUID_LEAF_FREQ)
+		return -ENOENT;
+
+	cpuid(CPUID_LEAF_FREQ, &eax_base_mhz, &ebx, &ecx, &edx);
+
+	if (!eax_base_mhz)
+		return -ENOENT;
+
+	*cpu_khz = eax_base_mhz * 1000;
+	return 0;
+}
+
 /**
  * native_calibrate_tsc - determine TSC frequency
  * Determine TSC frequency via CPUID, else return 0.
@@ -754,13 +772,8 @@ unsigned long native_calibrate_tsc(void)
 	 * clock, but we can easily calculate it to a high degree of accuracy
 	 * by considering the crystal ratio and the CPU speed.
 	 */
-	if (!info.crystal_khz && boot_cpu_data.cpuid_level >= CPUID_LEAF_FREQ) {
-		unsigned int eax_base_mhz, ebx, ecx, edx;
-
-		cpuid(CPUID_LEAF_FREQ, &eax_base_mhz, &ebx, &ecx, &edx);
-		info.crystal_khz = eax_base_mhz * 1000 *
-			info.denominator / info.numerator;
-	}
+	if (!info.crystal_khz && !cpuid_get_cpu_freq(&cpu_khz))
+		info.crystal_khz = cpu_khz * info.denominator / info.numerator;
 
 	if (!info.crystal_khz)
 		return 0;
@@ -787,19 +800,15 @@ unsigned long native_calibrate_tsc(void)
 
 static unsigned long cpu_khz_from_cpuid(void)
 {
-	unsigned int eax_base_mhz, ebx_max_mhz, ecx_bus_mhz, edx;
+	unsigned int cpu_khz;
 
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return 0;
 
-	if (boot_cpu_data.cpuid_level < CPUID_LEAF_FREQ)
+	if (cpuid_get_cpu_freq(&cpu_khz))
 		return 0;
 
-	eax_base_mhz = ebx_max_mhz = ecx_bus_mhz = edx = 0;
-
-	cpuid(CPUID_LEAF_FREQ, &eax_base_mhz, &ebx_max_mhz, &ecx_bus_mhz, &edx);
-
-	return eax_base_mhz * 1000;
+	return cpu_khz;
 }
 
 /*
-- 
2.54.0.563.g4f69b47b94-goog

