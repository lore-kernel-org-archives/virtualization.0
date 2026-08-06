Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AD44ACCE2
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 23:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059444; cv=none; b=uqgxzxH8bweyfi0ChcGHdKBJg9aYqM1/pih2YF/6aNja5aXG+HacuMQVKS+L4RgNFCsctO3+xC7HxfJNzlnc5PDZHdexDAaY+fNUFCEfr80M0pnan4LUEnjjc5nCK2nmNzsF+4i4pe1BaRZ1crnctYbr9CITT8Jxn8e9uWZXdZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059444; c=relaxed/simple;
	bh=wE5Lnirgd+SKewLj9G18nlZgvflnuTi/pbn67D/XsGQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UP/XbZPlF0quemnkBHShb6Di2s9m8izRUVJCow5p9R9xAd2rhJIkIKGC4BIZCEUjNymuOgn6/C2wrO5B3V3PouRChudUTX4tvASzSw444RRxxg1xV/4uMdJIhz3IT4vcLhOwD4Dfz/4rgONp5HvV6BCV4gRaSFipz8grmKl90/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sQE/WZiw; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sQE/WZiw"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb835525b10so3408218a12.2
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 16:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059441; x=1786664241; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+in/CASVMXdQrSwySi/14FWqsmLN6M2d30MjdmJLYfo=;
        b=sQE/WZiwRuUdR6DJ8fT9tnoEEsUsYu6LSy9g/7Kw7x5Ll0LsJMDvFkszCVxzhQpRBw
         RwcdNbzcJCT3b3e3OkrHH1ujosdaG3hVCZWuPeiVaBMkAl8rJxHmTI2ozjGFyhh0G1NH
         0jGeEMnK+dESk3+LlodSApnL22dyQz6pKXy7uyOqpM8kAr6zG2VY8IfgvKaNqqevGQ52
         HIuNCY4e0osSOJiNIJrmHtcZN9edV4Xc86yoGeaQu9ySMbAkJ1HI58gXqdFWDq+YqgaW
         xckI+05I2+YQFqHDav7NdUh7U5oxYVBhRlengs64kFypsUwMivOiaxRXDqA8WLW87c7S
         C3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059441; x=1786664241;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+in/CASVMXdQrSwySi/14FWqsmLN6M2d30MjdmJLYfo=;
        b=T6YOZXR7CUDS1c6B6qURd2sr2xHhQfVChjAFcdbjNGQO1VFROP/AJoGfsDXpripPUg
         A8M3ZlON0dYFJsDE4PWwI/ydtgazXUhnNHSRQwI3n8fs2RxoF6f7TZRgljaUhRUmdSLE
         ESzCiM9ayEh8xjsYnJ66jHGFENZifOS+I13mXYWgkhTXmwlwE0Q4kYfuUllS7IHRN1+J
         39423vx0uie6I7/c36BFbj5rx29Eu+frMR39UOhPxgMa2vbvu/nI5rpTc/tVJsqD0DxF
         Lpk05wNaP2QciX9P9YO3bfnBo7/7m2qJnIAYQo5ZZsS2vD2XJGVSXwCQ+EfUlVmvElCq
         bi/w==
X-Forwarded-Encrypted: i=1; AHgh+RqQNrTC3TlY8+JPA6+FX6ZU5nBFxBD+1e+ZRHzAn65OVzRwIFPTSfyYRddA/usTK8sC27jEY5g4DXMQEmMxsw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQzNCvmKo9URINfhlhtR8vMnY+zHr+oSuaQjG0aiTBDfczWUmP
	/9J71Uz1+WBLpb07CdQ5jsZz0E7Y8PiMZaKWkPtNOJNU8zzcLMcnSHUJQljcImmAnjVED18js5c
	OwM9gBw==
X-Received: from pgii4.prod.google.com ([2002:a63:2204:0:b0:c8d:62a8:ee35])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7a9c:b0:3bf:983d:e9b4
 with SMTP id adf61e73a8af0-3cb8603af0dmr21846910637.33.1786059441366; Thu, 06
 Aug 2026 16:37:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:36:03 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-47-seanjc@google.com>
Subject: [PATCH v6 46/51] x86/paravirt: Plumb a return code into __paravirt_set_sched_clock()
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

Add a return code to __paravirt_set_sched_clock() so that the kernel can
reject attempts to use a PV sched_clock without breaking the caller.  E.g.
when running as a CoCo VM with a secure TSC, using a PV clock is generally
undesirable.

Note, kvmclock is the only PV clock that does anything "extra" beyond
simply registering itself as sched_clock, i.e. is the only caller that
needs to check the new return value.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/timer.h | 6 +++---
 arch/x86/kernel/kvmclock.c   | 9 ++++++---
 arch/x86/kernel/tsc.c        | 5 +++--
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/timer.h b/arch/x86/include/asm/timer.h
index 96ae7feac47c..ca5c95d48c03 100644
--- a/arch/x86/include/asm/timer.h
+++ b/arch/x86/include/asm/timer.h
@@ -14,14 +14,14 @@ extern int no_timer_check;
 extern bool using_native_sched_clock(void);
 
 #ifdef CONFIG_PARAVIRT
-void __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
-				       void (*save)(void), void (*restore)(void));
+int __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
+				      void (*save)(void), void (*restore)(void));
 
 static __always_inline void paravirt_set_sched_clock(u64 (*func)(void),
 						     void (*save)(void),
 						     void (*restore)(void))
 {
-	__paravirt_set_sched_clock(func, true, save, restore);
+	(void)__paravirt_set_sched_clock(func, true, save, restore);
 }
 #endif
 
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 2cc3dd2ba355..22e8855fcd4d 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -332,10 +332,13 @@ static int kvmclock_setup_percpu(unsigned int cpu)
 
 static __init void kvm_sched_clock_init(bool stable)
 {
+	/* Ensure the offset is configured before making kvmclock visible! */
 	kvm_sched_clock_offset = kvm_clock_read();
-	__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
-				   kvm_save_sched_clock_state,
-				   kvm_restore_sched_clock_state);
+
+	if (__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
+				       kvm_save_sched_clock_state,
+				       kvm_restore_sched_clock_state))
+		return;
 
 	/*
 	 * The BSP's clock is managed via dedicated sched_clock save/restore
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 363145c83919..fcf331ffd874 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -280,8 +280,8 @@ bool using_native_sched_clock(void)
 	return static_call_query(pv_sched_clock) == native_sched_clock;
 }
 
-void __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
-				       void (*save)(void), void (*restore)(void))
+int __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
+				      void (*save)(void), void (*restore)(void))
 {
 	if (!stable)
 		clear_sched_clock_stable();
@@ -289,6 +289,7 @@ void __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
 	static_call_update(pv_sched_clock, func);
 	x86_platform.save_sched_clock_state = save;
 	x86_platform.restore_sched_clock_state = restore;
+	return 0;
 }
 #else
 u64 sched_clock_noinstr(void) __attribute__((alias("native_sched_clock")));
-- 
2.55.0.679.g6767b8d81c-goog

