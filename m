Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F48448390
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 23:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059431; cv=none; b=DwyWdTtrFAVNM0Tkx+AHahJ8FFxcqFB+lFZED5vdqfJCmwpz46BgXR6gF1QPF2ByVIXsLv1BleEFyJUZ5t/F3akW4F9VGw7yf/IjUwWjvoC+82n6QhcXCBk80/bazkxiSrFss47XoviPb4gpL1x8xhBqwJHuVmhI+Er4sZOhKpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059431; c=relaxed/simple;
	bh=sbzLks0rCz/Y4FC4JU4m7+dMymRO89Rs74fjqXQ5fdM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XbM4xLXh7jrLSChuvrwTMFw/b+zTfQQmFIsWPcxqXze/tlL1h0tGHafIigeqDfg7ggyusoFAHdTFIKMtD2lk71Syqe2gSJZMubZElG1lFfS3DDPfxZ8rU0wDbtolBKs7p8Z0MdGH5GQt3nNn1erxo3LjFHd6uc89MeTchqh3JlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OZTMtvb9; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OZTMtvb9"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38dbf293831so5541546a91.3
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 16:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059428; x=1786664228; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aQ8musMrPFB3W7GZXrEzufcFO/9G0XUPjz13+bRyF/M=;
        b=OZTMtvb9Amnluk+YAniV4gROWh2g07dD5BZioi8CRFJC7KeD/XqvnObIGhZDpywJjS
         R6pU1FVwihAytqpLlXvhdHIy8Y10gZSgxR2UdNIVsmCSVfivt9MwPUen5GZH4v0PzuCH
         imJF8VgqbhkLmsnA3F/LNgmsz6UsePbQmabJHVW7ty+e5SX9zMEMWB2Wih+dDQzrBAk4
         e0G5Vt3s4Esk2pU2G2JJqskmmhYpbQJqyH6Swl5l4HLCBan1jTFOsVTCkpKG0/UDr5XG
         FaxVeXDv6tfBp5pD9HA+GnvHIrlWlIAOr6j6OQBVDa174SXgpuAyQ0iJx95pntlMyVDG
         Kjxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059428; x=1786664228;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aQ8musMrPFB3W7GZXrEzufcFO/9G0XUPjz13+bRyF/M=;
        b=iZVbd2ROiC3uXAhwSebX2lKPhicwk/aTf+PNXmdqKdvM0RKf2NRM5p8JyGAuU+5mAX
         CP05/8/Y8qaf73WmbeJ76YwqKfCQQhOVHkZAC+i7WfjLTQzbIYbGZYJElSrjZwCGJzJL
         d5tpuvbzvM8AEwV1ImJOOHyCtQUANpjvsB/mstGXf/ivt3F94ca8mPYwTYkVWU4qkaAQ
         6LYiYnZinkcXv+D0yPqUL4xdjWeEQYzxnFlafHKgTviNE34q4k/NML+5rup7+SHEi+/G
         5gYRx2MOkwOjjjOhw8h+60KrBIeulm490bHpPh7qiC5ER8uiYhUwc8Qd21RhSOntCOIZ
         qgmw==
X-Forwarded-Encrypted: i=1; AHgh+RopQ4PWhgPm8j6ODzqvnIyTTzYAqmLoH6AgoGzutSSZpZ4cfGSMXe6rU/kqk0ucRPBIAp9YuxKcsl1vFtgSDg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyoBt5wozCs36sSb4enOl4Rh7xOtx8kGE40egoMpEJO7h9QxdV0
	KTLtqCt0HRh4rL7Nw3Nt3CGb77li7L4aaOdGbNJEUP4aPC3Pr3YICkIftXdNGaV/5fzaK8ZLFVn
	NtysGeQ==
X-Received: from pjpq20.prod.google.com ([2002:a17:90a:a014:b0:38e:befb:90c6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:264b:b0:38a:c3f:3b87
 with SMTP id 98e67ed59e1d1-3903c58a6femr19988163a91.12.1786059428057; Thu, 06
 Aug 2026 16:37:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:52 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-36-seanjc@google.com>
Subject: [PATCH v6 35/51] x86/tsc: WARN if TSC sched_clock save/restore used
 with PV sched_clock
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

Now that all PV clocksources override the sched_clock save/restore hooks
when overriding sched_clock, WARN if the "default" TSC hooks are invoked
when using a PV sched_clock, e.g. to guard against regressions.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/tsc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 964f3d6c2c71..60fcc3020792 100644
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
2.55.0.679.g6767b8d81c-goog

