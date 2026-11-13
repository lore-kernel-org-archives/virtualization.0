Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794552117;
	b=Hy+JttdpbJkBggomo58ZJxrtXpML2ZkP1dlRLbFxHBBRfXw93fqkPfDZTtDCuMwKFtmU
	 jt1fBi5WW7LA/Dk7NruY/atdOWRXfDACwjFwsN1xz/4Oegi9yN0WOy++aTKlIyCLD34Uh
	 SDqAKrh9WYzsjX9qac5yCjuo1yW8trJeJGnUNufY3tdzf2kipCAUG10V42dYF7Nr2baf+
	 jjMvzXAdUVHYyx04h9Z4mwkfgVh+HWdMrml7+E7aF+jgxO83DsrTZSiJlH+4C/m1xjlzo
	 QAGzsk+LWH+moYaHqeO6Stg8Nu4M1gLIZT2Q4npM/AU9AjFtOsb0rsP5k6hxxpDh4lw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552117;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=dJ5r1MeJy/NBjpUZvrwuqBzTMjcmrVWR8gIgDHHQN3E=;
	b=mcnW4UI9hhmy1KFS6o4Xw6zA5xIb/9VFLtlkf3KLVF2dJDhG+GNxZnfACIgHlbVEjWQF
	 8gmH5TJrULzUIN3skXzHufMNyU2EnwEJryaSnWGwx+2gwPUqzbkOn0sWkfozed9eqvkfE
	 2TKmCDknxIQMLKH3KP8DM3D/Jzk4OpVL18RYTvgONPvbhgV5QijqK82/RJReIzaLG1F63
	 T8EhCSYSO8h/gmURiIOha2s1NQAAcPj1lfAMBXl8xE1qurY5MRJ7oUmh0+rTFhGzOLUP4
	 y+dzcwBIo8RDaezyJnnkVqRnqYagW1sDo5if2o9SI3W9/bMPZZK4KTe/MRsejsitX+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PZozunrV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE12360A3801;
	Fri, 13 Nov 2026 06:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PZozunrV
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794552117;
	b=Ez40saFaTnOPjsLLHYXeOLyz/mVFVNs7fT/takgm2IO00WDEVo52ZCrZnmtVqYaJ1lro
	 IVk4EjNG/J3nwBVdWcJBWtUaTdWZXbEMXeOTpF0Vy2Xa1MvZXgU+5J00KUjS4u9KmQJQf
	 1lbhBcUMCVv6WTHzYV+94d/p1B0KVlE9HXqF3z7WtTiR+Gf4j8AIFMWL3p5V/h99wx4LL
	 UxTE5AQfP4eu8ynp8SQABvcpVpk1hDViB1Mk8hskWEV1VNzUa/4UWe+866Xypf9HGQf/d
	 4qw8ww3vwWQi2cXGPS+C4oEMLDfLLfleB6S3sbU2P+YyoQxSrdyIRtVDIABWWBEnh1g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794552117;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=dJ5r1MeJy/NBjpUZvrwuqBzTMjcmrVWR8gIgDHHQN3E=;
	b=DJBeNcPDGJu8D2wtvdjaPhZE3P7dXHgcGVF0+lTv2vJwhbUYA+BJkkDkfEQI39qlNhq/
	 0+VyYxzxHh6rRDJCH9G2cwVdM2ALljxpo040iLn0uAiWYTKJO3iGVmc5nAD8M//gZNBM+
	 FAnDofsHcNmWdW+U0GZ2Zj2N9u1eIFThjJkafUChsS/iCxN3h5K36RjQn8vG41DjqscUT
	 u2HOHkErVEnjERFelrnyB3BAXPFff192nUAOgHek7RBCScgjSJy6giIC9qgjbtgwrbHJx
	 RdmNrN8oQjE8GZB0SeJavFQEOVu9rTaLrOMwPXYpwED/FkGQjwpZWAfCr380E3z8OvA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 226C71F000C4;
	Fri, 13 Nov 2026 06:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794552117;
	bh=dJ5r1MeJy/NBjpUZvrwuqBzTMjcmrVWR8gIgDHHQN3E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=PZozunrVeTaHxcyZC/hF5CWx8fiPo4aEa/hHorxDT76N19/ELNHptJn8pZ0ZEAhNJ
	 jiEfGGgjERRGUT5IubLmNDSBEWsfOxumku0Bdvt2ZjZPtlbEHVplw9aBkVVWnfcR93
	 durfjFBG4tRKZL21u6wlxHA1TZVNplbRAkcEnXCDRkRQ1VEFzLRTFZr1BQha18YWuI
	 +Y9Wbsoj03WjJSTekodXRP5Dq+0BETpxaZFxQfApb1EuRYuRAUQ2rA2kzCnRbwFsnt
	 TuQJbTYb4R7doe/M5ddatQOSXEpSriThC9l3TNqlJ/4He8NuABx7jRyPULfp/JTQRM
	 Fs0aMFXDef0/w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BD61547662;
	Fri, 13 Nov 2026 06:41:52 +0000 (UTC)
From: Joonho Lee via B4 Relay <devnull+mynameisjune111.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 15:41:55 +0900
Subject: [PATCH v32 11/20] ALSA: virtio: wait through signals for PCM
 teardown
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-fix-virtio-snd-recovery-final-v32-11-4e95979e312c@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v32-0-4e95979e312c@gmail.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v32-0-4e95979e312c@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.com, perex@perex.cz, mst@redhat.com, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
 linux-doc@vger.kernel.org, Joonho Lee <mynameisjune111@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794552109; l=4583;
 i=mynameisjune111@gmail.com; s=default; h=from:subject:message-id;
 bh=tEix76YRDAosF5mQRnWaN3Vu/4kcrFqCkypzESSrFfM=;
 b=RrkOKo4ct8zJxF9NU0ceFi1tEdljuHE3VHpQqW0p9/bj9v3FpdDUF+SFta0oaGudttL+X6LEl
 kEYwvcB8kLHDL/gsXVoqtG3/CXwpucFikXgs5+ZXc9IMboqr3gotT5e
X-Developer-Key: i=mynameisjune111@gmail.com; a=ed25519;
 pk=wqkZdvfcC8g8fDi6f0Y58LlaXIo+ubf6Y/9Lr9yhshc=
X-Endpoint-Received: by B4 Relay for mynameisjune111@gmail.com/default with
 auth_id=1508
X-Original-From: Joonho Lee <mynameisjune111@gmail.com>
Reply-To: mynameisjune111@gmail.com
Content-Transfer-Encoding: 7bit

From: Joonho Lee <mynameisjune111@gmail.com>

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
 sound/virtio/virtio_ctl_msg.c | 19 ++++++++++++++++---
 sound/virtio/virtio_ctl_msg.h |  3 +++
 sound/virtio/virtio_pcm_ops.c | 10 +++++-----
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/sound/virtio/virtio_ctl_msg.c b/sound/virtio/virtio_ctl_msg.c
index 07df43f923f5..7de20c3da9c2 100644
--- a/sound/virtio/virtio_ctl_msg.c
+++ b/sound/virtio/virtio_ctl_msg.c
@@ -265,7 +265,7 @@ int virtsnd_ctl_msg_send(struct virtio_snd *snd, struct virtio_snd_msg *msg,
 {
 	struct virtio_device *vdev = snd->vdev;
 	struct virtio_snd_queue *queue = virtsnd_control_queue(snd);
-	unsigned int js = msecs_to_jiffies(virtsnd_msg_timeout_ms);
+	unsigned long js = msecs_to_jiffies(virtsnd_msg_timeout_ms);
 	struct virtio_snd_hdr *request = virtsnd_ctl_msg_request(msg);
 	struct virtio_snd_hdr *response = virtsnd_ctl_msg_response(msg);
 	unsigned int nouts = 0;
@@ -273,7 +273,7 @@ int virtsnd_ctl_msg_send(struct virtio_snd *snd, struct virtio_snd_msg *msg,
 	struct scatterlist *psgs[4];
 	bool notify = false;
 	unsigned long flags;
-	int rc;
+	long rc;
 
 	virtsnd_ctl_msg_ref(msg);
 	/* This reference stays with the queue until completion or teardown. */
@@ -314,7 +314,20 @@ int virtsnd_ctl_msg_send(struct virtio_snd *snd, struct virtio_snd_msg *msg,
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
index f867b9b9233d..d84f0740fcb0 100644
--- a/sound/virtio/virtio_ctl_msg.h
+++ b/sound/virtio/virtio_ctl_msg.h
@@ -47,6 +47,9 @@ int virtsnd_ctl_msg_send(struct virtio_snd *snd, struct virtio_snd_msg *msg,
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
index f40a9f3cd2a3..a5a682534acf 100644
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

-- 
Git-157)


