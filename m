Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CE04A701D
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 23:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059426; cv=none; b=pJ57dw4qIftFvVPbx17oUcPmvXRcndL31UEd1CJ0OjSb/yRLAOGJvTxuU0vR91xn++sujCMj9sYdSOyp3xIDdwx+mRJMMiWdyi67wM37L1eBKX861yRXq19aX8zpoAdKP8CPmErYlrBoCqoADMBPrGqITKDLJkZlKM8dLmMuNfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059426; c=relaxed/simple;
	bh=7Ni127rSaslOe/bH/SkQRKT4uzjuSgi5+t8RjZ9/edE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GOTLbXybDCBmTeL4/FGnElWLdFaRfcbbAdd1GkqK9bD8dSO0d6iyqXUmoRBdSsgwoeC0AjMyiFhVlve7vsKcdY2xtodEXywhHZT/uu+f7hpB9FmI2YSha/MRdrLH/Cjlwxx91gwVr14pF2oS4ZNDj/icxC8IgzFNtLCXZPxljWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eGgkhrdT; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eGgkhrdT"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8488ac68185so6660237b3a.2
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 16:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059423; x=1786664223; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vn6W6kHEL1s4RiTIjTKhQPQXVLtQ6/4gpgI7E1htjZ4=;
        b=eGgkhrdThYTorrMAh1bvweyNGwCYhC7kaodfqCHXzXl5l5IbkU5TUqqJMhPsZHYLye
         imaflHaIUMUvjtmqYccBN9zP6F1Y3gQDTlbNN2wqVSHkrzIB4vS8nnhAnDqHRNlIbr8+
         FNHFJXYEhzFgLXkufUSzCWdFn29s/tFPjaoE19Fl7j9JWUw2nNNEVU1nQXe7jo+vcK5E
         1nApnsFDCjIwrU+czE5Oc2+oASNoRMD8QQ6qpexGUU8cGG3utfDGHFkG8oEK/EOdOJFu
         DEBK42pkRl2fhZ5qH65BcwLaAtvbGBveOoDNBVtGapNc7oSzeNFWVbXoJSSgRE41krGN
         cYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059423; x=1786664223;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vn6W6kHEL1s4RiTIjTKhQPQXVLtQ6/4gpgI7E1htjZ4=;
        b=ah1OW0TNhDWhK9IWumRGkPZE7HbcvcqWywxvsnCjKn7XLb1fdj1kKysualcQ2esi9j
         OlONZXd1+OXSPfhlDEGTuySlR6WLe+lpxldGLA1zmkG9v/vFwkmdvgPJy32DXYZhz6DK
         Zde+Inv+j5OCjcJhPsC9lkSDIPanZcYl8+cUXCo8Jps4bMujVuuHxZ+OGDEVHJIW0+BS
         ojayApLzHqOd3nPkhoQ9TPC9K/OvsG4B5hj4LfaHKe0+BdWruf+BlAbXlkqoyu0xfoMw
         NzWrEkRRSt9KJA42GXVimyoXWt+WGWEiiuoqK4J8rVWFEeAFrV6nwR/WWqRjWGECE6M1
         MJHw==
X-Forwarded-Encrypted: i=1; AHgh+RqfGqZ6bB1gDbA9XzU3/ddsIANk+gKG7jv/uxhaaLYqgw0HUiIsGiG9TJk0qaWQczU9/A7XIFHo0Z/gl2R5og==@lists.linux.dev
X-Gm-Message-State: AOJu0YxmafqeNAIJELQU4kuGnUWJlAfH5X0ugydfT/AfM6VbQKTzWLr9
	7d8s/O/hwodpjIYfXLYpjpQ4W5B5HW5NX3rQ2XS/FSyLkUdJqeuS5/LWAG3Qy8dhCIGJthixwPY
	vRKKQIw==
X-Received: from pfbbx10.prod.google.com ([2002:a05:6a00:428a:b0:848:2e0e:62e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1daa:b0:848:401c:98e
 with SMTP id d2e1a72fcca58-84f2e0432a7mr20883954b3a.15.1786059423013; Thu, 06
 Aug 2026 16:37:03 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:48 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-32-seanjc@google.com>
Subject: [PATCH v6 31/51] x86/paravirt: Move handling of unstable PV clocks
 into paravirt_set_sched_clock()
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
index a3ec298d56d7..4bc0495f1f9e 100644
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
@@ -115,10 +114,8 @@ static noinstr u64 kvm_sched_clock_read(void)
 
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
index e0bea58b6658..964f3d6c2c71 100644
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
2.55.0.679.g6767b8d81c-goog

