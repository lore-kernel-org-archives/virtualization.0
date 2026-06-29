Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0A31B86C7
	for <virtualization@lists.linux.dev>; Mon, 29 Jun 2026 02:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782700981; cv=none; b=ZlCFMX5OuYuGCoCka6hXxhGZ//cIg5p0FdsnWCp2m6f8eX4dKqTLkxpf/JoBnrwdTxFOopYWO/aVJIBtkDwUcvYa/WWzhfTHziZhfwzhgyyMjvmDiYWu6NHz/r4CnI0l9jLlP4rRkSi4fcMXlY6KKLbmJaYmRiS+esBjmK26D2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782700981; c=relaxed/simple;
	bh=aYJDqLIeV5q8b+zEeZhiM2ZS/viJ0guXPqKcx31X8Cs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cPcxdRJYOgIQknMZWpp7uaIhWYgLefr9zbORmmZKbjxrP1N1A7lBOgJNmbQ7icgZ4Pfspn0AI92QO2Lfl/xZp27pgwQALGhL/KmSLqRePOnkMuvEoa1F1C5GXPzdbmp9+wYYSUiNw6K3UVIc7lkLIu27dCjKATE4El2YbAQlnqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bSzpDgkb; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bSzpDgkb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=g7
	a55kAaxhsU365SUmAyh7UxCGqz2b8SqA464g6a+RU=; b=bSzpDgkbSJMaTkkULA
	ILF9NGngKRadWxguhODVgihdHGNY571sS/KhUvtMvnRp/5TLV4Fm/5P3Y2EBnfSp
	e+qph6TwZ/SqOn9vefUCw9iBTHfV/p03qeNBuJ8XxE3zXiO6DOCb646Cw9ccBr0y
	bGNr5lDS1GAQRZ4bFdiRj4670=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgB3WgKY20FqvwrtEw--.20426S2;
	Mon, 29 Jun 2026 10:42:32 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: kuba@kernel.org,
	horms@kernel.org
Cc: mst@redhat.com,
	jasowang@redhat.com,
	edumazet@google.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	tanglongjun@kylinos.cn,
	lange_tang@163.com
Subject: [PATCH v5] virtio_net: disable cb when NAPI is busy-polled
Date: Mon, 29 Jun 2026 10:42:30 +0800
Message-Id: <20260629024230.37325-1-lange_tang@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgB3WgKY20FqvwrtEw--.20426S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw48WFWUXF4UurWxCF4kZwb_yoW8Gw4UpF
	4ay34Uurn0qry2qa18JF48XFy5uwn7GayfGw4Y9w45uFn0yrnxJryFyFyUAa1avrs5Ja43
	ZFsYvryUWF109FJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUUrcsUUUUU=
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC4RgINmpB25gsrAAA3v

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
V4 -> V5: Guard disable_cb with budget to avoid netpoll stall
V3 -> V4: Update commit message and remove some comments
V2 -> V3: Add fixes tag
V1 -> V2: Remain agnostic to busy polling
---
 drivers/net/virtio_net.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7d2eeb9b1226..0b3f1bb227d2 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3008,6 +3008,9 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 	unsigned int xdp_xmit = 0;
 	bool napi_complete;
 
+	if (budget)
+		virtqueue_disable_cb(rq->vq);
+
 	virtnet_poll_cleantx(rq, budget);
 
 	received = virtnet_receive(rq, budget, &xdp_xmit);
-- 
2.43.0

