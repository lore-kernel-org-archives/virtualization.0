Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807B242B324
	for <virtualization@lists.linux.dev>; Wed,  1 Jul 2026 19:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934405; cv=none; b=Z6yOwDXhyi1IpEGaEldhuho+ebxOpmu45ivSwgDNduRta5xQ6+anMXdfDjSzk8S+XGwohKmvJhtU8F0XZpFq6EJBtNPGh70i82ArjmlG5GdhLM3Dz6GrsNPo2TPHqKbQT0ZQsSndk30SDnC7rhSkYufafHVJSipRDQWk54UbuIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934405; c=relaxed/simple;
	bh=UExHFmJ65vTRSuxY6XqQx736Zu2Yk6LZG1h2YXf36Dc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BneLqgWm9WXi4P+l1y/nAzdRjSbEWIsMKR2J3yUFMq3bekREOU1czDT8hrYQrSZU2FHnYaB2JpQGAwLIYQk89G5I1n8Hr5qTdyCRid/DfmtPgx9sjBKFTrgrs5Mo5M9OQWPGw6ZfFks5qAO2UxZ5I9BD0HcDyUWK/8voQ7dWGZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EgVe+XIT; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EgVe+XIT"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ca3b3141a6so13439525ad.1
        for <virtualization@lists.linux.dev>; Wed, 01 Jul 2026 12:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934402; x=1783539202; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1gCn97n2OaQgcF7BGVq6zaJwKJkpkAfWBIFdTpXq3s=;
        b=EgVe+XITg+b2w6XPQRRTYI3NFeQB9WdyZY/jVenRCxvf/nR2vG/aCOi32ABumE+Lt9
         lXnWxGykUh09pCglrAIah1ZtUqBaKaKkK3MXe8lRrPjB/IY6wrwTQ7VNQuYBXRQ3DoE8
         yTdtIWHqajzDi1vT/IiJ79uTHF4NCDdhHk0LDLUs+PBiEAQ/U7lcytaSUl2oU/ic5VzU
         wq2HvxFG1nmENFOGjc1cOlNY/AVvDw9lajsDxBhmFPZ6Syhnst8Dve0XOUZHB+u1r+gq
         N4Mg93wxqiB8CobnJeHvUru+ZDn7pTovZu6vvqg7lM0mtT00O4Rdnspx8D73iqjXL8bs
         gIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934402; x=1783539202;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z1gCn97n2OaQgcF7BGVq6zaJwKJkpkAfWBIFdTpXq3s=;
        b=XdYAKLGGNbCi3wN4WUVbTo8wis/uXww+w1WG1noABRrG0Y7P6hMjcnxSY/TU2OlYWQ
         UDa2VSBuT0rnileSQre4Pz8NSUdz+uOalaBQPiBIupqegQRE2/EpGlkIq2PSW+tMjqre
         LPUpV9haf77TWOgd+T5mDvv0iPlTsD1vWW0rX3x5iIiqw4Z03wz4RVZxq075dLXRsZfX
         2sOane18an13bC0ZlvDC/Zlip//WLpjTZiAB3wNFGBt6Q+Oq29er1KD/AOrPcO39LDKV
         5eV5nuyaOBqOoj4bMDSwtqPT2lM6G3kBW596htLBUZRZLQavD6+2gh7fLw4zv6XZPec3
         YrVg==
X-Forwarded-Encrypted: i=1; AHgh+RqaYoSC8g3tbirF9wxsOx8mllUZuKmcDXl52eqQkYY7qWAT1CMsCQ7yNuWuYW7V/ycuA0eehc96yzNXhlGuEg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxYX/0FwaFNDPdbstZJapuHIjwWHOGghKJ4fUlbW4QjgxXEbZDm
	RvVI8lPgRITKzzx2LOELFyEbBgKezLFoxYuTSTl0W7zNhIq3uqfDElSlf9cf+XqTOc8YX+Ewlvr
	z8V/hSQ==
X-Received: from plgo7.prod.google.com ([2002:a17:902:d4c7:b0:2c0:b770:dcd7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1245:b0:2c9:fd62:a709
 with SMTP id d9443c01a7336-2ca7e6838d3mr33515195ad.10.1782934401463; Wed, 01
 Jul 2026 12:33:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:32:06 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-46-seanjc@google.com>
Subject: [PATCH v5 45/51] x86/paravirt: Mark __paravirt_set_sched_clock() as __init
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
index 83353d643150..0f92b29adecc 100644
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
2.55.0.rc0.799.gd6f94ed593-goog

