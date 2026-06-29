Received: from outbound.baidu.com (mx15.baidu.com [111.202.115.100])
	by smtp.subspace.kernel.org (Postfix) with SMTP id A688D2E7376
	for <virtualization@lists.linux.dev>; Mon, 29 Jun 2026 03:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782703931; cv=none; b=VcXPs72SeIflllvyzWKDxEWvTFvQCddqyAdrUhY18zDM14X8Q2m4Vxl6bMBaYu84HDkRlX1ouvb/MUbN3iw7gjncr6KNAKGUaU7Pra+WICW2rrbj8pctuZQAdLq8Bfh1CN5v/dpi8kxd3i1wQ0oiQvq5N96lQrz7whA5WcCU1Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782703931; c=relaxed/simple;
	bh=aJ6Obr1nrcUZmZff60mB2Y4WxdC8OhWK/+3frk6zGXA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fol+UMJXkNPMR24HdpzRIYWInORxwLnW0cEvqoooI3afLmXW04TaLnEJcwcXVgjqfdHpceXiiJe96phUzLCM+lp31RfPMDlk9aDlKZN3JOQreUMyITGx8F0xhQwYvNGxD0MOpuRxucnNF/N53TeRLuweZwXVgsEz/wVRAldxVsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=gE4GkpGZ; arc=none smtp.client-ip=111.202.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="gE4GkpGZ"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, David Stevens
	<stevensd@chromium.org>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] virtio_dma_buf: fix typo in kdoc comment: get_uid -> get_uuid
Date: Mon, 29 Jun 2026 11:31:46 +0800
Message-ID: <20260629033146.2209-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc10.internal.baidu.com (172.31.50.20) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1782703917;
	bh=Hxh/Hyu3F1L821UYw2lb8JdmRrktdXT855vpyT2waLY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=gE4GkpGZnQbV6G5ZGJA2VOXiLajd8g7TD+8mxYjw7375NPMYam21BaoPG5h42ikfw
	 I28hUv9YLzV/q2AGCHLEWKonVaScCf17qD76taYNSTTx23NUgW/7EGkDMsqEhFnEmo
	 Sl/5wnYD5Zz9vuF98pvjfx4BBVaYJN04ZZlyY07O4tvgfljKKnSjgladyEQsvR6xx6
	 AjmIsQT6y4W5DFSRrkUvUEkHGIK9U/XXjEiWc5Vb5XpQ77tHNmmVAvmoSeVXxhr95C
	 ZvupgAZaA40+L8OUcYosVK10pBfIpJyAkf9B5vfzwTVRN1ikri+psvmEIj2QPJEA0R
	 8v2VMuHzcjfJw==

From: Li RongQing <lirongqing@baidu.com>

The @get_uid tag in the virtio_dma_buf_ops kdoc comment is a typo;
the actual field name is get_uuid.

Fixes: a0308938ec81 ("virtio: add dma-buf support for exported objects")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 include/linux/virtio_dma_buf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/virtio_dma_buf.h b/include/linux/virtio_dma_buf.h
index a2fdf21..545ac5f 100644
--- a/include/linux/virtio_dma_buf.h
+++ b/include/linux/virtio_dma_buf.h
@@ -17,7 +17,7 @@
  * @ops: the base dma_buf_ops. ops.attach MUST be virtio_dma_buf_attach.
  * @device_attach: [optional] callback invoked by virtio_dma_buf_attach during
  *		   all attach operations.
- * @get_uid: [required] callback to get the uuid of the exported object.
+ * @get_uuid: [required] callback to get the uuid of the exported object.
  */
 struct virtio_dma_buf_ops {
 	struct dma_buf_ops ops;
-- 
2.9.4

