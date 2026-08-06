Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824B24A823E
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 23:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059433; cv=none; b=akJvsJOfBsrlQPaYT6PwCdIvVq1k6V/LDSF+qdUL6WjPC0hPuhOJ1P7iEz1dr7OLbbHidbk75lVGwfuGZ6BabIf2JatzEZmIiNdGcVJGHAvnnUif0wcsHAq35b7ttmgxM/ANkcqoof9vpeNQ+Yl6OEBsw3J9u47hGtbAQvwhyto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059433; c=relaxed/simple;
	bh=xQeSz+UJSRzEJeUN758xlvy+p2UjlhjfQlkKcSNGiA0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CRdYEgNNGzHIZZW4Q9Z2kGZaIJCLWjQavWHJtKxLjNrfhCXmT+szf0/6dbXBcN8K9RARMvh0IfU/8biUPSxBP6Nz6sECdHGXabIabpzb3d9ezZtvKYD+zi2/PLhw2TeIfSinpXFLskTwFH73TFM8dBDLK1Q9lda74vUseotBV6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GON7w0Fa; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GON7w0Fa"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc6dd43737so50911675ad.2
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 16:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059431; x=1786664231; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dLl1t0qRZTm556OBeVqKVx/DHfexmKODeXAiUOaDm4I=;
        b=GON7w0Fau1eU/8ss23k6MPhtbgLvJ1+B5lUypUQsoROsnz5QoUUl32GPy40uCo4SX3
         IKoBv/uIKPFDNuH8WhFgHWB6cnlfGldYaQJi7tNFhZtgIUXeTbz23ctM53JsN8B0vk52
         N22VGsEdGPaXmQIOrJQauQQ6QzKlEuO+dyzxg29n5aId2sV20X71GYI8DK+K58reHJ2M
         LGc3dSRdbxwj39ucI49l5wp1rKZTR2d7iMQZiV1kzo/zytcReBt9vOio0qIm9c/enATj
         E/9M3qpD6dT0tZMfKBED88Xifhcdm3voreLy9VvRJU7TvDQGxA/Q7N11tCB5p8S2IIlx
         LWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059431; x=1786664231;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dLl1t0qRZTm556OBeVqKVx/DHfexmKODeXAiUOaDm4I=;
        b=C24XytFtJWvxN/Fef7+bpMVoh9Dbl7ZpWPuIKT9KYtPl1v6LplCIpDRdzrmN3HKHEv
         ufQIM2szdDDObbsd8/HFKvGitFujwyk4J/eI/T1pPuRUVBAzrZSMc53NOvVzcSCLd43Z
         9HBPv1Jzy1kYBFSVvDXCfHDzdJ9ttO2oN3W6jWjGPSXInLmCPhpBbw7gUrIkx9wGoGjW
         jzZ1OF9sxEAm8wUlWxq47+ok15AaCoDvprHk9deQU2H/B4DjJOUr8NmF4aNUG5Y6cLYH
         AcGqWB4E6/kt54ms5GH+CXyn4DBIPGz6Wmw1MXKIWVQpsots75jLmv6scoZJ9S0BC6oS
         jmbw==
X-Forwarded-Encrypted: i=1; AHgh+RpTkBLjYLIrG8p7LXd9kDnm2jzgMsAXhOUTuKks2LdEed/Slz/v7fDkVi3o79A16/SY2y3KHk5CZf/rude2/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwlRonWQpNNniNWPGjctVawFDgOJBxI2WVEqFWfJle5PZHQl0Od
	g/+9rk4efaC7HG/B2Jh9oPkqvbOZZvM8t4HxJg4DaUKLvGlH6RQ7KDZ5nCbE2jEv88aU/i3ZOzd
	ZrklZqw==
X-Received: from pjzg4.prod.google.com ([2002:a17:90a:e584:b0:38e:b470:e6db])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2590:b0:38f:2168:b9cb
 with SMTP id 98e67ed59e1d1-3903c572a05mr18787499a91.9.1786059430539; Thu, 06
 Aug 2026 16:37:10 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:54 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-38-seanjc@google.com>
Subject: [PATCH v6 37/51] x86/kvmclock: Move kvm_sched_clock_init() down in kvmclock.c
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

Move kvm_sched_clock_init() "down" so that it can reference the global
kvm_clock structure without needing a forward declaration.

Opportunistically mark the helper as "__init" instead of "inline" to make
its usage more obvious; modern compilers don't need a hint to inline a
single-use function, and an extra CALL+RET pair during boot is a complete
non-issue.  And, if the compiler ignores the hint and does NOT inline the
function, the resulting code may not get discarded after boot due lack of
an __init annotation.

No functional change intended.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 5b9955343199..5220d205abc7 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -155,20 +155,6 @@ static void kvm_restore_sched_clock_state(void)
 	kvm_register_clock("primary cpu clock, resume");
 }
 
-static inline void kvm_sched_clock_init(bool stable)
-{
-	kvm_sched_clock_offset = kvm_clock_read();
-	__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
-				   kvm_save_sched_clock_state,
-				   kvm_restore_sched_clock_state);
-
-	pr_info("kvm-clock: using sched offset of %llu cycles",
-		kvm_sched_clock_offset);
-
-	BUILD_BUG_ON(sizeof(kvm_sched_clock_offset) >
-		sizeof(((struct pvclock_vcpu_time_info *)NULL)->system_time));
-}
-
 void kvmclock_cpu_action(enum kvm_guest_cpu_action action)
 {
 	/*
@@ -325,6 +311,20 @@ static int kvmclock_setup_percpu(unsigned int cpu)
 	return p ? 0 : -ENOMEM;
 }
 
+static __init void kvm_sched_clock_init(bool stable)
+{
+	kvm_sched_clock_offset = kvm_clock_read();
+	__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
+				   kvm_save_sched_clock_state,
+				   kvm_restore_sched_clock_state);
+
+	pr_info("kvm-clock: using sched offset of %llu cycles",
+		kvm_sched_clock_offset);
+
+	BUILD_BUG_ON(sizeof(kvm_sched_clock_offset) >
+		sizeof(((struct pvclock_vcpu_time_info *)NULL)->system_time));
+}
+
 void __init kvmclock_init(bool prefer_tsc)
 {
 	u8 flags;
-- 
2.55.0.679.g6767b8d81c-goog

