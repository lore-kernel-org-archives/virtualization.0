Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793144664;
	b=YMP9vJ74+yxeYtLdzMHkBenCMWXq1poe9NjVJTpt+TOlrHySusNBxTkylwCHOsK9v3E+
	 1l9qlANNCoUdgBlSDRfeUUZD9eUuRZLxN0dpRttdfgPEDNRg2vKKXsS1tE3WVCsemyEhJ
	 RUB0YEmHlrb/g9OZmvQ+YeCIBqvYiTWmYKLvOBEbU+i1AUaIVdHn6SnTQFpJVPb9LNwZM
	 mXQknGPZ9Q4/j5RTvwWc2XasLCRH6JsoukxyO/mPBZKspdyujgjDclvYGa/g69haMambl
	 jiDlwa4JLdTvNR9V+YrrJK8np+dMQdLOTnaMri08HAqSAHPqgiK5BbeWAbeH881X3zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793144664;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6eYi7haKrUUz5ppcKTnEsRmfpDKe/7u+K3cLCBGytI4=;
	b=zb7wb0VhTavZc2xYTbSyPeTkLoL+740Tz1X8lrSge6TzrR5LpmUfRiwoGoDEsnf3EUMh
	 n643qGWa1PuCuqtZ96V7xPuiaxAtk/iL/95kfRGil2RCyzQYQA94psd5qEsNwKAzBorvx
	 JB9/L5+il9EmIeN8g/0ziOEJLUgoxvzGxg/dtEDsCQspGd1YKZFjIZS497v+A4/aRfPC+
	 tT2zckg5YFExH6tOvlzFzpXvIIOJ2a0JRj88EQXtKnWcChGad8+Qqm0evk0PoNNMJ0yX0
	 mWuaUXH76P2ic/gXY+9xmeWViFngKHZqTAUnVyHxbFHLKeGSeY2woTb20RuPejFKFWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WRihZVDy;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F61606A31A
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 23:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1F61606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WRihZVDy
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a070b3f44aso183407b3a.2
        for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 16:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793144663; x=1793749463; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6eYi7haKrUUz5ppcKTnEsRmfpDKe/7u+K3cLCBGytI4=;
        b=WRihZVDyzROZaZ1fDtVXUlD0TigmokR6W9+EMtuZVzXDcPRXFkncD1+sN80p+oFrl4
         gQu1XrcJjxHTm3oUDYNC6UP0nU0Suf4A4Trx/XguEVmMJ2lsIeDYmjSqLzWNSzBgYZ0c
         krgbmdvKCRFUetk0mF3ChbHup/xM3bo4k1aB6qunLr9CUbdNXhKh8VxKVI58TZRssvGV
         s0XyZOGQvZ+w8LhTEjqSpE6u9DirHpOmapAsWEtVbLYuHTcj+c1/MT5RcE4kDUNgbza7
         2anRiikFGdveXGyv2S4V6aUV02HRRio1Y0fsklZo2S1od0gqYOR0bWLjrYwRc4QeOmCt
         wVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793144663; x=1793749463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6eYi7haKrUUz5ppcKTnEsRmfpDKe/7u+K3cLCBGytI4=;
        b=cJJbY/N0+Ue147Ewlf2zQY+UpwgqHq+zDRQan0AdSKky867QOWUHt458gTILbU+9m1
         gMdImVVp4njGyGnNMgjvg6kMRRO4BQzFjEDuaHE76NF1p02YkmmuOKB6nnP40jn0DEc7
         FbHu+NlBUaVrFZIw0MBjzb+rDQzaqwfpZVL+kbXf3PATmrZYavkmn8MfovYsgkBCbbVu
         yAVu9gwVJXWrAjINXpxcpDqbQ+/5pNwD6LdgUcN37eYLxsd8PybHxohGXRGT+I0GKHi3
         5QbGWrAF2upkG3JLCFlrvFnjfxsYUiVsr2eefmKwkjLQjyemQFCVWE35w0DUD3UKsb6D
         2dPQ==
X-Forwarded-Encrypted: i=1; AKwUvBzAilNExxe80syJBw5Pij+g6ySwVUaCwHhB8fG5ixtpxEJxH8NUjJRJHhyk1oDn3DSz1/q85uouMmf42zKZ5w==@lists.linux.dev
X-Gm-Message-State: AFq9FYLAPSC+XbSrgSafTIbJ4DLksINXY888F5zgT0Cu07qpiBsCacFh
	hu0Lxv1PUklNwHsWNeg6NDBl2Bk75wmlhO19gmxhO7yvClYq6qzwT4mR
X-Gm-Gg: AYBFou1UdW5qKHsjzS3VpHVvTlx1YVQN8PnlFFYrOQS9XMiq6+qhTnS9/cBN4Mxyjvs
	nFau0zEWfITtdQWAxf94OwHP88eUN+WxdoABiu0aYCtW61OY4Usq98M+Ic1klD0UOaUR3mF5Ytf
	xEe/TY6gBmaGH3jfrJRtz8f4MmXtLV+3tvb9CfQ1hpEnMVUCIBsDem10wvKyc4DyFQ0OQFivU50
	O5sfAwz6xMjWEukD5Zg0iaEKX/2s9AjdrnFmFT3DtO+K06E87BSCrY8UzSMUdUg4zITGeHMtdac
	hmA2QFemaVdEhlCd4gYr0AYSIYlSsbHNVn7DNV9N7xDFCc1WNjdrIGaB2aniHzAz4cQ/rXSPbm1
	km39BN9ubbohYSxk2xaTXzQ70RU4HtDDYcDeJ5GllMh896yjyEvMDcwVUa8N8wknuONrtkAHh4X
	bVxPAD+m8J5aAIOMgOqK+H9qdA1n9zi0lo+6V2Hatc4yTLaMEXqkuWLErn6JEj9zAbbmZcPgfLi
	rdhYgf0N5mQReSRiPfpcPirqxREsugtJR18kxlr+c6n3MbLEvPuoeU02sDef/GM5WuDZbezRQXt
	7CL0HPL1pMuKNOixQsDhPUPO4xhlQ2enQXXxZmbOKRHLec1UmZKUW00jOqpr429N58JheT00HMr
	M5p9O/1XBrdS+TPZfIwQ=
X-Received: by 2002:a05:6a00:2302:b0:8a0:72e8:732e with SMTP id d2e1a72fcca58-8a6e6ff2f26mr515420b3a.29.1793144663102;
        Tue, 27 Oct 2026 16:44:23 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a662b9f5sm542507b3a.21.2026.10.27.16.44.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 16:44:20 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.de,
	perex@perex.cz,
	anton.yakovlev@opensynergy.com,
	mst@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Joonho Lee <mynameisjune111@gmail.com>
Subject: [PATCH v5 08/11] ALSA: virtio: account staged capture reads before RX refill
Date: Wed, 28 Oct 2026 08:43:31 +0900
Message-ID: <20261027234334.32551-9-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027234334.32551-1-mynameisjune111@gmail.com>
References: <20261027234334.32551-1-mynameisjune111@gmail.com>
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

The RX callback holds the queue lock across a batch of completions. A
reader that has copied samples can wait for that lock in ACK before its
consumed bytes are removed from capture_ready. A later completion in the
same batch can then reject data using stale ring occupancy.

Account the staged read under the substream lock before acquiring the RX
queue lock. Release that lock before taking the queue and substream locks
in their established order to refill requests.

Once accounting is committed, latch refill errors as XRUN and return
success from ACK. A negative return would make ALSA restore appl_ptr while
the driver retained the consumed-byte accounting. Keep pre-commit errors,
ring-capacity checks, and normal period-work scheduling unchanged.

Source-extracted host and kernel fixtures reproduce the stale-capacity
race and post-commit ALSA pointer rollback. The candidate preserves wrapped
data and pointer accounting. KASAN/lockdep QEMU lifecycle checks passed.
The fixtures substitute selected backend helpers and do not independently
establish physical-device acceptance.

This follows pending staged capture support, whose introducing patch has
no upstream commit ID for a Fixes tag yet.

Link: https://lore.kernel.org/all/rfc-v2-vz-capture-compat-1.b9ab4c1540dc4691@gmail.com/
Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>
---
 sound/virtio/virtio_pcm_ops.c | 128 ++++++++++++++++++++--------------
 1 file changed, 77 insertions(+), 51 deletions(-)

diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
index 003832d112551..85e7576903d56 100644
--- a/sound/virtio/virtio_pcm_ops.c
+++ b/sound/virtio/virtio_pcm_ops.c
@@ -1229,70 +1229,96 @@ static int virtsnd_pcm_pb_ack(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int virtsnd_pcm_cp_ack(struct snd_pcm_substream *substream)
+static int virtsnd_pcm_capture_staged_ack(struct virtio_pcm_substream *vss,
+					  struct snd_pcm_runtime *runtime)
 {
-	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
 	struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct virtsnd_pcm_transfer transfer = {};
-	int rc;
+	int rc = 0;
+
+	/*
+	 * The RX callback holds the queue lock while draining completions.
+	 * Account ALSA's read under the substream lock alone so completions later
+	 * in that drain observe the newly released ring space.
+	 */
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		snd_pcm_uframes_t appl_ptr;
+		snd_pcm_sframes_t diff;
+		size_t bytes;
+		u64 next_acked_total;
+
+		if (!vss->runtime_active || !runtime || !runtime->control ||
+		    !runtime->dma_area)
+			return -EBADFD;
+		if (vss->xfer_xrun)
+			return -EPIPE;
+		if (!virtsnd_pcm_capture_counters_valid(vss)) {
+			vss->xfer_xrun = true;
+			schedule_work(&vss->elapsed_period);
+			return -EPIPE;
+		}
 
+		appl_ptr = runtime->control->appl_ptr;
+		diff = appl_ptr - vss->pcm_indirect.appl_ptr;
+		if (diff < -(snd_pcm_sframes_t)(runtime->boundary / 2))
+			diff += runtime->boundary;
+		if (diff < 0 ||
+		    (snd_pcm_uframes_t)diff > runtime->buffer_size) {
+			vss->xfer_xrun = true;
+			schedule_work(&vss->elapsed_period);
+			return -EPIPE;
+		}
+
+		/* ACK includes any subperiod tail already copied to the ring. */
+		bytes = frames_to_bytes(runtime, diff);
+		if (bytes > vss->capture_ready ||
+		    check_add_overflow(vss->capture_acked_total, (u64)bytes,
+				       &next_acked_total) ||
+		    next_acked_total > vss->capture_copied_total) {
+			vss->xfer_xrun = true;
+			schedule_work(&vss->elapsed_period);
+			return -EPIPE;
+		}
+
+		vss->capture_acked_total = next_acked_total;
+		vss->capture_ready -= bytes;
+		vss->pcm_indirect.appl_ptr = appl_ptr;
+	}
+
+	/* Preserve the queue -> substream lock order while refilling requests. */
 	scoped_guard(spinlock_irqsave, &queue->lock) {
 		guard(spinlock)(&vss->lock);
-		if (vss->capture_staging) {
-			snd_pcm_uframes_t appl_ptr;
-			snd_pcm_sframes_t diff;
-			size_t bytes;
-			u64 next_acked_total;
-
-			if (!vss->runtime_active || !runtime || !runtime->control ||
-			    !runtime->dma_area)
-				return -EBADFD;
-			if (vss->xfer_xrun)
-				return -EPIPE;
-			if (!virtsnd_pcm_capture_counters_valid(vss)) {
+		if (vss->runtime_active && vss->xfer_enabled &&
+		    !vss->xfer_xrun) {
+			rc = virtsnd_pcm_capture_send(vss);
+			if (rc) {
 				vss->xfer_xrun = true;
 				schedule_work(&vss->elapsed_period);
-				return -EPIPE;
 			}
-			appl_ptr = runtime->control->appl_ptr;
-			diff = appl_ptr - vss->pcm_indirect.appl_ptr;
+		}
+	}
 
-			if (diff < -(snd_pcm_sframes_t)(runtime->boundary / 2))
-				diff += runtime->boundary;
-			if (diff < 0 ||
-			    (snd_pcm_uframes_t)diff > runtime->buffer_size) {
-				vss->xfer_xrun = true;
-				schedule_work(&vss->elapsed_period);
-				return -EPIPE;
-			}
+	if (rc)
+		dev_warn_ratelimited(&vss->snd->vdev->dev,
+				     "SID %u: failed to refill capture queue after ACK: %d\n",
+				     vss->sid, rc);
 
-			/* ACK includes any subperiod tail already copied to the ring. */
-			bytes = frames_to_bytes(runtime, diff);
-			if (bytes > vss->capture_ready ||
-			    check_add_overflow(vss->capture_acked_total, (u64)bytes,
-					       &next_acked_total) ||
-			    next_acked_total > vss->capture_copied_total) {
-				vss->xfer_xrun = true;
-				schedule_work(&vss->elapsed_period);
-				return -EPIPE;
-			}
+	/* The ACK is committed; a refill failure is reported by the next XRUN. */
+	return 0;
+}
 
-			vss->capture_acked_total = next_acked_total;
-			vss->capture_ready -= bytes;
-			vss->pcm_indirect.appl_ptr = appl_ptr;
-			if (vss->xfer_enabled) {
-				rc = virtsnd_pcm_capture_send(vss);
-				if (rc) {
-					vss->xfer_xrun = true;
-					schedule_work(&vss->elapsed_period);
-				}
-				return rc;
-			}
+static int virtsnd_pcm_cp_ack(struct snd_pcm_substream *substream)
+{
+	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+	struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct virtsnd_pcm_transfer transfer = {};
+	int rc;
 
-			return 0;
-		}
+	if (vss->capture_staging)
+		return virtsnd_pcm_capture_staged_ack(vss, runtime);
 
+	scoped_guard(spinlock_irqsave, &queue->lock) {
+		guard(spinlock)(&vss->lock);
 		transfer.indirect = vss->pcm_indirect;
 		if (vss->stopped) {
 			rc = -EPIPE;
