Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31E34AE653
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 23:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059449; cv=none; b=rYe1MzTyqCRp7G0kAgXFifZ0ZUOv35uhQl1GeNcKQV8mFZAhqHRaNcUxe05VnNn8sEL6di7Yqn1ZzmIAbqKG0uAr2MqorhYJ/aP+uJ37+DV6Tgp6BPp01UooPuWTMFwy5CfOUVzC4Uvye9OqkjIorAdl8k80KqDa5cYy3XzEbkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059449; c=relaxed/simple;
	bh=XsGLMtVm+PnMkFVZK403hqaUQQJSgP5QvusfM67Nl2Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=af4eobay/U+KdIfl+pV1rva2Vc8SXbTVAJbA0FXEQWFRrbDE0hnu5cwhNEbwEHet9pFVFGooaYo+zoeiztiFnQffM74vxLfT66YWc27vKhpqEuO9KHbPrKHErfUFvQfRtd9cKgkfyTDUj1J0Pig9grWNc1ksZ1ZsuogcV8AOKJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SN423PtL; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SN423PtL"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38ce7fabf76so4359612a91.2
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 16:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059446; x=1786664246; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yUUzKej44hzjMWM7byUMUm3T8+/2OB7FMHfj7k4gSDk=;
        b=SN423PtLzvCNI6GjxftiY0buOS/X8uNgXJP29papR7TrVlq0jwBu28dd555Tv1zPAh
         ruUenDXFQWCNuAiCl5nietycvOvpkzoYimXykxo/72tNbsLkouBMRi+JrObt+xgKvWxi
         rJDwrvGkM2qOqvjh6zerZu3QKd4G3i9LsQSB1FO8N68h326MlpJbKjK7rTeBvbMP/DJP
         XO8gva9DXJp35gECI5v1K+hlexRCg7oXpeAqooWLO3zX72gN490lynoy9Sm5A5awtz6B
         A+pGZZ5H0WU1Uu7RNXG5H9VDNLSMhal2XjGrFExON9H2zpdSWOihYbqfI2NyD3ECcnBD
         wGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059446; x=1786664246;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yUUzKej44hzjMWM7byUMUm3T8+/2OB7FMHfj7k4gSDk=;
        b=BhAFndfsHeFyehelhHga0ugqke9nLEEI1+tehFuZovGnIYj3ziuMnd16Fa1qYfQjHW
         mTC7ROZm5FRhDhC96ewIGVJBxb9GqAeZ109jhIP/cCiv79+iLhl39Zg4OQpSiR3s6+q1
         yfkCdjLZJKE1epVQwwgKsYg+ZVZcrirIBup1W41o0XkrIWLJvXULDliP6E/FU4iU3fOK
         aXaOraegwc0rmPn35wO1uT3E8Wj36PuWdlpxmxr4teGMTFGrhnJMoD8hpRgf2jXMm/q7
         UWsoGvzujiBuZlD3S/Kt7p7DNzPl+s7ZrvlloEC1YUrzKPBCU2XedDNMwf5D3ZRDtmzj
         Hpng==
X-Forwarded-Encrypted: i=1; AHgh+Ro7mp1JcpI6GbdrXGQCIuiGiCxJOqXyszVCbeb/FKdLTvCwlNftEgpA0MFK9gkIB45BGzYRuCWWL36EP10QBw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxpZOn9AYM/u3N3Ou8+oLvISr6qjZ69omiLb0MoNr+8+FQ2+iKe
	/wVHvp5llQ5WN+ITeGMfzx4zKIHix82CjdqvsnzKxq0dXPMJS7WTY3MM4S77Jlj450Sd33PLWHZ
	NHFiCWQ==
X-Received: from pjzp16.prod.google.com ([2002:a17:90b:110:b0:382:7fcd:a18a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:520a:b0:38f:5828:a40c
 with SMTP id 98e67ed59e1d1-3903c59a6eemr19079453a91.10.1786059446038; Thu, 06
 Aug 2026 16:37:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:36:07 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-51-seanjc@google.com>
Subject: [PATCH v6 50/51] x86/paravirt: Move using_native_sched_clock() stub
 into timer.h
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

Now that timer.h ended up with CONFIG_PARAVIRT #ifdeffery anyways, move the
PARAVIRT=n using_native_sched_clock() stub into timer.h as a "free"
optimization.

No functional change intended.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/timer.h | 6 ++++--
 arch/x86/kernel/tsc.c        | 2 --
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/timer.h b/arch/x86/include/asm/timer.h
index ca5c95d48c03..a52388af6055 100644
--- a/arch/x86/include/asm/timer.h
+++ b/arch/x86/include/asm/timer.h
@@ -11,9 +11,9 @@ extern void recalibrate_cpu_khz(void);
 
 extern int no_timer_check;
 
-extern bool using_native_sched_clock(void);
-
 #ifdef CONFIG_PARAVIRT
+extern bool using_native_sched_clock(void);
+
 int __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
 				      void (*save)(void), void (*restore)(void));
 
@@ -23,6 +23,8 @@ static __always_inline void paravirt_set_sched_clock(u64 (*func)(void),
 {
 	(void)__paravirt_set_sched_clock(func, true, save, restore);
 }
+#else
+static inline bool using_native_sched_clock(void) { return true; }
 #endif
 
 /*
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index c0e4485484f2..74298e8ffa1f 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -302,8 +302,6 @@ int __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
 }
 #else
 u64 sched_clock_noinstr(void) __attribute__((alias("native_sched_clock")));
-
-bool using_native_sched_clock(void) { return true; }
 #endif
 
 notrace u64 sched_clock(void)
-- 
2.55.0.679.g6767b8d81c-goog

