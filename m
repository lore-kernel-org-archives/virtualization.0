Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795159124;
	b=15L9JgnRsmduK4l/XApDEeVVvzM9jjcu1hmxZsYCdnWxFZcyBk5dylXibdgwFAYo3O59
	 RGrKK7yXRqU3YNvZ7hVYCdFqi4wteS8D2J1XbUTqzFI/QIeFywzs7+rRuskYpoComOZK4
	 Sa54a3+2oaKybBMi/aP0exXIJIrAzYWPPUp3vHqL2FQJvt+8a7eQMT0t2zGonHRx7iezJ
	 F94FOrWzft5aQ0K1FyprN4f03gIxOTUdD5NcvuTSPKtIcTCIZ68JgcFLcGnjp+HPDcA0b
	 5CIG68cDTw1Jd76I1M3LjdxKOeA+i7R3XY3lErfNtsv4rljvrHRoE9AQY3WKJaN/rag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795159124;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=1jg5g40uRe95QMTb7SzoqnIxvWIssVUPLqvxnjEB+Ok=;
	b=iGbXbKanA7UlbIJMPHsq5aenH2OBewVAnIeQWNDdqseInMe914lNWb6qzHNyu5Wu0fz4
	 Uz9X8CKUtE1hTlZBinmuKiud2P9+AtSGl9vHxHRcnWItIC0dFIEjD//38lIeNhRjgicG/
	 o7Z9ZT9Z50j+hSavwSYvmRjl7r+2YIt3NNNtk5KdsXT9kfNdVsMJnvLsgX0rJurnNQS0o
	 pSrLvHhI7orETvgQQ0GuAC4wfI3cn8StviH10nyowbt9LDAymTQpe5GoZ9h2Tf+TcocxV
	 E10ojKJl419996Dovuk9Gk6seyV81vFmQkqYeOjmYg0s6aTOVQ2RzelEcky4025SoZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=gJJ9Dvfx;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D307F606A331
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 07:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D307F606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=gJJ9Dvfx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=1j
	g5g40uRe95QMTb7SzoqnIxvWIssVUPLqvxnjEB+Ok=; b=gJJ9Dvfx3Y1FF84y9b
	gPbGUHrFTdb9pYljPe/2JKmAsRADTAzi/F6UUqpeb6YaF+H0jMpwH+HMN3ZiOKUc
	o8C9hbhlZG5xs/fhwOC/vPwFaWKIQ1YMkfJHoT+icVPwK1D6CUMSHbKw8GUGaXbH
	u50REKeCSNj880CPWNVONYSrM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD354ZD9P9qmowxJA--.12595S5;
	Fri, 20 Nov 2026 15:18:29 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: mst@redhat.com,
	kuba@kernel.org,
	eperezma@redhat.com,
	jasowangio@gmail.com
Cc: xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	tanglongjun@kylinos.cn
Subject: [PATCH v2 3/3] virtio_net: add stalls per-queue statistic
Date: Fri, 20 Nov 2026 15:18:26 +0800
Message-Id: <20261120071826.198604-4-lange_tang@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261120071826.198604-1-lange_tang@163.com>
References: <20261120071826.198604-1-lange_tang@163.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD354ZD9P9qmowxJA--.12595S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw1kWFW7Ar4DXry8GFWDtwb_yoW8Ww43pr
	45A342qFyrXw4xXFZ3GrWxX345Jwn3AFy7Gryaq34ruFn8Gr1FyryFgFWjkFnxArZ8ArWj
	qwsYv398Jayj9FUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jVOJ5UUUUU=
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC-QXoF2r-9EWNbQAA3D

From: Longjun Tang <tanglongjun@kylinos.cn>

Add a stalls field to the per-queue RX statistics and expose it via
ethtool. Whenever an RX queue gets stuck, the NAPI poll increments
stalls, so it counts RX queue stall events.

Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>
---
 drivers/net/virtio_net.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 15191b841a60..61d51c5a50ea 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -134,6 +134,7 @@ struct virtnet_rq_stats {
 	u64_stats_t xdp_redirects;
 	u64_stats_t xdp_drops;
 	u64_stats_t kicks;
+	u64_stats_t stalls;
 };
 
 #define VIRTNET_SQ_STAT(name, m) {name, offsetof(struct virtnet_sq_stats, m), -1}
@@ -167,6 +168,7 @@ static const struct virtnet_stat_desc virtnet_rq_stats_desc[] = {
 	VIRTNET_RQ_STAT("xdp_redirects", xdp_redirects),
 	VIRTNET_RQ_STAT("xdp_drops",     xdp_drops),
 	VIRTNET_RQ_STAT("kicks",         kicks),
+	VIRTNET_RQ_STAT("stalls",   stalls),
 };
 
 static const struct virtnet_stat_desc virtnet_sq_stats_desc_qstat[] = {
@@ -2982,6 +2984,12 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 		u64_stats_add(item, u64_stats_read(src));
 	}
 
+	/* Count a stall recovered by this poll. */
+	if (rq->watchdog.stalled) {
+		u64_stats_inc(&rq->stats.stalls);
+		rq->watchdog.stalled = false;
+	}
+
 	u64_stats_add(&rq->stats.packets, u64_stats_read(&stats.packets));
 	u64_stats_add(&rq->stats.bytes, u64_stats_read(&stats.bytes));
 	u64_stats_add(&rq->stats.alloc_fail, u64_stats_read(&stats.alloc_fail));
-- 
2.25.1

