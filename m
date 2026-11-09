Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794201417;
	b=CbW4Wf+t9j7sWpTDEqu4uAxuwHETpoZ1+2vhTcnb8sdfsOAEyX5XFXyrIFMd3qFj20y0
	 wGkM9LYPB4TXNgNXty8wN29AdD3Ky/qRHdOgfFMd5E7x9QiDbN4SOFt76QqqO9YJPnJnA
	 nQn7e8hijt0OENzqGC2qcpMrjJCWsbtm75pbk/Flho7Et/dyJlDiJHgAraLe6b7tuYe9H
	 Af95E70VjtU2CLCYXbLkGPajq3ktEX4s7742YwXip3rl+LEsK6YOsi+AxpKQD2EhgE/Wi
	 BKdfi0DAJEF2qyPknGG7ZVp7ARWW7TTE+g+4bPFlZAsmSdDr/jgChYR+jPoNpKbuEZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794201417;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wxebC5D/9DcGBbKajYZQRzTUBj4jQz6fe23p0qiGvhA=;
	b=1nhFAvhtuOXovsmjUR6r88kzsMxUAOI1qCgvwOel0xFQON4UFX3NdcNpFVut3aTOiJ07
	 L3m3DSz9bG6gukx+Pnu5IVQ9qZmkYH89QjYMLBRJ1YdR0j2+J6AkNZVkRoKRZDm92geqd
	 UUoPGarDPqO/1yjV2i+rbX9Na4D94QMvcKLJE9ZIzFHnK6gJPvgDN3/nrUEAru9aLWiR+
	 Z+m04t5FkB5msg4acdpICXjgVbZG+8ulibr1N78c4kki0tSa3si/IKaTgaD/iat7Smuj9
	 yA5Qm+jJ4U0wwnDwYquBAaGXgULCuTcBWqaDSkqg7fZ34kxR2QwwmQlzdMlc0fl41Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="kTrr+QN/";
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1734C606A335
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 05:16:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1734C606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kTrr+QN/
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-14394530ec6so543248c88.1
        for <virtualization@lists.linux.dev>; Sun, 08 Nov 2026 21:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794201416; x=1794806216; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wxebC5D/9DcGBbKajYZQRzTUBj4jQz6fe23p0qiGvhA=;
        b=kTrr+QN/K/t+N0i7iDMxtnIr8UERVoDL9IaQNaQO5p9ngZc9VPrv5A+AcmAC4JWjCs
         iYIbNdbnRbSwzpSGsUjCiIEJpirwl369epkTON4oNzlJg8DvGM9wAO8cUKaLLqyl17JR
         HncOrQjHDCI3jSBKI/8Ob3X+di2fmJ/Q3nEFkmVnVXl3C4TncZWPmsvux951jGqgX8Si
         pQ0+MaANawu9+/QqvxSjzD6tHBb56unuJ8oUyPIDCWDjjkUFedPlTJeSZRgoH/iGuWYi
         pFYCA76VlvMuPeurPmv31C9xcgR4wydkWd9fcm0H2isd1j5V89UAarBpoMJlLJwt942j
         d5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794201416; x=1794806216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wxebC5D/9DcGBbKajYZQRzTUBj4jQz6fe23p0qiGvhA=;
        b=UadDwFK0iOPMJVgIg7PCjB5pRxiE1tzRr8UWROI5vcAkifuW9CQ03n0WbNdmztb9X+
         NX0w+vHAZR229U4APUkovzKjaG/bO8Lhvu+csptqpULgJCw9WCtyeQab2arK3UKrlzSu
         4I9fZ9rNmaFwuFkJ0P6N5GCjVZqmOD+J5Ay033fnreWGlnHbT27snNT0sTPvGl8pRU7E
         XQDQS66B3m1/SWlUYzlTwPoRElrY8Uilk4uSbEAOV4IMfgltlC4zWJLmDDdysBhPL7R9
         nD+25DG24ZVaZB75oMTZut/eAUBKfyJKQG1JMqxGssznMDcKi/2jTKAG954G29qWNQGk
         ZtDg==
X-Forwarded-Encrypted: i=1; AL+hErFVjLy8WuRXa6KyFCqzaJVBLCXfnna3sRLpYu1Fe/SejpgFdej9lGY8N4uSvWWtCCwCZZ6TiCdWikZqMCGg4g==@lists.linux.dev
X-Gm-Message-State: APuU4Z84EykGMc3hmXrf9XVHNyRYYVs8OoahdgqkFXu0S59d0e2dpYzy
	am5DuVZ1/Or2dxs+O+lVmOmyCwmdV1lzXvyQ7cshQnAGV2cbzkw5rtVA
X-Gm-Gg: AYBFou0ttQ4C9kmehN4nZiHe6AougKNButJHa68ZyKSDbW9+VKvtQkyf69hNisBS30X
	r/7otcnaBqJEpMSTmLFt6kxlTnadT4om0QcgkaXOQ6H8j4aLqVrNgyTHCkck3a1MRpwbT/4SBGD
	hJB9tSwtjIKON5ykTZs/UW8PKSZGpTaHNCwgxibVmat2/ugCfopo1JzbdlekPaSDb0NEdY7AzT4
	0MysLg6lFFQnignZVKa1wradzh/QPxg98TdImBx6FiDRd/aNq5WV9pYu4hvbuATSaxa63Whuqf6
	NuvGiMcv5qMfkxAB0qozbndQdddDSOqDm69aIMQh7fAUEelDbVYgMP0StBfbed62ZNgFIWyPIYa
	OVfMJCygaO0OrcdivHwpOBmYoGde+95uO8UaRTYA0GcmoJlG3C5afd5Dzv6YB4kJZPCD/6sBYPU
	EtlqqrOHYvWYD4iooYEm8Zf6zY1XjM6Dn7L1L89Sm98AykBM3OeRdFyYq2etIPb0NfGknO1lGQS
	PRTB5OQ9Cd6HHAHBvS+eVEv16EFUy+pqcNavD4u72UDaODGhH9QGTanPcpq253fpNpnn4aBY4oj
	M5D8/CI3cjBPrgsscwIBcLUHaso/wVabd+ci/E45rSGyqf+GLCg0/OoCKtcSq10ETDOMa265TWj
	t4HKYNEWNDfKLBENbVwqxa5s1gCmyRHRm3PIEVEFD37VTDgmrnLJ6HStSfH7xC+ZjaTBU
X-Received: by 2002:a05:7022:ec17:b0:19a:ace1:793b with SMTP id a92af1059eb24-1b39fed0700mr6138711c88.18.1794201416127;
        Sun, 08 Nov 2026 21:16:56 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b37314826asm11395635c88.3.2026.11.08.21.16.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Nov 2026 21:16:55 -0800 (PST)
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
Subject: [PATCH v22 10/13] ALSA: virtio: wait through signals for PCM teardown
Date: Mon,  9 Nov 2026 14:16:15 +0900
Message-ID: <20261109051618.22506-11-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109051618.22506-1-mynameisjune111@gmail.com>
References: <20261108235457.12688-1-mynameisjune111@gmail.com>
 <20261109051618.22506-1-mynameisjune111@gmail.com>
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
