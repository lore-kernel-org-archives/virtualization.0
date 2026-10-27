Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793144652;
	b=aiv7XiEXR6Nf+KK3vRgKGSxdSA2uyUBvpP3qXf6hQtaNvF9NVxUUJZCil39G/Luf9kjR
	 ZcESudQ6QuxN7BP+t0ZMSXgbDONgfg5ERRHoxm2KHlAYayLoizpje4oZIskAel3G94a4R
	 /yyvrunzyMbagVCnPN0ykew6hFbYlhE/q/97zqP5jxQo3P8B+5NGURACHiywnHNZYImLL
	 lUcDPlsTx0uNqwhlTREuZdnAJsTObwTYOqjngxQjewuibHW4L1LasKkR1oRyU12lvgeln
	 MLEJF++Otj5FPOrsRpfWSGBKdM2Wc+V3ArGFuqg1rln5tFfTo3T1GLbTautgaQ8t8lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793144652;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=THGvSriruXU51ZqrJHmjnjtWkdka3P5vgj19t9/O78M=;
	b=vVwxnka84XBxyAtycGhb9hP5ogdsITgJBfk/dMa8uGeTApaL+WIOs0Xst/cha7o3MaEm
	 3bbf3HBl3EQRlzrBSMCEo2gDEKM1aNQNKablxb/tfz0XAcQbOq0EcGybo7k0clxf95m9J
	 z0tWvC1UiinegXCxJ09hxy2mfEy0ETHNKiOJR64sWRjWYlvei2x98KgFPFDsNvCF6/9Gd
	 z7oeyfY78vR+iSuns1EyqCOAxtMt2LWZvVno2GSVMFeqLSSA+SGt68HQtjX1iQ0kOCL5A
	 N+OCAxITNZqdicPVX/C0/m+54bTDzZV+GDwjiheQmC/sdy1R8Z2In+6ovEcJ0GAUkdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IlPbdt2C;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6767A606A31F
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 23:44:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6767A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IlPbdt2C
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cd67cc518a6so292308a12.1
        for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 16:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793144652; x=1793749452; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=THGvSriruXU51ZqrJHmjnjtWkdka3P5vgj19t9/O78M=;
        b=IlPbdt2CGUOfl1x0jnoD9VsxPy8VInLhMkYjR77iqTnJ0gKlWcznjqeB3yYPQAPtaa
         s/qg4jIu6Oco4tFKbalytOJdsQzkm3LpDSW0QvTELNuf9N2hZK11NB37h8gMxAREt1tQ
         Zf7RsUZktCg2rJXobtxA7/p8o23EgwSapdNxBsaDSR2botOvV2HpyOPPNMknVs3fmLGY
         0IEBNOsTH/fmsbH1uZ6sV2oHiFWGonyYXQ7D1m0UgoSmRJ4pmR8gCt3P4u7RZ3FfdgEw
         VJMq+qhnWZ/0Zbtw5j7Typno6zeoJSA/btDMHydPIkzaYmdmClt3hHVAjZVspE/j4zKB
         saDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793144652; x=1793749452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=THGvSriruXU51ZqrJHmjnjtWkdka3P5vgj19t9/O78M=;
        b=ietOf5W4VJD2oZW720+FfmytOgx/mW8HGgQC4GiJJtYUuwxGriwGrllfL+0zcb+I4O
         fQV0I06cmzGiQHWSpH54OZf+PynbUlr1AMvNEFnKQ/ebeZgNW436YUIf90erwzlp6Wrc
         BnoUUsda7vBl2GA5Gcau2w+irYzWAzphzVebnqXeI5BYnnuocJv9XbqaE8FT0Rpzx80Z
         QzwahKAJFjvluXEahY7rgOdbePgHS4eGUTRJxXWrrR6mnDSXX3D8Bjq1nQdamXd/Ey+O
         Myu3869/wncE02EmY1YQr8yezW6frJI0t52MV2cj5PDbLKj4WXl4TDtSeGBLJxNcA8Ah
         1Jaw==
X-Forwarded-Encrypted: i=1; AKwUvBzbyGs6Z7312pndLj4oWjPFU/iLatnw+UVdD+kLZbt77UlGj6ODQ+b70MGj0zh47ZMru9q51O4Gq4CblpcJaw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJGVfj0Dg7q/hAyWWRk3yPSNvrN1KGYtI0EYOi6z6/nFmpgAzV2
	pbKMEs9+mvtWLVqJau4QhkyDhpWX0sfJ+cVvGQmI5vWh0xU9hsxcpnUF
X-Gm-Gg: AYBFou2OU0QEnuIta23cryy+EkRuvNdSlK7sWe1UdDQq5sYXnjDtEA71v0MbW0yDvlD
	+/f2lnZs/nk9okXeGFTbujj5A2sqga+Arteeg1xAFaKrgywXxYXahoo5dtWa2egj1Tk8LRxc6jN
	LLCoNLGHobcnM78tOxtCQMxBgDLL0zwHKVljTfYF5M9xEHPM841mpm57ppPjZfUMd7hAeGbvEth
	gZ/qcffqMphBpKqmNiOCvcSnuxDhLAp7iMea8hSMY0AoOCgG/nsvpmj7YWXtjBMMP5s8ElGTIW3
	EHmIRqAcitbVf/WGVLfhWsScERi9gNwC38KdOSxgpiMA3wulsN68My7VEkn18iGeghn/TgKwBEW
	bYtwXM/FCqWavCO69piIpeyWeOUxf7jPfys+1f8f6BDvjAAOph1yYq/LiUbTpS3uJMoKkcEEMkZ
	9n1hzwwo4XHsYFkLAlvkO95V64fIYaPxMPtm9cNTQ0va2PfGEnU2bqh9gshliAbGRpIjLXzLYya
	iZlFhVRPyyZVZafCbZZlnNUjihhVs4eQyE2QtE+9llA8HT5ccxv3VBu7VKRzEaIwFZWmOFj6PZ1
	EdNlLenOZfyu7HZnSc8pt9cRcdeJ7dKg1mwFDoNaFAylPgnsPTyQ162hbGdfHBV9KPcg11Qq7w=
	=
X-Received: by 2002:a05:6a21:a94:b0:3e2:b416:3c8e with SMTP id adf61e73a8af0-3e9024879d6mr509126637.60.1793144651785;
        Tue, 27 Oct 2026 16:44:11 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a662b9f5sm542507b3a.21.2026.10.27.16.44.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 16:44:10 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.de,
	perex@perex.cz,
	anton.yakovlev@opensynergy.com,
	mst@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Joonho Lee <mynameisjune111@gmail.com>
Subject: [PATCH v5 06/11] ALSA: virtio: wait through signals for PCM teardown
Date: Wed, 28 Oct 2026 08:43:29 +0900
Message-ID: <20261027234334.32551-7-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027234334.32551-1-mynameisjune111@gmail.com>
References: <20261027234334.32551-1-mynameisjune111@gmail.com>
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
