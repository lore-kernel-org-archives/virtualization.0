Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0B384D10
	for <virtualization@lists.linux-foundation.org>; Mon, 29 Jul 2024 05:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722230546; cv=none; b=PCBm57RwAJZ7Dwcq+SxgR5hwkadT+kTVIof53gtgm2gzQZchVtNUtQRg2PVndYlTJ6jewlRCMD2VNmLUqCgSJ0PRB248z43g3KhhTZDOgQYfbsOK6wor2+fZ+sJuuu+YLQvzKEL0fALHNOggLs+fy+hnaMzitg9xP/bdX6jq6I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722230546; c=relaxed/simple;
	bh=gtbtsPPrhBlsHf9S+0HR57Br4O4cC9TR/0wWshqIE2E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VT3qXCzl9MbLjBzsUIBz/w14md4WLUcBIUVdDbZgCFossEDL6zQs9UUg5H3H58ho+9sEWi+d++pCZG0g7QaE8ap6zxbuRAmnCZGl+EqXjrJBw/jsrL0cVsPH8/97KA8nTBPx4l7orCmH/NEcAcvlLf9VNH0KNhaT3djMN3a7O9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CzrG+T1U; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CzrG+T1U"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 17C364016D
	for <virtualization@lists.linux-foundation.org>; Mon, 29 Jul 2024 05:22:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vCJxH_nsr0cH for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Jul 2024 05:22:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2818A400C5
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2818A400C5
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CzrG+T1U
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2818A400C5
	for <virtualization@lists.linux-foundation.org>; Mon, 29 Jul 2024 05:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722230543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PxloFJjHKztR9LybQruoy6tmYRAm4Ks4H6Vbpd2cuSQ=;
	b=CzrG+T1UF/BprEBlaIiCDL6CSG5JGnl1Tr/2sX2n3n/9QOa9+Kp+1M6omPVzhKiI41eu7a
	WzlcYR4UUzT4NG3upID3cYeDqIYJRGhCoVc0oaKyfJdbFyBtXTdlxsrc5Hh0+YeKtlWclc
	lLv2R/YEG94tvW0VdaMw9PjzfdByxaU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-s22FMNWmM3uPmfWY7IR2DQ-1; Mon,
 29 Jul 2024 01:22:19 -0400
X-MC-Unique: s22FMNWmM3uPmfWY7IR2DQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 28D7C1955D45;
	Mon, 29 Jul 2024 05:22:18 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.168])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 227DB1955D42;
	Mon, 29 Jul 2024 05:22:12 +0000 (UTC)
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
Subject: [PATCH v7 3/3] vdpa/mlx5: Add the support of set mac address
Date: Mon, 29 Jul 2024 13:20:47 +0800
Message-ID: <20240729052146.621924-4-lulu@redhat.com>
In-Reply-To: <20240729052146.621924-1-lulu@redhat.com>
References: <20240729052146.621924-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Add the function to support setting the MAC address.
For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
to set the mac address

Tested in ConnectX-6 Dx device

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index ecfc16151d61..dd19eec40297 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -3786,9 +3786,37 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
 	mgtdev->ndev = NULL;
 }
 
+static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *dev,
+			      const struct vdpa_dev_set_config *add_config)
+{
+	struct virtio_net_config *config;
+	struct mlx5_core_dev *pfmdev;
+	struct mlx5_vdpa_dev *mvdev;
+	struct mlx5_vdpa_net *ndev;
+	struct mlx5_core_dev *mdev;
+	int err = -EINVAL;
+
+	mvdev = to_mvdev(dev);
+	ndev = to_mlx5_vdpa_ndev(mvdev);
+	mdev = mvdev->mdev;
+	config = &ndev->config;
+
+	down_write(&ndev->reslock);
+	if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
+		pfmdev = pci_get_drvdata(pci_physfn(mdev->pdev));
+		err = mlx5_mpfs_add_mac(pfmdev, config->mac);
+		if (!err)
+			ether_addr_copy(config->mac, add_config->net.mac);
+	}
+
+	up_write(&ndev->reslock);
+	return err;
+}
+
 static const struct vdpa_mgmtdev_ops mdev_ops = {
 	.dev_add = mlx5_vdpa_dev_add,
 	.dev_del = mlx5_vdpa_dev_del,
+	.dev_set_attr = mlx5_vdpa_set_attr,
 };
 
 static struct virtio_device_id id_table[] = {
-- 
2.45.0

