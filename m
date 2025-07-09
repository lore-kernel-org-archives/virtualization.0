Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AF524888C
	for <virtualization@lists.linux.dev>; Wed,  9 Jul 2025 20:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752094542; cv=none; b=t10c/DSyqLy4TUqqMvuMMnu1UJlL+E1Uffa5RJNdSJraBFhcB89kxgzvrbQ2YwZK8YkH0BKpI+fUxIwEH/hj3hTtM8VyJEySSnIHpVvWPri29bfHFdk2f6NQkVja6K+OrG0LMxInAt01zUxrPkWVnyU3GZJqBibCrlFHWYIVYlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752094542; c=relaxed/simple;
	bh=ixhuBTYfea3ddE2iz9G1mIy9dwkewDEfDsZY+6NW2nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=WceIZPYy3Ahnm1FHxSNOnhBZbffYGxz+lk3qqCUNIjc4oSCiLqSzLTGKoWH4kHfpU2sZ6H7Tx0kigLWudq4awLN1zSah433u3NQc4bnLx7H1qgb5plFjA3VBXlI2FrRX0A8pALc2gZCp57LlZ2O06D6C85d1+J1vvSMgicr4C5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DrUyWbEL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DrUyWbEL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752094539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iyE61h0zJVl0tJYFuJIzKM7tu1ObimreBAr/5qShF90=;
	b=DrUyWbEL09MUMij4dX6mBm0RbjXqMTBoAO2jcjXVB0BCfE99EG29ikbIKJ/nGqJZv0cKV+
	lUKDQsv4Z10bSXnrO6jskp2Ge0oL4mTyFb8rhiNCnSbaqO3I1tav9g317KQDdF67hbmrvy
	OfvcxY7rVa9dSjvzpV6KmxT5rN+ByBM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-F6LIaHdaPVyziOImZS9HoQ-1; Wed, 09 Jul 2025 16:55:37 -0400
X-MC-Unique: F6LIaHdaPVyziOImZS9HoQ-1
X-Mimecast-MFC-AGG-ID: F6LIaHdaPVyziOImZS9HoQ_1752094537
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b39cc43f15so165521f8f.2
        for <virtualization@lists.linux.dev>; Wed, 09 Jul 2025 13:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752094536; x=1752699336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iyE61h0zJVl0tJYFuJIzKM7tu1ObimreBAr/5qShF90=;
        b=SnRePNbamZtWZ4qmu7751ZYPslMZG6m+UF8dFspHSOjvFF01f0UOO5FdoVgXSgNxTc
         s/fD70qVEL5y5CAx33BKtxiH4ivNCZRnrSbqLfgxpu13XevPBC/d8vJ7NMmPysqOTcLh
         KFXr25a3Wl/WB+yIWcPLRmjMQM8ESsuec379bOnhoJdRHVPEOOOVjqQG19kbksVPt5WJ
         RRzH/ZZSn18/hdH0AU35wr343awwqXHELdWQvGiTkTfjAoYKowE2QKVNd1QepUjMfDLO
         NKlsfr4AMbQGMtN2EvnW44/MUvK4068HmlxC+p2KBhlv1og77KCjbSDhgl3Z4YGdpOpa
         ySmw==
X-Forwarded-Encrypted: i=1; AJvYcCVlasZQNteysdu7XvKBSn7fWdWioYxdwC53Giw3z+d42dyXCOKkEIPZ4FF6Zv0HsgrMEX68AymZSXJkWPWBHQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyraNlF9PE53xYOG18t5ERuHdXzoRigbzJ3LqnPZDzrAb95sxeE
	fF0YUKVMCpN58eII8ie5ivB6lNFQNtESv84lG+A/AbEyR62vr7f4urtrVzk6cOb1K9wG4t08cYl
	zqg/bTFLh3urXkMMS5Y3PPqwzDGoKmNFVSpKPCv+1iL8Niv3kVnuHspUWdyP4vnb714fm6a1dKk
	4a
X-Gm-Gg: ASbGncsSqBlSTQoCCR0XYaHiZRnx8gGTidL4rhKtfOsWxdtW9fjyaL/5jnPZDBsDqVI
	2lKUpcwjTA+0qkqOw3qqq/+Z3vewXWT5WsU+/e6T0m4or7z9tckxdblLQU16m+tNRGLiKOWPDzq
	zl3uxk+2UFu+QIP/flKXv3LWBtvCjNmNiXS5tYge2VlzgizCJMvsF+aFKQdNxdOpLa3bxJ4IjD+
	CSMmWhmc08SPFAYL+jBTQxsKc3zhn4io/1HqAftuxSQXryoOwbmrSPuahZjHIRfb7elUqQijpZg
	azY5QJJ12rcBb40=
X-Received: by 2002:a05:6000:40d9:b0:3b2:fe84:a10 with SMTP id ffacd0b85a97d-3b5e7650d66mr1214801f8f.0.1752094536402;
        Wed, 09 Jul 2025 13:55:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpsMPu7CU6gE5ErnQ6ZCj2ysNbEZlkEPok6bMsjf7y8BkX7URX96NcV6dlU7ULjAJLQlSWtg==
X-Received: by 2002:a05:6000:40d9:b0:3b2:fe84:a10 with SMTP id ffacd0b85a97d-3b5e7650d66mr1214783f8f.0.1752094535966;
        Wed, 09 Jul 2025 13:55:35 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030bd90sm17238302f8f.15.2025.07.09.13.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 13:55:35 -0700 (PDT)
Date: Wed, 9 Jul 2025 16:55:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PATCH RFC v5 4/5] virtio: allow transports to suppress config change
Message-ID: <bd9a6c26e03cafdc41a678c6eb12c0e91b7d0e69.1752094439.git.mst@redhat.com>
References: <cover.1752094439.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1752094439.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: j7jZX6cUb8MyOJROYS7h_SDG5f8iCaEqzzwW36BY5kE_1752094537
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

