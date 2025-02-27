Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345351ACED5
	for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 02:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622788; cv=none; b=ua/v33U/wstPLp9V25mB8OQ4xYf5D+xNU/3ukbuE3dJKHZQ3wLZBPhWZLO8hhtxXblTePX+OHPO1RZCVnP21oWD8wh39KOGyj4U/HUxa1rm9s4XNn+4RwKfzTZWVm16rouVg1AUycw4Ai6I4O1zU6opl6BcathhTWwODDM0dDNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622788; c=relaxed/simple;
	bh=zjjnD8AWfMJS2/xbCkWD8FS8YCODvYXqFbARM/Ts+/s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PnQB6AdRplWUqMgMjwhQ34oyYDDYrKkZnCEJylOTo5tBOCgsNaMdDkSH0CpwTdthbvh9kMfdxyv4dIOV/3dV8Biw6KqeXXX9Y7m+naDb8Lk1ZSz9acBZmiwV7Bvu8rsIGWj/zHz4AXUq8xEcaByegdjytkr++7I1Qq2qT4mycmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=srqxU/lr; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="srqxU/lr"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2234dddbd6fso8510405ad.0
        for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 18:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622786; x=1741227586; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=3WIlT5dxc8eqreSuMAUxshuXGBEM8C/NLPwcD1zy3Y0=;
        b=srqxU/lr7W/NKyKI2tErwOkyUNziARMWiy32bc8sbzPikLiFeRl8XWxAEyr4J3SGGL
         UetJDLlHQHsERAUEDOlwR1bujMHp9I0iNXA2N1kws/YgeHXFGciOLGmxpB5CHYogpJQi
         ktmKcSsOrMxoPmyAUmW7BD/mdRrxTawCj+tMKYtcdOIuaY0CN0WkzgcnfevzMYKxt6BX
         eQISNCzYoBLcVGAcIQgW+LMbez37wjz72KNnr5m+gN7amYRfPzlkM+WyUPM8HC38dsLF
         KuFUgNYuB/1De0m2zFStiDySihijPMg5OfG/7ESLk6HHjQGH8sdiMd/vaI5HP2F3tpGw
         4U+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622786; x=1741227586;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3WIlT5dxc8eqreSuMAUxshuXGBEM8C/NLPwcD1zy3Y0=;
        b=EJqUAjyxU2oeP5T2UH3pOjCbb8CI2WKinCYYuiWw853pUrpQgobH4TBFx6m0H4fMVj
         vjNwusMtRv2YIqs8OEaNAaXSzyQU1u5qP+Lqs7b/JodYbr3pM0z8TLcuN2LlyGeQWpOZ
         CgV1WcvZnToUEtUWCKOzsc3ZnJFIJ7vzroxB1XMBp6HP1JaZ46vqaKLvcJXsSOY5vD8r
         xN11vfoDjleIsIlAAfyQZRkjt4Tfz+y863ZdN+bA/BN83aiwSl7Pgx/ElAUg66daRLMT
         R6Xds6AaN4FQ8xqtFgQxQ317z0JSHv1gqs449bYf5mQA8kbDPZBX+8drqTY4ub6ayg2f
         O/OQ==
X-Forwarded-Encrypted: i=1; AJvYcCXz7w1bEvSYXU5JAwCXVl74cwcRq0M6DPBbJqae3fzNdIq6+CWV8ZKV3+t7enKDY6tS29gzUiA6Ma6gatWitg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyEcIxpIBlIMR8Vw8Ok3AL+Cp27jRLMrzl1odDAoPs8MPTan3KZ
	0tHvmOerr33mOmcgq/hEQXvJoqfFCcQFw/HyJny34uHjeDYCRISPJazp1iWVaS5inb8FKhxTFvP
	TGA==
X-Google-Smtp-Source: AGHT+IEKa+U3XmhHVLGnMc9mY3OxJMjJ1pR3+E2erpOOt4xnyyZwND9G3ZoTVgYNZ7eny0ZZLwJ5fe0HKa8=
X-Received: from pjvf4.prod.google.com ([2002:a17:90a:da84:b0:2ea:3a1b:f493])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e80e:b0:21f:3d0d:2408
 with SMTP id d9443c01a7336-2234a28af91mr27386885ad.10.1740622786458; Wed, 26
 Feb 2025 18:19:46 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:41 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-26-seanjc@google.com>
Subject: [PATCH v2 25/38] x86/kvmclock: Hook clocksource.suspend/resume when
 kvmclock isn't sched_clock
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

Save/restore kvmclock across suspend/resume via clocksource hooks when
kvmclock isn't being used for sched_clock.  This will allow using kvmclock
as a clocksource (or for wallclock!) without also using it for sched_clock.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 0580fe1aefa0..319f8b2d0702 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -130,7 +130,17 @@ static void kvm_setup_secondary_clock(void)
 
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
@@ -295,6 +307,15 @@ static void __init kvm_sched_clock_init(bool stable)
 	__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
 				   kvm_save_sched_clock_state, kvm_restore_sched_clock_state);
 
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
2.48.1.711.g2feabab25a-goog

