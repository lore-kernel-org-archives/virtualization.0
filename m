Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3CE12B7D
	for <virtualization@lists.linux.dev>; Mon, 11 Mar 2024 08:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710145341; cv=none; b=iWkk2v7ki/yDyUIGMrLy07mcPjOlE2N0KxWJ4qSb+eSMio1WvUYsS6415VykzuUxj+1eof0Sz4lFj6nWnxaVzIXsA+VOPHb3g90CnJvjn6nk9YRInRnlEjozAN/bQoR+MXFXKMkfrBBYUGF4X3byqdJLMaH+ecq4bbMuFCC0Xfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710145341; c=relaxed/simple;
	bh=aEHday/gk4ZOCk5uAe6j6ttIaEvyriVatbOjxCBx3f8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=awT3U0utkIoKxzeuIUD797Lzfu8xM2mJsc31VZjaB34Gc0eGxQAKpeDiTQkwJ5VZKWHwtIOv7+kp2ens46knlJxAVQY403krjBMmDakhWwMZcTpXxxk61xAAd/T0b+MG02zSvMgfG8vL6hd5QjszYXxWGhcEomd4oCcPKq3uIIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=c04nRhw7; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="c04nRhw7"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710145336; h=From:To:Subject:Date:Message-Id;
	bh=qNoNgE2K/K2kPLSrwQTYJbYYAFTH3c2G9nOR3kkuC/Q=;
	b=c04nRhw778VkhEBQEBb5q8zYfbrKX5akM5l/VGKf7ZSqDwKisiJdzuV7L7QmM1GsTUNIl7HZZZwgDzkN9gQUih9YPKbWAalt/d7XOqBdk3KRTmBUzeS218R86Cp2m/tGoS3ZDc6DTB8DhY8u3ohntolFJrDAxIBB2ntWlXhU6Bc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W2Dc-HM_1710145272;
Received: from localhost.localdomain(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0W2Dc-HM_1710145272)
          by smtp.aliyun-inc.com;
          Mon, 11 Mar 2024 16:22:16 +0800
From: Xianting Tian <xianting.tian@linux.alibaba.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH] vhost: correct misleading printing information
Date: Mon, 11 Mar 2024 16:21:09 +0800
Message-Id: <20240311082109.46773-1-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Guest moved avail idx not used idx when we need to print log if
'(vq->avail_idx - last_avail_idx) > vq->num', so fix it.

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 drivers/vhost/vhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 045f666b4f12..1f3604c79394 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2515,7 +2515,7 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 		vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
 
 		if (unlikely((u16)(vq->avail_idx - last_avail_idx) > vq->num)) {
-			vq_err(vq, "Guest moved used index from %u to %u",
+			vq_err(vq, "Guest moved avail index from %u to %u",
 				last_avail_idx, vq->avail_idx);
 			return -EFAULT;
 		}
-- 
2.17.1

