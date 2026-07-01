Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235DB4DC541
	for <virtualization@lists.linux.dev>; Wed,  1 Jul 2026 19:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934371; cv=none; b=WNFOFKSOvZBTOWZpbISip4+/fA1xVmSwlkQCRy2ogUBcPI5THoof7zwb3er2oWeAh1uCGFr0Ys8rVLo0wuS2obo4cnLJFXqEu8d5EsFZXE7ty1JPn5bQ4ISFsWKshzEmOz+HCyh/dCcGdzq0ABQcNyqrR+HfB1vaaAaPBPOm4Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934371; c=relaxed/simple;
	bh=bCu106G3ke2QslwQjzoF0iFGAeRR147Dfw14C3mfIq8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xe8GjAuxKLcxw9i97F0eYWOXD1As3a/ObwqqjFtliMFoJAUg0eCA3+3JVXXmRJQwYYP3Y8cHDyZAeONy4cQ9vcH87oGj8TkPMbwJVR/DVhKeE6Yogxvy8CuT8wbD54RKL1sIoN3S6URZ2XJ7d//+jOP10iM+ohOURF4hm1sZP88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bhQlx6hR; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bhQlx6hR"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-37fe90ee192so1185013a91.3
        for <virtualization@lists.linux.dev>; Wed, 01 Jul 2026 12:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934367; x=1783539167; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=wWnD58giubyrEvhTS3JtzvsAOScPFFHLvCt5ZIn12HI=;
        b=bhQlx6hRLHODWHHELAfSRa/zzqcDypjiBwQmedN7nRRg5CDeBkRcNjfDniuPBi3b5O
         lZr0hrM3fPOcCDLHBzJ0HJfP6XIflDEcUdKUfmDlb2q65KfX9JBHx12/ag95DOTN3TEH
         b1LAkPV8CcEMw0TqAyTX9cfrbFEDB2IvVVxQ0XAHKrMnM458pMXMy3qUUDjXMmf3Mqhf
         IbleEIMWO6eiBC/8sFwA3/qTPFuLS/wVvWoWvOPkSAX0pek1ycqC6g5Xu4GQsRbX/hvC
         mItbigWOsPyGXhwgbrzLeJA5dLzxWUy/UZYXOGvKutKpXmUiUvq2R+D41SKIAT6GooIz
         p1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934367; x=1783539167;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wWnD58giubyrEvhTS3JtzvsAOScPFFHLvCt5ZIn12HI=;
        b=LHpLPrIbETstyVoincoFPCDmVAGMUQhSFYEVPZUWoosmq/xF/kNnjblLwUrubrEHkH
         25WMUU2dp8MLOlmTMaTVNxEtqmbob5j2uILm2rDBFPaUgMfEv+a5uE6e30Ky5+rJc5yj
         MZjSqy86HoMIZFwd4QVfdFu2EWvRRl501Q7xwMmP9whmf1wvNttVutsXoO0msQbq//ry
         11qu+H6Um8Jfoy/Wr0avans48Bwk+Shtul8Wq09g8zYiqMXpuHBrozGxQ3EkAJFC7Bzo
         1O0ameDpY+lKdyZisGIK/4tBHbQ9M2HbMTtdUEp/j4l66Ek6JToak7lj5FNTFFHFQ4Fz
         x1Tg==
X-Forwarded-Encrypted: i=1; AHgh+RpJUUKg6jIVjk3/crRxhSuP9U+0tqr/uMCmyz/kHaWYTpt08rrVECqg297rlB0iZoKlPsr2ubuZO+QrI5jGgw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/+GTtIwdwCyZRqSsnwtm9FT56w+ietwPD6lvzpOXKuiZH7HBF
	EHtO6/JulrmRrABGwkqM0+bcie5IENxRBsMdgKa5kXukBwJcMjW64M+RHvljyEkZ6fJJvyinxrc
	/i0EWiw==
X-Received: from pjbms18.prod.google.com ([2002:a17:90b:2352:b0:380:9651:afb9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e7ce:b0:37d:8426:40de
 with SMTP id 98e67ed59e1d1-380aa0ad396mr2721883a91.1.1782934366877; Wed, 01
 Jul 2026 12:32:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:38 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-18-seanjc@google.com>
Subject: [PATCH v5 17/51] x86/tsc: Fold native_calibrate_cpu() into recalibrate_cpu_khz()
From: Sean Christopherson <seanjc@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sean Christopherson <seanjc@google.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, David Woodhouse <dwmw@amazon.co.uk>, 
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
 arch/x86/kernel/tsc.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 9764ac758081..6ed6f8f012eb 100644
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
2.55.0.rc0.799.gd6f94ed593-goog

