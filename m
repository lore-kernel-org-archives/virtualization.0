Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468F21C68F
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Jul 2024 06:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720421775; cv=none; b=d+n2icb6x/lkJH+Beb1cVAiF98dVjSrO4S3NlQxkgOVfRmvfmcPdF6rl1maEyyGKLN56U/nSXhGnN7GFojRdtXbEXajK1SZ3OuvH1BnG8odWcyE5o+uJxbocj7dSOCzX2xBccSRm84QKnE22I0NSpRffBb+KPgsnY9DGP3vhdy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720421775; c=relaxed/simple;
	bh=4Hp4Do4UGAJLQIKtQ3aFJElV4VFL6fW2NU15zapyEDo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LRVmPYjXo1ku2igoEwmqPWC5dcr59r/lQ3br5quX2ECnzr5L+jSF4rhIQgHh/jcwH2QwWdav8GGeEY9nfaXB5dHTmUFOkWCAt85KxWrVmjwOVXdS+eRsPjJKHXS1VuEO4VZGvy5MmN32xgoAcr+WH+Ch2k9a2j0F7lQBSiJS3Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LsKH3w9z; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LsKH3w9z"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0639A4045D
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Jul 2024 06:56:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P0PuavrZhBcg for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Jul 2024 06:56:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8E46F40190
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8E46F40190
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LsKH3w9z
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8E46F40190
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Jul 2024 06:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720421771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C5uJuthEpMTO2qIM2IpHkOPsYvzc+S5T4gK4tXYNDBE=;
	b=LsKH3w9zN3gKU3KQrjsGcg3WvONrk5n8cPglB1zEOKWRMtsBm3WRx25b2TPQUU0GlBT8RI
	EZ+tDAm38eBgxqhWFEGzZn+u0ylNaXw/Amsem2vwXXhRqAPaI9r4ghE/52GYkKjgRz09Ub
	9KidVE1uWDQozTPmkDRQW67BQIY047w=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-ReXQtQdXOoyQ04FFfwRPgQ-1; Mon,
 08 Jul 2024 02:56:07 -0400
X-MC-Unique: ReXQtQdXOoyQ04FFfwRPgQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3272A19560B0;
	Mon,  8 Jul 2024 06:56:06 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.123])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 64A9B19560AE;
	Mon,  8 Jul 2024 06:55:59 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	dtatulea@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	parav@nvidia.com,
	sgarzare@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH] vdpa/mlx5: Add the support of set mac address
Date: Mon,  8 Jul 2024 14:55:49 +0800
Message-ID: <20240708065549.89422-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add the function to support setting the MAC address.
For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
to set the mac address

Tested in ConnectX-6 Dx device

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 26ba7da6b410..f78701386690 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -3616,10 +3616,33 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
 	destroy_workqueue(wq);
 	mgtdev->ndev = NULL;
 }
+static int mlx5_vdpa_set_attr_mac(struct vdpa_mgmt_dev *v_mdev,
+				  struct vdpa_device *dev,
+				  const struct vdpa_dev_set_config *add_config)
+{
+	struct mlx5_vdpa_dev *mvdev = to_mvdev(dev);
+	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
+	struct mlx5_core_dev *mdev = mvdev->mdev;
+	struct virtio_net_config *config = &ndev->config;
+	int err;
+	struct mlx5_core_dev *pfmdev;
+
+	if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
+		if (!is_zero_ether_addr(add_config->net.mac)) {
+			memcpy(config->mac, add_config->net.mac, ETH_ALEN);
+			pfmdev = pci_get_drvdata(pci_physfn(mdev->pdev));
+			err = mlx5_mpfs_add_mac(pfmdev, config->mac);
+			if (err)
+				return -1;
+		}
+	}
+	return 0;
+}
 
 static const struct vdpa_mgmtdev_ops mdev_ops = {
 	.dev_add = mlx5_vdpa_dev_add,
 	.dev_del = mlx5_vdpa_dev_del,
+	.dev_set_attr = mlx5_vdpa_set_attr_mac,
 };
 
 static struct virtio_device_id id_table[] = {
-- 
2.45.0

