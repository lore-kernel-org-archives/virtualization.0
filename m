Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E067A32C94B
	for <virtualization@lists.linux-foundation.org>; Mon, 26 Jan 2026 09:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769420960; cv=none; b=PwEer0IIaa00lbsFP+QigNLJa4Up7reKzFdy1rFWmlIGSoUtgg7HWlGJSE7BAx9H5ZGxMAI05eeTKaEXY4UK/aHrrUJmJcfVoz0XU0rnMSSv7f0DVOyU/3QmfoS1Ce+XoUdUm0TcCjGPtFclN2qeY2/RZdLqcjKYSfAFtbOBO9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769420960; c=relaxed/simple;
	bh=sQG0ulPjyoMU2mXqCzKt0fj8BMgAfnG4+oOFmOhKhfo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oniMEy13dtr4KZ440pgNhecRHk2G5jPTdhQ41LdY8sfRKjYCM/x4Iq1Y0vKjcNVj1bQwiboJo5faLsxuUw2Xs/Y52cEMhZ3zT/gzqatoi0+BscimdYVymIwUk9+BcARAPPhkNUcXhGtjWCjqN9ItY1RUzsaAoaM7cBuRAg+EjlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UuV738Vl; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UuV738Vl"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 821704097B
	for <virtualization@lists.linux-foundation.org>; Mon, 26 Jan 2026 09:49:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.795
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yug-Fp673EiQ for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jan 2026 09:49:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 749574090C
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 749574090C
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UuV738Vl
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 749574090C
	for <virtualization@lists.linux-foundation.org>; Mon, 26 Jan 2026 09:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769420956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ItKIv+h2/RtsA3PNwbq9GoAOv0lsdKDp+oWdKyES3kM=;
	b=UuV738VlvM5SEf3WQAXMXrT9pR8Sx1F0/EOsde6Kt772SnRDu6UBBpxWtJyH23lx4YeZS4
	NiFdouxvgqsiXkbm/25r33AHLuMAvz1cYRhSjfqM7qB7tOlQxbWTwKoBGmLm/1qWUnm7ft
	JDUxBjyPlvmP8Zmh5zEpp+cCj2O62S8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-XxBIQ1eWMfSKmDIbSAM0Sg-1; Mon,
 26 Jan 2026 04:49:12 -0500
X-MC-Unique: XxBIQ1eWMfSKmDIbSAM0Sg-1
X-Mimecast-MFC-AGG-ID: XxBIQ1eWMfSKmDIbSAM0Sg_1769420951
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E9811956094;
	Mon, 26 Jan 2026 09:49:11 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D7E71180066A;
	Mon, 26 Jan 2026 09:49:07 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	dtatulea@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH v4 3/3] vdpa/mlx5: update MAC address handling in mlx5_vdpa_set_attr()
Date: Mon, 26 Jan 2026 17:45:38 +0800
Message-ID: <20260126094848.9601-4-lulu@redhat.com>
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

Improve MAC address handling in mlx5_vdpa_set_attr() to ensure that
old MAC entries are properly removed from the MPFS table before
adding a new one. The new MAC address is then added to both the MPFS
and VLAN tables.

This change fixes an issue where the updated MAC address would not
take effect until QEMU was rebooted.

Signed-off-by: Cindy Lu <lulu@redhat.com>

Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 78a4b80d1ce2..517edd7da019 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -4055,17 +4055,15 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
 static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *dev,
 			      const struct vdpa_dev_set_config *add_config)
 {
-	struct virtio_net_config *config;
 	struct mlx5_core_dev *pfmdev;
 	struct mlx5_vdpa_dev *mvdev;
 	struct mlx5_vdpa_net *ndev;
 	struct mlx5_core_dev *mdev;
-	int err = 0;
+	int err = -EOPNOTSUPP;
 
 	mvdev = to_mvdev(dev);
 	ndev = to_mlx5_vdpa_ndev(mvdev);
 	mdev = mvdev->mdev;
-	config = &ndev->config;
 
 	down_write(&ndev->reslock);
 
@@ -4078,9 +4076,8 @@ static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
 			goto out;
 		}
 		pfmdev = pci_get_drvdata(pci_physfn(mdev->pdev));
-		err = mlx5_mpfs_add_mac(pfmdev, config->mac);
-		if (!err)
-			ether_addr_copy(config->mac, add_config->net.mac);
+		err = mlx5_vdpa_change_mac(ndev, pfmdev,
+					   (u8 *)add_config->net.mac);
 	}
 
 out:
-- 
2.51.0

