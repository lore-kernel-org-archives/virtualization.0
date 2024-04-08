Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDB844373
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Apr 2024 07:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562077; cv=none; b=FxU4dhAPC0uWMcjXLEHHWYV/CvHhyjok1VE/3D8M/k62qepVgrFqOzNaurCne5gv441x8/IjY5xrsz+XTSOpIF2bkOW/STGJ0r0rLnRTmcbxpA1tM0mia2LdRcA2/k8Igcish0QRBY32aPwOsKcwhDEZ/PsndwaVKdnA/XAoe3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562077; c=relaxed/simple;
	bh=iKjQu5I5XlbEyI8tviReJ85sxcTJ+7YPkv/ktuPKMhM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q317zBX86vqePhp0KwSdvGOVZR3s4HbKidH1479krjkY4q7KC+pmdUrjdzWPI0dscWQHDyqAxCZ8NSxHRdCnQfRtuxVgAv/0/q5BtDn8FMPJGuBQ7g7zUXWBPwUs59Me7b3FtwxVn0vEHL555QzA3aHna4pfO5d1QsnWtrDNhj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvIXmQwA; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvIXmQwA"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2BAE14037E
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Apr 2024 07:41:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.849
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n0wEk1b6F8f7 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Apr 2024 07:41:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com; envelope-from=vsntk18@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 34DF740510
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 34DF740510
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=KvIXmQwA
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 34DF740510
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Apr 2024 07:41:15 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-415515178ceso26215015e9.0
        for <virtualization@lists.linux-foundation.org>; Mon, 08 Apr 2024 00:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712562073; x=1713166873; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJpD29/pv52tcSTFE56JNh7gpAMmLYs2U80V4FBahpg=;
        b=KvIXmQwAWMr/G7vw9tUbaodTW6Us9shyTTJyXoCoZ9HRt/hawb8+6o6Big6hDKWMIQ
         Jb4ynrrLyfc5khmikT1syYNo1Wa/thuCFXR4iw1wbYHaG5hZKUr2njNy0gfUBOC/A0Qn
         /mG2RtnSBwYdzBE+6e450cxo23b+uKOeWN1Ttze6wx6PXG/rZQOLlwcnko80u+sK4amJ
         m16+jNVr7a1KtQ+qwFKVVNucyMszoRmj8f1bXndosoY/7CgdT4EdPmeSt4Y/Al2NPXkF
         /vA4lpw/dQLxEraOHylhHGafBttQGadu3DotRXfKa0g32XC5Cgr/chtM0M7Cp+giVceZ
         xqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712562073; x=1713166873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJpD29/pv52tcSTFE56JNh7gpAMmLYs2U80V4FBahpg=;
        b=eqQZEWvJWveasppVV7tFBHmXVyUNxXB4bC2COuRX+Cg0GpOCUXGiu+7OhU3qgq5Ood
         iL/FnnJtulvDkpdq/TCigW3LOWgbQ1StmacFvNvAqApUlMB0yR2oS2Pk8LgzDzXi+GOA
         WKhWEVltWH7W75bIvNE69Sdan5F4v46xXdMP5LrUMRkjrbFXSSIukDuRxzCS4SPYU+AL
         kIgJOywEy5C/DRjujr6SyL2BtV0s/SBqRv4LK4KcwndqfMnVDCTdUv1iaeTUUtnuTnm1
         WceXMqr3xcqViOp6A4E4e3wToMcTED1WGEIvfTusFWyZ2z6//YfEi5lJfOGlFRQQ3ogl
         wQ9w==
X-Forwarded-Encrypted: i=1; AJvYcCWX3MuLeTEl6XddgiwbKYD5VUUyg8r669GjGRR7r7GPuXcZSOFzIdKTDKmXJHqtfQu1HygPYBZ+wFb7uOEerATZIgP6pXs0KB/x8+WeXuyNSdGpmmBjqlxWnQ==
X-Gm-Message-State: AOJu0YwWap4zkBojKf8fbFTS3MILQkf2kWjPUvVahzdJBrAbKcAKJE14
	jIYLj9i0ztAQVuCo/CGeVNXsC6vgnFRPgKEyc6BiMVnjZFfyTQVC
X-Google-Smtp-Source: AGHT+IE8QCaOWgeggvX3bzfdgpzjd9AKZpVWk5t3o1rNmV0yg4I7I6xr4BI4sOPOf3U8/XIcokRopQ==
X-Received: by 2002:a05:600c:350f:b0:416:7071:6eff with SMTP id h15-20020a05600c350f00b0041670716effmr1229085wmq.41.1712562073135;
        Mon, 08 Apr 2024 00:41:13 -0700 (PDT)
Received: from vasant-suse.suse.cz ([2001:9e8:ab70:9c00:7f0b:c18e:56a6:4f2])
        by smtp.gmail.com with ESMTPSA id j3-20020adfff83000000b00341e2146b53sm8271413wrr.106.2024.04.08.00.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 00:41:12 -0700 (PDT)
From: vsntk18@gmail.com
To: x86@kernel.org
Cc: cfir@google.com,
	dan.j.williams@intel.com,
	dave.hansen@linux.intel.com,
	ebiederm@xmission.com,
	erdemaktas@google.com,
	hpa@zytor.com,
	jgross@suse.com,
	jroedel@suse.de,
	jslaby@suse.cz,
	keescook@chromium.org,
	kexec@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	luto@kernel.org,
	martin.b.radev@gmail.com,
	mhiramat@kernel.org,
	mstunes@vmware.com,
	nivedita@alum.mit.edu,
	peterz@infradead.org,
	rientjes@google.com,
	seanjc@google.com,
	stable@vger.kernel.org,
	thomas.lendacky@amd.com,
	virtualization@lists.linux-foundation.org,
	vkarasulli@suse.de,
	ashish.kalra@amd.com,
	michael.roth@amd.com,
	Borislav.Petkov@amd.com,
	Dhaval.Giani@amd.com
Subject: [PATCH v5 06/10] x86/sev: Use AP Jump Table blob to stop CPU
Date: Mon,  8 Apr 2024 09:40:45 +0200
Message-Id: <20240408074049.7049-7-vsntk18@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408074049.7049-1-vsntk18@gmail.com>
References: <20240408074049.7049-1-vsntk18@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joerg Roedel <jroedel@suse.de>

To support kexec under SEV-ES the APs can't be parked with HLT. Upon
wakeup the AP needs to find its way to execute at the reset vector set
by the new kernel and in real-mode.

This is what the AP jump table blob provides, so stop the APs the
SEV-ES way by calling the AP-reset-hold VMGEXIT from the AP jump
table.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Vasant Karasulli <vkarasulli@suse.de>
---
 arch/x86/include/asm/sev.h |  2 ++
 arch/x86/kernel/process.c  |  8 ++++++++
 arch/x86/kernel/sev.c      | 15 ++++++++++++++-
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 829650bdd455..dba6cad1f7d3 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -233,6 +233,7 @@ u64 snp_get_unsupported_features(u64 status);
 u64 sev_get_status(void);
 void kdump_sev_callback(void);
 void sev_show_status(void);
+void sev_es_stop_this_cpu(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -263,6 +264,7 @@ static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
 static inline u64 sev_get_status(void) { return 0; }
 static inline void kdump_sev_callback(void) { }
 static inline void sev_show_status(void) { }
+static inline void sev_es_stop_this_cpu(void) { }
 #endif
 
 #ifdef CONFIG_KVM_AMD_SEV
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index b8441147eb5e..0bc615d69c0e 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -52,6 +52,7 @@
 #include <asm/tdx.h>
 #include <asm/mmu_context.h>
 #include <asm/shstk.h>
+#include <asm/sev.h>
 
 #include "process.h"
 
@@ -836,6 +837,13 @@ void __noreturn stop_this_cpu(void *dummy)
 	cpumask_clear_cpu(cpu, &cpus_stop_mask);
 
 	for (;;) {
+		/*
+		 * SEV-ES guests need a special stop routine to support
+		 * kexec. Try this first, if it fails the function will
+		 * return and native_halt() is used.
+		 */
+		sev_es_stop_this_cpu();
+
 		/*
 		 * Use native_halt() so that memory contents don't change
 		 * (stack usage and variables) after possibly issuing the
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 4c235e310487..17e4263cc7d7 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1357,7 +1357,6 @@ void setup_ghcb(void)
 		snp_register_ghcb_early(__pa(&boot_ghcb_page));
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
 void __noreturn sev_jumptable_ap_park(void)
 {
 	local_irq_disable();
@@ -1390,6 +1389,20 @@ void __noreturn sev_jumptable_ap_park(void)
 }
 STACK_FRAME_NON_STANDARD(sev_jumptable_ap_park);
 
+void sev_es_stop_this_cpu(void)
+{
+	if (!(cc_vendor == CC_VENDOR_AMD) ||
+	    !cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
+		return;
+
+	/* Only park in the AP jump table when the code has been installed */
+	if (!sev_ap_jumptable_blob_installed)
+		return;
+
+	sev_jumptable_ap_park();
+}
+
+#ifdef CONFIG_HOTPLUG_CPU
 static void sev_es_ap_hlt_loop(void)
 {
 	struct ghcb_state state;
-- 
2.34.1

