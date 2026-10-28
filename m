Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180533;
	b=uCB69W/46IKrCRqJ62cpxKLq/41wc77IleZxaGFQGgwlma14ntt9D3+yVIXTuYX2xB8p
	 k8faDq7ppkG61UYOsXgt/mY46xgzLdOCh5vkgSWiVLOIZxZO0yOF9czfpqSq/8+G3zTGp
	 thMCacSauNgKAoxlQo1q0uS8/6F+Pwf4JCumPJOzoSXXRBNbCEtMc2Rw32zES2pYR8V17
	 RmAlG437GnHt9kZwC7Gno5xEi9k3xyW2jhV7kCBsypmfR/72ysCj/qpuMzQuhsPzPwhUU
	 QKTsUYovwE5PTlAKG6ev3h5UZmKZicY7KX9kMdWSsRp0wIEn1CNT7isU+TQftkDEJpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180533;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1SSKD9R3/tZDll832XAf/4iUolviOcI2RSxt/Z/hu94=;
	b=J7/RXAiW9UXv/fSNMNPxbHqem45RAQFkXUk5eFA/23nLNnPZ6ZZNX0GSHmjhpQN7HT7d
	 JHgcn/JSg6KH6a2bwnQq4qrT1iSv/X9cfFkb4DAv7MVGsFHReJVHtBtpttNzBqSMw3Ybn
	 +5sc2CaDhZl+r/dIcfr0GzArXVVAR9wiKF0bgxEI2/S6U11sMYm1u7IDkw2zcdcItAvXU
	 bnhZRfYt84dWqhg64WX4IFOHsu1xSLl+Y89Qqi8XU8jmZctgWpCTaMruFXQ/nSCWcLzMd
	 OfMdM0NkgOzrW3DokIL+1xLf6VQBqYg5Q+1Uin3uQlbXjRkVHiKD2qTjRSxdwAZiXvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NCnlDplh;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4AD606A33A
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 09:42:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E4AD606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NCnlDplh
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3a4b3ac8fb7so470925a91.0
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 02:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793180533; x=1793785333; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1SSKD9R3/tZDll832XAf/4iUolviOcI2RSxt/Z/hu94=;
        b=NCnlDplhowGwfLFsy1H+O1CI75iz9+8rbMzusMKICl4rZPj9fHenjo3+F956fRicpY
         2LMGDArEDfeT4AsMDTw0RCtPg3oDv/IsHH8zSxXTmKkByxWPllnanzzug6qEbgqP7r30
         ZuQuM6DJKAlH332MA/ooTc6SNyeElWc8aG4OOt6SR0vH/6ZawYcYl98/psVEi59ygeq0
         Cvh6jK0+0ZIn+ACY7bSSNUdu7uqG/7xstexRbOrc5ad6MNsfp8ujqI8UR7ir6xIouNOc
         DY3A18QTxR0LHST6Yi0UgEoSXsebqFyJcVtdMqnw6bOhMGxLBKrEW4P/dKGKg/oxT/bH
         FQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793180533; x=1793785333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1SSKD9R3/tZDll832XAf/4iUolviOcI2RSxt/Z/hu94=;
        b=Rlht6+0fSqabse/HpFXQ+HYE5lfoQwi/O7SHXIx0EUpYT6HBseHOWmL/u40weM0g+Q
         0k79ZoPXJQcMjLATyY7F4lcmmmq/CKOtRbE5uwMYn/DMEmK0WukBJEmYxlm6rj5XIWXr
         BjvK7rrKYxYJMLij+vTfuCCbFvG9fkeG3eHq64xEleSnR8q4nY+yP3zI/xyELeDUzgmE
         rVT+CCavIBZ8gg4P5ZmIQWaOczphRZv4iETUvtmiUk1l4b+kUe7olOkMANvusmhzQZKB
         u0u8z34jtobRqxteJ8DnlgDQCWgq2BEILDo6a0nnQLFHJZHKq4RzPsY6AdTSqH7cA+zO
         TivQ==
X-Forwarded-Encrypted: i=1; AKwUvByN7Os4RARx5RlUWrI+aD/q1t4uIMEcH+g3qXgnR1AVzMZqYVfuFavtHECcc8rZTfqTuLXxxJ6IAGnIXDwTGw==@lists.linux.dev
X-Gm-Message-State: AFq9FYLD521C0ko0h6qAcrdpY35t5XHorSfTf8pSv9Ha1Sk9ohnkL5aD
	ocfZwkJeih8GWaD9BQVRXc9tzcpgdsjKlFNiCCHpSKC/+dUqPgTWmkrw
X-Gm-Gg: AYBFou04VQqwV5tHf+lkPnv5lNxZuZoneelCM9sr4bgEyMoDOg9ECjefo8zkYQTaAh9
	kTcUNNEfeCgcN6BaWeB3In9ilqz5VsLX5qiZhqr7U/01050O4jTI1EsluCIbP3i/FehEUN+kncY
	rLpFpuSECdPIPGTQ1yPc9jXpvsEEfAHHPLh9gN6/GMCZHsE5MSMlZBc/iHEm7vO8oFgH/S7KqAp
	eiQeKx184XbiEQyvgN3qzwN3ox7Fta8SDZE+tWT6k3srcM0Ejd4yitwOTNRoNGDukuaUCNaEbas
	NlYCGhX4gWY4zQohHg8oHG2fsTHcusb7E2JELcsPNv30XexV3RxH+WaxRJr2E4tONxtPYaR4fRg
	qgc6TRfQ49uF0Z+yB7Xt0s1dTHrehCJp3PZ8wWtwsIGMA+Ld0j8cQATiqZpzYf74ruJdEo/Unpn
	RtHLvaUJrBnhvM4lPEaizhRSO5FwzCf4GNsiYCGGhrbx/IlmTZ+Hl9XxwogESx3rL95vZeMpk77
	IOREqQ/XqCJTdAbrDZjmVm5daX1Jkcfp/892YWGxwEdKrwctQ9DwhkrNLBpou2s7TOwx4ZyTbJj
	uwvZA3rWfhbE66UzMJgFwki0p9FBt8YmAzft2SJO03mz8whVL2PIDBvpo8yJPL2+w//qPQ/nW9J
	DKEb5bXd4pAFZv/FLT0HckRxPBz/VL5nKhplHILW35/qvYo8=
X-Received: by 2002:a17:90b:2705:b0:3ac:9717:afd1 with SMTP id 98e67ed59e1d1-3ae58319466mr1220106a91.63.1793180532909;
        Wed, 28 Oct 2026 02:42:12 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a93b3f5sm2242377a91.5.2026.10.28.02.42.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 02:42:12 -0700 (PDT)
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
Subject: [PATCH v7 09/16] ALSA: virtio: prioritize staged capture period work
Date: Wed, 28 Oct 2026 18:41:25 +0900
Message-ID: <20261028094132.20364-10-mynameisjune111@gmail.com>
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

CPU contention can delay staged capture period notifications while RX
completions continue filling the unread ring. In a two-vCPU VZ guest with
16 nice-0 CPU workers, the ACK-fixed baseline stopped with ring_capacity
and EPIPE in three runs, after 11.74, 30.77 and 30.33 seconds of audio.

Route staged capture period work through system_highpri_wq with a common
helper at all ten producers, including ACK errors and self-requeue. Keep
playback and non-staged streams on the normal workqueue. Initialization,
cancellation, buffer geometry and capture accounting remain unchanged.

With the same kernel, input, geometry and userspace priority, the candidate
completed three 70-second captures and immediate reopens. Its maximum
matched queue-to-start delay was 20.366 ms, versus 108.112 ms in the first
baseline failure. The other baseline failures had pending work without
matching execution, so matched-only statistics do not bound that delay.

Reader scheduling delays were also present. Both arms passed a separate
nice -10 reader control, and host load varied between runs. These results
support the change for the tested workload without isolating a kernel-only
cause or guaranteeing lossless capture under arbitrary CPU load.
KASAN/lockdep QEMU regressions passed with the unchanged candidate source.

This follows the staged ACK fix and pending VZ capture support. The
introducing staged-capture patch has no upstream Fixes commit ID yet.

Link: https://lore.kernel.org/all/rfc-v2-vz-capture-compat-1.b9ab4c1540dc4691@gmail.com/
Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>
---
 sound/virtio/virtio_pcm.c     |  4 ++--
 sound/virtio/virtio_pcm.h     | 12 ++++++++++++
 sound/virtio/virtio_pcm_msg.c |  6 +++---
 sound/virtio/virtio_pcm_ops.c | 10 +++++-----
 4 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
index a3478fc8848db..d8515b2144a14 100644
--- a/sound/virtio/virtio_pcm.c
+++ b/sound/virtio/virtio_pcm.c
@@ -397,7 +397,7 @@ static void virtsnd_pcm_period_elapsed(struct work_struct *work)
 	}
 
 	if (requeue)
-		schedule_work(&vss->elapsed_period);
+		virtsnd_pcm_schedule_period_elapsed(vss);
 }
 
 /**
@@ -606,7 +606,7 @@ void virtsnd_pcm_event(struct virtio_snd *snd, struct virtio_snd_event *event)
 			if (vss->xfer_enabled) {
 				vss->xfer_xrun = true;
 				if (vss->capture_staging)
-					schedule_work(&vss->elapsed_period);
+					virtsnd_pcm_schedule_period_elapsed(vss);
 			}
 		}
 		break;
diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
index e143a15592f05..5d1d88f2823b2 100644
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -8,6 +8,7 @@
 
 #include <linux/atomic.h>
 #include <linux/virtio_config.h>
+#include <linux/workqueue.h>
 #include <sound/pcm.h>
 #include <sound/pcm-indirect.h>
 
@@ -114,6 +115,17 @@ struct virtio_pcm_substream {
 	wait_queue_head_t msg_empty;
 };
 
+/* Keep non-staged PCM notifications on schedule_work()'s normal queue. */
+static inline bool
+virtsnd_pcm_schedule_period_elapsed(struct virtio_pcm_substream *vss)
+{
+	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
+	    vss->capture_staging)
+		return queue_work(system_highpri_wq, &vss->elapsed_period);
+
+	return schedule_work(&vss->elapsed_period);
+}
+
 /*
  * ALSA may observe a subperiod tail before its period callback. Keep actual
  * unread occupancy separate from pointer observations and notification state.
diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
index 795e52e09564b..663f7695b5be8 100644
--- a/sound/virtio/virtio_pcm_msg.c
+++ b/sound/virtio/virtio_pcm_msg.c
@@ -627,7 +627,7 @@ static void virtsnd_pcm_capture_xrun_locked(struct virtio_pcm_substream *vss)
 {
 	if (!vss->xfer_xrun) {
 		vss->xfer_xrun = true;
-		schedule_work(&vss->elapsed_period);
+		virtsnd_pcm_schedule_period_elapsed(vss);
 	}
 }
 
@@ -720,7 +720,7 @@ static void virtsnd_pcm_capture_complete(struct virtio_pcm_msg *msg,
 			virtsnd_pcm_capture_xrun_locked(vss);
 		}
 		if (got_audio && !vss->xfer_xrun)
-			schedule_work(&vss->elapsed_period);
+			virtsnd_pcm_schedule_period_elapsed(vss);
 	} else if (!vss->msg_count) {
 		wake_up_all(&vss->msg_empty);
 	}
@@ -858,7 +858,7 @@ static void virtsnd_pcm_msg_complete(struct virtio_pcm_msg *msg,
 		runtime->delay =
 			bytes_to_frames(runtime,
 					le32_to_cpu(msg->status.latency_bytes));
-		schedule_work(&vss->elapsed_period);
+		virtsnd_pcm_schedule_period_elapsed(vss);
 	} else if (!vss->msg_count) {
 		wake_up_all(&vss->msg_empty);
 	}
diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
index 85e7576903d56..d50924b792f65 100644
--- a/sound/virtio/virtio_pcm_ops.c
+++ b/sound/virtio/virtio_pcm_ops.c
@@ -232,7 +232,7 @@ virtsnd_pcm_pause_restart_fail(struct virtio_pcm_substream *vss,
 				VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED;
 	}
 	if (notify_xrun)
-		schedule_work(&vss->elapsed_period);
+		virtsnd_pcm_schedule_period_elapsed(vss);
 	vss->substream->runtime->stop_operating = true;
 }
 
@@ -1253,7 +1253,7 @@ static int virtsnd_pcm_capture_staged_ack(struct virtio_pcm_substream *vss,
 			return -EPIPE;
 		if (!virtsnd_pcm_capture_counters_valid(vss)) {
 			vss->xfer_xrun = true;
-			schedule_work(&vss->elapsed_period);
+			virtsnd_pcm_schedule_period_elapsed(vss);
 			return -EPIPE;
 		}
 
@@ -1264,7 +1264,7 @@ static int virtsnd_pcm_capture_staged_ack(struct virtio_pcm_substream *vss,
 		if (diff < 0 ||
 		    (snd_pcm_uframes_t)diff > runtime->buffer_size) {
 			vss->xfer_xrun = true;
-			schedule_work(&vss->elapsed_period);
+			virtsnd_pcm_schedule_period_elapsed(vss);
 			return -EPIPE;
 		}
 
@@ -1275,7 +1275,7 @@ static int virtsnd_pcm_capture_staged_ack(struct virtio_pcm_substream *vss,
 				       &next_acked_total) ||
 		    next_acked_total > vss->capture_copied_total) {
 			vss->xfer_xrun = true;
-			schedule_work(&vss->elapsed_period);
+			virtsnd_pcm_schedule_period_elapsed(vss);
 			return -EPIPE;
 		}
 
@@ -1292,7 +1292,7 @@ static int virtsnd_pcm_capture_staged_ack(struct virtio_pcm_substream *vss,
 			rc = virtsnd_pcm_capture_send(vss);
 			if (rc) {
 				vss->xfer_xrun = true;
-				schedule_work(&vss->elapsed_period);
+				virtsnd_pcm_schedule_period_elapsed(vss);
 			}
 		}
 	}
