Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CF43B637A
	for <virtualization@lists.linux.dev>; Thu,  7 May 2026 12:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778155689; cv=none; b=BKv284t86dAPyqvmsme29aM9lhm7zqp2c0gWXF75cE2lSs2dmZsK7D3DzcWpG+dmOnkXCPrTKTsTX3og2wQT2VN4Do5oq/ays0CxPuSOQLVS73SB2E8ZgKJRHRYbrTlz8rlV599xVzPg9tudm9eVpQjkXGwISxRVDycccvDHBxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778155689; c=relaxed/simple;
	bh=nB9U/ItQ1bvcodF2365WONlT+9vQNnf7DXqq0m1If7k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KRNpqFLv/d6vvMIAkoYXO1DMKbzBMMdBbo4rTM2Qb91DzTb0r5IVHrPq9b6xDhtdyIg8rLgwJcVj1Aael/LSJJhosiythfh7kvXOu8rLigqWEDHRQbRZ/tb/mtyRnNsKDvPubx+2uXh/nPSB5oZiGMF4n+GhuW0udZIo8hr3DO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFGjuYQn; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFGjuYQn"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8353fd1cb5fso354912b3a.0
        for <virtualization@lists.linux.dev>; Thu, 07 May 2026 05:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778155688; x=1778760488; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HCGsL7JI5dLO0F8jNs4xTyVhYyOAvc3wlqNUFV7UDsw=;
        b=lFGjuYQnPNcYYLMDZx77co7xdsSK362s1MytYqJdjohm0VB07/WkBFx73h4AvlNPCG
         mSil7OHIT4VeUcUU6/0VUUKCEPRd9cjgbiNDJqZyrDRk/PgT5LFV2VeKbV1Trm/nrZNd
         v8AG5klY8TJPRRFVIknpa7hN/AOovdogxigbnElP3O0nPZxfuYEcB2i8pAkHwY5nazK/
         zf2NNT94iHzaRgXzHwv3qrAXGKY0lGC3S5jpYoiWFulcsIaA+7a60ABzvnpiyCvvxNQ2
         4IO7pGsFyopvAHTjMXSVF862pn4xEJcIS4eGCvQr+4rZB+QzMBhMyIzM1lAmQbv/qsQv
         jp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778155688; x=1778760488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCGsL7JI5dLO0F8jNs4xTyVhYyOAvc3wlqNUFV7UDsw=;
        b=SKeWpAIbm+/7HMdVKAjBpGFnZSKe3pcALkq9ZDhTgkYeDP+S0oNYgmM5AMZkSXmU57
         NvDGV/pjbKu0789EZzmcACA4hizeG0hrVimEDKSm7HUWfplQxUH8MH4IiouZnVYwuJ8n
         f6WnEhyegAMNFdNzixnU5wmdRUAIvwMoyzFX4Ci9Rvr0nb3+FwDt+p6FEThgjGyUPJVq
         PY2bNyy24aYQ/sxkCS8Os7+qjW8hFFrIzCPdIIDPm1eZjz/EDzMAIuvVLiHiv414Rv+u
         SCsV8hNhkFeEaKxrEsLbwyGoFMALq7eP9a/vL3elGkKIDacL/sHKPj6peP7CE4t7Po5W
         8BBQ==
X-Forwarded-Encrypted: i=1; AFNElJ/sJ/ihYhs9PiiCKKeWL9rFzefFZfnEqMAq9wUxZRJXo067Yt+QGE01D89MHTbxRooSvktg5Bp+5dHiQCgokg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxlHbxVma2VuvSF+c+4AkiVlJXqiEC8RUpQH7VnySLVOX1cbmyA
	J7etDZ32Iz64vhra/bSVyDSnK4HiZH5d+vwEKN66jezJ26tfyo4getzy
X-Gm-Gg: AeBDiesPgSCI1/nXd9oSKQzmz0w2j7arpmbHeCLiY2ep0116GkV8rsqxnqJ0tHBGmnT
	7koOg10kjDODxlkQzLDDPKuHWBRSPV2yjTn8FmES5tMSCawspWTAGH2o1SADN6jTw8oMIlyFuHD
	/6Sa85rPNGPA0DYXrg9V9h4cwf2qcqLKfgVYJltctEoXs174mAmixob0Yfb9f2tBW/hiXwX59cc
	5rs77a/4z5Q0qG0p6owVpTUyBrEB6yQGiz7Sg/mFiKZn6+fUIaSPhu1WTR4cc7vazz+JHtYN0xv
	iYOkcvcLG6keRRypurMSYZB45j2pvxs+bS5pcQKPiirKdpDYwip1hAmebZ215hoA9o4+dEz4Els
	Gk8nXqeTQmrWcrRDK1C3yUZzaFYe1S72TSxYKVr+2r0FaEmcvHZuiTg/WC+j8TKoi5XFYGoaER4
	ZXyZeTsPbRuy4SR7F4corHi3+sn0O30yv91ho=
X-Received: by 2002:a05:6a00:a219:b0:835:7c0e:b530 with SMTP id d2e1a72fcca58-83bb3d7835dmr2355039b3a.0.1778155687457;
        Thu, 07 May 2026 05:08:07 -0700 (PDT)
Received: from gmail.com ([114.249.134.218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965946543sm11540634b3a.16.2026.05.07.05.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 05:08:07 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: Peter Hilber <peter.hilber@oss.qualcomm.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jia Jia <physicalmtea@gmail.com>
Subject: [PATCH v4] virtio: rtc: tear down old virtqueues before restore
Date: Thu,  7 May 2026 20:08:01 +0800
Message-Id: <20260507120801.3677552-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_device_restore() resets the device and restores the negotiated
features before calling ->restore(). viortc_freeze() intentionally
leaves the existing virtqueues in place so the alarm queue can still
wake the system, but viortc_restore() immediately calls
viortc_init_vqs() without first deleting those old queues.

If virtqueue reinitialization fails on virtio-pci, the transport error
path can run vp_del_vqs() against a newly allocated vp_dev->vqs array
while vdev->vqs still contains the old virtqueues. vp_del_vqs() then
looks up queue state through the new array and can dereference a NULL
info pointer in vp_del_vq(), crashing the guest kernel during restore.

This can also happen during a non-faulty reinitialization, when one of
the vp_find_vqs_msix() attempts is unsuccessful before a later attempt
would succeed.

Delete the stale virtqueues before rebuilding them. If restore fails
before virtio_device_ready(), reuse the remove path to stop the device.
Once the device is ready, return errors directly instead of deleting the
virtqueues again.

Fixes: 0623c7592768 ("virtio_rtc: Add module and driver core")
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
Reviewed-by: Peter Hilber <peter.hilber@oss.qualcomm.com>
---
Thanks Michael for the pointer. Resending this as a new thread.

 drivers/virtio/virtio_rtc_driver.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio_rtc_driver.c b/drivers/virtio/virtio_rtc_driver.c
index a57d5e06e..4419735b0 100644
--- a/drivers/virtio/virtio_rtc_driver.c
+++ b/drivers/virtio/virtio_rtc_driver.c
@@ -1257,6 +1257,15 @@ static int viortc_init_vqs(struct viortc_dev *viortc)
 	return 0;
 }
 
+static void __viortc_remove(struct viortc_dev *viortc)
+{
+	struct virtio_device *vdev = viortc->vdev;
+
+	viortc_clocks_deinit(viortc);
+	virtio_reset_device(vdev);
+	vdev->config->del_vqs(vdev);
+}
+
 /**
  * viortc_probe() - probe a virtio_rtc virtio device
  * @vdev: virtio device
@@ -1282,7 +1291,7 @@ static int viortc_probe(struct virtio_device *vdev)
 
 	ret = viortc_init_vqs(viortc);
 	if (ret)
-		return ret;
+		goto err_reset_vdev;
 
 	virtio_device_ready(vdev);
 
@@ -1329,10 +1338,7 @@ static void viortc_remove(struct virtio_device *vdev)
 {
 	struct viortc_dev *viortc = vdev->priv;
 
-	viortc_clocks_deinit(viortc);
-
-	virtio_reset_device(vdev);
-	vdev->config->del_vqs(vdev);
+	__viortc_remove(viortc);
 }
 
 static int viortc_freeze(struct virtio_device *dev)
@@ -1353,9 +1359,11 @@ static int viortc_restore(struct virtio_device *dev)
 	bool notify = false;
 	int ret;
 
+	dev->config->del_vqs(dev);
+
 	ret = viortc_init_vqs(viortc);
 	if (ret)
-		return ret;
+		goto err_remove;
 
 	alarm_viortc_vq = &viortc->vqs[VIORTC_ALARMQ];
 	alarm_vq = alarm_viortc_vq->vq;
@@ -1364,7 +1372,7 @@ static int viortc_restore(struct virtio_device *dev)
 		ret = viortc_populate_vq(viortc, alarm_viortc_vq,
 					 VIORTC_ALARMQ_BUF_CAP, false);
 		if (ret)
-			return ret;
+			goto err_remove;
 
 		notify = virtqueue_kick_prepare(alarm_vq);
 	}
@@ -1372,8 +1380,12 @@ static int viortc_restore(struct virtio_device *dev)
 	virtio_device_ready(dev);
 
 	if (notify && !virtqueue_notify(alarm_vq))
-		ret = -EIO;
+		return -EIO;
+
+	return 0;
 
+err_remove:
+	__viortc_remove(viortc);
 	return ret;
 }
 
-- 
2.34.1
