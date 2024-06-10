Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D957F48C
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Jun 2024 10:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718014892; cv=none; b=LVCUtQJtrlxWQZJk3GrzRgsr2h8P263Jk9KwJPyC9cUwdDI4DiLiWHL7z1xyR6z9iMSplz7Pttj6YLxjOWgU6+sXhUNGfc6eXQRkT7vg8WHjqtwyUNx8CkHAA8FXflntynEpIJBWZQdalwe+ymAIZjz52ChEfNcmX4KH54Dl9C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718014892; c=relaxed/simple;
	bh=sEdqF1TavEfxZMRrq6GYTKhkej+k4AMnxHaUkC+Lmk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mES8qlc0kQUQRyBMhiiOr9styKGq8FFg/R7pU8wWYZdNwVnMoR3EkutwEfAaEaSsGc30HEA7lPoX3KQwOa+ZmIrhI9qfSJaCexPhMIO1BDJGshCVAR29ZIkeclaQ5jJLLtQhMQxf4XSbM7i1OVnQXVqEJt9xoJPwXjXkjOp1u2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYwdSMD0; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYwdSMD0"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 099AC40289
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Jun 2024 10:21:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.849
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xrH69v32I-w4 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jun 2024 10:21:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com; envelope-from=vsntk18@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org ACE1F4022A
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ACE1F4022A
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ZYwdSMD0
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by smtp2.osuosl.org (Postfix) with ESMTPS id ACE1F4022A
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Jun 2024 10:21:29 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a6f0e153eddso176135566b.0
        for <virtualization@lists.linux-foundation.org>; Mon, 10 Jun 2024 03:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718014887; x=1718619687; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCL4Vo5CEvbB78AJfWlszJwJfM4IkhVBnCtECteN90M=;
        b=ZYwdSMD0bHZpuF3mT0jQCq6967dMigmqhvf2pPfeC5iwD7LhM351PGkfQG22iaI8n6
         +49D9Nt7FLCmzu5ZujNqyiWDJrFpOryifB8ZnUTpcVSWYtw8Voik0ZMBsU+69NRY2Ch5
         3ONsAt7fOhbbMtcA2QA7p0yYalbIgqd5uhVHnvgYriXPBOcCnwPDAAvPfHFA+jehXbyv
         GUPicFXES2SlJaN9KzeQidAnT41A3peGh8hiqUQUUrm8g9DfrZxr2Lh+f6Ww2AlFI1a5
         diGaG6CCgrb0PYrQbVw8ZEyFOjH9TEcTG9A0k8NoAon7S8KUZPfKaTH/1I0vsPorfOKk
         FzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718014887; x=1718619687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCL4Vo5CEvbB78AJfWlszJwJfM4IkhVBnCtECteN90M=;
        b=jOX4dCfrnRQUkUZktXdQEdG+y2rV8NzyIrBmA5nzFNTP99cC3tqHXQpkigwRvN5eIK
         R7daxMGaR/w5vDhPTPY9sH4Q2aQOJxbZ1yL6VFUVwFlCkxHimFuMzdfqVNiLyfR6Of8g
         vfSXm6odSQX3vVrFy4dr+l8rFsjSeREBTXOwFACTLni9H2UwHQh+8u7QTk+r0Vyk0huP
         14x+lGXy4Jj/Enoit6j5FJbGwdaLUqiOzV2IqkQoy781pM81CI1DUEYimIRBu59o8e9U
         wsFfrb8VhVPjKEkYUQRExviPC7Butdpmn0v+0d8gzWOCRKh3+RfegLytTm68aPm3LwgE
         7FBA==
X-Forwarded-Encrypted: i=1; AJvYcCUnvE5uOiidC7LNMCOKQH84d5DaDfahMGT0rUwTqQML+vixOWxigPTTmrNqmGAhFkUM/FdWlOh5/vH31nKafxjmbjhf5ZLFeupctTOI7VmOEej5ZeanwLc40w==
X-Gm-Message-State: AOJu0YwTjbYLmBRIphNiKMwBJEmdibJlPyXRS0y8uMoj7cQnVd0qFwyp
	HJXdtyLKpfHPQjlR07VU4vSDd3MfZOfxZEQ991AqdoR0fHn+njqs
X-Google-Smtp-Source: AGHT+IEU4Gid3qf0r8Bb4VtO+jH0s35ne9U0e+dRyHVRPwaSrjMvMMb+EUFXtRe7Fz4xmoBBOgq/kQ==
X-Received: by 2002:a17:906:150c:b0:a6f:eb8:801a with SMTP id a640c23a62f3a-a6f0eb884afmr308071366b.56.1718014887288;
        Mon, 10 Jun 2024 03:21:27 -0700 (PDT)
Received: from vasant-suse.fritz.box ([2001:9e8:ab68:af00:6f43:17ee:43bd:e0a9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f0d7b35d5sm290887766b.192.2024.06.10.03.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 03:21:26 -0700 (PDT)
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
Subject: [PATCH v6 02/10] x86/sev: Save and print negotiated GHCB protocol version
Date: Mon, 10 Jun 2024 12:21:05 +0200
Message-Id: <20240610102113.20969-3-vsntk18@gmail.com>
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
index b4f8fa0f722c..f5717eddf75b 100644
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
index 3342ed58e168..f0d87549b1e1 100644
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

