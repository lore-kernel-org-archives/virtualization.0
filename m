Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5AE22F38B
	for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 02:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622790; cv=none; b=t3WcP7Z8cw27DBklwUkWFkW4/ShSx14Fu4wc8mco3GGD91OT8WFglqx+9f+A2216zDdUMsV7TCxyzSYZUOEd6D4a9ZOAv7FgcdvzHfZlmI4f0LgmGjXGqMWdqXEtD6qV29hYYBmZdfsln10n6RqjESQZPprx/dipBmbJOjb+Ho0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622790; c=relaxed/simple;
	bh=R5OwNlXhbkGyFpfs6H/9FfbWD/QK2xYWDQUAUET1omM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qxXbA1E2sVz/0ht9C0CU2QK7bYjjaecC6jYBz16ijN+IWLH+Ja3atIqNuG/IKxYnINsrZTuPrw8VHemX2uaCCkUEoxE2LNPkyOtQbFPRuWjejxE/v2trSLxp3uJPynx0lGDIfeTfd7AasSYTj54I4AW0D9fZx6ScUKYiddUkJJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gb+RaMoa; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gb+RaMoa"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fe8de1297eso1024021a91.0
        for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 18:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622788; x=1741227588; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=8l5U+hO6xQEeVCf+kI9O/UrrnIVeF1W04fkwqmR0RAk=;
        b=gb+RaMoavqOJQ/IVz7yqb2VwYoTHkZA8k1gepDGfyCLHCFE3vaLoQmMyUG846MGCgL
         bqXOx+xHBCGSMhmX1YTGJ7mHjD1hHE/46oY2ZwMbmUpeNnTd9pCo9xgjwbMCWtsHAxWn
         GZIzjdXCpTC7yXUW+h7HDr7pkkYWPB6yvdUUn5c4kZqQ74VqaGL3sbecAOXzxcU0fHuP
         O97RoRlhqRAeq+E7REnkUnZnGNKkXIBzxsmux1tYjLiHScfjYZZ1BfyCG3HGAYf8ZPiy
         5z2RKgom4CrKoG1meFGKWbbhgEpmUBNEU5LlUd4kucDNg1u595aS8oCTXFQk1bdwDAv2
         EOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622788; x=1741227588;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8l5U+hO6xQEeVCf+kI9O/UrrnIVeF1W04fkwqmR0RAk=;
        b=hZVvCs0x6LTgtobngeOlu/a7cS88PRXzkJBOoWE2iuZskZ6HRhb2q4GtqjWUEpJzsO
         2KEWh8IrF0Ey1EFa2cB7UEDvFv8qPF8eX2qm2WMF2Y6BhtkCOVvyeM6fGwDfv/VdLq0V
         jAUCKJbIKJNWLhGKZlCLFr5P1pQJeVOKXipESAgqtDRv5gHp0LsttNFA/ItrDMnRxFZE
         pbvpm0NazpLCMrDz7cTTv/9UJBlgkoKjMUEkBqSvwMWji2wrFswT1QlFUXB+11WL80VN
         UWncWZwNFn0lr0aVU7h4Ky9beq+iTFy5mwW39h+zdzsH2tI1RL173XS7jqin+HDi8taX
         lI3g==
X-Forwarded-Encrypted: i=1; AJvYcCUWbjBusEyO71xgUv+d2ZOAbwt+M0CbL6y6X2mdMY1JQWcwdJNnB9xEl2V09c+oxyM94Ci5oezEWF2DN7lGZg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyBpWoeXfxidxi5OKTzww5WLs3PC9ngLdMDjq+4x7TL7czZ25k1
	N9bYihyKJhplBPeCrXddOXFvU3djPJU3veZNRPb+PZUQZbF6NEwYkgF7MFRKK/3/9GPibIT1ug9
	Z1Q==
X-Google-Smtp-Source: AGHT+IGsGVabM6lqtL4epZ9oGORwajTYA23ku4RspaNu+4NGjN39FOibtOjpJfF6SNul6q4RPaHxkAISArM=
X-Received: from pjbph15.prod.google.com ([2002:a17:90b:3bcf:b0:2ef:d136:17fc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3901:b0:2fa:2268:1af4
 with SMTP id 98e67ed59e1d1-2fea1299b06mr2509653a91.7.1740622788182; Wed, 26
 Feb 2025 18:19:48 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:42 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-27-seanjc@google.com>
Subject: [PATCH v2 26/38] x86/kvmclock: WARN if wall clock is read while
 kvmclock is suspended
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Juergen Gross <jgross@suse.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	John Stultz <jstultz@google.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>
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
index 319f8b2d0702..0ce23f862cbd 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -52,6 +52,8 @@ static struct pvclock_vsyscall_time_info *hvclock_mem;
 DEFINE_PER_CPU(struct pvclock_vsyscall_time_info *, hv_clock_per_cpu);
 EXPORT_PER_CPU_SYMBOL_GPL(hv_clock_per_cpu);
 
+static bool kvmclock_suspended;
+
 /*
  * The wallclock is the time of day when we booted. Since then, some time may
  * have elapsed since the hypervisor wrote the data. So we try to account for
@@ -59,6 +61,7 @@ EXPORT_PER_CPU_SYMBOL_GPL(hv_clock_per_cpu);
  */
 static void kvm_get_wallclock(struct timespec64 *now)
 {
+	WARN_ON_ONCE(kvmclock_suspended);
 	wrmsrl(msr_kvm_wall_clock, slow_virt_to_phys(&wall_clock));
 	preempt_disable();
 	pvclock_read_wallclock(&wall_clock, this_cpu_pvti(), now);
@@ -118,6 +121,7 @@ static void kvm_save_sched_clock_state(void)
 	 * to the old address prior to reconfiguring kvmclock would clobber
 	 * random memory.
 	 */
+	kvmclock_suspended = true;
 	kvmclock_disable();
 }
 
@@ -130,16 +134,19 @@ static void kvm_setup_secondary_clock(void)
 
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
2.48.1.711.g2feabab25a-goog

