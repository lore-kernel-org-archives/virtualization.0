Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AE81F76B5
	for <virtualization@lists.linux.dev>; Tue, 21 Jan 2025 19:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737486674; cv=none; b=r+fXZG/tKHHXYELWua+TAZcCPGlND7h0nK3PT2ciB6fa63RPCxjGTcpXED4t7rEYylI0368G3k3AgBWVqicAWk8AD2seAZMxEq5pjTJ8/V9EG20MKsT1slj+QpA0O+BHtoZnOozZT/HjJmtS/Gr10wInf7zRzHvxYUnJn4TpoqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737486674; c=relaxed/simple;
	bh=CCW7kggp+rYbKpVhb0njIkNRisnJGwdMk+Hd84d4x2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ERzkvF/uhNeqDJ8/Wo+SxlGT3+CjgRRSWpX0C5r4g04ND//EPiICMarJRy3RKF2AFuvWHB6RQpyGc3SnDQRPaKKVRsMX9yYeMP6lWAPGZGALYrFheK+4FKlb6fqv9kfDvw3JCP25sTNDRWfPha18bvOAnmXMjC7id1hwpinAgY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Fwrv+s+K; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Fwrv+s+K"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ee51f8c47dso8325070a91.1
        for <virtualization@lists.linux.dev>; Tue, 21 Jan 2025 11:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1737486672; x=1738091472; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIxZmc2dYAqFea8fzwYrgwOnSbwHFqsyPk6MUVa0VxU=;
        b=Fwrv+s+Knz7YQPz4o/WSMy+lV6b0S4VkHjTeOSUNpzy6P/u4aKTmckeIJ2oenzws6e
         MlEI3xskDd+LDdh0Otwnmd719tpQktjR7P0aOvD+7caiHJkkzY96t+mnPPsmNkUzMofG
         zI5YiDVBm54zu7u+kTby79wMXnmODb7VNK3pM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737486672; x=1738091472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIxZmc2dYAqFea8fzwYrgwOnSbwHFqsyPk6MUVa0VxU=;
        b=Ym6RjiIsFu/GLvHTLwEC+pbEt3Z2EVxQ76pC2H1p+ST/rkx01aWCzXow4BiSeXYcpR
         DILm4ofB7GvFoxKZcf9GRBaqsxre6I1XrQenerEjPjP0cU8nBuWkQmPNA0X1v9fiv/hj
         +XRM2pwfU550K4eUD1cqFo6XejMG/kUTp2K5e8pzvRb8OxgpplCjfXgUSfOVNjouIolR
         BWVox5LUXH0XF7lzP7e8ciOXTvRXMW07BMns7yqs/BqAQGD++xVLVBBT4fkDv61fqI8A
         khcfgKjl8UPDKS730mItfTmCsh5TtrSPVonJ3ZS3mmo6tAUma8sahrv/Fz4AICGZJ8AY
         x70Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+b2Wf03ItFSky3qE9dl6zVWgA58g8QOMs4tQXi5Z+oqDUzgstHMrtaB7CSsyKLdm/xdgMwOlpqougyAGLKA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQu6zVfYIJ3+lOZRlJIpYTOtGlsT69ifsVplAvYtU/EwNTnDFV
	nA/cW2qGyZM9yplZBt5b6UFy0yuGxNxj11zadDid56QnYD7h0kYYEBzaxefZ8Yo=
X-Gm-Gg: ASbGnct5raU1Xxf89cLeTk0ExpjiF3Mhv/YUvI2CVaKMZyAZ+rgh43hvoFwP2NoTVbu
	vDs6T5e36NUDlZCEPaA5wSc59LJ0x/XeUtZhGq49/Sc0/nkBVxydE9E6zUQ83jsOxjZZvJyHxfn
	GpWTbvra6fUZoMVseyIqQaH4/eWAhsAx7t0cqYD9JjAsvqco+Zc6yNR4Eig95jXhsApPmB0OQPT
	TSM6QsoAwpBKc8NKWupxP+1deu1/oR5NMrCe4gQwiD8ZN81nxugtiUKLiyYbDcdYhQr6kXLIgX8
	nw==
X-Google-Smtp-Source: AGHT+IFmMAsVqWPTr/+MdaRMifAEOsKB5cFMykGXnqvqzynVvQlUx7VWgc1M158q6rlxSpFG7RmfQw==
X-Received: by 2002:a17:90b:5206:b0:2f4:f7f8:fc8b with SMTP id 98e67ed59e1d1-2f782d4ed77mr26908949a91.27.1737486672019;
        Tue, 21 Jan 2025 11:11:12 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7db6ab125sm1793440a91.26.2025.01.21.11.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 11:11:11 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: gerhard@engleder-embedded.com,
	jasowang@redhat.com,
	leiyang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	mkarsten@uwaterloo.ca,
	Joe Damato <jdamato@fastly.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next v3 3/4] virtio_net: Map NAPIs to queues
Date: Tue, 21 Jan 2025 19:10:43 +0000
Message-Id: <20250121191047.269844-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250121191047.269844-1-jdamato@fastly.com>
References: <20250121191047.269844-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
can be accessed by user apps.

$ ethtool -i ens4 | grep driver
driver: virtio_net

$ sudo ethtool -L ens4 combined 4

$ ./tools/net/ynl/pyynl/cli.py \
       --spec Documentation/netlink/specs/netdev.yaml \
       --dump queue-get --json='{"ifindex": 2}'
[{'id': 0, 'ifindex': 2, 'napi-id': 8289, 'type': 'rx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8290, 'type': 'rx'},
 {'id': 2, 'ifindex': 2, 'napi-id': 8291, 'type': 'rx'},
 {'id': 3, 'ifindex': 2, 'napi-id': 8292, 'type': 'rx'},
 {'id': 0, 'ifindex': 2, 'type': 'tx'},
 {'id': 1, 'ifindex': 2, 'type': 'tx'},
 {'id': 2, 'ifindex': 2, 'type': 'tx'},
 {'id': 3, 'ifindex': 2, 'type': 'tx'}]

Note that virtio_net has TX-only NAPIs which do not have NAPI IDs, so
the lack of 'napi-id' in the above output is expected.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 rfcv3:
   - Eliminated XDP checks; NAPIs will always be mapped to RX queues, as
     Gerhard Engleder suggested.

 v2:
   - Eliminate RTNL code paths using the API Jakub introduced in patch 1
     of this v2.
   - Added virtnet_napi_disable to reduce code duplication as
     suggested by Jason Wang.

 drivers/net/virtio_net.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index cff18c66b54a..c120cb2106c0 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2805,7 +2805,11 @@ static void virtnet_napi_do_enable(struct virtqueue *vq,
 
 static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
 {
+	struct virtnet_info *vi = vq->vdev->priv;
+
 	virtnet_napi_do_enable(vq, napi);
+
+	netif_queue_set_napi(vi->dev, vq2rxq(vq), NETDEV_QUEUE_TYPE_RX, napi);
 }
 
 static void virtnet_napi_tx_enable(struct virtnet_info *vi,
@@ -2826,6 +2830,16 @@ static void virtnet_napi_tx_enable(struct virtnet_info *vi,
 	virtnet_napi_do_enable(vq, napi);
 }
 
+static void virtnet_napi_disable(struct virtqueue *vq,
+				 struct napi_struct *napi)
+{
+	struct virtnet_info *vi = vq->vdev->priv;
+
+	netif_queue_set_napi(vi->dev, vq2rxq(vq), NETDEV_QUEUE_TYPE_RX, NULL);
+
+	napi_disable(napi);
+}
+
 static void virtnet_napi_tx_disable(struct napi_struct *napi)
 {
 	if (napi->weight)
@@ -2842,7 +2856,8 @@ static void refill_work(struct work_struct *work)
 	for (i = 0; i < vi->curr_queue_pairs; i++) {
 		struct receive_queue *rq = &vi->rq[i];
 
-		napi_disable(&rq->napi);
+		virtnet_napi_disable(rq->vq, &rq->napi);
+
 		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
 		virtnet_napi_enable(rq->vq, &rq->napi);
 
@@ -3042,7 +3057,7 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
 {
 	virtnet_napi_tx_disable(&vi->sq[qp_index].napi);
-	napi_disable(&vi->rq[qp_index].napi);
+	virtnet_napi_disable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
 	xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
 }
 
@@ -3313,7 +3328,7 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
 	bool running = netif_running(vi->dev);
 
 	if (running) {
-		napi_disable(&rq->napi);
+		virtnet_napi_disable(rq->vq, &rq->napi);
 		virtnet_cancel_dim(vi, &rq->dim);
 	}
 }
@@ -5932,7 +5947,7 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 	/* Make sure NAPI is not using any XDP TX queues for RX. */
 	if (netif_running(dev)) {
 		for (i = 0; i < vi->max_queue_pairs; i++) {
-			napi_disable(&vi->rq[i].napi);
+			virtnet_napi_disable(vi->rq[i].vq, &vi->rq[i].napi);
 			virtnet_napi_tx_disable(&vi->sq[i].napi);
 		}
 	}
-- 
2.25.1

