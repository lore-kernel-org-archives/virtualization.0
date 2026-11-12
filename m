Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794464734;
	b=NTk3/BT0IHvWjJmpZ2eu6NCPMig8WL2mgTO25fU2oDfN62yIiplZwRxGfA5i+Zkh6IHT
	 5Y6m1EY7aP9YTeIbUXFrIsx7XQWMrpOKhJEV2QBNZjCxClJSv4sJYzph5xgn9zDGikCwV
	 9xxiA5GzN7ehTyKR6IjhAs2tNlqSaNqtQLekuxASktRhOOY5J9p6qAM7j8/GG8gI9WCOZ
	 O8sghLJw2nD0+wIxCg8s4P8Zjj07kTDGl07B30fl7ZMJACQRbySaZM6083dnhWb1e0Nyq
	 COl3fIycUZXK8TUQvRWMhXHwAflA+N4THwIQuU4CPUIzZylJd9Ct4DjK5zL8vCif2AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794464734;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=T+sVIbp4DoVMcIWaKe5XqLWovfYHU/r2Z29X5f79OW0=;
	b=AuWMk6Ll4zFexVbMLLHcHRG74rCs0v6pQXUodMpWM0aJ/HUT9/D66NFCgdvL+N/CkX1u
	 CvJBtEIjNlr9xkL5g9/aYz63RS9G9GLDMwdW7S5S7ygkCsLGx2AcdBbSTd9fLjJj+A9E9
	 0tyYligEeAPZZEv9QkiZB5vGGqN7ZTiv5DJ0emNFeb1TObm2fJelHSWhriKIrNSeNauZw
	 xcPbIhr4EYUi3m7aGxYITVAY7/rDbOzJDqrnbtIC6hBTzaI6DNML8mHWdVnz0hsRhdFRm
	 v77dSe1RCabtYYBlDmOq89EGPY4z70SqrdIxCxEqIHlpI6o+/KPULPd8iO7WsLBhoyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="hP/H3lB4";
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C90160A3806
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 06:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C90160A3806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hP/H3lB4
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ed11653a91so18109185ad.2
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 22:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794464733; x=1795069533; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T+sVIbp4DoVMcIWaKe5XqLWovfYHU/r2Z29X5f79OW0=;
        b=hP/H3lB47nA2CtU2b2UitPOVpBhv7PSVcWUxQGLpWOzleAyyuKu/k9RwOHf25miAp3
         sTJ7ZwX24QfsEtx9PTTvOtkD4PMLqLx33Wy3Wo1FnV8GhQefyFz52jfqHEDw+5JcXdeE
         vaTEJEi39uXtVLtkWJ8hiH9bYuhtHhgMoWpbuHX67o7pyK1CHWpZWk7SWgDOK+GneYaU
         rt85RCtYYYcyl2wysHg7rUk1VN7GfYwJpYLMQwLFkhnRHIZSpw8C54OMsJoI81v//rsG
         EMDW9DQwJrA9Ak5o8G45+prRWSE1e47JBSxz6ZqFoWiPSqLhQLV3OyAQbw/Zx1+vxFJH
         cLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794464733; x=1795069533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T+sVIbp4DoVMcIWaKe5XqLWovfYHU/r2Z29X5f79OW0=;
        b=U6kxPpXv5s6KhWHNEqip2O/jPOfTo7/bZCRNH4/2894t9z20vs4Pghm3LkTs2zqzSc
         hZtQwa4K95tH86fA1teXE8KIV9fpdIH0Cx+gvHi2IfV1S6nF1elveBEMi/fHabM9l4iI
         bDofFrVhKKwMFgxkTHh8kZjZTywKtUPXcgYjQwFjxl4k8E0VT2ShXwqD6uRkVJw9XoGD
         TKyY6q/uqOsEODVYFiyDqGPeN4CyDdAPbXbrDV//qu1euiuhABRjN5MxcP2tnnikWbqv
         EAynL3MQ4IjMcUIQ3nDdZBXiuI7YWxRo+y5AB0MAAWr1kfW4CkCBQ7v8TyEbZPFo7O4s
         d1AQ==
X-Forwarded-Encrypted: i=1; AL+hErG/eO0BtNaMLVP5Vorb+EuWE4n+cgGhoSCDtJp2nRWdhGoRPNwxtHBPi1jUZpkl0HPHNopTKw6bjG4xJHqE8g==@lists.linux.dev
X-Gm-Message-State: APuU4Z9msVYsRh1XCb4OK5/QfJoUAcC0kwLLxW6Ma4hjcerQ6SN131/1
	wbtmCfIkht0RgBJ9mL3xCyqdb4u7dkBwoS0AaQ/25r+BtMfgMIobbZCT
X-Gm-Gg: AYBFou1iGG4uoh9HbZj7diCDt755LtXX3GsZQptQqL3a2BiW0KxKB/9/bDSDEEhihcA
	4+rSTiqkAwtYVp+OOdmyguuVwdgfkI0l5wCGnaq+batxZ0Ymn+u5sHF7qZcTxtBkcZO3yF27ZsA
	JkjvRJB7tgQODVh5e2OEY1NSsMHw2tIJZ2dKr5V3ANjSfzkdXrTLNkoe23i1kfeqVZcmiy62dFn
	Os63Vc2N0Z9u0IfJ2TvP0WAXej3Tp23NXUp9RXVzLagXujyqY49ELYxQbbUNpx6EaTCAEtJ7hpg
	MO3qun2fDMh1t+Zo5qzxPdU/TY7BW0CCXzNndqFSQcndtebTYUdlrndWrQigTcjpz3UBaSgAyl0
	VjK76iZr+wxw1VUoagwMLhoM1/IqLhU2a55y7U/lxZucnd33D/NFuxxb+8mehdWFnK7/nMgWGMa
	tO/WXcUNHojIYT5C2Ol9mgYuJVNQj254NUbumiGFgFy20JnH5a5XBPsiuZfB03PIzx+AczosFdV
	TaEOCcqQE11kwqz6atPrH1JTyf4zVntKZFzSgPjSVCjy6jGKQF7687asY8Sf+RNLH23h2byv+yT
	vipJbOFWiVvge2hKhEIy1ZtsZdr13E4PrqhkL3mT40XKxpL+3/+aHac0apIakIEOfO9xiKP0HiR
	R1RoXpgz+DHfCpmJ+WSFJr7tZpMDwRCWHtigClBryOQcS9Vc=
X-Received: by 2002:a17:903:1aa6:b0:2e9:66f6:7894 with SMTP id d9443c01a7336-2edd79db81emr47869465ad.40.1794464733463;
        Wed, 11 Nov 2026 22:25:33 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6a3e61bsm26979965ad.11.2026.11.11.22.25.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 22:25:32 -0800 (PST)
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
Subject: [PATCH v30 11/17] ALSA: virtio: wait through signals for PCM teardown
Date: Thu, 12 Nov 2026 15:24:40 +0900
Message-ID: <20261112062446.159-12-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112062446.159-1-mynameisjune111@gmail.com>
References: <20261112062446.159-1-mynameisjune111@gmail.com>
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
