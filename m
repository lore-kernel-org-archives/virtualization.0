Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CF43C3F6A
	for <virtualization@lists.linux.dev>; Mon, 10 Aug 2026 11:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786363038; cv=none; b=CK/p4zcn73MjZOlPfnhz23/0deMNNyk/3It1UE3LUnbdvqxVOxkZLgBWy+pHuVt27ooGQqhcpG6dU/RLJUoUkl69FCBYY/xdBuL5piT3Xmh5np5KEcTD6qeuSRe0nvy6OHHQTbJaj6oDS0SXtgV5zTXRhhnS8YF18UKn6pocX4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786363038; c=relaxed/simple;
	bh=FaheUX33TRJ4qYN53f+S4rMRfVUaGE8qHSXgcixbUww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sPillsyYd81LViuJ08Il2Zdms0OZWa8kKQsToINz1kVB769FNRmBoAyNfWWejQ+NFaGigaMZKhUGnSrWNlAtH4RmFwB48aant83tOTd8GCEmPVY4p2TH7lwC/O5L0ok31zatciCFXCjXoz3wQUTjsrun61am+WJ1X1QH7WPmdLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bLlpIrPp; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLlpIrPp"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso12109705e9.1
        for <virtualization@lists.linux.dev>; Mon, 10 Aug 2026 04:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786363034; x=1786967834; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lTRbu60u5fOzuvM1p0IBRxQ+W8tiNJ4MYzXEdegdXNo=;
        b=bLlpIrPptaQ8kr/10NTtXCb/AOxM/K6JRHpdgtbhyQ/SOgFt8LXHJoRA+mF3xNWFyo
         gFT7udJmytJadl7k5jWnpUejjvLZFbXaqndKyNr6x9FwYlvasxYRrE+d0UNSO6/IMlfK
         4CzD7jWIIjaisNbHO3EBJbl7RzzWCu04pcROeWXtqhkw0MtEKc6p196Fp3kw0yL1s2I9
         bogvFE7tHKWPZ4H7YMiZaySGaosH4Pa/vhkZSM2N+WUnRB8Z4TVTeYqRW1CTShq9wps0
         n+zgnMCnKwv1ECOUakxNgZ6jCaYgEIprGBDGsqINuZt29tbsc8FDW2IW+jhQ7/xmZMpn
         Fsug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786363034; x=1786967834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lTRbu60u5fOzuvM1p0IBRxQ+W8tiNJ4MYzXEdegdXNo=;
        b=gZua7h+uYlcRfXfkbkFCBWegrOxOKZVMTFKaOdogIaDcyQmRrY6YLMiDCsgBTAv2JJ
         ez7DImbEuTwrBUCh749xZ0yYsLi3/AUnoSp7l4SqoXnu5ZHJXNpyw64fX+S98dlac08G
         7y+ExdF8+J0lKDUL4l/I1r3ickvexT+w9U6/6aI0Mq+jXgyOEPUMsW4VQHEowjFFFrjH
         GOzaDHiX8tP0rWAebFVAbjSICN0RupqaQwZEquesS4fLBqt2G8vL5lSDm8pyTwNp8YO9
         gMXSFC0saxTng5lZ/jyAyFe1yVPBAIXYCAF4MkXBYqli91jfEAckmV0VfZJDUlRNFdFj
         yBkA==
X-Forwarded-Encrypted: i=1; AHgh+Romyqg5ex5fwV2yGCtptz2N9g+Uygtk71joOaxKh6gsEgQQPqVF5epfHWE8d+YVsrjWyIFFq8xM+57CbKQgDQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwsML3pJnftrIuLatKaGpgeKn0A0s3/G13xEztYpNUrekxBn+Jw
	mvyd1/8tJXg4h6lawRESg6pqZFPvhzaBGMJWA6sPa23GuHPJG+hSty6u
X-Gm-Gg: AR+sD10ThM6zJZIJ6MkQORje0h1pedpOB9b96WupbZ7OZW5pWZZC1EMC2jSiUqZD87K
	iamN7nCx07Y1UvhDe0R/If/ussuNKwy5Q4Bd1O3+KnYAMyQYRQxXlNYdcVL5bt6aR3WRAg8eKTj
	rSFt5pha6GDakyIb2L9Ry4Smuww/rZbOGllfnRu8aDfuwBgL80BOmcgaJ0MYmPOh2+zjAIPtHyo
	p65P1uk9GeMicYY2dxJBTw6bhuuB0TalA0vf5Gj2HtkvYLyFg3Z8IGoWTf21GCDmT9njuip7M8C
	a7yMKRl51vaIeJMXpU39+anf/kux5f1EWvJraO/G73OByYczzbnKKepjsEm3uo+6RzLWYe2n73W
	Rxm/a9RXE+HbV/rdMoyz7o4UVjiezFOb9piTPesjk9QtzRqAq3wspgHanC0DKbMWxJfVA1sRqBa
	v9mAhZ9qzPYU/xOMC1491o9kxPKQtM0f0ZPLgwT/ZqRWRFL26GYef51QU9AVRgIPQh8qgUKC+st
	s/LkmA60XBDvHUAsB1VCFvklBnMkA==
X-Received: by 2002:a05:600c:470a:b0:495:6338:1453 with SMTP id 5b1f17b1804b1-499727a866amr14257735e9.16.1786363033266;
        Mon, 10 Aug 2026 04:57:13 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021f9182sm34997090f8f.28.2026.08.10.04.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 04:57:12 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH net] virtio_net: Fix resize of the RX ring
Date: Mon, 10 Aug 2026 12:07:25 +0000
Message-ID: <20260810120728.47445-1-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a AF_XDP socket is attached, the virtnet_rx_resize
should resize the rq->xsk_buffs XSK buffer array. Otherwise,
when the size grows, the virtnet_rx_resume() causes a write
past the end of the array. This is easily reproducable with

    ethtool -G ens3 rx 32
    ./xdpsock -i eth0 -q 0 -r -z &
    ethtool -G eth0 rx 256

Fixes: e9f3962441c0 ("virtio_net: xsk: rx: support fill with xsk buffer")
Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 drivers/net/virtio_net.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3e2a5876c6c8..e34c52d059d3 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3444,17 +3444,31 @@ static void virtnet_rx_resume_all(struct virtnet_info *vi)
 static int virtnet_rx_resize(struct virtnet_info *vi,
 			     struct receive_queue *rq, u32 ring_num)
 {
+	unsigned int old_ring_num = virtqueue_get_vring_size(rq->vq);
+	struct xdp_buff **tmp_xsk_buffs = NULL;
 	int err, qindex;
 
 	qindex = rq - vi->rq;
 
+	if (rq->xsk_pool && ring_num > old_ring_num) {
+		tmp_xsk_buffs = kvzalloc_objs(*tmp_xsk_buffs, ring_num);
+		if (!tmp_xsk_buffs)
+			return -ENOMEM;
+	}
+
 	virtnet_rx_pause(vi, rq);
 
 	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_unmap_free_buf, NULL);
+
+	/* virtqueue_resize may have changed the size even if err != 0 */
+	if (tmp_xsk_buffs && virtqueue_get_vring_size(rq->vq) > old_ring_num)
+		swap(rq->xsk_buffs, tmp_xsk_buffs);
+
 	if (err)
 		netdev_err(vi->dev, "resize rx fail: rx queue index: %d err: %d\n", qindex, err);
 
 	virtnet_rx_resume(vi, rq, true);
+	kvfree(tmp_xsk_buffs);
 	return err;
 }
 
-- 
2.43.0

