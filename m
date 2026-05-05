Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331CC3B9DA9
	for <virtualization@lists.linux.dev>; Tue,  5 May 2026 04:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777956032; cv=none; b=JhJdzpRuTPqzQgJquXYFaDcSP6zj8/i43VDdskbs+VBVuwbIoVO0xxu/6hOPxNUWpmGbT/WVBt54hflTNhnxetV3iZW0ooP4mXVKlZsCmLCxMAySQkgziJQKM+dB59oNOC97xRufGEeR7PmNCfjuPZ0yr7NJ042cOQA8ShmPU0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777956032; c=relaxed/simple;
	bh=xg+AzQSH02m2ChqkHlHOL0nslwkp1ELZhv5oYpTQd1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FY3xZA33hSckT8HhwztwlyGSWMJ5RFNHQxJAt1z632uf1/RWml8MLSsVyQ/v8MJGlaokYW5epw1hLUFnsjmGy3wgd2tM2N/TrWMvHXP8ALmp+lqgufVfTSRBvUQjbDjHJ+UY1uY7AUgE+PfYmLIHAqOL0J9QB3XUh9ULrCrgCvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqeMTmX2; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqeMTmX2"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-130b2295ed0so846959c88.0
        for <virtualization@lists.linux.dev>; Mon, 04 May 2026 21:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777956030; x=1778560830; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wD6lG8b++LnD58VJ+TTawp1hDBka3Nn4267cv0Dov5Q=;
        b=dqeMTmX2UuI50WwU312LNd4wgEKnm1+D8Pa50OqRJgi1qjXlmMNcy64uAnL4tXdp5v
         iWAEDA2y/U6Pk9YV9dAMhaZnmKE6I+pKb28hNSIm12VyYq6aJFK83TjnfbZnbK11hRbt
         42rQdQ/uo5WIuuJkvZIHrspCRVzP2CHmjRtyw5wrexdUvrxfDR6wvTHuUhexGdWJmiIj
         c55KJjR0vV5IR436N1btDBK05qaFGxlcnT35fq+CGX5TuT7tyKh9ZE2oaWU2QJfO3cTW
         EtbnzoAMc9Ib+CKWhs76HayIL+oF5BkTpGp1hYv+oeDmN6pJKCULb8xbya/1nvDrrsJ/
         AF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777956030; x=1778560830;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wD6lG8b++LnD58VJ+TTawp1hDBka3Nn4267cv0Dov5Q=;
        b=iuhq9QSp3WZHaHT17JfxmDhay2MMZFuWhMWCxFih3UdipxldLy5xzUBX46m+IExiiO
         +Ooyu9bEatFepnZmp/QrpJyjsNODaWwyT5AiRDf1r6a4XUM5nRRrlEpecQwfAzj+LYaQ
         yvylVYnN28lGe6OlmBXcykOKjlQVYHAY8nZZBvQhl/jB0cNFOMMg+NnSAHwWTVNnZ1WG
         Z9lXU7hc+/bJlhZQ18S7rDMR1kbAAn+1s3WepZxU+duYz8X/NQzlhcLkro1NOvXL7hqK
         z7D8xQg3OM+cy44z9bds9AL+FKZ443ebF6JKeK+87uwv8ke0OF9mpLOaTf+/qVbRl/t6
         Vu4w==
X-Gm-Message-State: AOJu0YxPRibas+jhNGcCCDhLV0/lkKocr9iOwH8ctCLgCHgIEd0fcyTG
	XWopqNL3cXrycP5dBLVoXzdL241BuYy5iHfMbKeqPrl/eF5daVn7nT+O
X-Gm-Gg: AeBDiesPNLZSh5RyP4+AXctxOWQjD6Rni57Wqr6JBHzRQ6EWxW7BjAXzutTtwaO6eaG
	iBi5ypaWmuDSk4CeKSq8qjCvUp/7JUAcLO/FHidaoVZ4m6W5czMrJz83oO259wConQquzhNVjeH
	/oJjmPKl75eTVXHlJ7iGhXV19YhFNadnyjggQlH+Yp5pOXDObmUrLwSSrjuWwU1pP0+87gpfJ+q
	AVtqoaWeoTz0ZMkZs5czCxAlQYuATOEaMDAl/z/EtvaDRnLslix5FocEWLdSU0yy3Dc7UUhJXzu
	e2c6p+ofdw7lw/ldNlqwypA0t+PZJNB+bO/05GyDQHTHe5gg8k+dmSbr9FSqqtp2WM/hsRQX4U+
	9sL8FoeiuDpGYtmmdZvu6bjaVrdlzjaxeo9RB8/BcmBrUC0rZC9tRaLECFBX2Zny6pN3Pf9Z0SL
	1DMLUCase3jAw3fsx2MdhiM1a6/Yotnf7V0P4c/yFchn+jixuKQfCY/YwESMNOfEX0GmM9PheqQ
	pjUtyGh8Dyl
X-Received: by 2002:a05:7022:4392:b0:11b:f056:a19b with SMTP id a92af1059eb24-130b1752467mr1065462c88.18.1777956029887;
        Mon, 04 May 2026 21:40:29 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-87.user3p.v-tal.net.br. [177.4.161.87])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3b29b2casm18920019eec.14.2026.05.04.21.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 21:40:29 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Tue, 05 May 2026 01:40:21 -0300
Subject: [PATCH] ALSA: virtio: Add missing 384 kHz PCM rate mapping
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260505-alsa-virtio-384k-rate-v1-1-ca092185bb03@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CQAxA0auQrm2ChTDoVQyLih2oGjDtSEwId
 3eU5Vv8v4KLqTicixVMFnWdp4zjoYB+5GkQ1Fs2UElNWRMhP51xUUs6Y9XWDzROgoGqKKcQKHI
 DuX2ZRP38v5dut7+vd+nTbwbb9gWphXDBeQAAAA==
X-Change-ID: 20260422-alsa-virtio-384k-rate-723fe9772fa6
To: Takashi Iwai <tiwai@suse.com>, 
 Anton Yakovlev <anton.yakovlev@opensynergy.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jaroslav Kysela <perex@perex.cz>
Cc: virtualization@lists.linux.dev, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2351;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=xg+AzQSH02m2ChqkHlHOL0nslwkp1ELZhv5oYpTQd1Y=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJk/S3aFnYviPKy76r+C6bLPDEvun9saHRe3+O5Dt1K7P
 MbT7xu3d5SyMIhxMciKKbKsTlpkuafrwdX6uBUeMHNYmUCGMHBxCsBEFFwZGS5E8Yk32zOpbn3G
 +2Ujh8qBGSlftlWk3KkUXpelIPmvMI2R4defJeFKDCLdGtuZPu+qEvm5deurfXqcrccFJHzfPL3
 /hQEA
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83

The VirtIO sound UAPI defines VIRTIO_SND_PCM_RATE_384000, and ALSA
has SNDRV_PCM_RATE_384000. However, virtio-snd's rate conversion
tables stop at 192 kHz.

A device advertising only 384 kHz is rejected as having no supported
PCM frame rates. A device advertising 384 kHz together with lower rates
does not expose 384 kHz through the ALSA hardware constraints. The
selected ALSA rate also needs a reverse mapping for SET_PARAMS.

Add the missing 384 kHz entries to both conversion tables.

Fixes: 29b96bf50ba9 ("ALSA: virtio: build PCM devices and substream hardware descriptors")
Fixes: da76e9f3e43a ("ALSA: virtio: PCM substream operators")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/virtio/virtio_pcm.c     | 3 ++-
 sound/virtio/virtio_pcm_ops.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
index eb9cc8131905..be3893de40a5 100644
--- a/sound/virtio/virtio_pcm.c
+++ b/sound/virtio/virtio_pcm.c
@@ -77,7 +77,8 @@ static const struct virtsnd_v2a_rate g_v2a_rate_map[] = {
 	[VIRTIO_SND_PCM_RATE_88200] = { SNDRV_PCM_RATE_88200, 88200 },
 	[VIRTIO_SND_PCM_RATE_96000] = { SNDRV_PCM_RATE_96000, 96000 },
 	[VIRTIO_SND_PCM_RATE_176400] = { SNDRV_PCM_RATE_176400, 176400 },
-	[VIRTIO_SND_PCM_RATE_192000] = { SNDRV_PCM_RATE_192000, 192000 }
+	[VIRTIO_SND_PCM_RATE_192000] = { SNDRV_PCM_RATE_192000, 192000 },
+	[VIRTIO_SND_PCM_RATE_384000] = { SNDRV_PCM_RATE_384000, 384000 }
 };
 
 /**
diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
index 6297a9c61e70..1105e7ff3523 100644
--- a/sound/virtio/virtio_pcm_ops.c
+++ b/sound/virtio/virtio_pcm_ops.c
@@ -90,7 +90,8 @@ static const struct virtsnd_a2v_rate g_a2v_rate_map[] = {
 	{ 88200, VIRTIO_SND_PCM_RATE_88200 },
 	{ 96000, VIRTIO_SND_PCM_RATE_96000 },
 	{ 176400, VIRTIO_SND_PCM_RATE_176400 },
-	{ 192000, VIRTIO_SND_PCM_RATE_192000 }
+	{ 192000, VIRTIO_SND_PCM_RATE_192000 },
+	{ 384000, VIRTIO_SND_PCM_RATE_384000 }
 };
 
 static int virtsnd_pcm_sync_stop(struct snd_pcm_substream *substream);

---
base-commit: fac9a31701803e4e41fdb7b5c71582c65cf47176
change-id: 20260422-alsa-virtio-384k-rate-723fe9772fa6

Best regards,
--  
Cássio Gabriel <cassiogabrielcontato@gmail.com>

