Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE66812FB31
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Jun 2024 10:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718014907; cv=none; b=I9gcciToXCw8/ce8rHrtD7kmU1fENjrTxEdvoiZVzuTmFZWzRfDacN74EisR+0V7FYfrGS+kPgua8p2FqG+cAJ66tKYv3dMCMIkKvnPfTYLQPUpwYr4hKrB+Kc4PknbKxsRTZyy7daOB56/YeO0aP+MDDL0xyfjc1EaZQX70k3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718014907; c=relaxed/simple;
	bh=/9mG+Gjg7peWW7HnQepJ7FLCY6yAMicMO5w7jMUE6lc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bkfKhMUP7PjevBmpl6nQU66PUgQI7DYHulSltwwPPVedH74dtbdphIIkC8KhRXcLzyAXukSnGxg9hOodWiVM/dwWXZArOo+UEpWUsawqrBXZ2RAUKqR0jREFJrNKh73C4Iuw3Ds2uPoO/v+koWsoyE7dJ9rx3cudFXV4gqZnQYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZlSMBj3u; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlSMBj3u"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7A00E40635
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Jun 2024 10:21:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.849
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oHFsfaImOATq for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jun 2024 10:21:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com; envelope-from=vsntk18@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 60A78405B8
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 60A78405B8
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ZlSMBj3u
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 60A78405B8
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Jun 2024 10:21:44 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso421089566b.0
        for <virtualization@lists.linux-foundation.org>; Mon, 10 Jun 2024 03:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718014902; x=1718619702; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tjh976F+w5dkctaCwhyVJIF3AZpvtw+7R+eeFp89bGc=;
        b=ZlSMBj3uXHFPQgRSCoeyOfNvIRZT1m0KeeGKDda3IhJIeRD99CHGuHBYnRrYHCF1Zq
         FUVLvKKT6rXinfq4iwamCdmXSLPvOL7hCwdW00g0gB5/fkmfKjewhBgaq2XWsDESwgeP
         KqbbUQi36mBKP6RBxFAYrPHInfESaRqHTbfET2HQQEuxKcHMVUapRfuSYb70eDeJ8i7i
         WZzmQSjwHJffPpnPXC7ylur7VDzyEDb86TD4bybSGyJKUEIdVR+lWzv+PSFY+xn8PVHi
         2h2j0NBlwAqKyr/pgOqygP6a3cHdaYHCNCpCj25SmGWf9OPLqqI73NsE2DXcAmsOECPQ
         bw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718014902; x=1718619702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tjh976F+w5dkctaCwhyVJIF3AZpvtw+7R+eeFp89bGc=;
        b=rVYQf/+9fCApoDrvIiaXyyaaRhlINCyEWo5XKznVcHpaNTyDSCBxg2pb9ElC6uKNPl
         NUJQvULSTYK9sV2w15QqUnnmXM4C5bcpKSJNHTaVR48G1+J//NK41hLimd9ZEnPSLyXl
         VXvXJYC6TAU7QyByRMY6q0l96JgobnOOtx8uxxBVvsxQ2jXUOB43zS8Q7PmX6crvm9cf
         owLmWhoAbynQQ4lGmfmr1TvFtaVRMZnD0jSFH1OmC4dWXDpV56hUAW2hfWRTm0fxjvf9
         SGUULVzDtoZkaPMZpjBDHJYADAMnc3goAsxSU/i6lGiXvfi6/P6mxoOGE64gsNujSORO
         XHRA==
X-Forwarded-Encrypted: i=1; AJvYcCUk7+fEbNH1LcnPIj0eQdBDLszsYT0GjekCwHzprIJzcOwutancS4U+5waesgwo8vUSVfVxi6HBnibK/4JJIqBB+/6erk0i0EaCsZz2wc2x6WQl45Fju6bCEw==
X-Gm-Message-State: AOJu0YyVgsg7jN7Kr5t+ej62rbwRR4BYHDImqYFQi7pDU9VzPJ6nhGAM
	L2Qe8RrF72TkqaUjY2p+lYm9R0KQSvUWDCCunB7ORzIFtJL8Crsz
X-Google-Smtp-Source: AGHT+IEHe6hQkeUB13VRsNS95Hd5J4lzAWr+VF1fStw/ZH7jO5g8M7PodQMj2dQ17+7klWDhdygebg==
X-Received: by 2002:a17:906:6a0a:b0:a6f:1d19:c0b1 with SMTP id a640c23a62f3a-a6f1d19c496mr194718166b.18.1718014902187;
        Mon, 10 Jun 2024 03:21:42 -0700 (PDT)
Received: from vasant-suse.fritz.box ([2001:9e8:ab68:af00:6f43:17ee:43bd:e0a9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f0d7b35d5sm290887766b.192.2024.06.10.03.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 03:21:41 -0700 (PDT)
From: vsntk18@gmail.com
To: vsntk18@gmail.com
Cc: x86@kernel.org,
	Borislav.Petkov@amd.com,
	Dhaval.Giani@amd.com,
	ashish.kalra@amd.com,
	cfir@google.com,
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
	michael.roth@amd.com,
	mstunes@vmware.com,
	nivedita@alum.mit.edu,
	peterz@infradead.org,
	rientjes@google.com,
	seanjc@google.com,
	stable@vger.kernel.org,
	thomas.lendacky@amd.com,
	virtualization@lists.linux-foundation.org,
	vkarasulli@suse.de
Subject: [PATCH v6 09/10] x86/kexec/64: Support kexec under SEV-ES with AP Jump Table Blob
Date: Mon, 10 Jun 2024 12:21:12 +0200
Message-Id: <20240610102113.20969-10-vsntk18@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610102113.20969-1-vsntk18@gmail.com>
References: <20240610102113.20969-1-vsntk18@gmail.com>
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
index 6f681ced6594..e557eadb0ec9 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -233,6 +233,7 @@ u64 snp_get_unsupported_features(u64 status);
 u64 sev_get_status(void);
 void sev_show_status(void);
 void sev_es_stop_this_cpu(void);
+bool sev_kexec_supported(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -263,6 +264,7 @@ static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
 static inline u64 sev_get_status(void) { return 0; }
 static inline void sev_show_status(void) { }
 static inline void sev_es_stop_this_cpu(void) { }
+static inline bool sev_kexec_supported(void) { return true; }
 #endif
 
 #ifdef CONFIG_KVM_AMD_SEV
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 1dfb47df5c01..43f5f7e48cbc 100644
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
index 30ede17b5a04..e64320507da2 100644
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

