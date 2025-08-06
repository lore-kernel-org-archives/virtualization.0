Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44809CA5E
	for <virtualization@lists.linux.dev>; Wed,  6 Aug 2025 12:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754484081; cv=none; b=rD8rpVX6sthprL1uISPdgHhPyR4x4GvTgsj8UrBb+Q2V8ynLxZJDwxFRKAr/ViHNPkTB2FdP9S7fsTKUzSxZaf/+BB72uxWGUTvNsk5tyGq7MJ7GT9wuymai9lTKM7khRsNWDm8sZNnEGhkrfc1NTulw/f3SnzJ4DGDx7zBp9bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754484081; c=relaxed/simple;
	bh=0m6RKSmtZTceMC/hMeAxbNr1UJYT5Y7vTvxSoI/uCxc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ISn2kHTF0WeWBAvuRia8H9muTY5qJ/JmKkmdvht7wxF9pp2fgDZkMy6j2r5yvPHtWvDHDJjw1D9ZZGfmAevZxiUJcnaGwrcPSm9RqSbjyuGKH+OFuqu+1WDjCZty86I+6tvGrwjlFXyRq4I+Av5+/EpyrnTYhv+csOtTDPBJYjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfjGO+6U; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfjGO+6U"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e69960c557so574243785a.1
        for <virtualization@lists.linux.dev>; Wed, 06 Aug 2025 05:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754484079; x=1755088879; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KR0yLxGkAlbpioT3u11ceAuwuJsnO8hfmGay7B4ZxaM=;
        b=CfjGO+6UXdk74qCJmYH3b6FvF6Vyp6GvZkeTbiZ9+F110/mPB5KEJjYqFhCiQWxtUx
         Hqnul+VYDKfqrr+AyLgY7udeKyHY2jTTrdJ6b4WuQvfm1yogtQe9wkpQ4gbjeSQ2uSc6
         kj7lYnvoGMtKJjMCKKgiqb8jAUmkbDVafP9W4YzNYmKJPsOzL7SdEoMdSGi5He6DNRpG
         z2+DhEuQ9l0l23xlGzfixS3nRPcTvDwM/fWdNw3vBc9Y15asb/f72RtrS2UydXZ3+ns1
         j99y0lpB3FU6lEvRUC5gVNbaV2jkhpILVBzYONok/cE8bd7qDB4KRs7Zl07S44Ukfsj2
         Uxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754484079; x=1755088879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KR0yLxGkAlbpioT3u11ceAuwuJsnO8hfmGay7B4ZxaM=;
        b=mhu2kGVU4lJwb7VrBkGhoH/SooKO3MgnZOFtwPnCXnHJDSccmhQ+PdkQrSerQ0EAhN
         RdWWMnZMKjOd79P0gR/Btff7wMXAw/vAyiwYE108cuJJ4jSLKh2F1DB56P/9w8pD71nT
         ESji7aNm+UirHG4Su3E/jtbnExoz0rkNZ/mi1UtY2RoMh5OfkvBoiurUIZ8knvZzXBTL
         4Zp7w0VH9OVRv/s+z5R+m9qC7nzhEEsX/mNShCFvKx0cnCOzWN230yRKIV23OfAZ4sic
         ag9AlmDE3yl0bMYqQCBusL917M65pNmuPOXSnT2DrznhpE9XTc9X8C9PU2ZkA+ohS8do
         pBPw==
X-Forwarded-Encrypted: i=1; AJvYcCWr8g6GNspUcppafNfNK7wYc7tfahCTTaU46GLZoNR4sEAoxgiyWZnzg6NIiWIHP6FAsBh0j7UtoErEZAxCqg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWFOiyUSlOUo1YSb5yaDMwgBVln11d1LcPjak07ilrG9q/zM9A
	XuTccGjsLb1cTDqvSxksaPK2BREQugvbBtk2ddP3oaDF3BtmgII7epKj
X-Gm-Gg: ASbGncvntNViQe61VN8y2lh6cXWdu7ltib40NCXsg46kdoezEijVLzSUH3G0dwbRfrB
	w2bUHJneFFx9s9Y8OTXwh7/4h/OXATQOztz7NgwcNCXWbdSQNykx8AQMBlqQeyrtrVFh9c1EVjE
	Yz4Ohro9xNBBLqRmk4QipwkJ0maj7BxTw2OkpOLysMXrmsLt3Ol26S8ruXLNsRxzhmerM68Iww1
	PKZ3VMeJgDT0pZpzHegghmeF2qUCIV3mzqj26n0qnwKoRkfWpb2EmadG//MVPI2K703NNCAt8N2
	kL54kRPihrD3HuF/iSFYNBD3ZO1UjMcUzy8beSypPx+bXiGTYor7p5nrMXLUVR8MPPOxP7yvX8t
	vEccShpMB6g8UiAxXGtX6iO2TyiMpwK27jtNjcf0sVVpiqzbfcYBiTsn0P+Xz
X-Google-Smtp-Source: AGHT+IGJKZ70Vpy5upZ6dRn0ibe/IZW4Q8veEQlyjIhFt984r5eRubl9xr71nWCiCcUFWQ2Wi1aZtg==
X-Received: by 2002:a05:620a:2893:b0:7e6:3030:e480 with SMTP id af79cd13be357-7e814e70532mr467199185a.57.1754484078881;
        Wed, 06 Aug 2025 05:41:18 -0700 (PDT)
Received: from fyre-x-redhat96-nsd-1.fyre.ibm.com ([129.41.87.0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e8040a9154sm339944085a.70.2025.08.06.05.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 05:41:18 -0700 (PDT)
From: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Subject: [PATCH] virtio_ring:  fix uninitialized symbol warnings
Date: Wed,  6 Aug 2025 05:41:01 -0700
Message-ID: <20250806124101.3574834-1-chelsyratnawat2001@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix below smatch warnings:
  virtio_ring.c:1566 virtqueue_add_packed() error: uninitialized symbol 'prev'.
  virtio_ring.c:1574 virtqueue_add_packed() error: uninitialized symbol 'head_flags'.
  virtio_ring.c:635 virtqueue_add_split() error: uninitialized symbol 'prev'.

No functional changes intended.

Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
---
 drivers/virtio/virtio_ring.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index f5062061c408..03aa08aaebed 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -540,7 +540,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	struct vring_desc_extra *extra;
 	struct scatterlist *sg;
 	struct vring_desc *desc;
-	unsigned int i, n, avail, descs_used, prev, err_idx;
+	unsigned int i, n, avail, descs_used, prev = 0, err_idx;
 	int head;
 	bool indirect;
 
@@ -1459,8 +1459,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	struct vring_packed_desc *desc;
 	struct scatterlist *sg;
 	unsigned int i, n, c, descs_used, err_idx, len;
-	__le16 head_flags, flags;
-	u16 head, id, prev, curr, avail_used_flags;
+	__le16 head_flags = 0, flags;
+	u16 head, id, prev = 0, curr, avail_used_flags;
 	int err;
 
 	START_USE(vq);
-- 
2.47.3

