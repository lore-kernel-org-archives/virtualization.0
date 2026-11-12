Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794460736;
	b=132YpnUfH6bkIy2xlb071eoNvnCnFdkqUpFPykon4SCjzbvCCzR+RCYHfD8WxV11OQtp
	 lqeOvMdhL1bD37RUcEAKDeKwqmolMlYGzg/CbkEF1uDGxft+FYeMwM3AWKJFNklA0yR9M
	 /M7RWaXan9oBBMfkA2VvQlJ6XicaVopy+tX1gX6eINnHtrbwDf1mcg6FQO6m66ScwcZX1
	 cPglT5dqsUjz4BXUHAO4TTDK/aicsttf/nOcZqzbgPfSqpmODL9kS+2G/yrANShZ60Cqx
	 16WjehkNSmkYc/z6Pgn0EArKyUJvxFSS5zJRcwG7IVGFkcAeahj+B/DMmhnUWrkROLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794460736;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Reply-To:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=PeZmCzba2M5Jt4hjT2xigzRftMQa1cn3KQXiYi9CbsM=;
	b=sfMB2xkCfNXgv+i0THSrEfnf19aoGCF5Nue3zeXzo5KrfGMSw6gxY7j73YmTOP6zVthZ
	 qliz6/jKCIf/+vt9y5c3xHUuzWiWHxpYklLEo5aaPOLuMnRd6cUAemrjbiYasGGwtF5zA
	 JpQCZbEA9fWliayAqW8WY6Zo1kV3LfnUmvzSGGPVfZsgM5GZrHudawxD2uiM73HOIduO3
	 AYzyepgf7yGLX+fNDn7O8Jsnh3TRAa3bt41L5ZxBctgnHi3MApl/7qUkYhJMng7d/Lsr2
	 T4yKHgGWZQJLv/N5NvZ9b8i+7SVCXtZZhOcZrvSmCIWhwnKriq827qURa6+U+FNTMHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=deeply.co.kr;
	spf=pass smtp.mailfrom=deeply.co.kr;
	dkim=pass header.d=deeply-co-kr.20260707.gappssmtp.com header.i=@deeply-co-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=X9X34Ohd;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288B7606A330
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 05:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 288B7606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deeply.co.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deeply.co.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deeply-co-kr.20260707.gappssmtp.com header.i=@deeply-co-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=X9X34Ohd
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso8225636eec.0
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 21:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deeply-co-kr.20260707.gappssmtp.com; s=20260707; t=1794460734; x=1795065534; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:reply-to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PeZmCzba2M5Jt4hjT2xigzRftMQa1cn3KQXiYi9CbsM=;
        b=X9X34OhdUrpqRuxd65sYFIfGaRVIfW2NGwSoy68e4HkVb44n+KcbT5IavgeIb34DQu
         7LX2dCzNnpCpOh65aJ1yoQ9Ze4lFqH61QPPLONXgmfUeH4mq+pw3DM9xFSSY1KI02fqf
         o+Q1k2uf9ty1NuVQMldI2YeMRzQGJ+MNKPVrNiLnPZgcVLcCP426PpTghst7XfoM+C57
         XF+LKTAjE0H2jL4uojti6SQqzJp/IG7IKdtxnKAAYW2Jm4tUtC3n/9KejsPItS77X3cq
         ZLFBs4FN/yg6qJZ+IpDnIebYYRalrnS5r9v6k4302KRDq8ZJfiPwiC5XHUDV670HIMH/
         Qqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794460734; x=1795065534;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:reply-to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PeZmCzba2M5Jt4hjT2xigzRftMQa1cn3KQXiYi9CbsM=;
        b=PSFgf3hl0rrtwl/JIauQV5zCc+TEAR9mopYK4Lu+g1gYOkAjf7pyejZCK3gUw+SbIK
         7lkiaz9NrPNmw5IZbogYAyFZnSVTT9Nb6eCxgu4chyGadb2UImzUn5ClCSPwIcusovxr
         FogBR4CCWdwqlbiR94IEjJTnPn/L6EVO4OzpYFGfaZkhSDAsoyQJScjdJ0KHtnGNIQpe
         1Wri0RwaxHQ6fCk7KVKw4MXZLMAVE44l4doueMykKKQudJMswTrFplh726gg/XTg+FJx
         wf75W55U1N94PwGEbvQQ+iMd7JnAkPksE4pqz2SbWVYDP0aXXzTxfDq7uQZCW8A8hYDt
         9LKg==
X-Forwarded-Encrypted: i=1; AL+hErErLeSrHP2pVW7XaRmgpgCN14Y8cDSJ1QifWL9uq9jYikXxE/ahLIDRppglrxu2t+vOQqz+cWoH+XcZWJD42g==@lists.linux.dev
X-Gm-Message-State: APuU4Z/Y56g+0S0JILH0Vv6JI7JWCFF0Ejny0LCepBUSEQVzWjNGRBun
	dumD2JNzeD8rl/7Csd8v5WNDuoEVwDSP0UKPEQr9YGTUZuqEXz3eNCzHZRQU429IPzg=
X-Gm-Gg: AYBFou0BF4lXwqMbeU14G8bG+Vcx0PzSYAfMKmcRDdZDelEBLS0DJUERCW9JN5RPraa
	i+YDV4dXuVAjOgvxTmHzkTJ1/712L7K2fBpBPcMCgFTZPFxj67agMvObZnXt7OJd/EeZF/kzuTi
	2cbE9JHy7Rs3Pk5WSHaqaHzAtfZA2+kz9ZKvDhteSAoOUn5QJPPfvZQA2a82OLbPMBGX4rn8CMs
	+V3hcAHIFnwux7jwv/Zwm7ZMrFL66ThvBKt4Hm7U5hpW0iV+XDA4+d/aDdcQJS0tTJMziEOfk4V
	IPf+V+AyWyPY0FGm5gV0yphjOZaz72pwiD+7bEpofiCNyKo8N1JFJ7FFBwjqBVj40W+5sY7YIji
	ZBGIWh/iJAfFSJVvvaHxyJOQVcLsV8Sbq366483Xa2EunJD5+q7+f0nJEVMLX3rnRxn3VEVwHqi
	sf2nwrr3za+eFFT/1VVrh/9cXs2TfCv6njaqXbaCOof4LCVKSwzPYT4edX1sanbkNMgQZLZ/E+9
	rmlg0vbY81HTOsH6dhiYu7Evzzhgdjdir52h4g40+gMkkwxoYOF6RI0OaQbJMnzAbkoVpOggbJq
	CFuHCT5hNsjz+6+BlnRj2+9rLWoX3Eb4VnjWTy+bJ7zvA5zregwOUo5oZOWTeZVxh0Jp/bHD/+9
	o+Qg4rW4USvQEt/KjhVSKu4nqF9TTKfcYNWymmW+kUbgwG6c=
X-Received: by 2002:a05:701a:844d:20b0:163:c5eb:d42f with SMTP id a92af1059eb24-1b3c024ad18mr4159915c88.5.1794460733817;
        Wed, 11 Nov 2026 21:18:53 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b4b90csm19764527c88.14.2026.11.11.21.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 21:18:52 -0800 (PST)
From: Joonho Lee <joon@deeply.co.kr>
Reply-To: Joonho Lee <mynameisjune111@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.com, perex@perex.cz, anton.yakovlev@opensynergy.com,
 mst@redhat.com, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 linux-doc@vger.kernel.org, mynameisjune111@gmail.com
Subject: [PATCH v28 14/17] docs: describe virtio-sound capture options
Date: Thu, 12 Nov 2026 05:18:44 -0000
Message-ID: <20261112043516.37010-15-mynameisjune111@gmail.com>
In-Reply-To: <20261112043516.37010-1-mynameisjune111@gmail.com>
References: <20261112043516.37010-1-mynameisjune111@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

From: Joonho Lee <mynameisjune111@gmail.com>

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
 Documentation/sound/alsa-configuration.rst      |   25 +++++++++++++++++++++=
++
 2 files changed, 39 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/=
admin-guide/kernel-parameters.txt
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -8344,6 +8344,20 @@
=20
 			Can be used multiple times for multiple devices.
=20
+	virtio_snd.capture_packed_status=3D [HW,ALSA]
+			Read an explicitly enabled packed status trailer after
+			the returned capture data. The fixed status scatterlist is
+			used by default.
+			Format: <bool>
+			Default: false.
+
+	virtio_snd.capture_pause_restart=3D [HW,ALSA]
+			Stop and release the stream when pausing capture. On
+			resume, send PREPARE and START. If disabled, pause uses
+			STOP and START while retaining the prepared stream.
+			Format: <bool>
+			Default: false.
+
 	vga=3D		[BOOT,X86-32] Select a particular video mode
 			See Documentation/arch/x86/boot.rst and
 			Documentation/admin-guide/svga.rst.
diff --git a/Documentation/sound/alsa-configuration.rst b/Documentation/sound=
/alsa-configuration.rst
--- a/Documentation/sound/alsa-configuration.rst
+++ b/Documentation/sound/alsa-configuration.rst
@@ -2537,6 +2537,31 @@
=20
 This module supports multiple cards.
=20
+Module virtio-snd
+-----------------
+
+Virtio-sound capture receives data into a separate request buffer for each
+PCM period. The driver validates the responses and appends frame-aligned aud=
io
+to the ALSA ring in request order. Valid short responses are retained. Empty
+responses are accepted only during bounded startup or for requests already in
+flight at STOP or PAUSE.
+
+capture_packed_status
+    Read an explicitly enabled packed status trailer after returned capture
+    data. The fixed status scatterlist is used by default.
+    (default =3D false)
+
+capture_pause_restart
+    Stop and release capture on pause. Resume with PREPARE and START. When
+    disabled, pause uses STOP and START while retaining the prepared stream.
+    (default =3D false)
+
+On MMU systems, the request buffers are vmalloc-backed and page-rounded
+individually. Allocator rounding can make total additional memory exceed the
+ALSA ring size, especially with small periods. The request buffers remain
+allocated from hw_params until hw_free.
+Captured audio is copied from each request buffer into the ALSA ring.
+
 Module snd-virtuoso
 -------------------
=20
