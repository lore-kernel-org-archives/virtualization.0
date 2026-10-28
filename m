Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180552;
	b=WO+c9Uu7bWHcFg4fZ2GQCoh8Cu95A5RkgYBgGVo1t3BZpIAufQ/0ZRZ4Q+F9i8Or8TJX
	 +KxUQ5KWCUOGZanSeyB469IDbOvuJou+z/84ywG+GH2AK+MkBNV1qlEbKXVyGImqtuFAD
	 EwxLAl2I04pwCX57rM8U/46ATQDm1TlB1mUaSkZQnvMltZu9mUIwLudEoEsk5fARtDQAV
	 XE7uGzBG3jIMJv6rj9irwS9XF7pqKHzgo5aD+LuYMYpNGWjyHKuWZicfJs1WUyl41DtLT
	 GQI9F/1zdYnhTxRBoZz/2AzmLkUZwL+H0iI8ab+K9rbXMu/Z02kbfKtp12muTbZtHcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180552;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xENf0eoUGZdfDkYJ3sDGskH+jC5/Mfw71VSp/kGlzNw=;
	b=hCq8adx25TcM9m+6hXdS6eqDCSFP9KwNdduIzIcAwLNU+rMCdTTpd7lMJTqxCSeQ8+la
	 di0Nzm58JQLlbZ1h2n99E0PbjcrF5ZqSDJrJRDkrK1Au0XuaUc6jvNBsaWXnXzAffsIDe
	 ft70djRwrdXRnhuZe7PXd3tWVqBZpLlQoKoJgZ8ggPlDWQ2Vqfr7ZwWQpjExjDHqbSsch
	 aG375FJ/pJCTGGLwQcMqVgtSm+64QdQg3tTDfAGvQPWsGPp0tl9kCnB6sdMNDfg0resR1
	 TxKJ9tD0phx/ezuetzolMZIEPgIjda9YIr13ECufg+upv3OuhQwlXubFS3sCDOenTNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="fBb/IzP/";
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7EA60A3807
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 09:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B7EA60A3807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fBb/IzP/
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc4aa0246b7so442489a12.3
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 02:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793180551; x=1793785351; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xENf0eoUGZdfDkYJ3sDGskH+jC5/Mfw71VSp/kGlzNw=;
        b=fBb/IzP/a7h9HN/UZbW2iNlsBVcAK02uvsH/Kt9VnNTT9CwEj6mcTgpln0cyotYi1/
         U75X96/tXsoPnMSUeBc9fw4OLadyB7WsuPf4GvMbbORo1UX7U7zplpMHu6oXqzTvrwrE
         vYXI74q/w9nqV0LYu6n0kyVIBqHagOvQL2+1IAijnmK8Jl14ylyPXFFxJdkzB/fwF3KA
         JotGlD/wsXk7NY3JsXADUrhZ3MwGii587FR4XZ1aNr991JBXp1dv6qXk050MNi9U7OLE
         1lglslR2/WkPJ4hqVbZ6e+Gqofm4GknbwL4oG/qo7A9VwNd8JAdX3ew1a3dHImPSQ0DL
         AblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793180551; x=1793785351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xENf0eoUGZdfDkYJ3sDGskH+jC5/Mfw71VSp/kGlzNw=;
        b=BsNjvOGDd0s3MXFun8RQXP0uiGXBOUqkfFCZT5XGKYLVylOjAKEnC/4E7nArHqUM82
         PXGZ616YWby27f2i2TyFMu2xAJ87spP0Nxb7m9uNfMq6a+OUndzjmOBLKQ5EM5wOhr9K
         MY1thXzyONGVxysYKdw+1DxkXucP8alVCGklxkPXeBPMcJoaivm2w7Ir/Fb5disqS0nP
         9lPBnMW9Y6cI/jaikhydj2lLkBW1XFMjfixtQDKVMQgHDvZbvhdMRCXBrq0ZguGN3Opi
         ID3XPV9c87R5Tm7JJ/QqYv+ynGK6W9y2UIP4Oh+fLqwMDRBiU2THSPfibI9jf3w2Z5po
         C46Q==
X-Forwarded-Encrypted: i=1; AKwUvBy7fVWxwKGVerRUe3Wa+3BvzhMkjZ/b4ETfhDHU5lJja8PcL5nSWkWnTMFqb1EUvdnegWRzGugkOMNdx/lcRw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKZVaBO5SJR6oOTZ6UNNpZmKOtxn0PuSVSM3ZCkmBAfDTGUgMot
	y6KtR4vI4wpeptISwIcsExuBhwIBXDbglIjaNgsiEtVYRPndXoCTKPBV
X-Gm-Gg: AYBFou2IO7fH67r8/0i9SGHFWi8LVfA+sP5SqTSufkY7d1LimUm13MKUCvKk29KlVJg
	LDQM8cxdww196BqRC9PUabOmlLP9hp5cr4TY2aIGSS6a90eCyebt1Ixl03wMl9SvUxqzfsiY5c/
	FpBBL/y1ntb1F4p3p3+xWdJUjunYNilc9UduZDubnKvNYLydnumOyOr3IZWbY6eesiq4QMcsyX1
	5p3+0UMcsESWKWZxVu23WxA7VhyfidVvxpKX2HuOpP5BoijY1ne1uSSu1q88Y3tSsJBk9c97CS7
	fnv9loarswQ1FOwU2Ie4OpG9jgPjHAHayhpQj5zynU4LTQ7j8F6qcleZ3HZbLyAgHkGyVSsRj4/
	mNYw5wdvyztuyfNdjCHO0D1ytwqzx7D1wUmFtB5R63nUcH+bOA5jApOvndbto79Ww9vygn07xDr
	RsIcgJpNo+UKSyP3hOBDXS9PYuu8M72TLdVFZSSGtqg9n8tENVVTFHY4klCCcYWZ5Yv5Dwb8X3v
	zyUI3DEhQsr9tYOmUiW2WltggIRP+34GUTeGBW6xQI9WlkSoodki+Khq5+nn0WwwyO5u3jtYEoS
	8O84OwgyGziMorFEjL2M4sCFkLFF1uXEXUzFG55vn1PLRxWSVGWVQUF0z4PvPSbvUb4mSW9juub
	+Uzizidf0J1KrN+w57PRzcszC0zPAxc0oTQ9/UImPtfQxs7AU6xDVbrF1EvbgepqKgbGd
X-Received: by 2002:a17:90b:4a4f:b0:3ac:fe93:a731 with SMTP id 98e67ed59e1d1-3ae5822102cmr1339726a91.56.1793180551322;
        Wed, 28 Oct 2026 02:42:31 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a93b3f5sm2242377a91.5.2026.10.28.02.42.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 02:42:30 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.de,
	perex@perex.cz,
	anton.yakovlev@opensynergy.com,
	mst@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-doc@vger.kernel.org,
	Joonho Lee <mynameisjune111@gmail.com>
Subject: [PATCH v7 14/16] docs: describe virtio-sound capture options
Date: Wed, 28 Oct 2026 18:41:30 +0900
Message-ID: <20261028094132.20364-15-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261028094132.20364-1-mynameisjune111@gmail.com>
References: <20261028094132.20364-1-mynameisjune111@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the five opt-in capture module parameters introduced by this
series. All default to false. Describe the startup-empty, short-payload,
packed-status and pause-restart compatibility behavior alongside staging,
and require validation with the target device.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 30 +++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e75344f..6c7b1b3 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -8328,6 +8328,36 @@ Kernel parameters
 			brightness level.
 			default: 1
 
+	virtio_snd.capture_allow_empty= [HW,SOUND]
+			Retry a bounded number of empty startup capture replies.
+			Format: <bool>
+			Default: false. Compatibility option for devices that
+			require staged capture; validate with the target device.
+
+	virtio_snd.capture_allow_short= [HW,SOUND]
+			Accept non-empty, frame-aligned short capture replies.
+			Format: <bool>
+			Default: false. Compatibility option for devices that
+			require staged capture; validate with the target device.
+
+	virtio_snd.capture_packed_status= [HW,SOUND]
+			Read status immediately after the returned capture data.
+			Format: <bool>
+			Default: false. Compatibility option for devices that
+			require staged capture; validate with the target device.
+
+	virtio_snd.capture_pause_restart= [HW,SOUND]
+			Release and reprepare capture streams across pause.
+			Format: <bool>
+			Default: false. Compatibility option for devices that
+			require staged capture; validate with the target device.
+
+	virtio_snd.capture_staging= [HW,SOUND]
+			Use request-owned buffers for capture data.
+			Format: <bool>
+			Default: false. Compatibility option for devices that
+			require staged capture; validate with the target device.
+
 	virtio_mmio.device=
 			[VMMIO] Memory mapped virtio (platform) device.
 
