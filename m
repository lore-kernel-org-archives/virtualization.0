Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793156030;
	b=dqNIGXyVBCc03ttWuzm59A5peJS2FmcmVsvTiH0m/T7WKmFBQa9/n39PMCLWL03kVT1k
	 /nW/CD6c1isDXqmQ0z6GCXfYkjP2eGN0nWBl3fz/JMMaVVjXy1Wn1qkNOH5PH/4gkq0KF
	 tNQfxTO6JdArKACupiWN/1qEd0F40lJmnlD0i0RGkP8JVcZDd0DPDkGH8hipWOqm0FFS3
	 nTpZjdWz7IwkGDxhezU+hnoKgPKpy7w8uXH0SkkbIpPPNvUw1d9v2/+HGrlylmNfgOOjz
	 li6JcNGTgIJkwmpidyX6J4AKSs9KWXV/qiDbpE+bkfclrLOdyBtezI0QIu4dMSCm1tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793156030;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6eYi7haKrUUz5ppcKTnEsRmfpDKe/7u+K3cLCBGytI4=;
	b=33uUsdz7dni/P5CHPBQODXji/DeHXnoAX99FPWK/0Ua0u+nw0p4JQjsiOkD0degtcwFC
	 ujM1wfU+9F7a63DAkdrZqAM82BO0TVRumnXBI+F10spe9nEfnfmSxaFGLcybJPb9/zR1O
	 TrQTpjl8rmDTuQ1OBB5JG2W3hWwPc/2n3TPCV9R3snrID/5RcPWU3f1DMyB83m/5WuWWj
	 U+h69UY7SPVbszJsXUr1ttziyKQDeYJDPNTq6jrniM7goSYA5aWpbbyFd9D8ZWm4MiwaJ
	 3pXcc4rRVj5aCUGEJpaa4GtopOHTL2Q88KhNMljuUM+5Ec1xQUcz22cly0bg/8yZxhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PxJTgbMH;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A183460A2636
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 02:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A183460A2636
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PxJTgbMH
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3535a54bed9so730210eec.1
        for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 19:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793156029; x=1793760829; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6eYi7haKrUUz5ppcKTnEsRmfpDKe/7u+K3cLCBGytI4=;
        b=PxJTgbMHxGiy//5IHAZVXbYkWRlyqvcez5vFIFwO8W1xHuiWgopO7IRNfQQFvHaHLy
         UPWEkBEHG/+QZIe2B2BPeTv//sDx7DCvdWAmZHBx2Qp+xHoth8KPc09WRyf7T7djRBln
         nJbyl0AFw7Z3+K4o9AzwBso7Bulr2aqTMRoh0TlXzzW7bCtjpT0eakOBVR7TpiGjY+in
         p+LDDsfbro/ZvtKLqTCWJdYMsYdPbmrh1/OeGf0ngaOOwF8unhucXZ5OTBumHm3dxZKJ
         upvbSkb3gE2WHzLcqVV36bnAfXBs9QLXkRD55eKzKNVNjssf1glw5WTmT5q8BnxBh7ry
         8XTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793156029; x=1793760829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6eYi7haKrUUz5ppcKTnEsRmfpDKe/7u+K3cLCBGytI4=;
        b=jA5DXh09E9yHTRrl6NYUrEuYB270oE4msMe3RcwV2ZpOZxmk8DPS7UX090oc7za5D6
         T4zNxLQ5eB3vOX8VXMPQw+MrG1laO9XLt021Qe7g+5Rrgr8rj1ZEeOosOwdJ8KMsptGu
         AtdmgdEKkAWDlT9YSbwuBEn6WOk3UcWsf0Ko9DYZYxO/Awl3ua3xphKOSd52Liy+gb0Q
         3s6ptLh16AD38+hN9nBLg/2UkehBUYDdIiKBlEtn0sT8dqZ3A36q6hyLXHtAUGMivJal
         7MLnSP/b84BawmBOKghnqM2QGPtIp3f0bYnIWiMpp0lCy/pFhde6PvoBo5y/6TZfeu8z
         chnQ==
X-Forwarded-Encrypted: i=1; AKwUvBz6TQLfipRT83+DchKfot051WcfOaTHXfXJ6nxfSTG3B7PP85HRDGckgL2RU3Tb4G932OoGjiHTompjXZBgAA==@lists.linux.dev
X-Gm-Message-State: AFq9FYIPODjO3iJlmbAOwQ7x2fwvXN/ZwL2iF0MoXVMvHnepHACO0iaP
	LhUikvEe2+C7c0D1g14iiOLhVGEUFz0U7BEKd6eQ5Y8ktD5E2nusxf6h
X-Gm-Gg: AYBFou35nn5kEIwbh72wI7sjfwxDnBNJ0tH+IGO78HH+tDkWoc/pp6k5oD/jL9KTszP
	qZ1L85IBY/CMNmxKTivnyQz8Pv8S2PTH9j18h1eiFmBlqpQde1VYVyq0LQo05KnhFW34NBpdKYr
	xHDi0rK0y02D2K1xXKIo2SU0m1UvHAVbdsHEB07NsYdpRWpTrb+6kuJnJ+4Dir4TS9MQviGBjZ8
	Z9AMIENGIMIHnIKMdUmP2FFdrkPckP7o/cqgq/lXeigWvf0O8G/Ya6dO9xsCJOtMZP84kmM43ya
	tq0RHYuSE3ckwcch2pY8UEXDoZBq3SBH7xoKtuFXzH1yNv+QBoMCBSKzrPFPnFCQtjACHuujUja
	ijR+IJfYFZ1rIeHY5uIYyrQuuDp7GGTZa9JwBJyoh2AiQSL+z8g3YM0arbEN8i/sVrN+E0mu/LK
	mewnYslzpya7dyFOYGL71sHraW7Yq+w8SawxNfH3IwJ4fYWmmKqoi82V4LzPpH3k06N29CJUdWP
	7Yewz27ERS6TPDGCxMS+MHJiMwNhzL7Lx8KVOi/1N7uu6C2CirRs5hUKmxZ3xb1lZM3EIByTNM9
	Q+4zICz9E0hU/GhCtYyKSwoKDYJHA/ixnerOglE/HwQdtNlC3uuKRfLWODktxFXhO9dDwzE5vKc
	Hm0LRHhItGGsZqHvHmh0U8fO6WqFmOB4N/vEBwmvcPbkGaSY=
X-Received: by 2002:a05:693c:401a:b0:36a:1b95:fc75 with SMTP id 5a478bee46e88-36a2040717fmr2212392eec.35.1793156028554;
        Tue, 27 Oct 2026 19:53:48 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a239644efsm1711914eec.23.2026.10.27.19.53.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 19:53:47 -0700 (PDT)
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
Subject: [PATCH v6 08/14] ALSA: virtio: account staged capture reads before RX refill
Date: Wed, 28 Oct 2026 11:53:11 +0900
Message-ID: <20261028025317.92450-9-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261028025317.92450-1-mynameisjune111@gmail.com>
References: <20261028025317.92450-1-mynameisjune111@gmail.com>
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
