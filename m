Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8741E28EC
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jul 2024 01:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721871164; cv=none; b=NSBn63FWadZRhDthzdLOm9b3GSlRYkpOGUyOkdT+3Z/JIFyzgKGMZGJGaz0i/Vx6JO08UdDVkeD0I3QiUgAljTuHiEXZkEhnoZoz+qni2DLCLnNaV/+B52s1DAfVFD2d9dpdi9xfMLtEQoTIaHzbuNmRiMCcE+4MMH10t/DJNZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721871164; c=relaxed/simple;
	bh=B6kntrV50yntikWKwzd0CtyYI/Y0SyA0TsudD3v/2IE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ece010tcr/TdKiIJOvar9OEqwLhrIWs98NyRO3wsbJ3P79T2kUB4b9MIlWUWTAaSzEKvK7tqWtAAqN5O2DM6xiYDUX0Qji7B+2JZ4f6DOmosjf1k+GJXQcJp/5Ba8CDTw6xKCJEN+iCUEy0LJNJo7f0aJtIOZ4T1TDKk10WZHcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LTVY5U2B; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LTVY5U2B"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D7A0819D5
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jul 2024 01:32:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KXxpJpRoNqyy for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Jul 2024 01:32:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4F71B819D2
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4F71B819D2
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LTVY5U2B
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4F71B819D2
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jul 2024 01:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721871160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+201+GOsBBZJHHPN4LmlnkaPcB8che0dgv5rCxUZjcs=;
	b=LTVY5U2BSw6Y8y50pd8gMeDmXMUSgRMURoxcufEPoIRrfa523mbJ6P0kKg5bX7Rz+dkC08
	KGm/em2mGSuui/jVQ/V34qIBEppDdW1t/Aq8/9aFFWybt/pNSh5byV9j0ZoPiRDOfFKtsL
	sQlzLh/iiinrYyAsMyoYRUNmvbq0arg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-zUwEXeGhM52c7UO-bFujcA-1; Wed,
 24 Jul 2024 21:32:39 -0400
X-MC-Unique: zUwEXeGhM52c7UO-bFujcA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0DEE01955D45;
	Thu, 25 Jul 2024 01:32:38 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.141])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EDAA01955D42;
	Thu, 25 Jul 2024 01:32:31 +0000 (UTC)
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
Subject: [PATH v6 2/3] vdpa_sim_net: Add the support of set mac address
Date: Thu, 25 Jul 2024 09:31:03 +0800
Message-ID: <20240725013217.1124704-3-lulu@redhat.com>
In-Reply-To: <20240725013217.1124704-1-lulu@redhat.com>
References: <20240725013217.1124704-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Add the function to support setting the MAC address.
For vdpa_sim_net, the driver will write the MAC address
to the config space, and other devices can implement
their own functions to support this.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index cfe962911804..cd404a896414 100644
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
+		ether_addr_copy(vio_config->mac, config->net.mac);
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

