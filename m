Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA386199223
	for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 02:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622759; cv=none; b=HY5FdwB6VRd2WVg/7AoDg9BR3ewkxy1linUwDp3N2Su64PQnkn/sHbXBRHnX6mKxWlI+dHO2oDRfoag5hB6e+VqjH6ABlafxn8OtayOo2YOnCzw+Y5RB7+mg0l9am8oWIp9aO7LSyYCFTMJgKTNV2Z4D/S/hfcBS1JxKQ5CUz1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622759; c=relaxed/simple;
	bh=EP6PsRCf87GzV1IBCG1heWk9cTGrnzInffXbkT0E3+Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T7Xzi4mj2vZV/spPqWZX6Y/fgrwNlIqJn4m2vICpCCKnIGP89QuIzYsbWx0Ge0y14EKSphM+JHUurFZA10ZMRm41Wd7gGM8c+gHQcYE/ceFttRmxvNqw/wz7lvZ2hDsvmLBxtlY/N3buGk8n0Da3UvmneNAnu9D8uhAdeqsWDtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jq8k6htH; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jq8k6htH"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fe8c5dbdb0so1061160a91.3
        for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 18:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622757; x=1741227557; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=xfyweVUhHjn5qLEM1jkmIOD/E67k0zFXQwB6BCCQHG8=;
        b=jq8k6htHH8C7nsFSCOsPDIyt41m+kTBV9MyFcdz0xqt3sawnSXH2rFN3DRny3MMp1d
         NfC9+GXmy38K1YXtNX4NtQNrRWWJBzW/JMV8pvxbL4FOLeyJEmQyG2HpfS59D/Ro0sNW
         jvMrsig8IY8FCL5f/QvR7d60icvWFWF7zJq6OimBle+KiSwND7VyUmBJ9KI0NgyFNlz8
         cGiswvtKMGo2K4juoLIVtnoA9twQJfwsg6Du+JlLAbJTMbl/wQu6cqvDwONR3BkhWuWK
         CgQAINfk3BWZ09o8izvMl5nGXVbKYWrI/V2yvXGllcrRN20hGTVuhunLbb6qUr6jWrt2
         57Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622757; x=1741227557;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xfyweVUhHjn5qLEM1jkmIOD/E67k0zFXQwB6BCCQHG8=;
        b=Co6r2StT07xBGijoggngWLLK1ixwMOWZO9hbcGOQ4rTcWVTHxrOS1CFT+U1KsDRx9I
         9KSAUcGoT1vfFSf9EKBbCS1b31hJ1wZ5HPuL11B1/nnDDA5E4eBPYeDIZLJuAqF83aSz
         ooHf/cSVfb1UWbvJlmjfsAfjhMaS7x92NMd9FkTz85rSprSmL26f+gA77xvvwuLqL9e6
         v7phuLH8MYd0ws/LwJiP2h665QaT2RAueFKveFrq74LoFaOzSm8obURqwZNMDm04kcLF
         S8EwOm8FW9RHa22Mwnn84LYfJcbmMrHeEgrBvXpmsunMovNOqML1LrNoVzIzTRL9Q0oi
         mlyA==
X-Forwarded-Encrypted: i=1; AJvYcCUzr6Ulp5NQwop+mP8XVXim39PMWtU/fVkvardhsEsgacoD9xA7x5RyzU5tg+TNt+UPFXrdWQAqZ9uIVs/5Sg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyudzXjlQpOkYvuafVAZYnEVxj1dlCc/Wx+FbULBOHcy3cDozJ8
	0n7EuPMELAhoAq/61G34fo1tvE3AVJF/uZC2kIXEj6RUZHgRm9aohxoQ5njNRRVw+uHsO+MvmvR
	HpQ==
X-Google-Smtp-Source: AGHT+IGK7T2uVtHCkzgg9idpaqI5CgjOHQ8lJUTz55dy8O8u0q+xXKgUvujnuayeBIrgMdHIgLk5Hrx+hJs=
X-Received: from pjbta8.prod.google.com ([2002:a17:90b:4ec8:b0:2fa:1771:e276])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d48:b0:2ee:d7d3:3019
 with SMTP id 98e67ed59e1d1-2fe7e31f7c1mr10280973a91.12.1740622757149; Wed, 26
 Feb 2025 18:19:17 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:24 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-9-seanjc@google.com>
Subject: [PATCH v2 08/38] clocksource: hyper-v: Register sched_clock
 save/restore iff it's necessary
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Juergen Gross <jgross@suse.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	John Stultz <jstultz@google.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

Register the Hyper-V timer callbacks or saving/restoring its PV sched_clock
if and only if the timer is actually being used for sched_clock.
Currently, Hyper-V overrides the save/restore hooks if the reference TSC
available, whereas the Hyper-V timer code only overrides sched_clock if
the reference TSC is available *and* it's not invariant.  The flaw is
effectively papered over by invoking the "old" save/restore callbacks as
part of save/restore, but that's unnecessary and fragile.

To avoid introducing more complexity, and to allow for additional cleanups
of the PV sched_clock code, move the save/restore hooks and logic into
hyperv_timer.c and simply wire up the hooks when overriding sched_clock
itself.

Note, while the Hyper-V timer code is intended to be architecture neutral,
CONFIG_PARAVIRT is firmly x86-only, i.e. adding a small amount of x86
specific code (which will be reduced in future cleanups) doesn't
meaningfully pollute generic code.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/mshyperv.c     | 58 ------------------------------
 drivers/clocksource/hyperv_timer.c | 50 ++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 58 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index aa60491bf738..174f6a71c899 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -223,63 +223,6 @@ static void hv_machine_crash_shutdown(struct pt_regs *regs)
 	hyperv_cleanup();
 }
 #endif /* CONFIG_CRASH_DUMP */
-
-static u64 hv_ref_counter_at_suspend;
-static void (*old_save_sched_clock_state)(void);
-static void (*old_restore_sched_clock_state)(void);
-
-/*
- * Hyper-V clock counter resets during hibernation. Save and restore clock
- * offset during suspend/resume, while also considering the time passed
- * before suspend. This is to make sure that sched_clock using hv tsc page
- * based clocksource, proceeds from where it left off during suspend and
- * it shows correct time for the timestamps of kernel messages after resume.
- */
-static void save_hv_clock_tsc_state(void)
-{
-	hv_ref_counter_at_suspend = hv_read_reference_counter();
-}
-
-static void restore_hv_clock_tsc_state(void)
-{
-	/*
-	 * Adjust the offsets used by hv tsc clocksource to
-	 * account for the time spent before hibernation.
-	 * adjusted value = reference counter (time) at suspend
-	 *                - reference counter (time) now.
-	 */
-	hv_adj_sched_clock_offset(hv_ref_counter_at_suspend - hv_read_reference_counter());
-}
-
-/*
- * Functions to override save_sched_clock_state and restore_sched_clock_state
- * functions of x86_platform. The Hyper-V clock counter is reset during
- * suspend-resume and the offset used to measure time needs to be
- * corrected, post resume.
- */
-static void hv_save_sched_clock_state(void)
-{
-	old_save_sched_clock_state();
-	save_hv_clock_tsc_state();
-}
-
-static void hv_restore_sched_clock_state(void)
-{
-	restore_hv_clock_tsc_state();
-	old_restore_sched_clock_state();
-}
-
-static void __init x86_setup_ops_for_tsc_pg_clock(void)
-{
-	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
-		return;
-
-	old_save_sched_clock_state = x86_platform.save_sched_clock_state;
-	x86_platform.save_sched_clock_state = hv_save_sched_clock_state;
-
-	old_restore_sched_clock_state = x86_platform.restore_sched_clock_state;
-	x86_platform.restore_sched_clock_state = hv_restore_sched_clock_state;
-}
 #endif /* CONFIG_HYPERV */
 
 static uint32_t  __init ms_hyperv_platform(void)
@@ -635,7 +578,6 @@ static void __init ms_hyperv_init_platform(void)
 
 	/* Register Hyper-V specific clocksource */
 	hv_init_clocksource();
-	x86_setup_ops_for_tsc_pg_clock();
 	hv_vtl_init_platform();
 #endif
 	/*
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index f00019b078a7..86a55167bf5d 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -534,10 +534,60 @@ static __always_inline void hv_setup_sched_clock(void *sched_clock)
 	sched_clock_register(sched_clock, 64, NSEC_PER_SEC);
 }
 #elif defined CONFIG_PARAVIRT
+static u64 hv_ref_counter_at_suspend;
+static void (*old_save_sched_clock_state)(void);
+static void (*old_restore_sched_clock_state)(void);
+
+/*
+ * Hyper-V clock counter resets during hibernation. Save and restore clock
+ * offset during suspend/resume, while also considering the time passed
+ * before suspend. This is to make sure that sched_clock using hv tsc page
+ * based clocksource, proceeds from where it left off during suspend and
+ * it shows correct time for the timestamps of kernel messages after resume.
+ */
+static void save_hv_clock_tsc_state(void)
+{
+	hv_ref_counter_at_suspend = hv_read_reference_counter();
+}
+
+static void restore_hv_clock_tsc_state(void)
+{
+	/*
+	 * Adjust the offsets used by hv tsc clocksource to
+	 * account for the time spent before hibernation.
+	 * adjusted value = reference counter (time) at suspend
+	 *                - reference counter (time) now.
+	 */
+	hv_adj_sched_clock_offset(hv_ref_counter_at_suspend - hv_read_reference_counter());
+}
+/*
+ * Functions to override save_sched_clock_state and restore_sched_clock_state
+ * functions of x86_platform. The Hyper-V clock counter is reset during
+ * suspend-resume and the offset used to measure time needs to be
+ * corrected, post resume.
+ */
+static void hv_save_sched_clock_state(void)
+{
+	old_save_sched_clock_state();
+	save_hv_clock_tsc_state();
+}
+
+static void hv_restore_sched_clock_state(void)
+{
+	restore_hv_clock_tsc_state();
+	old_restore_sched_clock_state();
+}
+
 static __always_inline void hv_setup_sched_clock(void *sched_clock)
 {
 	/* We're on x86/x64 *and* using PV ops */
 	paravirt_set_sched_clock(sched_clock);
+
+	old_save_sched_clock_state = x86_platform.save_sched_clock_state;
+	x86_platform.save_sched_clock_state = hv_save_sched_clock_state;
+
+	old_restore_sched_clock_state = x86_platform.restore_sched_clock_state;
+	x86_platform.restore_sched_clock_state = hv_restore_sched_clock_state;
 }
 #else /* !CONFIG_GENERIC_SCHED_CLOCK && !CONFIG_PARAVIRT */
 static __always_inline void hv_setup_sched_clock(void *sched_clock) {}
-- 
2.48.1.711.g2feabab25a-goog

