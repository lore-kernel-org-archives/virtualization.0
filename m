Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C5619DFB6
	for <virtualization@lists.linux.dev>; Tue, 18 Jun 2024 07:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718697419; cv=none; b=hrXZ0lloysiGSP33LTreQ+bGyK0OMeuHn9yatyta/8YuV7EaUjlWiPpdOJh323sK0ja8/I32xZl2B2fJhG9JOD030JGqJQuWpvctTzDvGFCnXCAUfhBJlBKfb3M0xtImX40XFeLzo48K3x9BcK5synXqFJSN0Lxzwg0NbqU0Gcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718697419; c=relaxed/simple;
	bh=CIedzif6anRpRJNYMgvhFXRgdFqD4R2ceRZwrFkGgxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UElFD9z6GDSgcU0G4L+sIB7ZHUMu87DN2j/vBLgtOdz8gN9Wiwb8SDkKPWhocN3XnT0LZCL6weRe9v7C+GlT2mmgNfNOl5Zb054yIwlXOBNecyH3DtfRzg9A58Ps7y6p7vYYfs+UAYoz6yKTc61hGcW+7sv+yIV31WZ5Ci/h3Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pAx/GtTN; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pAx/GtTN"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718697415; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=DcosxQGMQEHUFy3QfeHPEhVjZwNhFC25zEd8+sxMlFA=;
	b=pAx/GtTNCP/FFvrtJHMz9WD8ILrCi895etNYX8HAE4/PwoCZu0FaSwMeWYti5scrJcBpPc//rMXb6KB17guKW/cCgbuQqx4zl2DM5fiLlYw0CSAWMZc/JZN6Gf91W0I08786zM4vgdDUVju8TVzj0P3rP1hmjo3J21YNvHeL55g=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8jQnKJ_1718697413;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8jQnKJ_1718697413)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 15:56:54 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next v6 10/10] virtio_net: xsk: rx: free the unused xsk buffer
Date: Tue, 18 Jun 2024 15:56:43 +0800
Message-Id: <20240618075643.24867-11-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240618075643.24867-1-xuanzhuo@linux.alibaba.com>
References: <20240618075643.24867-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 8baa0af3684b
Content-Transfer-Encoding: 8bit

Release the xsk buffer, when the queue is releasing or the queue is
resizing.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index cfa106aa8039..33695b86bd99 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -967,6 +967,11 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
 
 	rq = &vi->rq[i];
 
+	if (rq->xsk.pool) {
+		xsk_buff_free((struct xdp_buff *)buf);
+		return;
+	}
+
 	if (!vi->big_packets || vi->mergeable_rx_bufs)
 		virtnet_rq_unmap(rq, buf, 0);
 
-- 
2.32.0.3.g01195cf9f

