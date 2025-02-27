Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522B922D7AC
	for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 02:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622786; cv=none; b=FtA7j26SKMriLQgSMhQTYxZaS8RrsrQO4ndqTSoiZ/WOVfDKKTDOxSUxdtyumjQ/mje6u1xEm/mCO1qG3cUCmuVjV4QArxV4kpO1G8ToHbXlIWETvxMzP1Nezqf4htPysmtilQFMwEwYQhJQ6kto0QF0dAbFls49iH6rTpT4wO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622786; c=relaxed/simple;
	bh=2a8H0eAkRitgl8N78ADmzcHYgYnoAl+7GQjDO0K/gtg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VMZNJ9SKiShfmsPkeLhbm3axGqjt1CmR4sFFcHpXUwiWx74SXzfzvKzxZ0z/LHPdwmFQFAV2uaMZBrZP88uuV4vMZBH6zRnBMbT1aXePoBbMurYmI+v6zcYS5Il76AWE75hwZp2YLQWI5tRWrok1BZq8MgPH8MEG6S+A2ROwHPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EP2leKVu; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EP2leKVu"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fbff6426f5so1023515a91.3
        for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 18:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622785; x=1741227585; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=qN8YI5wmqMG6yVEs+7cu8Sw/AfoU86Z3NaGBSlCYqu0=;
        b=EP2leKVu8Itj7/Xfi4kYIz6hVrDwGpj6i6RlZ49SBzVhnn8RExVJaMstEanvh8g6Ch
         UsZeA7iyfNXTG4of6A82mB8UxNxr/NVIQXpt6m9Kkturu5+eIb8L2Rfg9ei+ToT9XD6q
         M+BsbEiobvfo8wNn8tSdN8IqZs7lvJQKpOKMSTfcHOKO9oTBtegoaT1kIgQMJ2qL/lLs
         aXlLXwyEpmSDIYO7hxMFNXANpfT2AKAMd6d/SGZ0bl8l8TjEOXMdJIL3XGp9jCZkYuYb
         9Sx7QpAOsBwjKvWXlgz16byhu5n5FvIM5eih1J944I/m3jTHsHcF0VoMuIWpoyuqqFxF
         Jruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622785; x=1741227585;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qN8YI5wmqMG6yVEs+7cu8Sw/AfoU86Z3NaGBSlCYqu0=;
        b=huDAmElYaSe/iCf1xf5cQ73hqYXgG1LgcDRd+ON0rM/6RYcevQfJ8QRyuV1AWGGgT1
         HCRAbay9c54MpCB1HO28C3CEWYQZVNbKbVS91H8iNhy4oFcjxzsDRiaF3vcJYAXqiTX7
         gWk16igcISD+/WfU3FaCwgktM2rTRXBifNTi3TnENd8Q9Me+ryys3JsqJ/RlyNbQfcLl
         kWwlPmUbscUr544/VLgCuQVXOkij/Ds/MeAIsrRzU4ktQcSTvKPyE9mtByQTgw7KOYDC
         x4lKbWBgKtQsuPaU8j4a6zdx1GolaybCJrrxIbeifeugMcql6JTFfdufV0xuOGp4DSfT
         5pdw==
X-Forwarded-Encrypted: i=1; AJvYcCUPK2VuzBEgnghzeAzRIL5gYH8IMze8PFW4lG4+f0BLjhUv1UYU0/sVLWa0a5pY/1EYo6hnWd51io8WimGkdw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzzSjBn7A6wWhVHEj7Wt5pEeVpWx0hSRxzxWtnd16M/LJkbJqfQ
	3rH4MGMif/oOnpn0SzkQbNkQ3099WtezKAEzBiXNWpcJb/y6hszqfG2XaNzmfrQ6kyNjVWNJBuw
	HOg==
X-Google-Smtp-Source: AGHT+IEw7VZRln4iIrg1rWM/7IZnuYkNWSUUNxKKGfY9HmA7vrLySNMf4INY1k647TDU8xAK61s1yi1H724=
X-Received: from pjbsw12.prod.google.com ([2002:a17:90b:2c8c:b0:2fa:284f:adae])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5243:b0:2f4:434d:c7f0
 with SMTP id 98e67ed59e1d1-2fe68ada3e8mr17648463a91.12.1740622784911; Wed, 26
 Feb 2025 18:19:44 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:40 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-25-seanjc@google.com>
Subject: [PATCH v2 24/38] timekeeping: Resume clocksources before reading
 persistent clock
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

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 kernel/time/timekeeping.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 1e67d076f195..332d053fa9ce 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1794,11 +1794,16 @@ void timekeeping_resume(void)
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
2.48.1.711.g2feabab25a-goog

