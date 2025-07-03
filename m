Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2C62D9494
	for <virtualization@lists.linux.dev>; Thu,  3 Jul 2025 09:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751534805; cv=none; b=lsVseoL31OeNz+oxFQAl83MwknmPGZLD+XZETE1aJhKLOAA8q5q80VMEJeCKPetFFCFTxvjou4JkCbrqeQZwBHkprJug/weSGqQ+QO2Z0TNNzV7Unv3uXDz9SxIPp87ynEHbItbnuhDtHJ7lz1TP9UXZ5omjVzIJW3svtVbdUic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751534805; c=relaxed/simple;
	bh=ixhuBTYfea3ddE2iz9G1mIy9dwkewDEfDsZY+6NW2nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=oV4jaRBqdKZBhojqIhZyoZMz2RQDMgrz4FHNousNvSuM3nnOgiBFKVYhQ9SxLe73sF/Yhx263jAvcx3bxLEMrE0DCGgo4PyliriOcs6EHYfz5p7Y7NfEiwQCNE0Qo2EHTK3o0iOytPYDihlziKSBkdteRYdVseKciiIk5r1X/ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ha0AlvPb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ha0AlvPb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751534803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iyE61h0zJVl0tJYFuJIzKM7tu1ObimreBAr/5qShF90=;
	b=Ha0AlvPb7diGklof+0qACI2rB4CYX0KYpemKdYaVzB89LKTkPDdSASwKFti04o34UC8TaI
	d7n7fHfqNAob2MLNUbtGxWesPRfrr8PPKGUfNax4npliGoou0n3o69NxrHBzcxl+jrHkd+
	AwdldtZbGcbKmnhXKlyE8fjT27GbZbI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-vxR3YRu4Pyy_T8GJBkbmUg-1; Thu, 03 Jul 2025 05:26:39 -0400
X-MC-Unique: vxR3YRu4Pyy_T8GJBkbmUg-1
X-Mimecast-MFC-AGG-ID: vxR3YRu4Pyy_T8GJBkbmUg_1751534798
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-450df53d461so43803125e9.1
        for <virtualization@lists.linux.dev>; Thu, 03 Jul 2025 02:26:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751534798; x=1752139598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iyE61h0zJVl0tJYFuJIzKM7tu1ObimreBAr/5qShF90=;
        b=Sb6otYa2+suNFYVmIhs0ngOXSmRuAo/M/ST9Zcow+8mj3itsCqdCWOKC7bii5/yLz4
         11Nbm9wS7oVUbO7PHYXHTftPMyN6DyR/UR46UDNmvdat9X7ePjl+QaRKycObaxCU/dk6
         8VHAvCEMY8aqgP/ZeTj3lb45o71adyXFpsLrCbIV8hSxKToFusc2G7goPCew2Am1b8C0
         DognZ+GD1I8+2GfGkTXh2NFNu74JfxOPwmqKnV+tzmH2RMp/rIIw82iBxL06zKeARJbZ
         ujn/+lCHpW7YLRxkbvcgBjyzveHkdLBzem8YPt44sjx8X+3sJLo6Zn6fRNZy1aJ/N3Sh
         K7Mw==
X-Forwarded-Encrypted: i=1; AJvYcCWtjDUnXVvTudkezyzXPknp90tfWFvqsopxoADV9tq5Yjlk3p06fWgQPS5nBwTFE8txaM8xR+61GH3U2ZZa6w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJSRYxvlWxFNQgHxtQtUnWLRrHHf2RSW2tGzlX45ceca1vSVID
	Am+8bbZ4ROXAWiyFwbYk+CW6W4XDdAQyl9/y6CXAqN4E/1YVkWI26O4gnVCG15dUM314kiczk1e
	UsoPd7+RutrziFJVy1qQdNQMHkQQc5IkjlE2t/Er28MTNCYfVFpvcBQwP2pZVPn4OXq/w
X-Gm-Gg: ASbGncuuk+P6Fadr1Lh3rSKvH7bobRBuxLexMhENRFoXS5CG6BgUBQraN4X+J5mNsNu
	G6hOVtBimrnu2pftf2EKPAugGMydTyJidLH/PlEaSM1mjrzG16MPZM/OCtx+PMfxRFsZ57FJ1XV
	G5fsyFqQJnJENR1Ji601m4M+rwnp88ZYMyoxCTuhGTBwIyjQ1/beazLrieZMQPKilQU5joY/e3T
	WfziIQzZZ3ZdC5+Xyj1faNLzutA7ZdL29TP+/W96JETE41KdHBUlpR4q0WNfeVaRNfsL8M5gBQa
	glITw5IYCaEkzm1b
X-Received: by 2002:a05:600c:8883:b0:454:ab1a:8c39 with SMTP id 5b1f17b1804b1-454ab1a8f9cmr14500905e9.26.1751534798020;
        Thu, 03 Jul 2025 02:26:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGULZivx6PdRE/Oj0oek5elGryB9j+UIWwEzss/nUl15lX5SquQnoBTrb+1G3/c7vEVKSP2+Q==
X-Received: by 2002:a05:600c:8883:b0:454:ab1a:8c39 with SMTP id 5b1f17b1804b1-454ab1a8f9cmr14500675e9.26.1751534797611;
        Thu, 03 Jul 2025 02:26:37 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152e:1400:856d:9957:3ec3:1ddc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a99a35f9sm21176835e9.27.2025.07.03.02.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 02:26:37 -0700 (PDT)
Date: Thu, 3 Jul 2025 05:26:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PATCH RFC v4 4/5] virtio: allow transports to suppress config change
Message-ID: <57feb6b4c9969e153c70dfaa8ec86a304dfee490.1751534711.git.mst@redhat.com>
References: <cover.1751534711.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1751534711.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0k_93vztHVCGP_h5p3Xwwonhm3xF6U3H-WmRKbsELp4_1751534798
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Will be used on surprise removal, so we don't need to
re-check.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio.c | 18 +++++++++++++++++-
 include/linux/virtio.h  |  2 ++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index c441c8cc71ef..1dd5cdf68c1d 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -127,7 +127,8 @@ static void __virtio_config_changed(struct virtio_device *dev)
 {
 	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
 
-	if (!dev->config_core_enabled || dev->config_driver_disabled)
+	if (!dev->config_core_enabled || dev->config_driver_disabled ||
+	    dev->config_transport_disabled)
 		dev->config_change_pending = true;
 	else if (drv && drv->config_changed) {
 		drv->config_changed(dev);
@@ -193,6 +194,20 @@ static void virtio_config_core_enable(struct virtio_device *dev)
 	spin_unlock_irq(&dev->config_lock);
 }
 
+/**
+ * virtio_config_transport_disable - disable config change reporting by transport
+ * @dev: the device in question
+ *
+ * This must only be called by transport and enabling is not allowed.
+ */
+void virtio_config_transport_disable(struct virtio_device *dev)
+{
+	spin_lock_irq(&dev->config_lock);
+	dev->config_transport_disabled = true;
+	spin_unlock_irq(&dev->config_lock);
+}
+EXPORT_SYMBOL_GPL(virtio_config_transport_disable);
+
 void virtio_add_status(struct virtio_device *dev, unsigned int status)
 {
 	might_sleep();
@@ -530,6 +545,7 @@ int register_virtio_device(struct virtio_device *dev)
 		goto out_ida_remove;
 
 	spin_lock_init(&dev->config_lock);
+	dev->config_transport_disabled = false;
 	dev->config_driver_disabled = false;
 	dev->config_core_enabled = false;
 	dev->config_change_pending = false;
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index be0beb16b487..072a25f6622c 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -151,6 +151,7 @@ struct virtio_device {
 	bool failed;
 	u8 config_core_enabled:1;
 	u8 config_driver_disabled:1;
+	u8 config_transport_disabled:1;
 	u8 config_change_pending:1;
 	spinlock_t config_lock;
 	spinlock_t vqs_list_lock;
@@ -185,6 +186,7 @@ void virtio_config_changed(struct virtio_device *dev);
 void virtio_config_driver_disable(struct virtio_device *dev);
 void virtio_config_driver_enable(struct virtio_device *dev);
 
+void virtio_config_transport_disable(struct virtio_device *dev);
 #ifdef CONFIG_PM_SLEEP
 int virtio_device_freeze(struct virtio_device *dev);
 int virtio_device_restore(struct virtio_device *dev);
-- 
MST

