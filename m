Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365878;
	b=bLw9MXsG2uN9cBawpBa9cVFdAGFi4JTgtKMHDl/cxbe6CIwU38NzRWk8mfPHqnW+2qOn
	 LlkEEfItU4zRCPf/v5tPYFtALeUdNkOfiblxn0ADmSnEf9CR4s92FdoPqFtfHwwb6VOiT
	 bisH68T0BWpPv4x2EFDfUWkPt9UN9NxgCkR5aJ20v/QN5Q+q5+CWSch3Ibe3x0gd5lsUV
	 YENvI6IKB4rejNC4XmRxmBItWKHC7xuxenUDGcUvB/AxHf9l0Mgvt04QZxM4ifTV7FU19
	 XT/wJVHqbrlz/f46gx/k2woOoBlqNFwY5s9DVRsugeNGvm1yNMfv4LV35HaNg6J5EWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365878;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jy4K+1GPAbkpD0UdYh2XMFqYJy9GKlqwMFTip7Xat8w=;
	b=glmYl3bkLfeqz3hoeQ3ZCQX16rGh5isqGgapkb5Hpo1C8YZOgQYaxkVDmHDAQtl4CJTy
	 tgX6RCiKGPwDBrQYzXfOMxOH46PK0riana6VSHR/S8cKkbrJhG+2v6+e3/wVPMXh/WcWx
	 RUUiaSo5ahsga1bhdOHVs+2RipjI0yrqkFU16DGUSd6Us/oImPlZOzN8OfgAlcQbTpvRL
	 4eWH9MU3M5SHwCCdm1g9QTN6q5l5gdRRQZzYtVZOnZe9yce7oddldufD3Wf8tfM8T3mQ6
	 L7BYIa9+xjXoWRwAaCYrx/1UmcI7oUE0DqSibAgyLFwbZ7efOh50h2wkcW0sthqK0GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wummuc6n;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9055D60A5BC5
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 02:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9055D60A5BC5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wummuc6n
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-37071c0f42aso4764565eec.0
        for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 18:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794365878; x=1794970678; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jy4K+1GPAbkpD0UdYh2XMFqYJy9GKlqwMFTip7Xat8w=;
        b=Wummuc6nztrmzNn9ZPieCLdzFrzH5IMG97H2mD0JiNwW3+5zqaQRC+AQRV+/iy/xVE
         cKDKYaJkvlbfwPILMRqMsNNcUYMr/dA6ugc+m0D2l3bSAlIe7CZ+IiLA4e4ZtY4YkOsR
         ktn9lueuFyXLGgNUVLUz3o0jhKbG2o243B41mmlTqGA4y3rwZ+xAx0xHXRmpHp1XHoo5
         oTY0XhU8qAMGHHVuFGHbRDsydauYhSas1/j9ebqWOaa+kkSPL7PHavvcc3XP38Ud5W4c
         kY81HjqS1aWplPdzIA8LJK3W+Fh1thz+V/kfhBdEY10MRoom7cLibpEsjJRKbYjkhvcE
         VV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794365878; x=1794970678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jy4K+1GPAbkpD0UdYh2XMFqYJy9GKlqwMFTip7Xat8w=;
        b=gBH1wQGvyXjZEgjodCNU5OKrob8+9wZn5UTLqy73mqkIHyNZRaMr2pKhFIvbb2hDFI
         Zfzl1XTsd/+7Npr7i3TNmOatucv6S7e2w9Ahv1YB1E4NNOHvLOybMxBJ2iy8UG7yXvbb
         /5/ko2IeidZqbi8JpO3gX+6PFUISfKsKwcRMCPBGz1E912kEwp3ClFZ2GMRDDyvZZmkP
         e0dktScb9Sfp7l/MxaenmKWxOtmr+idScFYxdhq2HVp1loxVfthCEvZKxxfyfFatytF4
         WIwhVf9wjsk7nz7jKgN9KuXraWnpzHu0CmFC6/xs2M+ICQHAzsU1Hu7IWI7y4X3haDNY
         DhiQ==
X-Forwarded-Encrypted: i=1; AL+hErGygK0XA4Yafa1nLqFlzNnFBzpp1ixTSyMFu/JHlflc0eleB6hPA3CrQTuTuK80Y6GlzwX/kHYvILlelXqPJQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+jDiVT6WowQEj8jkQtRwDb8TCLHo85xlyURNDJAqSBL77uhzwZ
	dL+ZYuZFa8HHGPm9dGBzdPM6nUwgzXIBxvjDSGkDNomBNsT6WrjqQPth
X-Gm-Gg: AYBFou0oCMcQvFOvKf6qH6VVF1CPJ3YPX2enbxGiltM337lexCbIpF2bhHln39S//Bd
	wfrDtSF20AJVGRqQ1eJwlofWCo37fPC1J9LfRfoJmDDgvWwEB92Y4ICj82Q+7AAmnJjs7lEEXID
	y9lhBf61yyn80wZdR8WDSxUbu6WQyPq5jH9as01m5GONeS/oUlDYdwWEDXygGvoYLUs6eecb2Ji
	z6HUouSWaLJDea43W93wh4yxMTiiHNSgogTuEub3hhbzTxCU50raJdtfrviZHYaAdgvGXCdRkUA
	RbtZfJdmTBWDJQoesqZrExsZ2tHJNQKUlL39qu5spVRuSQu8Lvq4MFVP9hMNDILW/gKJAvqyiTN
	2EDg0hp7m86LV+MfwHriATNwOLsT56QjPgltZA5dMeJNdxCVNOd36TQ/QpJs/G27L0P7UkFOdJJ
	BlHYVeqr1XWQqsEXjDgzHgrbqAyGck8uSACVE2lg2wg9fZfGIB7DJLltXwtDaSyzmUoQwmottpA
	gIW9MJEwnVN4SNSewlfLP1egnbCH7e2ShIhKhDPhd76fKNsvaWyVr9QEckluRIcZPT8fVkAu/ir
	R57CVD6pWN9006QzxuJmE1RfX2gyC0pb8g4ef9j5Gfxh3Fum3Vz5/naZ9w+AlwMwM2nkn9ITHTB
	8gPDAT3/NUdg7rrx0j8+7F8fjesBjOeeCYItAee3BXY+yFro=
X-Received: by 2002:a05:7300:bf91:b0:372:fa14:8b6c with SMTP id 5a478bee46e88-37685d7532amr1915024eec.19.1794365877628;
        Tue, 10 Nov 2026 18:57:57 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfc6sm12390018eec.17.2026.11.10.18.57.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 18:57:57 -0800 (PST)
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
Subject: [PATCH v25 16/16] ALSA: virtio: preserve playback progress across pause
Date: Wed, 11 Nov 2026 11:56:55 +0900
Message-ID: <20261111025655.63951-17-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261111025655.63951-1-mynameisjune111@gmail.com>
References: <20261111025655.63951-1-mynameisjune111@gmail.com>
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

TX completions can arrive after PAUSE closes transfer admission.
Preserve that progress and schedule catch-up when the stream resumes or
a rejected pause restores RUNNING. Cache device latency in stream-owned
state so a late completion does not need to dereference the ALSA
runtime. Clear both the cache and runtime delay on prepare and before
RESET observes the hardware pointer.

Use the existing indirect hw_queue_size to keep outstanding TX below one
physical ring: buffer_bytes - period_bytes. Equal modulo cursors then
mean no unobserved completion, and a non-interrupt HWSYNC cannot consume
a hidden full-ring wrap before deferred period work. Continue using the
ordinary ALSA pointer update for silence, drain, stop-threshold and
wakeup policy.

Check for pending progress or a latched transfer error again in the
period worker under the PCM stream lock. A queued notification can
outlive a paused RESET or an earlier pointer observation. Calling the
period helper without new progress after resume can turn equal cursors
into a false wrap when the core has backdated its pointer timestamp.

This reduces queued buffering by one period. With two periods, only one
period can be queued. Worst-case scheduling tolerance needs
qualification.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
sound/virtio/virtio_pcm.c     |    3 +++
 sound/virtio/virtio_pcm.h     |   10 ++++++++++
 sound/virtio/virtio_pcm_msg.c |    8 +++-----
 sound/virtio/virtio_pcm_ops.c |   19 ++++++++++++++++---
 4 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
--- a/sound/virtio/virtio_pcm.c
+++ b/sound/virtio/virtio_pcm.c
@@ -338,6 +338,9 @@
 	}
 
 	if (vss->direction != SNDRV_PCM_STREAM_CAPTURE) {
+		/* Ignore stale work after RESET rebases the playback cursors. */
+		if (!virtsnd_pcm_playback_progress_pending(vss))
+			return;
 		snd_pcm_period_elapsed_under_stream_lock(substream);
 		return;
 	}
diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -53,6 +53,7 @@
  *        substream operators, including @stopped.
  * @buffer_bytes: Current buffer size in bytes.
  * @hw_ptr: Substream hardware pointer value in bytes [0 ... buffer_bytes).
+ * @playback_latency_bytes: Device delay cached independently of the ALSA runtime.
  * @capture_ready: Managed-mode bytes copied but not yet acknowledged by ALSA;
  *                 always zero in free-running mode.
  * @capture_boundary: ALSA boundary captured for this prepared epoch.
@@ -113,6 +114,7 @@
 	bool resetting;
 	size_t buffer_bytes;
 	size_t hw_ptr;
+	u32 playback_latency_bytes;
 	size_t capture_ready;
 	snd_pcm_uframes_t capture_boundary;
 	u64 capture_copied_total;
@@ -179,6 +181,14 @@
 	return schedule_work(&vss->elapsed_period);
 }
 
+/* Caller holds the PCM stream lock so RESET cannot rebase these cursors. */
+static inline bool
+virtsnd_pcm_playback_progress_pending(struct virtio_pcm_substream *vss)
+{
+	guard(spinlock_irqsave)(&vss->lock);
+	return vss->xfer_xrun || vss->hw_ptr != vss->pcm_indirect.hw_io;
+}
+
 /*
  * ALSA may observe a subperiod tail before its period callback. Keep actual
  * unread occupancy separate from pointer observations and notification state;
diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
--- a/sound/virtio/virtio_pcm_msg.c
+++ b/sound/virtio/virtio_pcm_msg.c
@@ -1002,12 +1002,10 @@
 	/* Keep latched errors until prepare establishes a fresh epoch. */
 	vss->msg_count--;
 
-	if (vss->xfer_enabled) {
-		struct snd_pcm_runtime *runtime = vss->substream->runtime;
-
-		runtime->delay = bytes_to_frames(runtime, latency_bytes);
+	/* A queued request can outlive the ALSA runtime after hw_free. */
+	vss->playback_latency_bytes = latency_bytes;
+	if (vss->prepared && !vss->preparing)
 		virtsnd_pcm_schedule_period_elapsed(vss);
-	}
 	if (!vss->msg_count)
 		wake_up_all(&vss->msg_empty);
 }
diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
--- a/sound/virtio/virtio_pcm_ops.c
+++ b/sound/virtio/virtio_pcm_ops.c
@@ -770,6 +770,13 @@
 		memset(&vss->pcm_indirect, 0, sizeof(vss->pcm_indirect));
 		vss->pcm_indirect.sw_buffer_size = vss->buffer_bytes;
 		vss->pcm_indirect.hw_buffer_size = vss->buffer_bytes;
+		if (vss->direction == SNDRV_PCM_STREAM_PLAYBACK) {
+			/* Keep unobserved completions below one physical ring. */
+			vss->pcm_indirect.hw_queue_size = vss->buffer_bytes -
+				snd_pcm_lib_period_bytes(substream);
+			vss->playback_latency_bytes = 0;
+			substream->runtime->delay = 0;
+		}
 		if (vss->direction == SNDRV_PCM_STREAM_CAPTURE) {
 			vss->capture_boundary = substream->runtime->boundary;
 			rc = virtsnd_pcm_capture_refresh_mode_locked(vss,
@@ -1197,7 +1204,8 @@
 		}
 
 		if (running) {
-			if (vss->direction == SNDRV_PCM_STREAM_CAPTURE)
+			if (vss->direction == SNDRV_PCM_STREAM_CAPTURE ||
+			    virtsnd_pcm_playback_progress_pending(vss))
 				virtsnd_pcm_schedule_period_elapsed(vss);
 			return 0;
 		}
@@ -1219,7 +1227,8 @@
 				return -ECANCELED;
 			vss->device_running = true;
 		}
-		if (!rc && (vss->direction == SNDRV_PCM_STREAM_CAPTURE))
+		if (!rc && (vss->direction == SNDRV_PCM_STREAM_CAPTURE ||
+			    virtsnd_pcm_playback_progress_pending(vss)))
 			virtsnd_pcm_schedule_period_elapsed(vss);
 		return rc;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
@@ -1260,7 +1269,8 @@
 				virtsnd_pcm_trigger_failed(vss, epoch);
 			} else if (virtsnd_pcm_start_queue(vss, epoch)) {
 				virtsnd_pcm_trigger_failed(vss, epoch);
-			} else if (vss->direction == SNDRV_PCM_STREAM_CAPTURE) {
+			} else if (vss->direction == SNDRV_PCM_STREAM_CAPTURE ||
+				   virtsnd_pcm_playback_progress_pending(vss)) {
 				virtsnd_pcm_schedule_period_elapsed(vss);
 			}
 		}
@@ -1610,6 +1620,7 @@
 		}
 		if (!paused_pointer)
 			hw_ptr = vss->hw_ptr;
+		runtime->delay = bytes_to_frames(runtime, vss->playback_latency_bytes);
 	}
 	if (paused_pointer) {
 		if (defer_work)
@@ -2213,6 +2224,8 @@
 		guard(spinlock)(&vss->lock);
 		if (vss->msg_count)
 			return -EBUSY;
+		vss->playback_latency_bytes = 0;
+		runtime->delay = 0;
 	}
 	vss->indirect_reset_observing = true;
 	rc = snd_pcm_lib_reset(substream);
