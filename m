Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD86C29D267
	for <virtualization@lists.linux-foundation.org>; Mon, 26 Jan 2026 09:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769420966; cv=none; b=TlXUutLz9RwOMZG32Ho3pBsLScxOzjzpWBv3X1wj5sSAMPTo2dIARPIQyKTHwch/CSAVUCoM1gBkNUQSyxvVMS7XQgfkEjjU+BNl13mdKgDDz9xfGlEXAQqO7BFE+HWsetEA8m33Vz++rady5+UofDsAKrsiy31VEAO0e5nLgC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769420966; c=relaxed/simple;
	bh=SCfbIDBZ0i8ji2Il2O+CBn4hTNVv8fyBRR1E4OC8jIk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4pmy8mIbeRAUforWD97fAjxMhZtTZGzfwfcHyAcDyYYuT6pQHivfj+x0vzVnsk2JevwSXAwAn5iOOhAaS/Fw8vUmWIRmZTZeSr9qNqM34StzxHGfHAoQFuzxlTNSbgiejVbmng6c/wWzHB5dz26Rse3YzptGznN6k+K3if/ckw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SPgVIWXI; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SPgVIWXI"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 619FE401F6
	for <virtualization@lists.linux-foundation.org>; Mon, 26 Jan 2026 09:49:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.795
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5FmiOJZaKCbc for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jan 2026 09:49:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 586C840079
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 586C840079
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SPgVIWXI
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 586C840079
	for <virtualization@lists.linux-foundation.org>; Mon, 26 Jan 2026 09:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769420959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=95rlxJBn2msZ3au3wfm2bXPdC8+xLSko1wIOaCjjM/M=;
	b=SPgVIWXINdUSECRNhIj8VNcw7MU2iwj/pTAtDejrti4+6XJVtZ4nXsTqvNb1rtkTEXv46y
	fNl/l7w977uZnIkkdNwrUHKOw3I48aavZLOgmobeC4fYxcHogaPhifi5Ee0iCLkBkjP9y8
	F85M3VO/bU7EnpoDeIGa7AQWSdDNdAQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-Wi9pjlujN9a4MFgG7eoDRA-1; Mon,
 26 Jan 2026 04:49:08 -0500
X-MC-Unique: Wi9pjlujN9a4MFgG7eoDRA-1
X-Mimecast-MFC-AGG-ID: Wi9pjlujN9a4MFgG7eoDRA_1769420947
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E5BA1944EA8;
	Mon, 26 Jan 2026 09:49:07 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8F19618001D5;
	Mon, 26 Jan 2026 09:49:01 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	dtatulea@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH v4 2/3] vdpa/mlx5: reuse common function for MAC address updates
Date: Mon, 26 Jan 2026 17:45:37 +0800
Message-ID: <20260126094848.9601-3-lulu@redhat.com>
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

Factor out MAC address update logic and reuse it from handle_ctrl_mac().

This ensures that old MAC entries are removed from the MPFS table
before adding a new one and that the forwarding rules are updated
accordingly. If updating the flow table fails, the original MAC and
rules are restored as much as possible to keep the software and
hardware state consistent.

Signed-off-by: Cindy Lu <lulu@redhat.com>

Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 131 ++++++++++++++++--------------
 1 file changed, 71 insertions(+), 60 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 6e42bae7c9a1..78a4b80d1ce2 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2125,86 +2125,97 @@ static void teardown_steering(struct mlx5_vdpa_net *ndev)
 	mlx5_destroy_flow_table(ndev->rxft);
 }
 
-static virtio_net_ctrl_ack handle_ctrl_mac(struct mlx5_vdpa_dev *mvdev, u8 cmd)
+static int mlx5_vdpa_change_mac(struct mlx5_vdpa_net *ndev,
+				struct mlx5_core_dev *pfmdev,
+				const u8 *new_mac)
 {
-	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
-	struct mlx5_control_vq *cvq = &mvdev->cvq;
-	virtio_net_ctrl_ack status = VIRTIO_NET_ERR;
-	struct mlx5_core_dev *pfmdev;
-	size_t read;
-	u8 mac[ETH_ALEN], mac_back[ETH_ALEN];
+	struct mlx5_vdpa_dev *mvdev = &ndev->mvdev;
+	u8 old_mac[ETH_ALEN];
 
-	pfmdev = pci_get_drvdata(pci_physfn(mvdev->mdev->pdev));
-	switch (cmd) {
-	case VIRTIO_NET_CTRL_MAC_ADDR_SET:
-		read = vringh_iov_pull_iotlb(&cvq->vring, &cvq->riov, (void *)mac, ETH_ALEN);
-		if (read != ETH_ALEN)
-			break;
+	if (is_zero_ether_addr(new_mac))
+		return -EINVAL;
 
-		if (!memcmp(ndev->config.mac, mac, 6)) {
-			status = VIRTIO_NET_OK;
-			break;
+	if (!is_zero_ether_addr(ndev->config.mac)) {
+		if (mlx5_mpfs_del_mac(pfmdev, ndev->config.mac)) {
+			mlx5_vdpa_warn(mvdev, "failed to delete old MAC %pM from MPFS table\n",
+				       ndev->config.mac);
+			return -EIO;
 		}
+	}
 
-		if (is_zero_ether_addr(mac))
-			break;
+	if (mlx5_mpfs_add_mac(pfmdev, (u8 *)new_mac)) {
+		mlx5_vdpa_warn(mvdev, "failed to insert new MAC %pM into MPFS table\n",
+			       new_mac);
+		return -EIO;
+	}
 
-		if (!is_zero_ether_addr(ndev->config.mac)) {
-			if (mlx5_mpfs_del_mac(pfmdev, ndev->config.mac)) {
-				mlx5_vdpa_warn(mvdev, "failed to delete old MAC %pM from MPFS table\n",
-					       ndev->config.mac);
-				break;
-			}
-		}
+	/* backup the original mac address so that if failed to add the forward rules
+	 * we could restore it
+	 */
+	ether_addr_copy(old_mac, ndev->config.mac);
 
-		if (mlx5_mpfs_add_mac(pfmdev, mac)) {
-			mlx5_vdpa_warn(mvdev, "failed to insert new MAC %pM into MPFS table\n",
-				       mac);
-			break;
-		}
+	ether_addr_copy(ndev->config.mac, new_mac);
 
-		/* backup the original mac address so that if failed to add the forward rules
-		 * we could restore it
-		 */
-		memcpy(mac_back, ndev->config.mac, ETH_ALEN);
+	/* Need recreate the flow table entry, so that the packet could forward back
+	 */
+	mac_vlan_del(ndev, old_mac, 0, false);
 
-		memcpy(ndev->config.mac, mac, ETH_ALEN);
+	if (mac_vlan_add(ndev, ndev->config.mac, 0, false)) {
+		mlx5_vdpa_warn(mvdev, "failed to insert forward rules, try to restore\n");
 
-		/* Need recreate the flow table entry, so that the packet could forward back
+		/* Although it hardly run here, we still need double check */
+		if (is_zero_ether_addr(old_mac)) {
+			mlx5_vdpa_warn(mvdev, "restore mac failed: Original MAC is zero\n");
+			return -EIO;
+		}
+
+		/* Try to restore original mac address to MFPS table, and try to restore
+		 * the forward rule entry.
 		 */
-		mac_vlan_del(ndev, mac_back, 0, false);
+		if (mlx5_mpfs_del_mac(pfmdev, ndev->config.mac)) {
+			mlx5_vdpa_warn(mvdev, "restore mac failed: delete MAC %pM from MPFS table failed\n",
+				       ndev->config.mac);
+		}
 
-		if (mac_vlan_add(ndev, ndev->config.mac, 0, false)) {
-			mlx5_vdpa_warn(mvdev, "failed to insert forward rules, try to restore\n");
+		if (mlx5_mpfs_add_mac(pfmdev, old_mac)) {
+			mlx5_vdpa_warn(mvdev, "restore mac failed: insert old MAC %pM into MPFS table failed\n",
+				       old_mac);
+		}
 
-			/* Although it hardly run here, we still need double check */
-			if (is_zero_ether_addr(mac_back)) {
-				mlx5_vdpa_warn(mvdev, "restore mac failed: Original MAC is zero\n");
-				break;
-			}
+		ether_addr_copy(ndev->config.mac, old_mac);
 
-			/* Try to restore original mac address to MFPS table, and try to restore
-			 * the forward rule entry.
-			 */
-			if (mlx5_mpfs_del_mac(pfmdev, ndev->config.mac)) {
-				mlx5_vdpa_warn(mvdev, "restore mac failed: delete MAC %pM from MPFS table failed\n",
-					       ndev->config.mac);
-			}
+		if (mac_vlan_add(ndev, ndev->config.mac, 0, false))
+			mlx5_vdpa_warn(mvdev, "restore forward rules failed: insert forward rules failed\n");
 
-			if (mlx5_mpfs_add_mac(pfmdev, mac_back)) {
-				mlx5_vdpa_warn(mvdev, "restore mac failed: insert old MAC %pM into MPFS table failed\n",
-					       mac_back);
-			}
+		return -EIO;
+	}
 
-			memcpy(ndev->config.mac, mac_back, ETH_ALEN);
+	return 0;
+}
 
-			if (mac_vlan_add(ndev, ndev->config.mac, 0, false))
-				mlx5_vdpa_warn(mvdev, "restore forward rules failed: insert forward rules failed\n");
+static virtio_net_ctrl_ack handle_ctrl_mac(struct mlx5_vdpa_dev *mvdev, u8 cmd)
+{
+	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
+	struct mlx5_control_vq *cvq = &mvdev->cvq;
+	virtio_net_ctrl_ack status = VIRTIO_NET_ERR;
+	struct mlx5_core_dev *pfmdev;
+	size_t read;
+	u8 mac[ETH_ALEN];
 
+	pfmdev = pci_get_drvdata(pci_physfn(mvdev->mdev->pdev));
+	switch (cmd) {
+	case VIRTIO_NET_CTRL_MAC_ADDR_SET:
+		read = vringh_iov_pull_iotlb(&cvq->vring, &cvq->riov,
+					     (void *)mac, ETH_ALEN);
+		if (read != ETH_ALEN)
 			break;
-		}
 
-		status = VIRTIO_NET_OK;
+		if (!memcmp(ndev->config.mac, mac, 6)) {
+			status = VIRTIO_NET_OK;
+			break;
+		}
+		status = mlx5_vdpa_change_mac(ndev, pfmdev, mac) ? VIRTIO_NET_ERR :
+								       VIRTIO_NET_OK;
 		break;
 
 	default:
-- 
2.51.0

