Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9157B3D16F5
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 19:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872878; cv=none; b=iNAkqFH8jCwn8L1fcJs8DItf1K8VuVqlq8QRmcPcVV6vOWCbI/PggcTFTJmW8YmLbXe9sHlmQ8bsGRpEBU3dzglfwFMjmtS/gv/q4tmj9DtvOJMsj7avN+rU6ns6JL06o+J6J0orOhzIvYFGszQL/Bp5MwGLjp5zWDbV1Jx+Uis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872878; c=relaxed/simple;
	bh=lj0Wrx3Iv//hmkaQGmo4E+9Pr8EcmWhtdqcjCm5wSw8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TAc4fIpYbDIlzazp+2DO/rUTsTBuyho+GwTZEMNE52Q08cOFJwbjRcdrEYWIKYChNqVlWrsCouAekKc5eHtyhdZNoyCJroZw/scRRCxI0bnFxWwKuSn1GmpqXsDAiNpJSv57MFjVuU2pF06kPQgfFgUoCeOiQVfOIeE10XKnP/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SBjnciSS; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SBjnciSS"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-83f24cd00f8so200058b3a.0
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 12:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872876; x=1779477676; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=b8iwHk13SynGR+feSoAEVsPbJ8RDfXFvMc9oOLx500A=;
        b=SBjnciSSP8wkWZOdpHwnjfvBhPFC782nNaN1UKCHer9zJ2cEPBHmk04Jc0rFA0QvCE
         fuTFlI5Lyi1YzXcmSf1/3li8MG851aGfAOpNPvD+IoOD5TxxOd1WF5+KMozw44f1SvKM
         duiYPhKLY5hv57TATAolEe4wKL0SyeyVAWh2oc4Xl/19G6l3f20J34zmtEYL0LNA/ORl
         bSnRB26T+lYF2b0L8ZmsBVqZMgYooz0248tIlKqha02cWEr0SqJUpY+63kBl9mxt1Hni
         Dq9UOXJB3o2xEDiMlHX8QG7ifsUaOnK8sivSYf9JSnRJh8jov/UlneNH1AMYt8C8kjrH
         ntbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872876; x=1779477676;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b8iwHk13SynGR+feSoAEVsPbJ8RDfXFvMc9oOLx500A=;
        b=AWMWhc6C+EKcG5hk5Mp5FzBCR20WjbhvoEZyfRKKRhJLsG6INIOcLGX38n6Vyr9nfN
         tNES4ubNuo3FIkdN5+JUwoxYsaWhc1cX0FOh8lLFt4r4doWN1b7DH/f64t8lEWVn/hRn
         aYAN+x5ICwFJDN/TYHMi2Hec/go1AD9oWfIEMujmdaQAVXv/lOp/5AMiISbp062nSF5B
         plIwtI2Y+7eCcTy6QRvAKg7sX8eaFN/miVNe8Y/1fOnPYg+SXPGGtCetGy1GDrGT0GLb
         0IyXlMcY20uE15T1cG7LP/b1focrzUPY+CXUbrILs5JnAxPwkAcHPKJGtd90EaxLB6eh
         2rjg==
X-Forwarded-Encrypted: i=1; AFNElJ+l2D4MESwRmeBKzZmgzTSnCtdyRXGrRdgSuM+85Azs/Rk3sniMjEtwpQ8fSLVBcg0AL2q70pHCmbTRoE3d0g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwgY+ZA4Mbn6H1d4YpzDylrDZfXurEYSgs0naVHX8/LYOwIq8sQ
	HMhPkkaUht3Izt6yMnpe2i4OKYB/5zJ7aa8VZT7ih2g3EFS/Jd0DJF2yvQLg8wQy5MtNpKrE2Lm
	5Y+LFQA==
X-Received: from pfmm20.prod.google.com ([2002:a05:6a00:2494:b0:835:43a4:4aaa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4293:b0:835:41f3:f440
 with SMTP id d2e1a72fcca58-83f33bf68e4mr5394751b3a.14.1778872875569; Fri, 15
 May 2026 12:21:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:37 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-37-seanjc@google.com>
Subject: [PATCH v3 36/41] x86/kvmclock: Get local APIC bus frequency from PV
 CPUID Timing Info
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

When running as a KVM guest with kvmclock support enabled, stuff the APIC
timer period/frequency with the local APIC bus frequency reported in
CPUID.0x40000010.EBX instead of trying to calibrate/guess the frequency.

See Documentation/virt/kvm/x86/cpuid.rst for details.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_para.h |  1 +
 arch/x86/kernel/kvm.c           | 19 ++++++++++++++++---
 arch/x86/kernel/kvmclock.c      | 13 +++++++++++--
 3 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
index 3f7f558b5b24..381d029b72e7 100644
--- a/arch/x86/include/asm/kvm_para.h
+++ b/arch/x86/include/asm/kvm_para.h
@@ -130,6 +130,7 @@ void kvmclock_init(void);
 void kvmclock_cpu_action(enum kvm_guest_cpu_action action);
 bool kvm_para_available(void);
 unsigned int kvm_para_tsc_khz(void);
+unsigned int kvm_para_apic_bus_khz(void);
 unsigned int kvm_arch_para_features(void);
 unsigned int kvm_arch_para_hints(void);
 void kvm_async_pf_task_wait_schedule(u32 token);
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 5cd92a0b156a..bfe36e361b3c 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -918,12 +918,25 @@ bool kvm_para_available(void)
 }
 EXPORT_SYMBOL_GPL(kvm_para_available);
 
-unsigned int kvm_para_tsc_khz(void)
+static bool kvm_cpuid_has_timing_info(void)
 {
 	u32 base = kvm_cpuid_base();
 
-	if (cpuid_eax(base) >= (base | KVM_CPUID_TIMING_INFO))
-		return cpuid_eax(base | KVM_CPUID_TIMING_INFO);
+	return cpuid_eax(base) >= (base | KVM_CPUID_TIMING_INFO);
+}
+
+unsigned int kvm_para_tsc_khz(void)
+{
+	if (kvm_cpuid_has_timing_info())
+		return cpuid_eax(kvm_cpuid_base() | KVM_CPUID_TIMING_INFO);
+
+	return 0;
+}
+
+unsigned int kvm_para_apic_bus_khz(void)
+{
+	if (kvm_cpuid_has_timing_info())
+		return cpuid_ebx(kvm_cpuid_base() | KVM_CPUID_TIMING_INFO);
 
 	return 0;
 }
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 5ceba4f3836c..abcc5b36ea1d 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -200,10 +200,19 @@ void kvmclock_cpu_action(enum kvm_guest_cpu_action action)
  */
 static unsigned long kvm_get_tsc_khz(void)
 {
+#ifdef CONFIG_X86_LOCAL_APIC
+	u32 apic_khz = kvm_para_apic_bus_khz();
+
 	/*
-	 * If KVM advertises the frequency directly in CPUID, use that
-	 * instead of reverse-calculating it from the KVM clock data.
+	 * Use the TSC frequency from KVM's (and other hypervisors') PV CPUID
+	 * leaf when available, instead of reverse-calculating it from the KVM
+	 * clock data.  As a bonus, the CPUID leaf also includes the local APIC
+	 * bus/timer frequency.
 	 */
+	if (apic_khz)
+		lapic_timer_period = apic_khz;
+#endif
+
 	return kvm_para_tsc_khz() ? : pvclock_tsc_khz(this_cpu_pvti());
 }
 
-- 
2.54.0.563.g4f69b47b94-goog

