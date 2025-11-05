Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDDF280024
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Nov 2025 08:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762329739; cv=none; b=TBz15nFbb+SQOS4t2g/uSjTjL2Ubb8P8NQZrlfOdMKgv1btMmLvVG93vj9UoPcvoimCzFSUOCywvj80Gfi99uU/8dVD4m/7eoto+q5GSNb6zzgHwfWfnPJKFSJ0XKLniAuFaBLMYZptUsQ2v7/dLthOE+eWV9fCkhKk+gpuUxXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762329739; c=relaxed/simple;
	bh=eMxORmOzUuI5OdwDROOfx+2eROrvTAMSvHg6lfs+y/Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=F37kHGgOx1YHc9e4CID5445+CjR/l0tXjuxTg92KVwYoL3qciM576G8+jloJ1EJBMUm2S4E0TIn7xKYc+aMQKq+DceYTZmiZibG1vFINrMJyUu6K3xNz6H5BHVbim/gF5DCoAPo28oTu2kiLCZIYI+keG+NXlg9Ebc4/iQxvXQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QovKIbdo; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QovKIbdo"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C21FD6128D
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Nov 2025 08:02:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4ecm8dmpfOoW for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Nov 2025 08:02:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C7E4F61287
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C7E4F61287
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QovKIbdo
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C7E4F61287
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Nov 2025 08:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762329732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w6f8wSwHsRTwr+h58t/mZjZ7NV8Io6r807CbA2kYWRE=;
	b=QovKIbdonHhOgajWURmYPw8FSK6D3IXWBdpwj4vtuBDxFtamNNzZatlh3JyPlAyiYERNnb
	uLd+ul2LLOZJtXGUDUPL4dc138vnigYB1m+wDBlv+d3w7Wb29HGsLVez/cLn7qobMcMqUY
	Zf6af+HGsk2b100DPNra+oqPWO0Ol2U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-C-jwHh3MN1SrklTbB3Q5Dw-1; Wed,
 05 Nov 2025 03:02:11 -0500
X-MC-Unique: C-jwHh3MN1SrklTbB3Q5Dw-1
X-Mimecast-MFC-AGG-ID: C-jwHh3MN1SrklTbB3Q5Dw_1762329730
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1D8D71956080;
	Wed,  5 Nov 2025 08:02:10 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.48])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2F3001800451;
	Wed,  5 Nov 2025 08:02:05 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	dtatulea@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] vdpa/mlx5: update mlx_features with driver state check
Date: Wed,  5 Nov 2025 16:01:41 +0800
Message-ID: <20251105080151.1115698-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add logic in mlx5_vdpa_set_attr() to ensure the VIRTIO_NET_F_MAC
feature bit is properly set only when the device is not yet in
the DRIVER_OK (running) state.

This makes the MAC address visible in the output of:

 vdpa dev config show -jp

when the device is created without an initial MAC address.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 82034efb74fc..e38aa3a335fc 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -4057,6 +4057,12 @@ static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
 	ndev = to_mlx5_vdpa_ndev(mvdev);
 	mdev = mvdev->mdev;
 	config = &ndev->config;
+	if (!(ndev->mvdev.status & VIRTIO_CONFIG_S_DRIVER_OK)) {
+		ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_MAC);
+	} else {
+		mlx5_vdpa_warn(mvdev, "device running, skip updating MAC\n");
+		return err;
+	}
 
 	down_write(&ndev->reslock);
 	if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
-- 
2.45.0

