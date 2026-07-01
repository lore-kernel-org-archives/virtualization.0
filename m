Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F144252B0
	for <virtualization@lists.linux.dev>; Wed,  1 Jul 2026 19:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934395; cv=none; b=bnjFtWMGl4In3PP7i2VA1EfQmVl1s/I56H/GYVGaH6oE51zRxHd+/MxLuTobgM+YaCEzQ0yWTAUabXqpJ9xBqe7fDiP38Midv2nI1QAqUfi3Ww5ICSFd4oC5XOS2UzLm2z4SOe/PxnTrH1Viinb4BevXHp3FEdAQYBt8toEqkEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934395; c=relaxed/simple;
	bh=LXKQSRRHn2Tmdw6xmC/NKQLjwuUTQrIvkVaRCcna4n4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CzLE5jysGaUGEdA85yCgq2Ji5WNubHFDa9i5v/i5DabiytQkDFqgH7GwybzJqUJjKsOsI8PA2LiRWMhtDLAwk+SEU1hTiMVydYrzcPdRyriebMN2YgHOC1SI6Rp0mkttVKh58fOTdnSAVfg9vI3YJroA9Gjk1kJwkIoINhJgTl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A1SBnlsV; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A1SBnlsV"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c80be91ea3so19637915ad.1
        for <virtualization@lists.linux.dev>; Wed, 01 Jul 2026 12:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934392; x=1783539192; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=aK5m/cPAf0bdBYumbExr1aJO4L8QPhhYatB0l9CbU30=;
        b=A1SBnlsVhclEPg10IAJC7/CSQcvaITIN+fyX0ZGM/CgHMdOmJdNPa1ujf4+WHYfHBf
         rA0drlXrb+xk2/7c78270sJoGWsaZ34INNVtVkcD0o4H1dojiYAg4+cYqlj5733cy0+C
         0F5ddMvKHuUH7hTj69S2xg9Nkh4WVBF/oO1AwJgu+013lixx4/S8RW01L2eE76Ov9AKz
         YXwSitk6jDIH7EFw4sPk5wNh35DJXsBzhbDmQN4QBH8XitgMiM4kMUCRFNbTaslhegRS
         St/YtfJ3/XQGyS7haiUbCPD12I5hQ/mMBjHbidvX+6N/69pD82XU0ZKhrPM351GylNOJ
         SSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934392; x=1783539192;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aK5m/cPAf0bdBYumbExr1aJO4L8QPhhYatB0l9CbU30=;
        b=FVLyuzFRmXNI6Vb/cjYCS7hpgsFwlR0CFd/HoPAC/KHVX/pJtv+FCWujpMKs1nrwJg
         fiemwppIAsOzB+w4HSRzU3pHrIMzTmpHYRuxrQ/hUuD1hQsgFvc0MYvBaY/SFTYR6uh+
         9GdzETQ0cuKVNCm5BW65S8smE3jRMWxpPBQtJZ46WzacTJ1I/EPdQLtvdT167FkkhAdE
         8hC3vSGVL7rw8c+n+IRYLnW4bg6biZnk9tZrl5fRZH6/sbC1wAtUJmpY7N6+9GQmUgVH
         3FXATv+vLb6llcGPvxQyI7ySqvMgIpogjy1MmimINDNl0mS6iEUIQPoJl1nqR8gU9AE8
         k9kA==
X-Forwarded-Encrypted: i=1; AHgh+RoZ9r44pXeWSwv9LuD2oEOF1AEJDxXIt4KR2ik9JxEdp3Nenv91D+dMdwJjwGWtKmnC/XDnBbYVFtm1kHX+qw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwabxSzskmp6ei7JSUxpzYJ8eGadz/aHB47tJdePJpDS33iBc0J
	+K0u5yB5yxGJE1bGKbjoUdW+Rmhde/7v4dyVK62cDTBhx/R70aY+7arDyi5yJ4fVeglL9CGzjT3
	wCha4CA==
X-Received: from pjbil4.prod.google.com ([2002:a17:90b:1644:b0:37d:ece0:dd38])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3810:b0:37f:9ce1:cdaf
 with SMTP id 98e67ed59e1d1-380aa1ed882mr2896319a91.29.1782934392117; Wed, 01
 Jul 2026 12:33:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:58 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-38-seanjc@google.com>
Subject: [PATCH v5 37/51] x86/kvmclock: Move kvm_sched_clock_init() down in kvmclock.c
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

Move kvm_sched_clock_init() "down" so that it can reference the global
kvm_clock structure without needing a forward declaration.

Opportunistically mark the helper as "__init" instead of "inline" to make
its usage more obvious; modern compilers don't need a hint to inline a
single-use function, and an extra CALL+RET pair during boot is a complete
non-issue.  And, if the compiler ignores the hint and does NOT inline the
function, the resulting code may not get discarded after boot due lack of
an __init annotation.

No functional change intended.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 5b9955343199..5220d205abc7 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -155,20 +155,6 @@ static void kvm_restore_sched_clock_state(void)
 	kvm_register_clock("primary cpu clock, resume");
 }
 
-static inline void kvm_sched_clock_init(bool stable)
-{
-	kvm_sched_clock_offset = kvm_clock_read();
-	__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
-				   kvm_save_sched_clock_state,
-				   kvm_restore_sched_clock_state);
-
-	pr_info("kvm-clock: using sched offset of %llu cycles",
-		kvm_sched_clock_offset);
-
-	BUILD_BUG_ON(sizeof(kvm_sched_clock_offset) >
-		sizeof(((struct pvclock_vcpu_time_info *)NULL)->system_time));
-}
-
 void kvmclock_cpu_action(enum kvm_guest_cpu_action action)
 {
 	/*
@@ -325,6 +311,20 @@ static int kvmclock_setup_percpu(unsigned int cpu)
 	return p ? 0 : -ENOMEM;
 }
 
+static __init void kvm_sched_clock_init(bool stable)
+{
+	kvm_sched_clock_offset = kvm_clock_read();
+	__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
+				   kvm_save_sched_clock_state,
+				   kvm_restore_sched_clock_state);
+
+	pr_info("kvm-clock: using sched offset of %llu cycles",
+		kvm_sched_clock_offset);
+
+	BUILD_BUG_ON(sizeof(kvm_sched_clock_offset) >
+		sizeof(((struct pvclock_vcpu_time_info *)NULL)->system_time));
+}
+
 void __init kvmclock_init(bool prefer_tsc)
 {
 	u8 flags;
-- 
2.55.0.rc0.799.gd6f94ed593-goog

