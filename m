Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794182116;
	b=Ue4ogvA1YtMe3oieoBiW9EiQEUJXFOZyAvkOFhgUp7AFmiBPnEgcF0POFsHZ2FCB334T
	 S009hmUpMZUb9x/UV1qBOci11BJIAazzejvjfOB1X8/CTZC0HT5IZeP05FXdPOX2XnXcS
	 8YTwsaqcaQreGSJQbDUcw5NYpw7Rz2LV/683fXZ8cXOL/LeyD+jY2OWvw+kSN8WnVMUw7
	 S5j6f7r1H9hWQOBn3mGy4CLsNI7LkabE7DNxtNfScxHn0iYKVQP0g9zajvg9EXlKYH7DV
	 3z82KebDQ+rqWfGzCRfPmhjVB5rdJorj9lcHBPHMlDWkc/QERcn6O9Aojb3vadLWCnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794182116;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ipAq0GFpqeILnCbmHOCNtPSgE8BRxRY1/yFPd6rARKE=;
	b=SYuy6qjeN5WYgcV1nU/iY+mK3LW8huDYHLmvISoJ2BomD3QSjJDZ2pL2lLo1gth+nMOu
	 NY19PlA33hGW2X2DqenXCCd52+o5zJYNroFxWYH4wR92kDJ59hnfCmmYTx4IhoXk1LY0Q
	 7SFC46Yz2cHF2twOC7Q7uKMBs1PjNsY1/ikA88OLLF+G6X8jyrqRUyNvjNZVo6NpC5UEh
	 pG6nAnanruIc/FosCPQVmiiTNvH5Lk6m7KdfWovXi0BDh0e9Loqt+DYNupWoe9GsSndXf
	 MXg2M+8NpSvIpqvLrHnD7VyGmwO8e3VBO8oVhJTL1E2UXnQPxjO8+L5/zpj0rYiXPQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xP1FIn40;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7991606D802
	for <virtualization@lists.linux.dev>; Sun,  8 Nov 2026 23:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7991606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xP1FIn40
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e9ae391a05so1493065ad.1
        for <virtualization@lists.linux.dev>; Sun, 08 Nov 2026 15:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794182115; x=1794786915; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ipAq0GFpqeILnCbmHOCNtPSgE8BRxRY1/yFPd6rARKE=;
        b=xP1FIn40hsFcnD3zd2eq/1LVOFXGpnUgQrTE2aMFur9wyc/8C7qCAJ2CgNFR+s+y9T
         x6xLSMZeQvzX25hGKbwco5Ix3+uI2L0oMYVpLh8ENwkqXPqzsLFphNt8oWKJgTUSFcZL
         8VREmDMnTAtqGvdgJWyH71qCQ0p81jb4hSEkWb8qIAoS7XUs8PakKp+v+GyCkpsfMgj+
         FW81ae1i0iVhHILwn3op10RMccAgqE0g0efev7Cy5Z3LJtb56Cip2qzFBtp1lHJPGHPB
         09TkgUUvJphHEZl5TJHh4g2QSkuXKf13YIOTx5KQ+Ip68Iew/7GxjYUhakWaVOWtS+Eg
         iruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794182115; x=1794786915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ipAq0GFpqeILnCbmHOCNtPSgE8BRxRY1/yFPd6rARKE=;
        b=vdBJFs2qbhUplVD5Gows+5lLkG5FOhpLeorElkCTA7Zfx0o4c2TMILGhw6OUfXajCY
         yCE/yqVpV9LLMzlDmoFMdnpUn8mPCxmAsiUxegUf+zCN9bVKZgngIU9IhtBHvzcOQfdx
         Rqov53UMqHfyONssiciD6/Ou0NB8FC3+217EL127opiQxkwLYjnES8eGF5lgJmMZRHdn
         k53fnOa9sJLOTFsIN+2f5T4u0FDQiMCeXa79CV0WKv+mvFD83IoC3/Qvh6CMAaZrHzKQ
         Qk2YhVikrqfdDod7zDYW/4EjkXERjRO9LRsL0PUXvhGkv7vhr46UN7jyLqm9EKijStiU
         cLNA==
X-Forwarded-Encrypted: i=1; AL+hErFaX8dnurH5PPDNsO1ViYKN5YJ1dlQ130h3iiAhdALWMbbXAnLWf0U3WzTQJorCMMg95XNFVEWaezivCxwofQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+8o36GygsgKS6Hgwome4+H4I2rnlv6ySDh47FgNIHVXPAO16hh
	EmGSEz5fEkiqzxzrT/J317aFjqIOKr9tBB/HA3NhC74I91jyNnSuoG6l
X-Gm-Gg: AYBFou3SRalwgRws1SLdGAbTQc9JzOGGHs2ycif25h+8toVqVeyNVV/Bv22zXy1onwb
	chXyBOtW2ZkILxaQm8U2VhpFR0Lkn9EcisZHF99GsVouHlPEHpTZ+y0APcTEsDTeD164vGojTrt
	/4RATCyLWCAW9YnZ0kBeWauk3AVywGn+6oVybLdP8QRvjDzR4H0O8ioCXzKarg0RKDjMDy1q38k
	TjtJw0BRRp8l/PK0Wmsqd5zBNE5RmguW5Y4scMCj6LIkeh4x6eQubb39zxCcNOZPiA/VHxwtQ73
	ToVn1NGJCBBaA+16OAWYIupXNkDgKU/JEL3xLObLUbygntu94uSEYz0xQ+KEsd01abWM+z0pWhG
	xHOvtjojK7dE4pGFk8VEx45CCkhHy4iMr07aYcTTURA7L+e8qJWji9IMcZI3g3jgUH6mlikOdkS
	U5bsoRqim6WRlvCV6pw4Je/8GgHeEoGBZ9kQJIk0f85uN8ia0/8BAupV1SKP2BlTCirw7ZFKkMQ
	mC+LeOmzo+QwCDrqCt9ecyPZYNI0jJWDDNllV+FiIO8BBQhHsMWr1bJZxat2LiNdNBof7LYbcQW
	yknKBvYUQKw1gvN27sbWRyLvir4grwJFUkMloqXOqz/u+J8cJaa0yiHHrptX1Mtj5tVKmrkSXx/
	jUGg9iQOa+Q2l0y3YogYxadlNRKfkCMfv3Q6ELW6rzMe+Hgc=
X-Received: by 2002:a17:903:acb:b0:2e9:93b7:23fc with SMTP id d9443c01a7336-2ed6809d0dfmr37072905ad.17.1794182114866;
        Sun, 08 Nov 2026 15:55:14 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed81722edesm6095215ad.55.2026.11.08.15.55.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Nov 2026 15:55:13 -0800 (PST)
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
Subject: [PATCH v21 02/12] ALSA: pcm: report partial progress under the stream lock
Date: Mon,  9 Nov 2026 08:54:47 +0900
Message-ID: <20261108235457.12688-3-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261108235457.12688-1-mynameisjune111@gmail.com>
References: <20261108235457.12688-1-mynameisjune111@gmail.com>
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

Staged capture can make readable data available before a complete period
has elapsed. Skipping notification leaves a blocked reader asleep, while
using the period-interrupt path for this event can infer a false ring
wrap when the notification is delayed.

Add snd_pcm_progress_under_stream_lock() to update the hardware pointer
through the non-interrupt path and notify readers and fasync listeners.
It runs under the caller's PCM stream lock and does not tick the PCM
timer. The driver must release its pointer and trigger locks before
calling it. Existing period notification callers keep their current
behavior.
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
include/sound/pcm.h  |    1 +
 sound/core/pcm_lib.c |   19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -1182,6 +1182,7 @@
 int snd_pcm_lib_ioctl(struct snd_pcm_substream *substream,
 		      unsigned int cmd, void *arg);                      
 void snd_pcm_period_elapsed_under_stream_lock(struct snd_pcm_substream *substream);
+void snd_pcm_progress_under_stream_lock(struct snd_pcm_substream *substream);
 void snd_pcm_period_elapsed(struct snd_pcm_substream *substream);
 snd_pcm_sframes_t __snd_pcm_lib_xfer(struct snd_pcm_substream *substream,
 				     void *buf, bool interleaved,
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1919,6 +1919,25 @@
 EXPORT_SYMBOL(snd_pcm_period_elapsed_under_stream_lock);
 
 /**
+ * snd_pcm_progress_under_stream_lock - Report progress without a period IRQ
+ * @substream: PCM substream
+ *
+ * Context: PCM stream lock held, with no driver pointer or trigger locks held.
+ * Updates the pointer and wakes readers for partial-period transfers. Unlike
+ * a period notification, this does not imply an elapsed period or tick the PCM
+ * timer. The same pointer, trigger and timestamp callbacks may be invoked.
+ */
+void snd_pcm_progress_under_stream_lock(struct snd_pcm_substream *substream)
+{
+	if (PCM_RUNTIME_CHECK(substream) || !snd_pcm_running(substream))
+		return;
+	snd_pcm_update_hw_ptr(substream);
+	snd_kill_fasync(substream->runtime->fasync, SIGIO, POLL_IN);
+}
+EXPORT_SYMBOL_GPL(snd_pcm_progress_under_stream_lock);
+
+
+/**
  * snd_pcm_period_elapsed() - update the status of runtime for the next period by acquiring lock of
  *			      PCM substream.
  * @substream: the instance of PCM substream.
