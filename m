Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E268B1ADC70
	for <virtualization@lists.linux.dev>; Sat,  1 Feb 2025 02:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738376268; cv=none; b=nfWof+QiwHlOpycGnxWtnO1NhKLCOEMrqpWtYASb6u9mwrZuKvQsXM1GhpQAvnU+wP+q+23dXQSfbLFs6FDMyDi97QjnUfbHJ5vuwayiHa9qkKpzE3u+euvtRz0RWQrzdlGw81ieoo8kcPcn7TtwWrpYcc8LynZzMuGXcheQ50I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738376268; c=relaxed/simple;
	bh=I7ICP95Ld9V+B6MPp3tXCsSnHLq4xQG7ZATAfWkmSSA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DwFiHGj/3SozFIiXzUvyRF5oV4Vj3JBUYZayX3poI2XXawJ0Qqtu7e3cs6cA9absqECQghK4uFr+1Jk2Uuw3xG96ICF3FY/AOdIOa3fBIAyE6Whkhvdhb+JGPLvHP2HFa7/tlGEyOmno5HXAtvMnW4S0J7L1cfBsntTw0nVpzys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OQ70lzy7; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OQ70lzy7"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-216430a88b0so54945605ad.0
        for <virtualization@lists.linux.dev>; Fri, 31 Jan 2025 18:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738376266; x=1738981066; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=AK/mWgvwJvlM2VErSRU3T5I3ox4v68bEfhNUVA1UAEc=;
        b=OQ70lzy78KBwcr0Fq17z6/HUtESVYoIYdr/UmuOw/7jCZsgI9sKDUsKqIfbUbec8CU
         TC/92hZ/gseJo+9P2/esodKAGxmMgkRQLqdEGYIwtLlqInzdVHDTGEgDdU3NpInnX/zf
         WKFyTxRV2q40pXZCK8BCaks1u4NPNgGS1OM9BSvvsGmfftA2+9EaFMvxzlurWjF3FcC4
         a/kEMpF1kroVpbOnaqrIzk1o6rCCj5S2kF8Is906B0usCljxhq4UPIveoAZlAGTbRwTm
         b8SpFyt+Oew/W9C9/jVMar/WCX6OvhSMimypNA+NRZ+QjxbIJXDT3tfkzF7CwDv9HBKW
         Y9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738376266; x=1738981066;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AK/mWgvwJvlM2VErSRU3T5I3ox4v68bEfhNUVA1UAEc=;
        b=AbkedtCNSLikxMCL+yt95SvzIxkmSLdSlzVuLbGtJHi1/9N7fU0GJ+5iUZcGwAF9Wm
         vrZJfX0lvudfP5I0ioCsinojO5Mv4+cGp7MhUSwNDrFt4U35ZT0JbVvn5JzYxJfazOzD
         GIUlLAy+fYf7v9N48LhOD/azhlPHO6et6aV5+fVWQ6aU+lmlf3K8nD9RlOG+KC5xytGX
         +Jl96VM75cxBMYA590Y9nNpC0hQbplmBAiVoFmiMFiJyW3sT2Ya893cOaSTwOhKXff7Y
         FpdS1RgtTWWG1g8gervEZFVvqemtlNxsZlwgXPDXPpCHmTRJk2NLmG1LI8HVcpBWMtSL
         rB9w==
X-Forwarded-Encrypted: i=1; AJvYcCVr6biFFzQBZ97tdgQBsxs7MG6taa5F3PK2Hd/ETWrL2efUetIq97fccYrd8C873Wwxnz9fTDV3qK7SwvlQcg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yze3HxoHg5S1R3fOz4sO5T3s+Kvvvx6okv1m1Qa4hwHDuMJoina
	pCnrIXWwU4yvj3L2ikyOHT3wOyKX76kpUXWJcpuX1x8JUsBf5PUH444IJTU3g1lLxz3J5kkol8N
	WiA==
X-Google-Smtp-Source: AGHT+IGIBUdgj+cCgBZpvoXPxY6FOVmtNbk7sDeQo6dqnIl0GeJKfhw5O39y3pDqzJDExNb4JeazGQgwjQ8=
X-Received: from pjbdy6.prod.google.com ([2002:a17:90b:6c6:b0:2ef:7483:e770])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:11c3:b0:215:b1a3:4701
 with SMTP id d9443c01a7336-21dd7d64c1emr194518565ad.13.1738376266294; Fri, 31
 Jan 2025 18:17:46 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jan 2025 18:17:13 -0800
In-Reply-To: <20250201021718.699411-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250201021718.699411-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250201021718.699411-12-seanjc@google.com>
Subject: [PATCH 11/16] x86/paravirt: Don't use a PV sched_clock in CoCo guests
 with trusted TSC
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Juergen Gross <jgross@suse.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Alexey Makhalov <alexey.amakhalov@broadcom.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-hyperv@vger.kernel.org, 
	jailhouse-dev@googlegroups.com, kvm@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Sean Christopherson <seanjc@google.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

Silently ignore attempts to switch to a paravirt sched_clock when running
as a CoCo guest with trusted TSC.  In hand-wavy theory, a misbehaving
hypervisor could attack the guest by manipulating the PV clock to affect
guest scheduling in some weird and/or predictable way.  More importantly,
reading TSC on such platforms is faster than any PV clock, and sched_clock
is all about speed.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/paravirt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 55c819673a9d..980440d34997 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -88,6 +88,15 @@ DEFINE_STATIC_CALL(pv_sched_clock, native_sched_clock);
 
 void __paravirt_set_sched_clock(u64 (*func)(void), bool stable)
 {
+	/*
+	 * Don't replace TSC with a PV clock when running as a CoCo guest and
+	 * the TSC is secure/trusted; PV clocks are emulated by the hypervisor,
+	 * which isn't in the guest's TCB.
+	 */
+	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC) ||
+	    boot_cpu_has(X86_FEATURE_TDX_GUEST))
+		return;
+
 	if (!stable)
 		clear_sched_clock_stable();
 
-- 
2.48.1.362.g079036d154-goog

