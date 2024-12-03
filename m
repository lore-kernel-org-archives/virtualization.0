Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5CF126BEE
	for <virtualization@lists.linux.dev>; Tue,  3 Dec 2024 01:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733187637; cv=none; b=uWcSdfhQUxhJH/ck4NMatKW4vDabUHm+fKailxdnz0kYj0fyVCJjR2JE7lqFLI8csi21cLDLjDD+HnEnmtpb3vOezRb1FBcx7U0agaPvHr36v1tH7eMIuWOURqhyIll1kifULsKrxk1GMsMFWnZvzSPUrNeJpmAL3radN26drYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733187637; c=relaxed/simple;
	bh=ST360jAFSalxvsspokUYZryLYZwouzKdgllkKmYC1PE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RQoxJnt8a7JnAfopBdveKQdQrW4DU2AfxpZ8v4xKFjSspQ/kZHfjwRdzPRjcytGW6Aa7NMvSrJtRCtu0i9rsbwCvH8un4TECHLI5ppgCdL08zyp8g21FD+lkOL+p9BX7TZi/J4TsNgp36CIZrMuriL82lINgfO977oJW4iDmHJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4Bha/Fjb; arc=none smtp.client-ip=209.85.161.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4Bha/Fjb"
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-5f21cb68157so2857488eaf.3
        for <virtualization@lists.linux.dev>; Mon, 02 Dec 2024 17:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733187635; x=1733792435; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d+a3eBnHKvD8AQod1gMB/LKTW1oN3to08D39Docv/eQ=;
        b=4Bha/FjbC86yhMWgWL2IewBVmQdJzbDE+vaF3r6xZ6c1hfoQMBipRxCPbNWtttfQz/
         eRy2homchXKCdI9bOuxx/ZlCu9eZNBQnKiYFAHz+yPWJwLR1PZbIdc+gTmJb/PAbt9Iw
         vRNxipQ/LtR7i8w2NjVsFdRgTVhdDQ+CXgSiOcmCPDXuvOjCqc1QzeIgy3WiSH9tMQlq
         3TjWf78HZ+FC9cJmQSYQY6LX++z2ZLoryLJcdwNrTnWLMpMB4SQFYK+iHYOFF/tZkPf0
         qRuecFWWO0BfMcLt/nSjvnr9w+OPEU1xRTL2iUj4ysew4lwE0cJbIpebO6FryLoEaiWE
         waFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733187635; x=1733792435;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d+a3eBnHKvD8AQod1gMB/LKTW1oN3to08D39Docv/eQ=;
        b=JtGQN7b+UYUPK0en6EFgYN1CHkE3l5ax3aMpb7YUpzrVyPcWyeBEnDf2TKYCMjSRwh
         Edskx3Gjb01e0sQgWrprrnAP0EVjQvVX4jwPUrGTHDwzh5plnnXEN49nVAoimR+1umC+
         zBERP1vO1wSphO+J7ppYQpQ5TbY9cy8t0mfJ18jAZXcuizr5Mvz3txqUO0AzgHLMF/Xm
         IE3FK7JOCkQ3q96SkziHahES0Bfi+7o/SN7HrG2PAA5sTNwOb8IT5EdhXyx81AlaA1Gz
         XtQWwzTpxfW0jmDKsaBc+MuNi8Rd3Irvnb3R8R3ZTB3C2zBkZx2Dkaz3bzwcKiGZyeic
         XZuw==
X-Forwarded-Encrypted: i=1; AJvYcCV8pVnJl0Ji2ZRcj4uzxDKXvaiAIkSqWzhwiUlfIiXllpB4z+c85NqtiwTtS+QkUwAVM0jrpLYWm3EwiVce0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxcBW65BCndB152wPtCym0YCGS0dZTS6tGd76lT40B1Klx9D3hq
	gQc+lMnihNT3VgEorXJtA2M7w6XdHXpyRGAE8B+LohaQXbW6LMuys/+Sw/PpGhUcVSZwNz+mcCM
	YySp9yMZTFxRK9GNe1kF9pi9kOKf96g==
X-Google-Smtp-Source: AGHT+IHlAWUl/6xhfzZLqge5+mtkzOWOXTSZQKntjfye63eE/1sMNIDsJdEGUh7DCOLnVMK90ja1kBMWTjMKXb6+Bxua
X-Received: from ioay19.prod.google.com ([2002:a6b:c413:0:b0:841:802b:8e24])
 (user=kevinloughlin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6602:2b85:b0:83a:872f:4b98 with SMTP id ca18e2360f4ac-8445b53e7d6mr104251439f.2.1733187625111;
 Mon, 02 Dec 2024 17:00:25 -0800 (PST)
Date: Tue,  3 Dec 2024 00:59:20 +0000
In-Reply-To: <20241203005921.1119116-1-kevinloughlin@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20241203005921.1119116-1-kevinloughlin@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241203005921.1119116-2-kevinloughlin@google.com>
Subject: [RFC PATCH 1/2] x86, lib, xenpv: Add WBNOINVD helper functions
From: Kevin Loughlin <kevinloughlin@google.com>
To: linux-kernel@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, kvm@vger.kernel.org, thomas.lendacky@amd.com, 
	pgonda@google.com, sidtelang@google.com, mizhang@google.com, 
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org, 
	bcm-kernel-feedback-list@broadcom.com, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

In line with WBINVD usage, add WBONINVD helper functions, accounting
for kernels built with and without CONFIG_PARAVIRT_XXL.

Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
---
 arch/x86/include/asm/paravirt.h       |  7 +++++++
 arch/x86/include/asm/paravirt_types.h |  1 +
 arch/x86/include/asm/smp.h            |  7 +++++++
 arch/x86/include/asm/special_insns.h  | 12 +++++++++++-
 arch/x86/kernel/paravirt.c            |  6 ++++++
 arch/x86/lib/cache-smp.c              | 12 ++++++++++++
 arch/x86/xen/enlighten_pv.c           |  1 +
 7 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index d4eb9e1d61b8..c040af2d8eff 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -187,6 +187,13 @@ static __always_inline void wbinvd(void)
 	PVOP_ALT_VCALL0(cpu.wbinvd, "wbinvd", ALT_NOT_XEN);
 }
 
+extern noinstr void pv_native_wbnoinvd(void);
+
+static __always_inline void wbnoinvd(void)
+{
+	PVOP_ALT_VCALL0(cpu.wbnoinvd, "wbnoinvd", ALT_NOT_XEN);
+}
+
 static inline u64 paravirt_read_msr(unsigned msr)
 {
 	return PVOP_CALL1(u64, cpu.read_msr, msr);
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 8d4fbe1be489..9a3f38ad1958 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -87,6 +87,7 @@ struct pv_cpu_ops {
 #endif
 
 	void (*wbinvd)(void);
+	void (*wbnoinvd)(void);
 
 	/* cpuid emulation, mostly so that caps bits can be disabled */
 	void (*cpuid)(unsigned int *eax, unsigned int *ebx,
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index ca073f40698f..ecf93a243b83 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -112,6 +112,7 @@ void native_play_dead(void);
 void play_dead_common(void);
 void wbinvd_on_cpu(int cpu);
 int wbinvd_on_all_cpus(void);
+int wbnoinvd_on_all_cpus(void);
 
 void smp_kick_mwait_play_dead(void);
 
@@ -160,6 +161,12 @@ static inline int wbinvd_on_all_cpus(void)
 	return 0;
 }
 
+static inline int wbnoinvd_on_all_cpus(void)
+{
+	wbnoinvd();
+	return 0;
+}
+
 static inline struct cpumask *cpu_llc_shared_mask(int cpu)
 {
 	return (struct cpumask *)cpumask_of(0);
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index aec6e2d3aa1d..c2d16ddcd79b 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -117,7 +117,12 @@ static inline void wrpkru(u32 pkru)
 
 static __always_inline void native_wbinvd(void)
 {
-	asm volatile("wbinvd": : :"memory");
+	asm volatile("wbinvd" : : : "memory");
+}
+
+static __always_inline void native_wbnoinvd(void)
+{
+	asm volatile("wbnoinvd" : : : "memory");
 }
 
 static inline unsigned long __read_cr4(void)
@@ -173,6 +178,11 @@ static __always_inline void wbinvd(void)
 	native_wbinvd();
 }
 
+static __always_inline void wbnoinvd(void)
+{
+	native_wbnoinvd();
+}
+
 #endif /* CONFIG_PARAVIRT_XXL */
 
 static __always_inline void clflush(volatile void *__p)
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index fec381533555..a66b708d8a1e 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -121,6 +121,11 @@ noinstr void pv_native_wbinvd(void)
 	native_wbinvd();
 }
 
+noinstr void pv_native_wbnoinvd(void)
+{
+	native_wbnoinvd();
+}
+
 static noinstr void pv_native_safe_halt(void)
 {
 	native_safe_halt();
@@ -149,6 +154,7 @@ struct paravirt_patch_template pv_ops = {
 	.cpu.write_cr0		= native_write_cr0,
 	.cpu.write_cr4		= native_write_cr4,
 	.cpu.wbinvd		= pv_native_wbinvd,
+	.cpu.wbnoinvd		= pv_native_wbnoinvd,
 	.cpu.read_msr		= native_read_msr,
 	.cpu.write_msr		= native_write_msr,
 	.cpu.read_msr_safe	= native_read_msr_safe,
diff --git a/arch/x86/lib/cache-smp.c b/arch/x86/lib/cache-smp.c
index 7af743bd3b13..7ac5cca53031 100644
--- a/arch/x86/lib/cache-smp.c
+++ b/arch/x86/lib/cache-smp.c
@@ -20,3 +20,15 @@ int wbinvd_on_all_cpus(void)
 	return 0;
 }
 EXPORT_SYMBOL(wbinvd_on_all_cpus);
+
+static void __wbnoinvd(void *dummy)
+{
+	wbnoinvd();
+}
+
+int wbnoinvd_on_all_cpus(void)
+{
+	on_each_cpu(__wbnoinvd, NULL, 1);
+	return 0;
+}
+EXPORT_SYMBOL(wbnoinvd_on_all_cpus);
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index d6818c6cafda..a5c76a6f8976 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1162,6 +1162,7 @@ static const typeof(pv_ops) xen_cpu_ops __initconst = {
 		.write_cr4 = xen_write_cr4,
 
 		.wbinvd = pv_native_wbinvd,
+		.wbnoinvd = pv_native_wbnoinvd,
 
 		.read_msr = xen_read_msr,
 		.write_msr = xen_write_msr,
-- 
2.47.0.338.g60cca15819-goog

