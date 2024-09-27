Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563671C1731
	for <virtualization@lists.linux.dev>; Fri, 27 Sep 2024 15:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727452431; cv=none; b=J5SY+kfKc+HR2DDX721ELonCTTDnTKVz52p7ni8WY7iB/thk3PrK75fOLaA4xFNnLWZW1JGhQGc+UIRcZvAFdoJWzYHQTb9B6Ct8T/UvOD3d4To8SCJG4qR+tUIrMubU2gD/zHBZXepjZ8L5ukV8LOB615evPBBAxTdNwIa3ENA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727452431; c=relaxed/simple;
	bh=uboxNsRB7ArLOm3mSGXpF8THhv/G0jZ9YlhH+F8pR2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qeHtItaDR8RcrrpIjRItmtJLso//xIbxPkJloD8GzFLzGGJAptI1GOak+xr1k1GdSD5Bj04njuCvMHp5oZTA8msue3En+BbVGLaCO0FEHoXnTlTQzBTz12dNVo8fOD2v12V3KLrUAX1+UQLDdLCNnTlSRYBUFzUrA9rdpw3xIU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVf/Uko+; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVf/Uko+"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c5cc65a8abso2374731a12.3
        for <virtualization@lists.linux.dev>; Fri, 27 Sep 2024 08:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727452429; x=1728057229; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4IRmEJMqjv5amw97Du5XxRNvdkZ4L299x6VApzs7etY=;
        b=bVf/Uko+5lcMDhqLpvIntXN6OUe1CFlOCACDyLjN1sFZ/9/iCv+9XBXePPhHIppSUM
         IKwMYKkOhELMyrTI9CTHraIxkEQ53vl/c+jf4k0hKNJlXueH8ukSMdCo9JTpBN8T70h0
         dF4OFuLRVPVqnsHqYxxB7LtRP14Z6uaYO9iDtD3FLMC405+hXr1IRn8WIcH/8OIz3H8W
         +bF7B7y85/dfZIYoOZfymn87rfZb84Qteb8A+M8N4LyOYuaDHtGz3Tc3ZGDa5++jFxRT
         EeLF+uXCfSPatfk5FyZyv9OfeouKyVHXdtu0uN6Fv22zmbu4sO+JR9VS7FrggmWCEi8e
         eteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727452429; x=1728057229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4IRmEJMqjv5amw97Du5XxRNvdkZ4L299x6VApzs7etY=;
        b=UnT+3aVaJ4y7Lp8n/+SZaL0ezCr0YwNu68+H4JE0n8FNLXvnsiyr9CmRaH2w8RHvTt
         lNcjPgoO3q9uIfbx9o0P8wfjV7OXF3SgwrlP/1F/mYk1Pl8hYsed5MlIUrKpwoPEMEkU
         Lo7psLSpEPltgpHexoyoE9O6sVyMhWs3AbUxXlHKuMQyhrTXrYku/tc9muCvGfrxYjzg
         iWKqC8Tk8Z+cxalpHAR/wJs0oATP1n0pnQEvyJKbS+KeOIxFYJojC4JqcU2OrM9POa5o
         /dfL1HySNCA/WOU/O6nUVBsuV9Wk1PmbXn2nmrPOphtI+Qnyj1GkzwjBLsqkPFXRVrqp
         zKXA==
X-Forwarded-Encrypted: i=1; AJvYcCVRp1ca5wuJcvo36FX8XIKVhpPoSA70ZFohdUkyVzcxXAhyf9Lwzo5XBoOGWGwNM3ETYqtiebWMbDnRQRdWMw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4q21UXdBZyMRCFDXoRxhDSHoq4bA4QZVgfVnW5bxGsCVWfGET
	ESRB4JosverLpFecyUs2uxoXOdHgfcb6gbPgxkLtZ8Zk4fpX2VkZ
X-Google-Smtp-Source: AGHT+IHMLG4fe4vh5hjZD6liBWNFix6vxIV8H4R21+IftzrGiEu+AGKa392WyEYa/bDKIoqpw+3ssw==
X-Received: by 2002:a17:906:4fc8:b0:a8d:3338:a492 with SMTP id a640c23a62f3a-a93c48f1d78mr284887966b.7.1727452428254;
        Fri, 27 Sep 2024 08:53:48 -0700 (PDT)
Received: from alessandro-pc.station (net-37-119-37-200.cust.vodafonedsl.it. [37.119.37.200])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c297bb9bsm146918766b.168.2024.09.27.08.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 08:53:47 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	anupnewsmail@gmail.com
Subject: [PATCH] virtio: Fixes errors: uninitialized symbol
Date: Fri, 27 Sep 2024 17:53:27 +0200
Message-ID: <20240927155330.450702-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fix solves multiple Smatch static checker uninitialized errors:

drivers/virtio/virtio_ring.c:1516 virtqueue_add_packed()
error: uninitialized symbol 'prev'.

drivers/virtio/virtio_ring.c:1524 virtqueue_add_packed()
error: uninitialized symbol 'head_flags'.

drivers/virtio/virtio_ring.c:645 virtqueue_add_split()
error: uninitialized symbol 'prev'.

Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---
 drivers/virtio/virtio_ring.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index be7309b1e860..001ea503d52c 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -553,7 +553,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	struct scatterlist *sg;
 	struct vring_desc *desc;
-	unsigned int i, n, avail, descs_used, prev, err_idx;
+	unsigned int i, n, avail, descs_used, prev = 0, err_idx;
 	int head;
 	bool indirect;
 
@@ -1411,8 +1411,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	struct vring_packed_desc *desc;
 	struct scatterlist *sg;
 	unsigned int i, n, c, descs_used, err_idx;
-	__le16 head_flags, flags;
-	u16 head, id, prev, curr, avail_used_flags;
+	__le16 head_flags = 0, flags;
+	u16 head, id, prev = 0, curr, avail_used_flags;
 	int err;
 
 	START_USE(vq);
-- 
2.43.0

