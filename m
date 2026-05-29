Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98326402B8A
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067309; cv=none; b=Fl6MI8qfK5Qa97wzsDY6HwNUknZpJuVv28J+Nwf1f7tfeZ0NMMCW09SXdsEdbC8SAyrqmPehHTwP/g8Z64qwdmMpgfDg4JCNVPGnDu8UDP+J2jRgIwOv8GsSoayZ/BxjrZSI1j67Tbc01zxToy9gesiBgogfaM+zXw/B0+rxsJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067309; c=relaxed/simple;
	bh=fmtwqTBYkb6t5vw+7MpnJ0D/yvZROFNekcfkLoS9uAw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s8HS0VFYB+a9+iDlsLBHYIMYHdEADgB1JOdYLG6U9skbaB7hJrkkQEvOX2yyIwHDIXgZRKHOeYoh7voCJvXp6tMYBkbbrKiug8itlooVGQaAqunFuWVtOSiye5eplN8i2chxCVq26CyKnGAHpi0+Su2A/OlJkfwYVXPVyyrf4kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MG9RKF3g; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MG9RKF3g"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bd6aeb3637so313114685ad.2
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780067307; x=1780672107; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=2eZ/5/NHYtlqNBUgYS8sS/KxrmMqlqE8QNmqFczaR90=;
        b=MG9RKF3glC335gR5y/QED5qDATLF00Dq0ookxOGz33iypRKOJ5AzvHfGpybQEYRA3j
         XmpqF3v368O4wlkhxdceyErRWfoMh9Z8Z7/f61IC6MFDR3tSnzNwz4ZsRsPLE9GTVpHw
         orC7nud+n/5DxBP+qzr8Lwwk44jh3Q73ReOnEXcw6dsqbXeDYlQZKqfogQwVdpK0ColT
         5T8a0TQTPIt8jLa+4t5vRxkoYGa6ie3AnYXNiBgwlMby55rLHCPdgPaB2eBgMFN5S+aL
         hvGraM1nPhO4mbNxqHyKbypdRk6lfs756XX1aPSW9GhDaOwjjf6oHL0WtydXI0mSBx7k
         kovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067307; x=1780672107;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2eZ/5/NHYtlqNBUgYS8sS/KxrmMqlqE8QNmqFczaR90=;
        b=Wmjf0//ak8QKcjE6MVVfoZRjP55l+dGlb7ETSxRk5iABXe+f5ROHya8ZqzK8CjtzYI
         fGh0D3OdF2DzMEZZKJdGxDn6AFuM+no8cPzJgA3IcaN5xKLSk3X8NpQ6uvSA9MTLI14/
         rtLxtgW3MT9TtP3A0lg85yAof65ToLi2R2CAQhEGicBtSNJDWB6xRtOflGcg923KRXRI
         U3wkusQHeVR3LYe3zlRUN7MnoGfFMT7tnHz19XYarZ+h/yKqYXBt728dJsmDjjE6f5QL
         d7HgV4vOtwiCAp39ZCKLgJDcNDp8DNZf29R4C7VZWeXkY1vaJ2T0eFVoAFodHBS8uAeZ
         stZA==
X-Forwarded-Encrypted: i=1; AFNElJ8/tpaYovpzS12zh090HaamcKiWe3nKduqa+2SK9eRJ9UynRWjVV79amRltB9q1Z2VTUs4P/QxCNRW1RfZ+pw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJg2N0uygreSkYdQoxwl9k9oGqa/WUbP16MwfOfx6L77KgumZ9
	zUQsQd7QDy1erEsxk+VurcjyW87vQLCbSQolz7u3WYnc4lnugKV8/WyO5yd6suQyQz70nHrjuMA
	MdnvCag==
X-Received: from plau10.prod.google.com ([2002:a17:903:304a:b0:2ba:67f8:6257])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c94c:b0:2bf:604:d5ad
 with SMTP id d9443c01a7336-2bf368904abmr2085275ad.37.1780067306314; Fri, 29
 May 2026 08:08:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 08:08:24 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150824.714934-1-seanjc@google.com>
Subject: [PATCH v4 43/47] x86/paravirt: Plumb a return code into __paravirt_set_sched_clock()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	"K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, David Woodhouse <dwmw@amazon.co.uk>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Add a return code to __paravirt_set_sched_clock() so that the kernel can
reject attempts to use a PV sched_clock without breaking the caller.  E.g.
when running as a CoCo VM with a secure TSC, using a PV clock is generally
undesirable.

Note, kvmclock is the only PV clock that does anything "extra" beyond
simply registering itself as sched_clock, i.e. is the only caller that
needs to check the new return value.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/timer.h | 6 +++---
 arch/x86/kernel/kvmclock.c   | 9 ++++++---
 arch/x86/kernel/tsc.c        | 5 +++--
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/timer.h b/arch/x86/include/asm/timer.h
index 96ae7feac47c..ca5c95d48c03 100644
--- a/arch/x86/include/asm/timer.h
+++ b/arch/x86/include/asm/timer.h
@@ -14,14 +14,14 @@ extern int no_timer_check;
 extern bool using_native_sched_clock(void);
 
 #ifdef CONFIG_PARAVIRT
-void __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
-				       void (*save)(void), void (*restore)(void));
+int __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
+				      void (*save)(void), void (*restore)(void));
 
 static __always_inline void paravirt_set_sched_clock(u64 (*func)(void),
 						     void (*save)(void),
 						     void (*restore)(void))
 {
-	__paravirt_set_sched_clock(func, true, save, restore);
+	(void)__paravirt_set_sched_clock(func, true, save, restore);
 }
 #endif
 
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 73fabfac2bc9..1336c24f59cf 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -310,10 +310,13 @@ static int kvmclock_setup_percpu(unsigned int cpu)
 
 static __init void kvm_sched_clock_init(bool stable)
 {
+	/* Ensure the offset is configured before making kvmclock visible! */
 	kvm_sched_clock_offset = kvm_clock_read();
-	__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
-				   kvm_save_sched_clock_state,
-				   kvm_restore_sched_clock_state);
+
+	if (__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
+				       kvm_save_sched_clock_state,
+				       kvm_restore_sched_clock_state))
+		return;
 
 	/*
 	 * The BSP's clock is managed via dedicated sched_clock save/restore
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 6da0a3ac05c2..7bcf757bf551 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -280,8 +280,8 @@ bool using_native_sched_clock(void)
 	return static_call_query(pv_sched_clock) == native_sched_clock;
 }
 
-void __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
-				       void (*save)(void), void (*restore)(void))
+int __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
+				      void (*save)(void), void (*restore)(void))
 {
 	if (!stable)
 		clear_sched_clock_stable();
@@ -289,6 +289,7 @@ void __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
 	static_call_update(pv_sched_clock, func);
 	x86_platform.save_sched_clock_state = save;
 	x86_platform.restore_sched_clock_state = restore;
+	return 0;
 }
 #else
 u64 sched_clock_noinstr(void) __attribute__((alias("native_sched_clock")));
-- 
2.54.0.823.g6e5bcc1fc9-goog

