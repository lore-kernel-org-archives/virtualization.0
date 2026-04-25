Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B603038838A
	for <virtualization@lists.linux.dev>; Sat, 25 Apr 2026 07:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777100965; cv=none; b=YfG1H19cSp8D/aS4AB1HOLbpLyjNHqiqyjzfN/KHrG6XL4a91auOV0D8V3hby+6Hk9QwAALoNJuzP1qhSO1ZxCBEAMNceDd9Q5s2eOjUKmAlxYZleRAEexHo/ot3ZEkrbwPg5UnWdZph7Ff0gKBHGmyiedqcmBtYa5rCZ12y9sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777100965; c=relaxed/simple;
	bh=cXVnybCCIkpFfhCV7Pv9o+XLIu3aQHhlNZ/DsOTWcmY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PcrXKPvyFYHam4X0IhkezHc4GVNl7fdsjWNaKTNmWsHHRk0msnC8PW626d0L+mDAzVKJlMjFFTpUMN1FZtlAvoTyQvqwfufSdD97NJ37Keo1GzzYvJzT9JA1QRrMm1rRIAb/tjU9DRFfP7xkIjVU0Elci0nL+Be2ql6V4PAE4Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5YfVIVl; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5YfVIVl"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82ce2e2880cso5822160b3a.0
        for <virtualization@lists.linux.dev>; Sat, 25 Apr 2026 00:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777100958; x=1777705758; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5C0AEzedHj5XKUPA0aaKf/p0DN4DYxSicdzohR/x6tU=;
        b=Z5YfVIVlMzmwZwDOWUBv4OIm1tpBN/3NmEaY2AyHUzT6YPUrfaIm2qFge1qjpy6CVE
         R83uz9Kxd4GLxAiM/7DIEEkNSyqBccL+IViqx2xUrsbkU+euVKnMbz0yJo+OTur/P8LK
         l6ED1dTM3H2vr9KElLyVsVFFg0AaUyptE5dLCCqcVyg1oHJFyJB5BW5VapyTNtjy6wf+
         L0r+/yW0e3dMQf5aJYNAGGSzJAFuVq1tXZYjfO/bMI0XOOm2RyqGyA8+yaJjJ/Jv8XiE
         3KeAshedBob0qvPxky/2SH17RpSnnMnRrlxcM0o7m6O3RFiEd+sWR2n/3iDI3ccGUUq8
         lGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777100958; x=1777705758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5C0AEzedHj5XKUPA0aaKf/p0DN4DYxSicdzohR/x6tU=;
        b=sBFQD4Vn6FXh+OlWnk90s1mWN+TBDbmJvwomXIjMekLDMQUyWeYP5Gutb7fh96U6Fm
         3TuLr9pWsaFJ6pqi5mfds+ojgxJLpQEEY3wT9M3nVvQie/VKm46/qtSmiZJjvaq7qKDV
         SrfBXPBBtWqJ2ixrgtwf6yYFbHf+SRdxvOqEmzUbqU3jYM3GDBLiRzNPvasueh3A8n4a
         OoaZHVdDPRAe9PKGm9WMEzu9CbbO0mc9zeCqvrOU7lLbarAhjkklLucQ3ASHCR7lB5JN
         H2nQPSIYXeemvcDLIBaahNGo8EbwuRE0u6w50492j14XRbQRVUvVqEIlPQcOE6p8IqbZ
         aFyQ==
X-Forwarded-Encrypted: i=1; AFNElJ8MerTCpvJVZuccQ/u0XgFRHGqwzHIZXM/WvduAJBnMGuEhLeSsk2uw48d5aVdUOdnV8GwL/qYmhj3jdFog5A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw0Cto2KeTuak/NUJ4HjFfbNIyb8v9c2iwIzmIvmGorbQ7CkkgZ
	324+q9/39/Bz4nmQU3xkMymm8airuJOCyLl2L/0Vjsa9B2cLUNomIRen
X-Gm-Gg: AeBDietRL67z9zOq34cORcTZefDE2NIJ2Gw9zrOShCE6S5NnpMWHM2zDoKBBtGiyY8q
	h6gOCa8zd2LL4TCAqHu2rG7ZuRZNtH+KgREsAJ2rEJC7x6s6CggaAPxx5A+LDhmQC1KftDQVa/X
	bbU7b/+c0Ek+KNlITkk9ED8tBYD2nsTEXh6Qp6H1T2cScKadcOMSpPFw/PZ5IiHKUfJTMv/IzMY
	QvDq+Kmg6Jo8dmAHPhSDrqSyU4nYdST9J/mpRYk0jynNqKv4lskksr7hznomdKXtZMYifuZiBwA
	ZPvj9fZDQN4iwkZXS3dUHOMQxw8HImjTUkUhHEvDb30oCR7urt1qIElNYHwc3XG6HIb2Skqb63m
	czbTC5y9eiVoTB4vpDRA1a1FWp67nHlq9nUJjJZOeEDPu9uAPWsp3MNjrH1xulNDk5jS3jbJlQM
	9uXdxdUxmNeyowjHaU68EhLdaX7Dw6IH9cOp5Uc+yT
X-Received: by 2002:aa7:88cf:0:b0:82a:17b6:53ca with SMTP id d2e1a72fcca58-82f8c92e436mr36926514b3a.38.1777100957728;
        Sat, 25 Apr 2026 00:09:17 -0700 (PDT)
Received: from jia.. ([114.249.134.218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ec24850sm26611107b3a.60.2026.04.25.00.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 00:09:17 -0700 (PDT)
From: physicalmtea <physicalmtea@gmail.com>
To: Peter Hilber <peter.hilber@oss.qualcomm.com>
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	JiaJia <physicalmtea@gmail.com>
Subject: [PATCH v3] virtio: rtc: tear down old virtqueues before restore
Date: Sat, 25 Apr 2026 15:08:40 +0800
Message-Id: <20260425070840.488634-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <d2gtdzjz3bfs47rmeslo46dkwmjqpv2qjcxmpgbkcbxjrqbf6m@bkeeynnavvy3>
References: <d2gtdzjz3bfs47rmeslo46dkwmjqpv2qjcxmpgbkcbxjrqbf6m@bkeeynnavvy3>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: JiaJia <physicalmtea@gmail.com>

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
Signed-off-by: JiaJia <physicalmtea@gmail.com>
Reviewed-by: Peter Hilber <peter.hilber@oss.qualcomm.com>
---
v3:
  - Add Fixes tag.
  - Add Peter's Reviewed-by tag.
  - Clarify commit message regarding reinitialization scenarios.

Apologies for missing the Fixes tag, and thanks for catching that! 
I've also updated the commit message to include the scenario you 
mentioned.

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

