Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB099381B9
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Apr 2024 07:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562070; cv=none; b=eZr1G0tPLCTD9r5XtHI38WKYp8ncBa+NjihDD8E3eSoSAuXSfzYBb+3JvVnnJ58EBAprlG/eYf/8jIMoaTbOC+rvAtNFlPH2kQJDK8QMLczu54v+jAS+I27AAtzoiJQOLGRBQOVzvWhIGImIpL9LELq+ZQpa0JHbnb3D0eWs064=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562070; c=relaxed/simple;
	bh=U3via5+ZoR4Ic6ASsrA6NJhP2Y5mxiSHxXsiW+DpVzk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cqy1bA9iEHvZZflqh/r3SZODdCCV0FfIEAl7+qdLsbVhEYsakZV5Z0EapDsJaCrbBnWCUXKehw6IFdhFGXwTBZ06g8I7CfayVIUoQ4bbaG4gb0Z7K5YrzZtNnpIrdSLNsBTzCUC2uKJ3glfmch5jdSA/w39yQQdjcm5g0iV5sHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DflcqpNP; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DflcqpNP"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8FA3A4031E
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Apr 2024 07:41:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.849
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zUUbssTBCKIU for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Apr 2024 07:41:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::12f; helo=mail-lf1-x12f.google.com; envelope-from=vsntk18@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 98828400B8
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 98828400B8
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=DflcqpNP
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 98828400B8
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Apr 2024 07:41:07 +0000 (UTC)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-516d3776334so3746162e87.1
        for <virtualization@lists.linux-foundation.org>; Mon, 08 Apr 2024 00:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712562065; x=1713166865; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqnE+JA2AKP6TMVqtzdhtB8i3JdyW6VDhV209Iwbv/8=;
        b=DflcqpNPKu6kO3gYMbLzKi0QGFX04Fe+f2Zu3r6Xil8uNgv9yzreONHwCIqsodUtq3
         9BRT4P0uAGJifl8Y4IA9lHwxDMvDsr68O+46GAtilVHPYwVooJFhqyJbZd/WJXivSTki
         9/mjtjML0k0zjfAIyYF4/WqHNpJR11thvwwXfnnK5zE2rtahqN+DZOvYQkVz0936Gb3K
         tpZevYU6PnlhZkHgYqVVSdi4cbeygF74Jz2V7df10A0Yh39N7xMe9omMZ4RGGB6A7evG
         +FxStI+XbRBQC2QH7H/AYsBLpEca5WnmNj0HzKiC/xkRuUTGxsrWPlvfFeQbGE8ur+Zf
         A9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712562065; x=1713166865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZqnE+JA2AKP6TMVqtzdhtB8i3JdyW6VDhV209Iwbv/8=;
        b=MrYpyl0Bbpa9XH7SZ6hA1NQzyXyRxzuWynwkz0lCSxe8hVq0xrhzVio9ZMEihmtqLt
         bR4mFZUB1yjn2SZ1N8OurDuF+kP/jBqrECnvr5Ubvb1LFwhWjWwwCxtMnVjjlkUOggTN
         XFPU/7ZtDag7duroUEnUxHX1Q5ZjWA8dmXt7IswfQP+3464csilVpNzmMPt3p3UIrg6E
         1yAeL6tUkDO7XuQd7SjFIahzL95A8M9NLWIrxjXa0Ft67L0PvjXnHk37S7PccKpA2wgn
         ko3dTfY7ta6i+vFznlulFUSHGZ0ElfSK9EBiLJ2CujvDxuo/Pg0DBxrFDd4gF1RAXc/f
         u9Eg==
X-Forwarded-Encrypted: i=1; AJvYcCVp3RzN2M2HfreGwM/V8zcNaTlg4QhCjQkFZlNcNXXqKQVEKmqGmnXlZEJ7uNt7idOp7p5rXHaeAXqp4HKQ86e+dDTnm9LqmG0V/a7cjvtSBm3M6ztTKBUaxw==
X-Gm-Message-State: AOJu0YzaXpgYPEvWDOB0FMjUAwKxucoB7VfFT3+srRVBG3zuEqL5uGln
	q5RbwgEjWj4BcOS0tw+5MDdrJMdrokCeLo6BfS4gWtO6Z2X61iqz
X-Google-Smtp-Source: AGHT+IH2pJfyzX54b/TYrms4jG+/yAMqvvcGc6GwZPjgH3mJKkcZm/KCxWXEZlTYThTHzthqKdB71Q==
X-Received: by 2002:ac2:4db2:0:b0:515:d31f:ce2b with SMTP id h18-20020ac24db2000000b00515d31fce2bmr5757819lfe.15.1712562065111;
        Mon, 08 Apr 2024 00:41:05 -0700 (PDT)
Received: from vasant-suse.suse.cz ([2001:9e8:ab70:9c00:7f0b:c18e:56a6:4f2])
        by smtp.gmail.com with ESMTPSA id j3-20020adfff83000000b00341e2146b53sm8271413wrr.106.2024.04.08.00.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 00:41:04 -0700 (PDT)
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
Subject: [PATCH v5 02/10] x86/sev: Save and print negotiated GHCB protocol version
Date: Mon,  8 Apr 2024 09:40:41 +0200
Message-Id: <20240408074049.7049-3-vsntk18@gmail.com>
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
index 8b04958da5e7..ba51005ddde2 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -23,6 +23,23 @@
 #define sev_printk_rtl(fmt, ...)
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
@@ -159,12 +176,24 @@ static bool sev_es_negotiate_protocol(void)
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
index 7e1e63cc48e6..098f590f7bec 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1399,6 +1399,14 @@ void __init sev_es_init_vc_handling(void)
 
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

