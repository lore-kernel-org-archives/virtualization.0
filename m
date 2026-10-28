Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180545;
	b=4Hsf0/oS0QGM+uuM/Z3fOQXwK/klcHY1TA473k2ILIMBsSrl1MQxsme4Js1top/0uLWo
	 Q1AN+/xmt0PYKomu4hnroLJVBtpYDnd3jTLYgNNp5MHNrAwrDSICNkWPDSg0x7uWdcUrt
	 C8Vn5sUBFkIidXfLpgifot5Z8E6N0RkIwnXGUc8+lKTtF4wFBajXzEh88Ul7EggAcOCCj
	 MuAfUuQVokpD9t6J2RXpxu3mlXG9MebKMvzec6q3BUbdHVjHcTQAxF21lACAMTC7XtjGO
	 SG3x8PS1p8TKT8B0XH2nvs2qSEXyfnNB39BjqPTI4LxAgEOjhUYpk1QxlPxMf5gCyIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180545;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=e0mMfJ0fqf1GYFnHKs3FyJvrBnGJbFvp9ONWbll9TzY=;
	b=BEVaAiKD2IKqrUm31nse8NRQW9b5FlKgypEcfn4U8CfoKgnsLE8pUuCiSr9Y1jXDPiq3
	 cRQM45Uw/UnWlJfc0paoWt6GIEWrj/6hRhPxF6pjOtaf9eG5G922g1V6KI/VKCDjRRxBR
	 bePV70USFJ+WZ8sHtzCSNPKPeL5F9ysQ3TBig3ycbBB03aRUQHPWEy6iTbnmXVqfQ/7lI
	 53hHnz93SxaVY42KPh9R7FqOjALkKgrf9CHpaouHJrmALcuo6W6oiIyIxuUlqcvifzoyJ
	 ClrMWXtVUqwA2V3POgC9wjjedEiXjQ0ci27wZZicL6+Kw7fBkiSebSsGHsj654CzKTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kvhYxoAl;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1735606A32F
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 09:42:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1735606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kvhYxoAl
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cdac6d19ddaso374985a12.2
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 02:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793180544; x=1793785344; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e0mMfJ0fqf1GYFnHKs3FyJvrBnGJbFvp9ONWbll9TzY=;
        b=kvhYxoAlzbgawy76OgMXenA+rlqCgVlPtOgV+GZVIsX5wGM0cA4zSDMODO6by/wxR7
         jh0A9xXeN8NNoSR6kWcCbwvrr+809x0NbeAYDG9lOzinGnBZ175mVWfLoJH19KaVv8Z6
         D2ZWBTRPA6+ha+hXIYvYzERi7o1X6WE3+XT/U4MCnmupTsk1ih6rPxS1TzSlt9sfui3W
         l/v0BQWFoK6zEjOR+tjcR1d9n4D0gtTRWVNz6BRfm/diszgeBx35BCDy3z8W41k4nWGQ
         aicwyT2M36gf2HuugE65kqK+WmgOISnsmWg0JT6ED8Sd/UX+W8XGXD5vkKkKbfesJIei
         eoqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793180544; x=1793785344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e0mMfJ0fqf1GYFnHKs3FyJvrBnGJbFvp9ONWbll9TzY=;
        b=ZtdXoYpkdtfhuy40StPzGcri3KF6rxBTlbrzaIn+IsTud2FPf+UACmJFESz/wkYCqJ
         JIGA4EJIVDHOS8Q1rIof2WIIYEp32H86HKRXqHskbVo0M8URzzjJaN4lZyWrK97ZiMWH
         H6Djv/z+6guIyiTl8o0IvSyWp+J4tvgPNoteIn2bPRst08vIlAm7xkX233d/SfY5cT34
         AjXycHiQVDKh82YvCbrnVNQHSvZRXpieJfipU/IF4I6GIjMeU+zl8W+dudcrGqZ0cy0X
         vn9S6DcH4aiMho2oJuBm1UTH9P0QVebHlv/yhsfJU6iKNmlcWsVpykmRa926qnGHwPJk
         q9fw==
X-Forwarded-Encrypted: i=1; AKwUvBxvDiUF5sqFZVqGQY71Bj7JFuW1dPtomNl77GYjFTsUI4Hxr3e398/6aC32iQ+NU+Y8nSPo2u71smqp1V6NSg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJjCzNBwxk3aNdMGqZUnx/XoOnrOzOqAXxEFiWQPfburPrpENsT
	mZDyP3h+LbFLQlwPZDT+QdIs/tZaLeVZ5X/58hx/w8qj71quK85BZ1I6VI27/w==
X-Gm-Gg: AYBFou09Y2mYk/NM4j26qy2oTc/D1y8rVeGOBkvg40oUjFo8g5pBSjwYcU57mf3ufpC
	YUtBltnJDU/QUJGAs6/F7c//8akvKuEi0hWzHFrrqKaKaQ/nqBPZrDRJ35naEHHWLZ656TNPXhx
	ALS+mFU2T+8r7+FSMGpfUmnK/k4j5FhHgCWl7Ln8gOV95S1iSXuUKjuZ4E8Wvtc6d9Tz7EDV+Qd
	475dCei4ZgL772cDFT/OsJcsXIXucrCAxA5Tn82fls3OP9W9XTmE3uVp9tcI/I5EZvnKfEiTzhD
	bxaTmvy69t/cuX19h08lexIT1SrM+/91YllZa/apKT8ULeAxCoO2+ttBmVXgDeKAEMgMjieMDGu
	LNFPKAC2MFmk89iCS7YrOdyA6nzWNlMDfHoeSCl5ssZCh6kA+t9aWlLo0+myzbkle33sJVGP2qK
	0i7GnLyNvGAJaPKY8kNhOZgh3e/jEooypn1lU+Ji+6EMBSAtUMKW7+6/iiyp6uLpI2LeEQ0XzkN
	OUkS4ZGQ7o4nopI7mDYqYkPER22Mva0TDcgiaoqfqcdo98YHPzQqHb1C9LLJjtNleG3MKmvwsqD
	3Nr+gzeS41cvI3VNEXK5JAs22U9rDJdGc7W8flEAnA2f/hK/Tw83QXq/bKbx5TR7czNeWlLw3I9
	sHp5uVYDrn0wTWxUade+SKb4XVzg4slw9mdPBOSW2zvVnN4Q=
X-Received: by 2002:a17:90a:d603:b0:3ae:3f20:7056 with SMTP id 98e67ed59e1d1-3ae581d39c6mr1322287a91.31.1793180543926;
        Wed, 28 Oct 2026 02:42:23 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a93b3f5sm2242377a91.5.2026.10.28.02.42.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 02:42:23 -0700 (PDT)
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
Subject: [PATCH v7 12/16] ALSA: virtio: complete control transitions and preserve drain tail
Date: Wed, 28 Oct 2026 18:41:28 +0900
Message-ID: <20261028094132.20364-13-mynameisjune111@gmail.com>
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
