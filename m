Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE8514B96E
	for <virtualization@lists.linux.dev>; Wed, 22 Jan 2025 06:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737526595; cv=none; b=LqzRLYJGsuwuPuRQVrE3jclCBBXdgoxQnjl+UlyoZJVEyfjfRsk+YWi/8cHbxC5mXNIZFWgDtOpjsaTErVw0RS9RH5IXu5KFmhAhyv4aelYsTAn9v0i869YWOpKUTSP5M8vCdmp/s03EYiTvYlW6mFaDjNotgbO97RJXwHE5luQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737526595; c=relaxed/simple;
	bh=MT2Dh3Y6UWz7kMEHCO0eCOmGA36V0EnMYj/v3RzV2OY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K1+2/sFGdFA1qdvNNcUKSRbM1et1wM8RQDFxP2DvSAjFThS1PgwMpElVBFOwE7kjakR5hNz7Ik+gbUKCjYOp4W8va6vhTN9tKcL+J8ooRGMev6XgPCXZ3SA2PHCaRRHLbOg9yv090Jh1wg2QFUtTFYX3QH2p3DeioZY3p/dTWLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iGWELSl5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iGWELSl5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737526592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LUcQNxydkL92jLreS5YjwBGir+KoqMaS0EjOwxHRgcA=;
	b=iGWELSl5/qmPRehWWVVaAS+XRqSJB84Y/UICBjK1XUrszDHX/j2vjY9F9GCCzYVyCrJx7c
	szJSZk5+lMwnBr+KC70v0+k3cs7gzA4dT2fvc2c1DNMChCUZR0n8NqSpYCrTsFZTAI+EUx
	sqJioGOxd7JvtTiCEfA9/DxikiBM+2E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-aAtdN_yZO8On6VXg3OtIrg-1; Wed,
 22 Jan 2025 01:16:30 -0500
X-MC-Unique: aAtdN_yZO8On6VXg3OtIrg-1
X-Mimecast-MFC-AGG-ID: aAtdN_yZO8On6VXg3OtIrg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B27AB19560B7;
	Wed, 22 Jan 2025 06:16:28 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.209])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 826CE19560AB;
	Wed, 22 Jan 2025 06:16:19 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next RFC 1/2] virtio-net: factor out logic for stopping TX
Date: Wed, 22 Jan 2025 14:15:59 +0800
Message-ID: <20250122061600.16781-2-jasowang@redhat.com>
In-Reply-To: <20250122061600.16781-1-jasowang@redhat.com>
References: <20250122061600.16781-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

This patch factors out the logic of checking and stopping TX into a
dedicated helper. This will be used by following patch.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7646ddd9bef7..2f6c3dc68ba0 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1088,11 +1088,10 @@ static bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
 		return false;
 }
 
-static void check_sq_full_and_disable(struct virtnet_info *vi,
-				      struct net_device *dev,
-				      struct send_queue *sq)
+static bool tx_may_stop(struct virtnet_info *vi,
+			struct net_device *dev,
+			struct send_queue *sq)
 {
-	bool use_napi = sq->napi.weight;
 	int qnum;
 
 	qnum = sq - vi->sq;
@@ -1114,6 +1113,25 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
 		u64_stats_update_begin(&sq->stats.syncp);
 		u64_stats_inc(&sq->stats.stop);
 		u64_stats_update_end(&sq->stats.syncp);
+
+		return true;
+	}
+
+	return false;
+}
+
+static void check_sq_full_and_disable(struct virtnet_info *vi,
+				      struct net_device *dev,
+				      struct send_queue *sq)
+{
+	bool use_napi = sq->napi.weight;
+	int qnum;
+
+	qnum = sq - vi->sq;
+
+	if (tx_may_stop(vi, dev, sq)) {
+		struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
+
 		if (use_napi) {
 			if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
 				virtqueue_napi_schedule(&sq->napi, sq->vq);
-- 
2.34.1

