Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180530;
	b=RJ3yafb6D39hgiI4ZvKsv4fWXyVt1XSLJyQGGT9BNhx9gXBYNpsp4cTEtts6jLwxhCpc
	 Qbm1PK4q8q0qRenigIpjWOlFKIBc82qs7arhvaEv5ldUJStpSaN9RIK5NDbRbhNlCQMqF
	 j5q1zJXRkplT6K5SgF9lUniM5ddzO+OHQRxeOwPRJgnQEYx948cDm5PvgLQkaL7jf9wG0
	 r+Ls6SSjtMfTw6qW1sgRrgYz0Mz5mvi6v2i98eT4iIDfgAHBfIhoFhMsMPStzHx0vCLV9
	 4qt+CD/XnzSoQr/VRhU9n0Oyia3W0yToBOcMzasFVd+NLCFmNTQ8pcO58hI/dKqquHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180530;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6eYi7haKrUUz5ppcKTnEsRmfpDKe/7u+K3cLCBGytI4=;
	b=WczqDZTdkDc7tJYvGaxo5vwQNWO3XGB832h1dgK9m46Dafh7kra432sv77yRaWbLcDYY
	 A9yNCGMveyHvL2kJFzuum2Yg7cflrMyK5Zgm4J433/8Uzg33YNeRjrPRqHH2p8HWyHFnN
	 0bDJ4eRgojZMaOOEBd2SKO84rMOdh3ex6uV0G6GaTV/J8VVMIZPz/UQsrUy1jXUk3U2h/
	 mUkKg0qcsdsPbUo6d8fcJbdUO24hr6GPNNEF46X1gntOBT1c3zEeC6lxIPVhHrTIz/4Ja
	 60mYr0g6QCxi0rnZEwOtGr9Al76ZYbGaxPNYQLM9NUwT0YHHdxsBOnUymNvsqotqj2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WvVMm6gK;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C200060A262A
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 09:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C200060A262A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WvVMm6gK
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3acc96a256dso545050a91.3
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 02:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793180529; x=1793785329; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6eYi7haKrUUz5ppcKTnEsRmfpDKe/7u+K3cLCBGytI4=;
        b=WvVMm6gK9IVbqy56up5dBmlAU8zm0gk0luDQ6KqgDX6dN0KmzeeCs/UOopfKxWmsBv
         LGyoZ+iYRLTBWl4p6bP1V9zIddM9BSDz/fnsXz6bcB03dl8J2UD30Sdgp1w/ulVE0Fr3
         xYHJavgT5HFX7FCvjjqk0/Suyp2hKGBj3w3hNSFdRjre3htjRYKgu6VwhQlNx13x0W/J
         hIYkE2Zflz13/G8AitDiygOucBks8xthlHZIbhl1EYVMEkCRhhmnLbTrq9jPkiKi+nGO
         CNiaWHPdOBcmzVWN1GrA8FOhLfVrYb4cEl2Jmf5/AupIpdJh7j7jBzunluWZN1V/Coxy
         xjZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793180529; x=1793785329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6eYi7haKrUUz5ppcKTnEsRmfpDKe/7u+K3cLCBGytI4=;
        b=iNInfdEpFMurdxPtuqTo2Um5VC1/MJCzRmf3xyiYDiN8DcmTwoWXfHGVQ9ZnR8C7co
         JCJCDVSYjq94rDoxpmcjEgNJOlXrIVUJ+ekuyI7zfb/yeVInZ5mgzSdU9wNlfCJV90bB
         kwcMwl6aJtHvDAHKfALKqDl2PMiCIYUBp5yTh4xJAZ8ITqm2f18uOjGOaXgEyRZLNmvh
         wuDmEH3onGnr1doskH0yDMF8kjB9CgOSekn+ooUvxAH/e2bUYsnqChUqTUaG5TrIYwaQ
         QREVqiupfA0/dj4av7vjuv/o1OlNDc3UBOcfxPsLTDTcGILeon9k5XjXgxs0o1DN4ZpU
         t5Vw==
X-Forwarded-Encrypted: i=1; AKwUvBzx/CuASPk3JrdA4oJ2Fqzs9CzgKgxrjiKjpSkJJ+lGUIrTD6KJj76opGteHTZacn4VT18AkG1P4ktgeNLTvA==@lists.linux.dev
X-Gm-Message-State: AFq9FYI6wScJPvZFbPnyG4JkNDWjOUjSNCcUK2+OXkZLoEy+uaWi03Xh
	9w8Z8TqXQPZKoDojZ+14kn2GvJnBlvE/7FKmIa659r7n0ZGGdJBrNnYM
X-Gm-Gg: AYBFou2RzEQdfq4VTTBKOF9aM7ONFRmL4TmrcEodTQy6FtyY02fkB3KufYVtg8NQnhl
	w1ElrpNDin6T+5D2xRQI3VmanL6XjnGSVZq8lhQOFSCWx8toQRYDSalmxbzddRPoYPDpmDnku65
	7lWHavpzUwu9B7qJ4Y/+GQEcPdFbHgiPC6Lh0KtwgLw5yKXArSlS4QcUFttQOM37pAChkxbZ6B5
	cELtxPDlSKFescket/zOsn+YanABWPV0jBRT7GIwDBaYHdeBDMik7uI1ki/eegiDwNS5vWOA1C9
	5kKhF6bQS6xhf5ZU8zjVaHHSRFFgWVexKQDqo+eD1Y74UiPM9QIzPr6IZsZMd6JlDY7Ie1ktIdn
	MUczqehvPfs8MCZQGBQ1rJAoZa4KtX61oA/km+0ZFnfJQcLwvUKEUqnoUMVtYxJhisEDJUd+I4V
	ySQkMLevfZmBLTGmHwSI2i1nAwknv8kc8eCSo9tbOsRiBe51H8RnvH2ui7bjE1yeyWhhCOhYVSE
	OAbPM/aOKaz/M8R7ZYCZR7wE+5Pcwj7lT1B/JucbaWcqVk0CLd0/BPy0wDFR8VnvbvrYshh4Ub0
	pK/2s0YpVmwfSt7H64+joeDAfX/X6L3/CxzZxl2n/u9irPWnHzLC5QPQsmdsrwt6SGb1sawnXIA
	sMnqssk0mLTs/NXtPcipB7FnpUswgUc0B4U7BSw2GKjNOubxj
X-Received: by 2002:a17:90b:4ec8:b0:3ab:de4:7fa5 with SMTP id 98e67ed59e1d1-3ae582c0671mr1363142a91.56.1793180529080;
        Wed, 28 Oct 2026 02:42:09 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a93b3f5sm2242377a91.5.2026.10.28.02.42.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 02:42:08 -0700 (PDT)
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
Subject: [PATCH v7 08/16] ALSA: virtio: account staged capture reads before RX refill
Date: Wed, 28 Oct 2026 18:41:24 +0900
Message-ID: <20261028094132.20364-9-mynameisjune111@gmail.com>
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
