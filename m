Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A3638D3E4
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 19:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872852; cv=none; b=Eh1YHBtMmAi8pjEypzsXLH7sem8KIbRerslTqb1YDv40Icr9IA9Zkl18dq5+oViXyv4J+TP1nXZKRJuPbaQV/Pzzp4ufq8T2GKbnpCZ2zN4jPgizIFudRctlWxe/9kinrHZss9VeSu1g/PILZRT8wC+88JYgyuRflOlrmt2l84Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872852; c=relaxed/simple;
	bh=VGy+qLRWGOmAxsBGFeiFDyGswDSrJi4JQ5o9B+Fv8MU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NY4E4GjTLrdV1vM1fNhiv576kD1rBVl33BO6f1pgkc9kTJ0vfRcDPHOLh4ePPsvLVC9a5ztYJBI0Oj/tzshZdtc8VZRxhAM/KqTdlwb5tVZSSUEJsKhJ/kQWyqqQtfotnMqgJrw+HTsA7rBQrzZ3OlfdTT+0tHxvr+OHcNw6aTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=prrmj8WT; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="prrmj8WT"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-837cc5bc6deso94373b3a.3
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 12:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872849; x=1779477649; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=HUz/DYTZsMDp3XmDdx4uAZCV01b5NalrmHfGrDrQY4I=;
        b=prrmj8WTn9wcERs264A1wlzPWbtFdwCl5pyjd6y01RajvT8AlMIT8q8WILxTU6J9IH
         4sKAJvny9EphoRZCynwCKKw/MYXVT+I/q1vHyZP68aUeMxANwffIEmQoW55fNUNIcxPi
         71onQ2s+N4eyksOwhm3fodes9feZh9mjl9zHAmyK1RG6mE7KlH+5pTdK1ieJ4wHR2bk8
         Ha/pisoXjewzK24ihrUf8bwjKk5RecSxOo9CcNjgUoDngDgsvNae2a4sXvr8P3/cTGkR
         Ep2eig8wzoENrii1jXF4yzszOAz42D4lmxHQaaIVyz0x79uQ+/h06xFH1hJHqj4ZJG7J
         WBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872849; x=1779477649;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HUz/DYTZsMDp3XmDdx4uAZCV01b5NalrmHfGrDrQY4I=;
        b=HF/Oo/yGFKzwvyMNY4Drv4YNXyEm672K9V0f7rHCUybnxtlj3+fkZftBTtpwo+TJPO
         XUhMf4dM9/yL+VEEl8S6icn2A1ZHGQ6r5rawYdRfR6fFCW6XVZF1S4246neGpmFuthH/
         q4fpjmbuvcBrMaulkdFHC0Lvw7DZKO/i1QxNK0YBAKNkDAqh6xb4Q5MioZ7VmR8bsmXp
         Y5YlMEHEgKJg1NoFzL1jWaDh7FBFDvwTOyOFtfBHq29cJ0XolGshYlQAWUnCcW+pndrA
         6wb7sdCP+imiG9io3bGGpT420UiGQljTUmltdZTKHwqvNWLG1bzkAsUuNUrIBzh06g8c
         HWvg==
X-Forwarded-Encrypted: i=1; AFNElJ9pXkzYQ/9CV+oOCeofJFmGF2EBqkuD+BvKByS+i6Q5TqsHtGuqwtm1fppW4l15xAQUgTptOLGlzPo8M1wO3A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzGeDuGc4ZZOvxKW0jnwGuOmb6Vg8IlQ4zRd2bp4BJk9kLRZHoy
	c6ngDOqY9UBbx48m5+ZP0YQBKiKGYtw7a8c7xQsQlmZC7iPyis6TPGWQSzIndvvtUH0LKSzLd1A
	sx4i6RQ==
X-Received: from pfmm20.prod.google.com ([2002:a05:6a00:2494:b0:835:43a4:4aaa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:6ca2:b0:83d:b11f:7979
 with SMTP id d2e1a72fcca58-83f33c60deemr6247193b3a.29.1778872849160; Fri, 15
 May 2026 12:20:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:18 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-18-seanjc@google.com>
Subject: [PATCH v3 17/41] x86/tsc: WARN if TSC sched_clock save/restore used
 with PV sched_clock
From: Sean Christopherson <seanjc@google.com>
To: Kiryl Shutsemau <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, x86@kernel.org, 
	linux-coco@lists.linux.dev, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"

Now that all PV clocksources override the sched_clock save/restore hooks
when overriding sched_clock, WARN if the "default" TSC hooks are invoked
when using a PV sched_clock, e.g. to guard against regressions.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/tsc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 567d30b30a5a..b14c4ada89a3 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -984,9 +984,17 @@ EXPORT_SYMBOL_GPL(recalibrate_cpu_khz);
 
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
@@ -1006,7 +1014,7 @@ void tsc_restore_sched_clock_state(void)
 	unsigned long flags;
 	int cpu;
 
-	if (!static_branch_likely(&__use_tsc) && !sched_clock_stable())
+	if (!tsc_is_save_restore_needed())
 		return;
 
 	local_irq_save(flags);
-- 
2.54.0.563.g4f69b47b94-goog

