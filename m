Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com [209.85.160.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21F51A23A4
	for <virtualization@lists.linux.dev>; Tue, 27 Jan 2026 00:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769473370; cv=none; b=BfRMASBlTx6TsUBcXE2XMpfhKA2ne9qQirxLoQuOrn7u6Y3HcrAKWl0KDzdQt3ohF3r2P0MGop25+iz87D7WJYiGKy1ATSDRQyU6fRNg0tomAodnYyzPRWVxUg9XRfHPZ/SXp9jXy43n8UZk1+88A3qRlS3koXd1CRjT8mxlb8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769473370; c=relaxed/simple;
	bh=Aqmmw/ujtV1agXkvxCKU3nG6cvs+wyfXaMmgogDqLeo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nqHRgUG3vdua0915hJFFluEJ1L856u2KTu1VcqmsPuKe3QldfNnzwSGqpwdFukvNdhmVoG2agcIRJETJdz7lS7l0Ks4ywORg/+dgwC0owRiL8BVawPsGZvsfykY0IidGXisOllqBpLGYLamhhxLGO+8NcB80LIilhlz3xH9F4wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afHExnL6; arc=none smtp.client-ip=209.85.160.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afHExnL6"
Received: by mail-qt1-f193.google.com with SMTP id d75a77b69052e-5014e1312c6so32355001cf.2
        for <virtualization@lists.linux.dev>; Mon, 26 Jan 2026 16:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769473368; x=1770078168; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H7FSGPEylR/S8ORzUfzpVRMZ5OAAgnwAPOwAD4vCrfQ=;
        b=afHExnL6Z7yjzjQ6ks2FqvBe6Uj/yxDGuWRrd2GTgk3fN2pkyVa+6xqkN+9jS/LHYW
         XG0bzzysreX3bVLODeIe2jQKLfy+Wm3t9n18xG0pMHU42Wgd2a5yJmr1JNPCjh3o14wE
         d6U+Mar2iaSVDCv+vQkjdC/BtFO8WGlEH56xg71D3c4dVy/7VX24UhQNIWVmbyX/nBvz
         FOEWFPa9egJkXpR4/K3aj3IjQgnxcwxsQyizB5Hc3neqwoMIpD5R3zkTuR5g4T0UMJGW
         /vkgCHyYWC0rGp/5phno9bang90UWNT4DxB1168hS7uqJlhWYaDHjk7t1x0fNQGkAkZ/
         6lgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769473368; x=1770078168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7FSGPEylR/S8ORzUfzpVRMZ5OAAgnwAPOwAD4vCrfQ=;
        b=eSOCEHuQAEJknpBoVXaYDAmzJY+PIP0wl5b8/hxijBFUUqUu3yeB9bSbLdRNOdUld1
         psiErQ0hERQjwYefoOZb2+Vg9LQSFbDNeP1u2dcHBqyCzIB3vVbDPPKST4tl+nz4aTSr
         y/GFa+sb/iLOQNWpOEP+cOaTq4BVfHzlhF8I2oSS5xgp6HAI2VvL7/kFnAPgAVOaNwuH
         F09twW7P5ebZafqz0xSPnnqWPaFw2JWAi2cO0BMwvecEhQmDAv3sfpIaKu/kbMbxvOsG
         1RB2gM0YIBN+JUWpSwP0clsr5L/S6ORsE6okusUrSCJzodTxDY/R9nWtV9ui/R8lZuK8
         kT0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3JNhNryNDcqSmueMl48tP+ePu19IXC3MPC1sZ8J0cpRwmXJafThjr5jDOyrlLI0raNFtrWobsLgFGWP+BQg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZ235JTVRKObywITxF2Vnwhww7mJemrslDbCD1TSUFbLa4dAXw
	VQB2D6T6p1Eoanif25DHHdx/MAoGwvf99mjVtGNUPqyECU+Pg7iVnA4Q
X-Gm-Gg: AZuq6aLIj0872alQKV3fbGolY9gUEwTsr27lG95V2mVkV94PZlmaO2bL51dp0VRdkME
	B2lp0my3ZevfpbTv+KkLll6QOqev9C+zbpmIJohMocZvF5bgYYPmf3KHD+Fpu2t6H/6JrL0N23k
	2cpGdheXSHq1XdAtJNGeEEMLykS8SVv2x4MFgkogtmfJvC13pTmmp1PGwrCIGTshJrBmUNyRwiD
	N7ykog43T+OEsGEbxCv3yjC9rhRtcdr6BrMb0YIpWBl3c+ybDESVpNhXaDSfAuEed0zc/r3ZknH
	bmfTExmlqx6cy6nvZTazWb1ybqtkQhEbtC4wOM6ruvQv0W9FlqEKujAzm+TZc7AowiOmmNXjdbB
	r+6tiPS4DI7x+UTuuOFeov1MzR4RrqBO9iGN3qxOBVyWTVJv560bH7xh4dwYrnL9Wg3/EOY4=
X-Received: by 2002:ac8:5a84:0:b0:4ee:2200:409e with SMTP id d75a77b69052e-50314ba3cd1mr76172451cf.4.1769473368536;
        Mon, 26 Jan 2026 16:22:48 -0800 (PST)
Received: from r730.. ([46.110.19.170])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6e3853da0sm1155496285a.37.2026.01.26.16.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 16:22:48 -0800 (PST)
From: Henry Zhang <henryzhangjcle@gmail.com>
X-Google-Original-From: Henry Zhang <zeri@umich.edu>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Henry Zhang <zeri@umich.edu>
Subject: [PATCH] virtio: document map and vmap fields in struct virtio_device
Date: Mon, 26 Jan 2026 19:21:22 -0500
Message-Id: <20260127002122.1356964-1-zeri@umich.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These fields were added in commit bee8c7c24b73 ("virtio: introduce map
ops in virtio core") but the kernel-doc comments weren't updated.

Signed-off-by: Henry Zhang <zeri@umich.edu>
---
 include/linux/virtio.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 63bb05ece8c5..b8e791f7b687 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -157,11 +157,13 @@ struct virtio_admin_cmd {
  * @id: the device type identification (used to match it with a driver).
  * @config: the configuration ops for this device.
  * @vringh_config: configuration ops for host vrings.
+ * @map: memory mapping operations, or NULL to use DMA API.
  * @vqs: the list of virtqueues for this device.
  * @features: the 64 lower features supported by both driver and device.
  * @features_array: the full features space supported by both driver and
  *		    device.
  * @priv: private pointer for the driver's use.
+ * @vmap: context for @map operations.
  * @debugfs_dir: debugfs directory entry.
  * @debugfs_filter_features: features to be filtered set by debugfs.
  */
-- 
2.34.1

