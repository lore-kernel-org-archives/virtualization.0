Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7968738D014
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 19:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872846; cv=none; b=XqYqcKfE7bgFvsccdC4dFwXsPF7A7w5m2Z/R5fKou95KVpF8lCuRhk6R0y46i2mFCd8Kh63p+n3PaT7FyBRZPAnwHQFB3Y4hJVIrc+paZRS0XctxZ2XncaCQ0zEFWvwKnoNKHUjdLjjCvtTP/1ByxFr7o5t+wXvRsGbn34Thnho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872846; c=relaxed/simple;
	bh=nZsHt/XZy1AiJmrHTvYkKp5dep2GnBIAqllpDPOkXUg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N3DM/BHtrHrDvoo+WBn5Awdg5IqZkzwiblBJXetnbWzZ1iaIbP0YUXuRtB7guQ7PqtRekHF1lvK3RNtTjmQ888NZsEVkzCczb9xRblJwPrHXIv5qjGfkfWOBphLaPvBnisGNC48ZR16utaFVWB7aHARtAZGQ4ZD9ntHeVI2TyUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OaVo6id3; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OaVo6id3"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f756ebd0dso91672b3a.1
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 12:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872844; x=1779477644; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=62wrPM0lWE30yV9zyxGJWUHaw5WRQ2hiTxFnD7TdkoU=;
        b=OaVo6id3qpESbpR0+MneuJzhCUmtD6gTG/N5rXzVz5QIMjOiILByu30oMLv1xtqw7O
         58Kw0AekJO13ut5l0wq72EISYDhz+MJ5rehLaJMWrzXe9prIgaym2HaALB1pX6l9J0XI
         S2nkCna/+KitvOMZYL5DwEDfKD9vyRVluu8b227Fu7b9l9K3PxfOeoG/NjQzpEVkIggC
         p6SaWPny9B+Vx3ns1NRjtufCGuUQiVilGTJ0pb/eEzchQ/o23mG+y4nseCz8XNCGTiF8
         3sMrZHALKBX8gkBxkAO0NtkAL7IrKdAtltCz/E4fyJzNHjDQi/U+N/+8t5+4GTulAaw4
         oRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872844; x=1779477644;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=62wrPM0lWE30yV9zyxGJWUHaw5WRQ2hiTxFnD7TdkoU=;
        b=ag2qPsTopyTGHeyHX8lY4tBC3cgVy3Q9JLCtLPPA82+bGcqJ0amQhuLE80q9us11Ok
         SSdUOkxLwlS5347TwfNUfNEdZJGj7tkiM/Yucupj02/fvToedWFuTC0Jq+NnZYubPnAL
         BGLRP6b10xfIcc5sfRuCE5+fPL1pee/Ap96+ZU3D9ZDOJXYJrBRfrnxPeOE++mK+Xilt
         QpwO8nV24+Tni0kh2pFqtlV0MGFJRBSDDLVmp4aTQ5xhWAUh5Utn5c1M/hCKyyoQYDhd
         0C+aRkNpaLPVvIlVC2aLmZpLlqacE1wy01n8psD67zqgjaY/klpZDGcsiLW19s0KQCYd
         +69w==
X-Forwarded-Encrypted: i=1; AFNElJ9d50L/klKiw0sL5HJo275FhIkkzY/yNvPWStYGNJ1KhZPdxkn8v9K3VCsjnuEKYEJIpPyWX/qNv76hjb6fUA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNyD42WfW4/hrSVAdFr96YjcR5od+Jdeoh66FCd/etD3bF23zc
	i9AoS4TgqmDvvRYVSjTPXM32mr/8hgSYGSysdHmZe5EY2C706W6IbkhC8IcHkFK1iGbfJUxy9SS
	dgwszVA==
X-Received: from pfbg4.prod.google.com ([2002:a05:6a00:ae04:b0:82f:c34b:9799])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4193:b0:83e:eeab:aff8
 with SMTP id d2e1a72fcca58-83f33d24d7cmr6075416b3a.25.1778872843406; Fri, 15
 May 2026 12:20:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:13 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-13-seanjc@google.com>
Subject: [PATCH v3 12/41] x86/paravirt: Remove unnecessary PARAVIRT=n stub for paravirt_set_sched_clock()
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

Remove the unnecessary paravirt_set_sched_clock() stub for PARAVIRT=n, as
all callers are gated by PARAVIRT=y.  Eliminating the stub will avoid a
pile of pointless churn as the "real" implementation evolves.

No functional change intended.

Fixes: 39965afb1151 ("x86/paravirt: Move paravirt_sched_clock() related code into tsc.c")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/timer.h | 3 +++
 arch/x86/kernel/tsc.c        | 1 -
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/timer.h b/arch/x86/include/asm/timer.h
index fda18bcb19b4..c71b466d6ace 100644
--- a/arch/x86/include/asm/timer.h
+++ b/arch/x86/include/asm/timer.h
@@ -12,7 +12,10 @@ extern void recalibrate_cpu_khz(void);
 extern int no_timer_check;
 
 extern bool using_native_sched_clock(void);
+
+#ifdef CONFIG_PARAVIRT
 void paravirt_set_sched_clock(u64 (*func)(void));
+#endif
 
 /*
  * We use the full linear equation: f(x) = a + b*x, in order to allow
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index e00f53e3dd8d..021612c22b84 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -288,7 +288,6 @@ void paravirt_set_sched_clock(u64 (*func)(void))
 u64 sched_clock_noinstr(void) __attribute__((alias("native_sched_clock")));
 
 bool using_native_sched_clock(void) { return true; }
-void paravirt_set_sched_clock(u64 (*func)(void)) { }
 #endif
 
 notrace u64 sched_clock(void)
-- 
2.54.0.563.g4f69b47b94-goog

