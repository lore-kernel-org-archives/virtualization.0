Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794182154;
	b=bK7Rm4iMGHrl+vOOTOtNZ5K6Ghw6YZBOrflYsXtqT9ML+4W9Zg6NZqyHeSuKiNMWg1Tj
	 2v4WGvyeCgv3oxx7p6QLGi/RSkIyi2gYPrD2M4ZRu+dIxGrTumusuLy4oZHg/lrgFiEDl
	 ojI0loj2a8c21NmkZdBkApNrqxEJBVtUm4R3j+H1IPqM92hACTjHoV7Q7UuQlIVBKhN+e
	 nePsDh1DGxZCFBuYLts5IAxv9vSq1GSu3MITxxPHGGlr+BABnLcTXdPLlxplldrK4VYqd
	 2+6/P73Y9NPLMA8Znf9N7CCJwovXm8ibKxcULgXY+rWzljcNHBtO/kpYJjDDopJguyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794182154;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XF2VmCDJnpXIgiFaGUBtPdUTCN/KhchAk0nVPRL7Ydc=;
	b=xs61PlTTIXRvtwelCMxnVgJnWFXjkZd/uG+lifm04YGTIFpiin36wqaHFLZ2zErC2paw
	 j83JGnXpro/pcheonJ6s6CjSFWGglai7MOEDLurUNoz3h66/athrdVEWiyi9lAg3+9YL9
	 6E7Zmd2eBrg1nQhtkem/Uw230s4J70fD5Sfb0IzXTTB7MszwBFMUnjOo/9g0q8TtPPD4f
	 zn6B9e9dHOznzQf1ICM4J+RwtH5F4xpQVtnt3OXX6WWlGCgzHg9LsAZvX2hgpfbPXXCcl
	 /GgjRp4//HqjJHIz1ULtW6MJm7AH7PWuZGv6lN8TkHOsjeHoR/JSUN3pvX66nwwkR+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cRDO8UOF;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC7A606A330
	for <virtualization@lists.linux.dev>; Sun,  8 Nov 2026 23:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEC7A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cRDO8UOF
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e8da6ef7ddso1555175ad.3
        for <virtualization@lists.linux.dev>; Sun, 08 Nov 2026 15:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794182153; x=1794786953; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XF2VmCDJnpXIgiFaGUBtPdUTCN/KhchAk0nVPRL7Ydc=;
        b=cRDO8UOFt0C7O1Vf+j7JUV/mkmaswGwBNPqRdDWxgAFxUqUeZcKNWp8ebA4tviG4Jp
         c5HAbnA8GYrjUdzi5oxgkd961xXsnEgmM92LVQw13fMDQZoOrQUY6vk/U/gKjXTMAYZu
         vAxgx3MMFvycWJBnXmsAvG5uf+tNnerMnWt9wc3+oY2vopjfWbH5MlClezJhsEPQ06sq
         xUQfL0a06y8y1paSg3pXdOpRaU134snSQrPU8yLYDCAy7ggq7O2BCY8D3pRkDDx4QYwK
         WXcSXmAvdvgkYdEP/53xHfM0T9aoeq4pLVkiiea2RVINAeb1G8aCmQda6NMgXzlGcAPf
         mO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794182153; x=1794786953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XF2VmCDJnpXIgiFaGUBtPdUTCN/KhchAk0nVPRL7Ydc=;
        b=L9EJZ2ToDkyMPhxBq2ryFnLrOSmKfSXLcOaE6rNB4eaUfKw1oWkl3tIv0nAE0BqDsn
         fqVf4e5sVq1NZZo/v1cuKpBOQ0cu3ByvkKBZ2/5aZ8lnwwxbGtneuUECNBgvn9SOBqkr
         oH4z1gtgW6xjitGyaP80PAo0IOPdYpM9z2BX1BLSQwEfjX/uUKOphpWKsBHPnXnvfFty
         vIk/Q5i3p03eOaYmyy2ItcEILYcxpqvIs5hfN8M6h1T8Nvd4oa+XtFwC8MSlBufpU0Mc
         Tg54+s0dT/vxmAd8lsVm8ITkyrj0k6YwtTOgdYiwrwIBI8dWOZrwr1Y6JX/OZlZHEkIK
         Zxcg==
X-Forwarded-Encrypted: i=1; AL+hErHHx6QQJAMfLP64VZ4smrRi+bQJozn8Bbb83RVec3X+UQW5/ApVUkx6KkOPKA4Cs+48rp/+EDc099p+O0DPuA==@lists.linux.dev
X-Gm-Message-State: APuU4Z91L0/uzUUExRl0cPytyadbGEBYhfwFFkeTfjKHd8ypEd99mIEq
	uAHELO9XX3r6J5T9LlDIYQCvqhxxahrgQPdyi/rEh5bnK7K/OTZbjiT3
X-Gm-Gg: AYBFou1vagzAvDTJX3xylzdo6s87U2Dh3dSccHLbjTRnmGzKgj1utBjAz27f66K7OdA
	bNhblWLlqUTkUAhA0qYtfmgJXm457brUNlXPWDH7I/SvNg1xNvwR+lmm2lqmUr+6sh2HMNqYZFM
	WXq5cL120c1/a+j82c6YAqZY4R+sq6ldANH9CS2uhqQmJN6cRFW4vfM07tp+x/MTLJHHRAOTN9t
	nb3s6hvGifhFTT9JczkBnZO8V9Lbntg7TV02GEooom8jnGEXu3z4glfuhZ6q9VsJPFvuT/s1HOF
	at73Z/0DQ6nK228O0chheeUmBf3KQVRrq65HvLFb70Ttg1QalsR72KRO8fcXNBLIid3Um2X1h7Q
	J3zI9mMp1n9bhywZmPPNJY8rOiVagqqLn6ZubbCK7eqFizab80nDO9XbpRU7P3wjic7XRD9JXnp
	RurtVcotJa5UmtmufY5AoobJvJLQ68Glzz6/6alYLyaOmiWZidwVJ3yRpAvrT2vPCX+9qptF3o9
	m+kewlFLmbbtJAZNVF3tVU7tU5OwzMayUyhKbX5/ZaAwXW1MURoWIVF24wk7Pv+9zuVOkz0rvNE
	a8X7xcbOmWYGDol2c2/tri7x+UCacxJecV8HZb3P3zb3BxbKKrKgS2eP+qAOrM9XbE84h+kOh9K
	V0xPtkh8wLpBGCCEONaS5i8ztN1JlJSP0JANC/HRcGyKlF0o=
X-Received: by 2002:a17:903:1b07:b0:2e9:79db:449c with SMTP id d9443c01a7336-2ed83784c99mr24187015ad.47.1794182153315;
        Sun, 08 Nov 2026 15:55:53 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed81722edesm6095215ad.55.2026.11.08.15.55.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Nov 2026 15:55:52 -0800 (PST)
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
Subject: [PATCH v21 09/12] ALSA: virtio: wait through signals for PCM teardown
Date: Mon,  9 Nov 2026 08:54:54 +0900
Message-ID: <20261108235457.12688-10-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261108235457.12688-1-mynameisjune111@gmail.com>
References: <20261108235457.12688-1-mynameisjune111@gmail.com>
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

Keep timeout and wait results in the types returned by the kernel wait APIs.
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
sound/virtio/virtio_ctl_msg.c |   19 ++++++++++++++++---
 sound/virtio/virtio_ctl_msg.h |    3 +++
 2 files changed, 19 insertions(+), 3 deletions(-)

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
