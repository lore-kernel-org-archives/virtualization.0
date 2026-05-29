Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E1E3FE654
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 14:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065917; cv=none; b=q70dc8BYFCkIjmh2XnnfN9YaWgRg2DusuTOULArHswbmMOx/MYJXd3WWCEOSVlHY7amZr5AZ+Wu0WWQulywBHYjohwxdfxh1CTbjGRkgsTanOZ4ziN1Lc0f+9z7/zW3V4eFLnMlP2tNfN37WGQku3xC46y5EjLS/H/WZ18ee2PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065917; c=relaxed/simple;
	bh=UUytjfT9SVOtFZ9usAuTuI+mwQ/wQQjELPCBSRuUOk4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gYgwV29hHC6u8G1c9vZJHNinwHKn/WfS1DKmvn/KSAFftYsMM5U2MtSRFcpT28iugeWfJ5C72oPcTExWu8YGYJA3AImX8CIubU7zk6wxfoSg1JHCKR/9dQIP2Qc0nAeniruIm9A1wNAloKucrSsipNH7eFGR9lQ+K6iBU+pjJXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TwPFmzAj; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TwPFmzAj"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bf1845bddfso12753525ad.1
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 07:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780065914; x=1780670714; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Xkng2ObvqyeOAHFFD1k5jEREhKyPX3M1bjFdIhQCaZo=;
        b=TwPFmzAjT1sqs+5Bqv4wHTT4aZdwms4ix1o+dfOTxqCDE9Ey8gWRDOdxPhSmz9Eikf
         b579Aut684RjUcIwS/jFt7JW+ciC7RIj4aCExzgQgBWth6Ln4MTgmp5ryMB9GkZbVFrD
         fuvM2CT93HRPElzwEiNfhBKjmPQVLPoSU2fw06NdSPpM88++37c4Lt0q8+JL3xj8hLUI
         ATa68eU+VwHi0IRh80nViRnpFOUa8ykcpH9W5U7rYjTpHgbTm5ZI52MscJY+lDmL37GD
         2Wwz3j8rxO9tGIITMLb67NNuqyyXuEk3y5pOxxi7LRa8H0pTZPxSXGEeCA1VAcdofsxa
         6j+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065914; x=1780670714;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xkng2ObvqyeOAHFFD1k5jEREhKyPX3M1bjFdIhQCaZo=;
        b=iHZvbvjFcmHSEmHqABwr4UuxWNYzEn3gRxog4TD8kA17u9HJCEgdvMOeCci4ia/zr8
         tjgSlx14QD+dOUHNGxN5N6sx3lGnOoLYFAjAU6Pj3b+szVfXz8pPGWLJ0290bJXFMLM5
         6viNb3sl7OO+gG3q4GvcLfDR0k3Vw6r5VXyobkz9iVTsUHZGvP/Uf9sm1ERvPmrs7NLo
         ZaEbio2O2d4XmsmQcQi/CroMTE/J8XW1IRrs1o2HW/qewJf0fXx/JBEfY1OccETdDLRo
         lMbIcAu4UFrd+xxN+9KzZHBTd3NBH2AW/ma7AARx0tw6m+UrIywhrJ/zueTZDvsG7qeJ
         0Kfw==
X-Forwarded-Encrypted: i=1; AFNElJ+k5VRmSU+A5nbsQL9J2E6P2lXZGR4/bSJMhyq/9fNhf86lefE7ztZJrtzBsdW7hyMxX/1m2Wm6p8fFotFCoA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywq0imb3xfsGM0iEzXaLwzY4THcEJu3gtMLI4pz95G9bVERz1G1
	wwMTXauRyYoGv0FAyWiDS4n5oyoVAA/FWmuvGoKROn/B0r94zFXGuqJqorx3ASQp7JwSABgsLze
	D1FBjzA==
X-Received: from plhl2.prod.google.com ([2002:a17:903:1202:b0:2b0:5b0d:f4db])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1508:b0:2bc:b141:8551
 with SMTP id d9443c01a7336-2bf36833ef4mr1185145ad.19.1780065913278; Fri, 29
 May 2026 07:45:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 07:44:05 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529144435.704127-19-seanjc@google.com>
Subject: [PATCH v4 18/47] x86/kvm: Get local APIC bus frequency from PV CPUID
 Timing Info
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

When running as a KVM guest with PV timing info provided by the host,
stuff the APIC timer period/frequency with the local APIC bus frequency
reported in CPUID.0x40000010.EBX instead of trying to calibrate/guess the
frequency.

Note, the unit of measurement for lapic_timer_period is "ticks per HZ", not
Khz.

See Documentation/virt/kvm/x86/cpuid.rst for details.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 4fe9c69bf40b..c1139182121d 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -977,6 +977,7 @@ static void __init kvm_init_platform(void)
 		.mask_lo = (u32)(~(SZ_4G - tolud - 1)) | MTRR_PHYSMASK_V,
 		.mask_hi = (BIT_ULL(boot_cpu_data.x86_phys_bits) - 1) >> 32,
 	};
+	u32 apic_khz __maybe_unused;
 	u32 timing_info_leaf;
 	bool tsc_is_reliable;
 
@@ -1039,6 +1040,13 @@ static void __init kvm_init_platform(void)
 			x86_init.hyper.get_tsc_khz = kvm_get_tsc_khz;
 			x86_init.hyper.get_cpu_khz = kvm_get_tsc_khz;
 		}
+
+#ifdef CONFIG_X86_LOCAL_APIC
+		/* The leaf also includes the local APIC bus/timer frequency.*/
+		apic_khz = cpuid_ebx(timing_info_leaf);
+		if (apic_khz)
+	               lapic_timer_period = apic_khz * 1000 / HZ;
+#endif
 	}
 
         /*
-- 
2.54.0.823.g6e5bcc1fc9-goog

