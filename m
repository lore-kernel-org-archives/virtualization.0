Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7373DA7F5
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067222; cv=none; b=gESFcUoEoBeDZ7HdzLpiAJ26whFiqV1cjTBk7Qj2U89+oCzypybkhkW/zN8XyMIBfFtfA4UQ0+6OPikzMP6YN1Dft7QbDsHkOTFOP5IlX73R/zzgN3TdQfSdGC8B4C5t4RHfHwYeki+zJoKLWwM0exteij6fCBXlaIHMco+l3ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067222; c=relaxed/simple;
	bh=HD6T6IXKxXHYYTEzA8sYaRKBtXpTOgGbEYUT2q1t41U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UahTwvHEidf/OCvZ0g73dM8veC9FnleVOA33+O9WWg63LJyFIlAT/HNT+fhXnfDr4qEBb6szR0DVBmVQx3ZrKO4dazAQstTxj7wdl6tFbb1qWqGBl6hVD0FvBPrzuEScclnXuL+1Jc6Nkzo/cVMDxCLiinsgeJDihO477Dzc7p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wU0WFI/t; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wU0WFI/t"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8561bfbb16so1273996a12.1
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780067220; x=1780672020; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=xaVkfsA2sOgFELwC+9kgheEWN7jnZ1tVtkSLe6gYY/I=;
        b=wU0WFI/ted6me3MJ5gIXzdQFVu51Y8j6PFxCGB5kO2v3sWySjoI3037eGhxTwdTr1T
         TfyJwA4EV9ZLssm//dm7UhCJ3ciE5Uc3kgx1fW2UHmPsp+H11No6C5KNSkdAzhvu6h0j
         FjtvTqk5eGQroVpJy1ss1pyIi79UZ4Wcbxrpwx2+M0DQwvROfHC2E5cc8G5109y6Uc3/
         9PxBHmWGBWJPcHE5JANy/uvXEMDYKFTyJ4/pWbQCuI5c7D0qsH7d7XppDVq4+w3h8Xeh
         CTXs2g2lzNWXXIQ5DgeiDJbjN9HZzPxX3TlM+XlnTaSCs/jlD1tMngVnZWijQ1W3mvVB
         FOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067220; x=1780672020;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xaVkfsA2sOgFELwC+9kgheEWN7jnZ1tVtkSLe6gYY/I=;
        b=CU/AI4f5ji/0GjsPIGqAmeQox66MkK/vcIIcCMLvkCt3Q2apIiHKdaImELwdb5RQ2A
         iXkxurOKDm0bNjwyYAR7ozszNDw2PNbiy3zSmq+o/ur3m6RCRUlulmEBM1Sqr1LmpwOE
         ceckSrcDfLg48KFxdMQ5QZF3+muT0GJdbahaFvhcFmKl8KWn0t7+/Wt6KRtXro5IpuTn
         gzS61GGDWwQJ6hLO1eLtMPN4CjqVoGlmBPk9bGMHzOz7d55qHKMJh9TWbbL2POrYEnjG
         BfYipDktN1/cv7brYVrhuFsQ/t8VPBugHlSy3dtptR0dcsIu8OzX+HTl4fbCHh+Srg9K
         jcNQ==
X-Forwarded-Encrypted: i=1; AFNElJ80etoy63eCawyqYiS18jzzVbNb23H+K1ZMSZClElkRDZXs097JQc83GmqKfSKVCmnZokhOkL4n0wa3C1mLPQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwC3Kc+qkaDVsEeyGA1AoY9BZVdgKDl8yvrOA7su/NX3BZgKsq6
	Y16cdqIZmT6W49+gJS/NgM9KmvRlzly5Vf9qPQoREKoi5r8P8pXaySUnSgbjnSr30TwYHkIyOx2
	wjhBYnA==
X-Received: from pfkk14.prod.google.com ([2002:aa7:90ce:0:b0:82f:6245:a6ec])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:8088:b0:838:c01a:7a50
 with SMTP id d2e1a72fcca58-84212ce8ccamr3369227b3a.30.1780067219938; Fri, 29
 May 2026 08:06:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 08:06:31 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150631.713818-1-seanjc@google.com>
Subject: [PATCH v4 27/47] x86/paravirt: Remove unnecessary PARAVIRT=n stub for paravirt_set_sched_clock()
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

Remove the unnecessary paravirt_set_sched_clock() stub for PARAVIRT=n, as
all callers are gated by PARAVIRT=y.  Eliminating the stub will avoid a
pile of pointless churn as the "real" implementation evolves.

No functional change intended.

Fixes: 39965afb1151 ("x86/paravirt: Move paravirt_sched_clock() related code into tsc.c")
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
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
index bdff8c988866..888bd1cbd9bc 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -288,7 +288,6 @@ void paravirt_set_sched_clock(u64 (*func)(void))
 u64 sched_clock_noinstr(void) __attribute__((alias("native_sched_clock")));
 
 bool using_native_sched_clock(void) { return true; }
-void paravirt_set_sched_clock(u64 (*func)(void)) { }
 #endif
 
 notrace u64 sched_clock(void)
-- 
2.54.0.823.g6e5bcc1fc9-goog

