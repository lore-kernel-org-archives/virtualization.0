Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214B33A2E36
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 13:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778851963; cv=none; b=IG/WKI46lAUp3bC1p80aKGpYK2My5xS3H/cEXR8yNYC9LfrSF7vIFHETMFjpXz6LZ8DjOc7Ted6l0rbeXhOiyTXEQGM2REoC6yohHaJvigJj3NIiXlix7ACbaTHh005R8FjpMcl+VVPBs8ky2BvyX6+f+R0XVTIC+k3G3cEbmjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778851963; c=relaxed/simple;
	bh=ou1StnidYf6G/yTiPb1Jyr10n23l4lsfoChEA55hU/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LRokpEIAOUmtMkE3dO8fBuDNgb1KnNIhR5/bq+WUrcJA/wqIzaSp1ac7dDwiluayNImfPSbJ/a0qdgIXk58DIuquPRYJsVaRMqUBat7FWJQUdwCLjhQM3YaUK5KKyJi+ViizZTMROQkqDnOKb33aGTZ7YKZtO9fmlz3pPBlCX6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czF/JgCI; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czF/JgCI"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b4520f6b32so14928757eec.0
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 06:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778851961; x=1779456761; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d8duf5TvyhmY/rcIc+GeiPIXbLWq3N+o607ETTSlKvE=;
        b=czF/JgCIBmu4F0cyQ7KCZV0g8Tv5JaSOuviFrYqj+ipO2wNzYdzZZ1k3KNvpLIKWUJ
         5TL5vIwJRxN7PPtYRhCJ4opuBd41qqcXN/PS2OYt+ySsAqZrew2QtxoSHah0qjyoG778
         TrjCacKCtEdfTZcnHwkREk11LLt21YdJhXpIkuba+Pm2647S9Ko9jpJFcWuhkzsAp2xI
         h8dWjzQL6rLrHIoXWuZ4l6+FGRlthTq2tKx1GkgLhpT2HkYjq1VeCfKuLy+5m+lrd+iT
         fWluuBHYWWiJH0SZ/1+WxU4uPvwG5854vthDbsuUgcRaZWknM9giHyDB58iszxkk30LR
         s5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778851961; x=1779456761;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d8duf5TvyhmY/rcIc+GeiPIXbLWq3N+o607ETTSlKvE=;
        b=UFqm/LATER2I+1Wxd8zMKFeWGUguqEwTdHXRqAeCORM1sMaUSw3//55fa9hht/2EHm
         sdk4gusklaMQxsbwrilJNLrnkvEKOyLw7M1AR9C50NSHPMVOExsycEYQDlDFlGyX9zSG
         WqGHDyi28ffm+G7N6SaqjK3cmgzU34Q7qiGpO4W+dRaKYHJbuk6qq+FJr/S+g0uT+y9v
         iG8SltXKy9rdrplBwOiJ8UssVXtbxpnhw1DM/nqa5b3xtpFD6e0gezhZTFuRhdP1ZV6t
         5SgwhOlM4ke8H5+DkAq4lY1N8S3U+2sGUugBGbgHz3zpzY8balHwLhAL8okvJtMuoUcw
         xsFQ==
X-Gm-Message-State: AOJu0YwikEGpj5Qkxw9JsIK+0GDbTxyRfMbPdth/HrAhIRqE3n2Y2sES
	jhAIaVw6R/VZ1fyWu2XLfD4CInZk8DudVpIwhzfxTgwA/tJLw1ZRuDRX
X-Gm-Gg: Acq92OG0K/HOikq1bw4jLgYOrdjLePIrIQswuuq+sEdJprpSUIh2PqGu0v3Idi8tIzr
	a5CJJXsGkcnA/ei+NFOdXe27J80WAsjgluVP+bNwgXzx0ZXbnZ83a3FPFUN85uBi/qGADt70Po7
	xNgChDpndHMmmNAaCtjZ+I5NIQtn+r5mVEmZ9kOSXC8rYefxbOxwtn7qqPk3pXYhFbi0Agd2OBK
	tMIInhxBpp8tpupn1DIvgRa+YOjUERmKXDELwk8M4y6utUvlL5oz+5mlWp0CmVzbvHFRZ9tUHkX
	dQp1mibbYFeQjl5Rs7O32aXDhGMoQc2j8NurxzaQ9uZ6HRO4X1HtRdjS82Ko/jqkO9ndqTd5Y9K
	bhDKq/lxbbGOcOZtML9xEiRDrJhvhIkjtapnUZavf2rHm1Cj4nOUGJZYtHcq0isU1+VyWkw0k+s
	BU2HTPXBNpyZBGLEv0EZQy0JIk9/eQESxCQmyVhMmGA9uor2j8UkhtzWvPmDcfVyWXW7jdqrdXX
	cj1YKGAPsN1gMUHSAVzTAk=
X-Received: by 2002:a05:7300:641b:b0:2d9:6373:ad24 with SMTP id 5a478bee46e88-30398652478mr1931599eec.26.1778851960947;
        Fri, 15 May 2026 06:32:40 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-87.user3p.v-tal.net.br. [177.4.161.87])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302973bcd0csm7114643eec.24.2026.05.15.06.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:32:40 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Fri, 15 May 2026 10:32:25 -0300
Subject: [PATCH RESEND] ALSA: virtio: Add missing 384 kHz PCM rate mapping
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260515-alsa-virtio-384k-rate-v1-1-35ecb5df835c@gmail.com>
To: Takashi Iwai <tiwai@suse.com>, 
 Anton Yakovlev <anton.yakovlev@opensynergy.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jaroslav Kysela <perex@perex.cz>
Cc: virtualization@lists.linux.dev, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2404;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=ou1StnidYf6G/yTiPb1Jyr10n23l4lsfoChEA55hU/0=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDFnsCqWHmmc4HlFaGTmvdaXOz8pl2o75E6fGT7wy++jn/
 1OjcpP7OkpZGMS4GGTFFFlWJy2y3NP14Gp93AoPmDmsTCBDGLg4BWAiDzYy/E+0yGg8uf9H4MPr
 4td580LOLazidggyb0zJYXboqzi4r4iR4dSBSPd5N084vVKzFFDNeHwmQZ3/w/L524xf5c5lX+H
 /mQsA
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
-- 
Cássio Gabriel <cassiogabrielcontato@gmail.com>

