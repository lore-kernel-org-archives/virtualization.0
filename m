Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794561700;
	b=3JDT/O8Otc0mAA15q823M6CtTz9QZUNwwlPBR0nHmns1H8VKj0HdogC7B9G8Pskr4f/F
	 FfPMzlSaiQcFW1A3Bm1Z+jv5AAE9s0U+GRl/4G8cyGbL0dJAzz1Nmk08CFL775hMBMwzN
	 Tq3Yh6MsA5rquvXbV5/3286Sti4MFNSdY9AIZ1UKQBnf14Gj5zJbPXb4R+WVXqxo9tgTu
	 aq6iGoLKWtIlZ3bfHwfQ5m1u/ZcwPzggcSXlxzyzdEqz3kE0jNQZALBykvjFXO4cLP7T6
	 UsMuVWFtCkzbduMQwOSjPwhAqCVIKlfKX84hrvD95FLYGsYeSt1i55v3bhdttGoVEew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794561700;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=dJ5r1MeJy/NBjpUZvrwuqBzTMjcmrVWR8gIgDHHQN3E=;
	b=VECfweZ/V7dwymgrT0Mc/kD2FerRx8jhfF5DnFyjwBb9riIMZRmOwRXhna9PvC5RcKP6
	 Cghw3s+NjlCxlrRkasrFmhIuK6iTiEOPPGkuZt8mca3BtJkcL+v9739/UrvgC1XDgmHPh
	 3Hg29Si3p6jd/SqEG4+iB7w52d49+L74uCzslHwdJqancBYNOR8WFAQxvn8WUzgwee7iy
	 SrI6tLjrlfWG0SRwQbhD89QLftlve6oR0fQpuImAbm+aSVsBA0glAKe1SFH5JW6cYv8B0
	 XJo2X6+6gaQg7ir6Hh6/pYvxM+ougwuVtVptiDCHYg/l5OkX6bXq7NtHXms752G51SA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dVDm/hSA";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5A460A5BC3;
	Fri, 13 Nov 2026 09:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dVDm/hSA
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794561699;
	b=L+Bg8als0eRuI7yVjsR1MRgl7B/uStESgH6jYWswV0AUr12cXiQSFHv4cGTus3vB3xdE
	 RupcvRaJW1gkNbMSJfeTNaqGHjYHwM1WY8kioDzeoTzOQDf/DJU42IPmrzNrht3x6gZOW
	 hd3z6WPz3GaBrmLmVjfDQQcP0FsL+CwJ6sCSuYxV6eo6b2wvc19Gww+jt+IAZ9hTqxGNG
	 oEO5sivH250iPoQSNMRYOQ2SBVf5tKAC8Zv8EV4RPt2/TKF1WgTW6Hn/whQg3uSkAWDFP
	 6buZLr5vMoKqdKZnY6Dfh0aRs9mHrnTuD86sucf/GgIrpPF+BX7eCBitC9YRLuVg7nA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794561699;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=dJ5r1MeJy/NBjpUZvrwuqBzTMjcmrVWR8gIgDHHQN3E=;
	b=yjVKRTi+VYADdfYTEck5u6EtH+cR+JMbTiPpW3rlUsYIy11q9CiBdQ0Vmutm+8uVfT2G
	 T0Om/SQOvxQrVSPMt8TeC3j6AvREnIMadLkj1s9f2QTUDghAuOreo4hKZe/9+9N8Eo8Uc
	 gAYp9f45FHKM7A2HgBThMZyqbIXhDXVznBMz1FJERdvOYZz8jDCmniORhnaiUdTP6a7gg
	 riYhSXNNTmbehDQkRLDi/Kb3wm5bg+4VNYQ7NnCe8GTE5ZpNAEs5YEbw/jIoZXURYKNZ4
	 HQ38hG8Pm8jEP4UQ+27636hOTyhjorGbZpzb9sAHkn1i4n/65GPDY53M4z0BXUfmE3A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4B7631F000C8;
	Fri, 13 Nov 2026 09:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794561699;
	bh=dJ5r1MeJy/NBjpUZvrwuqBzTMjcmrVWR8gIgDHHQN3E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=dVDm/hSA3vre3qIUmx8iPICBP+1Fs/U2mtr5a++nEWS99hL2gtC/o361KGKOvWMpy
	 YFAoNSA7BQKJ5Ls23UXct1Ayu1h1U3kLI6RWq8dKGmmHAO43vliBbqchC+yKWE3dGk
	 t0I7a8QWnxTtEmxdkm3Xzk05X75O50SiqiZVXWlNaGlPq1QfhPpCRKvS34kQ0DcZyZ
	 3lpHnSwQwkqQ4gzy2iquFrtHWX7FAH1LtlUhgxF+tjPQoQ01wPWXDbq+U0n3PH8tpE
	 yVW2KTxOUp1xMEY+GfqBgfXQZc4gJQjvsWBadRP/yBUevgtH/Xoae5klYAlg34OGCC
	 pNtlF+PtcBElw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2A55947730;
	Fri, 13 Nov 2026 09:21:33 +0000 (UTC)
From: Joonho Lee via B4 Relay <devnull+mynameisjune111.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 18:21:35 +0900
Subject: [PATCH v33 11/18] ALSA: virtio: wait through signals for PCM
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
Message-Id: <20261113-fix-virtio-snd-recovery-final-v33-11-13a934ad5ece@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v33-0-13a934ad5ece@gmail.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v33-0-13a934ad5ece@gmail.com>
To: linux-sound@vger.kernel.org, 
 Anton Yakovlev <anton.yakovlev@opensynergy.com>, 
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: tiwai@suse.com, perex@perex.cz, mst@redhat.com, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
 linux-doc@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, 
 Joonho Lee <mynameisjune111@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794561688; l=4583;
 i=mynameisjune111@gmail.com; s=default; h=from:subject:message-id;
 bh=tEix76YRDAosF5mQRnWaN3Vu/4kcrFqCkypzESSrFfM=;
 b=ZB+W7XO21/oqPvbyW7JDscBxFPyd1oThoxmZPPVY0GvjVZxc8bol88XCtPqOL2UZlzsA9Zje1
 8A4Vbvksj69BZ4f7zKcALHP9+oRDvb4rFkf/LtLUeY0orNknGNmFecl
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


