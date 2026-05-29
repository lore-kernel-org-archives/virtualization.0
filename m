Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074C43FF89D
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067302; cv=none; b=sIyEJMugEXuOaWd2Khu3DLZXr/hVgEHwuuFwM/AXyNtC5IoFk1d1HnBK0FZ4Zb5/4nSDHgTamH5A6YrsPAereIZWMR4J560HkZRMhw6OO9WwzbgzQv/SXJIDl+m2w4H6meJcdJ/KqThV0L4vNyESe2UvemFpW07lKy8enoOf+Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067302; c=relaxed/simple;
	bh=FXFmm/bt28qzsjhzY8TENCjzEiTjb//R/uZtmzqCTi4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pz/jag+KztiHaq7+UUSHi2ADNHjcFBSuHaas5sC/0EKpHVlnnwU020M2MjrJm6Fg/Baz8Ib72BxpR60IFhPhqOu1u7S7Q58DFmyRbgqCsenrjR2Nt5xsvMRb8eKAySwjrX0cSuab9sSCDsyfTefoyDD55AgRoSHvJlKM1n7a3P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c5q8xQ1s; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c5q8xQ1s"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8292e18166so7029773a12.3
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780067300; x=1780672100; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=hiLxlYw3clwD2dLxI09vlAh7vN9DHw/HVEHbWWzJKBk=;
        b=c5q8xQ1sqMsQage55n1jnExZR/aIzh06HJ+305hBeFwjsIcMb6L+NQcMEav1saoISz
         uZH85YfueLdJoBVpb2d4Ort8yied5IGxH2uekkdX4ARDYJQAQc05KvkVZMY28x/38sw3
         m0H+ynKxJHA9li1DlYpbyoJuk0Q/SJ0WXgN90kMoiE6HtThrwH1pVPsBDihIfeWbI4Ll
         4Rf3c2fDHvwsehAd6ydUmVVM5hpaz4CH5UXh73EBdKO/4jV7Mp1tdxCyOU8BSh98ZEsM
         ZWuNFPvn9Cc7n9Nqnwq+KwZOvpdNmlznmPAbcKgOZajh+FnC2lsfAwKD+eocnrT+RzJK
         clMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067300; x=1780672100;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hiLxlYw3clwD2dLxI09vlAh7vN9DHw/HVEHbWWzJKBk=;
        b=smsQUmw95jzFZmFXuOsyAMdYs9O03lzTtKilf9w9lCrsVW8hzvMOeC3RrEIyktgJ+b
         +8JLVWy2q4sm8nl4/tMHk+r6aAbvpPWnn7TFl2VJRRBt/dYuMSwIn4s7zBtZSCQjubcd
         3VJ0FDbLANT6wd8JcyG3MCU4ouBOXOZ85DqRl/vsomJLQhMU0+496j7w0FF2AL2xMJUw
         yyLutxgXiblAWSXygFV+yxsI9fBlgJ22fvFVIw6umorL5L4u3aA3rUmMvIZj6Njy2+L7
         cJvAP5lIbzY/W5wFUipvHvBQFRqzf9BhunYkVvA7o25eMdj7Pod3fuNKCRVU0yXnU245
         rSLg==
X-Forwarded-Encrypted: i=1; AFNElJ+BCtx9u8RU/t6atqwGhLYx8a9eIMmpIlxOsQq87l+UfG8rK1pdVCtDBCthjQ1FAUNJFDm9IrSB9piwDQhyDQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzpkoe5gSct3U4g119kNvdeZDzZsEW2NgT92JVPJPLLphXc0iVA
	gC32pGd/2NpCtvc/6TEG7/HXBh3+GFZFYQFmTICpwwbUjH6+2Wib/8Uz9yQHZ3wgiToyHQxuXNz
	QEfYZZA==
X-Received: from pgx6.prod.google.com ([2002:a63:1746:0:b0:c79:81bb:79ef])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9149:b0:3b2:a958:a725
 with SMTP id adf61e73a8af0-3b411e478f7mr4139551637.41.1780067299927; Fri, 29
 May 2026 08:08:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 08:08:18 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150818.714760-1-seanjc@google.com>
Subject: [PATCH v4 40/47] x86/kvmclock: Hook clocksource.suspend/resume when
 kvmclock isn't sched_clock
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

Save/restore kvmclock across suspend/resume via clocksource hooks when
kvmclock isn't being used for sched_clock.  This will allow using kvmclock
as a clocksource (or for wallclock!) without also using it for sched_clock.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 4e304f1c887d..5dfac79a5d30 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -131,7 +131,17 @@ static void kvm_setup_secondary_clock(void)
 
 static void kvm_restore_sched_clock_state(void)
 {
-	kvm_register_clock("primary cpu clock, resume");
+	kvm_register_clock("primary cpu, sched_clock resume");
+}
+
+static void kvmclock_suspend(struct clocksource *cs)
+{
+	kvmclock_disable();
+}
+
+static void kvmclock_resume(struct clocksource *cs)
+{
+	kvm_register_clock("primary cpu, clocksource resume");
 }
 
 void kvmclock_cpu_action(enum kvm_guest_cpu_action action)
@@ -201,6 +211,8 @@ static struct clocksource kvm_clock = {
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 	.id     = CSID_X86_KVM_CLK,
 	.enable	= kvm_cs_enable,
+	.suspend = kvmclock_suspend,
+	.resume = kvmclock_resume,
 };
 
 static void __init kvmclock_init_mem(void)
@@ -296,6 +308,15 @@ static __init void kvm_sched_clock_init(bool stable)
 				   kvm_save_sched_clock_state,
 				   kvm_restore_sched_clock_state);
 
+	/*
+	 * The BSP's clock is managed via dedicated sched_clock save/restore
+	 * hooks when kvmclock is used as sched_clock, as sched_clock needs to
+	 * be kept alive until the very end of suspend entry, and restored as
+	 * quickly as possible after resume.
+	 */
+	kvm_clock.suspend = NULL;
+	kvm_clock.resume = NULL;
+
 	pr_info("kvm-clock: using sched offset of %llu cycles",
 		kvm_sched_clock_offset);
 
-- 
2.54.0.823.g6e5bcc1fc9-goog

