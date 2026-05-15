Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59A240C7A3
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 19:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872866; cv=none; b=GjcI1mi6ff3xINu78RZAvQP9JIcAUnoJnNBNOKTzQbRzKTnbgUYapMsFHp8n6xjAulekrW/DhAN9iNPs2/alHl4AlK3UzxjbuQB2D29iI3j/7Vz9P+NegvouSgKene6pg53Xnz0x4M4Fz+baqMxEPHSlVz2zLT86xO+tCVt9J34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872866; c=relaxed/simple;
	bh=njyJbcCwcXeXO9YjbcQGwk3m3d5+4iPknlalgaFw/CU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LJmqfGu1i5110SD8Fvs0FVGJNblFxtitXwgVJNoWyejFl9Rtj55yoiV6JbNZ5pA73h0bHiUA7FV+vjrz3FEmPWNRZAL2oUw1v11uCM3d8TMsuFFvZlExkUSNa5wWM1JKqdw9V9VsnIWnLhw8UeHbqXgREXVFtu8a3hSAZGQkwOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AEC3WCL1; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AEC3WCL1"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3662e7756f0so82762a91.1
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 12:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872864; x=1779477664; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=5QvrpVnh0KMuRz6LXU92QW6Er6134KolvOCNQ9nQk3A=;
        b=AEC3WCL1qdJ1MccWE70WBSEkFqwje5KnoyV9PesCAPYLq/wm2jVzOqNQeA999GtAOR
         zwNT2H51dGRQCUQzCXsuBQn9PflMDEUga+BS0YksSyvSaVL2XCEIap27P0+6Rrj3mm6L
         dEaFT8cVC9S8AMLIH9U1oywWErs8hpVWk6Wd+y7HYY3pHOTpGP7X6yFBfOKbc+jwh/yD
         i+qrRk+l8F2POl3Tm2ki04++s8mVs1RFrbif3hbE6yNQPvyL+n/Y2ncMgPqIoWF6cgDv
         PGEqbhosoRJ7sgZSyp1kWp1WfydioTeaypxtK7Ig9fXygjL2WdKk5NXJjaQqKDfvltC5
         wyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872864; x=1779477664;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5QvrpVnh0KMuRz6LXU92QW6Er6134KolvOCNQ9nQk3A=;
        b=ZVow+ZYzI+502t9BLeCIpbI9oYAVvJbOCVgHHkBZ7Kcey5JmcSdn3GLGH3QZQa55ko
         OmvF6PzHW2EzzudxGmXmhD2AxxwzYV+qQDFp7jqCkxnq+mcI1g3pjsngjIUbdTbIe2Xu
         KMhcBS5dtXbQcuUhORp2dKXYTe3G4xN0jnOWYsZfyUBdt2UrixIOW7rN+xlGuvJhXRoG
         yMX1NrV+/FsiuSn20W85LlIyonfz4yg57e/XFb87CNzcidpAAnQZWOdJZoy+g0qopSpx
         10iNbm9XqpDk/9z2Mm5aGsOTuL+Sy4oLGMmMGoHs7Egwywp26zOzVJjOBPlGWfbIUCAI
         ZVaw==
X-Forwarded-Encrypted: i=1; AFNElJ9ExBAgczNKRxkX96gIUQ2Wi1GNQiXJDNTWy3lboFrzsnGux3Oa4eCtSl9KV5Jin3nFfIEPwjSqZQYGRBS8wg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxYB9AErwnk3spmOzCws6AVLSfv1CgR3xr0rBE9Ra4ZrqMh8Gdj
	SQeib2a8DlC6cHjsIaa+e5WmxjwjtcsMWn/sjnIimfk3DScwpFGBY3w7G8kxVchZ91K5X+6X+TZ
	TJCZ+nA==
X-Received: from plbl12.prod.google.com ([2002:a17:902:eb0c:b0:2b0:aef9:a5a2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d84:b0:368:433:b697
 with SMTP id 98e67ed59e1d1-36951ca51ecmr5533993a91.19.1778872863652; Fri, 15
 May 2026 12:21:03 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:27 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-27-seanjc@google.com>
Subject: [PATCH v3 26/41] x86/kvmclock: WARN if wall clock is read while
 kvmclock is suspended
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

WARN if kvmclock is still suspended when its wallclock is read, i.e. when
the kernel reads its persistent clock.  The wallclock subtly depends on
the BSP's kvmclock being enabled, and returns garbage if kvmclock is
disabled.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 655037949446..e7250d21c672 100644
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
2.54.0.563.g4f69b47b94-goog

