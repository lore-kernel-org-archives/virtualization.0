Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE10640D1D3
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 19:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872870; cv=none; b=RkrGJCJrJ2Q7EbMb0Lzs55KQCZEbblmQqFV1OXkuFvHtphW35uMBWKe4mX3v+CM8vC8jUSYzDrv86VrYrZJxxeqEABPhfUCCTEX0mgvEkmtm8Yp42ESCYpQ82vAq7LtRKkmJ3/0nvKGaSZnkJhSPng/XTbKFzDaHlB8PQtzlgBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872870; c=relaxed/simple;
	bh=wHV+tqsgKZeHCNlwzMKQ+ffX2tGbMars+kUaRwUmZDQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sc+q3Fp4UXVUbk+SBWZ2RjhetHrnuDWmCPT6GqA4sq6P2BzcT4qcVv+sCrFt4dNA2NHCklKYxfcxlwhbUWfFo60FVU72gH/1w5tkHsSx6lSaYxiNHS29qXdM01nyLKACpIAH5GeI6b5OUrC+dd+KJHDjJom9DiDnbcHyQoX6vuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l8mHcj5T; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l8mHcj5T"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-837cc5bc6deso94520b3a.3
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 12:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872868; x=1779477668; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=pNsHSCzVBvNpSbb8atgOEwFmCd7ur8peJFPmwL2u2ME=;
        b=l8mHcj5TJ45ielZDuyAV3lL/aD6zXH4YgYqsjpQMDQv7vYnY8hPgd/AoOOSfMVZQIe
         3b15nkRuw5wv23+frtjEnz6j5pqWkppgSTu/cysmpaJX2W0JwkCUK4efI6NaArfgmSam
         bdr2CYT+udqRyahYFMCZYUm+XsV7ptOPYkl1lxaCeGHayPMVgtUp5FqJpyfPsjvKcvoL
         gQ9DHtz6MNyOqiS3uvbC8QDnucqqmg6JYtByYkSXx40MAbX4NakSlmG1W+a4RXjfGMBI
         M1uJb6sI+IRsod52Es72biDxvJGQYIPMQahn11mhCguJhxQl0Uoq9xWfu8BAeBK1IISn
         gn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872868; x=1779477668;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pNsHSCzVBvNpSbb8atgOEwFmCd7ur8peJFPmwL2u2ME=;
        b=l2hl7UHPC6CHHKa5M3+1JNQx+k7pWifIYHqVLXKFJZUrE2RszvSZuuGNN56nKZEbef
         ZJK7fIPIzYp2TCp1QNHRmpi77CwDh/C6SBShq/VqMvuc2RDO6VvUy8bHkYGEsFzTlISl
         Ozu8VzEr2673mm7IHvaeMo6Q7228s05dwwJeNY2OL5JQxA21Ovg4ffybUv9sNm6C9nFA
         nAdXBKbHe+3m9hEvSCL1XXdnYCvQO7zR6dKbGN2MBCPqZfIuz6UJuWr8XoYBvqd3zALi
         A7fzoRl2TDr7DVe6hOefRHH3v4CxuDI+lRrsiJkdxmXzjDofzCdt16Mt464xfy24tZag
         ldqQ==
X-Forwarded-Encrypted: i=1; AFNElJ/mscZ0ZgKYHhemqbkSybSXQPJomc35PSVszLKOkwlgpab4FnpjZ5wZZozOPBMg5FdqASaWj0heqTI+f8ZX/g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwUHHZQFfi6fzu9aA7ugp56wHj4WE/JnEPnKVsw2eQ37SRJypMi
	Ku6JT1tkcOB8Lbs3H6LIAbnEMu7difNLbKOIKsEunn7FBn3AUxrVZNZtME2cuB4AG3opYFRbjCg
	7MYClpA==
X-Received: from pfra8.prod.google.com ([2002:aa7:8e88:0:b0:83e:b125:ff3c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3005:b0:82f:29fe:7239
 with SMTP id d2e1a72fcca58-83f33d3659cmr5558676b3a.50.1778872867738; Fri, 15
 May 2026 12:21:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:30 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-30-seanjc@google.com>
Subject: [PATCH v3 29/41] x86/paravirt: Plumb a return code into __paravirt_set_sched_clock()
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

Add a return code to __paravirt_set_sched_clock() so that the kernel can
reject attempts to use a PV sched_clock without breaking the caller.  E.g.
when running as a CoCo VM with a secure TSC, using a PV clock is generally
undesirable.

Note, kvmclock is the only PV clock that does anything "extra" beyond
simply registering itself as sched_clock, i.e. is the only caller that
needs to check the new return value.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/timer.h | 6 +++---
 arch/x86/kernel/kvmclock.c   | 8 +++++---
 arch/x86/kernel/tsc.c        | 5 +++--
 3 files changed, 11 insertions(+), 8 deletions(-)

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
index d3bb281c0805..9b3d1ed1a96d 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -338,10 +338,12 @@ static int kvmclock_setup_percpu(unsigned int cpu)
 
 static __init void kvm_sched_clock_init(bool stable)
 {
+	if (__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
+				       kvm_save_sched_clock_state,
+				       kvm_restore_sched_clock_state))
+		return;
+
 	kvm_sched_clock_offset = kvm_clock_read();
-	__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
-				   kvm_save_sched_clock_state,
-				   kvm_restore_sched_clock_state);
 	kvmclock_is_sched_clock = true;
 
 	/*
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 4a48b8ba5bea..3c15fc10e501 100644
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
2.54.0.563.g4f69b47b94-goog

