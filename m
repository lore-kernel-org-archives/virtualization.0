Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466217;
	b=DAvdXtojUOuZFNGPhOVSXdDx0zHChm5GWKMMwO+lTWg1ATUjoOJ/FBQ6Q2d1aAXG1v2+
	 QjYYU3r1CDSQfUqmudxzs0DvK1s/O6XHoeIDAA52Qru6JGf0dUHWZ5+4TfqmF6TAeagLo
	 o8AaT6Y3TspZhPEK1uYEKX7mwBAWSgYXiKw/N7ifZBK14s3YoNygT+gW/u0H8dBYL/UiQ
	 l96HRL5Z+R1J+N2bbYFyKDPN8eAJ87JY9F0oaVRA/KSP12B/BYDeaUVPojvw1+3mxCfGy
	 7eFZDBMArqHe+DrBgnUazBVNE4egoYYQLSHl3pjsT8Pp/TrS6t3hpEd4cqIJ+ooT3hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466217;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=T+sVIbp4DoVMcIWaKe5XqLWovfYHU/r2Z29X5f79OW0=;
	b=KC7fA4EZG3PqofuT3l0Kdl+0hQZpIdzpta1UlAlFnpUVMujg1F/OYvF5LYIXFVOWkOBB
	 0iTtliIOz8hl4ZtB2Nf9Ous6XMv+fHC+5J0V4vLPsXhkPFOgNMrXGSlXu1DGctV/ilXqx
	 Rd4oCLD7+hKGjFphQQ5qYxw63DrL0r4RaB/WxN1quPEepQS7vz55Duq75SQWiP7eCC6U9
	 wZVaEmO1KwXTzkmKxOL/UWrDQB/ofNmDdy2CN6u4KjWG3lu22X29KrJ7RhUHtG1fI3fGB
	 e5DT2LWmc/3GrZc/IY9Eom9MP1XDw/N5R4SOa53dEnGVvUoTHdp0iwuKnx57n8igdqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bLvckt19;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516BA606B4A4
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 06:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 516BA606B4A4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bLvckt19
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8b612fd74e1so1423675b3a.0
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 22:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794466217; x=1795071017; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T+sVIbp4DoVMcIWaKe5XqLWovfYHU/r2Z29X5f79OW0=;
        b=bLvckt19cxQZiNvJGCMnt/pW6zGrjsex9A46V7Sd1O/Pin4wX6DPohUK7W2TA6kdhZ
         dFxiMRNb5iWOzqhBDudt719K+iehXG80kyRtSQwmt+vCtUC9YzR0HaZ5Qslm0lhLuL8U
         Mq8f90xJiCkwOdm3XBElHJPFOCHIyGb1DwsS69U8rM4JPQ4cdZUfOkWoYpRK0+M2+gTR
         g65O/znu1wiV31MIt4S7HKgkDv51nHPzyERv4qtODWgCfVoLUODt1QMTS/6/eDe+xBCt
         ffrN69IerYIJftxkJV0Dqypf3KeMBwq5FLwreWbmRVV4zmOlxBx77j+BiGqHXReFOW8W
         JwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466217; x=1795071017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T+sVIbp4DoVMcIWaKe5XqLWovfYHU/r2Z29X5f79OW0=;
        b=h3B0kTrNznkF2FK3cSyboBAOohliD9N3I4fL6I9xX6oXyQV+WTFrYRoa/hAQUsHZOh
         tg7T6DIvwffTh/2xTZeS0E8+yytCelqGUTn++7mEuFDLR1FK/KL+Ix0RZkTukZI4PXsn
         rrf8iEgwWClecF43q+aadKlRQYLy4aSFRIxDuvoKOiXvF2Io4O4Fy9MB7bfRrvPFo91O
         mB9MpH8caxSpbfvHtuVrMVcPAVNlRqBFempY4JYKNNDIkh9WJS6GBE5prj2XLePVMNLP
         drT/CiAKx41lpVpeqM0PbWA2neHTON4LvIH0oMVAPqkAUYJyqukuujjJRBis9sL04LzC
         ZITA==
X-Forwarded-Encrypted: i=1; AL+hErE+/1ZrjsduvScJfXEisXXiNMPW8OkA5Ti4vTkncHFu6hQY/fzLplPh9jZToPnUUS/N0J/iNW2dTNy/5SKqkQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9242iGh71i1VBcMSSyprGWkYf3URN7fw0V8t6IA8DPafuS+GEK
	iny+D5J6dGcmWtrpwgr8UkUWsdgxCRxocMW6DH1UQ27Szy9+E6mvpXpsnw0YuA==
X-Gm-Gg: AYBFou2kNT4Dwl7sRBSZYKqs+wP3dSRIyYgBpmg41uaXYBl0N33O5fe235dg04nJFe0
	xDCTyaIAy0ONfx/xEZFyTJaDaTyIlwa0ZHJrmk/yfXhF6fT+P5yf+GCaUAt2cBCYdECGOFtPuzN
	2QiGDmEBMhuh+zlg6WYzSQt5kKpZt0qPsLVXqJ3YoUTwqsN34NFr/OioJ1KfR3FeiOFIlTNSWaI
	Zr3880fczisO1cHErviMbfzsH/HoLH1CF7eLQcd1oSDvXph01hFdX0tIzcLCsLMXaUpvloo7LxV
	MuIOPLLWGR+XiU628uN+Jp3nHQnDiQLKnNyZriBHgICX+M/zx3pNLXHqihvdCyA1zQoEZYKJcxJ
	whOhXdLeC/i0/5DyZBvlEzsSEOWJ2xMZfIw5p2nFMlxj7SHZyl32V3FkhMs0Bl/sLoMDasY79aF
	WHQ7aN9PA3yWg5xo+yU0I81meZMRCJUxptoHaig5PSxqGqIfSh/IdM4cJqBgD5j0d+PP1jCacrn
	3+F9PyEm/E2qzJbTqEH46HnzF0SMFC2MKOU8CESXgn4aolUeWutF6C89M9G6QvqHAYwFdsexaKO
	BT5IEx0vtc7FH38yf1v81ktVMo93fkc2ZKQhhxhHBMePYuBTkSZHKZYsy3m8Ss8SU8PStRR0KAB
	Ffb8nyoy3eVpoRK1rGhuCnDNW5mdyW+j+zYqe069LTobAsoI=
X-Received: by 2002:a05:6a00:4187:b0:87d:dc3c:1b5e with SMTP id d2e1a72fcca58-8bc1ca72e47mr4389657b3a.26.1794466216316;
        Wed, 11 Nov 2026 22:50:16 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baab1228e2sm3097511b3a.41.2026.11.11.22.50.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 22:50:15 -0800 (PST)
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
Subject: [PATCH v31 11/17] ALSA: virtio: wait through signals for PCM teardown
Date: Thu, 12 Nov 2026 15:49:23 +0900
Message-ID: <20261112064929.11211-12-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112064929.11211-1-mynameisjune111@gmail.com>
References: <20261112064929.11211-1-mynameisjune111@gmail.com>
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
