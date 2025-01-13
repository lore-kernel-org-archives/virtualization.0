Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CF9239790
	for <virtualization@lists.linux.dev>; Mon, 13 Jan 2025 09:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736758961; cv=none; b=mLtP9e9K9709rlHhQi8pWKdHHBw6o5m/abrBWK6JbodccXyONoYKHHBA+s9GXPeQwJ8N4U/AZ75hAekAyD+4kTcxZiSoIproUcCSx/xN4BRW7ZmZPeJJq8wBUDpRK3OEylGG33ioR/EtDZuXCSqnFIMZ0mcoVn74IaI1UE2dGh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736758961; c=relaxed/simple;
	bh=ZRZgcpXF9Vo0iBoHpWONsJSAS38Qr0n6xxFQha2z6YE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=iEGWF0DQ6mzscRKkJs9sWiQ0sGqQUKbKcz9+ABcLJ7Zuq2bujXUSQg04nSItSeONBbChKEHU8Ou75HYROcSXzvnGX4K1mLLRBKla/0bmCzOJ42A0I5k31g5hhKzJaH1JekrHByWEu0wyyfQfBp8XIAKIJyqXTkjrGE7A2mnef9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 217557bcd18d11efa216b1d71e6e1362-20250113
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:4a8c3d47-dee4-4261-8cf4-e46c1c4f34b5,IP:0,U
	RL:0,TC:0,Content:-5,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-30
X-CID-META: VersionHash:6493067,CLOUDID:404b033aa65253e43479dc516a56b303,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:1,IP:nil,URL
	:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SP
	R:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 217557bcd18d11efa216b1d71e6e1362-20250113
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <wangyufeng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 430005671; Mon, 13 Jan 2025 17:02:35 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 2E3FEB803947;
	Mon, 13 Jan 2025 17:02:35 +0800 (CST)
X-ns-mid: postfix-6784D6AB-164362288
Received: from localhost.localdomain (unknown [10.42.12.106])
	by node2.com.cn (NSMail) with ESMTPA id 1EEA4B803947;
	Mon, 13 Jan 2025 09:02:33 +0000 (UTC)
From: Yufeng Wang <wangyufeng@kylinos.cn>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Yufeng Wang <wangyufeng@kylinos.cn>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tools/virtio: Add DMA_MAPPING_ERROR define for virtio test
Date: Mon, 13 Jan 2025 17:02:31 +0800
Message-Id: <20250113090231.169149-1-wangyufeng@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fixes: <c7e1b422afac>("virtio_ring: perform premapped operations based on=
 per-buffer")
also add DMA_MAPPING_ERROR define for virtio test.

Signed-off-by: Yufeng Wang <wangyufeng@kylinos.cn>
---
 tools/virtio/linux/dma-mapping.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/virtio/linux/dma-mapping.h b/tools/virtio/linux/dma-ma=
pping.h
index 822ecaa8e4df..6e6e443c53d4 100644
--- a/tools/virtio/linux/dma-mapping.h
+++ b/tools/virtio/linux/dma-mapping.h
@@ -43,4 +43,16 @@ enum dma_data_direction {
 } while (0)
 #define dma_max_mapping_size(...) SIZE_MAX
=20
+/*
+ * A dma_addr_t can hold any valid DMA or bus address for the platform. =
 It can
+ * be given to a device to use as a DMA source or target.  It is specifi=
c to a
+ * given device and there may be a translation between the CPU physical =
address
+ * space and the bus address space.
+ *
+ * DMA_MAPPING_ERROR is the magic error code if a mapping failed.  It sh=
ould not
+ * be used directly in drivers, but checked for using dma_mapping_error(=
)
+ * instead.
+ */
+#define DMA_MAPPING_ERROR		(~(dma_addr_t)0)
+
 #endif
--=20
2.34.1

