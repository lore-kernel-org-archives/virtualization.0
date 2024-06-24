Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BD24C96
	for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 02:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719197150; cv=none; b=AlaMF+8LBWAfn/3iuVBOrIZpH7yOTo6j2X1peJ07mVUHDp3gYzC/wDMbX4/nt5n0HecpqB8/2X1hL3/aHmggYdtfxVGrxHIwu8zN1Nw+83dsKasdMGF73KD7EBnXw7c8k8rs1lO1+hUChkGlpUZMxdD3XTHlrQGoZ/0G+sBLodc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719197150; c=relaxed/simple;
	bh=WfeIGdPCABX8Ekz9dFEQWp6GcPg872qaZOhjgmpzO+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gXP7fW5ellDOHAgWrcylZ3Q5stPWhI4LfDHSNK9EGBa+DNicIFqSJeQurJVLT5ssnPDdZCXdXI3CPKueSSxXaDBe0XoIZV2iArRj3TG+eYl4Et1h/moXtq1C2Z05SS+fZA892xWG9+F6WRE/FB+CTsgJLK70ribeAXwaGKlCqEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P2hch6Na; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P2hch6Na"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719197148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BDxzijJpYtAgNTVGRnv3Y++7d/17cWXmWRlDF3N15Ms=;
	b=P2hch6NaRq15HZPz6irFuHYz2NP9S0VAysPrOWd8+aw/mOarORLnsdEFxV3kmXWHwA+JEo
	g8Lyz6hhxgBK0RkqudWIPj+ZTLaodN2xjdAZztkuE0yPmlgZ8we+ouUCxMjnkokPd4siHg
	ZEzcuc+BHsDKX5DxSMA8KNDiKSMW/rM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-f4qeZlybPK25jEVqZkh3gw-1; Sun,
 23 Jun 2024 22:45:44 -0400
X-MC-Unique: f4qeZlybPK25jEVqZkh3gw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D479C195608E;
	Mon, 24 Jun 2024 02:45:42 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.150])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3A98B3000218;
	Mon, 24 Jun 2024 02:45:35 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	venkat.x.venkatsubra@oracle.com,
	gia-khanh.nguyen@oracle.com
Subject: [PATCH V2 1/3] virtio: allow nested disabling of the configure interrupt
Date: Mon, 24 Jun 2024 10:45:21 +0800
Message-ID: <20240624024523.34272-2-jasowang@redhat.com>
In-Reply-To: <20240624024523.34272-1-jasowang@redhat.com>
References: <20240624024523.34272-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Somtime driver may want to enable or disable the config callback. This
requires a synchronization with the core. So this patch change the
config_enabled to be a integer counter. This allows the toggling of
the config_enable to be synchronized between the virtio core and the
virtio driver.

The counter is not allowed to be increased greater than one, this
simplifies the logic where the interrupt could be disabled immediately
without extra synchronization between driver and core.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio.c | 20 +++++++++++++-------
 include/linux/virtio.h  |  2 +-
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index b968b2aa5f4d..d3aa74b8ae5d 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -127,7 +127,7 @@ static void __virtio_config_changed(struct virtio_device *dev)
 {
 	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
 
-	if (!dev->config_enabled)
+	if (dev->config_enabled < 1)
 		dev->config_change_pending = true;
 	else if (drv && drv->config_changed)
 		drv->config_changed(dev);
@@ -146,17 +146,23 @@ EXPORT_SYMBOL_GPL(virtio_config_changed);
 static void virtio_config_disable(struct virtio_device *dev)
 {
 	spin_lock_irq(&dev->config_lock);
-	dev->config_enabled = false;
+	--dev->config_enabled;
 	spin_unlock_irq(&dev->config_lock);
 }
 
 static void virtio_config_enable(struct virtio_device *dev)
 {
 	spin_lock_irq(&dev->config_lock);
-	dev->config_enabled = true;
-	if (dev->config_change_pending)
-		__virtio_config_changed(dev);
-	dev->config_change_pending = false;
+
+	if (dev->config_enabled < 1) {
+		++dev->config_enabled;
+		if (dev->config_enabled == 1 &&
+		    dev->config_change_pending) {
+			__virtio_config_changed(dev);
+			dev->config_change_pending = false;
+		}
+	}
+
 	spin_unlock_irq(&dev->config_lock);
 }
 
@@ -455,7 +461,7 @@ int register_virtio_device(struct virtio_device *dev)
 		goto out_ida_remove;
 
 	spin_lock_init(&dev->config_lock);
-	dev->config_enabled = false;
+	dev->config_enabled = 0;
 	dev->config_change_pending = false;
 
 	INIT_LIST_HEAD(&dev->vqs);
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 96fea920873b..4496f9ba5d82 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -132,7 +132,7 @@ struct virtio_admin_cmd {
 struct virtio_device {
 	int index;
 	bool failed;
-	bool config_enabled;
+	int config_enabled;
 	bool config_change_pending;
 	spinlock_t config_lock;
 	spinlock_t vqs_list_lock;
-- 
2.31.1

