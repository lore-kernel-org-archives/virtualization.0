Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C29963CB
	for <virtualization@lists.linux.dev>; Mon,  8 Apr 2024 17:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712596813; cv=none; b=l+bQSJwC1NpENjNxYSxkxaL7nzlQf73//xlPjYilgd0QQkl3+eDmspiBfbeGBqXgRVrBcgiWMb8s06mkMpZhRGwOS8pJYSUx9r/YVdW3O3Ggjr+GMCSztlXGDYCRDiiVVsPA6r6nQ2vgGlBZJ3u9HIHpDigmrr+5E1b8eiB8PWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712596813; c=relaxed/simple;
	bh=Hy01Oa3Y5fdu8NN7/m5SuXeoCQnczrFPf2fsszlfi6w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uOPan8whPWNbL3oRdmXU18MU+BCmV2ycJLuuoICw8OSb8e2+Y3cz3M2m6fD0e5giqZZl4wEyGoyr+fwktHapuhI1Qp8x4tqEyEackLMzYlx7aHQrTD5HGn+vBtjeC5Vq6zeRi9QqSKpoZ8pYzZmwumOGoX8sWEZN5OKpOUZiVLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Q2qMRw6M; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Q2qMRw6M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=8KgZ3
	HHNMS8RkaCplDDZE4ow+qt7Z9m53EL44mw1eHg=; b=Q2qMRw6MNMIQtcXGvSkpc
	K3Fn0rDl3SWr0uuip8/zNf3psgok2gk3nOtTs2+jqKJQydjKC19gMiliStoi4b4L
	wzYQgoCu8qzBpWOHsDIMS5QE43Z99o3qDC5IN4XP2HRHMqG7Ydi/Dys5/SizLn/x
	ZQXXCCHXWUtpuzjzraqoKw=
Received: from nilq-virtual-machine.. (unknown [119.123.197.58])
	by gzga-smtp-mta-g0-4 (Coremail) with SMTP id _____wDnr4V2IxRmMq4rAw--.55328S2;
	Tue, 09 Apr 2024 01:03:51 +0800 (CST)
From: "ni.liqiang" <ni_liqiang@126.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "ni.liqiang" <ni_liqiang@126.com>,
	"jin . qi" <jin.qi@zte.com.cn>,
	"ni . liqiang" <ni.liqiang@zte.com.cn>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/virtio: delayed configuration descriptor flags
Date: Tue,  9 Apr 2024 01:02:52 +0800
Message-Id: <20240408170252.13566-1-ni_liqiang@126.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnr4V2IxRmMq4rAw--.55328S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr4rZrWkCrykCw1ruFWktFb_yoW8Zw1DpF
	4qkayUJan3A3WIvan7Ca1xWayYvas3Kryru3WUW34a9rs8ZF17Ary0yFW5tr4UJF90yr18
	Zr109FyUKFykuFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEco7NUUUUU=
X-CM-SenderInfo: xqlbzxxtld0wa6rslhhfrp/1tbirxu65WVLZqSb4AAAs8

In our testing of the virtio hardware accelerator, we found that
configuring the flags of the descriptor after addr and len,
as implemented in DPDK, seems to be more friendly to the hardware.

In our Virtio hardware implementation tests, using the default
open-source code, the hardware's bulk reads ensure performance
but correctness is compromised. If we refer to the implementation code
of DPDK, placing the flags configuration of the descriptor
after addr and len, virtio backend can function properly based on
our hardware accelerator.

I am somewhat puzzled by this. From a software process perspective,
it seems that there should be no difference whether
the flags configuration of the descriptor is before or after addr and len.
However, this is not the case according to experimental test results.
We would like to know if such a change in the configuration order
is reasonable and acceptable?

Thanks.

Signed-off-by: ni.liqiang <ni_liqiang@126.com>
Reviewed-by: jin.qi <jin.qi@zte.com.cn>
Tested-by: jin.qi <jin.qi@zte.com.cn>
Cc: ni.liqiang <ni.liqiang@zte.com.cn>
---
 drivers/virtio/virtio_ring.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 6f7e5010a673..bea2c2fb084e 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1472,15 +1472,16 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 			flags = cpu_to_le16(vq->packed.avail_used_flags |
 				    (++c == total_sg ? 0 : VRING_DESC_F_NEXT) |
 				    (n < out_sgs ? 0 : VRING_DESC_F_WRITE));
-			if (i == head)
-				head_flags = flags;
-			else
-				desc[i].flags = flags;
 
 			desc[i].addr = cpu_to_le64(addr);
 			desc[i].len = cpu_to_le32(sg->length);
 			desc[i].id = cpu_to_le16(id);
 
+			if (i == head)
+				head_flags = flags;
+			else
+				desc[i].flags = flags;
+
 			if (unlikely(vq->use_dma_api)) {
 				vq->packed.desc_extra[curr].addr = addr;
 				vq->packed.desc_extra[curr].len = sg->length;
-- 
2.34.1

