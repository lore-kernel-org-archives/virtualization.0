Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365861;
	b=eC7rqqk9yUi3MqH7EuDFevjjL1JWLSRBupMaIjXBy5PeSfvYBRV0TTAhVWSV2Ze7Sd+j
	 r3QCJk5esRYfh4qVhnT5oCVENQvy/6nwa1ukhTzeJBBTLDQ6zxIJ4m3JF6IsHx3qiPHiK
	 ks81hup66wKe+2wc+jxzYGQFh2mzdsXnPLcCyBbYaZdiBrqHKthm/W9BeInnlAxM5bvTM
	 twaysGIY49phHaAwyUQstl961ZdIAKzb0661V9cpknYKqFl5NjMfZOjTVTJ/4IZ4S5Y0o
	 Gr3nYNvW0pzL+Cu5VWNgBcm6I2t7OGTPt3/n16N/Imvt9+k+HuNyUB3zOqqT0xNbisA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365861;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=T+sVIbp4DoVMcIWaKe5XqLWovfYHU/r2Z29X5f79OW0=;
	b=czgBYByawn2Zbe1+GaGXA6CLCu/ZVx+Q63o2hpa8DxFE4Uxf/wGhvR+hvO3P0FcHWwto
	 t9187h130vUhhvdT0LREZp6Row1N2JpTiYKMrxj5ZFxfe3m5SrK2p/0iUhxCDJYhIWEAz
	 OA6ZPRh7MIu1N43+pcnJkXPKihMrn/4rWkfnJvlBCn0eKSbMbXdviQdbfEL5b35gnP4eK
	 XIqcJhVh89WFQXm69GUSWgDTCvO7G8qSWp/tHZIAHVk7cLaBhuAM9CJ9G+Qo6jj0VPhr5
	 cYODFCozknavMpyxZHvoJEPSLltQXYnGsiZjeY8bpmD6GdKtejYaW4YOXjODqprQMTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yz7vFVqd;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3F160A263F
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 02:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F3F160A263F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yz7vFVqd
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3700ed8dbe3so4669051eec.0
        for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 18:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794365860; x=1794970660; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T+sVIbp4DoVMcIWaKe5XqLWovfYHU/r2Z29X5f79OW0=;
        b=Yz7vFVqd7sr65dWM8aVKfQuicV0dzsTwdhC57lKye0m3bkKN4o6uciDHSf/dbrjIM4
         NI6VGIBWsdGi6DO+rUmhawS22+NqKZgg4SAX3yrtDeh2uNpfna4JG9+6WftiWdMuest4
         NKeeS5H3hYCTfUfjuXIXzXKxldowN+0+JY3Mzj2Ny63DwyUn5SIhc+C2qVlsoxq3GL/n
         YVeyRQ5A+XHayEkAyYHNXDns98A0rgmfeInCl36B1hG5u9VzfvyhILOWYdLeU1rQPdY6
         CEOy7UidSdlIx07dgCJPEPFlW4g/I+ZWumvsXrpB6cs0NNCB6tO6nO+OipNlYPlE6y9C
         xkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794365860; x=1794970660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T+sVIbp4DoVMcIWaKe5XqLWovfYHU/r2Z29X5f79OW0=;
        b=s0SDlAjsW4iC+lZg9F9jKyUOG16jl0yUkjXSVlipSUBWtYpFRt9pgx93pJb+q4zlaG
         ftbceoAuWMxRkmrqFWAXACW4L2XBctJ4KmI4fLewXnAsYJb5Izw9vkL/W6zYKYfDNjOm
         q15TZp/1yzvzQJVMjEB9lNiNgMHmEbC4x0l2k0LaO1AC9DYBv3/AFdHvkoXRSCT26AlK
         YBai7i+iMcDF9LaipiGYM7LK5cESgw0VYuosGgfwHhty3nBAkyMB3pPxJxPaR1xSKLcY
         HkwkXixI32oh3cnG/vuF05XJDu74dxzTc6gTndQRiN7x416IFjHWUZ2R7xbSC5n85OvD
         lEeQ==
X-Forwarded-Encrypted: i=1; AL+hErG87wuFeOPAEMKELzfc9bZQhefR8XpDTQ8KsJbPQJL1tMk+C2nXLgAIPrbh0Mlx6R+c3VujkANadxZClFd7yw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/YpBQW2hrfsNO4JnquJpJg+FDY53kSNf/zOzNl/+r6ro4DSMoa
	1hnK7in71TYRSNptJDK5GRc6uHS8zLIkrvOhJFpJ9SwvbcfAWsw4JWR8
X-Gm-Gg: AYBFou0cVCcpckxjmSvOabKZUni6ATC17hQFjjydR2QqRYLAes3AdlIPLCeR0SBN6bR
	YdAKPZx1UoxmJBpr4SHWC/Jq+7z+6B3IWLpTUzp2IDx+U0mtDT5AcKwlBywFByX32xe5aX2lLZ7
	8JtWuc+AJ8QV4S9CtEXu+CH5tL8wRStq38/KxhVUcbZZvjh6IV5I5i5a12Zxac5nzCWUkPJf5s+
	LJ2+GiGmUERxUITGkZVAIH48bXyEjAOesGKpGIsP4twa7CXWGFwGqiaPzW7vmCMC9+gwoba6F7F
	AcF/dqoGP4uULHWuYgNEKIZkMNksT7QgqO7bMyJELsvfEALA81gGR+TFMuaQdc0FfqCzy6FpuKF
	zxXasNDgA1mW/SvPozpbRzUjXJeXxhsXAB71oU7yEHJ+IZVwPEXay18iG8fxTnIrWeW9wEDb2ei
	WgdrKoS682KXDehoUDnwptuMT5HOwAQztRALRLOaIhjto8nOcJkxIRHtDa3LU6uGDy3igA5IUAx
	EgMWWtDQTJrauSfR2qzSFeZWhTMi0Beo2glm0S/sUf1O9NU15HjOLvGmnaCJXkTY+tKeFvYhkeq
	Gb1bR7eXsZFlQ7ByvHWyTD30C1qU+QCRKyYADXoho8Gmnm+hj38rGTUcRkGdMDj6aI8yDTok2v1
	PCUYybbewr38facQ6PUsoGk2ki6iAFG90dTKRsDh+5nlPZVy+9C0nAQsz4HRTmmxVaty5
X-Received: by 2002:a05:693c:8852:b0:371:ede8:3e9b with SMTP id 5a478bee46e88-3768721116amr1738057eec.36.1794365860232;
        Tue, 10 Nov 2026 18:57:40 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfc6sm12390018eec.17.2026.11.10.18.57.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 18:57:39 -0800 (PST)
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
Subject: [PATCH v25 11/16] ALSA: virtio: wait through signals for PCM teardown
Date: Wed, 11 Nov 2026 11:56:50 +0900
Message-ID: <20261111025655.63951-12-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261111025655.63951-1-mynameisjune111@gmail.com>
References: <20261111025655.63951-1-mynameisjune111@gmail.com>
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
