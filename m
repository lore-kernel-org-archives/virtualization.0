Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794267691;
	b=mTar2p1m/4AHdKNdarM+lPLG02ResfsnjcH/Zznu7H1zpFbDEtRC0c0fCkNSEhoiqbjS
	 4teun9omNLTFuo9Am9Cutr7yfFND5VGthl21pqB07sR18mMrKpsFXpZYzFDUOajf9UJmN
	 qhMyzM5TLWH9gBEWYuC3DNTK9uIg8XZL2fCwTiAqsuKP7rADOGFYcdHPzEwXLD7XYqh6g
	 KFQuVoZqQT+umgIBKo29HPutEp4mYy6eps79LfbIN6z2krmy2Mlj77syNmWQuykVvX25n
	 lFoGeERO2TECbYhccIvm2bPA3Ib2PZ0v7IhJMVZR8LlW1j+5GuHhYFGSya7lpSV+Y7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794267691;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Da9OCm5N+tM292Jb1wkFobEcv5XsLraXLlVZUfX2Yhg=;
	b=Orv/a7ieV8K6Hs9iENij+p3xeRbzHRmdnodlJrLLS14l9UmfaQFoWerFQWOK5w0vI0pD
	 QPQXIshKsquXcaVphK71fyKxQSlMKqThMelnjuj38OLmi1MLbVvIMpyvB5MuU1I6uOzan
	 C/8A/8CXgPlGX/raVXHgQCffvol7Z1mCjDXZbiPbpDKDY+WwUAS7JH8WbK8LIpMZAAU0s
	 xhRtEZcavPfmlK859d/q7vt3OutjcAdJ0XBudBf/ofl76RQt1Aer3mmkrR7OHYu8NPYkV
	 E6ApwGExE18rUK0+XXN0ZkWuIubD60RKYE4zXDFHc0FSXGi5Lwk+A+ocd85KUzHUqVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rJHTsSz1;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C1360A3827
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 23:41:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83C1360A3827
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rJHTsSz1
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1a2af4c8d00so2460693c88.0
        for <virtualization@lists.linux.dev>; Mon, 09 Nov 2026 15:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794267691; x=1794872491; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Da9OCm5N+tM292Jb1wkFobEcv5XsLraXLlVZUfX2Yhg=;
        b=rJHTsSz1Tju5VC6zhUh/fxIdMHHWsHD4f69GJSW+TVNOTvaGzhilF010RwwkqhcDMf
         vFAVCprmStpNeDQxDgLIuv+t+/gDtQHHIQTvffLzEBnvmioHfB0uNRglN9iydQcWmeeF
         B8rO46bSIvhA24FtkmRvYy7jgbU8qgZgY50x2/IMIgRIg1UvuFtO0u829OYyZ7UfnnYp
         RhHc1hsvCz2M6XYUD1jQq+kUXzKWyO8N+qLhe3ozFC1q9raBHOmefWfR86DN7CmieLjY
         hMdFxpFAOwdC7driPaF1DjtlgLKnMebgRSJEQMV9d2vDLj1YF0/EdtZhfmzlFC4MsSDT
         HE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794267691; x=1794872491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Da9OCm5N+tM292Jb1wkFobEcv5XsLraXLlVZUfX2Yhg=;
        b=Ijkvx4PCEQYjjuuXvl1eMheeBK5N40foeWMa+oXcCxOC9ndeM/COE8mQ53IVBbPpyR
         cOZKRjsSZtMSyo4I1xpZfyv0hFGjgHplIajX/y+6oUF325b1rU9+oFznjGIpqAw9R0WI
         iUi5PhXGY24L/5rvUjqTQqVrwBfVbcygYnqy4wiZGUyozLNhGwA4RWqlPKqvIZ5D4KNd
         gcVvn9O0N5lNv2FVyOA+Ib+8cmclVzj9pQL9XFVJksJ1kgvRrGnyKP8seFlSaYWqWYGz
         WpgpBJRfRsIyoMQBRiMofcj2G7OOyrInjCVuzl+OtCBoCwyoNaiOaqVp1NuDnvBFpWfn
         aacw==
X-Forwarded-Encrypted: i=1; AL+hErEvMAhk1aVEBTE85/9iZcj99orbEMgdmTqO6XAtWquyzCF72WMBst8EV0CI4ls3sz6eGblLkJnjLLmtDzTdWg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+drbPTD8fZ3suVlyjWLQgwlig++/vEjRo+Z+E0VSfmPrzlOuiY
	2b2Zy9Mo63xP2sSLX6BC2Jl8Hd7vPLdw/1dnV63euxhgA1n2OW+sSjHu
X-Gm-Gg: AYBFou2jaCjVxQsvyzf+6ZKh9hOzPHdskNG5kmDhXvuqD9nFS76DxSH3xJPj55+L5zD
	XAc2Bus51vxegynoq7Uq3/NWq+BG5FRaScV//R9WPGB1kgc8KM/25FAxePPXWAIGQLf/Tbp0bbo
	d7xU7ic4m6DPAbE+E584BaQ6mNI1g+a4+UY8XMQwFRGBrYA1HrVys2n0h7tvgU14j4G/fQTLRFN
	XWHuRs3DbyPlBuhnQKxtg8x+8mNvPga33ZFNcpeiFw5iD2Hkwk/cm+6K9aJoKGxFWKHciB8nDst
	S6bGlzZ4t7pLYZbJx0PpUNl4araYYl1HzisVEXZbckKljmzfqQmqB/xkntSCtVyTNtFiwUq9mXO
	AXTiii1IhR0WqnD4YpvoJ+BfnCpH0YmZtdZM71scoAR7S6Hcv33+zsKfyQ1Md6d+Kqs4VhdZF93
	SOFnuPfeFhPXE9Sq8N/SlnOmlbdTRez3+QI4xjOjxQKIrzrgR6XPNcPQOY7ZCI1XzDntCqawURx
	0KYZYw5WGXrsqdPixYh6aTwLtd93dcoGPNp+Rvs/wvhZzDrPPDOFhVqn3RG/MJIeBLL8+PBtQ5b
	DXPgUzonI8ajHiEtZftmunnaT+Mt/Ms8aPeEaV4vNTKNWMgoWPcdGUhrh8NqDxDwwi5K2d27u/i
	8oOOzNasOiGXajaDQldoWQuM8S6SOsmRhDQZqxB0X2A/vYhI=
X-Received: by 2002:a05:7300:d195:b0:36a:1d6f:917c with SMTP id 5a478bee46e88-3751f55f74fmr1066564eec.22.1794267690535;
        Mon, 09 Nov 2026 15:41:30 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe2ff5dsm1739049eec.5.2026.11.09.15.41.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 15:41:29 -0800 (PST)
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
Subject: [PATCH v23 11/14] ALSA: virtio: wait through signals for PCM teardown
Date: Tue, 10 Nov 2026 08:40:46 +0900
Message-ID: <20261109234049.79534-12-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109234049.79534-1-mynameisjune111@gmail.com>
References: <20261109234049.79534-1-mynameisjune111@gmail.com>
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
