Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6953303A04
	for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 04:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777003684; cv=none; b=ZAdlcseYEh6X4hkwNxorRCArx3XFKZ1LzEkZhhK/5WeE4UZP1xedPwQEf3Wlu9ejly7gO2UABccJ1MPYTSMg6G85AgDao04x3qJZAKlC0ITNKsQfJvCRLthRS0ZHVZoPi8zuAs5x/vHiiDsKl2Is8c5flmSKu9CvqyuecVvp65U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777003684; c=relaxed/simple;
	bh=1jqgqePiCpWS5lWhDTPGPcI+gdO+taxTOjKbPiuxaMs=;
	h=Message-ID:From:To:Cc:Date:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a4qkKPcl5SpuXR8AM/faWWgTTodgaLfbgCi1YGAGVCri4dnvqkFCE1oJckY6Zw4AjuXxfYNXLgj0APPsM+bwHJVCc/mUr75eH8skPhFaK89KUYyGvmFGYtyRCR9YX/wYnyr6UZswZJfdZNfLGWAsiujORmamooim8FwbE5e/3jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUC17Qrh; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUC17Qrh"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82f6b592fc7so3379619b3a.3
        for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 21:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777003682; x=1777608482; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :subject:date:cc:to:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebTz24LbM5JUkJMnX0UTG9L5NdW7NGB2BYBIfLQKtDU=;
        b=aUC17QrhsOhjMU+YFdXbPbeMokWu1ZYq+HSD7uIK2PUoeuXunBnbvzAkQmfvz4yTpp
         lUkH+XyQRcehRJQlZSb5pMv+4Jf99Gccw/tN0vuFIon0tb5/h63m7daMfjKBiNmjyIa9
         v2VyB7Q8wk7Hikth3Vky93/HAncnA3vdU0st3pHZkyJbFHv5DklV0m1B6VrPqONTBWSl
         pkw9lVHE0TmihXFQtv2naJ8mbc6FW95lHaHQ3B+tU9Aoj2Y2Aadw7Bti4LhYqZ/USRKa
         5OXPQj67I+WVGpnX9rG3U+WME6TGhkhBaZQtt1xcI0lDplprQAAfXdvh9dyoVZUc56Fm
         36tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777003682; x=1777608482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :subject:date:cc:to:from:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ebTz24LbM5JUkJMnX0UTG9L5NdW7NGB2BYBIfLQKtDU=;
        b=plQR0YSMJpmppXSQOXROgCAWXeISyZf33v7WT1rQ3VNfFymJ/jZxWeNOmn09M9wMsT
         C4qjK9sz4jpTTr9slj1WW+SaoR1Njya712egS8Z0ikSXcGL73A9Rj+DB5FR78IiHZgeL
         X3qT+fcD2rq5O9u4sNxD4IaYveyYCX86tONyrcUgfTA2kOptrN/C/DnTrGzWiLGmg+2M
         CgXWGPs3FzZE+ul8rgCcALyh5u8ukfXN57mMvR0H5IyiIi+6xICPyb597anTBG3yLmT8
         ojmGvG7xCIXqGzi6nQGFr0MT7OwRZBTGx87s9N9r/zzoHcVfBq030u8p8gD8w6qIXqgH
         m3xg==
X-Forwarded-Encrypted: i=1; AFNElJ9XqKkbnnmD0rbOLdqr5phLMTKW5MNb5iSO94bjfEdZn1dhXaJ8+CKXebh9GUIEOLOBHLoVLB54O/jmd2o52A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxMI1dYplj2HZux6p+JrwIZNrbcJ6UCt39ztWUKIGCz3fItfkgw
	jJ1VCrrk7VNIiaDgKnAetIYDvpqnWMAiV6IpkJoCMWDfJn1N2m0lRoed
X-Gm-Gg: AeBDiesPnoVKRYFNnzhCV4WVyqZSl5ZpkHutQNm8EI+YTBXP2u4jXzo8QXF+JUd4o0P
	5iY+svlXi2mopuqMmunKayjKNkpRFlie05SHdxNNyJYbrNWxphxOHeKClzLIbx/JhifRvdd/nHQ
	glKvW8xs07uPLzLtNPKKXfIJk/zOe560NpSLbPay+ifiHZ+PrS+qM8fZMyZqZKshYcLeGcQNvEC
	eoirJvm0uxB3OKjE6aTy1B/z8y0Ik8VMyNc1ooUiCGvc9Cs11pyxm1nkTWkvM9Nc58/IBhHe4dh
	e8/n4M3Erw9dSGWoN20niKljD0FNBdInz58TE83aC6SQyT1v0AMYaJ5XZmTYHeoy8sjlS/9s/A4
	Ug6s2NMs/HAGZLJUZGOEkycElw9dN7Zs0i/p3iO/PH+kBW/WKSroVWD/VHIdjCdSE25b1eb7dDE
	XQIFWeAGx96Oou8B+11GQPVx3Ey/Bjm0r28i/U5wM=
X-Received: by 2002:a05:6a00:aa08:b0:82c:66f2:1226 with SMTP id d2e1a72fcca58-82f8c8e4febmr30231789b3a.38.1777003681389;
        Thu, 23 Apr 2026 21:08:01 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.126.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9d2f9asm23197324b3a.19.2026.04.23.21.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 21:08:00 -0700 (PDT)
Message-ID: <69eaeca0.050a0220.408e2.027b@mx.google.com>
From: JiaJia <physicalmtea@gmail.com>
To: Peter Hilber <peter.hilber@oss.qualcomm.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, physicalmtea@gmail.com
Date: Fri, 24 Apr 2026 11:14:53 +0800
Subject: [PATCH v2] virtio: rtc: tear down old virtqueues before restore
In-Reply-To: <iwb4axxcxti6bpgpde5cv3n7y46xaopvkbdd2kug3qhn2ehfim@ny45mixj7ncn>
References: <iwb4axxcxti6bpgpde5cv3n7y46xaopvkbdd2kug3qhn2ehfim@ny45mixj7ncn>
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
path can run vp_del_vqs() against a newly allocated vp_dev->vqs array
while vdev->vqs still contains the old virtqueues. vp_del_vqs() then
looks up queue state through the new array and can dereference a NULL
info pointer in vp_del_vq(), crashing the guest kernel during restore.

Delete the stale virtqueues before rebuilding them. If restore fails
before virtio_device_ready(), reuse the remove path to stop the device.
Once the device is ready, return errors directly instead of deleting the
virtqueues again.

Signed-off-by: JiaJia <physicalmtea@gmail.com>
---
Hi Peter,

thanks for taking a look and for pointing this out. I took another look
at the restore path and agree that deleting the virtqueues from that
error path can race with `viortc_cb_alarmq()` once the device has been
readied.

This v2 follows the direction you suggested. It factors out
`__viortc_remove()`, reuses that path for restore failures before
`virtio_device_ready()`, routes `viortc_init_vqs()` failures in probe
through `err_reset_vdev` for consistent teardown, drops the
`viortc_del_vqs()` helper and the `viortc_msg_xfer()` NULL-vq guard,
and avoids deleting the virtqueues again after `virtio_device_ready()`.

Thanks,
JiaJia

v2:
- reuse the remove path for restore failures before virtio_device_ready()
- route viortc_init_vqs() failures in probe through err_reset_vdev
- drop the viortc_del_vqs() helper and the viortc_msg_xfer() NULL-vq guard
- avoid deleting virtqueues again after virtio_device_ready()

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
