Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E5C4ACCC5
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 23:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059443; cv=none; b=Is2Y4kuxOfslJVPCQCInCipXI31T7eAr/mgbNR0SqxSIldAG6QBuIUQm+3L7Et2UccE09bu2Nqdm9MPPKhzKIXotwfzALMEa9Xc7NOGz5f3KbdB731ct06AoWaI/nbkgzHtf9WM4iUVkk8r7VovtqCJyuR8tLj+eWBH3azKfSjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059443; c=relaxed/simple;
	bh=XkhFva8JyfvpNMGgTzJPYMHmon5wSx833A7LghpVEEU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EbuRix4euUjJoV0XIIkuszy/8KimO9FKYYyDnY6QPSg7rwA6f3ZVj+0LSU8bV9iU+UGOSEwrljqpb3T2RFYZfFjSLEVw0Y9OH40US9M2GH8aFAT53Eq3cnVr318IVOZMZm9NcbpjHjmUgPPwyGC8fe1qeB7c3+8dSutbokNp4e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AC/eHdhb; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AC/eHdhb"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cee1ec30f2so33076985ad.3
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 16:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059440; x=1786664240; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ITopxW07/FQizEWlsu5JVYhKtG4YNcRGYaSiNeAs44w=;
        b=AC/eHdhbsuATBfJjW/zs3Bkm+/IO8Kxq6poBgl4jaoAR1sriXnGaQgCckb3/yUCTdX
         SGyUeeYVPhh3pA1CTAIK4jfkINMURISq5QjQNmvrwklxFhY0hPohvTwt2Ge4yPxb+EBj
         ka/5ceSbYdf+rl4kFy63y4m3IyFdm/grRMan/w5pD//mO/eh+KFCBEKzHQvndeeg5+H/
         3kOYY2Z/pujEVRR10BTsxsEnW04sgC8ScVVLgRUz7uMiOfXtog4ulTKAyaYzwM0OkscZ
         5rSXbcTwo4TRySI7835MIxD6pfxMhU5MQmX41TZYisurLh6yGWrQUlUugeXt5GnGdFXJ
         jpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059440; x=1786664240;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ITopxW07/FQizEWlsu5JVYhKtG4YNcRGYaSiNeAs44w=;
        b=CBOWlXFVMbb/aUzRawtlLlcHUsVsWQRtNZOIUTLWC3HDFTem3lQqMDbLDX98UaaCs/
         5gkNADcTwcpjOmzBXPUmNHkM1NTL3IyBZA9z1AQTlwQVbW0n2v+AB8U52l8zfxxC6T+V
         crR3ziIl9j8vc1C8K430hmQbc3I17ICEDpFT2C1AAP33fLWgtTZ1cf5uKnD1nr0gyAEN
         tTVjajcNtFp79SSl2/pbtW2/316rqHDhtZvC4CrOB+FwScVxYZfngRnuVlwiWKzRZF/e
         cnwcHvpDpbjNe+ENEN57vLSnUgW8hwQkMP9Kjo670Ye8bozFxbfW9MiAS5hJjO+B3vh0
         egFQ==
X-Forwarded-Encrypted: i=1; AHgh+RoFgCNmtOh7MGTYiPFqH1PwZgwmIesVaMBACGiJULL1QqbURSAmbBXQ3gc5naBUSLn0QniT7ddiLawVXV2bBw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxC93gdFzjRNCN5JjM13ysptrJeH+Iy5+cQoKiEWoOr56m2x1yy
	V5JUzw4JChCXvYICRWAQa0QRWQyJNp85Y0wp7KoBjR1wXUqVtPOZJNREfwNz62JZEa9NFhVXnj2
	0vEwr8A==
X-Received: from pljs12.prod.google.com ([2002:a17:903:3bac:b0:2ca:e163:e0c8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:41ce:b0:2cf:afa5:b19a
 with SMTP id d9443c01a7336-2d0ca7f8e9amr186517945ad.11.1786059440120; Thu, 06
 Aug 2026 16:37:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:36:02 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-46-seanjc@google.com>
Subject: [PATCH v6 45/51] x86/paravirt: Mark __paravirt_set_sched_clock() as __init
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

Annotate __paravirt_set_sched_clock() as __init, and make its wrapper
__always_inline to ensure sanitizers don't result in a non-inline version
hanging around.  All callers run during __init, and changing sched_clock
after boot would be all kinds of crazy.

No functional change intended.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
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
index d4f7cb127235..363145c83919 100644
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
2.55.0.679.g6767b8d81c-goog

