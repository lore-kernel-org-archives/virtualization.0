Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3569138AC8B
	for <virtualization@lists.linux.dev>; Wed, 24 Jun 2026 07:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782284550; cv=none; b=jm3rj79tOBAS2oiajq0t1nqvORaKtz3d/dq6trHHZ+WiesvQ5Q82NwVw2bgl9/QNca0t2edYhLeV2OYyxbhGE1y+y0Wf17g8oDAIg2xTbQnSlOiQNWbwNkr3sCDFNaUgR/tX9BDi5I/zbrUPa0jeKLoFPDD9iEjuHK3cj7ng/jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782284550; c=relaxed/simple;
	bh=AaiSMsjBNVaqKw1hGHPQ/DFuSr+ZSaSOAtSUiE5AjbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e79phe5uGo8n1nDbM0VKP/62gfKfcxMtqNh0lbLrhwks5FG4IPIahayvLyK1XnI0QRiDYU2y62ry1e/P7WRLKCGrcuf+qPAxb6XJa9pb26IOWcHA7UCfnvVjbf28+VyirKu5HfzqFSBOGK7HI8v+5x0DOFDrhdBWNiE6+/6+PJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WR/5Y7qG; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WR/5Y7qG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=hM
	iF6qCF7o2uVxPbbEn3QEJ84LjMiBA8PLAiF/udl5U=; b=WR/5Y7qGLCedtOBl8i
	JMRVVc8uscejfA/xvwn/xFt1JIHaNAQdj9IW2KV75gitxcKdy2Hq8vdNUZvZIFDa
	juICKUZJYyE6wV6PtPsMp0MGOap8NdjwWE8xNZfNRm5l69B53EEDUYBxf5PuTVUm
	8DzEzxshd0G2LDjJ49kEerXyQ=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgBXEyfvgDtq+E5qDw--.41034S2;
	Wed, 24 Jun 2026 15:02:09 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: mst@redhat.com,
	xuanzhuo@linux.alibaba.com
Cc: jasowang@redhat.com,
	edumazet@google.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	tanglongjun@kylinos.cn,
	lange_tang@163.com
Subject: [PATCH v3] virtio_net: disable cb when NAPI is busy-polled
Date: Wed, 24 Jun 2026 15:02:06 +0800
Message-Id: <20260624070206.85467-1-lange_tang@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgBXEyfvgDtq+E5qDw--.41034S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw48WFWUXF4UurWxCw1xXwb_yoW8GF1kpF
	42k3yUurn0qryIqan5JF48XFyY93Z3GayfG3yY9w45uFs8trnxtryrtFy2ya1avrs5CFy3
	Zr4vvryUG3WkuFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRvfOOUUUUU=
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC-RHF82o7gPFIZwAA3V

From: Longjun Tang <tanglongjun@kylinos.cn>

When busy-poll is active, napi_schedule_prep() returns false in
virtqueue_napi_schedule(), so virtqueue_disable_cb() is skipped.
The device may keep firing irqs until reaches virtqueue_napi_complete().
Under load (received == budget), it will lead to a large number
of spurious interrupts.

Fix it by disabling the callback at the virtnet_poll() entry. This keeps
the callback off while we poll and re-enable by virtqueue_napi_complete()
when going idle.

Fixes: ceef438d613f ("virtio_net: remove custom busy_poll")
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>

---
V1 -> V2: Remain agnostic to busy polling
V2 -> V3: Add fixes tag
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

