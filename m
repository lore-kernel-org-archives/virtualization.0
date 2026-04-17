Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E31C315D46
	for <virtualization@lists.linux.dev>; Fri, 17 Apr 2026 13:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776433808; cv=none; b=fih8/CCSYaTeAEa09CU6HsiPGtDGGqnjJSDyxuzEhwY7boaxCwfAWD5W4D2Ir1vETFhC5sgPZIvn04ZQ0CtUv/BXkt6PUq0UAdVWYuFrWdKo/gCySF9Tpd7QCOF5RsVAFl42MyAjsqT5j+oDAVhckmKhtC4YJCQtOXlMiFAh1xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776433808; c=relaxed/simple;
	bh=fo4xhoC9NzPbZRZBW63KZnbvMyUJGRXLR+fuMV1h24I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jweLwySlEJDKHNWH4jzxVvXprGTF4DxuXArNOmTL2t/XKH9EuRySUB6GI+QVJxAmx1ScVd/vlbY7G4iK4jdR1YfjfHnqVk8xThGvilb76lXN6KZIYoi9pcN7HEHJN/0145aTibuClYGVu6ivAfq7lmnyP5cEAZ9RNbaemS/hv9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p07I7Nh+; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p07I7Nh+"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-824c9da9928so396245b3a.3
        for <virtualization@lists.linux.dev>; Fri, 17 Apr 2026 06:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776433807; x=1777038607; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C2i44n+1eaFoKthvoHXkc0Qb+3fUcYde9FhFl3lRY+w=;
        b=p07I7Nh+N3GBiLHR0XqIUBcjZq+3TpU/q2A8clbOdqqXiUCuiBT+aXCXZZG/iXwWRc
         X0TtzEelE8N+gpTpio+p5pxbmBPedWUKAeJuz8lKP2G+jNl5rPHNBOXkaqafnYdURlUL
         4TxWDI3umyRaPFbtJ31FJpO3RI+KTJMzRulwUDpE+hL/3gLdSGfbppg84kBNZ9fErKbH
         L5tcAd6nAsyCod9hAhUAEhulPRAzjYLkZLgsmHA75xog2FzM9tviqQaOQgfLFqoIIHzm
         l7IVkAOlqaSdic/BS1aziS6I9Sa8WfH0rVXNb1MdoNrpfWREFVJRRLyuUL08FpHMkkFK
         r0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776433807; x=1777038607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2i44n+1eaFoKthvoHXkc0Qb+3fUcYde9FhFl3lRY+w=;
        b=DJ1VsfWmtIrEaFO+NZAzp2Lzhj5C9XWAyaFMkhU9ifd2DrEZkPgrC/r8D1GcPG8HUk
         UDgG0qKiNGypfWBik7kZrZh7l9yxoDmWJDizjRbUREodbw0cD263YGMxj9arL77SxQ+T
         GJ1HC52yaOwG1BchfnJoP+J79yeUXAO+qM3u7pf7l6/yG3UhSZ6vKFNoS02fJ5ASy5Nc
         Gn0Rpd4lwlWSEwa5f3NtQ0i2DafaJOc1T6nk8+ITEC1xZAyZwMdZgoprhoHVoGNcNwU7
         AUJ7HfkmSzoQWKHrlGT87xRhTwGswQASYmPt8O6oZOza1fViVzAxmCfG6bsyXiCSF97a
         5lOg==
X-Forwarded-Encrypted: i=1; AFNElJ9Mi5CNix3YqusjGtSZoBCkh0Tmr+GW1tMzd2DzN9Be4iRANvSPzN19vI8plYU2X2np4C/pIIBkFobZw1RR1w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwoQziMAI3eUugr3yFOQ5Gj1AvSKK1IDbE9uG0T7L6ySbs1vDOP
	L0MyldUj/kATm9wea8siPuK6v9y4s9u10x76/W6gdbYTytMGxtUbQCYf
X-Gm-Gg: AeBDieu2KVmWe+hwP/WiYyR9wUQhuqJY8l9mjCvtj3kvyyRzJ/A9Av+HznPeip13YDb
	DLFPXQ5dz5QVFM31E7h+horpXOaSTj6khfwTMMhnjGybKHiB4OR8vhlFKF4yecy2kwVwhW6IO7w
	Bw05Dzaf8gmDhkdfVdNgJWh2yvc9JdorRhDlOEgpTvWuPJMxI0yPJzj/Ch6JX0yXMwU2d7gPLjm
	fDs+sqZZk9+7v6fkP6QJ97Ca9xXMF3/vcf5ni7RvhugRjqOnNS9giU9S/uXLXYxCrmumnrSSk9f
	LLcSDhy6e2SKTTPOsTQLG9hz5ZPwiS0shtrsw3dV1xbaDlN3MGPka/bK/9PUcCp+/dgsh6Lgm4g
	YhF0BnPFBX1PcCDHukLutAcbsQUrHb7UMoxHTStRNWNtbrmV7kZfn4RowrOz7OcQLxGsUoSsy7w
	jKwCgS9JHN8CFHW0/Uilz76hrAw3zerNDeU6c7fVqBkdpOuTtDEw==
X-Received: by 2002:a05:6a00:148e:b0:82c:9cd2:fee5 with SMTP id d2e1a72fcca58-82f8c87e28amr2673000b3a.7.1776433806291;
        Fri, 17 Apr 2026 06:50:06 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.126.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9d6adbsm2877558b3a.18.2026.04.17.06.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 06:50:05 -0700 (PDT)
From: JiaJia <physicalmtea@gmail.com>
To: Peter Hilber <peter.hilber@oss.qualcomm.com>,
	Michael S. Tsirkin <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio Pérez <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	JiaJia <physicalmtea@gmail.com>
Subject: [PATCH] virtio: rtc: tear down old virtqueues before restore
Date: Fri, 17 Apr 2026 17:08:31 +0800
Message-Id: <20260417214953.793956-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

virtio_device_restore() resets the device and restores the negotiated
features before calling ->restore(). viortc_freeze() intentionally
leaves the existing virtqueues in place so the alarm queue can still
wake the system, but viortc_restore() immediately calls
viortc_init_vqs() without first deleting those old queues.

If virtqueue reinitialization fails on virtio-pci, the transport error
path runs vp_del_vqs() against a new vp_dev->vqs array while vdev->vqs
still holds the old virtqueues. vp_del_vqs() then looks up queue state
through that new array and can dereference a NULL info pointer in
vp_del_vq(), crashing the guest kernel during restore.

Delete any old virtqueues before rebuilding them, and clear the cached
queue pointers so later message requests fail cleanly if restore does
not complete.

Signed-off-by: JiaJia <physicalmtea@gmail.com>
---
Runtime evidence from a standard hibernation test_resume run on a guest
with virtio-rtc-pci (no fault injection):

  KASAN null-ptr-deref report in vp_del_vq.isra.0+0x70/0xd0

  Call trace:
    vp_del_vq.isra.0+0x70/0xd0
    vp_del_vqs+0xec/0x358
    vp_find_vqs_msix+0x24c/0x6a8
    vp_find_vqs+0x88/0x360
    vp_modern_find_vqs+0x20/0x90
    viortc_init_vqs+0xd0/0x128
    viortc_restore+0x28/0xb8
    virtio_device_restore_priv+0x184/0x288
    virtio_pci_restore+0x44/0x58

 drivers/virtio/virtio_rtc_driver.c | 38 ++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/virtio/virtio_rtc_driver.c b/drivers/virtio/virtio_rtc_driver.c
index a57d5e06e..c1adde27d 100644
--- a/drivers/virtio/virtio_rtc_driver.c
+++ b/drivers/virtio/virtio_rtc_driver.c
@@ -427,6 +427,15 @@ static int viortc_msg_xfer(struct viortc_vq *vq, struct viortc_msg *msg,
 	sg_init_one(out_sg, msg->req, msg->req_size);
 	sg_init_one(in_sg, msg->resp, msg->resp_cap);
 
+	if (!vq->vq) {
+		/*
+		 * Keep runtime interfaces in a safe failed state if restore
+		 * teardown removed the virtqueues.
+		 */
+		viortc_msg_release(msg);
+		return -ENODEV;
+	}
+
 	spin_lock_irqsave(&vq->lock, flags);
 
 	ret = virtqueue_add_sgs(vq->vq, sgs, 1, 1, msg, GFP_ATOMIC);
@@ -478,6 +487,17 @@ static int viortc_msg_xfer(struct viortc_vq *vq, struct viortc_msg *msg,
 	return 0;
 }
 
+static void viortc_del_vqs(struct viortc_dev *viortc)
+{
+	struct virtio_device *vdev = viortc->vdev;
+	unsigned int i;
+
+	vdev->config->del_vqs(vdev);
+
+	for (i = 0; i < ARRAY_SIZE(viortc->vqs); i++)
+		viortc->vqs[i].vq = NULL;
+}
+
 /*
  * common message handle macros for messages of different types
  */
@@ -1316,7 +1336,7 @@ static int viortc_probe(struct virtio_device *vdev)
 
 err_reset_vdev:
 	virtio_reset_device(vdev);
-	vdev->config->del_vqs(vdev);
+	viortc_del_vqs(viortc);
 
 	return ret;
 }
@@ -1332,7 +1352,7 @@ static void viortc_remove(struct virtio_device *vdev)
 	viortc_clocks_deinit(viortc);
 
 	virtio_reset_device(vdev);
-	vdev->config->del_vqs(vdev);
+	viortc_del_vqs(viortc);
 }
 
 static int viortc_freeze(struct virtio_device *dev)
@@ -1353,9 +1373,11 @@ static int viortc_restore(struct virtio_device *dev)
 	bool notify = false;
 	int ret;
 
+	viortc_del_vqs(viortc);
+
 	ret = viortc_init_vqs(viortc);
 	if (ret)
-		return ret;
+		goto err_del_vqs;
 
 	alarm_viortc_vq = &viortc->vqs[VIORTC_ALARMQ];
 	alarm_vq = alarm_viortc_vq->vq;
@@ -1364,16 +1386,22 @@ static int viortc_restore(struct virtio_device *dev)
 		ret = viortc_populate_vq(viortc, alarm_viortc_vq,
 					 VIORTC_ALARMQ_BUF_CAP, false);
 		if (ret)
-			return ret;
+			goto err_del_vqs;
 
 		notify = virtqueue_kick_prepare(alarm_vq);
 	}
 
 	virtio_device_ready(dev);
 
-	if (notify && !virtqueue_notify(alarm_vq))
+	if (notify && !virtqueue_notify(alarm_vq)) {
 		ret = -EIO;
+		goto err_del_vqs;
+	}
+
+	return ret;
 
+err_del_vqs:
+	viortc_del_vqs(viortc);
 	return ret;
 }
 
-- 
2.34.1
