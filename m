Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5056C1C07C4
	for <virtualization@lists.linux.dev>; Sat,  1 Feb 2025 02:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738376273; cv=none; b=q/5e+kQH4sZtOTtXuQMLHsYFYo4TpdVhUevgdKcztPbJBSINfs/t8SB6FRlb0bQOI9FqLF3ZU54dxM9wEZKJywOKgdxvx8pvq62tZYGOJLmnECQkGMOKjvHA7X6/blyn+5+bWWlc90/eRFFQNVaXH5SxbDnCxTNWNYnZKVzAVXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738376273; c=relaxed/simple;
	bh=OViTJZ+XBu7MgZ7inPoS/83nOvRpwHQF3rmoy13X/Q4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fRBCpBC/4O7lSVAtAp4fu6IOugC1sEKxt7lwfZwha3fICtWHZ5b6KZIMBN1/salMXXbzDFMW4+ZaY29DOej/kwAq9InqxzipEUJ/sdSurHx/lhYlwj86ByDerigazl2uT2k0yLfK1Qu0uOY0jHTlUvo804LjgoKNflONTDSEnCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KM9VwPad; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KM9VwPad"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2efa74481fdso5200764a91.1
        for <virtualization@lists.linux.dev>; Fri, 31 Jan 2025 18:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738376272; x=1738981072; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=H8aoO3CAJ0dqDpElLUQaiYDlNJUSBbklsVcflcMYifM=;
        b=KM9VwPad73rtDQQP1BAJ7Jtd4JNcrp/H6LHDz1TWIPoPVJHOqyMHktt0+n48C3a4+o
         2IqsOZ/d5s3Ul3XYbCYrCtdLfCeFVW4MwgzUsTwy5MwnP2ZjavPm9fVRajyzRQN7Ks27
         T/pbNkoPuHHI816Mz23HBFpvSayQWA/OUoisNHqrvN/Utos6YYR3pVLs5bp+2bDmrHGw
         EmF6JKk+tPVUafxq66/iD5GSgzDshCK8kNywHFGqmIzTJ3k83afYRnUTyIQHxxh6z3am
         jH48LOJT4u+h7md+srqI+mBiYdGa1uLdQQCfwU9sXy1aIdPEqksapsPk3G3ucZFuypjj
         t6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738376272; x=1738981072;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H8aoO3CAJ0dqDpElLUQaiYDlNJUSBbklsVcflcMYifM=;
        b=SH92r0Jc9ag293R8HeIULCrk+xjIlFu0I47bNbLviJMg1kRxo7H9yn4nNO5mqhkBRe
         Dy3vTdRHov9UltLmI82Ffr/KW/9g6ZabFnUViLKNc/tWyx8Jx6jrWaaCY3FIvNQFmywl
         DtXbUyZT2ipczUMJcvlE1/oR6iPQaAUrQv49GH72h3HJyZASrMY5n6bDFm0ueLXOWuXz
         jonEAavDoOay1s3lV0JpoZGyV73NnAvgQLlB72JHJC4U0+lcxVIOtCUbS2/KR/J9QT4m
         uwog2p9A/Ly5gd56uISyfGQj1AxpprMgkqVrSzgf2KyCqxXXy4nR4eB3mgv/T9P4o8ge
         gwBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXam4CRk6PlVlQVhh6M20pnZDf/HVGp2PMW9jzlYa2Mh05wpzakrzF5jY9YQ7B2cyCb/fl93h/zwbcBRAxtbw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWC8y/UA6o6U/KUqhexT3kp+/lLQimiQ11uyVHvWXdo9HTuj+4
	dNe7Xi6O/PqE438TNzB52fSZVgAxnBbHO2Nqp6Jmroc9Itju80ZdJ1KCTYI8aQf4Fh12xpZd3U2
	YUg==
X-Google-Smtp-Source: AGHT+IFlM5iy+/YhDLhDvbxJ2kgMrd1qTg/6Z4sP06sibC0sgnf3CqMto9NWjotO4O8YEuu2B+OhUgsrUhU=
X-Received: from pjbsw14.prod.google.com ([2002:a17:90b:2c8e:b0:2f7:d453:e587])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d45:b0:2ee:8358:385
 with SMTP id 98e67ed59e1d1-2f83abb34bfmr19091952a91.4.1738376271854; Fri, 31
 Jan 2025 18:17:51 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jan 2025 18:17:16 -0800
In-Reply-To: <20250201021718.699411-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250201021718.699411-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250201021718.699411-15-seanjc@google.com>
Subject: [PATCH 14/16] x86/kvmclock: Get TSC frequency from CPUID when its available
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Juergen Gross <jgross@suse.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Alexey Makhalov <alexey.amakhalov@broadcom.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-hyperv@vger.kernel.org, 
	jailhouse-dev@googlegroups.com, kvm@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Sean Christopherson <seanjc@google.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

When kvmclock and CPUID.0x15 are both present, use the TSC frequency from
CPUID.0x15 instead of kvmclock's frequency.  Barring a misconfigured
setup, both sources should provide the same frequency, CPUID.0x15 is
arguably a better source when using the TSC over kvmclock, and most
importantly, using CPUID.0x15 will allow stuffing the local APIC timer
frequency based on the core crystal frequency, i.e. will allow skipping
APIC timer calibration.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 66e53b15dd1d..0ec867807b84 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -102,6 +102,16 @@ static inline void kvm_sched_clock_init(bool stable)
 		sizeof(((struct pvclock_vcpu_time_info *)NULL)->system_time));
 }
 
+static unsigned long kvm_get_tsc_khz(void)
+{
+	unsigned int __tsc_khz, crystal_khz;
+
+	if (!cpuid_get_tsc_freq(&__tsc_khz, &crystal_khz))
+		return __tsc_khz;
+
+	return pvclock_tsc_khz(this_cpu_pvti());
+}
+
 static unsigned long kvm_get_cpu_khz(void)
 {
 	unsigned int cpu_khz;
@@ -125,11 +135,6 @@ static unsigned long kvm_get_cpu_khz(void)
  * poll of guests can be running and trouble each other. So we preset
  * lpj here
  */
-static unsigned long kvm_get_tsc_khz(void)
-{
-	return pvclock_tsc_khz(this_cpu_pvti());
-}
-
 static void __init kvm_get_preset_lpj(void)
 {
 	unsigned long khz;
-- 
2.48.1.362.g079036d154-goog

