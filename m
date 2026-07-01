Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A389F41C8CE
	for <virtualization@lists.linux.dev>; Wed,  1 Jul 2026 19:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934383; cv=none; b=nWJARLaJQDp67sA+nvuQ+CFcmZ8C/1Tpzo1ng590eAVMcG7wry88rL7Xhls0K6ALKTDFms3iV0SUBuvN+0HAUxDdTHUQa0BRS2uSJjYXcW+qVBr8ydTZ4xoptgt8gQPVvsnJxrUTxM94biMJLc79AmfF4BKtDa3GyO9UK8fei+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934383; c=relaxed/simple;
	bh=7ECvDpVYy24rqoUPVQpDZNfw6Aqt7A7i1akOyN+Prss=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NoHQOsS4l3S1fy272U56F4ISQXX6Y/Q1xTAyw0bS3GpEBfM/kz2TYGHFHWxlYN8CETyYRKMlNPOe4GBW9BwU0bS55GNKTGU/lsiumLgibu9XPa236iVD5Tnn3Y9ATKOkcyEwxljzea2Q6zKkEtvAd+VclIB0/LdY2/ck+Dvmm4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FwFScT8+; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FwFScT8+"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c9b1b608e2so14566925ad.3
        for <virtualization@lists.linux.dev>; Wed, 01 Jul 2026 12:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934381; x=1783539181; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=IHAlzrllQ2SIWnv0fCfBsaTBNv7ymljQujJZvblLIYE=;
        b=FwFScT8+OiwEGBK952uermUzhiWGkW6NMRbc63IKBa53bFmIdPxZBd8PNrtictgwJW
         yiEjsvSHh8GJeIfkyyZHIyyTBl8nHMEIHYmNbG5UN8ocdjTzxCV55cD0J1Dn/tzIYxa+
         y1SigXDQ0Kj0oZv5EF5+sujyD6Wi2R/LMK/TINUWm35NGaTKo/EKi7bAU59EzzAXK6/m
         LtH/ccdlOtKbTfpXOBHzyyfCgP6bsd5hfENmiZ2VfEdTKmiYzGA3+uqVBB3NRD/5Oa2n
         VI0uPMW0HNE4UoWtm+0K5VkWwQw1oHdCe9RJzNAxWA5SyPD3wVY67H1s/gGB2wCUmuPk
         lIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934381; x=1783539181;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IHAlzrllQ2SIWnv0fCfBsaTBNv7ymljQujJZvblLIYE=;
        b=dULJ+Gq4z/+0HclMpoQ6D5zNboc7FH/qVbjYBZrY6OxSvEwgjjJmmCzdW913EzdC9s
         bVRZjXYF65k8GvyIrztnIOI8j+0UN2nE0CiJySe591HbnyHUbinQuFh29kOWkWCtsRn/
         Cis10GGAPGZ+J5uSDfcmMrmQldPiQjFY/f3HxOfF33JATe0reuC1zsgCqr+97csHNJZt
         u4Stw1zgoYyP5UuSUvt7Iic/o7zx0tgi0HSzLgWYAiQ3BrSNqCdsLL7gOI1OUvnUvbL1
         jlRjxf0OXe4mPwyk1Q+aPs+Wt7NgkG7IZqZqhmzCLXyBsvuWrCIf5iv1eY8chBS5V5zb
         4RZQ==
X-Forwarded-Encrypted: i=1; AHgh+RoZn49T9OubLeiJShug40YYlzMNjQ8FsPpI3kCE0QSkgDeC6exhXva0avGDCCM81nIAfm+DcPgiklCO3UJdIA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywd8rQeWIc85kXzOAtyokbVbIQeIqtC3Sm4Q802/bHmsWftrQfY
	U0qUXBR3Nn66cc8d7bEiHGtwiELljVrc36pAX9kMrA2d1ZCJLxsW6xHUL2/P+sjpgwQ8I3FhF3Z
	1nrEyuA==
X-Received: from plblk15.prod.google.com ([2002:a17:903:8cf:b0:2c7:f338:5690])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:41c7:b0:2ca:de3:15e2
 with SMTP id d9443c01a7336-2ca7e561189mr31594705ad.0.1782934380474; Wed, 01
 Jul 2026 12:33:00 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:49 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-29-seanjc@google.com>
Subject: [PATCH v5 28/51] x86/kvmclock: Setup kvmclock for secondary CPUs iff CONFIG_SMP=y
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
index 2e7ab54cb9dc..b0c871ba8232 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -208,7 +208,7 @@ static void kvm_restore_sched_clock_state(void)
 	kvm_register_clock("primary cpu clock, resume");
 }
 
-#ifdef CONFIG_X86_LOCAL_APIC
+#ifdef CONFIG_SMP
 static void kvm_setup_secondary_clock(void)
 {
 	kvm_register_clock("secondary cpu clock");
@@ -348,7 +348,7 @@ void __init kvmclock_init(bool prefer_tsc)
 		x86_init.hyper.get_cpu_khz = kvmclock_get_tsc_khz;
 	x86_platform.get_wallclock = kvm_get_wallclock;
 	x86_platform.set_wallclock = kvm_set_wallclock;
-#ifdef CONFIG_X86_LOCAL_APIC
+#ifdef CONFIG_SMP
 	x86_cpuinit.early_percpu_clock_init = kvm_setup_secondary_clock;
 #endif
 	x86_platform.save_sched_clock_state = kvm_save_sched_clock_state;
-- 
2.55.0.rc0.799.gd6f94ed593-goog

