Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3011C49425B
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 23:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059408; cv=none; b=DAYTPyTcDJLJI6BrnmBfuvBvs3TXN4jdNqzRvrnGjCo4jGbHnvqFl+VfDPS3kGwanJkhiaNe/XNRZR0O78yYhApYNSe7QNmaC8hOpP2rXw8HpjcPOky/zeW6qdGg9bzpPSb12RapjfcJkBRcrQsi6MYn+3rCotm6Q6FUmPaSBXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059408; c=relaxed/simple;
	bh=zUwj/tUghTiTEVoKSWMsQNbnRAFLb6fHDZIqhxq4ECM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uuECdd9XNx8+559nZb/X8mFalesi0kdSxWXiubAPKp088cG3AcGKOpoBK924S25mVPkLu3VL6m0F+OdFDmQsSRmcs8SQT2y8iM25a6nXS3c54gmLdmDNXrx2hgU4rYPdY/rqdOb9/ALOUMgXYnuzOMrafvLUFhx9da+NX7W3i9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LWFbrg2W; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LWFbrg2W"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cea6a46766so46521985ad.0
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 16:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059405; x=1786664205; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=as+YzjPRM0DAZztxhbx3Raa/ax9+dW0ZzZ4Dw8q0B68=;
        b=LWFbrg2Wqxv/hhA3Mp/sVdBOLAAaG0T58DpQ6ynT+DP9OIVwDmYO0V7yUXTNkuoqFZ
         +Q2ml9efnuxL0W95XMFKi/XTEYcPI8oHhDTGfgVd5p+sKCWBmU7tA2HFBYd7k6P/cGY1
         +aKB4ICLTlCLXh3udiSaW5qgg5zFrzbZ3tIKDmQUhyI0DKOg+ApvUtcyyci7iH8ShzKg
         Suzjd23rr2OzxagtX4ToYvUWmYBiYIaV9T83geQDULcXGjTxcQGl+hdOvzxQXjnWvvmH
         14LHUvxRnBoSXABbnREJoLgOebyLKHAIBB48AZ1Dv6PDtHU99DGA8WDvYGgHZchg2Wfk
         rlew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059405; x=1786664205;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=as+YzjPRM0DAZztxhbx3Raa/ax9+dW0ZzZ4Dw8q0B68=;
        b=E+9C+k5AtH9vnGwRNBP4s0sk3FLA27alr6tv/DnR4qT8LuGLqkLXs4DXzIk57afCN/
         /3UuvwhHp2OSi09jgyPYHpz0emgEYJvr3sC10Q6AiZ4lphwPjVb/yyajAcMbJUii+Ym8
         42MntLhPie+CU6/KM0+BxpmsD8CSBEzi8MCDd3bLbno3+FM8vf5BlNv9CBvamvItUOgc
         rc52/Bpa3JG6iwb+3vE1vKfoIGEXexPlUoKUpOzS1AMbSgxTgOZ/qRXzCXVbvCjl10yS
         Cdq7nA54hDBkp3b9F6LKQjpFU9G4PBgWmF8enetDUkme6o6Re8gSDUmyzOcGBCUax7Nl
         nDQQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp7nVT3JZztStF7mHcqBU2EvAfglAFjidsRfhtoKzD+0Y/3MIZOjyNdlv61WetmZ04BlNLi/sGfunjCNYN0Jg==@lists.linux.dev
X-Gm-Message-State: AOJu0YydIIMEY12zjSYmW4R3L67qg+eDj/GuCY9XyUHl4Ij6OlfuVK5T
	9qRdt2YmUmbDGfbsaA9AL23fgFTKLdkHv6Fcc+dOVlTATtcnTvPBBkeBJskL8CkRPSLcaQWOq8/
	VEQIeTA==
X-Received: from plblh12.prod.google.com ([2002:a17:903:290c:b0:2cf:277e:c60c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f708:b0:2ba:6518:a6d4
 with SMTP id d9443c01a7336-2d0ca9624bdmr224800085ad.20.1786059405010; Thu, 06
 Aug 2026 16:36:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:34 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-18-seanjc@google.com>
Subject: [PATCH v6 17/51] x86/tsc: Fold native_calibrate_cpu() into recalibrate_cpu_khz()
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

Fold the guts of native_calibrate_cpu() into its sole remaining caller,
recalibrate_cpu_khz() to eliminate the extra SMP=n #ifdef, and so that it's
more obvious that directly invoking the early vs. late calibration routines
in determine_cpu_tsc_frequencies() is intentional.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/tsc.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index dd9e04e325d6..d95e4f059f17 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -918,21 +918,6 @@ static unsigned long native_calibrate_cpu_early(void)
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
@@ -944,7 +929,9 @@ void recalibrate_cpu_khz(void)
 	if (WARN_ON_ONCE(cpu_feature_enabled(X86_FEATURE_TSC_KNOWN_FREQ)))
 		return;
 
-	cpu_khz = native_calibrate_cpu();
+	cpu_khz = native_calibrate_cpu_early();
+	if (!cpu_khz)
+		cpu_khz = native_calibrate_cpu_late();
 	tsc_khz = native_calibrate_tsc();
 	if (tsc_khz == 0)
 		tsc_khz = cpu_khz;
-- 
2.55.0.679.g6767b8d81c-goog

