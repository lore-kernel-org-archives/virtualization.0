Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1194A3165
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 23:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059418; cv=none; b=AiT0a6HSzbt/dNny6HSjkJcet7TPdaZJW+tgGSelCvX8LAzjVQOfeI4X2aAiSdog9Oub8IBTC/CDzo2/sF0Dp+RH60bE35SzZPvwK0KpDKfkTfjZLHHL03Duxincnit4wTVA/BCGxfXjKDcJF+pASWsOTTAU1cygty0z+pA81mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059418; c=relaxed/simple;
	bh=rjQbLkkx2ub+8kt+Uu6IBZg4kMe4fhwmXJTlShW4cvI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u2Hp++xm5Fxmog3GtHkCzXCVZV0dr3rSzuJEB5B+YlnP1zqh4KxogAukk2eddw9fOHpNwQers9HiF+ohXcGfDISfVpW/uEJNrO4w3cGAe58UpW7C6U7G0KbOvWg80O7i825fbRtjmPcxZyEoBwYtBhuWdAEEwDWnAB2pv+zA3GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S+ZtghjJ; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S+ZtghjJ"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84e3d575d6eso4633027b3a.3
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 16:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059414; x=1786664214; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RXgfgHNb2M05mbaK7fzwXMNXNJyNMqWfUYS+q8iqpyw=;
        b=S+ZtghjJiYnMB6nvqQzrH+ig7HxsMwDGTg0NgxMBAeDwDiGlVvxt5C3eeAazujZJO2
         qx/z0aaRQxYymAe9AD2IdzgYkd2Swsy6uPr7UwZpFfECD7BzBnw2FTfESJZC1f/pU8RP
         5PeRvPwNw6vXRMeidoWmdeX4lqgPqE8g6LfnNZG6rRAZSdz1Rr3lnCoIkO9RBVSmHwfv
         J2+ALEme0h+wfyqgZH1nN0vzEgeWWJFxY/+u39dJXeMMqRYkkchAnmWCdAT6x/ojzGf0
         wN0QeqQ6cLa7Hts7SwQ9KEK6VKRH5k11hrWvpHnioAxMtkIFiJkP5pJWx+Gn4OJzVrn2
         ojKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059414; x=1786664214;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RXgfgHNb2M05mbaK7fzwXMNXNJyNMqWfUYS+q8iqpyw=;
        b=V8OG4xb1jZ0ZPyn+8APsLyOxhdsxQuEl4xSCgIXpmVv+ztd4qQvoR4joUJwIb3GRYi
         u3M227GavEqXwkHxuREFkwjRioy3ZQykgvHaCPSB//CVev9OEqwuDxNY8GKkAwIxg0Io
         Z3DcZmeXhIE5JWTZdsxJNhgagOjxvpZSHDRU9NamXFLePgBX6yTX8iuIRzQjc2mIVckh
         56rQYCG3u+CvXya1vEhAMCMVKumL8zO2TPC8LYpMG2xsI3e06o2V5u4BH97ic7IuTxdT
         2sy8EsitsmeXFfXyUUeUIJlVBU4HK2UlQdNzF2UOfyP+3lRKgPPqtulgHxTx1He+81yh
         GDkw==
X-Forwarded-Encrypted: i=1; AHgh+Rpzr+9+ZpTh6j+IDKdrEwFYUdY/Ve1auGbEwoIWs2XaiGACUkuAKwjLYEEUPE9prz6msdbffnrSjOGpFlt/og==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKWUCz+cGh00NR8XRwossYzrQ+EGSgXd0ebYjWNdLlVI7lxA4e
	+clEc4n/eK8YzeIMyLyVlAtdZtIP3CRb4ruZ4JoZ44oFdWTep/ityiNTjfQSLMspaF1/AS3/zAY
	aB407mQ==
X-Received: from pfcy7.prod.google.com ([2002:a05:6a00:93c7:b0:845:e683:1287])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:6e81:b0:84e:2bb:2d3e
 with SMTP id d2e1a72fcca58-84f2dfb4e50mr16994834b3a.9.1786059414067; Thu, 06
 Aug 2026 16:36:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:41 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-25-seanjc@google.com>
Subject: [PATCH v6 24/51] x86/kvm: Get CPU base frequency from CPUID when it's available
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

If CPUID.0x16 is present and valid, use the CPU frequency provided by
CPUID instead of assuming that the virtual CPU runs at the same
frequency as TSC and/or kvmclock.  Back before constant TSCs were a
thing, treating the TSC and CPU frequencies as one and the same was
somewhat reasonable, but now it's nonsensical, especially if the
hypervisor explicitly enumerates the CPU frequency.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 255a24a99f28..83b9351f2810 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -50,6 +50,7 @@
 #include <asm/e820/api.h>
 
 static unsigned int kvm_tsc_khz_cpuid __initdata;
+static unsigned int kvm_cpu_khz_cpuid __initdata;
 
 DEFINE_STATIC_KEY_FALSE_RO(kvm_async_pf_enabled);
 
@@ -930,6 +931,11 @@ static unsigned int __init kvm_get_tsc_khz(void)
 	return kvm_tsc_khz_cpuid;
 }
 
+static unsigned int __init kvm_get_cpu_khz(void)
+{
+	return kvm_cpu_khz_cpuid;
+}
+
 unsigned int kvm_arch_para_features(void)
 {
 	return cpuid_eax(kvm_cpuid_base() | KVM_CPUID_FEATURES);
@@ -1043,6 +1049,14 @@ static void __init kvm_init_platform(void)
 		}
 	}
 
+	/*
+	 * Prefer CPUID.0x16 over KVM's PV CPUID when possible, as the base CPU
+	 * frequency isn't necessarily the same as the TSC frequency.
+	 */
+	kvm_cpu_khz_cpuid = __cpu_khz_from_cpuid();
+	if (kvm_cpu_khz_cpuid)
+		x86_init.hyper.get_cpu_khz = kvm_get_cpu_khz;
+
 	/*
 	 * If the TSC counts at a constant frequency across P/T states and in
 	 * deep C-states, treat the TSC reliable, as guaranteed by KVM.
-- 
2.55.0.679.g6767b8d81c-goog

