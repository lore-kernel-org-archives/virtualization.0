Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE46A3F4DE9
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 14:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065909; cv=none; b=K8o27+9ssLVTTtjsA0M88+H/Ltk1rCL7OxhVSmdqUljVox8WkfFOo6CzHISrm3XsupTcgneCDewUBF5yFQffIyxwI/bxOrd06wOPsc8hdaFgpCvUxMUYLCidWSzFMC0XnKbFdfpguwV6tqbUTbCMmM7xLfXND7DhzpeZpPi+oCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065909; c=relaxed/simple;
	bh=WHi2AWvhDQvTEIPut9U48s/z4C+6DTwQMXjBVRNgv1M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e6clWo/BTGUbl5CkUonFkuSuxVXN6Ne8jYTWHJIFTpYj5MLoIBgDnAPMrGulES0C7cqxEqUf5xhyMAETQkqQmNNtBfB1yaEs3QkVDUFh2sWcgiiTIEeSdFrRAKTByCUaOm6bI3XJ/XKEreZ0C/AY1Cvqi3OC1fQQr+cppgmEy9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Je/HJLQ3; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Je/HJLQ3"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso112501055ad.3
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 07:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780065907; x=1780670707; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=gZ7qyLV4Qg2/G7AZdfT7QLEMZtHiHfovzBdDbSmwy9M=;
        b=Je/HJLQ3IhgKTCCOQ7/VpHHcf5T1CJApFOr5fE13w7ejYrQvYwLbkAZ1I9tA5SFEvt
         1LauvrfehKe2o6B6ARdqW15wswY9z4I7wKxXETPNEQpu/54Gt99hiUBTNHQxXMDVOtdo
         DaIwLOmQBABvN4p5gedbqlpjhpQLNxPb6SmnPSkEGM1mYjIDrn5Kj/yyvujCELAP134Z
         JjrDh4isLI8zbeUghwfohMJEAu+hplw3Xh9G6uTfyDvmQDupnZXZeo6iZUWBUXmdvYJH
         EkI2OSOjaDfYrMGpStVdX2tci/ucZZOtj+btFcuRe0pfS9SXhYL1xkO6QXGDO/bhT0Q6
         IGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065907; x=1780670707;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gZ7qyLV4Qg2/G7AZdfT7QLEMZtHiHfovzBdDbSmwy9M=;
        b=VydAELWfoQquu9rQCCrGTemiyHFySvAvfSN1Q8lYVLotdZf2NZRtPC6VwMr8ets6hs
         Mkli1gxyIvtsAoK1z3z281/jIbh1/0MRBVGURnPw9hetXuQS+yalxjai4glHBGm7jkc2
         +On5zDc8mUfWN0hgzBxTWRpFVdVDlh1qfL3Kp8I40NfTjdSJKe6LaQd2y1L4r5GnZzo/
         FAlyP+NIEYh8BSSNE/lTLec6WNcqwEnN7mOANk47RFI8nM1Bt/DDReqtuPVG+qpIn2Cz
         FPDtkSewo3nD//a6ANLfDGTUdeuqlq+8da1JlfWOTB4paxhircO9cnkuRe6BdrHrHkpM
         iPag==
X-Forwarded-Encrypted: i=1; AFNElJ8JhlQwtevNC6T5vYb5MTe7p7vPAvA4Biv2jNcHqZ4PSXPQj+CyMEaTskWvTdnYp3HHZ0jJwCKuLEAER7Rijg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxSj7Pz4H3fJ+sH32nzxbfefH0U7VfLuhZUaR67DR4CsK2ZxxBy
	15zzQtns8ye/y0MnbQK5cuNGxjd0/nLggxVl2D9EzJ8AFY3XMZUwe5pMHopPYDR4yFsiEelLFPY
	fBsszmA==
X-Received: from plblk13.prod.google.com ([2002:a17:903:8cd:b0:2bf:1cdf:9e4b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f785:b0:2bf:b17:ae3c
 with SMTP id d9443c01a7336-2bf3684e2c2mr1144355ad.25.1780065906739; Fri, 29
 May 2026 07:45:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 07:44:00 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529144435.704127-14-seanjc@google.com>
Subject: [PATCH v4 13/47] x86/tsc: Fold native_calibrate_cpu() into recalibrate_cpu_khz()
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

Fold the guts of native_calibrate_cpu() into its sole remaining caller,
recalibrate_cpu_khz() to eliminate the extra SMP=n #ifdef, and so that it's
more obvious that directly invoking the early vs. late calibration routines
in determine_cpu_tsc_frequencies() is intentional.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/tsc.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 534462c81c78..3e911f0f7364 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -945,21 +945,6 @@ static unsigned long native_calibrate_cpu_early(void)
 	return fast_calibrate;
 }
 
-#ifndef CONFIG_SMP
-/**
- * native_calibrate_cpu - calibrate the cpu
- */
-static unsigned long native_calibrate_cpu(void)
-{
-	unsigned long tsc_freq = native_calibrate_cpu_early();
-
-	if (!tsc_freq)
-		tsc_freq = native_calibrate_cpu_late();
-
-	return tsc_freq;
-}
-#endif
-
 void recalibrate_cpu_khz(void)
 {
 #ifndef CONFIG_SMP
@@ -968,7 +953,10 @@ void recalibrate_cpu_khz(void)
 	if (!boot_cpu_has(X86_FEATURE_TSC))
 		return;
 
-	cpu_khz = native_calibrate_cpu();
+	cpu_khz = native_calibrate_cpu_early();
+	if (!cpu_khz)
+		cpu_khz = native_calibrate_cpu_late();
+
 	if (!boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ))
 		tsc_khz = native_calibrate_tsc();
 	if (tsc_khz == 0)
-- 
2.54.0.823.g6e5bcc1fc9-goog

