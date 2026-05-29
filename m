Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56273FFADC
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067304; cv=none; b=WnPkb40PyLi1WiEQQLMEQdUBk0df0QhmnpfNxs/xkIjzbnYk6NmQfkzVHuOidy46H3heR5n2zxDZ+KvBMqOWONvGCgLikdmk5WCKOMiI0nZfQWQi5gruNg0Yv7MySa72ufmgzrLhwG5BjXtYan+qgXyv6PjFyMv1/VGnYXWwzmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067304; c=relaxed/simple;
	bh=w7EHINNFIlZbRg/evTqhyq1nM7Dr9UCBDzW76qUJY8M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G4bhN7qHE0j7aXiF08EHViACLk5a+rqvv6v8YAf2ZFCLBrlYnPAa9JT46DXttK8qQaq5pHGshpMTZ06Bum5I0rX+4WT5cQ47AN9f7uBm8D0fpVgtuydKWq6KFrM1gmQWZagi1Vc+HJ3sHhin2M7X0mQEtzrdMlv3WH+97EoKY4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XzsdLGye; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XzsdLGye"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bf32fb7cb2so1715535ad.2
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780067302; x=1780672102; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=N9FJGXb1rHvCmGDbAStTerw3YHwheVCgedyMSiUJO9w=;
        b=XzsdLGye72RetLmiLlCDe8vujJvxzsTs2o4UG7QAyxAZUbVQcepmlqYYV9qLOece4T
         sTITN4r579lJOE5jtqtvUPh9o2PBOk9dls+L59qkwHxEsYLU27ydEIaVa8VscLYPhtGy
         EEPxScbzTS43v1XMzUeslf7oKfSs0RLFeBEmX/8EPwgRVS7etUF29B2MjCp6bT2QQBU1
         Y2fLEEjYpLnn+POJHno0OlKiGtpkOZKsNvlz2LrN/xnCpUPw0a0FaQGv7m70+eTIewPU
         xSysmDP5lNGrc0arOLp0wRl7W2WjRYOSmpZjGoLJsHr1N+uz1bGgtU37elpD9PKgCySG
         wHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067302; x=1780672102;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N9FJGXb1rHvCmGDbAStTerw3YHwheVCgedyMSiUJO9w=;
        b=It/gSXpef1n5V4K/8A6caf9G/GOIpHR/JgQpKns6MXDKUGkE4gagUp+/WTR/AcnE04
         wvrozgkz+UnRsPVNLSufcIvxcq5Jnaza69zVbCCVov+QTNeArFMqFFkImaCM5gikVJyI
         eAWQfpAyiF3hbo6dxhF3oM5QjapJ0fSdeo/1vGNT6Puu8ICAoQnmRXfBc9mRjJpC3odn
         bB4MebCxrqFohy10DI5ZY4TKmxkc4g6Z8//L1f5yKGpRCjrK1pfdMQU1R+Jh57jW4xih
         ONkhvBtcrh88yEbE1QXRDftIf68CkqFPr+LAKQZynFaueM6IX+4W5dGHfGYhWUXUykAN
         JPJg==
X-Forwarded-Encrypted: i=1; AFNElJ/RVHhPtDK2irP1weaN+S2EJuYFTda2MfoeWarlDiPD1rKbsnMed8oYPSnoxQgcTdcfwlEMPmUbUN60h8vlkA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJfTf67jK1HKM0M0mfUfGG6STwYneMOYYCOXg9mi78oObMtLU/
	QEWWXPhr+E3hroep7lSH0ugRmh4jrfGdA8y5FpYEV28DLmHR89GdJM77aguodW3zmZvUwHFIope
	XKn+Myw==
X-Received: from pgvi7.prod.google.com ([2002:a65:61a7:0:b0:c85:82f6:34de])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:594:b0:3b3:2703:111
 with SMTP id adf61e73a8af0-3b411e9b75cmr3575842637.44.1780067301940; Fri, 29
 May 2026 08:08:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 08:08:20 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150820.714844-1-seanjc@google.com>
Subject: [PATCH v4 41/47] x86/kvmclock: WARN if wall clock is read while
 kvmclock is suspended
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

WARN if kvmclock is still suspended when its wallclock is read, i.e. when
the kernel reads its persistent clock.  The wallclock subtly depends on
the BSP's kvmclock being enabled, and returns garbage if kvmclock is
disabled.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 5dfac79a5d30..73fabfac2bc9 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -53,6 +53,8 @@ static struct pvclock_vsyscall_time_info *hvclock_mem;
 DEFINE_PER_CPU(struct pvclock_vsyscall_time_info *, hv_clock_per_cpu);
 EXPORT_PER_CPU_SYMBOL_GPL(hv_clock_per_cpu);
 
+static bool kvmclock_suspended;
+
 /*
  * The wallclock is the time of day when we booted. Since then, some time may
  * have elapsed since the hypervisor wrote the data. So we try to account for
@@ -60,6 +62,7 @@ EXPORT_PER_CPU_SYMBOL_GPL(hv_clock_per_cpu);
  */
 static void kvm_get_wallclock(struct timespec64 *now)
 {
+	WARN_ON_ONCE(kvmclock_suspended);
 	wrmsrq(msr_kvm_wall_clock, slow_virt_to_phys(&wall_clock));
 	preempt_disable();
 	pvclock_read_wallclock(&wall_clock, this_cpu_pvti(), now);
@@ -119,6 +122,7 @@ static void kvm_save_sched_clock_state(void)
 	 * to the old address prior to reconfiguring kvmclock would clobber
 	 * random memory.
 	 */
+	kvmclock_suspended = true;
 	kvmclock_disable();
 }
 
@@ -131,16 +135,19 @@ static void kvm_setup_secondary_clock(void)
 
 static void kvm_restore_sched_clock_state(void)
 {
+	kvmclock_suspended = false;
 	kvm_register_clock("primary cpu, sched_clock resume");
 }
 
 static void kvmclock_suspend(struct clocksource *cs)
 {
+	kvmclock_suspended = true;
 	kvmclock_disable();
 }
 
 static void kvmclock_resume(struct clocksource *cs)
 {
+	kvmclock_suspended = false;
 	kvm_register_clock("primary cpu, clocksource resume");
 }
 
-- 
2.54.0.823.g6e5bcc1fc9-goog

