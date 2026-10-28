Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793156043;
	b=NLJjRORv8wXn0XxkxcAHmOcXomhgJtvva2W8Wz2TsBTv96+PsUbdXzLLwGztNL+X9Rsl
	 DPl93XYPYzuSiuRwf+7HowKJbVSSphSWott/Jwat2zKfse28zAweNDVoetOtM4kci2Uxl
	 ZTF0KbbNaegVHjNmWoY7jZboTySJ2GmfGtZhhovb6EZt5HLZkmfXiHcs9sYBseuC5ynHx
	 ePcrAjHVkIiwTS24qv6hiZus8bbpxdpmjYvtvLJKmzTpAAvzB6dI99nawk69lMemG8AlT
	 4H3UgAf0cdAIVQ8NJP4qeIHrgoLj9Xt4xW4k7ATZObGPTTHM90CqUy5GTXD5lf7Idgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793156043;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=e0mMfJ0fqf1GYFnHKs3FyJvrBnGJbFvp9ONWbll9TzY=;
	b=AHRq2WJsp36eZvhMVgrs2oYVLNIc9YXuLRLsauxyPJije2y5hiprnBQcvAy/3MDn+98w
	 VyBpOZbggQzZYfP87x3zGAqCHhZPlK/V2KNZAMC3pFloGy3AQuzRAeCNeCkgwT1V9JJDU
	 9R0e+NF+bgMiANEGMvFXnbild6TnjYAFqeCauR6/kQqrsI41EvIDUuVIlvWAsoTVq0SXu
	 rRQ+ZdAP7Jx/5C+J4HXUjJ+hvjNtdbEPFFOWAWpsEIMBQe6iITDo9rNi9TLp9bJiA6QLI
	 oyAprMVXv4byMKaHCOW2nbgD6cE0SRAKtHJFOm80f7CIoxlpRsWs2DI8Y+SePch3QLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lLJHS1IM;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19BE60A2634
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 02:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B19BE60A2634
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lLJHS1IM
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-353804b591eso832274eec.0
        for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 19:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793156042; x=1793760842; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e0mMfJ0fqf1GYFnHKs3FyJvrBnGJbFvp9ONWbll9TzY=;
        b=lLJHS1IMiyU6qadPa779u2ZpZXgF1L8w63JQQHH24fvXlmtT2BCGCiKrFSZ2ysCb8X
         x06PfHafEi/gn44h5oSBXipsPFTTrqEtkwUsDX9dR9nOJ779Vhxas4+52ojvskxczfOy
         cz00VCE5Db4CLzjqC5OliLqnkImeIhaioaLZHryEXW0EYGDl4OTVZYAdu/JZrUGyQnVR
         8SeosISwEgXjdWkfiZF/afzBpI459JxpCVrZbwqebSOGYgjG2YQ/kUzEJD7gmQAHbZ24
         EtBisXl0Ngc406MkQQ84w9dWdT+zTZ9t2fc09s3dvJ8xvkJ+F0vdQ8MuFV17sWQbxkMK
         jijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793156042; x=1793760842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e0mMfJ0fqf1GYFnHKs3FyJvrBnGJbFvp9ONWbll9TzY=;
        b=ifxFjVfYMNIoRHw4SBQTf9cqCuHo41hbaf0ox+Hia6tNKcwsCLNjmC6H5dqC+9ZUiZ
         hyWTq4XxwyNbkNgcilApzWyHtBwgqlcfRgQstKDe7RFrbsseshzPepHGD/JYTG7rvBv3
         CiWklBp/98CAWNE9UbntnLH2BCxr/9Bs0DXs4skFHsPDyy9r4cXtkKdRt0l94KNcr233
         aGsvpYmuwlyp6VfMYQdyZ7VYl0scQ457c9RNYcH5ySFWv0xR1GXBv3Idy+pDFI9xotWj
         L3shvde13CaCnd20MbOmto3bL27YmSifvonuKzfcnaqNA32IxrejikhEYarh3YFDc7s6
         zKew==
X-Forwarded-Encrypted: i=1; AKwUvByhSHPrOuLI1CHd861V27B+cfmpA85FlPxYdr2Wg+NzMhfkB8IWI9fWh3XSg6HHAwW0rzF5ZdwbIap6VgfYBQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYILUxWp6Nb8mfQ643jwjPAKkZR3FTON2Btfp1l9U5zPPD06X6dE
	fRQBPn5fDSKMNVcMVzekQtBr1fCQL9LQ4sWM7r/T68JgqGmJrt8Fjd80
X-Gm-Gg: AYBFou2DYCGA4t+MCMmhjF+iLmG761tE5EPqXgdlxheA+mvFXMLUS6QmXJ3FlG1lbgb
	tHMWgs6DqDsqqL5N/XWjqzq6LrWokWvEJDHpEqe722KsESPvSxa3J8hrLm1kmJ/bL6vpLKsUt+c
	54zMCxwKWpSNHTzk41lTegZM/IxKLP84r4PAIKA9AGflK7k+XjzEIDq89xo+XrkgJ8E3TjEtMXQ
	Tx9BfDAS5ZibogwJ3mW77S5WAckN18/mBLXtiatu+x1qPmhEX9wTWnUteL4w45eTWS8Xp3cK0wz
	CYF0rrZiYSpc5mZgmNCrBlDFQnxVnC/JwfEp06C1V5UYE0M9aYzWm8cSU1uj2KZoo+9VWxwUuYR
	ovF/pCv4voGVkmypGN8UDzeeitijzfvn/T951OXh2REDuCntvweIr59UpbXlNPBEdJygD6Oke14
	hJjcfApoHEkd3CdQbkG/eyYYh6X7piH3seNqp78tLFphtd6v0PcuwDgaJKmPWqnZek3SeJvAeFs
	eb636EcPHrI5nK6iYapAsvTmcrsrn4d7pofdRGkkQ/NDg4WUoDuU3Q1iRsIJQ0du/tdQmdOkW8+
	Hl4T/0554PvzCWtCciYa2OUTVaYMXQlxcuz/ZM+8MqmxH24qozN6ipaU3hnvd3Kdwv3MDmprCpT
	2U9yd50F9xWMF3493MBi+h6mLrlvEbJWQDAgYysZceFbkBBE=
X-Received: by 2002:a05:7301:6183:20b0:36a:3ac:b15 with SMTP id 5a478bee46e88-36a203fec6bmr1743372eec.36.1793156041434;
        Tue, 27 Oct 2026 19:54:01 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a239644efsm1711914eec.23.2026.10.27.19.53.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 19:54:00 -0700 (PDT)
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
Subject: [PATCH v6 12/14] ALSA: virtio: complete control transitions and preserve drain tail
Date: Wed, 28 Oct 2026 11:53:15 +0900
Message-ID: <20261028025317.92450-13-mynameisjune111@gmail.com>
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

Pending signals can interrupt synchronous PCM state changes or the RX
teardown wait after the device has accepted the command. Recovery can then
issue a conflicting request before the previous transition has completed.
Wait for SET_PARAMS, PREPARE and START within the existing timeout, as for
STOP and RELEASE, and make the pending-RX drain wait non-interruptible.
Device reset still cancels the wait and the timeout remains bounded.

Track whether a control request was submitted. Expose that information to
the pause-restart state machine so it can distinguish a definitive failure
from a timeout or reset after submission. The next patch uses this helper.

Keep INTEGER64 control values in the aligned response-data allocation
instead of placing them immediately after the four-byte response header.

Capture DRAINING must allow consumption of the remaining tail without
queueing fresh RX requests. Permit its indirect ACK while stopped and skip
the refill in the transfer callback. A non-staged drain test returned
-EPIPE with v5; the corrected kernel returned the final frame.

These changes address Sashiko findings in patches 1, 5 and 6 of this
series. They apply after the included prerequisites.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>
---
 sound/virtio/virtio_ctl_msg.c | 21 ++++++++++++++++++---
 sound/virtio/virtio_ctl_msg.h |  4 +++-
 sound/virtio/virtio_kctl.c    |  9 ++++-----
 sound/virtio/virtio_pcm_ops.c |  8 +++++---
 4 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/sound/virtio/virtio_ctl_msg.c b/sound/virtio/virtio_ctl_msg.c
index e50e6c7..5d77217 100644
--- a/sound/virtio/virtio_ctl_msg.c
+++ b/sound/virtio/virtio_ctl_msg.c
@@ -23,6 +23,7 @@
  * @list: Pending message list entry.
  * @notify: Request completed notification.
  * @ref_count: Reference count used to manage a message lifetime.
+ * @submitted: Request was handed to the device.
  * @cancelled: Request canceled during device teardown.
  */
 struct virtio_snd_msg {
@@ -37,8 +38,18 @@ struct virtio_snd_msg {
 	struct completion notify;
 	refcount_t ref_count;
 	bool cancelled;
+	bool submitted;
 };
 
+/* Caller retains a reference across the synchronous send. */
+bool virtsnd_ctl_msg_uncertain(struct virtio_snd_msg *msg, int rc)
+{
+	return msg->submitted &&
+	       (rc == -ETIMEDOUT || rc == -ERESTARTSYS ||
+		READ_ONCE(msg->cancelled));
+}
+
+
 /**
  * virtsnd_ctl_msg_ref() - Increment reference counter for the message.
  * @msg: Control message.
@@ -296,6 +307,7 @@ int virtsnd_ctl_msg_send(struct virtio_snd *snd, struct virtio_snd_msg *msg,
 		rc = virtqueue_add_sgs(queue->vqueue, psgs, nouts, nins, msg,
 				       GFP_ATOMIC);
 	if (!rc) {
+		msg->submitted = true;
 		notify = virtqueue_kick_prepare(queue->vqueue);
 
 		list_add_tail(&msg->list, &snd->ctl_msgs);
@@ -315,11 +327,14 @@ int virtsnd_ctl_msg_send(struct virtio_snd *snd, struct virtio_snd_msg *msg,
 		virtsnd_ctl_msg_unref(msg);
 	} else if (!nowait) {
 		/*
-		 * Teardown must observe completion even with a pending signal.
-		 * Otherwise a subsequent open can retry RELEASE while the device
-		 * is still processing the previous teardown request.
+		 * PCM state changes must observe completion with a pending signal.
+		 * Otherwise recovery can issue a conflicting command while the
+		 * device is still processing the previous transition.
 		 */
 		switch (le32_to_cpu(request->code)) {
+		case VIRTIO_SND_R_PCM_SET_PARAMS:
+		case VIRTIO_SND_R_PCM_PREPARE:
+		case VIRTIO_SND_R_PCM_START:
 		case VIRTIO_SND_R_PCM_STOP:
 		case VIRTIO_SND_R_PCM_RELEASE:
 			rc = wait_for_completion_timeout(&msg->notify, js);
diff --git a/sound/virtio/virtio_ctl_msg.h b/sound/virtio/virtio_ctl_msg.h
index d84f074..cb5b9fe 100644
--- a/sound/virtio/virtio_ctl_msg.h
+++ b/sound/virtio/virtio_ctl_msg.h
@@ -12,6 +12,8 @@
 struct virtio_snd;
 struct virtio_snd_msg;
 
+bool virtsnd_ctl_msg_uncertain(struct virtio_snd_msg *msg, int rc);
+
 void virtsnd_ctl_msg_ref(struct virtio_snd_msg *msg);
 
 void virtsnd_ctl_msg_unref(struct virtio_snd_msg *msg);
@@ -47,7 +49,7 @@ int virtsnd_ctl_msg_send(struct virtio_snd *snd, struct virtio_snd_msg *msg,
  * The msg_timeout_ms module parameter defines the message completion timeout.
  * If the message is not completed within this time, the function will return an
  * error.
- * PCM STOP and RELEASE wait through pending signals within this timeout.
+ * PCM state-changing requests wait through pending signals within this timeout.
  * Other requests remain interruptible. Device reset cancels and wakes either
  * kind of waiter.
  *
diff --git a/sound/virtio/virtio_kctl.c b/sound/virtio/virtio_kctl.c
index 4cf75de..2b6290c 100644
--- a/sound/virtio/virtio_kctl.c
+++ b/sound/virtio/virtio_kctl.c
@@ -159,12 +159,12 @@ static int virtsnd_kctl_get(struct snd_kcontrol *kcontrol,
 	struct virtio_snd_ctl_hdr *hdr;
 	struct virtio_snd_ctl_value *kvalue;
 	size_t request_size = sizeof(*hdr);
-	size_t response_size = sizeof(struct virtio_snd_hdr) + sizeof(*kvalue);
+	size_t response_size = sizeof(struct virtio_snd_hdr);
 	unsigned int i;
 	int rc;
 
-	msg = virtsnd_ctl_msg_alloc(request_size, response_size, 0, 0,
-				    GFP_KERNEL);
+	msg = virtsnd_ctl_msg_alloc(request_size, response_size, 0,
+				    sizeof(*kvalue), GFP_KERNEL);
 	if (!msg)
 		return -ENOMEM;
 
@@ -179,8 +179,7 @@ static int virtsnd_kctl_get(struct snd_kcontrol *kcontrol,
 	if (rc)
 		goto on_failure;
 
-	kvalue = (void *)((u8 *)virtsnd_ctl_msg_response(msg) +
-			  sizeof(struct virtio_snd_hdr));
+	kvalue = virtsnd_ctl_msg_response_data(msg);
 
 	switch (type) {
 	case VIRTIO_SND_CTL_TYPE_BOOLEAN:
diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
index cbf4e47..c7e85b1 100644
--- a/sound/virtio/virtio_pcm_ops.c
+++ b/sound/virtio/virtio_pcm_ops.c
@@ -1102,7 +1102,7 @@ static int virtsnd_pcm_sync_stop(struct snd_pcm_substream *substream)
 	 * Thus, we consider the absence of I/O messages in the queue as an
 	 * indication that the substream has been released.
 	 */
-	rc = wait_event_interruptible_timeout(vss->msg_empty,
+	rc = wait_event_timeout(vss->msg_empty,
 					      !virtsnd_pcm_msg_pending_num(vss),
 					      js);
 	if (rc <= 0) {
@@ -1205,7 +1205,9 @@ static void virtsnd_pcm_trans_copy(struct snd_pcm_substream *substream,
 	struct virtsnd_pcm_transfer *transfer =
 		container_of(rec, struct virtsnd_pcm_transfer, indirect);
 
-	if (transfer->error)
+	if (transfer->error ||
+	    (substream->stream == SNDRV_PCM_STREAM_CAPTURE &&
+	     substream->runtime->state == SNDRV_PCM_STATE_DRAINING))
 		return;
 
 	transfer->error = virtsnd_pcm_msg_send(vss, rec->sw_data, bytes);
@@ -1360,7 +1362,7 @@ static int virtsnd_pcm_cp_ack(struct snd_pcm_substream *substream)
 	scoped_guard(spinlock_irqsave, &queue->lock) {
 		guard(spinlock)(&vss->lock);
 		transfer.indirect = vss->pcm_indirect;
-		if (vss->stopped) {
+		if (vss->stopped && runtime->state != SNDRV_PCM_STATE_DRAINING) {
 			rc = -EPIPE;
 		} else {
 			rc = snd_pcm_indirect_capture_transfer(substream,
