Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D68F3E0C66
	for <virtualization@lists.linux.dev>; Tue, 31 Mar 2026 10:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952822; cv=none; b=rD+42qCJcTxSLVzwLkRvoFLcNNr2isEWbm+ZMzEBaZOi7WkeCaHUx4qsdZ8/pBn7CSLQKH2UdqYFQ9moc+KVFUXu24Kmt7IcJ7E+HoU8EsDR+713cjqPXtBsAHg+VeyOA8bK8prXLCkPLlHB8kaIBQ9SRRerxQMtgjaeGpgFkvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952822; c=relaxed/simple;
	bh=yBhUO9AcDizDzi5hZ7HFPf1Ys9igXRDkMcDveowrUBU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t6F2k+HXMDdOMlSwXhWzbEi7xrlZoBEy9uAjVTX1AW1zewB/exXV5n6g3LtpuVnJTaMmnkGLfyvCAtVXQ+YZIVPU0ESBDkUhhq43JLBkO1cYI79c5fm9Tq61OHCcXGByDgquaSlcnuwG5SAOu28Vbsu+wHCLvTV14nd3zafiwV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WewWCeZ4; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WewWCeZ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=qj
	GcDu2cLYHPG5yJ/yHByIrJKq6iL1NMW8tRcHnqlWk=; b=WewWCeZ4Pcolhw1OXj
	er2iatdtthc2VinSXnGhWL18+yaAwmmq5sPzlr5BvP7icgm2VheWN0TnHAfuGw5s
	nmzWnbEMpDu7VQ0Z1aV/N+f2TH/yq1PS15EiqmZ6jfda846zNERCfnBgjo6rUao8
	z6HI0xixAVcu7KZLxEK9HNFzg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDHqoNToctphXY9CQ--.9353S3;
	Tue, 31 Mar 2026 18:26:28 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	edumazet@google.com
Cc: lange_tang@163.com,
	tanglongjun@kylinos.cn,
	virtualization@lists.linux.dev
Subject: [PATCH 1/2] virtio_net: disable cb when in busy-polling
Date: Tue, 31 Mar 2026 18:26:25 +0800
Message-Id: <20260331102626.108962-2-lange_tang@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260331102626.108962-1-lange_tang@163.com>
References: <20260331102626.108962-1-lange_tang@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHqoNToctphXY9CQ--.9353S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrurW3GFW3trWkWF4kGry7Awb_yoWDZFg_C3
	4xWr1fG345AFsYk3yUuw45XrySya909F48WF9IgrySk3s7C3WUXr1DZr1DC3ZxC3yxuFnx
	Cws3XFy5t3yfWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRqeH6JUUUUU==
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC-RTK+GnLoVS2uAAA3C

From: Longjun Tang <tanglongjun@kylinos.cn>

virtnet_poll() is shared between NAPI softirq context and the busy-poll
path (sk_busy_loop).  In the busy-poll path the caller drives the loop
directly and does not rely on interrupts to schedule NAPI; keeping
callbacks enabled is wasteful and risks a flood of IRQ_NONE returns that
can trigger the kernel's spurious-IRQ detector.

Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>
---
 drivers/net/virtio_net.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 72d6a9c6a5a2..df365fba2c40 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3078,6 +3078,9 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 	unsigned int xdp_xmit = 0;
 	bool napi_complete;
 
+	if (READ_ONCE(napi->state) & NAPIF_STATE_IN_BUSY_POLL)
+		virtqueue_disable_cb(rq->vq);
+
 	virtnet_poll_cleantx(rq, budget);
 
 	received = virtnet_receive(rq, budget, &xdp_xmit);
-- 
2.43.0

