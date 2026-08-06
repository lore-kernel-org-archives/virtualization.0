Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D4B4931E3
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 23:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059402; cv=none; b=mlCa73gZbUebcGO72sMlc/kwkF0/dM4Zfm0lQfS8ry2C/tqwNjIWFnTqXrpkDS7Q6bnN1HpDeQqg4WUFblB56WoTtSET9QUFhMvklIifwJIXW5hyVk67GgDLl1Vpw/rkHcEOXq85Iv5qQcbVDZelDu2EwYENgp2vzoHKTnQsAMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059402; c=relaxed/simple;
	bh=kNb3vvgtLbRH7N/DprLb1mmCclzI0d/ujF+Or08Q6XI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JTcQEnAAliVBzewLBAlalR7s+aOmBz6BFvQizZdqv6cCGe1vXSLA0uJWeRyjGsjQUockXeJnul56L26zR2ES4lf8YpxXaYzatoGat9RDt7FvEM25FAJJXJJzWwySUEesredGe+pYXfOOFr+Gf32WvEgeNtJaTNl+pO5e98R9xwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tuKPJtZO; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tuKPJtZO"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38dbf293831so5540927a91.3
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 16:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059399; x=1786664199; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yV4aOROKwLK4YUA2A0rPmI+8Xp1hkN/OxQzRiMqFKuI=;
        b=tuKPJtZO6lFMpZEiTzXQvrqCjdIyQ3CIMMRdie0BTu/LNLmje8YJVGIl37mgS1kmXD
         AN9bx0JvumhVIMCFJ1tn6Z+KzF2HvZck1isgum802Yaq//CEA13WG9BhgUgDzyrRxuwx
         TpT6WNTj1tRCy5QyA7VAST95b3/ExWuRgzIXulw/xwobWfD26V7Kwoa3dLSuNkrr/+u7
         6Kj7AK77XX2whNdnZx5zRjM/gDMGz/3SfvN2IqoMHYSt34yYgKL1T9iQT5AOZ0w4TBSR
         yXqA1Bhevp2KAIKoNEDs0mSFkeycU7Nf6yh4aV8WPhFC8lq78bErJWf4fanXWCGNHE04
         TMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059399; x=1786664199;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yV4aOROKwLK4YUA2A0rPmI+8Xp1hkN/OxQzRiMqFKuI=;
        b=Txdy9J92t/ug2UfwcAGa/jfCX3kTBOp+VRs/819tazKBB2VbiE8KDEtueKRGPcJmdz
         MEOZS0AYqlKx0yaTqQf0bN2M2+bc9kLCjvc9ieFh3jOnBl7BQ0WJ6mD9EMy0HKlGfznk
         XHC0y4FzZt3r+o7aeWeYGKynxbYvo8uZuZmbfmcyZ4UzLP+dvPhUNka92GO9TQinQXX2
         e/9TQaGyIzOq2XnQ83xUHCpo0+m0ADCAMEDxC8VaouiYQE58gmXUhFixNLiYe47Vnua1
         5MUeCgMo7vo8xmcqs79FSCYqaXJQ3OyXeOyYPXvqSymbCm9tj6EO9q44oNY/VL/gycwT
         CSnQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro70/WgMPU2sP2AXVzmP/XrL4z2ip9cUFclV9d0oLMc58X40KOqQ0G38fnOUFsEZv/afMmhe6PDOMOrEwFeHg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzFhfMF2WI76cuLnmwV8OKxstXkrTkQXF3vsgS9bhK/+24TSzAy
	/Rsod9GG5CJQWf6w4JnaJusoWXqHQ+vCN6D9LtORR+2z48m1tuMok3tD483QKVozLkhTxMVBbmv
	BVzDqVQ==
X-Received: from pjbqa7.prod.google.com ([2002:a17:90b:4fc7:b0:38e:bbd1:f3c8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:c88e:b0:38e:488f:7068
 with SMTP id 98e67ed59e1d1-3903c5373b4mr20563002a91.2.1786059398528; Thu, 06
 Aug 2026 16:36:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:29 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-13-seanjc@google.com>
Subject: [PATCH v6 12/51] x86/acrn: Register TSC/CPU frequency callbacks iff
 frequency is actually in CPUID
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

Register ACRN's TSC/CPU frequency overrides if and only if the exact TSC
frequency is actually provided in CPUID.  This will allow marking the TSC
as reliable as appropriate, and avoids relying on the caller to handle
"failure".

For all intents and purposes, no functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/acrn.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index ad8f2da8003b..dc71a6fdd461 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -19,6 +19,8 @@
 #include <asm/idtentry.h>
 #include <asm/irq_regs.h>
 
+static unsigned int acrn_tsc_khz_cpuid __initdata;
+
 static u32 __init acrn_detect(void)
 {
 	return acrn_cpuid_base();
@@ -26,13 +28,19 @@ static u32 __init acrn_detect(void)
 
 static unsigned int __init acrn_get_tsc_khz(void)
 {
-	return cpuid_eax(ACRN_CPUID_TIMING_INFO);
+	return acrn_tsc_khz_cpuid;
 }
 
 static void __init acrn_init_platform(void)
 {
 	/* Install system interrupt handler for ACRN hypervisor callback */
 	sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_acrn_hv_callback);
+
+	acrn_tsc_khz_cpuid = cpuid_eax(ACRN_CPUID_TIMING_INFO);
+	if (acrn_tsc_khz_cpuid) {
+		x86_init.hyper.get_tsc_khz = acrn_get_tsc_khz;
+		x86_init.hyper.get_cpu_khz = acrn_get_tsc_khz;
+	}
 }
 
 static bool acrn_x2apic_available(void)
@@ -80,6 +88,4 @@ const __initconst struct hypervisor_x86 x86_hyper_acrn = {
 	.type			= X86_HYPER_ACRN,
 	.init.init_platform     = acrn_init_platform,
 	.init.x2apic_available  = acrn_x2apic_available,
-	.init.get_tsc_khz	= acrn_get_tsc_khz,
-	.init.get_cpu_khz	= acrn_get_tsc_khz,
 };
-- 
2.55.0.679.g6767b8d81c-goog

