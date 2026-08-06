Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD6E4AA133
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 23:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059438; cv=none; b=DYogDjFRXqlGfRVi2N5Z/tiABj6ncZmnB0w7AjV/YbF7yNeTy450bQQz9JFG0Qzw6hphPWOCoJhvVpIoxY+8Uj5ftoFj9O+/u9przaqtb+tMEaS9+WuWvQBBWjC35P7rOeth644KWKes+2NUVccdrS1lZI74h3/v1kDfBWmrJ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059438; c=relaxed/simple;
	bh=EetB+RnX28VKy0jN0zLsMSRc1BZr5Co2JodEFYoMux8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kw7wJFjyNpnJq2WdkTO5sH37+hZ+WD4ICDilgDDAtJiRjruDC9sr8F9oVSVzcenLBFPMQYy0TdMycYJUlHoWeq/5nyiHwcDqr9QkD1hMyY6qRI5aLUwXbEevrADCKs5N6te0PFOHDFIfAioPkfYg77DzT3IdcTwZnMfpsv5L0yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UaGA+rOU; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UaGA+rOU"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84870e7f498so2971190b3a.3
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 16:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059436; x=1786664236; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DfVsK4/eNAzlqgTkif/k+3bkJqkVsqeG8riFv7GGWx4=;
        b=UaGA+rOU4ISVyxp46qdy+9CMBDARChj4qw1/HggMF1DAnF3FTCNtE2hyS0nxs1hUgU
         Sz+Z4oGsmwnAX9U3vyAUZLDyjLjSO1lmpdRsgH+nEJ+TMpCaJaTfeqe6T6xmLalFejYn
         aWT1+Okbv4lM1hs/EdN5T6cOCPwAOAk62+vcbcnuLc06/Wrym+SB6tjs2sgx2ka0MigT
         yl4BjxQ+bfnvIQuU5Z0JJsi/ADS5uhmsfcpgSkDari7ot1f4ouV6yLH3AVaSlYDHsK8D
         8WtfB5SVfWmmTuc/WGvpYqyBHuj/b888+0xrmb8i5V5kmN093NVNLlcM/ib/1xS815xh
         aBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059436; x=1786664236;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DfVsK4/eNAzlqgTkif/k+3bkJqkVsqeG8riFv7GGWx4=;
        b=FhXxSW+vlB0D9YUS8QtZntL2kDZe2G+pXGCUCaio5sPBn4vvnW8/QeJCqjk3CsJ1Z4
         ebJGLnzXyuzuqa3MRToZlhGATMWlufb/2kXG2X+XsV3GXWkH1jM9c3xfJR1dmPBVLZXE
         bkoNIR8xpo5TUsH0tt2O1/jumxjO7xaf6GKyWEXiYN9aSDz7E2YTVZ7pE6wB/RMA4J5H
         oWUb8WFcUVqchmT/LjhxyXBni1RD/jLTUloj1VqbkWT9Y4xnS5XFMXtIut2MuRFpshrJ
         qQb7/iDZimdCHkI+s6TMi9N1wRp0nYe+AIUCuMhR57h9pjLTB1HT/75KfDlXZ4o6KIlw
         KfsQ==
X-Forwarded-Encrypted: i=1; AHgh+RqBp/KPH9ePZ1f4w72EhzuHuLn6sKvArCN15v5ui5bQNFs/RHGIl3YMC8Uwvee8u0ZiB22PnJ5DeWIHrdFzug==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx522YWKdE4wViqe88P6tw04wYxPFZ7Lk9xoQduAZKviIBZylYu
	z3cE9re9R7bNMop+TllP1Asr4XH3p3ctAjKJxE/sX70T2nne49TeqqL6Cjv5j/DKKhX+vUVYjb5
	77icq9g==
X-Received: from pfbko19.prod.google.com ([2002:a05:6a00:4613:b0:847:926b:dc17])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1886:b0:847:99a7:c751
 with SMTP id d2e1a72fcca58-84f2e05d02dmr18083285b3a.25.1786059435385; Thu, 06
 Aug 2026 16:37:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:58 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-42-seanjc@google.com>
Subject: [PATCH v6 41/51] x86/kvmclock: Refactor handling of
 PVCLOCK_TSC_STABLE_BIT during kvmclock_init()
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

Clean up the setting of PVCLOCK_TSC_STABLE_BIT during kvmclock init to
make it somewhat obvious that pvclock_read_flags() must be called *after*
pvclock_set_flags().

Note, in theory, a different PV clock could have set PVCLOCK_TSC_STABLE_BIT
in the supported flags, i.e. reading flags only if
KVM_FEATURE_CLOCKSOURCE_STABLE_BIT is set could very, very theoretically
result in a change in behavior.  In practice, the kernel only supports a
single PV clock.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 5220d205abc7..61d4d943fe74 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -327,7 +327,7 @@ static __init void kvm_sched_clock_init(bool stable)
 
 void __init kvmclock_init(bool prefer_tsc)
 {
-	u8 flags;
+	bool stable = false;
 
 	if (!kvm_para_available() || !kvmclock)
 		return;
@@ -354,11 +354,18 @@ void __init kvmclock_init(bool prefer_tsc)
 	kvm_register_clock("primary cpu clock");
 	pvclock_set_pvti_cpu0_va(hv_clock_boot);
 
-	if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE_STABLE_BIT))
+	if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE_STABLE_BIT)) {
 		pvclock_set_flags(PVCLOCK_TSC_STABLE_BIT);
 
-	flags = pvclock_read_flags(&hv_clock_boot[0].pvti);
-	kvm_sched_clock_init(flags & PVCLOCK_TSC_STABLE_BIT);
+		/*
+		 * Check if the clock is stable *after* marking TSC_STABLE as a
+		 * valid flag.
+		 */
+		stable = pvclock_read_flags(&hv_clock_boot[0].pvti) &
+			 PVCLOCK_TSC_STABLE_BIT;
+	}
+
+	kvm_sched_clock_init(stable);
 
 	if (!x86_init.hyper.get_tsc_khz)
 		x86_init.hyper.get_tsc_khz = kvmclock_get_tsc_khz;
-- 
2.55.0.679.g6767b8d81c-goog

