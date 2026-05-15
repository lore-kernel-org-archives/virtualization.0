Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE833932F0
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 19:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872863; cv=none; b=d0LhmYXipZ11Ud1BzuKLTGcJlvrlgWT8RVjajt0Pif+sJgKNh6CQhJbIO9RGaVgY5VKAuvEn/NEebrAP8EtSb3qIjhSnm3s8Jo3BQg2g2IdLGiqnYwiNNE74AkkKzqY5b7SfPdxlr5FoKKhXf+XlBlrKjsaSDenGDWLZ+3E+fhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872863; c=relaxed/simple;
	bh=7HCympHBB5xq3NRYbNWj3V2HpCZUGQZPcE1kS6YLWe4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QODQy6jFcfNgNzw8HhM6DGh5+uQrDJ0+rpEs2de8X8yjxxxdtsoikayQlHNST9jBcPnyH3NF62MJQN+KCivUT6HbzoiPWQ83kWVo4sLn6g3S1mmkNICaR6RmZQF2gPIT9rd0cHPq091NHy7nOdC14grb224bZu+zw7msE/c1/jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GqjS3m/A; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GqjS3m/A"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8386367b23cso111022b3a.3
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 12:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872861; x=1779477661; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=4XJIP9GZP+0qc5TpuA2ddXAK/ReZERF3J3EAtmTAWAE=;
        b=GqjS3m/A6FIkC8zBO8wN1oS16xXRWLLOJ6P3q39rOYL6PlSZ9EE4Nh+H3KiMyWrTi0
         No1TAYsyqDBdCgIF41jKDkOapenaIX7XrqtWS5/7pFpCbLp49pyAa5aFd45l4o/z3RoG
         JBxZxqu7boRdMMZ5BCNO3oYuyTENUbUI/o6lmjrPuVGTl9NNe4etbOWMjP4R/KmDJLVG
         9bE8DiwG68toyVWpHg6tfWQeHgIt9t7tft/MgqaQwDq81nHRojhjoKKIzQaExBngz/UH
         NmZX30Dm//ZDUw2UZRe14M3WEf9x/U06ZQboX43tvAgz8YnfqMeRv+v98QuI458Xw4AP
         HcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872861; x=1779477661;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4XJIP9GZP+0qc5TpuA2ddXAK/ReZERF3J3EAtmTAWAE=;
        b=nwYKHR61HPOJG/FMgOiy+ofN3uitjtrA83WkAJfwdViv2R4rq49h7w8Z7l5i1HIJWy
         ec+0qMC97GjaxTyrgvvKgI4nG5OcUQ6NnuQJxnbQoqQZMQPZnNzByJ8sdprmjdseut5a
         rMcLa9irRFlqjHI5P/GfweRoFRiH/Ji5Vl4LPAUbryvgoJr3LPKzwRtgdF6gP3Gsw3+2
         FUljK9hjWVHtJdmc4BxNpvVqalbQr3IpU2eLgJNnI2aiGfWouGN91ZjPIoFrQ24seQjx
         lv0DmcxDGwDVTl5sHRBpcTQZtJItHQ7jNwEMD2V/zpxdReTK8zuHidBOg0NnFHtDah/u
         Fh6w==
X-Forwarded-Encrypted: i=1; AFNElJ9UJw+JMm7UiQaArPLKw+hr6uL/nhe5pyNN04HltFh6V65GaLGCKrRtIL25EAS55iyMoweE/TdPn7zuF6XnJg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywmr0KvCzw1E7mW8FmZrXdefapT0i0ZtQyPDKfR/C9YCZsFLu4a
	epUGbeoOXHRDdJEmmRsZI9zJJ59FM4Ix1ggA0DL3ll3QkBowWVC3XChZbfE73TOeoCmUsuydtoL
	uHDqeTg==
X-Received: from pfje16.prod.google.com ([2002:a05:6a00:d0:b0:82f:6eb4:9793])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a20e:b0:82c:e1aa:21e3
 with SMTP id d2e1a72fcca58-83f33bca81dmr5806035b3a.10.1778872860340; Fri, 15
 May 2026 12:21:00 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:25 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-25-seanjc@google.com>
Subject: [PATCH v3 24/41] timekeeping: Resume clocksources before reading
 persistent clock
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
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 kernel/time/timekeeping.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index c493a4010305..26f3291a814d 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2098,11 +2098,16 @@ void timekeeping_resume(void)
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
2.54.0.563.g4f69b47b94-goog

