Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461B11A682A
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067242; cv=none; b=EYXcJtPN78Wza0872+cHMrBe6duwxBjPjPm49FEWoVT+vD/v6XMHqyEA2GRtbRiwEakXSdX9sGD6acQSepKguoREpumdxoQanCLW78bGQAqzQbohsK982sSz75ejQu2ohF5RoyOYz7SmVuv0ZAkMZGrWXTdIQQWbVs+Z0deFTsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067242; c=relaxed/simple;
	bh=/5UTvuwmDWBQP+NjGkI8KUcbqqoDwqf+ns+dipFMGrk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QYPbqRyqunRbstkxXnFG7SrVbG8ACUivF/zQKrDoHLve9eK251BsqFollXwskPeZfTOW9J04nJW0di9uzZMUc0X05oXFp+4WdIQ8gq+ycaqId4CUMXwI+mj3DpjmVMZcBFCN0kJMZBiBoHMxAaETYcDsrAkLrS7Mp8duKNDV8kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EkkrHknR; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EkkrHknR"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf1845bddfso12989625ad.1
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780067241; x=1780672041; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=N49NWH4ro3GNRH29aAKxdd1VwjKE+o/ejmYXSEWUPuw=;
        b=EkkrHknRwHdkpvCFE7nKNh9nzLEEcYgl4l8bH/+x4A3elCRRZdWT7MeAdA89wDy0ld
         /wSpa4iOlILmoBrRDMd63MGfHmzJPtOBfqzzdDcFc2iuYKIapLCH3c7CVvUCz973871u
         hCJZta09/69UUIRLv8XhI1AMQPjgNCFt52jH1BLJ5qnvMd5rRCVOyQVLd0Le4+g65Av/
         wUWCRtNAbE8VYe37TR9bmT13aZasS5Zwp5XNCBLuc+mGmFoLf94PMV5OhRjwkmTKXYFk
         QowZlc20HKcTNYVjw5k5hKLaYgfwpCPPDOd2M0/lza5QQr5PizDUXWXxjilhIL0VwL8g
         k8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067241; x=1780672041;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N49NWH4ro3GNRH29aAKxdd1VwjKE+o/ejmYXSEWUPuw=;
        b=GGHfC1xqM1xBgKdDVMX8TN48rIfJB/D2GSpbKze19e8dtcDMaqzIcKLvIxxIaceuGf
         Nwxffjkb29PVTGpIX6SMk8Sd5hnkHyYbiHel0b7/3sxzJESzrOaS34uJSZlK67SJCElE
         uUtBA1cPsbVQ6GdNDDVFibRBtNGoEYzoW2y9eAhkfGhKQie19rZRXMQavGHONjn9h1JL
         WmnBkWs9GgLXFyAwsU0VS72TKXwiTKcOfDN9Z22+jMKxtwY+pjw+lxAymfAel+5VJTDN
         iHdMSQuwppAkOPZyuJ+waEbHD0v6nACGIWQrGZ3F3X9QkFPT96J5ghYe+J/tCHBGteCe
         XFdg==
X-Forwarded-Encrypted: i=1; AFNElJ/ebL58r8T9ZrlsheHlMDYGlSiwumkCxtso7NYCTzzqefzPdt30cSMRRBSc6iR68KXPVocxQmjCVw+NGRFiIg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywbc3Mu6amKh4WdiEP/au369ouhgMnGIgKO0JYglRH6MiBxDCBH
	0m/e8h+qLkeylxwJKyueYad4pyRQX4Dhi7QkwDgkA9e5Ww5FjoDFIo5t7TZ3xV9t/d2wm8gS3NR
	EbkSq7g==
X-Received: from plge8.prod.google.com ([2002:a17:902:cf48:b0:2be:fc90:7642])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e74d:b0:2bf:28e3:a5e7
 with SMTP id d9443c01a7336-2bf36793522mr2531755ad.6.1780067240251; Fri, 29
 May 2026 08:07:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 08:07:00 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150700.713953-1-seanjc@google.com>
Subject: [PATCH v4 28/47] x86/paravirt: Move handling of unstable PV clocks
 into paravirt_set_sched_clock()
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

Move the handling of unstable PV clocks, of which kvmclock is the only
example, into paravirt_set_sched_clock().  This will allow modifying
paravirt_set_sched_clock() to keep using the TSC for sched_clock in
certain scenarios without unintentionally marking the TSC-based clock as
unstable.

No functional change intended.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/timer.h | 7 ++++++-
 arch/x86/kernel/kvmclock.c   | 5 +----
 arch/x86/kernel/tsc.c        | 5 ++++-
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/timer.h b/arch/x86/include/asm/timer.h
index c71b466d6ace..fe41d40a9ae6 100644
--- a/arch/x86/include/asm/timer.h
+++ b/arch/x86/include/asm/timer.h
@@ -14,7 +14,12 @@ extern int no_timer_check;
 extern bool using_native_sched_clock(void);
 
 #ifdef CONFIG_PARAVIRT
-void paravirt_set_sched_clock(u64 (*func)(void));
+void __paravirt_set_sched_clock(u64 (*func)(void), bool stable);
+
+static inline void paravirt_set_sched_clock(u64 (*func)(void))
+{
+	__paravirt_set_sched_clock(func, true);
+}
 #endif
 
 /*
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 13c4be3a7f0a..4e50e75ff43d 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -12,7 +12,6 @@
 #include <linux/hardirq.h>
 #include <linux/cpuhotplug.h>
 #include <linux/sched.h>
-#include <linux/sched/clock.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/set_memory.h>
@@ -94,10 +93,8 @@ static noinstr u64 kvm_sched_clock_read(void)
 
 static inline void kvm_sched_clock_init(bool stable)
 {
-	if (!stable)
-		clear_sched_clock_stable();
 	kvm_sched_clock_offset = kvm_clock_read();
-	paravirt_set_sched_clock(kvm_sched_clock_read);
+	__paravirt_set_sched_clock(kvm_sched_clock_read, stable);
 
 	pr_info("kvm-clock: using sched offset of %llu cycles",
 		kvm_sched_clock_offset);
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 888bd1cbd9bc..a9b6d3399c23 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -280,8 +280,11 @@ bool using_native_sched_clock(void)
 	return static_call_query(pv_sched_clock) == native_sched_clock;
 }
 
-void paravirt_set_sched_clock(u64 (*func)(void))
+void __paravirt_set_sched_clock(u64 (*func)(void), bool stable)
 {
+	if (!stable)
+		clear_sched_clock_stable();
+
 	static_call_update(pv_sched_clock, func);
 }
 #else
-- 
2.54.0.823.g6e5bcc1fc9-goog

