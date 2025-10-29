Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44611D63F7
	for <virtualization@lists.linux.dev>; Wed, 29 Oct 2025 03:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761708982; cv=none; b=OtzEukzXjKeWnWdLnYwlGms5yhJ9bpQjNz4617NIJP8N7Al10Yx/NE71/lRzeEafITejQtrnaN3ZJtrARF4e2WnSGgYZRJJWyJWHaM17dRQ+7kWX3gOg8w5g+Kd3hm7sb/s7SwDJA0eJq9ZtlGQELT6f8LYxyGF0jTV9+3r8ons=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761708982; c=relaxed/simple;
	bh=JjeI8UAzfBC854auP7OdUILptuEOBu9o+fyhFZjyqrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tNa8eafDxWgUhm6jeSmVc0V3DQLVCXlydbGAy76bdhmB1ri7MMgxE8c0i+CfRSewEooyJ+HybCc/rQghBG8YUW3cMei4NPlFIpYcEBKtY8zqQMzUcaCK8sireL5+aurAUAlivuWCFeeMLfc+xrtZiygpBBAZuEWlBPPH6RSUM3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgLaH5Oa; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgLaH5Oa"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29470bc80ceso7861595ad.1
        for <virtualization@lists.linux.dev>; Tue, 28 Oct 2025 20:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761708980; x=1762313780; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4KFQRQSGfTM2DCXucYOUjxAN7CzQGIAPT4+vm618YSs=;
        b=bgLaH5Oai3rWZwGu7GClOpakDpHJfVnFVmyXXh6nKtQQ0Mqzyg2hatufLEhbxEsNfp
         KX9a2cIVwLJOhScmFwAH6s6fgUaNcBG32rR8Q12Mq9kA6W48aeTwDVsg8w/HUc4L76Un
         0AeyR/bheMRuzvamAo8bhRpbzmCi3wfyMPMQY3l2ynn+1t7+wO4TduJ/eAtto6/41cpS
         4tAXnbvSJeZX/nAQzeIzcSVLCINpml5Tw/RsejxB+5xkyAH5mPnO9TzdTpIfiStmySq9
         HwT6kvgaWtIByldehG831AnAAORZkUcN5Jvm9mmTrGxNZAlb8q2UBfYsV+wZwOL5paUc
         HM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761708980; x=1762313780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4KFQRQSGfTM2DCXucYOUjxAN7CzQGIAPT4+vm618YSs=;
        b=gPotbZr0+DbGohkKNnFBeRwq2MUy8vRN/8ACI5HkKHK2Ln6Oa16irFltzrpTDbvsVJ
         yB+c3+fsWIICqgR7KljrC7O2cXwFU9tO4nllNib2dU28IRo8y3oMGA7CUMQEfMA07Zxu
         hL1ub5f3pPR1JG7DX99menCblT1yhkZpRR2TebyUmykOQ2LoUrgOn0TTj+znQ1oYYjZS
         /WzWE3rGdwNRpqMHcEVjwXQUBCv1WQz79Dyb3AFk4gnDdDDPOQxNGn+ZbHXPqD6w3O42
         n14fH/WHjv8Jk5//dEQXhb8oYLUWcI20OwLYmwkj5Vt35E8GtW9YoNBp5y764RB2VB3N
         jx7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVbXsSm3OCR0dWTDVYt8wf2ZgefcfTXFUmFGUhrzaC0GXjVCfuaC0VMRKlJDSL4PWZ2C4C0DJ6P2VAovKrUug==@lists.linux.dev
X-Gm-Message-State: AOJu0YxHFAvsy4kGpbB4e5ftSEtyka16rJWDggBvLlT8s8F6N+x2qbM9
	lgMdHIF7765UU6LFCgXNGWTF2oRx8UdHxtpZqIkSuCyF5hkdTLrlSHT7
X-Gm-Gg: ASbGncsPA+P5HRVoagk9N+f1AeAGoNbmvEoX6S/gdUoNQk6dQP7zVzoMEMDpHOXFuRp
	YO1CFSxzGwSu/4wUodOOMrfwis5c85w9E1SSwmxD6J83htXYhxh1MCL6UHWOXWiRl1IwzgwvI01
	k8o4h9Jca5KVX5KiwX+791mlHobybbFUHbdtSw64m3GRTB4SgVjkT3t2i/ABsMMnHpLr3MtIOA4
	FdpF4/yF15L8PZwYuqRVnNAnJyLTGy9q4Hs08KRV+dGDtGzDS6DTFPE58Fy6/BbpPWeXBzpLrM7
	b33nSdsEc0d+rte8hlp3iYVXQIPNKwlQNs/ZRx/8MzKC6Vhq92qJ47ZHu6yMMAlAKWDUdDJhljG
	9ye1n4GeSATxEgD/qi4W7plII3UBk0DQCccCR7ZH/CgrFWmKnAXwMIaGtaTTkbDpbAMUVwA==
X-Google-Smtp-Source: AGHT+IESE7CJsQY/WY628QryMAKelqQ/Edj6cNUuCksIAiMU46Z8F5oD6rzOrts+HuduuM1Ib5/7Hw==
X-Received: by 2002:a17:902:fc4e:b0:27d:6cb6:f7c2 with SMTP id d9443c01a7336-294de9cf938mr17416625ad.17.1761708980026;
        Tue, 28 Oct 2025 20:36:20 -0700 (PDT)
Received: from hsukr3.. ([2405:201:d019:4872:4680:8a:2bce:378c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d40b50sm135972885ad.75.2025.10.28.20.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 20:36:19 -0700 (PDT)
From: Sukrut Heroorkar <hsukrut3@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: shuah@kernel.org,
	david.hunter.linux@gmail.com,
	Sukrut Heroorkar <hsukrut3@gmail.com>
Subject: [PATCH] virtio: document @vaddr in virtqueue_map_free_coherent kernel-doc comment
Date: Wed, 29 Oct 2025 09:05:58 +0530
Message-ID: <20251029033559.83145-1-hsukrut3@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Building with W=1 reports:
Warning: drivers/virtio/virtio_ring.c:3174 function parameter 'vaddr'
not described in 'virtqueue_map_free_coherent'

The @vaddr parameter was introduced when virtqueue_map_free_coherent
was added in order to provide map operations to virtio device, but it
was never documented. Document @vaddr to silence this warning.

Fixes: bee8c7c24b73 ("virtio: introduce map ops in virtio core")
Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
---
 drivers/virtio/virtio_ring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 7b6205253b46..d763060ff0f6 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -3166,6 +3166,7 @@ EXPORT_SYMBOL_GPL(virtqueue_map_alloc_coherent);
  * @vdev: the virtio device we are talking to
  * @map: metadata for performing mapping
  * @size: the size of the buffer
+ * @vaddr: virtual address of the buffer
  * @map_handle: the mapped address that needs to be freed
  *
  */
-- 
2.43.0

