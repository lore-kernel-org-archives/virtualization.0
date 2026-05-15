Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7041F37472A
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 19:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872854; cv=none; b=TJuIl6E3CKMT16fmp1zq0x5O6F/E0Nx45NwDEmkhXcD3S9T9+8MPSSPC9x/jTIRAD3y9iXki1Zpm4p6AuTm7dVNYECSM3Jc6PVOozSVpALdXr6StpMo7OkTT0fUoPFn8KCNcmtXx6ZyjQNyM603MTpRErMZ2JqQcSVnvzb2sze4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872854; c=relaxed/simple;
	bh=MgerBvYEE19VEGmb0jwZ6MxNxLG6DRj12L8dn18zHeg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l9uWvKCkaxVRKVZuS2VakFP+3szL2bgPfPOruF+y5MhpsqRz/9bWSOHPv7mPFwhZMAC+dsuYbyDmbOptwJFlETphw27s0bHyVTJn+hQYcent5IGWcunV1lUHKPjH+lqrFtyWrh3SDIWBStUuVZaVTTeladToqcyb2xZg+vHOHXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MqsAnxT0; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MqsAnxT0"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-836cfd84728so39219b3a.0
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 12:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872852; x=1779477652; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=pABxqq/LCN+Mp4/TOmuyDPyBXfPq+tAOVmlCcYLwmko=;
        b=MqsAnxT0v74LviCbgAqLWPefbYlMT561AD85cfJEBH8RUVXXJvlmf+vQcpgdQQaost
         SoMJWw/H8PJtrKIgDMmcZRg29gl92bsVpE7wamSR6W/skK3IeIdq/ikIn2tZaYGhOTMI
         IF3Zy3M3+arXVcv/mPHk7XUvFlOFKBQ5IvmFCPwDqE8iPz/oImFiKiUOvrh4hnK35/vV
         uLEZHJQE0GHsTEVpFWzGgLl5hX52iIqlu5XqCwAsOJQV955TyHs5SErHmg8TF3DFI615
         kgqRX+ejXydAJM5msbjOnTPOHpPDvdelsraQ/qBx1+lyE0yFwRNvjqGlj3uoNULK4LLR
         GgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872852; x=1779477652;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pABxqq/LCN+Mp4/TOmuyDPyBXfPq+tAOVmlCcYLwmko=;
        b=HNvHjvc64ejPrQU/yffKI8nuzj6S827TS8znJrg+jHrqHC+fSzkEOjgYSqB4vFjueT
         p8wFSX+OIu7w93zMhvjGPsz4ZcjIU6z6MqI6DN3kcF7X6hHAS1B9IKjF3MdknbhhyEaC
         +Ev2nShZXdX8TOsCFExOGfcY5oFza9DOjLnqAZ9ipTBTYrAG07+pJ0DdNJA8B8NZNr5r
         JLCsNvEdILSNRuIMWujrpaTW5TldopZySDa+MXlA1z9alTkjX69+fnbN0qssd3bEr7Kp
         veJU+HsSZQotOdO9zkghyfKdvSQicaHaJkfNdknofW+7YTV/jh3tte6oDdVXCf4SdfBR
         Rl1g==
X-Forwarded-Encrypted: i=1; AFNElJ8Agq0gka0I/DhkgG5fORdcG9kcL+3SU1cbEy4iuaSHW+pxhxUTaS+ed+/h//k8vyMgXajvanj4MTEZr2csGA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6yrpenEYCN6ga7+9xnuKlJR6/goaKv3v0qnobe033KDDGlH+q
	WRr0B/pxW3QKei4zwtYgvwPQQBCKwezoiX2N3noJgMtGhs/AG/5Ym8ig1lsAjgcD7AGPYWiw/7r
	0UVjJfQ==
X-Received: from pfblj16.prod.google.com ([2002:a05:6a00:71d0:b0:83f:22c:66ee])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:801b:b0:835:51fd:b7e9
 with SMTP id d2e1a72fcca58-83f18e75ed2mr8194934b3a.20.1778872851317; Fri, 15
 May 2026 12:20:51 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:20 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-20-seanjc@google.com>
Subject: [PATCH v3 19/41] x86/kvmclock: Move kvm_sched_clock_init() down in kvmclock.c
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

Move kvm_sched_clock_init() "down" so that it can reference the global
kvm_clock structure without needing a forward declaration.

Opportunistically mark the helper as "__init" instead of "inline" to make
its usage more obvious; modern compilers don't need a hint to inline a
single-use function, and an extra CALL+RET pair during boot is a complete
non-issue.  And, if the compiler ignores the hint and does NOT inline the
function, the resulting code may not get discarded after boot due lack of
an __init annotation.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 962b6fcb5c60..8df6adcd6cd8 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -134,20 +134,6 @@ static void kvm_restore_sched_clock_state(void)
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
@@ -304,6 +290,20 @@ static int kvmclock_setup_percpu(unsigned int cpu)
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
 void __init kvmclock_init(void)
 {
 	u8 flags;
-- 
2.54.0.563.g4f69b47b94-goog

