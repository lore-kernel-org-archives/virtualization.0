Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0791730C179
	for <virtualization@lists.linux.dev>; Wed, 24 Jun 2026 14:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782310133; cv=none; b=MsUJojIODHx4cmd1RJTSmuZcFKRvoyG1WtYHEECmCrLmOhxLoLSlb0HK1l2vfVlT1yLhqqYdAGoJUujBQj1On/xyXm4pFs29GDJ0AezXAMCekk6SG+TA9Qzc2Jb/77b1lsSqrl22E4BIv6uqKAhkxaxpOcXQR/ualNBH182kzw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782310133; c=relaxed/simple;
	bh=H3AofhNEHYpKH3qKmHnFcIZHklOCB+JEV5BWAwMmlvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aU41zchm4aRROKT2SGdd2YlQyBdiUvqYU2uEny03GjAPO3tslDvUfug/XSnvHsnipGcnxe5geqPHcDdOqALW+hWJ/RVKZwSCAmCtVQeUvh4PfgPIbtknzgvixem4CXMwcijFvyLgTt5yxJ+b0E3gKsuM2o+BpBfC6Bx4hUhqur4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvz.org; spf=pass smtp.mailfrom=openvz.org; dkim=pass (2048-bit key) header.d=openvz.org header.i=@openvz.org header.b=FeCqZncN; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvz.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvz.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvz.org header.i=@openvz.org header.b="FeCqZncN"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49241a577d8so6887085e9.3
        for <virtualization@lists.linux.dev>; Wed, 24 Jun 2026 07:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz.org; s=google; t=1782310130; x=1782914930; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48Au7et5Z4YbTFT58xfMD2qmVHKMDdo11xhFKNzYy74=;
        b=FeCqZncNOsncrgHJLKYVjn9y+bv5o9By+EvHzPXiiv3tuBKR0APhiLIlqLpsrQBq+t
         FB4zRUAcCS5Y5WXIGiTRyvfa2B116enVE6CeIttImHGD1R/bU0KIShBpPCKH5QjkEFaq
         r4TqDAy/D9aeDTkBvdONUVzP6miAuR0Bh8JIJuFRk57iyXS80lU4nxXb/WM47Y9Dn03u
         LRFXEwDy6fFeuOA5MSoKxDz6V7ggwlm60sTU3QTWAqoeZVFD1aw1+ldX7F7WkopUEDIW
         lO6yQ4HxyWLHfylIw/EDG5xvt9uujQ8k89Y6+CoXo7L+Nho2FWSYtYuVGjwyE5Iu7r2B
         4+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782310130; x=1782914930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=48Au7et5Z4YbTFT58xfMD2qmVHKMDdo11xhFKNzYy74=;
        b=JiMFwIHTSsp5MqxHaMt33GG+o3xax7pWSjCdcE+hHuNk+LZ4yiwuPSMaXHzYYURnnV
         2XOPaD4nIUXGedQPlIoQDOFsLm5D/jbmywiIqSKXsZLoM21Rdpf09o7vqZvId/ihiIPI
         rW77VKd10+iXAZcjGiuXDtQrG2/tZ86oUW7ipzjgVIokcgPnBe4zzVXRtk4UsG5ggQtw
         Nq6PGkDtufYQL1BENtLqOuYOpgU6Sd8WlAAUlakghqmpr3BEMEOlEwwdC+kGg2UHx6E6
         vlpIqOgYQmLhH3sMqZPoX5WoAxTcA42qJDIfbsNfngX9Yesfh5dpdb0ojCBM8xvDKKtG
         4DlQ==
X-Gm-Message-State: AOJu0Yx1X3n77pjZ/oqGS8BXKOhzAYVAI8FebFsid8MmXb9jjFRQ0vXz
	tBYUcz1pDFmY+WQVDSmBNi0a9dJemL9UcHwWNOGqWhHvpT6M5XwjZ3CvNYv8luwI+Mg=
X-Gm-Gg: AfdE7cnKAWpwokQ6UT0Gq0L3z0uc/RYSW37KqvZpg94ZUI40S7DlEysdweGkXP36uuY
	Cwso23qEjOYdks6DR6yx3W7/28mBVDU3+F0Nf7ruPGJtu4T1QmufDAUXSTILk20k5aKWEfgJieU
	HQ2sap8Y0DX/i/V3gUWQfgeEG3luUxRYF5JepAcbX6+zr7xFlSoYkf0PMo3qMEaj7/6fD2jFyeZ
	xK13zzCP9QNWs8gMQpOC/EmoBWm0qaEiFzjWNSh7B4K5RX4fgPbyPxI+W19aEEZnrdd71udhKZ2
	gZ+ijcoyFBz5I6DVJkDZQRNaPXBlw+cAdMeWfHVV7P8ADGMF72kLWIHg4PnhDXsASlfEywcI7eW
	cpgWYaexKlfHtAWphaoPnNmVUo674gEeJ8dnIcGXMzqFlpf/O5wRo3pna0//Isb7m6L51kQ==
X-Received: by 2002:a05:600d:8495:10b0:490:c032:ae92 with SMTP id 5b1f17b1804b1-4926087f7edmr37928655e9.33.1782310130503;
        Wed, 24 Jun 2026 07:08:50 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:306c:c2d:85d5:28d5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd1fa34sm519680275e9.5.2026.06.24.07.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 07:08:50 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: mst@redhat.com,
	david@kernel.org
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Denis V. Lunev" <den@openvz.org>
Subject: [PATCH v2 1/4] virtio: add virtio_device_shutdown() helper
Date: Wed, 24 Jun 2026 16:08:43 +0200
Message-ID: <20260624140846.2616797-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624140846.2616797-1-den@openvz.org>
References: <20260624140846.2616797-1-den@openvz.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The generic virtio bus .shutdown handler, virtio_dev_shutdown(), breaks
and resets a device once it has established that the driver has no
.shutdown of its own. A driver that does implement .shutdown, to quiesce
its own activity first, still needs the same break and reset afterwards
and would otherwise have to open code it.

Factor the break + synchronize_cbs + reset sequence out of
virtio_dev_shutdown() into an exported virtio_device_shutdown() helper so
such drivers can reuse it instead of duplicating the core logic.

No functional change.

Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 drivers/virtio/virtio.c | 41 +++++++++++++++++++++++++++--------------
 include/linux/virtio.h  |  1 +
 2 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 299fa83be1d5..75bb4ffe3b87 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -401,6 +401,32 @@ static const struct cpumask *virtio_irq_get_affinity(struct device *_d,
 	return dev->config->get_vq_affinity(dev, irq_vec);
 }
 
+/**
+ * virtio_device_shutdown - break and reset a device on shutdown
+ * @dev: the device
+ *
+ * Drivers with their own .shutdown method should quiesce their activity and
+ * then call this to stop the device the way the generic shutdown path does.
+ */
+void virtio_device_shutdown(struct virtio_device *dev)
+{
+	/*
+	 * Some devices get wedged if you kick them after they are
+	 * reset. Mark all vqs as broken to make sure we don't.
+	 */
+	virtio_break_device(dev);
+	/*
+	 * Guarantee that any callback will see vq->broken as true.
+	 */
+	virtio_synchronize_cbs(dev);
+	/*
+	 * As IOMMUs are reset on shutdown, this will block device access to memory.
+	 * Some devices get wedged if this happens, so reset to make sure it does not.
+	 */
+	dev->config->reset(dev);
+}
+EXPORT_SYMBOL_GPL(virtio_device_shutdown);
+
 static void virtio_dev_shutdown(struct device *_d)
 {
 	struct virtio_device *dev = dev_to_virtio(_d);
@@ -419,20 +445,7 @@ static void virtio_dev_shutdown(struct device *_d)
 		return;
 	}
 
-	/*
-	 * Some devices get wedged if you kick them after they are
-	 * reset. Mark all vqs as broken to make sure we don't.
-	 */
-	virtio_break_device(dev);
-	/*
-	 * Guarantee that any callback will see vq->broken as true.
-	 */
-	virtio_synchronize_cbs(dev);
-	/*
-	 * As IOMMUs are reset on shutdown, this will block device access to memory.
-	 * Some devices get wedged if this happens, so reset to make sure it does not.
-	 */
-	dev->config->reset(dev);
+	virtio_device_shutdown(dev);
 }
 
 static int virtio_dev_num_vf(struct device *dev)
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index bf089e51970e..66184828fdd0 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -213,6 +213,7 @@ int virtio_device_freeze(struct virtio_device *dev);
 int virtio_device_restore(struct virtio_device *dev);
 #endif
 void virtio_reset_device(struct virtio_device *dev);
+void virtio_device_shutdown(struct virtio_device *dev);
 int virtio_device_reset_prepare(struct virtio_device *dev);
 int virtio_device_reset_done(struct virtio_device *dev);
 
-- 
2.53.0

