Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981954;
	b=mJgdSiVXVlRTwODA19ZNfUGRw37dVGF1x/mqMayJW51X/l0LmB6jR2CGtOs/ljhqOlzI
	 lie/jxviIDEQ7b0mOrHkCIA2U3bxmzvwQ8ajOYfvjUE0jGCXaTfu5xGvcadDxmDaHtY0m
	 LxeUXIzoRwc7IwNaALa1VS1HIEvc3/2CbuT6ild7EW3OfI2IusUEpts+c6QaMyFp1YE4D
	 o0BEzkZjCXih/u1wrojaOO/lQMxre7rDFCHgf5ZfkyVHBh5NufTKFCzv+KB/TrDEJuSTN
	 DWRf4QjJ2OnGmjOWmI4yeuGsvKIG//X9FJlK+MBMg6+qFBMmnQtVu/BC52l6f+FJ9gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981954;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XF2VmCDJnpXIgiFaGUBtPdUTCN/KhchAk0nVPRL7Ydc=;
	b=FTCEO9OqK0yNX3f4o59YKYMdsM4cY/obwNF3GiTlN5/w8qiHVl4Rm0u1sDYt75cwv0XP
	 ILG0skbXH5lKTr1iZ92+otIuFBO7c5uKymFkbs7yONBYNoIt14Z6HVSKqmXyXf7ZTRWS3
	 hJMN1s3r/lUOsJgwbPtWcwOYvQJpsQzEzrO+F7lcTXY06Ib0feJWqxIDZ32H8W6cJ+9Gs
	 AsajijMPVrIM+AqA7LwTPT+Ud/yH9Yj+9sJLWEERpDz4u/pAkk/4Chal0VqxojDfeJOL8
	 eqS52S1NOPeMM6n5UJD+GyepUduIbzR4SrIZtffWFIt+Ta35tGydVjOGzJPgP1ec71A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tcABqEZ3;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35D36083603
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 16:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D35D36083603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tcABqEZ3
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1b2513decc3so432773c88.1
        for <virtualization@lists.linux.dev>; Fri, 06 Nov 2026 08:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793981953; x=1794586753; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XF2VmCDJnpXIgiFaGUBtPdUTCN/KhchAk0nVPRL7Ydc=;
        b=tcABqEZ3T/mIeyyvE6GchBd0yV0lKazdTF8zS0n098p66S/dbESep2Wl/A4VosYtBT
         t+8S1tohn+dzEbFLYu3Y1e0Q7lgEJQHj1LmKNfQaI4kE9t2X4tSroO5O2XXrHkoo5EAP
         al0RajBQNcAFuw+hBNVURc46x4q5JX/oxW5gX/J4tHTpc7mvKiGXklDnybqqVY4ecPC4
         lKECgGluU4PmdzakC+JcdFD1r2OTYW6sIh1gkpxci4VZ+N5gwD/QALCL9/22ZI3WxfHY
         1KyQW/HOSZMMF5QmA9c6KB6Mvw/IoAa4Foo28fm0HwAifQjWJm9b5vJ3BWllLwhvpAQr
         1biw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793981953; x=1794586753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XF2VmCDJnpXIgiFaGUBtPdUTCN/KhchAk0nVPRL7Ydc=;
        b=amjFhTbt0wCAVFvyEce9CprX9c4hQQ/PdAff06gpm9Nw9L2OG/DM5ihmsBrcJztEhr
         3Qrd/7XTx1p2Hgf53OHdqXFs3Vblz5nMoHFP2y/ZX0q4HRN8y78ur9k+5mk4tXHcp9WE
         U2eY54f6J5jCY4JImNOfupdFdmiD5rsyr7sXyT8XQZ0n9KIsBK+aGWLJEPhRSKtK7Mi5
         ZT0uUCIRsJ42qXJZyM/Cf3Gwib7TvfZM8F2Y4wVzfCEjjMnQLP0khrPhem8F1JvzcTXr
         ldI0a0Opkk/YgRAEiSxK6qcnZ3hGQSCUquNC8OaI4MN+WoTi2Tic0RoB2T3MkEm3P/QY
         Hw+A==
X-Forwarded-Encrypted: i=1; AKwUvBzZ4IYH9sI9MmltKIabOgnfSJDT2hiYBYRQLHuX671JjtzHqYQiyIX7HLgejWDLT2fe/ohYrnh1dDjSSAQxZA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+rJj6QSyoa6olKv+CjsWGAm9jWk6CI62jfGpTWeRPOvnjs37cu
	xlLxYl5q+KXcoLQ1hNRRqQG14ZpWZPTd3Y1rcVTuYX6Qt7DAptJV+bSS
X-Gm-Gg: AYBFou0yTcFmaIhed/mkLxe4z7bxpuLM0aFAZc538gQnbnvB8DwviY/TdrNRR2s2ALU
	Q2EWUA0o7gyv35aEvnh4+IPeFqnzN7ReCrmv29TRxzo06C3WVlLDQojcOcAdVqHh4dumZ9vJpud
	L522A4rzuSgqb/rLZ+fhJ1XZFxDfw0m69qrnvvufEJ6auWwqfPWuULosS5NYSaANi/ATzuL39AL
	J2V9VRsRJWFeAj6PXe9M98vz5h6I8HnsDxTvYKIzYe8nxXOc/5jDf+OMs7ACHmliuf1f4SsyxUe
	NLIaLtHblKVdrIl4MUaDgoR/mYyq7zQ0vNXy2XE5E0LPyi+po8y2/z8qlWP3b9FGWu9RdVHYjwd
	iAzEcr632q2zg+oJ2xMx4P4GfUk4me5MsHGZ0epZpSLcyvBJV5PBYVxggQ9Ta//AWDqK2+ICaHC
	GEJgSrsXYppWyvIKTdjjyfFQAzP0Y5ouoIf/oNnBCYGbhD9+mVCrY2tIgl8T8cWQjLPlpBcH5Bk
	K4rEirj7vig5nHvJ3NXWJv/kGEwGjiO+5WgleQqesHNY+3w421ugodym6dSA3+0L+Q7uHZzkYJp
	82dJZTFvYpYf5/uXAGx5CSjPmJesX9s8rtOsv6YamZWE0pedb+HeJ578ZsSffhgrXwgBL/1zLFS
	ZSEgW95i7cadGKE1R4lh9tOZTnR4Aafc0jfnmMTvfRZihwQ==
X-Received: by 2002:a05:7022:ef07:b0:194:9e7a:3ba2 with SMTP id a92af1059eb24-1b25d29407bmr4211846c88.2.1793981952881;
        Fri, 06 Nov 2026 08:19:12 -0800 (PST)
Received: from localhost.localdomain ([180.182.24.11])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4840f3sm13139526c88.5.2026.11.06.08.19.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 08:19:12 -0800 (PST)
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
Subject: [PATCH v19 09/12] ALSA: virtio: wait through signals for PCM teardown
Date: Sat,  7 Nov 2026 01:18:35 +0900
Message-ID: <20261106161838.94308-10-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261106161838.94308-1-mynameisjune111@gmail.com>
References: <20261106161838.94308-1-mynameisjune111@gmail.com>
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
