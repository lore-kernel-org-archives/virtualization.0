Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794444480;
	b=aplDauChZIos5706zEn/PbZfsSfvosNRIT7YCNaMNZovz6jNDmXaIOSPc3ERw8r+8ICP
	 /+mEp0cCmLXd6EYTo61Uye/DaW8ZYMkpFupGme4AGpivSsGYF+YcOxl367Rmc1Rjvhr3z
	 dnAg4kc+K7zu541mnyRss3Nl8wKg9tjgCRzbGgilKtWa61xZDj1qA2p/F9BIQURUTD7xM
	 yyJz0+0LnE7151e6ZM200x6bd1zTHI6p/PSIKeOGuZ90r1Yqhb/ILawG0Rk3y6XEoJhTp
	 H+1IYqo+jNq/ZA/vLA1s8661td1Kg2HZFhPBzEpfQJ/u6daVTS2SyGzjhKY1lA0i5OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794444480;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KO6ffwCtdr8RA7k8Fc5roNJODB8/sxhF5kvv5Zygm2k=;
	b=YyHofTMbv3ZsklRxJV5Fp+BI5+jxQc8hMj0dXvrxjWW8nVScE0pB8bu1a4GlF3/BhC7Z
	 vuZwYwYD6R8FpjS/M/jc6CJvYL/gMNU226BkgwugMxgdDkC/z8WtqsE2oIfLU8kfnDyC/
	 AD4DFu8PZ2c96H4dWoPrP3xWeS2iMtZq6o8EhQNZaz16BFpfzxwFqRdmWdJOYTI92+aDe
	 WNjvuYOxPvTnx0CQGAHcxaxY7+9Z7JZeQprdOwrT6fmLpS0PGI557f4i70cOojlvGMp20
	 Gxhs9wWlr64OgKQ73cNidtSx7Shs5MiNvO9INgRm95zQNv9tFGKOPyWvvXQDYa+YAEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JqU16DF9;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E02A606C752
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 00:47:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E02A606C752
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JqU16DF9
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1b244fb7fffso4666984c88.1
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 16:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794444479; x=1795049279; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KO6ffwCtdr8RA7k8Fc5roNJODB8/sxhF5kvv5Zygm2k=;
        b=JqU16DF9Xz0Sg6dnPaxgocoC9YkVpV4162PMoMm6dGsV8tAqMK09qEYe+c1tIkWPi4
         uglJXxGY/u9lsMbNCZeTq5aNtA5/e8b3J6YgrSmc7NNizfueczOpjKbAVr0YfYspYsp0
         rCZcI99JHsbkRAFNP4E9deLKg7j4TjOSmeGW1ku8tRGnT4iGg1PSZlBSxGWqglGNgmAJ
         k4Almcul7YFTmMgKYzWM1OmcPiJYZThDWTIG+pKFQlrOsAxdJuib0xe9jI8MqzJR4jDC
         ZBXvRFQZPQcijHOOHEtKgSw5vauo0grpnCUnNuyA6TbGqgZ0IXUb0mpAP+jIzfvt7hRJ
         LX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794444479; x=1795049279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KO6ffwCtdr8RA7k8Fc5roNJODB8/sxhF5kvv5Zygm2k=;
        b=OmCO1VEC/wg3j16d8xM7bA4pNcLFNC66bReq5iQOt6o4QrEaF2wiHeyBhrRIpr0qhj
         DYr8mFeBvXkYvnPS5J/FQtsdAPGXDOvRmNATAqNQtX5htqYvD9RzKCA7aR74kxbA7t/C
         N3+CekjkHpfDx8+8iZSPHz15slVWrqnd02s6xYMqP03LnUHgvbrUgSSgsUKKBv12mUpB
         TQf2s3MYh7yENlupe1FGmWsX3pO+IkexD71JcwyqalEq+w9HFuDqSMjtaQ2SEMauwPI/
         Y9IYJu6T8kHtFv4eVU4MxV8w8EmyJ+HyhZgHb2nZjNfeTESsTAG6mzWErwxQTj9cuH2g
         8nGw==
X-Forwarded-Encrypted: i=1; AL+hErGHWq9TWM2YnUzA+sTRWgw8k4g6YHWe6cYSisiXm/ojzoDbR2I3ipuR8rEaenxVjIEVPSftzpNSbXeyEk/PMw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/xoxp7kIqwsHpbzKjQbEe1wNEAoHE+XV2TQWDav9aRgXkEducU
	N/3GBwV4ZwKTdK32wiSQ1vs3oYVJGk3F6P3ts9Ma48p4917a0Qt05DO6
X-Gm-Gg: AYBFou3+15PNwQiSBcejMXifHtVl4APulVBQgz/RjZSUaFkhUzkrgHyByXuyNxresf3
	mSrssWb/ucXws/5NY+tLLBNgTnKUSi4TSr5oCJ8cgwzqyz+D5TpPJyuF3S9P+mCA1vl8bq+UGea
	9VffbCmpu7W53BKwgPbS5STXTa3RiAhaLhycQztZQ0GKZ+FUFqoBfgOKcNhyMtt00NkU/00zHg9
	1QTd63VDXFkUOldKbSPfmUpO47ZfNRTqAKCrkr2+7kaY9IN2tGpGf0ZgggMg5xwjLZK4gLdNxZ+
	RQBbutkzSjCdPlTy+stCESJBFeQfDn+8PKxfAM2pknyuryDFg+mt8096dZgXLyylOQAYO+Q7fSr
	9d38U0xZIe78i6QZc4GD/T9k2v6WmN+dyHdpACMquNgB+U5JZ5WmSEsUSt5VBe56T/LbBc0Ye3D
	uL1a7X9e2drDWqRGw2JTDTV5xe086TNT8Sek8IM2zukdL+bWpoO+TXt4h1S4OZFsbFWn/Os7vfP
	SSua/dA/2Vu4uwTIqjl5nI/FSRlGbXu4bFNWTt8fflzgtDrlXZvmha9fK6ngQpRSnBWJ4JxpCIT
	q9dvO+bx1JTAa1sENsiFqbDQxFAZm8gRYaDFi4PQBECVGweEky0eCMvZ5lPSdCyC+FFaCJ5gsGk
	XRjztTp6dL9ec6BrE4rUwrkO7OOodcBjq/B4Jn0g/3YaTjEc=
X-Received: by 2002:a05:701b:2906:b0:160:a80f:3ed2 with SMTP id a92af1059eb24-1b3c02f039amr3321754c88.10.1794444479106;
        Wed, 11 Nov 2026 16:47:59 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2eeffsm20672163c88.9.2026.11.11.16.47.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 16:47:58 -0800 (PST)
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
Subject: [PATCH v27 14/17] docs: describe virtio-sound capture options
Date: Thu, 12 Nov 2026 09:47:01 +0900
Message-ID: <20261112004704.49758-15-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112004704.49758-1-mynameisjune111@gmail.com>
References: <20261112004704.49758-1-mynameisjune111@gmail.com>
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

Document request-owned capture in the ALSA configuration guide. Describe
`capture_packed_status` as default-off, reading a packed trailer after
returned data while the fixed status scatterlist remains the default.
Describe default-off `capture_pause_restart`: pause uses STOP and
RELEASE, then resume uses PREPARE and START; disabled mode uses STOP and
START while retaining the prepared stream.

Note that on MMU systems request buffers are vmalloc-backed and
page-rounded individually. They remain allocated from hw_params through
hw_free, and capture data is copied into the ALSA ring.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
Documentation/admin-guide/kernel-parameters.txt |   14 +++++++++++++
 Documentation/sound/alsa-configuration.rst      |   25 +++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -8344,6 +8344,20 @@
 
 			Can be used multiple times for multiple devices.
 
+	virtio_snd.capture_packed_status= [HW,ALSA]
+			Read an explicitly enabled packed status trailer after
+			the returned capture data. The fixed status scatterlist is
+			used by default.
+			Format: <bool>
+			Default: false.
+
+	virtio_snd.capture_pause_restart= [HW,ALSA]
+			Stop and release the stream when pausing capture. On
+			resume, send PREPARE and START. If disabled, pause uses
+			STOP and START while retaining the prepared stream.
+			Format: <bool>
+			Default: false.
+
 	vga=		[BOOT,X86-32] Select a particular video mode
 			See Documentation/arch/x86/boot.rst and
 			Documentation/admin-guide/svga.rst.
diff --git a/Documentation/sound/alsa-configuration.rst b/Documentation/sound/alsa-configuration.rst
--- a/Documentation/sound/alsa-configuration.rst
+++ b/Documentation/sound/alsa-configuration.rst
@@ -2537,6 +2537,31 @@
 
 This module supports multiple cards.
 
+Module virtio-snd
+-----------------
+
+Virtio-sound capture receives data into a separate request buffer for each
+PCM period. The driver validates the responses and appends frame-aligned audio
+to the ALSA ring in request order. Valid short responses are retained. Empty
+responses are accepted only during bounded startup or for requests already in
+flight at STOP or PAUSE.
+
+capture_packed_status
+    Read an explicitly enabled packed status trailer after returned capture
+    data. The fixed status scatterlist is used by default.
+    (default = false)
+
+capture_pause_restart
+    Stop and release capture on pause. Resume with PREPARE and START. When
+    disabled, pause uses STOP and START while retaining the prepared stream.
+    (default = false)
+
+On MMU systems, the request buffers are vmalloc-backed and page-rounded
+individually. Allocator rounding can make total additional memory exceed the
+ALSA ring size, especially with small periods. The request buffers remain
+allocated from hw_params until hw_free.
+Captured audio is copied from each request buffer into the ALSA ring.
+
 Module snd-virtuoso
 -------------------
 
