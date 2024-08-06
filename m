Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D66818622
	for <virtualization@lists.linux.dev>; Tue,  6 Aug 2024 02:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722910999; cv=none; b=oEYcMJOrg7PhL3uN9NdnKG79TcA+iWRcGFHtGckMx9VUAcs+9AZo3G1CKEO3VHcja7CgLnLIfClyBCTwp6B0rfx+Zjy9Ok7HxpPzwuHV/YhMGY+rSiwGNzPVWNMw2CK1T5tpEvWQdMsuNVIsnfO9h0OKxLgVpn/AiSrMsuTvXh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722910999; c=relaxed/simple;
	bh=nt3Et2YoligCcXL757duTBuKwOZ+AWh1f7tagjAAdZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gAEElmBU72rQ/8c2UbjZII4/nT3GDD50r8FpdoBXpgXf+yrmnon8M3+QF6zSvDPxU723wVtxkl9ZBKwwy40itxPiHnChobJ6WJRpGVOz3TqfEkU/hryyiVLe7eYE5Bf5oRpgssn7ZC7/I6fSbB8F8l1yGWdoxGMCgs4e6IdWqWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MYjQlSOl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MYjQlSOl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722910997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H7Hlfk//mTDGwteqWxFtsa9yMOC+g2V11rknPgi7O7k=;
	b=MYjQlSOlOIkoW7qCD4dCwakGFyoryczJd5d8jjMwqe25KQ1WAaS0QmXVG06ywfFDD3Nenr
	aY+Vo0Kbng33RCx2c+ckc02fepIzf4cSJPqgYfsetaBI+5Lje4NVChFi6iNoFzlGFrk/3+
	i/kZ7LCFdCU4J0TR2rqLhEys7LiqR9U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-bjX01LljNTCVapUOQjaptg-1; Mon,
 05 Aug 2024 22:23:13 -0400
X-MC-Unique: bjX01LljNTCVapUOQjaptg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 89E7F1955F77;
	Tue,  6 Aug 2024 02:23:11 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8380219560AE;
	Tue,  6 Aug 2024 02:23:04 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	inux-kernel@vger.kernel.org
Subject: [PATCH net-next V6 4/4] virtio-net: synchronize probe with ndo_set_features
Date: Tue,  6 Aug 2024 10:22:24 +0800
Message-ID: <20240806022224.71779-5-jasowang@redhat.com>
In-Reply-To: <20240806022224.71779-1-jasowang@redhat.com>
References: <20240806022224.71779-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

We calculate guest offloads during probe without the protection of
rtnl_lock. This lead to race between probe and ndo_set_features. Fix
this by moving the calculation under the rtnl_lock.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index fc5196ca8d51..1d86aa07c871 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6596,6 +6596,11 @@ static int virtnet_probe(struct virtio_device *vdev)
 		netif_carrier_on(dev);
 	}
 
+	for (i = 0; i < ARRAY_SIZE(guest_offloads); i++)
+		if (virtio_has_feature(vi->vdev, guest_offloads[i]))
+			set_bit(guest_offloads[i], &vi->guest_offloads);
+	vi->guest_offloads_capable = vi->guest_offloads;
+
 	rtnl_unlock();
 
 	err = virtnet_cpu_notif_add(vi);
@@ -6604,11 +6609,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 		goto free_unregister_netdev;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(guest_offloads); i++)
-		if (virtio_has_feature(vi->vdev, guest_offloads[i]))
-			set_bit(guest_offloads[i], &vi->guest_offloads);
-	vi->guest_offloads_capable = vi->guest_offloads;
-
 	pr_debug("virtnet: registered device %s with %d RX and TX vq's\n",
 		 dev->name, max_queue_pairs);
 
-- 
2.31.1

