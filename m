Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D44428D09
	for <virtualization@lists.linux.dev>; Wed,  1 Jul 2026 19:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934404; cv=none; b=l9+Jm8klxhKCjjP3Ylk5sV+Eh3ke7uULK3SPQSqInU84niKsxaqiQ1tVLGmoZJPrig0fVPJ1nXIdEowakltLaoxsCLayWpYhIK66287XZTyCFtQe8ZfEOFH/MGLDX9eFCL+76OHpN2zGOHVFKHedzHK6su7BNu0P5hcnJK+kilM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934404; c=relaxed/simple;
	bh=yJ9ey08FPsxOVFIWPFG6h7XBR1765ZGM408oIX3wjfI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eioDnV1SRRm4OmTWHf0QCzbx3fx/0E1h84EoOStPRIUDj+8RR2kjgC/XiWvrXqcETdti4SVNZ8HWONDkYJTv56Ug5PgZ79jKwsZdXefDQJI2UUWhQX1ECHMN+8DosqL77gzJCq2jcdiOmJO9MUeDNq97iJV2FQAM3K5OEntmdVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IvoHCQRP; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IvoHCQRP"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-37fc13e8182so1271524a91.3
        for <virtualization@lists.linux.dev>; Wed, 01 Jul 2026 12:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934401; x=1783539201; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=X+4LkvbZ4eCaIbae7uS/MPBNwexrDlCNdhdaInFV7cw=;
        b=IvoHCQRPJVVAqecH91sP2PQxJbaXG6xkaf1DcxaCbXcT56taTVYSY5jG0i2UDkG498
         Mr0A90ghYdiKqWc/CUww0DA1892CrGSX3iEJrbwSBZCn4ihpKf5pOJiMDCsOQRbkT2ZE
         i6VQwd69SKSW6YF5UXy7TCIfKRYFNV3JVBc91MeS2z8of3NyOsSWo1uR/JA6RpjtZ4Y4
         4w22i7D8BwGjwf6MGpDNOF596LraP9sW+57olS8kKcmLxpjRL8sS9Aagvze4V5zqsuFo
         oEvrRl5NasEhBRdfbQwrcBg9YxB2Zalq5p9pYX+GuSZ9W0n7nxw6/rE6Udhdm72ZvBU2
         GoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934401; x=1783539201;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X+4LkvbZ4eCaIbae7uS/MPBNwexrDlCNdhdaInFV7cw=;
        b=NTrmrpV+rbb5Ay5Pn8njlO1Vo+gTOthiZWaVkIFWb+iBUfi5KD6qSPzNjo/zViw2BC
         nM75f10znKDvarrQlMHij0x32w/fslC29wUSJaQGGXTs0cg2LpwbL0dzK62Jltzy3rQ3
         RM9FRtbMocv/hu8XA8iQN7GdPgaJoX4X0iUTphwWz5lqgB8SKyAggVYVgVMTXwEIrqQ8
         5rkkQX2UxXMfvm11+LXXbcFLGPlY7QMQwuKCHnWuGLgzE/5sCuIHK6zO6wxgO+5Z1fix
         GfZ4z+iY71nrry56w5hCP0nqL4794v4XjShlMe33sVjLXTmOveAl+Kxt97Auk+fYYANs
         S+uA==
X-Forwarded-Encrypted: i=1; AHgh+Rp1DG/9NYyf4/AZIMxzOe8IWJLxK8kplhvDwTgey33tNj59CL8WZks+yxUVYsBtJj+CD2czLdo4nT3gxkrQfA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxtF6AUIm2mBaBhnRPURR/syJ3Ke9Ma7nN841K373XbOtR/nXmt
	LMPlxs5MzFCaQA6CzdimbMTlaN14UD3VYxnMEtlY/19otnZy4O7B8baj+uCsj2bccNayk4Ywden
	yMWhpHg==
X-Received: from pjbms9.prod.google.com ([2002:a17:90b:2349:b0:37f:9ce0:f1f5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2c87:b0:37f:ed7e:7e42
 with SMTP id 98e67ed59e1d1-380aa0e0512mr2733682a91.14.1782934400395; Wed, 01
 Jul 2026 12:33:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:32:05 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-45-seanjc@google.com>
Subject: [PATCH v5 44/51] x86/kvmclock: WARN if wall clock is read while
 kvmclock is suspended
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
index 41aff709b90a..2cc3dd2ba355 100644
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
@@ -140,6 +143,7 @@ static void kvm_save_sched_clock_state(void)
 	 * to the old address prior to reconfiguring kvmclock would clobber
 	 * random memory.
 	 */
+	kvmclock_suspended = true;
 	kvmclock_disable();
 }
 
@@ -152,16 +156,19 @@ static void kvm_setup_secondary_clock(void)
 
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
2.55.0.rc0.799.gd6f94ed593-goog

