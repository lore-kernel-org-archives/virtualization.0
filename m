Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1175495028
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 23:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059406; cv=none; b=gQtcaua4fFV2FjWt7BP7JKrBib0rByotwXQLOl7j4XF+PTlOy0Vw6nHCNbDsTYtTNwz8q89rnGF4GfmJjBURPpLZTNuclp3HXSedJbbhUwPzHbVu2wJRCWNOCwL9fUsAxUH13kIVqWagThFs5GXHhJYQlQ2wSf4X3ueTSCUnjUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059406; c=relaxed/simple;
	bh=JVq3rGO4pg6RPeAnx1wMiHtknekbd2VNIRn3YGfu0ao=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NxVXnDDgBIIfGl/TsHgzmz4T44dC2+CCXyrIhGiHP/1pT5kz2V2qzKgwI+XHWzKyftgYK6gDnJUO+jOl1h8bIPkgnSWcQJyMZ1Bt8gwac+dQvfdBOeG7c9U92i6jzPRciOEeex0bQ4wkUCHwrw+87o2KCwKKSYJ+xRHlbpDqgQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Iym4Khdz; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iym4Khdz"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e475f83a2so4350209a91.1
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 16:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059404; x=1786664204; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VAfqOqpweyKvsFpq/agEYC9CEWnfcmlui4k8L8ZR5pE=;
        b=Iym4KhdzPxDstpv27JB6hVwd/FnA2NtnhehMxiqRn3ajo5nCYI85SWVuG8fcStu8Jv
         jHKPu1vjcagQoMON2YGks6w/UMJm0nvIEJYMJUESq0Hm3kt1sINDKnY5es+d3xXMJb6B
         fSECcuOzVouwx14AwinWzsJxjl7Jaui0sBF7UKYIkh7Rk2zDd79DJfzguIYEtgSbT8yP
         u+XQCnfr9zKLYJOOG+erTz0D3SWJGvx7jBRkg1yyxW8ZvQ/FvMY6Jqjrmu6AyKgRh0do
         cUjwQPkRh3YRzC+Ndydgu82Hd1ugnZbVtRxx90vZWiMyxcao9GeEw81FGx9DkcbsoI0N
         wLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059404; x=1786664204;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VAfqOqpweyKvsFpq/agEYC9CEWnfcmlui4k8L8ZR5pE=;
        b=EMMu4IGBxJ+xaku7GGX+ONaD2uPuxsvzLdZs69SiCharHwqduNU/ATyMO2ZOnXKAtU
         AnaI8wP/JRjGRSo94wmgnCFbFTtyVDyope46wyo7iJalZZh3lv0Tw4X+mDeKw5/nofhZ
         lnCp5OGoumEo/rReCcpAw1aiVZoCVrm1UJx6shiEi560JEQj6b8+NFnbN1XMqN0/vZkr
         Rj8bkjuUxlferdL/wCYskdn6x5cxi09uwB/t05GnYWWQifcXJdxJvkA+y6/qTyFq6VCY
         LzBm29o6YDwv2ad1sDaUrKmhGVgk/kXT0MnwGi0oYRCXATpO41pccEaPUGesgOMrjTgX
         p9FA==
X-Forwarded-Encrypted: i=1; AHgh+RqbwfVPZvq09Kr66EiTJcU4q26j06ZWcSQq5G0Qv9xYaJs1ifNTJgBKIoGXSvgVbZSGkAieom+PdX8UnDVLsQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXNB4g4Bk44tIDpSuK6AW1f5y+GSLESTIKxT3uCWdXXvKLY1LQ
	mC03TtaHkEiidqPN4FlrJY8TnBacgBVyRrMRai2ynGR92PGzx80+Vwl5w99hL9q7zAeJJIiaG/z
	hBiybvw==
X-Received: from pjbcu4.prod.google.com ([2002:a17:90a:fa84:b0:381:7fb0:5a60])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:288b:b0:38e:8300:af51
 with SMTP id 98e67ed59e1d1-3903c54d040mr19813478a91.8.1786059403683; Thu, 06
 Aug 2026 16:36:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:33 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-17-seanjc@google.com>
Subject: [PATCH v6 16/51] x86/tsc: Rename pit_hpet_ptimer_calibrate_cpu() => native_calibrate_cpu_late()
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

Rename the late CPU calibration routine so that its relationship to the
early routine is more obvious and intuitive.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/tsc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 1d41ef1db27c..dd9e04e325d6 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -752,7 +752,7 @@ static unsigned long cpu_khz_from_cpuid(void)
  * calibrate cpu using pit, hpet, and ptimer methods. They are available
  * later in boot after acpi is initialized.
  */
-static unsigned long pit_hpet_ptimer_calibrate_cpu(void)
+static unsigned long native_calibrate_cpu_late(void)
 {
 	u64 tsc1, tsc2, delta, ref1, ref2;
 	unsigned long tsc_pit_min = ULONG_MAX, tsc_ref_min = ULONG_MAX;
@@ -927,7 +927,7 @@ static unsigned long native_calibrate_cpu(void)
 	unsigned long tsc_freq = native_calibrate_cpu_early();
 
 	if (!tsc_freq)
-		tsc_freq = pit_hpet_ptimer_calibrate_cpu();
+		tsc_freq = native_calibrate_cpu_late();
 
 	return tsc_freq;
 }
@@ -1472,7 +1472,7 @@ static bool __init determine_cpu_tsc_frequencies(bool early,
 		else
 			tsc_khz = native_calibrate_tsc();
 	} else {
-		cpu_khz = pit_hpet_ptimer_calibrate_cpu();
+		cpu_khz = native_calibrate_cpu_late();
 	}
 
 	/*
-- 
2.55.0.679.g6767b8d81c-goog

