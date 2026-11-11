Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794355594;
	b=QM45/tWyq3a7xclNhohJSh3CvsoxbeiTdi4YWCoHoqCXbkLu2kY7Vs4x6aFgiTvyXW+Y
	 q3iUVDrhemc2lMOJ9PBrQmnGOzhVbZ4lU2vtjDRn0eUbF+ibChAMf0icEVveUZk2Wnhzs
	 85cLosGqWmeVyuX0Sv/qtccwU1+mBZ/fvplXVSjRjP//HtoGHp+XC21Sy5vjTYfVeTLZB
	 WP+E8oRF7OtMODbpDSPI5Absos3n1BoAJnc9KOTLId+qx5vj7i5Kyyu7gBvJz0CoRMqeH
	 1ZPh6To2X/K3skmqAqD/GGDVA9HreXyE+aGSfIqKkUxGdcd4bf/Fl/k6mWKtvccQ0hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794355594;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Da9OCm5N+tM292Jb1wkFobEcv5XsLraXLlVZUfX2Yhg=;
	b=SrOa4K1JNuTu5Cf3N+LmLCiifIT5SZ8BXDACIuWCLaAF7SQHSINM0kTeLR1yfG+GXRb6
	 iNjCuj4wkt8IPPOUgO+L174zl3XvzqVwMeZV3Onyp3EJri19QqNDRhjX6aovSdC2dQJad
	 EslFGIugTQ7P600fbeU3727LrHH4ywrTnmub+UV+Zc+ATHblAPaNdE79UGexJ58cpH87/
	 Yy7ibyKX6vPeHOLa8qS+dWA6GSmIbfuCRZRt6uMa/BcFzk7pomz0jQBr4rBu4Vdp7p4ty
	 b7yfRyjOV6E5qhDuSgmux6g3TBqzLmu28TFodoMqQuEAXLEMq3Ke5gisfZ8t8krF9Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fA6iLo6e;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F083860A5BE8
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 00:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F083860A5BE8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fA6iLo6e
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cdab8873d9dso1119176a12.1
        for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 16:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794355592; x=1794960392; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Da9OCm5N+tM292Jb1wkFobEcv5XsLraXLlVZUfX2Yhg=;
        b=fA6iLo6ee9t7jD9FIICK6RXOEQFFIKnzc5KIGS/rDwnb8FWtNp6wP9Zvni67EOit8e
         qrhS+Q9V4gP9fi8QcKOvYPdHwHk4INxeEWvvYOacF4RU67ngiC2h1NsZv/PR6E1tByXU
         Fx1B0i+EJqOJNiD4W91EYTbtSiP6K3SyiR5oxzeDpEwLlmAqiW74rKmgkxKt8a34WkLN
         HiO9YZVomW9JL9yE7Es4POoeGGUbUXhAmsUiOTIR9qwZr97u5B856Tgpy3+Jn+HVjcDu
         bEkg7N1/SIUNY1MWa0UbvlLcs+mE3YeUh3WH47p9ZZ4Kv5Ao4szAfvyHPlOkQyrUVmZu
         xBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794355592; x=1794960392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Da9OCm5N+tM292Jb1wkFobEcv5XsLraXLlVZUfX2Yhg=;
        b=VFyHOlpGigmO7v2ZvUw7ybMN6yX8op/URIAV3L7yAPDp7cBltwLZkqjX/QDq93a8X1
         iV6Iqhm8zY4R52ydHhTv+qy8tsWcxhEwzM6Ki/WflllnmkAZvPYOH9Pkfhh+OVjGmgxt
         uZMlZyHdk2xF5AVRUOn64M80qTJX2rgiV7V5Mczq2RC9LIwmiNCjk4TkEArQ5Yn9Dn+Y
         Wg5IYkMyJjB2xnBkVx260dBER+oZQBRu6djmvt8HdFyZbMJQofilu9GDwxXGpeW4xblZ
         DeUqrP5tJLI7of09e6eIQl4Gt7kGpgRcIpUhcoI4QlD9/P1hIjQsrF/OS2o7L30BHFmY
         8rug==
X-Forwarded-Encrypted: i=1; AL+hErHkSt5gvdcTJvXbef6UwLkKwPKjcnze7C/jovbvx/cYW9fcB5tF5m8Vg5BtclGoPcfeWrNbiOY1Flf5UO6jbg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+SXAFmCXq/0rOT17VyCtCueuwyUPGTokD65L+Nr5wrJ+Do8f++
	R6mT1B9t16v9J5MrK46cqvuLAIkPfhzECcHVaVDDQAK6YnQVocRvyaZG
X-Gm-Gg: AYBFou398ai+GnEZ4lzXCL9wuq6DEexxozTS3NRsSeeIRexQvxqZKGajg4cktdLHTMr
	VUh9styw3W0z2DwgBIYy9BeChDpgHBUReYuyDVAquG29eqiR9PO522KGlJG7QuOVloF/esFL3jx
	tiepN0a6bFS7xpPjbA81bQtPpNd3/T7Rmuk/NN8hHA3VamkK8GANob1hRcu6hdfqItAP3Hupg5W
	GSOd3u8uUzJ/oCvqa4WUPSlESZSdiXf7CO5hYIhETvW1vtyUYmJPtH0t3x8TyaC7IjRCj8tDA8d
	Tlawzfwta5r6m/n+OxBjbqnbKlGEps6RELN0EPoxx61IG7AJ4CTFy0wMbVULGqKClAyLk7xFAVu
	ykCb0GRTIF0BpA12cbPgRvqcfOgz7EuFiv0Az8oMU6ahOC1GpOLb2YGjvKxrqmB+XyXL1+iZd2g
	QjN6xppqWqAt80rIYWe2tTI+9zUvIUCrMGZ7ul1Z3mjoZwOuJ72Mf2jmS6XxORXL8Wcjl82moNq
	6VuAmgAiw0U+PGaD0G1mP2oS8DFB78NBD/Kej8qs7O4dJ5QtwmeazR+jbcqz3S7Ibnf17YxY3LW
	kvrj8+yXU5+NM3+CC2rIvDY5g/rWfchfVUfuXudg7PHCVjfwtJ77DsOrM12YW+KnnD6tnNYx+D8
	xYwb47PpqS4FPWMhX44GwxANWlIQAOrHGKbJKazchr3915t0=
X-Received: by 2002:a17:90b:4c07:b0:3ad:5c64:c7ae with SMTP id 98e67ed59e1d1-3b18300b741mr646865a91.57.1794355592274;
        Tue, 10 Nov 2026 16:06:32 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1838e616dsm474361a91.4.2026.11.10.16.06.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 16:06:31 -0800 (PST)
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
Subject: [PATCH v24 11/16] ALSA: virtio: wait through signals for PCM teardown
Date: Wed, 11 Nov 2026 09:05:38 +0900
Message-ID: <20261111000543.28550-12-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261111000543.28550-1-mynameisjune111@gmail.com>
References: <20261111000543.28550-1-mynameisjune111@gmail.com>
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

A signal can end the interruptible wait while a STOP or RELEASE request
is still pending. A later teardown may then submit another RELEASE
before the first request completes.

Keep both waits non-interruptible and use the existing message timeout.
Other control requests remain interruptible. Device reset still cancels
the pending request and wakes the waiter.

Keep timeout and wait results in the types returned by the kernel wait
APIs.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
sound/virtio/virtio_ctl_msg.c |   19 ++++++++++++++++---
 sound/virtio/virtio_ctl_msg.h |    3 +++
 sound/virtio/virtio_pcm_ops.c |   10 +++++-----
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/sound/virtio/virtio_ctl_msg.c b/sound/virtio/virtio_ctl_msg.c
--- a/sound/virtio/virtio_ctl_msg.c
+++ b/sound/virtio/virtio_ctl_msg.c
@@ -265,7 +265,7 @@
 {
 	struct virtio_device *vdev = snd->vdev;
 	struct virtio_snd_queue *queue = virtsnd_control_queue(snd);
-	unsigned int js = msecs_to_jiffies(virtsnd_msg_timeout_ms);
+	unsigned long js = msecs_to_jiffies(virtsnd_msg_timeout_ms);
 	struct virtio_snd_hdr *request = virtsnd_ctl_msg_request(msg);
 	struct virtio_snd_hdr *response = virtsnd_ctl_msg_response(msg);
 	unsigned int nouts = 0;
@@ -273,7 +273,7 @@
 	struct scatterlist *psgs[4];
 	bool notify = false;
 	unsigned long flags;
-	int rc;
+	long rc;
 
 	virtsnd_ctl_msg_ref(msg);
 	/* This reference stays with the queue until completion or teardown. */
@@ -314,7 +314,20 @@
 		 */
 		virtsnd_ctl_msg_unref(msg);
 	} else if (!nowait) {
-		rc = wait_for_completion_interruptible_timeout(&msg->notify, js);
+		/*
+		 * Teardown must observe completion even with a pending signal.
+		 * Otherwise a subsequent open can retry RELEASE while the device
+		 * is still processing the previous teardown request.
+		 */
+		switch (le32_to_cpu(request->code)) {
+		case VIRTIO_SND_R_PCM_STOP:
+		case VIRTIO_SND_R_PCM_RELEASE:
+			rc = wait_for_completion_timeout(&msg->notify, js);
+			break;
+		default:
+			rc = wait_for_completion_interruptible_timeout(&msg->notify, js);
+			break;
+		}
 		if (!rc) {
 			dev_err(&vdev->dev,
 				"control message (0x%08x) timeout\n",
diff --git a/sound/virtio/virtio_ctl_msg.h b/sound/virtio/virtio_ctl_msg.h
--- a/sound/virtio/virtio_ctl_msg.h
+++ b/sound/virtio/virtio_ctl_msg.h
@@ -47,6 +47,9 @@
  * The msg_timeout_ms module parameter defines the message completion timeout.
  * If the message is not completed within this time, the function will return an
  * error.
+ * PCM STOP and RELEASE wait through pending signals within this timeout.
+ * Other requests remain interruptible. Device reset cancels and wakes either
+ * kind of waiter.
  *
  * Context: Any context that permits to sleep.
  * Return: 0 on success, -errno on failure.
diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
--- a/sound/virtio/virtio_pcm_ops.c
+++ b/sound/virtio/virtio_pcm_ops.c
@@ -20,11 +20,11 @@
  *   (RELEASE command in the ops->sync_stop()) and the ops->hw_free() has been
  *   called.
  *
- *   When the substream stops, the ops->sync_stop() waits until the device has
- *   completed all pending messages. This wait can be interrupted either by a
- *   signal or due to a timeout. In this case, the device can still access
- *   messages even after calling ops->hw_free(). It can also issue an interrupt,
- *   and the interrupt handler will also try to access message structures.
+ *   When the substream stops, ops->sync_stop() stops and releases the device
+ *   as required, then waits for pending messages. A failed control request or
+ *   timed-out flush can leave the device able to access messages after
+ *   ops->hw_free(). It can also issue an interrupt, and the interrupt handler
+ *   will also try to access message structures.
  *   The messages retain references to the PCM buffer pages until they are
  *   freed, so late DMA does not target pages released by ALSA.
  *
