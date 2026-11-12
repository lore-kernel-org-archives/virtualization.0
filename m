Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794444470;
	b=xwWm86kxRgXygGCJokIB9/dXgQsndR9FrqyachjHqZXeFCohnU8KNSjmb57JktL/2EnG
	 0ildokWK75rlZYaMIzjzBH0Qy3Znnr6u/AzyJpaaCS6um2+9Q3BlxuPbg0uOdFDIJsk7R
	 c39/2WqzYjFLK/2hPLGyXkPjDnq0SASvrcsges/ny0TKk7UcHniIUxyQNGn9R4ffS54u+
	 wBQ4WbqxIq6wof+efQJUx07dX5qympm6OnH0qEWXyCeW+3Y34WjxJBy7ymyta0J/DDymR
	 x/SykNqrkxXZjC+2Umd6vdkz/6OJ2wPVW76VIHFiGPloyZTTneWs9QBahfwM9UKwkbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794444470;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=T+sVIbp4DoVMcIWaKe5XqLWovfYHU/r2Z29X5f79OW0=;
	b=o/MPIiYWZGoiUbXBgg1WXPDa4VfcEI0n6tG4Sor0AFAmMUaNBW1szX6K5WoORNU9tPJ+
	 +fn1tlHWX0OEHYHsXXy6gq27PnfYNXro/AUMN8man//3h/xX7lvrjunklzYDsBPbsxSkL
	 esZ688Gu6Q7ixovfu7ka8LopelUmuQ8tdSiWDIQjmQD/twlqIAu6ueKBVDeOI6XmD50F7
	 jE49NOyoXDhTaSKweNkOoKMQKsCBDvrDIfa7/dAXL9x45v1jlVb+jkRP+mNWwxWaGQisO
	 YmvYysDkn7u4U/XmM9KxuRuvmNQ6PCtuQQN4OfOzEB8OYoY+rX1b7BZUV84LatYg3wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rVG6wgnz;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3DB60A2600
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 00:47:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B3DB60A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rVG6wgnz
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso7809911eec.0
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 16:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794444469; x=1795049269; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T+sVIbp4DoVMcIWaKe5XqLWovfYHU/r2Z29X5f79OW0=;
        b=rVG6wgnzIVkZDwzfVp/CHbLD1Zt8f0Q8pvqYkjHyQOQb59/0W/ZG0On7WqwnFak5dn
         Ga6aWUkq/Yr2pBcEwNXDKUDdtINgUru80x9kLb4EfEEYUepORqmjpt7y8hoizsFbQm6q
         W4bELUOpc7KF+1AdoxkxVtmTS70B68V/zQ05ZbjwEx873iNMwSh2RHsBwfUZgJSgEnqj
         D5T0rkyZ2MhsZdo7CoEw4YX60iZBifkN3F1+eML794dZYWA6KeLbdLLxnXZsZ4lFfmCK
         UfRA65+nRW1W+UwxRHtcmjDaDqWMrD2lYL5Cd5wVr0cLvMZkJjdCk0ICKWQgA7p+wQno
         1ZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794444469; x=1795049269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T+sVIbp4DoVMcIWaKe5XqLWovfYHU/r2Z29X5f79OW0=;
        b=NmylyvMrTtk/6TPEilDaH7Hdkg+J+GZUxvDeNheCJFBe746l/QFqCsfcX5e1e1tBm5
         aVtEPHCqKfjmRCvN7lB2BEsplk+uHZ49yvr7g+Z2I4zIDJ1e54AZwfvcxbSLKgloLjv3
         7zMcCRLJDpTXoCwTP+dnSCjvnWkd7Z6znMieKFYBmTOXidOXiIIcB8oGGRJmmyU/+Fej
         QbGMgo2MYA7gifVyP9MaVz+dcxkDZkdVaQkbPIPGSy0IjZg0PomHFq6UW4DL62y/Lput
         F3SWeAu02h5fJqN56Ww9Gy4suND5YUmVwY97YOM34oR8noedJBDuESIu2dYAntQUTzzB
         4NjA==
X-Forwarded-Encrypted: i=1; AL+hErHJFZhur04wLxz3fqbgOJkqGhK9rdWNnqNGXTZak5vT1pjORMYN8JV0pB78BftKpOkZYRW1o6k3pwmuZ19xWg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+aIlivwW5tXIpyrwX+TegjJMelJVQ2zSYXbF2imfNQmO5BcEBA
	qq1xrV/qwPSjKiOEjaovw7lB5TsCpLV4B1n4hgrpDBCYhmhgZVh2KL/l
X-Gm-Gg: AYBFou0Q4X+6dXNfbU93PJXGr3/a9VY5T1z7s/h0aLWLZcWY7a6GBV0MgPvCyUkh+7Q
	eLog8k3ZW6SEzGy68hfENVCuM03CR0Ca6A5ZcNyddFgraK4p472xgaxXc5wibSPii1dV52bZCMT
	lMdX1BaWwKBN4J0nazpQmAHBHfZQuxsHK8Q2NX/TBUt0UvHYMkk2lOcxkHXhUQWCOi+xe/fSsX3
	GpSQj5uEgIwKnjqgTGpPZhiqqxAnpcqT2uGZtaH/Ep5KpDbVv9FHgLQb62JHvXJJrEUmFFYw/9Q
	Hvfy7mvN8XXUzmPnMx4nGtMvTlcj58pZpZsqE1VbV5NImQdLTIsQ5TVmCD7yF+VKjK2v0VWi6v6
	WUMYsasVsMHsmBKthPFGbkeM46LLxE/MFpPlIeWMkR09N0s2hIlbgpzqVqQ4Gw+yGA1MlKiW1Oj
	u9iRyMrSs/KdqMQ5SUumEEM5fiJSAR5hBflECFQ3bbUyd1r5qnSFdUPpwRpe/aiZXaqHm+Z79ty
	gNGpV8y13lJulBX0a1PpN7XnC+r9xGtS/72vJB3RwT4CtLqTlkd8PHcr7Aw33ccK6OFFCdUwzog
	1RGhBebVND9KfP1zG0GnrxNNrDSixwcQyIyp8sybQMfHxIBqLCzGpdwvxyH1um0jSYKH//ZZMnI
	nHdEnon+d7VeOWPK12eOE/fN6jX9a1kveYebtHGF7Ytc7T64=
X-Received: by 2002:a05:7022:b058:10b0:185:33ab:4d55 with SMTP id a92af1059eb24-1b3c137c87emr3424050c88.29.1794444468572;
        Wed, 11 Nov 2026 16:47:48 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2eeffsm20672163c88.9.2026.11.11.16.47.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 16:47:48 -0800 (PST)
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
Subject: [PATCH v27 11/17] ALSA: virtio: wait through signals for PCM teardown
Date: Thu, 12 Nov 2026 09:46:58 +0900
Message-ID: <20261112004704.49758-12-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112004704.49758-1-mynameisjune111@gmail.com>
References: <20261112004704.49758-1-mynameisjune111@gmail.com>
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

Fixes: 9d45e514da88 ("ALSA: virtio: handling control messages")
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
