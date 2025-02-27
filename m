Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D341B042D
	for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 02:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622811; cv=none; b=dZqczl0tgUPoIoHF2c0EBZo9caRmrK40mV2GDtSVh4XhTWFqfzk8o8nz9sHt+dXL3DKI2oRyL8tk8GwKw/2msdXB0Bu/RoLiQHr4PtjIOJuDaQYkb/3YogQZFW6H6l1CIPCfnEjemiKSes5wQavZY7tE+JZmdrI/dhPBaVDE7sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622811; c=relaxed/simple;
	bh=hxlTZC8hhB/2jCSFfc8NfglIDRkf8SaM4Ur2KmgRPXU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UtnWH3aYhZf5AGvO+O9B7+3WGhDwNrcfNEPHFMIA3c10i4LdczUDkoVda89KvfkudzLSV14AGTsUOknuMHd7Ilxm4ntF8J3AUf8GbgyYIpH4e5m/7w7xueKI4vh67biym3odRYobrXtYdDCaXYBq6RrVh5qneDw5J1efg5YK31k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L5c6SCvJ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L5c6SCvJ"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc0bc05c00so1509832a91.2
        for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 18:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622809; x=1741227609; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=7QXAixlOaLHnLrPcLZCTebtwCxVmNNMI9kZmebDzK/g=;
        b=L5c6SCvJ4miV+UonuynWMkS6rdqfDDoqAR8SWIOmM9PQ3Z8fDM9RSKPqiKMgvEV3fz
         hfVcYOlWNlXLQ8c+AVbA2JMrHola3tKVJw1EEfKyQIgGtKoRQtfpkQATpsTw2cpUsLrK
         ODdXVoLLq9iOm77Z5oQcAUiY3raYbx+gM1B6jkIvE7shTOqiHNSU8+Ayf9aHKqooiAJy
         gdhDGbTaf85LcUhovWZcvtKoDyGQslr8tt4X5zNaJ8hzS2RdOCgB0UFcsyVoSMWLCy9S
         GQV1AAElru3KeGCwj0O4h4DYoVEdMIg+VLl9Llz5imggqAY3u1jxQR1MWEbeJwyC/GkC
         QCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622809; x=1741227609;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7QXAixlOaLHnLrPcLZCTebtwCxVmNNMI9kZmebDzK/g=;
        b=Ys37awR8Kt9/Qk3oBfRKSlhPxBwxMz1xRbXiy99GWfgGqoOaNzKucRu5bHWFqkj6dN
         4FtvQuZTfl25fhLAtmT6vOMXybvAJXLlGR1MYs5k0AB2AuPz/g+m3i6a8c1lZbc2jTwF
         tjbVnBsSbajQ9km8MscH1pwboFAALe4WCxy7vZCuPjrFtilgwrEojY9zTwemcgwLurLz
         Uo05dOgby5EvrayzMQQ3vIsSnEskuCbgo+gF0znLxrKvoI8AYgHC8wj9+2B1Y0OlOACj
         A7zExQ5eqlCe1QWDRYfXC7IKc8IXasaJKkRPOKtwWLA/1CQ8Nis4eLA9T1ryHUzBFrZW
         vwxw==
X-Forwarded-Encrypted: i=1; AJvYcCUgWo66Rka9y1kwqUY49kZBYBnVpVb+qRVkGuJumvb3z4j+lRCoZ+8VqsxtlzOLN0aY28TaIDLx2bGWwU+Gzw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwB1tzEYNty0HWeVtWGywnS1zoBeNog2RkYiUzeuH2bkGKs8TTn
	nqsT8bwRwYMmTl1uuozMA3gYTGUhsfYSJ7/Se0paWdRGveFUk0hDvV4adF6N0t6fn0HRVLXwGXb
	e7Q==
X-Google-Smtp-Source: AGHT+IHi4d1QOUfXEPfDRjR4DxqWNosFyXVnkFi4SDlf4Oxmtkdi3La4kP/2IDxMG83GHnzWpK766unKU5E=
X-Received: from pjz6.prod.google.com ([2002:a17:90b:56c6:b0:2fc:3022:36b8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5688:b0:2ee:d63f:d77
 with SMTP id 98e67ed59e1d1-2fe68adec61mr16362401a91.9.1740622809153; Wed, 26
 Feb 2025 18:20:09 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:54 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-39-seanjc@google.com>
Subject: [PATCH v2 38/38] x86/paravirt: kvmclock: Setup kvmclock early iff
 it's sched_clock
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

Rework the seemingly generic x86_cpuinit_ops.early_percpu_clock_init hook
into a dedicated PV sched_clock hook, as the only reason the hook exists
is to allow kvmclock to enable its PV clock on secondary CPUs before the
kernel tries to reference sched_clock, e.g. when grabbing a timestamp for
printk.

Rearranging the hook doesn't exactly reduce complexity; arguably it does
the opposite.  But as-is, it's practically impossible to understand *why*
kvmclock needs to do early configuration.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/paravirt.h | 10 ++++++++--
 arch/x86/include/asm/x86_init.h |  2 --
 arch/x86/kernel/kvmclock.c      | 13 ++++++-------
 arch/x86/kernel/paravirt.c      | 18 +++++++++++++++++-
 arch/x86/kernel/smpboot.c       |  2 +-
 arch/x86/kernel/x86_init.c      |  1 -
 6 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 5de31b22aa5f..8550262fc710 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -29,13 +29,14 @@ DECLARE_STATIC_CALL(pv_steal_clock, dummy_steal_clock);
 DECLARE_STATIC_CALL(pv_sched_clock, dummy_sched_clock);
 
 int __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
-				      void (*save)(void), void (*restore)(void));
+				      void (*save)(void), void (*restore)(void),
+				      void (*start_secondary));
 
 static __always_inline void paravirt_set_sched_clock(u64 (*func)(void),
 						     void (*save)(void),
 						     void (*restore)(void))
 {
-	(void)__paravirt_set_sched_clock(func, true, save, restore);
+	(void)__paravirt_set_sched_clock(func, true, save, restore, NULL);
 }
 
 static __always_inline u64 paravirt_sched_clock(void)
@@ -43,6 +44,8 @@ static __always_inline u64 paravirt_sched_clock(void)
 	return static_call(pv_sched_clock)();
 }
 
+void paravirt_sched_clock_start_secondary(void);
+
 struct static_key;
 extern struct static_key paravirt_steal_enabled;
 extern struct static_key paravirt_steal_rq_enabled;
@@ -756,6 +759,9 @@ void native_pv_lock_init(void) __init;
 static inline void native_pv_lock_init(void)
 {
 }
+static inline void paravirt_sched_clock_start_secondary(void)
+{
+}
 #endif
 #endif /* !CONFIG_PARAVIRT */
 
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 213cf5379a5a..e3456def5aea 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -187,13 +187,11 @@ struct x86_init_ops {
 /**
  * struct x86_cpuinit_ops - platform specific cpu hotplug setups
  * @setup_percpu_clockev:	set up the per cpu clock event device
- * @early_percpu_clock_init:	early init of the per cpu clock event device
  * @fixup_cpu_id:		fixup function for cpuinfo_x86::topo.pkg_id
  * @parallel_bringup:		Parallel bringup control
  */
 struct x86_cpuinit_ops {
 	void (*setup_percpu_clockev)(void);
-	void (*early_percpu_clock_init)(void);
 	void (*fixup_cpu_id)(struct cpuinfo_x86 *c, int node);
 	bool parallel_bringup;
 };
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 280bb964f30a..11f078b91f22 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -126,12 +126,13 @@ static void kvm_save_sched_clock_state(void)
 	kvmclock_disable();
 }
 
-#ifdef CONFIG_SMP
-static void kvm_setup_secondary_clock(void)
+static void kvm_setup_secondary_sched_clock(void)
 {
+	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_SMP)))
+		return;
+
 	kvm_register_clock("secondary cpu, sched_clock setup");
 }
-#endif
 
 static void kvm_restore_sched_clock_state(void)
 {
@@ -367,7 +368,8 @@ static void __init kvm_sched_clock_init(bool stable)
 {
 	if (__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
 				       kvm_save_sched_clock_state,
-				       kvm_restore_sched_clock_state))
+				       kvm_restore_sched_clock_state,
+				       kvm_setup_secondary_sched_clock))
 		return;
 
 	kvm_sched_clock_offset = kvm_clock_read();
@@ -452,9 +454,6 @@ void __init kvmclock_init(void)
 
 	x86_platform.get_wallclock = kvm_get_wallclock;
 	x86_platform.set_wallclock = kvm_set_wallclock;
-#ifdef CONFIG_SMP
-	x86_cpuinit.early_percpu_clock_init = kvm_setup_secondary_clock;
-#endif
 	kvm_get_preset_lpj();
 
 	clocksource_register_hz(&kvm_clock, NSEC_PER_SEC);
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index c538c608d9fb..f93278ddb1d2 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -86,8 +86,13 @@ static u64 native_steal_clock(int cpu)
 DEFINE_STATIC_CALL(pv_steal_clock, native_steal_clock);
 DEFINE_STATIC_CALL(pv_sched_clock, native_sched_clock);
 
+#ifdef CONFIG_SMP
+static void (*pv_sched_clock_start_secondary)(void) __ro_after_init;
+#endif
+
 int __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
-				      void (*save)(void), void (*restore)(void))
+				      void (*save)(void), void (*restore)(void),
+				      void (*start_secondary))
 {
 	/*
 	 * Don't replace TSC with a PV clock when running as a CoCo guest and
@@ -104,9 +109,20 @@ int __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
 	static_call_update(pv_sched_clock, func);
 	x86_platform.save_sched_clock_state = save;
 	x86_platform.restore_sched_clock_state = restore;
+#ifdef CONFIG_SMP
+	pv_sched_clock_start_secondary = start_secondary;
+#endif
 	return 0;
 }
 
+#ifdef CONFIG_SMP
+void paravirt_sched_clock_start_secondary(void)
+{
+	if (pv_sched_clock_start_secondary)
+		pv_sched_clock_start_secondary();
+}
+#endif
+
 /* These are in entry.S */
 static struct resource reserve_ioports = {
 	.start = 0,
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index c10850ae6f09..e6fff67dd264 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -278,7 +278,7 @@ static void notrace start_secondary(void *unused)
 	cpu_init();
 	fpu__init_cpu();
 	rcutree_report_cpu_starting(raw_smp_processor_id());
-	x86_cpuinit.early_percpu_clock_init();
+	paravirt_sched_clock_start_secondary();
 
 	ap_starting();
 
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 0a2bbd674a6d..1d4cf071c74b 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -128,7 +128,6 @@ struct x86_init_ops x86_init __initdata = {
 };
 
 struct x86_cpuinit_ops x86_cpuinit = {
-	.early_percpu_clock_init	= x86_init_noop,
 	.setup_percpu_clockev		= setup_secondary_APIC_clock,
 	.parallel_bringup		= true,
 };
-- 
2.48.1.711.g2feabab25a-goog

