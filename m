Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB2D107A0
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jul 2024 01:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721610413; cv=none; b=l32FKvGLEGP3FRkWSULBg1chJnQzVkUkpcMf6cXVWhxPSCK9iKk2TW1j/MpkWBrKc9MgrPfcLBLlaL/3J7EUvade4k5H82VFuNBBPA1SphJP2JuxxMrpwE5vJXHwSUJRmBXoAXkJRBS+vi3WSfbwJf+q7pzCt9g+Wqbi3zV9Qgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721610413; c=relaxed/simple;
	bh=YlgBd52tDp0ELLAhudJbHc5ZsTK4ruEZDV/AMZxlW9I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kt89/TuZy39wUK+OPL3C7RpgVE6C202zlpWvdyo9HW2Mir3MSgUMDy4Kjug9YOd7QT3kaaGDgtfZqQGPJrKY2GkXnwcTSnyTD0w/1GrY0WtK2N20fTCeg1LW7qo8+wEjlEYLb3fnCzYLieUROqNjI0HDHR/dDOtoCgXXwH3gjT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TIPlJRc4; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TIPlJRc4"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E41481089
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jul 2024 01:06:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T9DLBoSEdohq for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Jul 2024 01:06:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6F83180D80
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6F83180D80
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TIPlJRc4
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6F83180D80
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jul 2024 01:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721610410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=slQyrjhTwLXhRJi7KIDsmKXTj3WUm9y9lo/YxO259so=;
	b=TIPlJRc40liDhAHwP9/2HeDEVoJxyZ3qFyfb0l1VnEXGhbUY4a7r8weV5UXIeQjiSePThP
	xA3TXdp5bqS3gJTXLWZPrQ3WKbTwRwSQbODyluDo6wGRonkue8Banvi49I3C9shcL3VAoy
	ORcUw/pJeK0qO4ptRvXvGTcCUZaWaec=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-AQjAT5RnP2ehu83NVECDNw-1; Sun,
 21 Jul 2024 21:06:48 -0400
X-MC-Unique: AQjAT5RnP2ehu83NVECDNw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2CC1F19560AA;
	Mon, 22 Jul 2024 01:06:47 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.22])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0F697195605A;
	Mon, 22 Jul 2024 01:06:41 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	dtatulea@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	parav@nvidia.com,
	sgarzare@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATH v4 2/3] vdpa_sim_net: Add the support of set mac address
Date: Mon, 22 Jul 2024 09:05:19 +0800
Message-ID: <20240722010625.1016854-3-lulu@redhat.com>
In-Reply-To: <20240722010625.1016854-1-lulu@redhat.com>
References: <20240722010625.1016854-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Add the function to support setting the MAC address.
For vdpa_sim_net, the driver will write the MAC address
to the config space, and other devices can implement
their own functions to support this.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index cfe962911804..936e33e5021a 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -414,6 +414,25 @@ static void vdpasim_net_get_config(struct vdpasim *vdpasim, void *config)
 	net_config->status = cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_LINK_UP);
 }
 
+static int vdpasim_net_set_attr(struct vdpa_mgmt_dev *mdev,
+				struct vdpa_device *dev,
+				const struct vdpa_dev_set_config *config)
+{
+	struct vdpasim *vdpasim = container_of(dev, struct vdpasim, vdpa);
+	struct virtio_net_config *vio_config = vdpasim->config;
+
+	mutex_lock(&vdpasim->mutex);
+
+	if (config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
+		memcpy(vio_config->mac, config->net.mac, ETH_ALEN);
+		mutex_unlock(&vdpasim->mutex);
+		return 0;
+	}
+
+	mutex_unlock(&vdpasim->mutex);
+	return -EINVAL;
+}
+
 static void vdpasim_net_setup_config(struct vdpasim *vdpasim,
 				     const struct vdpa_dev_set_config *config)
 {
@@ -510,7 +529,8 @@ static void vdpasim_net_dev_del(struct vdpa_mgmt_dev *mdev,
 
 static const struct vdpa_mgmtdev_ops vdpasim_net_mgmtdev_ops = {
 	.dev_add = vdpasim_net_dev_add,
-	.dev_del = vdpasim_net_dev_del
+	.dev_del = vdpasim_net_dev_del,
+	.dev_set_attr = vdpasim_net_set_attr
 };
 
 static struct virtio_device_id id_table[] = {
-- 
2.45.0

