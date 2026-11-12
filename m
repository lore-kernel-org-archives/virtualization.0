Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794461732;
	b=kMSa9RPmzor58GayutJ9h32itIfYPfoscuErRozC6sQtB+B/kqsxI5+xyM14PnEvFD3n
	 UZ8PWL/wIsq8dj/ZAieYXbMfEQemMQwoW73JxYfbrrGrdaJlvybD6HbdaB/UIeUoQ6NeE
	 byc9J++72iFMkkg92yq5NGGlG0eCq/HjZOgg9vcoOFNsWpyDk1/5Iles8P72R1dWB/C0v
	 gMj3uNFPCycvJEz5NdswxMiWR5eeNeK248wkaCDGbVbUMeKFkbpTc7vzMNa89wKIKkb++
	 FQ5BPzF0+GPirzuaLgPVvTGt+L8MoAKIluOLtcAEmfmS0LW4eLj4AfeXRDTDdngtSFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794461732;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=T+sVIbp4DoVMcIWaKe5XqLWovfYHU/r2Z29X5f79OW0=;
	b=xbqC3ZZ2VZPeGT6z7gYV02FZOqXnu+7530OAKJEKpg1Unabj00H4RSckI2GNVurb9Qjy
	 /4SgsBJRbaVIYb+uZE5uHJj3nFVNNoai8Zu31I0RH9kE8L6iTbjE/pFMh5U7eAgraXDle
	 Nb+i9NzJ6JOx+O7yo/9PaLYhRL+fPY8YgAfnY/VYk1WmiAOcgRpeO2DnU3ZQOJ2eqprIN
	 KX5GHpuiK41qPEh2hTmJ/xpi1LJrfZQ8Hv9LhQO62okwk8rC9DrBAJO3Jn1wnDUuQLk6L
	 IX6cqmwqTSEO4OvXYKtCvwEaGCb4APMyAuwK24cqyHinrZtMK+GQGWItre4hamRFTsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TRHrQB6e;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6648A606A8B0
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 05:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6648A606A8B0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TRHrQB6e
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso5496230c88.1
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 21:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794461732; x=1795066532; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T+sVIbp4DoVMcIWaKe5XqLWovfYHU/r2Z29X5f79OW0=;
        b=TRHrQB6ewmwxmieJ9CyABveeRmMUNHWr20yBM5qXe3iUR1VflGs7hZ7RNe8xGGdGqs
         LLhgclAjP4Lf/95UwbDv0+Rc3Ata9N5s4OQrsWBGX2Nc3mR1CsZBCcejx6c0ds8uoWXX
         i5pYuoG/hHv21YYRjzNb7FWtgNVFJxw6/SLcDhyoxIKkWhcRpLnTqxJxR4T99ExU2LNd
         vXgRd04smIKWzh+iEbN0O2MWg7fb9PVAXpMOHQMsWduyqAfMi0zORQcaVlXDVb9ntvWd
         Oexf5to5xBT8NGkbq9tcl5Mk0kETBSNyWpRyKf6B7Ibjlf3a0xBH9oY5BNV/0qW96iqk
         jT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794461732; x=1795066532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T+sVIbp4DoVMcIWaKe5XqLWovfYHU/r2Z29X5f79OW0=;
        b=PIOLJsakG8gBkkkg2F2647pp9jPhwR9lloEUEKn+ieN6UoGxOJf9PFW4uLqAXz27P9
         C8QYvXqnYm6hZc41G0XTTMWPnioskbwu5f1elhnMBtIcYXN1e1VYXTzm0EL3c9FWoo/L
         StsxXYnJXD6hK5jl6x9dCIiiv3DrNt8hdtn5oCdBviVTodVr1Dy+2EYW3HaLoatVpEtq
         JTZ0/Fu0wXkz57Ht05nqJ/eJtzNmuFG+txt6m2kU7MrzofT8Fatr5eu0knmM9pdTQxiQ
         xpxWb+tLi1vjV5B/GRAT1K03L3bfcCLRMiclmJ1AHQYr7En406/fGjpDbOgVl/7F3XW1
         fEUg==
X-Forwarded-Encrypted: i=1; AL+hErEJ5A5rjQHRqehIzQTHDFMni+bnRyIhRYYyHrKMpLy2JSPg/HMKTp773YVQ46QVLyYuRxJkEJWATz6E04dH7w==@lists.linux.dev
X-Gm-Message-State: APuU4Z/KhPxfIlUHiJh2Gkzt/tYNhBiPyDCorb1u5EKh/iuag/Cck4G7
	6GGGwpv5adjSIF2ebla7xSRxRi6u5FzEBYpexpyLdVmGie2Y0VbYNhx1
X-Gm-Gg: AYBFou0tYe+KJ3HyZgrpa/nPAk79u2kTnS+/7e8+QGI7vBXBii7CXU0XvoAFVKH4C0u
	u5udv8d+4rHWqNXkuled5tzDk0iYm4F3q0TARcp+1DXUQ8+1eV9xlWPMT3+7saWkuM63Ycw3GsU
	jKYk9V39BIW06iJEBLASfyoVVG0oZU9woto8KxQlbKUlkcC2iWGb/yrPdCtaB3dVMj5kS9sMEvO
	kBw0fw8T8VuwP5Gqc5gtlWkkgubWkdkAeTRwyk5WPadwNmYjfq4/MOQI3AN+kOSL/yHdYhULzHQ
	ZDkNjIuEvUuZSSQwxUGvNfxQ4t6jWSse+uJwwPw4gYg+9PqPsIlpX0HGbR6gTDrIyNSQ6Vr8+i3
	/3Ak6TJmQcpRhSESbH5xAhEKnlOi9ch/Lh4zO4y9KCrPY/pglXkSdbHxioe4nPW0CHLKSGzKpt5
	pl+aI1Ab5NuiFceGnrHtHaRJrIUKxKZumJcy5uJphy2OUiqDummw/V1LuYc3CMOFaUZIgJRtn/2
	e0uUw2PVPOmhjyOrBmywe7s/Vz1HhXnyIiHUzg60M++qXNQl8YtFe50f48sDplXvt2j7tM+r5iS
	aD/9dHb72ZtRvT0vyCmK/BstztUYBOSQcCre7B9yg5DgYyYt52x2O3yZMjK4487ZIWzNasMYhlT
	gp/IcwATb9omP6IybsnwW3qU1NI+Qv/5djtw2LS/AQjefRfY=
X-Received: by 2002:a05:7022:2204:b0:19a:20d3:a3d6 with SMTP id a92af1059eb24-1b3c0242211mr5541040c88.1.1794461731568;
        Wed, 11 Nov 2026 21:35:31 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5890c0esm21953240c88.1.2026.11.11.21.35.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 21:35:30 -0800 (PST)
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
Subject: [PATCH v29 11/17] ALSA: virtio: wait through signals for PCM teardown
Date: Thu, 12 Nov 2026 14:34:40 +0900
Message-ID: <20261112053446.73504-12-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112053446.73504-1-mynameisjune111@gmail.com>
References: <20261112053446.73504-1-mynameisjune111@gmail.com>
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
