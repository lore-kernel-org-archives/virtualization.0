Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C7A32D42A
	for <virtualization@lists.linux-foundation.org>; Mon, 26 Jan 2026 09:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769420950; cv=none; b=dY2dLC1xY7yZAZVJAcv6uHrYPALLeq3Elc4Gb+p4r2bxmuxofLFbIZozLhYXRG9ELBSXzmABVLERZGS4HcOExggsW9Jq1SvRt8hFlCmJqSZTFbdkZxNi5BUXt1RedVYpunKOqIzLmnrNrMTi7vv5JQwiqZJequ5vR6LnLuaKE8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769420950; c=relaxed/simple;
	bh=tu5SYZ4sBijOnmwN3BXLwTM84gyNVhByLrMaj3fLiQs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ny/zrdikmiQl9AQm49R9w+AiBxt3l+KOPCPt9Yh5xA5cJZ+5xv0BJ7lwKl43e2UhHK+LkkSK+8RM343auy2zDoTM9S8T9OFToNaDljUzEZYr1leQiNNVxqtpc6gfXH95WmIamZoyx2qlnHImHvw5kjqhyl2wzLgsIXd6rSpHKew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BMMhNc75; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BMMhNc75"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0C63C8177A
	for <virtualization@lists.linux-foundation.org>; Mon, 26 Jan 2026 09:49:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0qIQxY0jMXSe for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jan 2026 09:49:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org DB6D78164B
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DB6D78164B
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BMMhNc75
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DB6D78164B
	for <virtualization@lists.linux-foundation.org>; Mon, 26 Jan 2026 09:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769420946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=34z1K+d6LyulR8yKYD3uyl4l7F9JoQvdVoW4oBdiuc0=;
	b=BMMhNc75NC+gjUolp6SjLetcnxYyOAzdxOw2VyH06vEuYsI2uJRCUgsuMjlqxhkLBn7MZ/
	mbt2MIk4tw35ggVxYHyJP5LX/fKi1hvqZz0lCFcbVv8GfTCOivihGqJvgRFPvcV0RktUON
	H4jKNTx1juYdf4+KJIkd3wimP9ernx8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-QIZ-x6qHNwOV-9qF82R1qQ-1; Mon,
 26 Jan 2026 04:49:03 -0500
X-MC-Unique: QIZ-x6qHNwOV-9qF82R1qQ-1
X-Mimecast-MFC-AGG-ID: QIZ-x6qHNwOV-9qF82R1qQ_1769420941
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8DE691977642;
	Mon, 26 Jan 2026 09:49:01 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D7374180066A;
	Mon, 26 Jan 2026 09:48:57 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	dtatulea@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH v4 1/3] vdpa/mlx5: update mlx_features with driver state check
Date: Mon, 26 Jan 2026 17:45:36 +0800
Message-ID: <20260126094848.9601-2-lulu@redhat.com>
In-Reply-To: <20260126094848.9601-1-lulu@redhat.com>
References: <20260126094848.9601-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add logic in mlx5_vdpa_set_attr() to ensure the VIRTIO_NET_F_MAC
feature bit is properly set only when the device is not yet in
the DRIVER_OK (running) state.

This makes the MAC address visible in the output of:

 vdpa dev config show -jp

when the device is created without an initial MAC address.

Signed-off-by: Cindy Lu <lulu@redhat.com>

Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index ddaa1366704b..6e42bae7c9a1 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -4049,7 +4049,7 @@ static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
 	struct mlx5_vdpa_dev *mvdev;
 	struct mlx5_vdpa_net *ndev;
 	struct mlx5_core_dev *mdev;
-	int err = -EOPNOTSUPP;
+	int err = 0;
 
 	mvdev = to_mvdev(dev);
 	ndev = to_mlx5_vdpa_ndev(mvdev);
@@ -4057,13 +4057,22 @@ static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
 	config = &ndev->config;
 
 	down_write(&ndev->reslock);
-	if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
+
+	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
+		if (!(ndev->mvdev.status & VIRTIO_CONFIG_S_DRIVER_OK)) {
+			ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_MAC);
+		} else {
+			mlx5_vdpa_warn(mvdev, "device running, skip updating MAC\n");
+			err = -EBUSY;
+			goto out;
+		}
 		pfmdev = pci_get_drvdata(pci_physfn(mdev->pdev));
 		err = mlx5_mpfs_add_mac(pfmdev, config->mac);
 		if (!err)
 			ether_addr_copy(config->mac, add_config->net.mac);
 	}
 
+out:
 	up_write(&ndev->reslock);
 	return err;
 }
-- 
2.51.0

