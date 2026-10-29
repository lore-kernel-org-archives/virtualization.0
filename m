Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793252650;
	b=rNjrQ5tay9mBb1RshyQ/yXXnQHOia0CylTCifLMvz5rCOYcHjPVImyCnTk313cfks9Hs
	 fHKJu0JzYBHg/BggUlTD9A0TghvnOODDUSkDKYqkaND8VnfNdHEJrB0rl5pIokhhJ0d3i
	 chEnuo/9BWAKrN2s+uw/m6Mp2L9TYW5sDgv4cmKSbcVVHTbN+wJT4BH91aSiWthMBuSnE
	 Yvx+776eC6FeUqQY0FYpn32W5vhctPMIdZ8ac0kVIUFaafFoWbX75yNeQF8W6mtfWd2kK
	 7nAsz+I7sei4fTItbKCiqwGot6rNGFLHrnX3QUKA5pID2UNZ5ccbDxmccXPeDXA5SMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793252650;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OpwHiZYTLatyvvxjRUM2hdadeePr4pZBh/g5i6VGeuQ=;
	b=o45k/akjfRpg/3biGWcw8XCqkDgyUqTaU8FofScO0PVN5I6BNFvZ2uu5sMU3aeimAHJ9
	 iGVbSrI7I8zM0ukPmt3+7tB8q5R6gnoN1Dvihr1MYxOchUpyrPtYp6xIoSLqfcIwja7Kp
	 nvVdxSVQ1POlyd0b2ZJVvxCSlMJXlsSWBK1KQ+LJVvltUQOMd7Rw/rZWcvAkKdXQ51rrx
	 /PyFLgmrOe5/deoLQ8UynDSFZZEVSHN4oypiMLaBq/QQ1gp13zpBRmNN/pSDriNNofKku
	 E1P18v7KtDTaCSTGefUyZLlFZI1okij3hcVhUvjS2KU1ez8v9iRsqWym7lk54yo8l/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="m/YZA4iC";
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BAD606A31E
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 05:44:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50BAD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m/YZA4iC
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3acb512a7a0so1086270a91.1
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 22:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793252649; x=1793857449; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OpwHiZYTLatyvvxjRUM2hdadeePr4pZBh/g5i6VGeuQ=;
        b=m/YZA4iCRzsbEq+9gSbdbhd9e+OFhbMLqubdiymtSEiLLTlRajRkGWulsdAo3+tFhh
         gSs1k3eYhUtioAZPr9GiFzUnAWc6VX+gw0D1HuWoX47yXR8g0Ho5KCsi9FIkLvHxbeE6
         nn90y6bdaZJ2344oAgUQKpSjFMA9Y9HPUc9ChPtdXVHBMKZNYcKdCjycmmJgQSeLw2Ln
         Q/HnuPqmjbgNIjAX6JpV9+2mjKqYS8MbFkKFbWVGL6QjZpj1d/0QTac8xVCq+9P1y09S
         9NLii9rN4IlrrfeATp+nLP571zmDfjKOJZJ8SGSILTkLa1RG6mbc8ptpmPUGNBFl1g6j
         8enQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793252649; x=1793857449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OpwHiZYTLatyvvxjRUM2hdadeePr4pZBh/g5i6VGeuQ=;
        b=XgsKHKnJoySlPQ3y3XdRwydhMS9S/zEfqAe9EyE5UQH7wKwDmjvUXqcNz+3rvnZNrZ
         IiWvqMLwbRn67EiBeebxhiFo0Sg3PNhqOSCHinclT7zAfj41DWnVcrcsV5+kh37iT8/T
         g9PgVWa8hvkGBek0MtyBPCGpWvD/AVPuC0RLWqYnxcGvPgk1IYuehPFiFJh+UuBAM4J8
         LgsejjaFZ+/pzHwCyd6SGwD1T0qmYx3qDAuqexvllBpxjDm+JbRiawCGgPsJmEFusLgH
         rYeiJ8ekkSh7eR+cIkP7OuQKTam8pA4rIZlQOMwcHp9hcxPixJC4OZrGlYRlG1oz92Re
         hJYA==
X-Forwarded-Encrypted: i=1; AKwUvBxL+rMrtx3ZskRE+jLjjsseiMwzPiIajev4+1j5cPJwp5V2B1mc5yxzXA6e7rMNOJq08kSSHyVhvvEmdWnlSw==@lists.linux.dev
X-Gm-Message-State: AFq9FYL26hQQR5madqVV6x1aoGPu8MvKvKXdPjOZFER5plX5U0ePdkdG
	sKj1WpdsJYhV5VeTiS+9EuRaPDFo10HQYrA1Za1iC89LA8O/dhJTB/Ov
X-Gm-Gg: AYBFou39r07exS2Yn+jPKrtmSG7hpnN0UWzv89hDGRGYXOs5X6WUYLDQ2N9aTM+tGTA
	8mpMhHLB2BkOxke8ROOciyx3npJYIkvqwUXzs0G+OJoraazPhrxJOZGoWhQHC7pfSMXEAKtg7bp
	l5Asfd8AhSSMj3HT+MQIsXHdcD4jML/1nP4wtP48Ll7LNzCojgxmbEjWpEee8ZNWMu731dsxDkj
	ZxtOzEGdpjbanZu5E1kt2r+NXaE60384ZCe5FgYLDOS/fcRhJYAxVLkpxXc7P2CxsQ3Q3/17nO8
	P505FQLIH8BOTOiBuvpe1Be05m4jdnq1y2xVuYwxhtKTI9yfyS/fjyYZ1MDW6VU7utaV5MkGNOW
	TetieHzNbUATsYD280wPwG4MAbuItsl0t8BH6/KLoXmUaU680IBCMrJ14+xW+KMHg1sOOqCArrI
	mOB+GiR575shOI9L1elmwairqxapqROorpBZkpvzjLp03i8L8/LQQrWaZPaM203c6OvI8XfUtiO
	oPiJjd2iMlXpVR46njbFSq01r/4dKId/89oo7Lcx1yU8HM7BI51YZx53vdwX81ZqMjsTqMkn/8t
	js3EBIaprF9smNNY7VIG7g+XfXm8iZPXfwKBybfjPr3DD2e/tqGczAY8DU0QtnotttNvBXuREN7
	7r9zcNck9vbNPmytMJuUCGlDN8JjSg1toOFFmWt6FV6ANvbw=
X-Received: by 2002:a17:90b:6d0:b0:3ac:7556:8ed9 with SMTP id 98e67ed59e1d1-3ae58169cf5mr3260196a91.10.1793252648579;
        Wed, 28 Oct 2026 22:44:08 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e83127csm2433520a91.10.2026.10.28.22.44.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 22:44:08 -0700 (PDT)
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
Subject: [PATCH v8 02/14] ALSA: virtio: Recover PCM state after a failed start
Date: Thu, 29 Oct 2026 14:43:42 +0900
Message-ID: <20261029054354.2931-3-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261029054354.2931-1-mynameisjune111@gmail.com>
References: <20261029054354.2931-1-mynameisjune111@gmail.com>
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

Capture trigger queues I/O messages before PCM_START. If the START
message cannot be allocated or sent, transfers may remain queued, and
ALSA does not invoke the action undo callback for the failed trigger.

Mark the stream stopped and disable transfers for every failed START
path. Arm runtime->stop_operating so sync_stop releases pending I/O and
prevents prepare, hw_params, or START retries until release succeeds.

The stopped flag is shared with ACK callbacks that can run without the
ALSA stream lock. Protect every stopped access with vss->lock. Read the
pending message count under the same lock in open and hw_params. In
sync_stop, decide whether RELEASE is needed and mark the stream stopped
in one locked transition; leave it stopped when release or draining fails.

Always cancel elapsed-period work in sync_stop, even when no RELEASE
is needed.

Fixes: da76e9f3e43a ("ALSA: virtio: PCM substream operators")
Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
index 8837dfc12828..8048b14e6c80 100644
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -26,13 +26,13 @@ struct virtio_pcm_msg;
  * @hw: Kernel ALSA substream hardware descriptor.
  * @elapsed_period: Kernel work to handle the elapsed period state.
  * @lock: Spinlock that protects fields shared by interrupt handlers and
- *        substream operators.
+ *        substream operators, including @stopped.
  * @buffer_bytes: Current buffer size in bytes.
  * @hw_ptr: Substream hardware pointer value in bytes [0 ... buffer_bytes).
  * @xfer_enabled: Data transfer state (0 - off, 1 - on).
  * @xfer_xrun: Data underflow/overflow state (0 - no xrun, 1 - xrun).
  * @stopped: True if the substream is stopped and must be released on the device
- *           side.
+ *           side; protected by @lock.
  * @suspended: True if the substream is suspended and must be reconfigured on
  *             the device side at resume.
  * @msgs: Allocated I/O messages.
diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
index a40ea394bf17..970499fe419b 100644
--- a/sound/virtio/virtio_pcm_ops.c
+++ b/sound/virtio/virtio_pcm_ops.c
@@ -96,6 +96,15 @@ static const struct virtsnd_a2v_rate g_a2v_rate_map[] = {
 
 static int virtsnd_pcm_sync_stop(struct snd_pcm_substream *substream);
 
+static void virtsnd_pcm_start_failed(struct virtio_pcm_substream *vss)
+{
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		vss->xfer_enabled = false;
+		vss->stopped = true;
+	}
+	vss->substream->runtime->stop_operating = true;
+}
+
 /**
  * virtsnd_pcm_open() - Open the PCM substream.
  * @substream: Kernel ALSA substream.
@@ -115,7 +124,8 @@ static int virtsnd_pcm_open(struct snd_pcm_substream *substream)
 	snd_pcm_hw_constraint_integer(substream->runtime,
 				      SNDRV_PCM_HW_PARAM_PERIODS);
 
-	vss->stopped = !!virtsnd_pcm_msg_pending_num(vss);
+	scoped_guard(spinlock_irqsave, &vss->lock)
+		vss->stopped |= !!vss->msg_count;
 	vss->suspended = false;
 
 	/*
@@ -217,13 +227,25 @@ static int virtsnd_pcm_hw_params(struct snd_pcm_substream *substream,
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
 	struct virtio_device *vdev = vss->snd->vdev;
+	unsigned int msg_count;
+	bool stopped;
 	int rc;
 
-	if (virtsnd_pcm_msg_pending_num(vss)) {
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		msg_count = vss->msg_count;
+		stopped = vss->stopped;
+	}
+	if (msg_count) {
 		dev_err(&vdev->dev, "SID %u: invalid I/O queue state\n",
 			vss->sid);
 		return -EBADFD;
 	}
+	if (stopped) {
+		dev_err(&vdev->dev, "SID %u: stream release failed\n",
+			vss->sid);
+		substream->runtime->stop_operating = true;
+		return -EBADFD;
+	}
 
 	rc = virtsnd_pcm_dev_set_params(vss, params_buffer_bytes(hw_params),
 					params_period_bytes(hw_params),
@@ -273,6 +295,16 @@ static int virtsnd_pcm_prepare(struct snd_pcm_substream *substream)
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
 	struct virtio_device *vdev = vss->snd->vdev;
 	struct virtio_snd_msg *msg;
+	bool stopped;
+
+	scoped_guard(spinlock_irqsave, &vss->lock)
+		stopped = vss->stopped;
+	if (stopped) {
+		dev_err(&vdev->dev, "SID %u: stream release failed\n",
+			vss->sid);
+		substream->runtime->stop_operating = true;
+		return -EBADFD;
+	}
 
 	if (!vss->suspended) {
 		if (virtsnd_pcm_msg_pending_num(vss)) {
@@ -338,31 +370,40 @@ static int virtsnd_pcm_trigger(struct snd_pcm_substream *substream, int command)
 
 		scoped_guard(spinlock_irqsave, &queue->lock) {
 			guard(spinlock)(&vss->lock);
+			if (vss->stopped) {
+				substream->runtime->stop_operating = true;
+				return -EBADFD;
+			}
 			if (vss->direction == SNDRV_PCM_STREAM_CAPTURE)
 				rc = virtsnd_pcm_msg_send(vss, 0, vss->buffer_bytes);
-			if (rc)
+			if (rc) {
+				vss->stopped = true;
+				substream->runtime->stop_operating = true;
 				return rc;
+			}
 			vss->xfer_enabled = true;
 		}
 
 		msg = virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_START,
 						GFP_KERNEL);
 		if (!msg) {
-			guard(spinlock_irqsave)(&vss->lock);
-			vss->xfer_enabled = false;
-
+			virtsnd_pcm_start_failed(vss);
 			return -ENOMEM;
 		}
 
-		return virtsnd_ctl_msg_send_sync(snd, msg);
+		rc = virtsnd_ctl_msg_send_sync(snd, msg);
+		if (rc)
+			virtsnd_pcm_start_failed(vss);
+
+		return rc;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 		vss->suspended = true;
 		fallthrough;
 	case SNDRV_PCM_TRIGGER_STOP:
-		vss->stopped = true;
-		fallthrough;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		scoped_guard(spinlock_irqsave, &vss->lock) {
+			if (command != SNDRV_PCM_TRIGGER_PAUSE_PUSH)
+				vss->stopped = true;
 			vss->xfer_enabled = false;
 		}
 
@@ -393,21 +434,31 @@ static int virtsnd_pcm_sync_stop(struct snd_pcm_substream *substream)
 	struct virtio_snd *snd = vss->snd;
 	struct virtio_snd_msg *msg;
 	unsigned int js = msecs_to_jiffies(virtsnd_msg_timeout_ms);
+	bool need_release;
 	int rc;
 
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		vss->xfer_enabled = false;
+		need_release = vss->stopped || vss->msg_count;
+		if (need_release)
+			vss->stopped = true;
+	}
 	cancel_work_sync(&vss->elapsed_period);
-
-	if (!vss->stopped)
+	if (!need_release)
 		return 0;
 
 	msg = virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_RELEASE,
 					GFP_KERNEL);
-	if (!msg)
+	if (!msg) {
+		substream->runtime->stop_operating = true;
 		return -ENOMEM;
+	}
 
 	rc = virtsnd_ctl_msg_send_sync(snd, msg);
-	if (rc)
+	if (rc) {
+		substream->runtime->stop_operating = true;
 		return rc;
+	}
 
 	/*
 	 * The spec states that upon receipt of the RELEASE command "the device
@@ -421,11 +472,13 @@ static int virtsnd_pcm_sync_stop(struct snd_pcm_substream *substream)
 	if (rc <= 0) {
 		dev_warn(&snd->vdev->dev, "SID %u: failed to flush I/O queue\n",
 			 vss->sid);
+		substream->runtime->stop_operating = true;
 
 		return !rc ? -ETIMEDOUT : rc;
 	}
 
-	vss->stopped = false;
+	scoped_guard(spinlock_irqsave, &vss->lock)
+		vss->stopped = false;
 
 	return 0;
 }
