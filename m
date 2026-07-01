Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15B1423F70
	for <virtualization@lists.linux.dev>; Wed,  1 Jul 2026 19:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934393; cv=none; b=ZRDm+G6mQOpd1XE2e6Usht/yn1ng8rN67FNjaLnv+DOlhhmLYrTIW6ZlEJozg9tHjU0YiXPyLxyY9RU+8hfJ9wV66UvuJMCgKU6CGJrHdp+WteVapKEfmJclcT0yqz9VI1dPcx8gggn325qY7d8uMV5OBqhfVJf7ekxHgmBraZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934393; c=relaxed/simple;
	bh=CMkMn9gDHGDnd3gtJyIeM0lkE5As7w47pJpKewsK9/4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qc4DGe2h+atTVvaG0qboHdHArCFIOpOuRtcqWFsZvLsEKw7C/jSyZTvfa35956VYAwcToz+rHavngFcuew9sk8NiNh1DCSe0AnX+Q3hyVnIhQd65zRtyRbcUXy39gLXMPnpvfkW+DKCNos1Av5jSg+CogTQo5Ofy0+cOSMeIm4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XObTsx6V; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XObTsx6V"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c88fc985a65so945977a12.2
        for <virtualization@lists.linux.dev>; Wed, 01 Jul 2026 12:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934390; x=1783539190; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=bEdSCU5mjiDv3GADlP0fC3hWLpC5/Jr71iPsXhxCK9Y=;
        b=XObTsx6V9Vz6LvScSHHHpSGCvxCUnhsm+6AxdaD6iWPAoI5s14ay4TsXozwZHiQnbr
         opxZ/Zj83wWyU8Q3WfCM0V+AQdvlr+byS7hPvmbAIMXCWC6+OGR8emUwuAzLQlbUe8sI
         X39qdjvQkUIIwx6o1r7Rt1QuIzcntyTInjBX5KVDnQ1KMJJex3kRthEoB8+kvmSjZZpJ
         muOQUqFvinDYmisSyoXWQvTL/ckBE3kMjd8MyY7FRdyhVtltmVuYa0IkeU1p1PL7T3sd
         id2ZPFZ0bEgdQ3QqE4pRwe1kUTUQABeLY3t04aEYnoI8iHmbAmeLOm/2U2lqPoqUJDzm
         LY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934390; x=1783539190;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bEdSCU5mjiDv3GADlP0fC3hWLpC5/Jr71iPsXhxCK9Y=;
        b=kVNG1WHKmLRL3cs3A36skv2ijyJH8/9Ij0BqYRvSAIexXQyLMb/i7G3lrU3k6bDBoV
         ntzB1rYGi9lMOpS8UEwlnB/lOXff8BwQ5STBvmKhY8Z5EWcIqlaOY5R6D2bGvP4sTGTE
         zBM9/1tHS6qJPw6WqMagvhLlW10yzNN/Xflfrn4/nEuUiIXBk7lZ++P9IPBWPAcd6DwB
         /opF53LsF4VxcGdKAP1KvhKQIrfAW0e8QmeTIejIioTrO5DHix4u6N2NnbyeMHyesUn1
         xvCRkobGHOrUlfNfh1gefbBiQoAh518lLRGeTxuTHRat+LSFR8K49cMklQXwIQWvXeHs
         TOww==
X-Forwarded-Encrypted: i=1; AFNElJ+jTOJuTF1N03frTHcy7vY6FsoQ1/W4v1b07JUAHiY+y7xnJwJnwzMYU5VXH9NhLjysSYf6CLTvtt0Ej6Nt9A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxzWok3lIBBRJVc+37Ch+2IY12142HVcHbUM9jSyvqy2/+KKJkO
	0QiGzVVesmU+Rn+12+J2uhPKGVNTI7Okn3RaiYLRLFk88KPgapTw717EYIglcQwP1P6qr3MhVmK
	OW3FfYg==
X-Received: from pgh6.prod.google.com ([2002:a05:6a02:4e06:b0:c8b:19f4:6228])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4320:b0:3bf:6c08:fb88
 with SMTP id adf61e73a8af0-3bfed4b9441mr3531733637.56.1782934389876; Wed, 01
 Jul 2026 12:33:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:56 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-36-seanjc@google.com>
Subject: [PATCH v5 35/51] x86/tsc: WARN if TSC sched_clock save/restore used
 with PV sched_clock
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

Now that all PV clocksources override the sched_clock save/restore hooks
when overriding sched_clock, WARN if the "default" TSC hooks are invoked
when using a PV sched_clock, e.g. to guard against regressions.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/tsc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index a762cb5cec0f..7473dcab4775 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -947,9 +947,17 @@ EXPORT_SYMBOL_FOR_MODULES(recalibrate_cpu_khz, "p4-clockmod,powernow-k7");
 
 static unsigned long long cyc2ns_suspend;
 
+static __always_inline bool tsc_is_save_restore_needed(void)
+{
+	if (WARN_ON_ONCE(!using_native_sched_clock()))
+		return false;
+
+	return static_branch_likely(&__use_tsc) || sched_clock_stable();
+}
+
 void tsc_save_sched_clock_state(void)
 {
-	if (!static_branch_likely(&__use_tsc) && !sched_clock_stable())
+	if (!tsc_is_save_restore_needed())
 		return;
 
 	cyc2ns_suspend = sched_clock();
@@ -969,7 +977,7 @@ void tsc_restore_sched_clock_state(void)
 	unsigned long flags;
 	int cpu;
 
-	if (!static_branch_likely(&__use_tsc) && !sched_clock_stable())
+	if (!tsc_is_save_restore_needed())
 		return;
 
 	local_irq_save(flags);
-- 
2.55.0.rc0.799.gd6f94ed593-goog

