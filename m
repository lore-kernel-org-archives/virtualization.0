Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B223F1AB0
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 14:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065902; cv=none; b=RyIuWHkloADYcL1g+q85R0Q7qxNMC+0V0Ac0WvHtQoFiHb1x4A2aqKl3IEHJ4IbBETKJb/zvmIweEfFqDAFyzFLxUUI9v157XvgJzxSv2//DwXp5Cs2z3DmsDBJ3CVuGEBSAum/i/lbbuiHP5OVCsHSIo9uioXGkhNkctvrlfFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065902; c=relaxed/simple;
	bh=zdJO+zZEzsLby2yiiaTorWcznz9CLqIQq6bb6Lyhy/s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KWThukpAnQ4kPoWeuWHNSiWq7FrZ6HD5Mt8xhJqk5EHDWEi8oZTRQojMfLC127EFGnajfeWE0DFzR6m8LoGOVsRfZDx3Q65E4zroeBWL8KwXKiY3E4w3n7N25OEGsnUAfekbvrXT2p+b36fj6XJk+YS5EfE7KGeppTao+1UQR+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RFe3ZTKV; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RFe3ZTKV"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b4530a90fdso104583265ad.1
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 07:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780065899; x=1780670699; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=fwFQzI2jeVi8q9emUB9u5qsW4Gj215t9UPhq3t/oEkw=;
        b=RFe3ZTKVg058O8qRaMIz4EMXcNX+xqTNpZ+gsi43cYxa3laMp89Bq0fpppW4VMOmlY
         vVRj3LLuP9wch4HjhAHBI0YMBN4AvnopFO2sJnr0dJFAqQnNLuJs6wkx33SjuXsp3wpN
         i/biUaq2K9TtA11liJ7Z/lqOgGg0fkbe9dHU8ijhfluPKyPHlWiNw7JT59VAMYN7GTR6
         t8en2/IZru/mumJA43lTVSE5GjUow9VPq/dXH9XrOpecpjCcHYeIEbqXFCj45sQY57A9
         xuDxQIR+FpUm7/+LzE+8fUiKKILaUhnqDLBtUbDAi1NQrulmdml0j6ee9U1gB7x5RBh7
         2Seg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065899; x=1780670699;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fwFQzI2jeVi8q9emUB9u5qsW4Gj215t9UPhq3t/oEkw=;
        b=rDcCXbpjX/AxyxkBdf4dxEI5zMv5vZelCLAZwrUBam97aHDPO6t6YpPGJhsPvVVAOF
         SdKPawu70Kt7KIlOasngNDgU4kJ8qGuBKHFYWMzhwn1dYz5YihHUVnthrWFQkNWfeDtO
         B6VUdK+DgH/8oRuFmSppiabH4JA1N9NPWnnn6k46xmcMB0Ryae1j9pMjL1HlnTasS+Ku
         fK/5+JOENGw1n4w1aaIJhuvdRKxiBX/2ZgbcCoXoXD6NeRcR89PcY+k8NRoGM2j8ASLb
         9Yx9P9Xw3KVccyJ0T3grfow2HxSYBrueQDXrGC2hZ1h5ENDBKnxV3LLyyiOG6dt7DPlv
         79KA==
X-Forwarded-Encrypted: i=1; AFNElJ+AmtIgfXk7uPkqzMNhIkjZrAENIshKTxhezXBadHtc4Ovswt56MQchF6mlMWnAxguBWqM0RZcUZ2zeyTyEnw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyIXDLZWs0KRUn/ZRYZL7NZI96PoY0B1lgwLDZnMkp4TpxUd8kY
	yksrhDbnSiCJAqiflflCd8JqDGJ8oXO2EyjU6HStYMvnpyvdJxOk2LTpjLMRVA6lgvNdUrJxiCM
	aPPtcEw==
X-Received: from plble15.prod.google.com ([2002:a17:902:fb0f:b0:2bf:aa7:47b9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c94c:b0:2b0:bebb:1081
 with SMTP id d9443c01a7336-2bf368698abmr864185ad.28.1780065898563; Fri, 29
 May 2026 07:44:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 07:43:53 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529144435.704127-7-seanjc@google.com>
Subject: [PATCH v4 06/47] x86/sev: Shove SNP's secure/trusted TSC frequency
 directly into "calibration"
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
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

As a first step towards dropping .calibrate_{cpu,tsc}() and explicitly
defining precedence/priority for "calibration" routines, pass the secure
TSC frequency obtained from SNP firmware directly to
determine_cpu_tsc_frequencies() instead of overriding the .calibrate_tsc()
hook.

Unlike the native calibration routines, all of the paravirtual overrides,
including SNP and TDX, are constant in the sense that the frequency
provided by the hypervisor or trusted firmware is fixed, known, and always
available during early boot.  More importantly, for CoCo (SNP and TDX) VMs,
it's imperative that the kernel uses the frequency provided by the trusted
firmware, not by the untrusted hypervisor.  Enforcing the priority between
sources by carefully ordering seemingly unrelated init calls, so that the
trusted override "wins", is brittle and all but impossible to follow.

While it's rather weird, deliberately prioritize tsc_early_khz over all
else to maintain existing behavior.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/coco/sev/core.c   | 14 ++++----------
 arch/x86/include/asm/sev.h |  4 ++--
 arch/x86/kernel/tsc.c      | 19 ++++++++++++-------
 3 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 403dcea86452..bc5ae9ef74da 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -99,7 +99,6 @@ static const char * const sev_status_feat_names[] = {
  */
 static u64 snp_tsc_scale __ro_after_init;
 static u64 snp_tsc_offset __ro_after_init;
-static unsigned long snp_tsc_freq_khz __ro_after_init;
 
 DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
 DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
@@ -2014,15 +2013,10 @@ void __init snp_secure_tsc_prepare(void)
 	pr_debug("SecureTSC enabled");
 }
 
-static unsigned long securetsc_get_tsc_khz(void)
-{
-	return snp_tsc_freq_khz;
-}
-
-void __init snp_secure_tsc_init(void)
+unsigned int __init snp_secure_tsc_init(void)
 {
+	unsigned long snp_tsc_freq_khz, tsc_freq_mhz;
 	struct snp_secrets_page *secrets;
-	unsigned long tsc_freq_mhz;
 	void *mem;
 
 	mem = early_memremap_encrypted(sev_secrets_pa, PAGE_SIZE);
@@ -2043,7 +2037,7 @@ void __init snp_secure_tsc_init(void)
 
 	snp_tsc_freq_khz = SNP_SCALE_TSC_FREQ(tsc_freq_mhz * 1000, secrets->tsc_factor);
 
-	x86_platform.calibrate_tsc = securetsc_get_tsc_khz;
-
 	early_memunmap(mem, PAGE_SIZE);
+
+	return snp_tsc_freq_khz;
 }
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 594cfa19cbd4..05ebf0b73ef4 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -530,7 +530,7 @@ int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req
 int snp_svsm_vtpm_send_command(u8 *buffer);
 
 void __init snp_secure_tsc_prepare(void);
-void __init snp_secure_tsc_init(void);
+unsigned int snp_secure_tsc_init(void);
 enum es_result savic_register_gpa(u64 gpa);
 enum es_result savic_unregister_gpa(u64 *gpa);
 u64 savic_ghcb_msr_read(u32 reg);
@@ -637,7 +637,7 @@ static inline int snp_send_guest_request(struct snp_msg_desc *mdesc,
 					 struct snp_guest_req *req) { return -ENODEV; }
 static inline int snp_svsm_vtpm_send_command(u8 *buffer) { return -ENODEV; }
 static inline void __init snp_secure_tsc_prepare(void) { }
-static inline void __init snp_secure_tsc_init(void) { }
+static inline unsigned int __init snp_secure_tsc_init(void) { return 0; }
 static inline void sev_evict_cache(void *va, int npages) {}
 static inline enum es_result savic_register_gpa(u64 gpa) { return ES_UNSUPPORTED; }
 static inline enum es_result savic_unregister_gpa(u64 *gpa) { return ES_UNSUPPORTED; }
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 833eed5c048a..2b8f94c3fcc7 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1474,15 +1474,16 @@ static int __init init_tsc_clocksource(void)
  */
 device_initcall(init_tsc_clocksource);
 
-static bool __init determine_cpu_tsc_frequencies(bool early)
+static bool __init determine_cpu_tsc_frequencies(bool early,
+						 unsigned int known_tsc_khz)
 {
 	/* Make sure that cpu and tsc are not already calibrated */
 	WARN_ON(cpu_khz || tsc_khz);
 
 	if (early) {
 		cpu_khz = x86_platform.calibrate_cpu();
-		if (tsc_early_khz)
-			tsc_khz = tsc_early_khz;
+		if (known_tsc_khz)
+			tsc_khz = known_tsc_khz;
 		else
 			tsc_khz = x86_platform.calibrate_tsc();
 	} else {
@@ -1537,16 +1538,20 @@ static void __init tsc_enable_sched_clock(void)
 
 void __init tsc_early_init(void)
 {
+	unsigned int known_tsc_khz = 0;
+
 	if (!boot_cpu_has(X86_FEATURE_TSC))
 		return;
 	/* Don't change UV TSC multi-chassis synchronization */
 	if (is_early_uv_system())
 		return;
 
-	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
-		snp_secure_tsc_init();
+	if (tsc_early_khz)
+		known_tsc_khz = tsc_early_khz;
+	else if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
+		known_tsc_khz = snp_secure_tsc_init();
 
-	if (!determine_cpu_tsc_frequencies(true))
+	if (!determine_cpu_tsc_frequencies(true, known_tsc_khz))
 		return;
 	tsc_enable_sched_clock();
 }
@@ -1567,7 +1572,7 @@ void __init tsc_init(void)
 
 	if (!tsc_khz) {
 		/* We failed to determine frequencies earlier, try again */
-		if (!determine_cpu_tsc_frequencies(false)) {
+		if (!determine_cpu_tsc_frequencies(false, 0)) {
 			mark_tsc_unstable("could not calculate TSC khz");
 			setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
 			return;
-- 
2.54.0.823.g6e5bcc1fc9-goog

