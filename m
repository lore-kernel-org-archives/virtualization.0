Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793252665;
	b=GovE51M8ZsY48OTRaK75JS2KafjQROJeorhvpaYA5OFbs2sj38GlSpCEEpX4Sej5upBd
	 uwMYvWBTv1RZJJAg8orMrLPXoBTkob5nF+9CV6ymkYtxjjwwg3e+G44I5XUICR67dYTIm
	 Nafpo4Mx0j07fZF3axOiq4hsj8xBCiy+iaNAiyB2u9kptHVywa/Bqq2TtYFLppw6W5V98
	 2OBtixjwCTj0qRjV37oZL93WL7ujorxR3kRavdry2SdsL6uVIpcgITKNw2dW0zSwtoCL1
	 JERr6xCQdQr7FHHRogYpYTCA8OMnpby0kZaf2eEuK4rUJ8lx8mUu4DVzpzeqkkTE7NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793252665;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=F5Cda1iTEohKGqJz5gtxJbapFh8jTgiZxocpRrDCK1w=;
	b=X2PqzlQMSgw0Wt+whWvOGY1Ceehvlr25k4iJhWJHwiJNVkHA7WtpFVgr+LXoTOx+7+0Y
	 c0pGn0jpK2AXy9rp1AsxexI8Mqj7dEF6tANG8Sbf4Fn+eUINpfWCc07+f4WemBQO2cp+r
	 tZTjH8H0WgC9Edme9SEz0t3HxYLVV+v3H2ZNV1SSun55RQPe6pl0PcVhXmsg7T7vLst1z
	 E01KsWn77WG4cm8B4DPPkI0tAZbKjKRgNBS6JpAv80GFWbjnUvD3MkgRYM603b426AoG8
	 TUAmsJi/18WzRaSiywPTNRuDY1T8730TuugyNL4EkmnrA+gb9TnwAOFIBEpMNW71tFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LjEaqo1Y;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C311606A329
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 05:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C311606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LjEaqo1Y
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cdab9e9761cso972356a12.2
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 22:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793252664; x=1793857464; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F5Cda1iTEohKGqJz5gtxJbapFh8jTgiZxocpRrDCK1w=;
        b=LjEaqo1Yi3IXir2E0q0RFLkURybi770pD7CEq6lCXjX0tvnCZXl5jQXjOQAaqak4zo
         70G3QTVVMcfaXoxe0ScLr2+8pp+LXoRnyqz8VEMcky2nQ9UsvwINC9X6oWWxYrUJll4D
         xDTVN/BH8zDpX9iCwDkqBPRu7jPcTwR4zTx4pGTwKh5eOg1wmFsO6D9rdvEnqFXH6+Gf
         lNwLywy8X5XlwMsssPYDk539fB7so57iK1fATTXL64bUO89mmb9f9SNf14AJlEnWJ7JU
         oKLTCZpJKRJ04xFrOLICW62JUzs/Ga/G235zAzS45x9zFntYr2KZdvz7nxUZClV67lbB
         aOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793252664; x=1793857464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F5Cda1iTEohKGqJz5gtxJbapFh8jTgiZxocpRrDCK1w=;
        b=WBFrJz6vyC70JwO3zgeNHSw9X8aorQAWZBApHhQMlzJCgB626uf+hoeiE1w3xROrVM
         N48QnQ/4bpp7M1uzAil7OKG21CmvWzFizSoZbHmXke3yoRgb2etWk9LC/VQ5GwsvPUKM
         /l2pffsvckSVA8UUiKkkd11pQNWjd/khBE0FpDlDC3Exs+enlFygCYLme/+KJhiDHp18
         1/SFIQjHJF4G+rCFhcVOa1vMyIt65j9SfqkofijhbxTSL2sRUXag9zXkENv25aiK1f7n
         wgnmU3edJD5+sggstaZJQer//cc96Sq7QJe7u4GDEGejIo+GsS5ynj/CZrHspuDsiM91
         MMNQ==
X-Forwarded-Encrypted: i=1; AKwUvBz/TCoegneIN0x/08aggJ5E+Lifof0voNnGZyT5etIKpyWoXFC3ZUYpIdROLXeB1KDqRr/V7PxyrRuqNV1juQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLcW+1koAYveeY8h7w05p+aYxYCJxxj7H3DvVKfZV5lUx1MyUE1
	v2ZYP8PxGbHM51ktaxKJSBt/QDWGxui8UdyzhAoRM+zp2kv8tHW4a6ev
X-Gm-Gg: AYBFou1XfCr1qbd9HDWxaCukEzDoflp6naxiApaNr40xdVbjf9F9CIjwDu70SzT9pCj
	Rj6o8C8YNYj8kfPKx8c261KksJz7XsqHgMeATFt2+Nao0cZhvxsLmFUc4W3vbsYmZ1vanvZd2AM
	kgXJnD05Ym0CKJARxQL3x1w5IUF7Ph5YwS4Z1w7W8Wd+NLOan7ypdpeUAogaGWbqfY9KSuQDakY
	/qanNE+uwIwqluZVzPXeOj84kA2bqi5iFZwJ3ZtNeAVjZukvVoiDPEuUAtKNorCS7M3eixQJu5h
	vh9BtJzwrS3RZBnP0mNNQGd4ANcjDcBkpfuNgHiqtIEuGLKBhoBWmny2Ydm3xrj6f8cDWU5QyRc
	XjjZlz14zMc8FZgR4o7xz1lenCpxva6Z7SYP9KYKz3tLlrooLTzM8vl8BJC6pMRBbwFcRo6c3dP
	mi1M4ep18skZPy23aC9ratIHeMhesBzp1HJep9h2WdheUexRn+eMuwiTe6keV5wonjGajxUP34V
	TYHSy489fo6AYqxMVvO2w7L0+2gHm4KT5nEMJGa4mfddKPXMw7/HRLvVesocYFWYf1cLs5mWYTr
	bwl6afo61vcNwJIlWc2QQCUhAGV3uK8wNKetq5eNN/jEGdeLhAotD0V8bLVA5yavnMuKvAeRYvB
	GNcZJ5MG6pPd6tRlMxKyNFqS//7XLGNjYe7mcOdFg9ZbnxrM=
X-Received: by 2002:a17:90b:2745:b0:3ae:5525:dc25 with SMTP id 98e67ed59e1d1-3ae5830a184mr3504844a91.51.1793252664007;
        Wed, 28 Oct 2026 22:44:24 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e83127csm2433520a91.10.2026.10.28.22.44.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 22:44:23 -0700 (PDT)
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
Subject: [PATCH v8 06/14] ALSA: virtio: wait through signals for PCM teardown
Date: Thu, 29 Oct 2026 14:43:46 +0900
Message-ID: <20261029054354.2931-7-mynameisjune111@gmail.com>
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

A signal can end the interruptible wait while a STOP or RELEASE request is
still pending. A later teardown may then submit another RELEASE before the
first request completes.

Keep both waits non-interruptible and use the existing message timeout.
Other control requests remain interruptible. Device reset still cancels the
pending request and wakes the waiter.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
diff --git a/sound/virtio/virtio_ctl_msg.c b/sound/virtio/virtio_ctl_msg.c
index 2e0ff15e729d..e50e6c7f3b8d 100644
--- a/sound/virtio/virtio_ctl_msg.c
+++ b/sound/virtio/virtio_ctl_msg.c
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

