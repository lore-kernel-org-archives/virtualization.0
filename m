Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3920658106
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Mar 2024 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173871; cv=none; b=FFceA1nHG/lB0M5upBgT7uUhvwO0/qXrdIh4pBip3ogJP0rDw6GezyRyaxxRmZk07WeqJhcI/oT3ie4DfgD9aHP9gDjbYWcNxB8/X91CYfOMwA7W/XoelmdcqBEqKlwfY9rm5ZwC+tF4NWDj4XbF7jPm4SPCpxbpd3JUtqoI3gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173871; c=relaxed/simple;
	bh=ruyWOEutbzTX21I1GbtMMknQjZcW/AmsekAFWxYC848=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S6KS4tg7UNeJrkxZIwN0dCfc7UZvayYXX1qtOw0TFXaDzlRX1SJfOq9V5RQIaF5Ykayu7PWDfB4lAem88G/sCmbnboSiayDaLL9pYFzhxxNjuwwyRQcW0KaewFwL2x7zQjV76XLFlIakv2f/bt2BirWOdjtj4XvfFgyGipFwSz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyYQo2UM; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyYQo2UM"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C76081E00
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Mar 2024 16:17:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.849
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ebOnLkKcmzAn
	for <virtualization@lists.linux-foundation.org>;
	Mon, 11 Mar 2024 16:17:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com; envelope-from=vsntk18@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C0D2F81DF7
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C0D2F81DF7
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=iyYQo2UM
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C0D2F81DF7
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Mar 2024 16:17:47 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-33e9ba0eadcso628965f8f.2
        for <virtualization@lists.linux-foundation.org>; Mon, 11 Mar 2024 09:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710173866; x=1710778666; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ImRzpHgQ7+uutfuh8SJRk0DTE4K/6LtArW0nv9lfM+k=;
        b=iyYQo2UMYIXC0GQ/QTrYmr/f8bFAQE2vd1HLiKHKMHHSoRTTRfUY42B6chs9bqVevN
         Ym3+g/ig10mfJYKOb6opsRhOTNJHvHDfZ/0wn5rJND5xoQiUfveHPzgY3RRASFm2K07W
         vH6s9hRAIbReh5IUsUzHQT2rTOE+PdpoxvXNXXuLilhdtNG62cP8DoNXidSs0xkoumjL
         ircNDEUX4AfStWUe1YngNN8IYVq/uEmATkJh+wLGCrj45DZxS3/lON3FpxVhLh2NIVnw
         Ofd4euIs4vjdw3HYj/3lzueAFRLwcdyS3LbPifHdZbQr8wK+9AIo+QX31v38TUKXDEMA
         9pVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710173866; x=1710778666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ImRzpHgQ7+uutfuh8SJRk0DTE4K/6LtArW0nv9lfM+k=;
        b=b4GojdT9R2qPYBOt2w8C9WI+pIi1bRUciq+wArn8kllOlnxvvG0OjUBs3mKQj4xSzM
         dkG6TfBBxCsFRqpDNucmKq6NHfxNsvWzckQSgdiHByvFqC7zjvRZTFinBmV3TgsO2HRp
         rMfwVVhk6N3TC37AjH9o8so8pLWMsrW9qyKt/uWTAY6PDy6Yoc6R3clykDzkqMZLYjjt
         IxMizNysvPYT3KVnicf696ZlWBX2mS80ow2G48W2rLZR3xAzpOJQzQA+YEO7bqT8qywT
         HHpsUo+dVDmkPQEZLGNlAPYC49sp2cC8bvtlE4lQTrneQYm4fVKy+7K6p5oeelCAag4s
         e4LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHrmnacslQQThSsh4AFSxr1+9AXsA6jVI1NvRXIr8eFoRo6SEBtL5JmPp9cr7OYRr/SiB9sxiAFmjj9FY7Sr+EIUue6BPapyqVLzdVOJfCVRtqySa7TAlHfg==
X-Gm-Message-State: AOJu0YyApbVS2sbX/DCTuTu+393U5RAIvzbqdLJCHP3YuIyIOey0iNU4
	JB48go3XOrZENRPnKIJrst7tlGwUYLSBRGjU0nhj8AcbqP+cQkkG
X-Google-Smtp-Source: AGHT+IEG0QdNGOuIWSe9NXJvczTc8p7SlmtsuTs9Nh46GFsp/syoRmIiV9TumgTcGzwe4lIUdTQkcw==
X-Received: by 2002:a5d:6611:0:b0:33e:5a33:b169 with SMTP id n17-20020a5d6611000000b0033e5a33b169mr4250288wru.28.1710173865721;
        Mon, 11 Mar 2024 09:17:45 -0700 (PDT)
Received: from vasant-suse.suse.cz ([2001:9e8:ab47:8200:c3b9:43af:f8e1:76f9])
        by smtp.gmail.com with ESMTPSA id ba14-20020a0560001c0e00b0033e96fe9479sm2823815wrb.89.2024.03.11.09.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:17:45 -0700 (PDT)
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
Subject: [PATCH v4 9/9] x86/kexec/64: Support kexec under SEV-ES with AP Jump Table Blob
Date: Mon, 11 Mar 2024 17:17:27 +0100
Message-Id: <20240311161727.14916-10-vsntk18@gmail.com>
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
index 2dbd2238325a..26027083a2a9 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -217,6 +217,7 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 u64 snp_get_unsupported_features(u64 status);
 u64 sev_get_status(void);
 void sev_es_stop_this_cpu(void);
+bool sev_kexec_supported(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -246,6 +247,7 @@ static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
 static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
 static inline u64 sev_get_status(void) { return 0; }
 static inline void sev_es_stop_this_cpu(void) { }
+static inline bool sev_kexec_supported(void) { return true; }
 #endif

 #endif
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 3671ea1a5045..6013ba6fc16e 100644
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
index 73477eeb7de2..66e85b82d170 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1456,6 +1456,21 @@ static void __init sev_es_setup_play_dead(void)
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

