Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDF62135A8
	for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 02:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622777; cv=none; b=b809MYu1mz+XaxWJDKZTu5tsyhxlAyPJXhfnkHmg2oUrQtmTijjfn+UAGtOTO1N4vtKRFpSpoB6OpiAyKdUZv/yBC/Zc9pUCWEGHEHR0k7YrL3Q5/5daJPd4CfMToHvqTKFqcthAHfjf4MDfNVL6C9tG3Mo9xS7WPVRrq3vRY60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622777; c=relaxed/simple;
	bh=MgbzTWQ5O3po+uvgZbmYvyZGhklKbSd0kRHueynvX0o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ETdSowYko+b98fxHOivapmPLuC2tXxN0z11eF/G/IY5ZNm2GInWnaLHWJ/8hAPpQOXbBb3VmSmhskHN/mNX4nKhh2p2/Y8WHseIb4T3gz9XwnJWDCWMq9RkKnYtsph2ivDRHKl8RmnG+WsqzkCB+N3rmR5R/FNt/hm85axHXueU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bu+pE25t; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bu+pE25t"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2f2a9f056a8so981931a91.2
        for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 18:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622774; x=1741227574; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=+aPHxZSdvUlWxMuV2uSxypL8fcuaMUyvD+y52Dh+Bv8=;
        b=bu+pE25tEoCfwPyM73rH995uvwtN1zjU1CcZa+zDVvOavOdarBAgvghOnfPRtB6zk0
         1CLypIn57S+FH//cXT+pQiHF4ocPDfR/5vYTVI9tpXpDT7KSgti5+C3RQcqjNYR3NS3v
         erKntwCdSS0CUEYM5NY8vz7eIVQfle/X0i+vg37HyCVekSPrfYDQvXs5jUo1xor1locv
         OVpak6xIRzqo2QpiV6R+y9H8VdZ1TZ+gGVBQ3RCQvuM1fEqogok+l8dQ1rdPrI54xcK9
         TpFMMoyTvXra46ydJ05NRchNJiFkIc7nfI9+TWn8WR2DI5qSG9AK4Ui/RXP4Ute4gAlW
         +vHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622774; x=1741227574;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+aPHxZSdvUlWxMuV2uSxypL8fcuaMUyvD+y52Dh+Bv8=;
        b=jLweAJtTzM5hgcGgRqrmcEaLMts3Vz/OA3B+s2VQYrUynMZFfGTpIBHvMLM9EazFMa
         MwbGmobLgKQ6LKohXqiEmeAKlBrGfSFrCTXh5kace+cZLC6cl7H35NZ7EjOM+3tXcYE3
         l4BnbT5IMIheE9ADfVlV2VuEzuoFtYoSZBxRnMoG5iZcaXWen3sBhuS62wLIBlV7Q/aA
         bvW1yStYS30wbjhaQoYh+fhuMuItOBN9BOK/TcF4sCnWphWL8Zs5W/WKMpG3jtiuf1ZU
         W8kUgNXMq30TjTIi9qphC5DrJlTaVgALjG4f/8tk2I+7pbaHQbV9GiiS1IAx5GFDAUUf
         QkPw==
X-Forwarded-Encrypted: i=1; AJvYcCW6TXD8/D+PICbQGt2YBt/A36iXQEAHsFlglgJOJKGBK1UsgI29L0IV9jQZN6iqPre1czys0bYr0A3YpKzEwA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZc1M2ofclil/8B5lXD6GJKS15AuEW3l+X9oenmmBTooE5wh18
	KHbrKZRIeirgjxieFAd0kAnKflgcq+17xZrcElvAynowwBNfM9juhofJc5jOy4rPPv6S6e3mLmP
	M7A==
X-Google-Smtp-Source: AGHT+IGtJhSaBP2AlM0Njvk3g8X/xMhIC1fqVJrfdIV8pKqmQJT6ad+58HkgFke1VLmpWg41h8WiiOdBO04=
X-Received: from pjbta3.prod.google.com ([2002:a17:90b:4ec3:b0:2ea:448a:8cd1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5483:b0:2ee:f076:20f1
 with SMTP id 98e67ed59e1d1-2fe7e218ab9mr10711632a91.0.1740622774461; Wed, 26
 Feb 2025 18:19:34 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:34 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-19-seanjc@google.com>
Subject: [PATCH v2 18/38] x86/paravirt: Pass sched_clock save/restore helpers
 during registration
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

Pass in a PV clock's save/restore helpers when configuring sched_clock
instead of relying on each PV clock to manually set the save/restore hooks.
In addition to bringing sanity to the code, this will allow gracefully
"rejecting" a PV sched_clock, e.g. when running as a CoCo guest that has
access to a "secure" TSC.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/paravirt.h    | 8 +++++---
 arch/x86/kernel/cpu/vmware.c       | 7 ++-----
 arch/x86/kernel/kvmclock.c         | 5 ++---
 arch/x86/kernel/paravirt.c         | 5 ++++-
 arch/x86/xen/time.c                | 5 ++---
 drivers/clocksource/hyperv_timer.c | 6 ++----
 6 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index cfceabd5f7e1..dc26a3c26527 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -28,11 +28,13 @@ u64 dummy_sched_clock(void);
 DECLARE_STATIC_CALL(pv_steal_clock, dummy_steal_clock);
 DECLARE_STATIC_CALL(pv_sched_clock, dummy_sched_clock);
 
-void __paravirt_set_sched_clock(u64 (*func)(void), bool stable);
+void __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
+				void (*save)(void), void (*restore)(void));
 
-static inline void paravirt_set_sched_clock(u64 (*func)(void))
+static inline void paravirt_set_sched_clock(u64 (*func)(void),
+					    void (*save)(void), void (*restore)(void))
 {
-	__paravirt_set_sched_clock(func, true);
+	__paravirt_set_sched_clock(func, true, save, restore);
 }
 
 static __always_inline u64 paravirt_sched_clock(void)
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index d6eadb5b37fd..399cf3286a60 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -344,11 +344,8 @@ static void __init vmware_paravirt_ops_setup(void)
 
 	vmware_cyc2ns_setup();
 
-	if (vmw_sched_clock) {
-		paravirt_set_sched_clock(vmware_sched_clock);
-		x86_platform.save_sched_clock_state = NULL;
-		x86_platform.restore_sched_clock_state = NULL;
-	}
+	if (vmw_sched_clock)
+		paravirt_set_sched_clock(vmware_sched_clock, NULL, NULL);
 
 	if (vmware_is_stealclock_available()) {
 		has_steal_clock = true;
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index c78db52ae399..1ad3878cc1d9 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -136,7 +136,8 @@ static void kvm_restore_sched_clock_state(void)
 static inline void kvm_sched_clock_init(bool stable)
 {
 	kvm_sched_clock_offset = kvm_clock_read();
-	__paravirt_set_sched_clock(kvm_sched_clock_read, stable);
+	__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
+				   kvm_save_sched_clock_state, kvm_restore_sched_clock_state);
 
 	pr_info("kvm-clock: using sched offset of %llu cycles",
 		kvm_sched_clock_offset);
@@ -343,8 +344,6 @@ void __init kvmclock_init(void)
 #ifdef CONFIG_SMP
 	x86_cpuinit.early_percpu_clock_init = kvm_setup_secondary_clock;
 #endif
-	x86_platform.save_sched_clock_state = kvm_save_sched_clock_state;
-	x86_platform.restore_sched_clock_state = kvm_restore_sched_clock_state;
 	kvm_get_preset_lpj();
 
 	/*
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 55c819673a9d..9673cd3a3f0a 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -86,12 +86,15 @@ static u64 native_steal_clock(int cpu)
 DEFINE_STATIC_CALL(pv_steal_clock, native_steal_clock);
 DEFINE_STATIC_CALL(pv_sched_clock, native_sched_clock);
 
-void __paravirt_set_sched_clock(u64 (*func)(void), bool stable)
+void __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
+				void (*save)(void), void (*restore)(void))
 {
 	if (!stable)
 		clear_sched_clock_stable();
 
 	static_call_update(pv_sched_clock, func);
+	x86_platform.save_sched_clock_state = save;
+	x86_platform.restore_sched_clock_state = restore;
 }
 
 /* These are in entry.S */
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 51eba986cd18..3179f850352d 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -564,13 +564,12 @@ static void __init xen_init_time_common(void)
 {
 	xen_sched_clock_offset = xen_clocksource_read();
 	static_call_update(pv_steal_clock, xen_steal_clock);
-	paravirt_set_sched_clock(xen_sched_clock);
+
 	/*
 	 * Xen has paravirtualized suspend/resume and so doesn't use the common
 	 * x86 sched_clock save/restore hooks.
 	 */
-	x86_platform.save_sched_clock_state = NULL;
-	x86_platform.restore_sched_clock_state = NULL;
+	paravirt_set_sched_clock(xen_sched_clock, NULL, NULL);
 
 	tsc_register_calibration_routines(xen_tsc_khz, NULL);
 	x86_platform.get_wallclock = xen_get_wallclock;
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 4a21874e91b9..1c4ed9995cb2 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -550,10 +550,8 @@ static void hv_restore_sched_clock_state(void)
 static __always_inline void hv_setup_sched_clock(void *sched_clock)
 {
 	/* We're on x86/x64 *and* using PV ops */
-	paravirt_set_sched_clock(sched_clock);
-
-	x86_platform.save_sched_clock_state = hv_save_sched_clock_state;
-	x86_platform.restore_sched_clock_state = hv_restore_sched_clock_state;
+	paravirt_set_sched_clock(sched_clock, hv_save_sched_clock_state,
+				 hv_restore_sched_clock_state);
 }
 #else /* !CONFIG_GENERIC_SCHED_CLOCK && !CONFIG_PARAVIRT */
 static __always_inline void hv_setup_sched_clock(void *sched_clock) {}
-- 
2.48.1.711.g2feabab25a-goog

