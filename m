Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2136C56B7B
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Mar 2024 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173868; cv=none; b=SPqDV/4lUIpgNxqAIl9Ae6RJLCxzl5VtNM2p1XmXs9VwsyAyqbAhuUh9onQ25NmEr47OctuIuelM6bwJX0mCJN86uoVO3rCSrBjybdE9RlirfTJ+nf5F3WkcKGkisITsGq/g615hH3KnxJZInp/jAi905jtUDVCXE4BWXMEpl3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173868; c=relaxed/simple;
	bh=qyug1TiSxBgmhet3ML7LgG8vHlI4z2vu4W9y71YYu60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NB4nmj+uCLbAAreeQi6hBLzvlUffDWiFTlFWAe5b1xOyI4G35pDqiCZSwQ/JnOpocqy6fbcBUfIrfvVnKMlTq1kgh9BILX7skpDIeyE6SouNX8AH14rDulSawDfquMqkbBRfvkts7auJVr1qTm9gozeRPLzdzG7yPbxU7RFOnAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9xrqmjs; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9xrqmjs"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 742B681DFC
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Mar 2024 16:17:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.849
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XuTaJw9cdDhj
	for <virtualization@lists.linux-foundation.org>;
	Mon, 11 Mar 2024 16:17:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=vsntk18@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6893F81DF7
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6893F81DF7
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=E9xrqmjs
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6893F81DF7
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Mar 2024 16:17:43 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-41329a665a8so6501825e9.3
        for <virtualization@lists.linux-foundation.org>; Mon, 11 Mar 2024 09:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710173861; x=1710778661; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xZKnKV6vagYMs+CUwMzgN6IK8RsSRi3wmiW45NPZ9I=;
        b=E9xrqmjs2EgcYBmTEEvrrXdo7MBK/Svrl7DrDsF+PF+zzz6R/eMt91dF9o690j/1rw
         pFor1UoJBZ3POOSa+NWYTqg0ezP0FbnyW3aX75vnBaWY5nSlDl0k7MqL/Sx4qgU0tXFm
         ZJxqnsMrF8NcrbXXE3CJC5haJgFl0Qjf6gDtznPVR6sWk93E5QJggkGQ5jy9UoK5WdHd
         nEbgfRRJNuFdpGaxxmu6tKh22NYM3wEFKPwKYHXUA+6llpIxEcEP7sz/g7/781Be/sc4
         ypEl3f19GzO3xQSjUzicquNCW+TTmDhlFbKDEAXl/SPCOh1FSkM/VmRIIwZE3on0xR1K
         cgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710173861; x=1710778661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xZKnKV6vagYMs+CUwMzgN6IK8RsSRi3wmiW45NPZ9I=;
        b=WEWJovB9Kq4p7uzjMwBszP9FuaR7KzJMdqKHYCEwnAKnqmG2ttVSKrHQfZuusTEfSn
         uQSoFtdKnceYn9gWKZdcOy7a7h2z16UPcgYuvco8eRYxhInaqRnfZv631rzD7S55x+IG
         hcxuYJTCBcm0JXrwHOwqX437y7Fd8soLfc5RFyA091ytHbZC05SdVURgUxF2kaHE+D1C
         EkSJ0Q92gAX8/k0NyXXlewMaBR9NcF1YUKLfXrfZHEYCF6JiHC7grGutwyuIMTgIiPVM
         m5KMy/HMCHbVHeWF5eD0W0caJFWnuYNYUF+A5f6WDoUw+Mt9wx2bWEpHeJ3YOiuzykVy
         Ru0w==
X-Forwarded-Encrypted: i=1; AJvYcCXPaVU0/udNd+RBGg7EKySpNE6o8LJGEpfwAYJhTunwxYNI4C7CJXg+HPUv7Rj6lk3zMyyDAXiWrmQsQuVn3T8DyT63jkGxp0T6SiD2h4V8LGSrDgMz7v85bA==
X-Gm-Message-State: AOJu0YzVV2V2Fws309rjANZJDEGQtKxjDGTkUZFFUm5UDC+mfy3FT61u
	Hta9uegRLCczHh676LSvz4pxib0u1IPAJGGCZKwauGHlQf4Lv5iS
X-Google-Smtp-Source: AGHT+IHdxdRKuyogtANKix0xsfVIxJjqfkRL3xOpZ/E6JkPe6fFXU/lAH+e1wKvVax66n9KjcPMJqg==
X-Received: by 2002:a05:600c:5026:b0:413:d95:bb2c with SMTP id n38-20020a05600c502600b004130d95bb2cmr705386wmr.33.1710173860999;
        Mon, 11 Mar 2024 09:17:40 -0700 (PDT)
Received: from vasant-suse.suse.cz ([2001:9e8:ab47:8200:c3b9:43af:f8e1:76f9])
        by smtp.gmail.com with ESMTPSA id ba14-20020a0560001c0e00b0033e96fe9479sm2823815wrb.89.2024.03.11.09.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:17:40 -0700 (PDT)
From: Vasant Karasulli <vsntk18@gmail.com>
To: x86@kernel.org
Cc: joro@8bytes.org,
	cfir@google.com,
	dan.j.williams@intel.com,
	dave.hansen@linux.intel.com,
	ebiederm@xmission.com,
	erdemaktas@google.com,
	hpa@zytor.com,
	jgross@suse.com,
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
	Joerg Roedel <jroedel@suse.de>,
	Vasant Karasulli <vkarasulli@suse.de>
Subject: [PATCH v4 6/9] x86/sev: Use AP Jump Table blob to stop CPU
Date: Mon, 11 Mar 2024 17:17:24 +0100
Message-Id: <20240311161727.14916-7-vsntk18@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311161727.14916-1-vsntk18@gmail.com>
References: <20240311161727.14916-1-vsntk18@gmail.com>
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
index c48db0bfb707..2dbd2238325a 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -216,6 +216,7 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct sn
 void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 u64 snp_get_unsupported_features(u64 status);
 u64 sev_get_status(void);
+void sev_es_stop_this_cpu(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -244,6 +245,7 @@ static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *in
 static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
 static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
 static inline u64 sev_get_status(void) { return 0; }
+static inline void sev_es_stop_this_cpu(void) { }
 #endif

 #endif
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index ab49ade31b0d..ddc3fa076f4d 100644
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
index 08bf897361b9..10f4294904b4 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1350,7 +1350,6 @@ void setup_ghcb(void)
 		snp_register_ghcb_early(__pa(&boot_ghcb_page));
 }

-#ifdef CONFIG_HOTPLUG_CPU
 void __noreturn sev_jumptable_ap_park(void)
 {
 	local_irq_disable();
@@ -1383,6 +1382,20 @@ void __noreturn sev_jumptable_ap_park(void)
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

