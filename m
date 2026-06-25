Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F83EEC3
	for <virtualization@lists.linux.dev>; Thu, 25 Jun 2026 01:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782351479; cv=none; b=nwQ0EZiGJdhjpqy4alA1b5/80MHqHXvSU5GlmkRv+8+Xq+9ne2L5wVUfomXPN1ukvDZ9d3XCINoskyUZpKTpliEcvw6d/0Soa3vkEZzl9nKDbU5nPnyQnpfJu6+cFYWqodH4uE5AF6y8Urdqp1oujcvDheHFcjohlQ+Ri5PmEGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782351479; c=relaxed/simple;
	bh=gZuD8Vvgu+uyRPFcFvPFgy5+G3DNYykp5gSdfDaLGEA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VhZi59uqAi6Ow/Rv/dMrJE8fgFJDuEPQjtGdMuAbI/IWMbdyiI13MZF8ZBWyWoKNkeXHsZ18IXWijxA8hc32/HZMvrjfAmn+/Z/dlK/wityWALNUcxqUtbJJoWfM8QmdtYCP57uuXuHfJgjqAZp96pX5JAVfudESbeIhB6zZFrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hAIGINI2; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hAIGINI2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=gY
	0Fh4pgY/1ngQWWvSj+epDfJSoFfpNL30c1Mz3Qqx4=; b=hAIGINI2PJnF0GXXzU
	yKjrMancxVZGNQXLftM2eRRzlK3ED7TXedtYBrsWIbqREStR/kJpUfSwy7ITxo0t
	SSHvjN3zdAUR544xm3JcAkgHD54eK1vabHFVmcCkaBEItLNyYqnHJoIbcVD6Zwlh
	YNYkXvXbm0wmknSIrTVlAnV5Y=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDnIm1jhjxqJN6SFQ--.61028S2;
	Thu, 25 Jun 2026 09:37:40 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: mst@redhat.com,
	xuanzhuo@linux.alibaba.com
Cc: jasowang@redhat.com,
	edumazet@google.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	tanglongjun@kylinos.cn,
	lange_tang@163.com
Subject: [PATCH v4] virtio_net: disable cb when NAPI is busy-polled
Date: Thu, 25 Jun 2026 09:37:33 +0800
Message-Id: <20260625013733.29300-1-lange_tang@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnIm1jhjxqJN6SFQ--.61028S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw48WFWUXF4UurWxAFWxXrb_yoW8GryfpF
	4jy3yUurn0grWIqa1kJF48XFy5uwn3GayfGw4Y9w45uFn8KrnxJry5tFyjya1avrs5ta43
	ZFsYvryUGF18uFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRknY8UUUUU=
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC-QRkkmo8hmQEZgAA3Z

From: Longjun Tang <tanglongjun@kylinos.cn>

When busy-poll is active, napi_schedule_prep() returns false in
virtqueue_napi_schedule(), so virtqueue_disable_cb() is skipped.
The device may keep firing irqs until reaches virtqueue_napi_complete().
Under load (received == budget), it will lead to a large number
of spurious interrupts.

Fix it by disabling the callback at the virtnet_poll() entry.
This keeps the callback off while we poll and it is re-enabled by
virtqueue_napi_complete() when going idle.

Fixes: ceef438d613f ("virtio_net: remove custom busy_poll")
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>

---
V1 -> V2: Remain agnostic to busy polling
V2 -> V3: Add fixes tag
V3 -> V4: Update commit message and remove some comments
---
 drivers/net/virtio_net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f4adcfee7a80..569e4db187d1 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3008,6 +3008,8 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 	unsigned int xdp_xmit = 0;
 	bool napi_complete;
 
+	virtqueue_disable_cb(rq->vq);
+
 	virtnet_poll_cleantx(rq, budget);
 
 	received = virtnet_receive(rq, budget, &xdp_xmit);
-- 
2.43.0

