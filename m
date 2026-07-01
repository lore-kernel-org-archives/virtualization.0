Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7DB4D2ECA
	for <virtualization@lists.linux.dev>; Wed,  1 Jul 2026 19:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934388; cv=none; b=Lq3u63RRdhwA5LDhZ5UE+Df3k3OacY8h+YPFiLlXZgtUojTB+I79PPJTEXrUzqhVqtDLoS5gEMW5oX9HpDlSRnlAtBSy3fj/traTBRBenlE0e1zjBU8gCkXUR50RfrnHNrRQTkXy5uwvXzKb6qaFEboSoTdlRHvDLwsVw4WghyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934388; c=relaxed/simple;
	bh=7YsySPptQ6kA1DOmr538pF/lRTH1eLru41S1skeiyMY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NaqTZydsPuNRdQc24KMwq8tAjzqPU6WCbtPFPxkIH8oREpCnhCUi2gxhz8IW1lRz1+6a0y02GmGAVFjPtVqdps4QttBWggQKCZfi2h+dLA+CFhFWxZMuKr/0i0fYbe1ODt5HnQsgwoUE8Vuj00hknNXTlQYWQR6bW5J9BXiD5Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=irYb9+Ua; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="irYb9+Ua"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ca5d2474c7so22057875ad.2
        for <virtualization@lists.linux.dev>; Wed, 01 Jul 2026 12:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934385; x=1783539185; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=E6ig/L0f6Bi8iYQ5fSK4jpuHUho56x4PQqpcZJJeUg4=;
        b=irYb9+UaMX1psYqB2hz5+ayhlWzZuYZFHxk0K/Mt3W/vY3Ahsudl8/KtrP5UxHf4HF
         QKZBLD12LcFSdEMxmPQB3JKlkEsx3WV6GzogqI/4xiN0l5EIohOZQFdV7XFx/dRzNdut
         HpNzmMj1KYIe/8kmMEcfvfGdlOGRmyZ00dKPYpSeLKRQIa++wCWRoZbplJZnOOMEjI4W
         6zW245QogxsXiPDa59Ed7Tgn+fyTVHdZQ+dkVhUGRcSM/OOIKLOmaMZqGNPvC2I9ZRh3
         AZL5TvHM/7eLDgydhRa+Vx9YFkSNx2MofXXxKRZ4E59Y/w0HQWzschU6YHMT1NqJ0VbZ
         gaWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934385; x=1783539185;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E6ig/L0f6Bi8iYQ5fSK4jpuHUho56x4PQqpcZJJeUg4=;
        b=HNfT/1cb048OXDHT11CW1y4nJtqFzzU9BIZumuEPVM0zR17qakJipBoXd1uYldowE9
         rymrsi/EORjkmM0VHHyh1TgsnqTM3ecp7sS+jEHbyaGVmQuXZ4aB1SnWhS+2AVIKMSgf
         Pk/a/co0c8OeWZ2ErKeYrZkiMu3in8rjyY+sMTKc+GVmG4LcJjPodM3nkfL+iOKER5XE
         UuNqYjTwNMcYlAFjyf3sO1nzVCYqKfAKirGeokmegcNu2/0FN7FMcVSsWSP1wskTP/yw
         dlTdQ07YsYt+YdM7Y7MJghzQ4w1f7rwsoFqI//fyF9+nsMfcnSrxhKj59+DLpyQQmGlL
         rNYw==
X-Forwarded-Encrypted: i=1; AHgh+RrT5ca+HVZ+Lfs/kwyJ0mqqNP/0iWRINNtW0kJszbXHsVD2j7WzsYOTOtxr+JIOvovmVQNKg0D0281yzrIpzg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz1W3LgBi2BbRMClRMaTJYhzdvHQt/U+i8Q1aXWLLm3OpAf73JS
	MizOajXV6U5p2PmM1d4ycylhSDXh3dnw2jiGfXzLeYDwKNa4xr/y4o3hSd4Hzm3YfWQq0KsnhLj
	R1BqlOA==
X-Received: from plbmt13.prod.google.com ([2002:a17:903:b0d:b0:2c6:b7bd:4804])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1acb:b0:2c9:c54a:7915
 with SMTP id d9443c01a7336-2ca91140306mr23508775ad.14.1782934385462; Wed, 01
 Jul 2026 12:33:05 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:52 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-32-seanjc@google.com>
Subject: [PATCH v5 31/51] x86/paravirt: Move handling of unstable PV clocks
 into paravirt_set_sched_clock()
From: Sean Christopherson <seanjc@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sean Christopherson <seanjc@google.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, David Woodhouse <dwmw@amazon.co.uk>, 
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
index 375b0279df66..a762cb5cec0f 100644
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
2.55.0.rc0.799.gd6f94ed593-goog

