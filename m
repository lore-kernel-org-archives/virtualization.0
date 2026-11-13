Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794561694;
	b=4riZyKfF/gmk83xktSa4L0IPexapfdI5V0a9+KVI5KmxGQeJOq6AhKX8MgH7BRnJuvkT
	 NYl0fIb5bDNq2gw1NMTyhfZBV9voiSqyIeAHBmes0pyE2/SA7fTV09us3HASlwiyvNNnv
	 errz5jtL+ZdIxLKHprDXErulAXWFER0qiV4qxPh9NdjAL+2qpIUMgYrrcGvUfUUvOeK37
	 hIJIoMEWeUjbv/tcSA6c8+SKiMzjAF9kUz0EYRrFEd8E4hMsKTJcA7U4D1diBgfOf1Zip
	 +qLlv9WC/lvzevKfarWbgp+HGphthIP9aXUWYJB6wDYzOKn5eBnNvT4u27643zRM/Xw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794561694;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Xt4nVbr+QJWsmhkuk9NO2h+mQ+GI20Tp8xXx6ZTHMq4=;
	b=CcnXfh0pJUB0bdt3nMW9WF5MpKvOyp2fCMOneorY/l1FKrckHzsd1wVj5iYrvHQde6uh
	 BHQuZqLcVp++XKEEYfEv8TrEE1XKMNWvcSGyXuGwWzd4DYtmltLZ5bcFGW1KuHwx6q7h1
	 GxFO/dOV4DuqPinLdPNRZO5chCg0c2wA2PDn/Eb1u3B+gL2eVBz0ncroZnEYFvOAM4suT
	 vQbY8PaiIy6aWCPffhnzaAz/mrEV1lC8ePZly+LIyPqs6ewQutEr7MEfsWdD1132kUJ9v
	 kZZxu2SutipDO3rcgBbvq/nKGUl6HRNtCVdm7ErYS+bZqgC1Xfa8AKMoUMj02qOzyCA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O7n4aMIj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309F1606A32D;
	Fri, 13 Nov 2026 09:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O7n4aMIj
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794561694;
	b=RjJWRbyxCq2ALJhu9lx/sW6qecjIDGiAgwyiyRgMrY2r0x73YobhdmYepsm7rmWd7wWh
	 wVWQ8dua+IqibXxh+JeAT2TGUKKW2NqL8mYWf7SefzitnMFNQmNUHbk4GbynqW0kFKTfR
	 c9mBou99MDbZ+TjiWoSKN+QECy9mYx9ud0ozFt44PPSZSuYZJw/bo02tZUK0rldboJdo1
	 r35mMj9uEQHZtYYUI2msEYUYjToHCZha4byR+HqU0PzhOqEabVrBRIqrud8ZXq3miLhJz
	 31eK/ZIryNj3Ob5v5lPpy4VxKQQJ8EUSbAGXhBMc3dt57GBHDH7ZdSsAIj8NtHSJ0Tg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794561694;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Xt4nVbr+QJWsmhkuk9NO2h+mQ+GI20Tp8xXx6ZTHMq4=;
	b=U/gVnWLfxHtjRPyQkyigjZJFZ3caMD3Ok+rVgl5THPsT0NrP+iTSHJVXL1sDLuxF5VmY
	 wmvEYcNdPyn1hsu9bAheY0s3X7UlQSNxkPj76sghZnjGWoFemShjTiM1F93/8w3cS1w1f
	 93yZq1bnT6gzS/SfsoPUKTmO+VHIaili/5L8p1wCsCbFFt7iA9UhPWsQVhff0VuuiNnms
	 a00MNTASu79+4lCbfeVdUBFQ1KJJxX0HP9InKvwXzAriD+g/Q4iJYYQN4gmFDz1MiAA4j
	 HZ6KkDf2Eb5lIMSJo7XBHT9cYheKIxhmjYmC/DDm6jrWNhRBUbVhWL19a9rok5VV5EQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D74A21F000C4;
	Fri, 13 Nov 2026 09:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794561694;
	bh=Xt4nVbr+QJWsmhkuk9NO2h+mQ+GI20Tp8xXx6ZTHMq4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=O7n4aMIjaajYoogMrhI9w4o2/HrgZZb+nUGwNvK1M0pRkxT53LFnzPmdu7if4aN2B
	 Kq8bqieSgu7OeR2dwKIVmI49Zu0i4u4sRLvX4tsVd5HaGXXZlGjQvFr35nbDv5x5rS
	 KNwipdSRq70EAdVOCWpz+5QfaYQcsW5IfPJdhx2GvKANC+Csq1GQZ21fDUQU5g2ECf
	 XKRteszzMZBDowxrSkh/ynf3OyKdUEds6+XYJUbBlfwJoNZ6RPsVgsigJIwAG2DD9X
	 3dHUfz2CRyoklR5IDqA9LR4WpdyrF9mk6gDKP+rbTjcQA8X4PzuUGXST5gwAGpfsyA
	 7/IARzKupjurg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 51B53476FA;
	Fri, 13 Nov 2026 09:21:32 +0000 (UTC)
From: Joonho Lee via B4 Relay <devnull+mynameisjune111.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 18:21:25 +0900
Subject: [PATCH v33 01/18] ALSA: pcm: mark stop-threshold accesses for
 capture policy sampling
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-fix-virtio-snd-recovery-final-v33-1-13a934ad5ece@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v33-0-13a934ad5ece@gmail.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v33-0-13a934ad5ece@gmail.com>
To: linux-sound@vger.kernel.org, 
 Anton Yakovlev <anton.yakovlev@opensynergy.com>, 
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: tiwai@suse.com, perex@perex.cz, mst@redhat.com, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
 linux-doc@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, 
 Joonho Lee <mynameisjune111@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794561687; l=3315;
 i=mynameisjune111@gmail.com; s=default; h=from:subject:message-id;
 bh=sCatKzTRQ727dcoeYM6czFLlHu2crS/Fj1mgMxGQJm8=;
 b=G8HEn7ySIPhDuqHAy8ktgbO9/ehUOZsJ/LIIwR6iMN9DR1xyNbATm7Gqob/CQx8vs5gglQWZU
 30vF0Mu4mSECWfO3k7XY2O1kojlX//WNeQj+QwCQ6s7WtvmjyrNFRCn
X-Developer-Key: i=mynameisjune111@gmail.com; a=ed25519;
 pk=wqkZdvfcC8g8fDi6f0Y58LlaXIo+ubf6Y/9Lr9yhshc=
X-Endpoint-Received: by B4 Relay for mynameisjune111@gmail.com/default with
 auth_id=1508
X-Original-From: Joonho Lee <mynameisjune111@gmail.com>
Reply-To: mynameisjune111@gmail.com
Content-Transfer-Encoding: 7bit

From: Joonho Lee <mynameisjune111@gmail.com>

The staged virtio-snd capture path needs to sample stop_threshold from
completion context to distinguish free-running capture from bounded
capture. Software parameters can update this field while capture runs.

Mark the runtime stop-threshold assignments with WRITE_ONCE and the proc
status read with READ_ONCE. This pairs the assignments with the driver's
staged-capture policy sampling.

These annotations do not provide a transaction for the entire sw_params
update. The driver serializes its cached policy and accounting with its
own substream lock.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>
---
 sound/core/oss/pcm_oss.c | 2 +-
 sound/core/pcm.c         | 3 ++-
 sound/core/pcm_native.c  | 5 +++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index e8df27d09b97..897c8dddcfd2 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -2958,7 +2958,7 @@ static int snd_pcm_oss_mmap(struct file *file, struct vm_area_struct *area)
 	       runtime->oss.mmap_bytes);
 #endif
 	/* In mmap mode we never stop */
-	runtime->stop_threshold = runtime->boundary;
+	WRITE_ONCE(runtime->stop_threshold, runtime->boundary);
 
 	return 0;
 }
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 064df4cd3b50..356ddaf33f63 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -422,7 +422,8 @@ static void snd_pcm_substream_proc_sw_params_read(struct snd_info_entry *entry,
 	snd_iprintf(buffer, "period_step: %u\n", runtime->period_step);
 	snd_iprintf(buffer, "avail_min: %lu\n", runtime->control->avail_min);
 	snd_iprintf(buffer, "start_threshold: %lu\n", runtime->start_threshold);
-	snd_iprintf(buffer, "stop_threshold: %lu\n", runtime->stop_threshold);
+	snd_iprintf(buffer, "stop_threshold: %lu\n",
+		    READ_ONCE(runtime->stop_threshold));
 	snd_iprintf(buffer, "silence_threshold: %lu\n", runtime->silence_threshold);
 	snd_iprintf(buffer, "silence_size: %lu\n", runtime->silence_size);
 	snd_iprintf(buffer, "boundary: %lu\n", runtime->boundary);
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 35152fae74ca..a2ea44c3c1d2 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -871,7 +871,7 @@ static int snd_pcm_hw_params(struct snd_pcm_substream *substream,
 	runtime->period_step = 1;
 	runtime->control->avail_min = runtime->period_size;
 	runtime->start_threshold = 1;
-	runtime->stop_threshold = runtime->buffer_size;
+	WRITE_ONCE(runtime->stop_threshold, runtime->buffer_size);
 	runtime->silence_threshold = 0;
 	runtime->silence_size = 0;
 	runtime->boundary = runtime->buffer_size;
@@ -1062,7 +1062,8 @@ static int snd_pcm_sw_params(struct snd_pcm_substream *substream,
 		runtime->period_step = params->period_step;
 		runtime->control->avail_min = params->avail_min;
 		runtime->start_threshold = params->start_threshold;
-		runtime->stop_threshold = params->stop_threshold;
+		/* Drivers may sample the stop policy from completion context. */
+		WRITE_ONCE(runtime->stop_threshold, params->stop_threshold);
 		runtime->silence_threshold = params->silence_threshold;
 		runtime->silence_size = params->silence_size;
 		params->boundary = runtime->boundary;

-- 
Git-157)


