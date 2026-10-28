Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180523;
	b=q8lG9Zxe3GivS1K8J1UZ1tP8TmAIv69LxVdJTuIekxSgpS5/l4KGxLvWDdFwyhZgVB+I
	 /X2HtKMdd3YiuJjYbvxu/MmDd4em7QZM44hdZkueWcmsmQlzf3CFWOnxPa6qXI05ISaUY
	 UqN9/a/IyWmerSv9ochiaN8oTA2zgvWgXLerDBQboLDbEfSjF0evoLcELQ0vLZ54WzjKR
	 G6dJXoi4sXX6uAi55QdLumb71yfa+Xj1Ct0Y3kOM6tXXnCW/1DKnNgf/18v+ttIBiCe9E
	 eIU/+HWJDWqsyk+zWhYRoOrbBheag0SzOCIqiVR3/F/yBqPAJisc6fFXPDnGu+b319A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180523;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=THGvSriruXU51ZqrJHmjnjtWkdka3P5vgj19t9/O78M=;
	b=PpbwHe5M8qehkrJr09c38nRg7dF8S4DMoaP9gyVS3hGMZn7KnMa0gSuHCvZY218y2op1
	 QlvzN3JOSEXdjAzGJCWSzSVk2jJlXOC+f7oQkHqG9DwuvxiuB1QURz0be7F32Gbgz9O6O
	 4/V3EEavNLWNhzu3U55jrqUjspemwH7cDuDNFh1yyqoZdnfGVCs0ZEQC0Fdwwzz58JOf2
	 8fw2hk6hdTFhJGADalq5uZw2BKtch4szfQV+EpMwqIQFmwW1w12cDIFcalpK7S06uaQaE
	 hb/IH/fl2wFUS7xJLLNaNZw+msFGofKemM4zMpAf3VbzevxeBrOb0NbASg8cTpgE+CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WWUNqYai;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE14960A2617
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 09:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE14960A2617
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WWUNqYai
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ac9f49b984so464339a91.1
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 02:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793180522; x=1793785322; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=THGvSriruXU51ZqrJHmjnjtWkdka3P5vgj19t9/O78M=;
        b=WWUNqYai3EdYDQwsPlwSeYQmbFURR/tQXhMG0hOlIc3w+GBQBwHO5T0nAOwAF7A9BT
         bTY+0Kx3nEVGDFlHq8XHlrTRWOkt0h70Hun/Nz2qF5p6vzQLKpJ3UBocVu3xuPhBWzGd
         zf3ZfqnHmjJYrXknJg7qCPRl24V4P2GJJ7FWu76dqfXFlzzJrVlQn57Rgbq+LIAET7nI
         95/QwZ1xbvc3sfMcC36tmgLD/VXXQ9yu0aZUmio6LhjcyYTRvaDcI4fRG21vXhtIRHFe
         kSkpXtidtRx1crVeMweijyAlzPAZtLAN1b+uaNqr2v0kn4O2u5nYcC7AwdaFl5YTPIMK
         nNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793180522; x=1793785322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=THGvSriruXU51ZqrJHmjnjtWkdka3P5vgj19t9/O78M=;
        b=qNMm6QnWiaHajmW0w46W14CVdih87mOwR9LaTZQLq+76le3y9BTwtqazeh/MMbh0jj
         Zp5AIFtxiB0fvoQ5A+g9EyMP9KEo5+AR43YIApbU0R/voei1vIb0c22o5nRD/K7FYCOP
         fPWFNHmjlU3sUd29UxgPvpFuwqECWToYN2R8uNIFfGU7Xu1SwHd+iY7y/03B94YQOQLJ
         DfzYq+CPTcYqWfHTQwDCnownP8G2H4rvhvxIYNh9wj4ippBFcbWNU2n8dJvKSvNS/v/O
         bWK48SOcsYhkn+jN52BZ2rYQhdIJ/wOGn6K+VYLOWdo3n+v3Xkd/InTW8Y6IOf6JjUeb
         4L7A==
X-Forwarded-Encrypted: i=1; AKwUvByO1NosXgVpboLI0e/KZ3BBEOkOAWtNybqkBhuRWQVMakbcLhNSpFWXM4cEqCDbcpQps+3LmL0HK2leUCP0EA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJWQVMVE+i27QfMtWCtZb+GoUKSshBdMFFI3hUh5vEYUN2OaGn+
	n+FyB6khcNtpylO08wIyZPZ4htZTl3yR2rAHN2x4sPjhO2WluOPIvOBf
X-Gm-Gg: AYBFou3HTsZB0072DCYHZtuZlEXGOwF8q/+rw4d5T2bcTST4Cw+GB5VIS4T7X880kfa
	BPUDdamQj1znpaGUAkOGL+DJsaWA0DCF6+1r3DetNe4WXflVDf2Te6GiKro16c/8NDsLTkL/hiG
	tbLpGNJCKZUMKM7MIgoPyc+ksPJ0CFDlK2wH1V/b1KfUT1V01ZiQRGok3iZ4JS+yHmgwhlZK9DZ
	SYBhZmzqcr2rrNTb2P+EKjeTU2kEif5OKS2ZxhE1Kg/fI/L8SfRaw5X600fT0JO14ht+f8z78CO
	USrOcsyF08EKJTPsd3/BI77qodcZ6o/REGuB7SykGfS3AZiuNva5cexpdab8J/z6OX/39yhLBQD
	l+xrH5UdW6UnddZ8OskSSCCY90oOgAXQUmQR9TgzpVKrWm/rEL7xnlh+JLtUO0iitwZbaj4Y+lU
	R23YXpU2RKBmaEXcmXbOLtJfV4faUPAU4z5JerLKjRvdRXfTsr/yA0oeF01Zu5s56siN7jTeqJb
	PznnrGLav9p1Wxkf941fUjJQ/nWhT3n/NVx6UeqmLmA/Hz7jaksJg3w2IX6qtzQkBZOWApBLrid
	+3j9L2otjogKxfDU72UQgByaH5HoN/P/WjpdEbnnPcYLdKMLX3ygiLGvehQKmU2yop7WwObw5Gv
	OYaNfQ474aNti4ZKSSGhOjElrWKN+GWgLuMuMxJRKnlCg3r8=
X-Received: by 2002:a17:90b:2587:b0:3a6:d850:bf16 with SMTP id 98e67ed59e1d1-3ae5c86a185mr502672a91.23.1793180521633;
        Wed, 28 Oct 2026 02:42:01 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a93b3f5sm2242377a91.5.2026.10.28.02.41.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 02:42:01 -0700 (PDT)
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
Subject: [PATCH v7 06/16] ALSA: virtio: wait through signals for PCM teardown
Date: Wed, 28 Oct 2026 18:41:22 +0900
Message-ID: <20261028094132.20364-7-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261028094132.20364-1-mynameisjune111@gmail.com>
References: <20261028094132.20364-1-mynameisjune111@gmail.com>
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
 sound/virtio/virtio_ctl_msg.c | 15 ++++++++++++++-
 sound/virtio/virtio_ctl_msg.h |  3 +++
 2 files changed, 17 insertions(+), 1 deletion(-)

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
