Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A394014AD
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067306; cv=none; b=f0YF1ePCF2B0A5YJ4uhBJmh8S/6mGNKKEfqXeE2aqZSHKNCx7rETJu6KM4LBmbFmN6PEgWkUdmrruxRsSpKpc2HGVFrpEZ+cVwPVcJ7gnmk59Fp0oghyt9+ZOZMEDE6bRffweeMN1hIR++bFUexC5ajr/PfyX/Obo6UMIe9BRxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067306; c=relaxed/simple;
	bh=4VaqmgjNCHEhgXChxiXGwJR3wgEm9x1M9Rq4DUXzzAg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cUPuXPRFRqe/NS7NWPWFJ7ExnDlBbtKr494lQ33wbdlVk+GQsY6YluA/abH82A4pMHwlK5Q7FutBEIBTBtT4tYgzILB6nljEqP4shKvSI8PPA1t9+vAXoqZrTqgjCqnfThiSnPmdLGJS/YbTQDT3UgEJbKrALTnovGRYuKvibGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FYCnz0vJ; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FYCnz0vJ"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c85807671b1so109367a12.2
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780067304; x=1780672104; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Yfx7EXC5hiFOp82KCG+sZ/JXqzo7JAMVp+JZIeKJNyA=;
        b=FYCnz0vJX9i0zb3KVNtVvGyp2oQC09KFPMuh4DbD5MMH+TpS4z3Id4hnaEDrrvJUi1
         4eBBybtSqY0wqY5NgglDLBp0D4Grss55nMkKx+ZdgRvSY4xUOfIV68s8Unf/uJ78dmPX
         rSoam/gs3jvndGRTNwg8NJiAjGHqcLQQPjOG0UwsZspz2m5xhz4/0QT/pv1ifyD4+jmo
         Y1u8faa747s3J9qlDxHKLX2Go++idjvIdeCDKl8QXEaBJVqSUixAvPrlEzNZPvHsDOtG
         tCu3RCls9S1k+UWgzYK1GGF0dVQ2Cv5R8q0SVCGlRZygJTZ4VAbxgyHVrLkBXj23Hr8e
         2IqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067304; x=1780672104;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yfx7EXC5hiFOp82KCG+sZ/JXqzo7JAMVp+JZIeKJNyA=;
        b=GstvDgh+TaV/GRkGUxAeHpPPUsmSZy28WBOnwD6Rf+pc9PQGtcv+LzBZ/blaz5ixjf
         Oemm8wEvyMphlx7HqNz52uPYVy04WoEsJfZVCXKZQV1xaLgiNMQp4IofX13MT/rLvKEg
         cGcVxRCOWNCdiMabLRdSj0Yq9JP+AmUKX3gFRmLSDbViNvPU8TuDnCeBt3XIVkdSLoVR
         m69h5VghPmJW+eoNqpPRc5Ho6jNviI8IqPHFYQzUQCQXx7Z57drA4VPpfnDv7OWtaN3t
         hnMFq27U5ozv9Mi5D8fRdXilOxUQ88xH1p9uAf0D0RrIFiPJrdAxRN//2VH4u9wePh4h
         W3dw==
X-Forwarded-Encrypted: i=1; AFNElJ+gLUgxWKA0aw9AbaE4vLAzM0/JfLBGOQp4pA3rt83D3Q0Xa/F+SLo9NLXC9lGF3paW1skiVKuW94WCWrZ56Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzCw//enuvTVQ/4zoRuuPPUSRwxFRwFwsUQxHGDr7FI8H7aloqA
	O7UNIQtMNjL/+34Q4YCdPb5sqSwy2M8HBcSep/lXCjOQsqwR/6vyWsAhrqTUQoaWueLah3bbNoB
	ISDK1iw==
X-Received: from plai6.prod.google.com ([2002:a17:902:c946:b0:2bf:1ccd:c294])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e88c:b0:2bf:3074:34dc
 with SMTP id d9443c01a7336-2bf367c54demr2671615ad.14.1780067303834; Fri, 29
 May 2026 08:08:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 08:08:22 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150822.714883-1-seanjc@google.com>
Subject: [PATCH v4 42/47] x86/paravirt: Mark __paravirt_set_sched_clock() as __init
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
index 7fbcfc2efd1d..6da0a3ac05c2 100644
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
2.54.0.823.g6e5bcc1fc9-goog

