Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04374D106
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Mar 2024 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173863; cv=none; b=TDxX+TSG8AkOHj4nrrErGF0rfFg8XGaq/Uq+IvR3sfOmkWzXuRaBWh2e66xwHNixgVPZZMwipurBf4FwvLTjB7oST3Z0YSWA5g0R26ett6HdK4/U+ZwGOnudx4WLS3y+idibx5A2rVP4ifY4yFp9PAJFKi0RLm+HB4xp2OdKsh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173863; c=relaxed/simple;
	bh=k4KATT8BongMPGyzu+avZmp/iNPi9MTSWDfDzR0R684=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TRF9nlFnLKxTE8BNEZIEnKf3yiTgq1I3YC6YVfjIhbhuyIeV1mTHdZa+jnnUW93VYnEMGjFMKHYOW7yt/u1nzYvIerXeghTcoJAXOWokOshgrgVyqFIeJDmbhCeX3NKFjgANYPIb+TG2vvNoYy4E0DZH9Dx0gkGrc4UcbmtpZIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5vknwFR; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5vknwFR"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B871F60A5A
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Mar 2024 16:17:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.849
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bXfft-5gzC2S
	for <virtualization@lists.linux-foundation.org>;
	Mon, 11 Mar 2024 16:17:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=vsntk18@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 91A1360909
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 91A1360909
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=c5vknwFR
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 91A1360909
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Mar 2024 16:17:37 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4132cc37e21so5166505e9.0
        for <virtualization@lists.linux-foundation.org>; Mon, 11 Mar 2024 09:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710173855; x=1710778655; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Nx+lR8M3d9xAl/7OW4v6MUggA0QirKWOFkex7liC38=;
        b=c5vknwFRMYkWe1LcU4eXqyhc5qj0yJ8U7QIdY6FJmpJluFOE58mNapfVV/k52R1gES
         uktkHM1o29JzCz3i0uLFshDQEQo1Jsu1iqAs+VxDtQ2KXOVtX/jQZBBWElFbS4KsSiuD
         UFXb/KiDdPtOEWb3z4fUajBQ0a/8GxZm+ZvwgWQ596+HfhoqT8WB3+BqniG7UwKgfERG
         MxdXmVrKIma2Y/tyYEL9t/FryxIMl+RkWTKF5OdlQ66StS2SwX30oquq6hY15lyCmJXW
         y30gh91L+i1mNxuiIG4MRAJTdFIrpthUpCquy4zdnfnEQIGSd0Li34eLfH7U2+2Aofas
         g11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710173855; x=1710778655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Nx+lR8M3d9xAl/7OW4v6MUggA0QirKWOFkex7liC38=;
        b=qB2r9O7/vwQm9iwuIpjYkgbb6S6E1tLS8ZB6wt0ADwJ9japo/SDMVoPA6k/L1Bjj5j
         PWi4Ed2WALMSi7TpTNE5kB3qtTEbw4GeN0Cx2JmBlRjP5I5wJ2nRXapysNZqzAWSY1eK
         AL0TsIesLdToLNQeDZdcNTheRiqeh89LJIKs8/RYEj1glx+9ZjV+usOHU0nnQQ/uCppj
         CAwabnqfX++bPLSSklmddz3uQ0dPjSAIQ9/143RVxU0h0GcoD007yZuBrOh+LlVlnYJI
         AXFFbykRetsJybM08ZWp9zMEzI7UJ+UdT+NfrUouOfT/MGTb/XvJqiFU3lG5ExnrypG9
         0Edg==
X-Forwarded-Encrypted: i=1; AJvYcCW5SL06PYz3guBJEIv1EtYaUv9+3ifujj9NQuSeztqHa+bQxF3Mw2R89X57WPKXajCoLi7uAy9yCBhPblkVxHvT+XA6DopAJ5ukzX5m+vzwEj2suiUOf7kpfQ==
X-Gm-Message-State: AOJu0YwUGWdAI3GaBvPDCDNta+bXtpe/j7V+5F22MGK/ykuopg9S3y3r
	MThdhWDgeGql8EWFjGYpTU/yk3KNvJhEFqHwYygdGKqoQp6BGzoP
X-Google-Smtp-Source: AGHT+IGUkQIfxvl6yLuTpdvx8nBMGwNueb7cOPWvFZGWKEwfp7qH2FFkNgyfYv3Q3y0mmeMCQSJfrA==
X-Received: by 2002:a05:600c:458c:b0:413:2c3e:c323 with SMTP id r12-20020a05600c458c00b004132c3ec323mr1492631wmo.38.1710173855159;
        Mon, 11 Mar 2024 09:17:35 -0700 (PDT)
Received: from vasant-suse.suse.cz ([2001:9e8:ab47:8200:c3b9:43af:f8e1:76f9])
        by smtp.gmail.com with ESMTPSA id ba14-20020a0560001c0e00b0033e96fe9479sm2823815wrb.89.2024.03.11.09.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:17:34 -0700 (PDT)
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
Subject: [PATCH v4 2/9] x86/sev: Save and print negotiated GHCB protocol version
Date: Mon, 11 Mar 2024 17:17:20 +0100
Message-Id: <20240311161727.14916-3-vsntk18@gmail.com>
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

Save the results of the GHCB protocol negotiation into a data structure
and print information about versions supported and used to the kernel
log.

This is useful for debugging kexec issues in SEV-ES guests down the
road to quickly spot whether kexec is supported on the given host.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Vasant Karasulli <vkarasulli@suse.de>
---
 arch/x86/kernel/sev-shared.c | 33 +++++++++++++++++++++++++++++++--
 arch/x86/kernel/sev.c        |  8 ++++++++
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 1d24ec679915..c02a087c7945 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -17,6 +17,23 @@
 #define WARN(condition, format...) (!!(condition))
 #endif

+/*
+ * struct ghcb_info - Used to return GHCB protocol
+ *				   negotiation details.
+ *
+ * @hv_proto_min:	Minimum GHCB protocol version supported by Hypervisor
+ * @hv_proto_max:	Maximum GHCB protocol version supported by Hypervisor
+ * @vm_proto:		Protocol version the VM (this kernel) will use
+ */
+struct ghcb_info {
+	unsigned int hv_proto_min;
+	unsigned int hv_proto_max;
+	unsigned int vm_proto;
+};
+
+/* Negotiated GHCB protocol version */
+static struct ghcb_info ghcb_info __ro_after_init;
+
 /* I/O parameters for CPUID-related helpers */
 struct cpuid_leaf {
 	u32 fn;
@@ -152,12 +169,24 @@ static bool sev_es_negotiate_protocol(void)
 	if (GHCB_MSR_INFO(val) != GHCB_MSR_SEV_INFO_RESP)
 		return false;

-	if (GHCB_MSR_PROTO_MAX(val) < GHCB_PROTOCOL_MIN ||
-	    GHCB_MSR_PROTO_MIN(val) > GHCB_PROTOCOL_MAX)
+	/* Sanity check untrusted input */
+	if (GHCB_MSR_PROTO_MIN(val) > GHCB_MSR_PROTO_MAX(val))
 		return false;

+	/* Use maximum supported protocol version */
 	ghcb_version = min_t(size_t, GHCB_MSR_PROTO_MAX(val), GHCB_PROTOCOL_MAX);

+	/*
+	 * Hypervisor does not support any protocol version required for this
+	 * kernel.
+	 */
+	if (ghcb_version < GHCB_MSR_PROTO_MIN(val))
+		return false;
+
+	ghcb_info.hv_proto_min = GHCB_MSR_PROTO_MIN(val);
+	ghcb_info.hv_proto_max = GHCB_MSR_PROTO_MAX(val);
+	ghcb_info.vm_proto     = ghcb_version;
+
 	return true;
 }

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index c67285824e82..179ab6eab0be 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1392,6 +1392,14 @@ void __init sev_es_init_vc_handling(void)

 	/* Secondary CPUs use the runtime #VC handler */
 	initial_vc_handler = (unsigned long)kernel_exc_vmm_communication;
+
+	/*
+	 * Print information about supported and negotiated GHCB protocol
+	 * versions.
+	 */
+	pr_info("Hypervisor GHCB protocol version support: min=%u max=%u\n",
+		ghcb_info.hv_proto_min, ghcb_info.hv_proto_max);
+	pr_info("Using GHCB protocol version %u\n", ghcb_info.vm_proto);
 }

 static void __init vc_early_forward_exception(struct es_em_ctxt *ctxt)
--
2.34.1

