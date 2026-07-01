Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A5E4DD6F7
	for <virtualization@lists.linux.dev>; Wed,  1 Jul 2026 19:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934372; cv=none; b=kDlWacfvAiqUMW1twsVQ3TOpF8wJOwVJkHfdhKlqvlVrB3uU64nr7MbHzEd3xreD3mfGYwnP7IWxbgSK60IzlQnsp7g2k8IUJGjhwU6P6fcjXdSgE2uJNzEgiCM/3kYbcnXZ4HUQHnSMYZGQfu3kf22UM+SufPOhbEgLEc6QiOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934372; c=relaxed/simple;
	bh=BNbYGSH55jffEq4VtE+b969iyJXTMV1HTMSCzkA3sgE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=puR3zsDN+dgEccu0vQ/a/vMoqtuUgpCON2zWw4K9yMYtoveLo0iostY/d1bnGSU/loHe9g45VgUs/rLeDQNHte1CQ4fdYjjVjcMfsZsa5r+87ZW7seTK9wfK7t7s4rEXlR3Gl5ypF9PKlXeu/wUNqiO+1X4rvsLHfJAmfm+Oc54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DN22F9EC; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DN22F9EC"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c88aab7c1fcso998738a12.3
        for <virtualization@lists.linux.dev>; Wed, 01 Jul 2026 12:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934370; x=1783539170; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=/Hl8ESM1aN3u3Me6yWngcHpVlzQnDyaS4TqcnFx8YJ8=;
        b=DN22F9ECMW/8ZT5RJ7o4XjP8z1Zw2rFD+BNjPbsIFOMirIVcsPluYOO/ir4X2VZU1K
         FBXKG7EE+gVHloFuVGvEEZOqK6ITBreYweEP9gX8pTNb4ijQlUhPePahVjprVBOUhOrw
         dFcSiqU6Ju+PkfCpvIL/QXuTghLSl2oOyTlXr3Kjrijtl+peVuW7b9kM8WErxOldKBsU
         MxmcHEVLGGIq2bn2Bbv8wjowR7jkXhuKnaf7vbDYKzuuMIhBYyIP5NWj/r99LlDFp/5C
         g5F+rrzhRRh4nQ5LdJQM8rPyB1u93HbH6fl88C3a2fqz1Oufn4zQIbl/MoPdESOoyVSz
         LYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934370; x=1783539170;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Hl8ESM1aN3u3Me6yWngcHpVlzQnDyaS4TqcnFx8YJ8=;
        b=R8moXWjyXRxmvamrm3m9yJpHoSF0S6wzGb8c7+61JTg8AxqzENfPi7VtszrAJC6PG0
         BEt6MurHWGtdow5iuNyhfweN3HseHdqMQf9feXt9oDDEhaHsuo83tJzzwedfRIVFzStP
         GsHpmN7kcYTnzL9uefkAjzxnzFiXasjC4FsVeEomw/7Bi60Y3DCmi2NiiXSxIwHfQNqC
         eToFKgrJw/7AZ/KvdwOrLDx6BwquNDRPRG3OdgSCQXxwcl6Ts4GNDATwtT879F0Ldzi4
         OtKw8W62D2ZBYf/K/GODzk9uDHBw2N9XQ6xFHeE2FVDrUiqjCa0C/w9lHYpumxx/6kFb
         8U2Q==
X-Forwarded-Encrypted: i=1; AHgh+RoBRxE7YwTdjOfWY8kZvONh90JWZTXdXqpZWEUoFUzH2N6NJbLfI92ALD8YUmqaG5TqjH3dhX8w/Zjci1604w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxlIHZWOTO95mNB5fNk1yD7naqHM8cotYeOIqYPZI8d40uHbls6
	BO2RGk6SnmSWJYEQjvvgpLwMhtKbNSIlBLBs/i2UB6m7FiBPTtrwYMK5VuYDq078o46U7xyIIpT
	27D4RNg==
X-Received: from plrx15.prod.google.com ([2002:a17:902:b40f:b0:2c0:bd65:1a98])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:18e:b0:2c9:e86e:a9f5
 with SMTP id d9443c01a7336-2ca7e73cbd7mr31240015ad.18.1782934369266; Wed, 01
 Jul 2026 12:32:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:40 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-20-seanjc@google.com>
Subject: [PATCH v5 19/51] x86/kvmclock: Drop dead check on TSC being unstable
 during kvmclock_init()
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

As pointed out by Sashiko[*], kvmclock_init() runs before __setup() and
thus before notsc_setup() or tsc_setup() can mark the TSC unstable.
kvmclock_init() also runs well before tsc_init(), and even before
tsc_early_init().  Simply delete the check, as it's been dead code since
it was introduced.

Note, odds are good the check_tsc_unstable() call was copied from Xen's
xen_time_init()+xen_tsc_safe_clocksource() logic (as so much of KVM's PV
code was).  However, xen_time_init() runs via x86_init.timers.timer_init(),
which is invoke from x86_late_time_init(), and thus after params have been
parsed.

Alternatively, kvmclock could register itself later on, or tsc_setup()
could be parsed as an early param.  Given that there's zero evidence there
was any meaningful intent or need to actually check for an unstable TSC,
go with the simplest option.

Fixes: 7539b174aef4 ("x86: kvmguest: use TSC clocksource if invariant TSC is exposed")
Link: https://lore.kernel.org/all/20260529181213.0B27A1F00893@smtp.kernel.org [*]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 061a22d31dea..29ca37e9a3bc 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -362,8 +362,7 @@ void __init kvmclock_init(void)
 	 *
 	 */
 	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
-	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
-	    !check_tsc_unstable())
+	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC))
 		kvm_clock.rating = 299;
 
 	clocksource_register_hz(&kvm_clock, NSEC_PER_SEC);
-- 
2.55.0.rc0.799.gd6f94ed593-goog

