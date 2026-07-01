Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2738C429DD9
	for <virtualization@lists.linux.dev>; Wed,  1 Jul 2026 19:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934401; cv=none; b=WLKDSQZ7gX1UlwHgYpFt3LICVYwM0F8fvvY1yQStCHSON+EKJrE/H8VplTRWtkXhQZy9q4RiryoA2YLQy7X+VAouFpPKG96GLRYoNAA/0YHngpnoKfI8ftfmCl1Wz3Pquk87LZ4/I4iQnNGyE/oK6h6N3BCV6d4zrc3XgfIAe04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934401; c=relaxed/simple;
	bh=v/jmxMkGYZ/HTlvohOgxWHlLEZvO6K2N4svMiche8Yc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QIYXXZjghLwMNeptnd+YQFVNLCmQd1ehrj7BZbtKPr1T3LwQwmWkv8xYi7naR0Gp90K1iKxc5P3inlBs3o2qZfi/YIT76szrFESjAWg6dT3ly5FFFJd+OhRH6OgJkvA2o1afeAZNcHm9V9vcLpIpIt2hwuzSjoOR5uJiMiK/Nj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oQD+YBE3; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oQD+YBE3"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ca0481106cso11583895ad.0
        for <virtualization@lists.linux.dev>; Wed, 01 Jul 2026 12:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934398; x=1783539198; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=E0Ky72UXh2AIoPVqIZkO5elKJbkXgXhRlg1eH2WcetI=;
        b=oQD+YBE3xepK1ALUs3s8VdXNVkDHyT0lx6jco1gY6To3Df4HczkrKxhPDy/yFxc2M4
         LsNopIabOmqdWOJC8ddBfFhZQZLI3L/eSpnEhWs3DxfaYB3sbrndzBSZKDllnRy9uCsk
         0x8AGc133PvxPzgfbeE7q58KorwZ6DdqTyd+zmxwAsBVbg4ZDpFf4Zics5/WPA/2IFW7
         FWxVxVOwU+ebpqMXrcW6MlcM43cVl7PXAMzgM0yoq5WbYebVSqKjr5VhehZ1TB42q9op
         dfXEhU1Y6k6RJoMj3GIKRBjT2wWD8PaTPVkN/A9cALijyf2rmNNOTu3vz3/ICJSV8nMq
         s06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934398; x=1783539198;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E0Ky72UXh2AIoPVqIZkO5elKJbkXgXhRlg1eH2WcetI=;
        b=GXO0Tai+rxjN2rSUM4kSfC3PXdfql6XKlu+MCnxLK0o0j9j67IZf0pASSy7jp2LoY6
         hLueF+hcZFV3e01Xfa1Olm01LaEXVo2+fjjTjl/yXQiAjs3iTUNmWlyVW977hS/Ob5Ra
         TJF5QiLFq2XGRrKXuJ1NhrOzcMgWPwcKl6s/MXDSNGl0xmTp0rIxcJxXvAgxgTGBVx8E
         c5CmIcBlEvVtAR559VZxQx4FAcJ6YQHGuIIkH+LDNHiHVaZ1ocONL/6ZT7SipGF9DFRJ
         wA//S0nxx6hi6peEAFcsVz0v0RLMIPWyaZ7gyTF00ol7Ts6tCfMHFLhoP0Xgs0H9yHrJ
         bsFA==
X-Forwarded-Encrypted: i=1; AHgh+RrTmCbgTHtyn2N4reZTcZXgdLB7paBZZmROWINvsPeKlNcDyqudVfh8lee0LsSfagCxIN1W5LcQ+KSfsB6JWw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyAsFR9szKgn9V7LofqZcUd2HKTXj3OZ2NiUfLlyhgeZXM4whj5
	SHTGoi2qP3AapCZaEg46Wzu60gAOiFoL2lx5kH9G7rd5w8d3xI+nQnetngjKa/IlhZLIe23Hhrx
	TREbCEw==
X-Received: from pleu6.prod.google.com ([2002:a17:903:41c6:b0:2c8:5a:8056])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3885:b0:2ca:17a8:cfce
 with SMTP id d9443c01a7336-2ca911d341fmr20775345ad.29.1782934398119; Wed, 01
 Jul 2026 12:33:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:32:03 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-43-seanjc@google.com>
Subject: [PATCH v5 42/51] timekeeping: Resume clocksources before reading
 persistent clock
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
index b1b5ec43c0f2..5bc77d36c7a3 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2180,11 +2180,16 @@ void timekeeping_resume(void)
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
2.55.0.rc0.799.gd6f94ed593-goog

