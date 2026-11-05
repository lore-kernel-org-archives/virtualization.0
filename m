Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793837405;
	b=xAE6krl2//xnrmayQ5q7sDyvU5y3VUrmYyXW2jBZevlso8d9k2kK/lij4eUo6DcQaJ2j
	 CsMybgpACkIS8cmqgD/28LT9NTkt8y1Q+chDv1CoY3sCWGJuJuqZHacfXUb0zx4wb/q0n
	 fE0QYsivmvrbnzSq9VZ8i8WA6dTH7IpnHE7r7W46gvNQDFDpcF6IB0XUxFeHHc48UPNJ6
	 NH3tk+Z5nPxd4sGPtapBJJFzs8Nd/bqdP9Ta/lHTZoTu9Rquw75Jk454/tkdaLo+Hg2EX
	 +tFZRC67KRYicQtvicWQGVyJrnlEChsCisqkg9cgTetQaDsHlgyk332q7BzslcH62hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837405;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=I+E1FT7j2TPwT2i0hneBh3LNGnIyRwhqUFoGV1aFaFs=;
	b=ZONzXE+tlqT2SMl4r8ShGOcQVhydn6kWZRR/5Xo69Kr3BT+OOfA54vBtVX2+1zdbxAeE
	 onl305MK0Ee0Dk7evOhbY5oi3b/S4BAtH3Dh8Fc+/wpQFgFUWHM9WQlTn8v9HHxTHbkQb
	 MMayDdhucFTR6cBHDdcSTXBVTTEmouvvHd/c6kClSs/4G1sNhQbHcafcc8fibkFyIKaxT
	 5+jXSr2rRhfiOYZymXyj+DBAyOtLFzbdSzsfqqTPlRsJnII5O4ZZXA3osNIkUbotiudXH
	 eQ6cp2Fz4KtnCECRSA60sndc3ihzw6UBBmCjANJOuAdkdRGlLKVraQZbVyW4GzKpVew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=snzqUMTt;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1552D608362E
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 00:10:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1552D608362E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=snzqUMTt
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc502d509c0so550138a12.2
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 16:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793837404; x=1794442204; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I+E1FT7j2TPwT2i0hneBh3LNGnIyRwhqUFoGV1aFaFs=;
        b=snzqUMTtH6JJK95lFg7xpkXMU/Q8jpXfW/L5cjTugSKGiiztz+h/cDtlwKTJMnpaJD
         dsLrYzV+aR/vkYFEzzv1LnSC9Xkn4+KbKWGGKW6me6lN/QFuNpZyY5j99Aox6ExTnt7J
         bFeJacVoTbzG8dLfl8HIGdYp7PVCeYwUy77DmjHiGYO5lFa5S3w+A2n04Nh4aPqB4ZI8
         bNyXr9GbsI36XEuR05PV9RXgYOAKQwpLXTfa/QcNgJ1PZPH/ozL4Zf79ifWH/du9yHjJ
         x9gjTSXeNt3jvkbxvrsieW/UIymeE8T1v0eq5ufMZAdORUp0x6Y6+im5PxET2ASRRgxE
         Gyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793837404; x=1794442204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I+E1FT7j2TPwT2i0hneBh3LNGnIyRwhqUFoGV1aFaFs=;
        b=kqC9KoyVUlDPlZlFu6vcAFCU3X4QquHkMZSCWhC3ze6prqn68KtH509XUaoBTLOnlJ
         CBkyom1OuzpQY+GrGQY5EFHwRK5w/2DjVW4fo7JbozhKaOLzdsbMcOmuvWfaol8olWt4
         hOd14qKxVNEHCJZXKq5X2XEsKS1Z9qTkrVHud8Ze4ytQrHmx7zkehm8UMw/a54fddpIi
         M4hs1FFuqj0sA9hddCi/Qdk7/3Vo2dphqhMa+4UDnlMoy9kRp1Wq+35a/ju57fvxDwCH
         1DCi5XN89CrYr691FJHomNKN+quegsbClwHOob9JnEY3NJljrtLpHlJCwD5FFxIUt1ap
         7LCA==
X-Forwarded-Encrypted: i=1; AKwUvBzb/w71FurvY0Limim1Va/PwpAKrZXLRr3pf1ecfHWDpa4WFx9iv5xfmjSUsdXEyzYgEljzBGehjly39K2VJA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+i9Je3oT23feEBasZG8XoZgK6OVQRff8fJi1rwLaLgqJnUXi7v
	W2GizZ1j/C1OzqXgjrs74U+Q1plkKBxdFFEK2PPoX5az6U+QIKEjalzf
X-Gm-Gg: AYBFou2Dt0skr1O8rYcwYeGos8PHkYM2Ge7FXAd/+6B8Mkx5k67Ie3+/2rpLmSmuSjc
	gbNIouaiEEqwIV6a5R0Z3+F1FlARrdwVfN5yHgDRJCvzvNjiPFfKdDnEq1nF92KlISfue3uVCM5
	SepgAVvn+jwHOFVTYf7pNTBPG+IUuElH6f7FLHo634fBiEYh9uau9QozRh1ulyzDa4feOS2dUxD
	2YhtPAG+7E91Tn+PvpBEdb+Qt3fFJ0KSdnpQPddi6K7O7kkMmzDQcVUTQ61RKmVrX8eFGsUVflt
	liu6udD+snptnNU9Xead3HERG2V8Rj6gdtPrTIpGebEkeDuHbvx2Kqt94+bO7wFWsAF/qiEo9k7
	ghH5WeahR4HUPrc5kxUCE60YofpdzxKyu8Yi+WuYFgGq7nJdqppcaTQa9v+P32FUKt2I68GRjpr
	qvPN6gazGFya05kUBA9TlL0Zml80wLV3NcFDSdyMJS8MC8R+/kwAohCLg87P56Prn4iN/P9Zi8j
	sMw/zpiNUezDBZ+7elEC3dvsrFapmu81xJ7CHyXKz8AksTyRMdVADDIYkzKRF5DuvRnJhp6dbYI
	90VsdFHGVgH/qxS2dpN820Etqvf06Tv5k9OQKOU08GbC8ES4aemq66YqszeqmxdUTiIcaZnPOrR
	Z6lH5YEktSSMn7zJwV7qu+hvR1ONANZYy8ncCfvIiJXfjkGY=
X-Received: by 2002:a17:90b:2e07:b0:3b0:9e2c:9b5f with SMTP id 98e67ed59e1d1-3b09e2c9e85mr2641358a91.2.1793837404449;
        Wed, 04 Nov 2026 16:10:04 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b323c18fsm897208a91.4.2026.11.04.16.10.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 16:10:04 -0800 (PST)
From: Joonho Lee <mynameisjune111@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.com,
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
Subject: [PATCH v15 12/12] docs: describe virtio-sound capture options
Date: Thu,  5 Nov 2026 09:09:15 +0900
Message-ID: <20261105000915.15177-13-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105000915.15177-1-mynameisjune111@gmail.com>
References: <20261105000915.15177-1-mynameisjune111@gmail.com>
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

Document the five opt-in virtio_snd capture module parameters. State that
capture_allow_empty, capture_allow_short, capture_packed_status and
capture_pause_restart require capture_staging, and use the ALSA kernel
parameter restriction tag for each entry.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
Documentation/admin-guide/kernel-parameters.txt |   29 +++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -8344,6 +8344,35 @@
 
 			Can be used multiple times for multiple devices.
 
+	virtio_snd.capture_allow_empty= [HW,ALSA]
+			Retry a bounded number of empty startup capture replies
+			when virtio_snd.capture_staging=1.
+			Format: <bool>
+			Default: false. Validate with the target device.
+
+	virtio_snd.capture_allow_short= [HW,ALSA]
+			Accept non-empty, frame-aligned short capture replies
+			when virtio_snd.capture_staging=1.
+			Format: <bool>
+			Default: false. Validate with the target device.
+
+	virtio_snd.capture_packed_status= [HW,ALSA]
+			Read status immediately after the returned capture data
+			when virtio_snd.capture_staging=1.
+			Format: <bool>
+			Default: false. Validate with the target device.
+
+	virtio_snd.capture_pause_restart= [HW,ALSA]
+			Release and reprepare capture streams across pause when
+			virtio_snd.capture_staging=1.
+			Format: <bool>
+			Default: false. Validate with the target device.
+
+	virtio_snd.capture_staging= [HW,ALSA]
+			Enable staged capture using request-owned buffers.
+			Format: <bool>
+			Default: false. Validate with the target device.
+
 	vga=		[BOOT,X86-32] Select a particular video mode
 			See Documentation/arch/x86/boot.rst and
 			Documentation/admin-guide/svga.rst.
