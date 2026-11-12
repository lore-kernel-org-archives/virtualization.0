Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794458160;
	b=BwRKtBPXtNPxC38qkzsnJYoshRBMvzM6OTq7u5oMf3Qjmwo5SUNs2DyHj8cMlcs8KqYV
	 trbeDt5jNnFKs4l4I3XWTtXdKrUbPh8DogXKZCnlrQoBJshQDmVCUl5K9dNBqS99RoYu+
	 lKhgjbqguMXonFhfVddFljszq4pxbZTB2s5PICGbkjq2YDjW1rmfddgcFWDgTtRQm2mmz
	 3dYi3nXDhtYti3F7u9lQa3rfVSLrFEglW7VXqMPVEUH/OPirB/ikw0XH1Ewln0Q+F53jO
	 83AO06QbkvEkzTLUNwEFOI7RDNaH4IOwQV1jpXgXYp5fJmwnT5vUYnh7MvEVSLI2A4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794458160;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=T+sVIbp4DoVMcIWaKe5XqLWovfYHU/r2Z29X5f79OW0=;
	b=rcBtrZNEFCs9QCN9g603YwUdFHdYdGdKsvj5GAnp6vhZUTHkkcMlfOCwm7eKZ+A0vZHK
	 Dewv4/oWNTHmmGcFz4CJGxriYDB8FTItO9/7i2zrRDREGblLEoEqUacjOmlW7uN/erGTP
	 dAaoFsIiIp7h1BznTwPku40Gcr7oE2g7lTnYXNciGFptB1TV05kyeR/hR6hkJKAy8rXse
	 d8hBLgJ+LwpB8diKmBSSDkDydSbW1TDSphZ/0Wb/9KmgOIEG5PVbVZo4sOlj9WD7qWSbx
	 HBxkzG/gqccQNL6PvsHzCoPOPKfadwcr5U3XuZuiW85qIaqutqAuMtjV7IgpCtNGMEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kmcix2xa;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BA560A5BD1
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 04:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82BA560A5BD1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kmcix2xa
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cdac6d19ddaso1469072a12.2
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 20:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794458160; x=1795062960; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T+sVIbp4DoVMcIWaKe5XqLWovfYHU/r2Z29X5f79OW0=;
        b=kmcix2xaziHrSXfHJTc09PaAFCj2+pPohPrQoiwAjKMgIBNY5e3kyNnG5dv1h43M7K
         URLKTqEx4ti155ucqWda0nVQ+qBcnGEvKu13O3sHx+KoriyznQUQylbHQJgLJUxK78EU
         DoIE2/wr0TtPFr7SoooUURJ1npLzm2oLeRvzvaNcLCbCj7/SaAKE4zgaZNeMrqIQjMzx
         TXjNoX4bgQ5MrtjaY9gkBMdky/xjz6yxahAKVJ/qbsjB7XgNntiz04vx54E/5Jqbb86w
         ZGxQzc6hralUEwzdi37efNSTLk5X/FXw2tBMlUERutSkyasHRzVb+rodIYKUasOm1fX6
         pyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794458160; x=1795062960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T+sVIbp4DoVMcIWaKe5XqLWovfYHU/r2Z29X5f79OW0=;
        b=1rV1jtCPWjopfsZZvBqvtEIuI5dLnK+ZG8lsvFYN/ujfV1yCaObgcoD61RBdDfs+q0
         7DrliHQHCOC46unuLB7FfTw+KFSq13A2r0NG5Hbbz2rs+cNIYcdNhsiTv9RdS57tmhAV
         iwUPFDQUhOs6sCJKZXbyvYtUbb+lkCAlT2TormpCr6ncq1aTRMPAY2kxlftogVGq5umM
         05EoHDgiom43R5t+tI9LPfO/crq0SqU0gaTms60vR3YgcqFye51CpGEngAE3XLGLAxSH
         FqZpPAjKLujxxVHCP/qS+JDWt6xv72AEdgVeuM/J8OBBfsI1rmYkHkMlEXd5OAywTGW7
         kWSQ==
X-Forwarded-Encrypted: i=1; AL+hErFkGJ9AocKrSawiF7Q/9kptcCifBBeZl04GQc3d5Vqml2rSZqv/l6K5JB+LBWHOs8YdpqKFNOf6C2wuVnL6gQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8H9CamBv5OgcQEuGrvndqVe89Rcx54vJfL8D21aIwctknPiGl2
	P7dL7d9YBXMNWqwLwqLPH2AJ2a9oQSIcGcPxJwfmw6XAxXvZ/F0MqOlq
X-Gm-Gg: AYBFou2mMJcQ6BIKovQsUu56OAX+hFuvIM+2I97j5Pa198achYH0p+sHDH0v7N2lfRM
	eeGbBXhnnE4fKC+RUviJQSL9gEXwGdBj5Zk0pRjbHJqkDJyoTJnn5uBx90C3umf4Dqt7SCQm9ET
	LwIQuRPIE36S0vdkvb81Ky9jyI0Om6eXW5EssKVqjunS47mEHx1uSprolYRnrplC5xu+ZYflhet
	cPQVo4wBSGghk6A5KFY+vJAKnugGg1Lx/EOmX2iNEFY0EW9epHvAT0ZP4eqxnfmAOibU4BmlaZL
	b2nk6zPSPY09qs272FfqgMqSv4H0oA206arulGGDbby9d9L6Ufm2Sxf+yTCVJj2chNYQzW3mwyb
	P7Mf3AtL0eAuCMvpugsOmE8MmIRTPlnpa82NZ8gYB1JPohlUTET3sSuNob6QYF9dsR1q73ocOHu
	4fc30R4hUjbCHGB+QF9YI/raocGQverH9tAbeIwNnobYwDq10gMv9fTDasHcbVbJaBtbY3g/5pn
	1Buot1QBaXzwyqzdJS1zazPUUEcmnUr9CteaU1XBTvpjz8lJ+6agkKqLs1eUjyR+ymjHNsFene0
	mX7TFAJHyufUTswWyPNB7dxIrXtppy+//Qyqpc42Ru5wkhm3gaGzv5sWW88XamvE1Pu+oFhqVCQ
	wbi0DW5tmazdALL8I9uxlV387h9ULAHOQiKrzGRI+Px/wbqUZ
X-Received: by 2002:a17:90b:691:b0:3b1:8300:f48f with SMTP id 98e67ed59e1d1-3b18300f503mr3347378a91.51.1794458159800;
        Wed, 11 Nov 2026 20:35:59 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c8b287sm2470466a91.15.2026.11.11.20.35.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 20:35:59 -0800 (PST)
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
Subject: [PATCH v28 11/17] ALSA: virtio: wait through signals for PCM teardown
Date: Thu, 12 Nov 2026 13:35:10 +0900
Message-ID: <20261112043516.37010-12-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112043516.37010-1-mynameisjune111@gmail.com>
References: <20261112043516.37010-1-mynameisjune111@gmail.com>
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
