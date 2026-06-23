Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2988234DB56
	for <virtualization@lists.linux.dev>; Tue, 23 Jun 2026 09:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782206369; cv=none; b=QlLbFdWVnZKkELRdXMEz/gyxhxe7TSn8Vi4IV3WAi3gxkenuXnZ2P7V+O3+fw0gjrk5h4qkugCwTtvK6Jf0vG+MR+muhxuJccCondJw7TdF8kq9vYUWZ6fUVWDyiGRk56pRqZdosGrWRknn+bjRd4COplHCzGU+o+2Jo8f6qP3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782206369; c=relaxed/simple;
	bh=w4FL5BIvW7cSQr48i2yTjN1PHBhvct/xiolvaCwH/4A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=onAoYK2zZRfrEEewOYqlgrY9izIRnbHZGCNtg9QvuP/kjWz4e4wlTDV79GkWdwKPYpHk7fkFi+2ivxvLgu4/4Ab5b/PIzQnPJWUpPiMJ6fkbNbMSUciGF+2aB7hy2euA+CWPSOHbBrY9u+pIpxnLrw8M107RA9L4RUz97QoFy4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=k/YZb4x7; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="k/YZb4x7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=fV
	Ccxy8040WsMZ0wn76jq/CYSE6ONKUMShmozTiptzU=; b=k/YZb4x7BOdcZBVR+5
	UH4wuFoC+q2/k6bFDDWbyc69EGp61jKX5KEYq4OEOebS+KGqEr/6OFsN7sgWkn8+
	JepOU0NbW1gPsy3UFyfuLlDGvNwvbGzPUZuF+kGOP8HPv1geTXtPlwGk+jYKNa/r
	ySvwJ6vAMmLBxl0xXnRw+hv6A=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBXdOmGTzpqD7P7FA--.44075S2;
	Tue, 23 Jun 2026 17:19:03 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: mst@redhat.com,
	xuanzhuo@linux.alibaba.com
Cc: jasowang@redhat.com,
	edumazet@google.com,
	virtualization@lists.linux.dev,
	tanglongjun@kylinos.cn,
	lange_tang@163.com
Subject: [PATCH v2] virtio_net: disable cb when NAPI is busy-polled
Date: Tue, 23 Jun 2026 17:19:01 +0800
Message-Id: <20260623091901.118315-1-lange_tang@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXdOmGTzpqD7P7FA--.44075S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrurWfXFW8Jw17ur45WFyrCrg_yoW8JrW3pF
	43A3yUur4YqryIgan5JF4kXFyYvwn3GayfGrWF9w45uFn8GrsrtryrtFy7ta13Zrs5CFy7
	Zr4vvrWUJ3WkurJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR3EfUUUUUU=
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC-gceTGo6T4cOPwAA3C

From: Longjun Tang <tanglongjun@kylinos.cn>

When busy-poll is active, napi_schedule_prep() returns false in
virtqueue_napi_schedule(), so virtqueue_disable_cb() is skipped.
The device may keep firing irqs until reaches virtqueue_napi_complete().
Under load (received == budget), it will lead to a large number
of spurious interrupts.

Fix it by disabling the callback at the virtnet_poll() entry. This keeps
the callback off while we poll and re-enable by virtqueue_napi_complete()
when going idle.

Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>

---
V1 -> V2: Remain agnostic to busy polling
---
 drivers/net/virtio_net.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f4adcfee7a80..0a11f2b32500 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3008,6 +3008,11 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 	unsigned int xdp_xmit = 0;
 	bool napi_complete;
 
+	/* Keep callbacks suppressed for the duration of this poll,
+	 * busy-poll need.
+	 */
+	virtqueue_disable_cb(rq->vq);
+
 	virtnet_poll_cleantx(rq, budget);
 
 	received = virtnet_receive(rq, budget, &xdp_xmit);
-- 
2.43.0

