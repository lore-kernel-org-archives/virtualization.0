Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFC61FDA78
	for <virtualization@lists.linux.dev>; Mon, 13 Jan 2025 10:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736762591; cv=none; b=L7L3zFLRpjOHOdYyk2E3KKbIgVaE8ZQvW4A4MlLwJwLGCwomDfh09RuoTwq4Eq34mJqhYP2QXbb0jVTOmN6MVa01zoRJ/TbQt2XI+M6S//A0Z5090XFoB+PTzRF5LkhHrHW23VtWu0pGQBrEd/JpyI3npjuc7vfvl2usvyL2Q0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736762591; c=relaxed/simple;
	bh=I0iLGLoingivba6W6nV+6WOB5RMn6wMHhgUaf69LrZU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A5lwLb2uaxvT+lAumSDTJfzr9V4cTl4P8Y6dwZT1L/opwh7j9RLqXL0Kl4FXFaddJB+XFkL9LoxOY7tijgGbiIsvIt6IP4GsN8eNeQfDb9bd2uhix/j++/tUOlzBx8LTGHqAePHpqi+RjXjDY3J14McLovDoraPbAjOMQ3aQWOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9432dcccd19511efa216b1d71e6e1362-20250113
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:89d1d8f5-cc7a-49c3-a1dc-8a732374dea8,IP:0,U
	RL:0,TC:0,Content:-25,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-55
X-CID-META: VersionHash:6493067,CLOUDID:49d59e2f298ddd97acdf809673a998b8,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:2,IP:n
	il,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
	S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9432dcccd19511efa216b1d71e6e1362-20250113
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <wangyufeng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 138486490; Mon, 13 Jan 2025 18:03:03 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id A5E0CB803CA2;
	Mon, 13 Jan 2025 18:03:03 +0800 (CST)
X-ns-mid: postfix-6784E4D7-5499562680
Received: from localhost.localdomain (unknown [10.42.12.106])
	by node2.com.cn (NSMail) with ESMTPA id EB3CCB803CA2;
	Mon, 13 Jan 2025 10:03:02 +0000 (UTC)
From: Yufeng Wang <wangyufeng@kylinos.cn>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Yufeng Wang <wangyufeng@kylinos.cn>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] tools/virtio: Add DMA_MAPPING_ERROR and sg_dma_len api define for virtio test
Date: Mon, 13 Jan 2025 18:03:00 +0800
Message-Id: <20250113100300.174382-1-wangyufeng@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250113090231.169149-1-wangyufeng@kylinos.cn>
References: <20250113090231.169149-1-wangyufeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

when we build tools/virtio, meet below error information.

cc -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/
-I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow
-fno-strict-aliasing -fno-common -MMD
-U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h
-mfunction-return=3Dthunk
-fcf-protection=3Dnone -mindirect-branch-register -pthread
-c -o virtio_ring.o ../../drivers/virtio/virtio_ring.c

../../drivers/virtio/virtio_ring.c: in function 'vring_need_unmap_buffer'=
:
../../drivers/virtio/virtio_ring.c:294:54: error:'DMA_MAPPING_ERROR'Undec=
lared (first use within this function)
  294 |         return vring->use_dma_api && (extra->addr !=3D DMA_MAPPIN=
G_ERROR);
      |                                                      ^~~~~~~~~~~~=
~~~~~
../../drivers/virtio/virtio_ring.c:294:54: Note: Each undeclared identifi=
er is only reported once within the function it appears in
../../drivers/virtio/virtio_ring.c: in function 'vring_map_one_sg':
../../drivers/virtio/virtio_ring.c:369:24: error=EF=BC=9AImplicit declara=
tion function'sg_dma_len' [-Wimplicit-function-declaration]
  369 |                 *len =3D sg_dma_len(sg);
      |                        ^~~~~~~~~~
../../drivers/virtio/virtio_ring.c: in function'virtqueue_add_desc_split'=
:
../../drivers/virtio/virtio_ring.c:518:37: error:'DMA_MAPPING_ERROR'Undec=
lared (first use within this function)
  518 |         extra[i].addr =3D premapped ? DMA_MAPPING_ERROR : addr;
      |                                     ^~~~~~~~~~~~~~~~~
../../drivers/virtio/virtio_ring.c: in function'virtqueue_add_indirect_pa=
cked':
../../drivers/virtio/virtio_ring.c:1370:61: error: 'DMA_MAPPING_ERROR'Und=
eclared (first use within this function)
 1370 |                             extra[i].addr =3D premapped ? DMA_MAP=
PING_ERROR : addr;
      |                                                         ^~~~~~~~~=
~~~~~~~~

../../drivers/virtio/virtio_ring.c: in function'virtqueue_add_packed':
../../drivers/virtio/virtio_ring.c:1535:41: error:'DMA_MAPPING_ERROR'Unde=
clared (first use within this function)
 1535 |                                         DMA_MAPPING_ERROR : addr;
      |                                         ^~~~~~~~~~~~~~~~~

Fixes: <c7e1b422afac>("virtio_ring: perform premapped operations based on=
 per-buffer")
also add DMA_MAPPING_ERROR define for virtio test.

Signed-off-by: Yufeng Wang <wangyufeng@kylinos.cn>
---
v2: fix more build error in the same commit
    <c7e1b422afac>("virtio_ring: perform premapped operations based on pe=
r-buffer")
---
 tools/virtio/linux/dma-mapping.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/virtio/linux/dma-mapping.h b/tools/virtio/linux/dma-ma=
pping.h
index 822ecaa8e4df..095958461788 100644
--- a/tools/virtio/linux/dma-mapping.h
+++ b/tools/virtio/linux/dma-mapping.h
@@ -31,6 +31,7 @@ enum dma_data_direction {
 #define dma_unmap_page(d, a, s, r) do { (void)(d); (void)(a); (void)(s);=
 (void)(r); } while (0)
=20
 #define sg_dma_address(sg) (0)
+#define sg_dma_len(sg) (0)
 #define dma_need_sync(v, a) (0)
 #define dma_unmap_single_attrs(d, a, s, r, t) do { \
 	(void)(d); (void)(a); (void)(s); (void)(r); (void)(t); \
@@ -43,4 +44,16 @@ enum dma_data_direction {
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

