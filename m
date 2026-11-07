Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794062100;
	b=OscLlscAxIRpYzvOwhTjYLredbVVy4GzMl+BOfMBZRdxwSQbFh0YXrFXCkEtp5fLhzn6
	 isp/YMwwA1ZIvzF4thuJPrE1HA9GFNYW2JLk2XcLF8Gj7f4V25nlyL5Mr0wka/AdACycL
	 mHkH8+jq3/YEnPks2yZF3f69hJ5xaqiB34kIu4OovX4n/B0H5DnUIMYgB+1gW/TPop/i7
	 a/DkXh44niCp3FZPapkGFrqhUtEDiv66aDxbsscTb/Ft1A9bFedCpzjJJUFcD6tV8JFp6
	 06bPjze23doEoaX5YpO6bzKK9abzU77PLBjbL6I61sDyEIzuR5ueR8qB4yoQoDMiUBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794062100;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XF2VmCDJnpXIgiFaGUBtPdUTCN/KhchAk0nVPRL7Ydc=;
	b=wdElYWAhSVuv8K60bN3KoxvDIBS/vxpTL2w/w6b37KGZMvy59FDSQRS6h8Co1yImi1Lh
	 ECB3MNBJb9x1Ah5wrnj3Q/gZhDKdr2+3jyNxaRfzM6ZJaUU0QQh/UWLXhqgkid/fvNX6p
	 Jy1eH89GcO94rdg9syvE55PjJpEDU9TEXKJYmfI9bP9AedOfM+ZVWHrGZ830/0dGqpBV9
	 3+bbO61h2bl3kcu/rMlxUZpTjaFgnjTgWQjDzi7xW50qQMv60euKdWzr65oCuSQ5Ks8EP
	 OxUsrxQbfAW4C7C6INiuKbbLOKjpoAnjiq+3KP4dkq5Hz6vRNDF0m8+d5xXE/cJO/aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yWcG7v6c;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAEB60A2617
	for <virtualization@lists.linux.dev>; Sat,  7 Nov 2026 14:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EAEB60A2617
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yWcG7v6c
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-37071c0f42aso2156327eec.0
        for <virtualization@lists.linux.dev>; Sat, 07 Nov 2026 06:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794062099; x=1794666899; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XF2VmCDJnpXIgiFaGUBtPdUTCN/KhchAk0nVPRL7Ydc=;
        b=yWcG7v6cKjusBwkB9015zSyX4RPqSOd3Eyltft/TWnmha3+91kl2nGge3mvuj9CzRN
         iRl0NJOsYHySphVNKH60jsO4pk5CPTt4VQThlRjHt/p6DrDrOv/lG6uI/WuZ73c0mjH3
         9fOnw6QbWXOsBSuUpAByJqRRxP9WJC89dpamnsGhfRJBgooBV9c/2VyY4USWGdMEb1RY
         hyzLsrDj9eCV/4me+NxwyrgvHfWufGqnqH+Ercs8HXIJBouR2ReYNhYSm7sH2yeLprVj
         zcBnuyEXe+B24gqZQjG8UpZk0EEpTZ1syuEhBPsD7+eem1gR1MRfItejR29Y7QpNhyti
         nRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794062099; x=1794666899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XF2VmCDJnpXIgiFaGUBtPdUTCN/KhchAk0nVPRL7Ydc=;
        b=TO5eYUD2LKo4dQUMmpDGcmpjO083/H+68fqtvW/D8f5LdKMwuTSAgjghFBifx1Vv0q
         zsqLx4ry7PpqMWUkuj3GYT3BwR4jlUQ47ea+E3TfbMoRQnaJnBCXf6wO4lrHII5dOfSk
         QhKeIxEQjLZb1JCS/iVCmiLXQ8dRCWapZ6EVem8soXREGQcMenPG2CFloOvASPQJJ+aV
         aavXCm8doSuhezU0a6dTn9wgYKAUMyJ+ixgzMK7sGNnW1Dgehw99kymrn4ZzryPNqtY3
         QVYHvUi0Vj9uea/n/FbSiahWyoMeGw1d+doKkWoOXSVxoVhMpD0I8a1PsJo/TnSFXnL5
         eNig==
X-Forwarded-Encrypted: i=1; AKwUvBxuAFRDscWxhd03Alnd1BHh9MMxlS1ZAxsxpBSif/RMN3lp/lLrokTPGT1PhBxLT9G6c0UZuQSWNeADsF7kQg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8dI9BvhRALkiocDl90kgvQkWAsN2LwTKVbaX+4BREHY5HGHCaK
	i2SqA7wp5CZXUsJnLBrPu3uynWDd6LLAXK21Pna7M+P1unmeabJf989E
X-Gm-Gg: AYBFou1xZVZbtrNhzklqF/OrwkbjD5Mc9b7wM50K4EFbaKuS4Emu4ZvevWKltjrrNlA
	qnUxTa5KkV/xqYE11ApsrlVmXnZET6ipByt7qOVKWpE3lxh8VHPQ6xcfTR4wa6qi+ZwAI7v+RmI
	eN8/yMFn1ucHV8APxGwmGeT/qK214zimgTUO7029KUMRG5M1h17a3GuL3MUSI12QbPsdq3XIbbA
	uyuAYu49/hR2VvWm2Ket55T97w3XbCw510SXLe0qLmSxYjin6XFmxWmaXOhtRhXYeG63giNdaag
	EEaEuwGkkemPZAT1ggio1cEXSIQjQ+Cg7yJi2242t2kj+oSJtqZ6/YcTML2Bd9G9jeo1kB9YUYX
	ndFzkvlcVYq0Mo1AZm+6bKUnIvKuy8UKMkaRQQwnGXKwvuhcPV0v637PZyiW2M4I+R1D59Rkar2
	p6gCwuzTE758RKSyCB7U4anLOQZIfqe+hwlW0ZnyFNC4ysZd8fhsozPWH0ElF1eRlgoj4+wIAF1
	pAa03esx+ALUM0L7KkttH/OQHMKjDJph2KelV7mraDgSA96okw5vgZBKRsP13kImqgynw+EgvC1
	Z+pLQdeIY8q6BUxB/qoLQyQcveYyGIK46D/ticRF+xTU4HUFfJOV5x4FWBMiOPkHjvI+3xW9vVg
	F2lHBTuMMZMKisfQfhhqEjsdzM326JUcbrkFNnjJQSRwzTg==
X-Received: by 2002:a05:7301:d808:b0:36c:9af3:2309 with SMTP id 5a478bee46e88-36f6f2a4632mr7502669eec.0.1794062098568;
        Sat, 07 Nov 2026 06:34:58 -0800 (PST)
Received: from localhost.localdomain ([180.182.24.11])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9aea75fsm27881873eec.15.2026.11.07.06.34.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 06:34:57 -0800 (PST)
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
Subject: [PATCH v20 09/12] ALSA: virtio: wait through signals for PCM teardown
Date: Sat,  7 Nov 2026 23:34:19 +0900
Message-ID: <20261107143422.29319-10-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261107143422.29319-1-mynameisjune111@gmail.com>
References: <20261107143422.29319-1-mynameisjune111@gmail.com>
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
