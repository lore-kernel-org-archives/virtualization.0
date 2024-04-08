Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A82B4D9E2
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Apr 2024 07:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562085; cv=none; b=IxspWtVIr63MtM2x0+MfRkPvFscCXwaAevC0oumQuMRj3vLUjFvETcvSO3x0f4Nv42YwQCz3K67I7wkhPQBJgYvu6kTavTxl7o0E7TNgdpEjWv/0Xpr2orfwl88B9iqKTA8xMlNB7Nz/t9hKvkyOSCEMdVBmj1EDNQi69jzC1Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562085; c=relaxed/simple;
	bh=zYcb4/9WEShY0XRHnrQbKJ01pXJ2G8yIwcM+DsGPPXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iF282hmdn7hd8f0Ok4RLpC2s5fDayVzH6/f+0kV84s0+xAOAvMQwxUiAPbSxWhdf8emrotDoyQiClFpFD7U1DdZd46UaiQKEKQB+dDXOMigMbpyOpXiorlP84SFZEW3HOgzmvlFrRi8sbYqRmv8sJjs6nlsl9gR4zZARlNS3waU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YoByQz21; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YoByQz21"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B8CA860A93
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Apr 2024 07:41:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.849
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KhW4VYvu5kXk for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Apr 2024 07:41:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com; envelope-from=vsntk18@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org BCA5960A53
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BCA5960A53
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=YoByQz21
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BCA5960A53
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Apr 2024 07:41:21 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-343e7c20686so2158062f8f.1
        for <virtualization@lists.linux-foundation.org>; Mon, 08 Apr 2024 00:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712562079; x=1713166879; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PtkyqKxJvkp9IMsnHYE4l6zbbRyMrAgNbiaeWO9SXiI=;
        b=YoByQz21aOQHQOVv5gN50BDfDkXa4E8+VAVBefbWP1V3sawk2Eg2et7n9HGwDudJhL
         VSdx1pfZ983gYDgww+VuLN3yxKbfRJKN55QO00weizJeeTT6EyM1g1hJY9gt92N6C2q4
         W4eO20NS8h01O9/oG6dck/aSqrN6QuxEz/YgS5xiAmSMqsuYIFdjaWwlodclWoNohaVx
         gmEBxRUeKt6jgSP361dKp8WoKM55euPBTGcdMZ8BVOrcL9KZ2nVTop/o15VZbhVK3MOK
         tLnfVmF8XblyAz3bWizTAwEuqZ716Pu+MgYsDwG8ci02ongVnA8ZMr6T3HRflv7NbQQy
         s9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712562079; x=1713166879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PtkyqKxJvkp9IMsnHYE4l6zbbRyMrAgNbiaeWO9SXiI=;
        b=f6ATQt2m35aWek+gR9c6sVFNzSCYNYeggj9RqhJP44aW2wSuhyPct/t1zJJX6gnRdE
         zr16yVLijO5RTwSgnX4QJ/s6pIAboAI7BP8pE1aOnnXxOVb0aYdohfBKhlMoG31NmNb3
         ySNw1wmg7kg4VMFrDWZSTouNclj06J+W73AUGcF1U6ytrH7Jf6ERHX9OJuobukTNM3iJ
         7QiQKsEcbFRU0BYzC3wjX69JhCMD7bX3tV6w5FufA7iv0liQJVXhYve/19rjB17tm2zt
         Wl60HzyzUEVDvT9eOWMzyWtSeaY+o01wGHg47dMGiMaIXWYlu8+Zh+mEuEpoQXnNKdSN
         nR9A==
X-Forwarded-Encrypted: i=1; AJvYcCXb9Ti/ERZkJUeHelwiKBTKnlRC6e3Y5QRv0RP99RQ6LOXw/wICJeMB05EQW5awgGEbBwLDe2vUmqv9UptriF6BddmzpMiMojaRVrb8aYkeIfo/EPZ06HlJVA==
X-Gm-Message-State: AOJu0YyupvMyLV/rePfwkByshss/8EKwL3JBY04wf5zHW7OWwdAQH+g0
	jynqRD4JfAps8S/DqK4fdLzWtUzF+UHf5wJ4hc+I1IOT2cjZyFJ0
X-Google-Smtp-Source: AGHT+IHCtTgtguJAV1/c4MkfZce3ouAm8nkkV1k3lPxle87h5W00nuVVJEZORfw/dl/4V3xbzdiheA==
X-Received: by 2002:a5d:5f46:0:b0:345:bcd4:bc99 with SMTP id cm6-20020a5d5f46000000b00345bcd4bc99mr1264651wrb.11.1712562079618;
        Mon, 08 Apr 2024 00:41:19 -0700 (PDT)
Received: from vasant-suse.suse.cz ([2001:9e8:ab70:9c00:7f0b:c18e:56a6:4f2])
        by smtp.gmail.com with ESMTPSA id j3-20020adfff83000000b00341e2146b53sm8271413wrr.106.2024.04.08.00.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 00:41:19 -0700 (PDT)
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
Subject: [PATCH v5 09/10] x86/kexec/64: Support kexec under SEV-ES with AP Jump Table Blob
Date: Mon,  8 Apr 2024 09:40:48 +0200
Message-Id: <20240408074049.7049-10-vsntk18@gmail.com>
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

When the AP jump table blob is installed the kernel can hand over the
APs from the old to the new kernel. Enable kexec when the AP jump
table blob has been installed.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Vasant Karasulli <vkarasulli@suse.de>
---
 arch/x86/include/asm/sev.h         |  2 ++
 arch/x86/kernel/machine_kexec_64.c |  3 ++-
 arch/x86/kernel/sev.c              | 15 +++++++++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index dba6cad1f7d3..9c773c272986 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -234,6 +234,7 @@ u64 sev_get_status(void);
 void kdump_sev_callback(void);
 void sev_show_status(void);
 void sev_es_stop_this_cpu(void);
+bool sev_kexec_supported(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -265,6 +266,7 @@ static inline u64 sev_get_status(void) { return 0; }
 static inline void kdump_sev_callback(void) { }
 static inline void sev_show_status(void) { }
 static inline void sev_es_stop_this_cpu(void) { }
+static inline bool sev_kexec_supported(void) { return true; }
 #endif
 
 #ifdef CONFIG_KVM_AMD_SEV
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 4696e149d70d..558266d9bf1d 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -28,6 +28,7 @@
 #include <asm/setup.h>
 #include <asm/set_memory.h>
 #include <asm/cpu.h>
+#include <asm/sev.h>
 
 #ifdef CONFIG_ACPI
 /*
@@ -269,7 +270,7 @@ static void load_segments(void)
 
 static bool machine_kexec_supported(void)
 {
-	if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
+	if (!sev_kexec_supported())
 		return false;
 
 	return true;
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 36181bb26e25..aa53e8eb4cd5 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1463,6 +1463,21 @@ static void __init sev_es_setup_play_dead(void)
 static inline void sev_es_setup_play_dead(void) { }
 #endif
 
+bool sev_kexec_supported(void)
+{
+	if (!cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
+		return true;
+
+	/*
+	 * KEXEC with SEV-ES and more than one CPU is only supported
+	 * when the AP jump table is installed.
+	 */
+	if (num_possible_cpus() > 1)
+		return sev_ap_jumptable_blob_installed;
+	else
+		return true;
+}
+
 static void __init alloc_runtime_data(int cpu)
 {
 	struct sev_es_runtime_data *data;
-- 
2.34.1

