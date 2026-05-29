Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403ED35DA49
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 14:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065925; cv=none; b=GqXRkW9bgVHiw8QXy87R2QEmTgn/pWiTWzivt3jNPvnE3FIjWznZ6RQZmh+Tp3nTB0OM4eiDEn7cz549cAlX+LK8LVmRZuQAwz1UqhzsZj3q1yHpO2aBe/Qt0h+Ke9HngNVtfYgR/ZfVUQ+Omq3YRfMepqqbT8YfJGWETO/53aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065925; c=relaxed/simple;
	bh=fK2LI2CUeD0BDEX+PJXGpTUqY8RX3Vr+B1cVn7pLK3g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KDverKdCK3ipTRtpjFG7fbYxFxgZM3lD3E8m9aa0THu6Yc7tYAwuqN9NKBFEoqmzSrCFTn78lmM3yEyoThXm/nRoSqM9zsOh0LaZBP2C8OhtslCE41Oy1NsePr536SFNw/QUZxGq7w5xmvG0NG1NzkoYYYiXoOUfPZmLRf4Zdi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dn6P6I0d; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dn6P6I0d"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf1845bddfso12755315ad.1
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 07:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780065923; x=1780670723; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=n/IQNTw72HzXqO6AWPqeABL90E8LQ8oyD69HI8J1qOQ=;
        b=dn6P6I0d9GZegfDF9G7Uy3o/xvT0Sx6LQlp6cXQUXgONMOMJAZYhmCc2yLt6WCiHTP
         Wzt6ZxocOtpL85gCLlTgumu314LLHzs3hHpMUBT3nk7E96Yn9mNO0KnnfdIAXMWnOwja
         eUu7ewQ00bLnw0360+gaUuOzjVAFwexPqfqCBKHcko+W3UKFBQjjWJSQ+kVbbAK7Umyq
         DzllvCMrZowzejqNv2hX8rdRuUYsQXxk+/Ys3C6GIErtxIcF2ndUnjpkBdD6+zh14KsO
         6zhRzytMIOa8V03cAZ8Jqo/l66Ut4k4DYza6FxQHv4NXQ6SM7e9aITM6EG9wB07oNzuu
         M0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065923; x=1780670723;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/IQNTw72HzXqO6AWPqeABL90E8LQ8oyD69HI8J1qOQ=;
        b=dYccNhW2luVlBEXnjXtTgfOkIqZngso0q5xWAYH0nnDVKtWsw3Nm9u7JiGjKAVv7aR
         gVVMefdyTjK4qkv+hCC7vQktIoz1i2TuX51TK2P+2wTgAufKQ0dE0LGU21+dxVyb2QJZ
         dMQ4y1nUWrhCqYVJrnGcK2Ax/+oTrT5/F5hl7mH8ppkptjZPjjliz32kuJKkbhUfeMFS
         z8iQwBMIH/35BQn23HpabZKkpP5ySbJpVdRQQ6kxpbuqfgRfVEb90TQm1lLaQZmfP+KT
         LeyDvJHSDrPXhwdv26Xn7FNiORHWpQMSSMeZ87e9d+FTuJqLikRV+Btr5hjge8jl/N3d
         CxtQ==
X-Forwarded-Encrypted: i=1; AFNElJ9xDoFr/wEdik8G59n2LeRlt+9BtLYaCvf62V0VVUewJp8up2JC7h8MKIAVO/UgDriZ1PcTeFJTeN8LHjFPAQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx1M7I/Sz7l4jMoJA9iWX8xKDhhYfsZRsX8YQp+4vIrXlC5k8pd
	gwFamLYlKPXJiezkjAGY/EV2j1MikgRiw1z7k7ErowzQl7Jf3rHp05HIxt8gk2etasHeYOiPCta
	FJgDeug==
X-Received: from plbbj2.prod.google.com ([2002:a17:902:8502:b0:2bf:1b54:1fc4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:906:b0:2bf:13b6:dafd
 with SMTP id d9443c01a7336-2bf367ddeecmr1314895ad.18.1780065921988; Fri, 29
 May 2026 07:45:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 07:44:12 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529144435.704127-26-seanjc@google.com>
Subject: [PATCH v4 25/47] x86/kvmclock: Setup kvmclock for secondary CPUs iff CONFIG_SMP=y
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
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

Gate kvmclock's secondary CPU code on CONFIG_SMP, not CONFIG_X86_LOCAL_APIC.
Originally, kvmclock piggybacked PV APIC ops to setup secondary CPUs.
When that wart was fixed by commit df156f90a0f9 ("x86: Introduce
x86_cpuinit.early_percpu_clock_init hook"), the dependency on a local APIC
got carried forward unnecessarily.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 69a15fbfb779..13c728444e12 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -186,7 +186,7 @@ static void kvm_restore_sched_clock_state(void)
 	kvm_register_clock("primary cpu clock, resume");
 }
 
-#ifdef CONFIG_X86_LOCAL_APIC
+#ifdef CONFIG_SMP
 static void kvm_setup_secondary_clock(void)
 {
 	kvm_register_clock("secondary cpu clock");
@@ -326,7 +326,7 @@ void __init kvmclock_init(bool prefer_tsc)
 		x86_init.hyper.get_cpu_khz = kvmclock_get_tsc_khz;
 	x86_platform.get_wallclock = kvm_get_wallclock;
 	x86_platform.set_wallclock = kvm_set_wallclock;
-#ifdef CONFIG_X86_LOCAL_APIC
+#ifdef CONFIG_SMP
 	x86_cpuinit.early_percpu_clock_init = kvm_setup_secondary_clock;
 #endif
 	x86_platform.save_sched_clock_state = kvm_save_sched_clock_state;
-- 
2.54.0.823.g6e5bcc1fc9-goog

