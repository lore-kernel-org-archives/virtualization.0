Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3762AD0C
	for <virtualization@lists.linux.dev>; Sat, 17 Oct 2026 06:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792216831; cv=none; b=kxDm/vXyn+pnaig2f7xFWYtbCPwHOwyFYdLXvmabKErFzEExzAgrCe0jVAHaIuv9cO3W4vQLmHfKQCi5UKqeekQIiMl5qsw5/o1du2dMZiT82dYza4+q2tBQu+i1krknab1W8RxXVpU6oqD5THeDCUTeyQx0ZtDXlXTDUJ2xLlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792216831; c=relaxed/simple;
	bh=L5b0I/0+i5OjpPgAdiQ54velgnThBwe+zC6SmWduBPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GxCtQ8MwK5HQiZXBIBKbkN3WfSGXigQB5+B+yfwmBgeA2DyhZ2T0VP+raP+B9+Yf26siX4//vHnka4/5tA0K9G8UMHBnOLFM9wZRYLe6LVF6YcTpMsGCGm1XeUR8qLDceP5o3wteQ9joq+TiV1JAYxSlK+fXI+kMejpthTDT9LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzHohLGp; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzHohLGp"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ab3260b35dso489856a91.1
        for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 23:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792216829; x=1792821629; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6eYi7haKrUUz5ppcKTnEsRmfpDKe/7u+K3cLCBGytI4=;
        b=kzHohLGpqMeRBwrXEX2ltW7LhuK696MZmL+Io4+5KGo4jyUlqvdXzHeY3m8f6Pt4+4
         ue/XoJ8DyeHhaNCmMdbmf23t8R5PUdn4sfhDk5YQwQnHfUq6eY20c/Ez5l/rr6ePNjF5
         Dzl8solCHS0PsVX7eMLKdRUKFYGIMvjBqgXakMhN0lzipbA62iMA8Qtmq+p3j5luCzlm
         hvdEtsOrrsyorHeDI+aIOK2dYH7HPQFt6+g1dB9pepKuxRwSqhg1Zn3/QGF5nP5pvdQk
         6ZqN8EF0nHqJk21MYFzWH/yTIBTriOVeRvRQ/x45u/G6T1Q3CPh0/qnQPk3N6gdVmK5T
         NmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792216829; x=1792821629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6eYi7haKrUUz5ppcKTnEsRmfpDKe/7u+K3cLCBGytI4=;
        b=SjJ2Uce3GMut3M0r174TAzr41ffsAIO4gdkIaiS4zVf6SpoDOC6Rf9C/WYPwAQWv82
         y3XPBfuh65Iz7A1xvKMzZgQO18VwdhOjqU8lTSUxeif8juTR6vTghfWzjesUm1wZtm16
         Kiz8V6NdEcVriE9nO4FaIde0WvOvpmfhsRNOtinPSPahh1AO+xAWOsjd+70VkCd0XRfl
         VnwbUVcxQpfH1FMmKjlfIfW73FkWqIQA6W9XJO4PNG5E8xEFTYg8zVUnuVyJeK0Ivdtp
         BE0W655RfBpDZMrRCt7xw/orIACTR6BCDG/PIIsU45VnIoomBN6ctR6DPVe/0l1/w6zw
         jC7A==
X-Forwarded-Encrypted: i=1; AKwUvBzYZiUDYVmmuwvMVZE2ET+F60miXHdUvk1m32ezjt8YBVMRgWUXCfP3wu/3IXFKYiyHgkVSakT29DnYBLOL1g==@lists.linux.dev
X-Gm-Message-State: AFq9FYKYRk/fzhsEDr6WHlRPtXVRHxidWiVzZWsopThqAQFmZSwdgpmk
	I3nLJw8gOCpLblnCIj43zFNp6gk+zItRTcvT8/3vRWGN7JBIrhaLK5p/
X-Gm-Gg: AYBFou16o2mo2OQ68Lp8C0MhrWD+YnKAJx/xaDUvW32L9tTfJmeu+VaXHdCMUOoE/0m
	IAprewQRzSNxn7ZuIQ+IGUC9k6enjOZmDqlaUzkacT62Dt7ciLn6u1uk/s4RzF3Nq1Zjt8AK4ck
	Np6mfu96TBaQ+/Ik3KIxeagZ9XHwXiWKaa7+CMLtafSRPsH7gCyWd6L+eIfX/Bcxt9vtTHy7Epc
	yCNHHwXJ2MnZ/HtMf2BvIV2wdXutvIU/HMUHv/AenrYmHrwAa+mvFNUohb9Qz4Siqot35t70O7I
	v6SnjwTFVrmVXT0Oxqb0dApW+BUBNeAd/DLWk4TUMA3ZFvm4Bs4/POioGNp5TeaeGC3amg8at+S
	vYe0hfCZmE5OEW4MSRREmB/y1MdQ8hPr2K1DY+dmDRpe+qNkDn/9pVtrDJHJnuYCGQ2deJUqR3v
	MK7WXOc6uGC2XsdiQMt5E7CIBanc24kSZ70Zj/muU6/AHnanbdkQUyBW09mwc7AScGbpPHfVEV2
	RIUAxJPdJbVsJp84XPwfMEANc1Pbw9pCJ5iCKzp5u34InSsjroVi1jrSu/GvK2oDQgA22MkYLRh
	mxmA2Rx3cWdd5R+QIXyek36/CA==
X-Received: by 2002:a17:90b:582f:b0:3ac:4e18:2390 with SMTP id 98e67ed59e1d1-3acee27718amr1846889a91.7.1792216829054;
        Fri, 16 Oct 2026 23:00:29 -0700 (PDT)
Received: from localhost.localdomain ([180.182.24.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac947d2706sm12106705a91.16.2026.10.16.23.00.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Oct 2026 23:00:28 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Takashi Iwai <tiwai@suse.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] ALSA: virtio: account staged capture reads before RX refill
Date: Sat, 17 Oct 2026 15:00:24 +0900
Message-ID: <rfc-virtio-snd-capture-followups-1.f2737c95c12e45b4@gmail.com>
In-Reply-To: <rfc-virtio-snd-capture-followups-0.f2737c95c12e45b4@gmail.com>
References: <rfc-virtio-snd-capture-followups-0.f2737c95c12e45b4@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
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
