Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A324AB82A
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 23:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059439; cv=none; b=nKNgf+HWOxK2hZdynGJo6Qn5CtCYHRcLFLuR6A/7TJ2FpHkD9VgjvEXcqnmd/YoQUQ9WwPrEYy8u/uxOAwyKtKjZIdyLxlrN72SfQRBxJpK2W3Mrm/XPcEdJEEW3QPIchi+SjF4ZYXbzdWcqRkGRFPj6G8eJy5hRRz7JL3Ffzx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059439; c=relaxed/simple;
	bh=CMNPpn663VblKppKKu5nFjYj1HkUy1nnfJebT2ynUYY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MaHF2la1xVdeYyB+q0TBvYojVWEUvh7VpGiy+9EomaVKCUEh3j1Ga8CHgOoIB8paYKSxjNUsSERWJR2oSuxtqRyh4wjTf7s9riNq8uT7Z1vRMsb9b+UxXG/xBZnk+g8Rm9SETFHdEht6RRyIFH1Q03clAofbMdFIAMDXTwvpm0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sAovURGX; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sAovURGX"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c9fe4c5eb39so2012428a12.1
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 16:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059437; x=1786664237; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qISz6FBmFt+Rjc4N/P+Kp805/IDsq2ZStMxtEE1uDRQ=;
        b=sAovURGXKBgSewvOHUPHy0nOClcirdIAAIV2pnAn6VRdHeBOYK+8uJwWvFPWHfn7pT
         VNrZ2s6qfIzSNyUqBxzOM3QYwL7E32ciPTYHuj2Pncdb3+feC0pC9JbJjyvb2FiTBqFF
         ZtH9mC2LTov2IU4trYES9AYBtKlQ75yU3/KwLsiDGtIgb0SEUQabwyHCjP5tms81woZp
         Nic33LFbHN1htl+sB/KRWIBJvJNTzl4ZFQFQx4OI/QcW1wqRtmuQdCtPjdK25HCkcZEg
         KfDXfVJYb8VjhlNIh+h6qZI8SkHWEF8bg6p6Hh22Gr5nxyXkEVIKx+i8wSQWuTl97CnR
         GOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059437; x=1786664237;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qISz6FBmFt+Rjc4N/P+Kp805/IDsq2ZStMxtEE1uDRQ=;
        b=AXgi8NYKOq1AWF1n3mtfv8ZOZ647atpJoJdN3//k2iFr4WMxRr4Jf6glkUpQJWwhV4
         uCHR/3Th3Asn7ME7MxPhBBtTVbjIz+CiRWBsP8iecMWdRYiR3osdqIhGx1CuBbOKRrJy
         kgl+kVDShjkNE9h33mLWlk+sA/daLlSgTGLZU/bTpJeHdbm2vKXuNUZ2zWBrwOQWGpS5
         DwCnxT6m5bnVRRXZ7+g0pdwb1+T5IH6O28c09YyiG1W+UZpIPjXqExXNZ/ZDZf0ZZEdw
         RyvCScQ2AowRU2cBcoql0fBn37wLezd1gJyYvFOhKc16gwNwidDxP/zVQruLrG1eY6uQ
         ilug==
X-Forwarded-Encrypted: i=1; AHgh+RoaofA8rfDlXpk/65+vqxeBQ+zp8/iGvlzh2cm14D6g7T4HOt8pzGuWHYBtGN0H+vD9ECoakgj+0S0GqioioA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwTQfxroLzL/jBxgjbEJO9+dzUZLieqQdm+4hXR3dwLaVymK/o7
	v6xA+kIV2YWoqRPcKJjFVAexqrDRI6AF3rO4y0TBEqzL793UERIW3xQRNst8fxANTdSVRVVoZS+
	4nhpGXw==
X-Received: from pgbep6.prod.google.com ([2002:a05:6a02:2646:b0:c99:90dc:7b3f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6112:b0:3b4:e4f6:4f15
 with SMTP id adf61e73a8af0-3cb85e9922cmr22668021637.5.1786059436589; Thu, 06
 Aug 2026 16:37:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:59 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-43-seanjc@google.com>
Subject: [PATCH v6 42/51] timekeeping: Resume clocksources before reading
 persistent clock
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

When resuming timekeeping after suspend, restore clocksources prior to
reading the persistent clock.  Paravirt clocks, e.g. kvmclock, tie the
validity of a PV persistent clock to a clocksource, i.e. reading the PV
persistent clock will return garbage if the underlying PV clocksource
hasn't been enabled.  The flaw has gone unnoticed because kvmclock is a
mess and uses its own suspend/resume hooks instead of the clocksource
suspend/resume hooks, which happens to work by sheer dumb luck (the
kvmclock resume hook runs before timekeeping_resume()).

Note, there is no evidence that any clocksource supported by the kernel
depends on a persistent clock.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 kernel/time/timekeeping.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 97db2e9393f9..585525f5c1f6 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2226,11 +2226,16 @@ void timekeeping_resume(void)
 	u64 cycle_now, nsec;
 	unsigned long flags;
 
-	read_persistent_clock64(&ts_new);
-
 	clockevents_resume();
 	clocksource_resume();
 
+	/*
+	 * Read persistent time after clocksources have been resumed.  Paravirt
+	 * clocks have a nasty habit of piggybacking a persistent clock on a
+	 * system clock, and may return garbage if the system clock is suspended.
+	 */
+	read_persistent_clock64(&ts_new);
+
 	raw_spin_lock_irqsave(&tk_core.lock, flags);
 
 	/*
-- 
2.55.0.679.g6767b8d81c-goog

