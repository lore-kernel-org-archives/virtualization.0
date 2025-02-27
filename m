Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B001A5BBC
	for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 02:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622769; cv=none; b=LgB5w3gAlxBZE7zwiLzuyPYsJ4kLQyZPtaIr6StM6qS9qXy5GmwsQgFzyQXqbHp2hCTLxOR+gXRX3kVmp357MNfuuPB4JF5q9hdUQetvh53DHmpt/QmGOGmH4XzY6Mdd3GwxOwKtPUMD9ZLokJKr4HVTKcoFeLOHlwrAYg9qX/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622769; c=relaxed/simple;
	bh=tKdzx967TkUiaJBdJTLkl553UTH+9SxXCyvJrKuaAw4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PdGU+UkkHTOO0uSLKKP296YDmzhgNjNe354ggIiVmcZr2qrsXOVE7H53mEGy2PjWhmdWadqvzMwSVET2qph6w4rpBZDYJVECQSQx4w+CuBJ46AIQVL2ka3OmJtqWILQ28wftsW3OBYII6ogNaP7fm4CEJjcJIF05+9J1QLveekg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L+V3FEqG; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L+V3FEqG"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc404aaed5so1539534a91.3
        for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 18:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622767; x=1741227567; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=cUIL6SYLHU+yTwrAtTegZ21noDNMwlKuhwHKs3VPMSg=;
        b=L+V3FEqGresLMpKu+AXXYOhwG1z7qMr2DdhJMRnjkLbxW+Ty/xGoa1uCWv2iLJsvlW
         JCZMbhBVMVOVLhy0oTTBya1B6zaEabzHELoGKyjDH/baNXQqJHoXojzS+opZz9VXd5Mv
         WDcaxA8jNacY+oD/7duCjixLyIf7cAjJ+RZ8KlXZI+vAJBqVx1jm8XfAJK9jo7brflyL
         Qxh+k+uF/dzMB8subNP/7JBHDJHjR2Y4oo1tYxvND7dSoaxJDarfST0r5L1+wp8f1dHv
         UVmNp49/JHlxfmGVarWuno841nZfr9sux2qopCm3QRanSWSIlsfR6RmkYxdlAdj+e5Po
         ngtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622767; x=1741227567;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cUIL6SYLHU+yTwrAtTegZ21noDNMwlKuhwHKs3VPMSg=;
        b=rvgSMiXEH9hBXVOpsEnpA2jX1dS8Rr9NsxU0J1YKwCBR9DAekVFnwXBDh5WlUZsEFa
         3alVsoSXZTIPsnoCoj8e9nzxpOSr7ar7MlAZUECCa9D9oS08A3LSi9UhvJv01oIOd8hd
         MYlaMqGS9GouQ78ZwQrtRAxMBUXpzCDrdgMryu8HWKTRowAxh+hwTzvmK4CmQkKKovSN
         rrDeZ36CWWSRNng8NSISK4tI2Nx5e6jMqn97bYd7yPcSUIq6Emg1xDXw9XxuFA7gjVd2
         OjvdK0UplxqbybUV7CXe86bj2axbXCREYnFqsJTfviHCVVQl8duR1cACoCB1tFvywaxU
         nCaA==
X-Forwarded-Encrypted: i=1; AJvYcCVI6f+FJmVN+CG7PuGWaMnKk7C5DUReu7JEiX2JrU3SDse8zzv9cPrJlhPFVQ+xfhv8MYkZ1z/jKUOIEAu/Gg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwtcV9eL732Yi8BctIpZJNPCWTcCcvhgOhsrnkRG14yVKgCO2B4
	uDCEFbCCkIQPlTK407FmhRqisoaZf5K7uDuN3rtPS0Y3rzXrfjOck+t5SflSfBPx1aWUm8fenTr
	0pw==
X-Google-Smtp-Source: AGHT+IHyh9LqedkCKW+Gv/tYRFdHEhi/V70ldbMXUa2l8chtlUNDSfd68q5Rf4dBrz6sq443DVBJXoiGfdY=
X-Received: from pja6.prod.google.com ([2002:a17:90b:5486:b0:2ef:95f4:4619])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d44:b0:2f6:f32e:90ac
 with SMTP id 98e67ed59e1d1-2fe7e2fe521mr9393579a91.11.1740622767576; Wed, 26
 Feb 2025 18:19:27 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:30 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-15-seanjc@google.com>
Subject: [PATCH v2 14/38] x86/kvmclock: Move sched_clock save/restore helpers
 up in kvmclock.c
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

Move kvmclock's sched_clock save/restore helper "up" so that they can
(eventually) be referenced by kvm_sched_clock_init().

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 108 ++++++++++++++++++-------------------
 1 file changed, 54 insertions(+), 54 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index aae6fba21331..c78db52ae399 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -70,6 +70,25 @@ static int kvm_set_wallclock(const struct timespec64 *now)
 	return -ENODEV;
 }
 
+static void kvm_register_clock(char *txt)
+{
+	struct pvclock_vsyscall_time_info *src = this_cpu_hvclock();
+	u64 pa;
+
+	if (!src)
+		return;
+
+	pa = slow_virt_to_phys(&src->pvti) | 0x01ULL;
+	wrmsrl(msr_kvm_system_time, pa);
+	pr_debug("kvm-clock: cpu %d, msr %llx, %s", smp_processor_id(), pa, txt);
+}
+
+static void kvmclock_disable(void)
+{
+	if (msr_kvm_system_time)
+		native_write_msr(msr_kvm_system_time, 0, 0);
+}
+
 static u64 kvm_clock_read(void)
 {
 	u64 ret;
@@ -90,6 +109,30 @@ static noinstr u64 kvm_sched_clock_read(void)
 	return pvclock_clocksource_read_nowd(this_cpu_pvti()) - kvm_sched_clock_offset;
 }
 
+static void kvm_save_sched_clock_state(void)
+{
+	/*
+	 * Stop host writes to kvmclock immediately prior to suspend/hibernate.
+	 * If the system is hibernating, then kvmclock will likely reside at a
+	 * different physical address when the system awakens, and host writes
+	 * to the old address prior to reconfiguring kvmclock would clobber
+	 * random memory.
+	 */
+	kvmclock_disable();
+}
+
+#ifdef CONFIG_SMP
+static void kvm_setup_secondary_clock(void)
+{
+	kvm_register_clock("secondary cpu clock");
+}
+#endif
+
+static void kvm_restore_sched_clock_state(void)
+{
+	kvm_register_clock("primary cpu clock, resume");
+}
+
 static inline void kvm_sched_clock_init(bool stable)
 {
 	kvm_sched_clock_offset = kvm_clock_read();
@@ -102,6 +145,17 @@ static inline void kvm_sched_clock_init(bool stable)
 		sizeof(((struct pvclock_vcpu_time_info *)NULL)->system_time));
 }
 
+void kvmclock_cpu_action(enum kvm_guest_cpu_action action)
+{
+	/*
+	 * Don't disable kvmclock on the BSP during suspend.  If kvmclock is
+	 * being used for sched_clock, then it needs to be kept alive until the
+	 * last minute, and restored as quickly as possible after resume.
+	 */
+	if (action != KVM_GUEST_BSP_SUSPEND)
+		kvmclock_disable();
+}
+
 /*
  * If we don't do that, there is the possibility that the guest
  * will calibrate under heavy load - thus, getting a lower lpj -
@@ -161,60 +215,6 @@ static struct clocksource kvm_clock = {
 	.enable	= kvm_cs_enable,
 };
 
-static void kvm_register_clock(char *txt)
-{
-	struct pvclock_vsyscall_time_info *src = this_cpu_hvclock();
-	u64 pa;
-
-	if (!src)
-		return;
-
-	pa = slow_virt_to_phys(&src->pvti) | 0x01ULL;
-	wrmsrl(msr_kvm_system_time, pa);
-	pr_debug("kvm-clock: cpu %d, msr %llx, %s", smp_processor_id(), pa, txt);
-}
-
-static void kvmclock_disable(void)
-{
-	if (msr_kvm_system_time)
-		native_write_msr(msr_kvm_system_time, 0, 0);
-}
-
-static void kvm_save_sched_clock_state(void)
-{
-	/*
-	 * Stop host writes to kvmclock immediately prior to suspend/hibernate.
-	 * If the system is hibernating, then kvmclock will likely reside at a
-	 * different physical address when the system awakens, and host writes
-	 * to the old address prior to reconfiguring kvmclock would clobber
-	 * random memory.
-	 */
-	kvmclock_disable();
-}
-
-static void kvm_restore_sched_clock_state(void)
-{
-	kvm_register_clock("primary cpu clock, resume");
-}
-
-void kvmclock_cpu_action(enum kvm_guest_cpu_action action)
-{
-	/*
-	 * Don't disable kvmclock on the BSP during suspend.  If kvmclock is
-	 * being used for sched_clock, then it needs to be kept alive until the
-	 * last minute, and restored as quickly as possible after resume.
-	 */
-	if (action != KVM_GUEST_BSP_SUSPEND)
-		kvmclock_disable();
-}
-
-#ifdef CONFIG_SMP
-static void kvm_setup_secondary_clock(void)
-{
-	kvm_register_clock("secondary cpu clock");
-}
-#endif
-
 static void __init kvmclock_init_mem(void)
 {
 	unsigned long ncpus;
-- 
2.48.1.711.g2feabab25a-goog

