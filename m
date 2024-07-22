Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5A5101EE
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jul 2024 01:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721610421; cv=none; b=fVdwx5A06yFpQoDY6i4avp9+NRTd8m6yfHF87Y9SR51SCOi7Du16eFCUTVskGx60MuutZlzXoY5SPY4xRCMKsdHyuLc0bwY8VF+Ht448mOiUKfzDELLeh7h/3wpaJex5BB1uJ2KOmqupFYTLT601ZAus7jp6VeGfmhusf/2YP94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721610421; c=relaxed/simple;
	bh=gXbWIq+gxkTzT3zch5PQ/lEQzgZ4K6uVJ8NO5W4Cj6g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t1QCGuepTicKA9cfCxf9loVKw4U4l6bTBqPTmjKh+ODKNjEyPc4tbGefo8PoBk8k0kzRuVuQpiD1/lQEQBCdYLWPGcCD3mzlkuDR1EMYym/ghNaD1uiiCW1NDU7j5EqtyE5UWy1o4o2QKllN6cq3JKcytCaqfF+oIb/ywbPJk4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JND6bYfq; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JND6bYfq"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B9AE4402FD
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jul 2024 01:06:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BYLbYc8i5jra for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Jul 2024 01:06:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org BBC0F402EF
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BBC0F402EF
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JND6bYfq
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BBC0F402EF
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jul 2024 01:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721610417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K4jF6VLeOGDtL4UWMcNA9VQvzb5OUV9kjKDeZZWn4yk=;
	b=JND6bYfqnjU68MY3zeSXWbtHWZfVR4Xt7HzGbpwsp66fvRT2ZRcDZBzdoHC0AHtOSGdNp9
	WbYQp0pAajlrW4LHWHi0S3NEpIzTlnAFuUPnSn4pZEIAidKlXREsXoCxWri2oHViAG8q/A
	vQUkbWvAbFikOr0JbRDSpctuiYUrCdU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-8veGnTEQMDyOHd8Y2cAJZw-1; Sun,
 21 Jul 2024 21:06:53 -0400
X-MC-Unique: 8veGnTEQMDyOHd8Y2cAJZw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 79FC219560AD;
	Mon, 22 Jul 2024 01:06:52 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.22])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7C69A195605A;
	Mon, 22 Jul 2024 01:06:47 +0000 (UTC)
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
Subject: [PATH v4 3/3] vdpa/mlx5: Add the support of set mac address
Date: Mon, 22 Jul 2024 09:05:20 +0800
Message-ID: <20240722010625.1016854-4-lulu@redhat.com>
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
For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
to set the mac address

Tested in ConnectX-6 Dx device

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index ecfc16151d61..415b527a9c72 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -3785,10 +3785,35 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
 	destroy_workqueue(wq);
 	mgtdev->ndev = NULL;
 }
+static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev,
+			      struct vdpa_device *dev,
+			      const struct vdpa_dev_set_config *add_config)
+{
+	struct mlx5_vdpa_dev *mvdev;
+	struct mlx5_vdpa_net *ndev;
+	struct mlx5_core_dev *mdev;
+	struct virtio_net_config *config;
+	struct mlx5_core_dev *pfmdev;
+	int err = -EOPNOTSUPP;
+
+	mvdev = to_mvdev(dev);
+	ndev = to_mlx5_vdpa_ndev(mvdev);
+	mdev = mvdev->mdev;
+	config = &ndev->config;
+
+	if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
+		pfmdev = pci_get_drvdata(pci_physfn(mdev->pdev));
+		err = mlx5_mpfs_add_mac(pfmdev, config->mac);
+		if (!err)
+			memcpy(config->mac, add_config->net.mac, ETH_ALEN);
+	}
+	return err;
+}
 
 static const struct vdpa_mgmtdev_ops mdev_ops = {
 	.dev_add = mlx5_vdpa_dev_add,
 	.dev_del = mlx5_vdpa_dev_del,
+	.dev_set_attr = mlx5_vdpa_set_attr,
 };
 
 static struct virtio_device_id id_table[] = {
-- 
2.45.0

