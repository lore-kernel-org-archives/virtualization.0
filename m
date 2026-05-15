Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC713C584D
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 19:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872869; cv=none; b=S2fD/ZO0ds0/ow7NZz5wvWKGM+JNU7aqJocz0lYCXIr+W8YcZEsiZ2f3Kz6ZEHLuskMhEF7AHqtw/74HuFNEKxZz6sYQfpP9sEUGBw9dpLb5Xir28dFGqp+gmSvDvRbW1gPaFMR57iZQ5CYw5ZFV+8Wab6UyOdydUTioeKarjVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872869; c=relaxed/simple;
	bh=dMZi/ynefGqL3V/hiHHk2W0j93MqJm0B6kXxK/NMi+E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WPVT0aykh4b/k6Z5oqSXbqP7eggfsrXfivvMrpiG1uAhRDJ7EkbQxZnGRdF5Jaml1e3Wphmyp3tYVNN6BM8Cl285IsfhWA0oHqG7icTKdgAy3BDrc5cCTAF9cIDOjT+ifqDvc7d4Fn24rFqiaFyKO1EQgPFXY8EYY4LGZ/AAde4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CMM1eTYl; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CMM1eTYl"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3663cbff31cso245395a91.2
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 12:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872867; x=1779477667; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=czryuinsQM/bDv8Ei5QNsAEKCG27pLCUAiJBy5nMgao=;
        b=CMM1eTYlBOC3LR+IbM7ZLiXNYUIGEhBfNcW4bfoHAmraenHAzyNHLBwD4kw0TNVa6a
         6lUlgIScl156d3xyuO2MewxrsE43EmJ6oCPRjhFQ5C6KlsEkfpLvtcXYz34BJEI6FKxs
         qNQFLIt/YGSTujIeJxMbbDoMqT4S5IzKN91D61O2NJJevxR7fuoX0YmiAGrv3cD0mPNC
         UpBLbel7lMCiBgkOjPvbuPNgK7l7Atjspw4rdb/W43sEyLPDpZzIOZkaBcCf8sq+K48q
         sQ+MJd4i63o9cnO7hqqfGeXxfFamW6MI5O8IKwBgtAbLhWQeVU3TkDdKNVVGja3tKXix
         2/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872867; x=1779477667;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=czryuinsQM/bDv8Ei5QNsAEKCG27pLCUAiJBy5nMgao=;
        b=qc0WtE+CWX7nMwAmIV4yNlJowz90R7pjv1k5GPowUmbdy28tyDHCu8nR5+1gJQi27I
         VLDVqdht2AvSqJdbnQilHUTUcZ6IoKjRh6pDhgUurkmqxyPANbTm6FjDRZh1CocYsvkc
         xG1HXc2HKYOgFPnxZWy6FUvlkK/qDywyUOXUMN5r6qivR6PK0G2YPBzI1pdUTCOZ5JKU
         AmnXdpPpGllqMGMuyqYSDn8l6FsyiJL/k/04P5KkvymsKId/HRvr4uXnmF4TMXjXuzVQ
         LCodr2acaJWSnpZ/1AfzouMBiteM7aMF34LhxmlxhZNAuhOWyvJ+97Y/G2L7SofxdxUJ
         HYmw==
X-Forwarded-Encrypted: i=1; AFNElJ95GuACxmfPqhM5TadOn71FV6J15kwR9zYjzfXNvewvMKPT+RUrPa4+sgE6t+xdVCMxsIo8kHBE4l/G54Hzbw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2Z4JYMKgiNurlWi04Cej3IwwE8vLM9FLNUd0Rfamz/1GNL9oD
	MFNwM2dIYblRWMDmuXPSMVM1ZxkZx5N3YVXfAn8px7XRCqpsd8EricG3NyMXcr9XSZXZgZytiim
	juQjh3w==
X-Received: from pjbiw14.prod.google.com ([2002:a17:90b:420e:b0:365:df9b:ae96])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:4ca4:b0:369:69f8:ad6b
 with SMTP id 98e67ed59e1d1-36969f8b046mr1344290a91.0.1778872866654; Fri, 15
 May 2026 12:21:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:29 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-29-seanjc@google.com>
Subject: [PATCH v3 28/41] x86/paravirt: Mark __paravirt_set_sched_clock() as __init
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

Annotate __paravirt_set_sched_clock() as __init, and make its wrapper
__always_inline to ensure sanitizers don't result in a non-inline version
hanging around.  All callers run during __init, and changing sched_clock
after boot would be all kinds of crazy.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/timer.h | 10 +++++-----
 arch/x86/kernel/tsc.c        |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/timer.h b/arch/x86/include/asm/timer.h
index e97cd1ae03d1..96ae7feac47c 100644
--- a/arch/x86/include/asm/timer.h
+++ b/arch/x86/include/asm/timer.h
@@ -14,12 +14,12 @@ extern int no_timer_check;
 extern bool using_native_sched_clock(void);
 
 #ifdef CONFIG_PARAVIRT
-void __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
-				void (*save)(void), void (*restore)(void));
+void __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
+				       void (*save)(void), void (*restore)(void));
 
-static inline void paravirt_set_sched_clock(u64 (*func)(void),
-					    void (*save)(void),
-					    void (*restore)(void))
+static __always_inline void paravirt_set_sched_clock(u64 (*func)(void),
+						     void (*save)(void),
+						     void (*restore)(void))
 {
 	__paravirt_set_sched_clock(func, true, save, restore);
 }
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 0114c63dfdd9..4a48b8ba5bea 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -280,8 +280,8 @@ bool using_native_sched_clock(void)
 	return static_call_query(pv_sched_clock) == native_sched_clock;
 }
 
-void __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
-				void (*save)(void), void (*restore)(void))
+void __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
+				       void (*save)(void), void (*restore)(void))
 {
 	if (!stable)
 		clear_sched_clock_stable();
-- 
2.54.0.563.g4f69b47b94-goog

