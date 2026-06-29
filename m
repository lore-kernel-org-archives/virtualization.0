Received: from outbound.baidu.com (mx21.baidu.com [220.181.3.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD4137E307
	for <virtualization@lists.linux.dev>; Mon, 29 Jun 2026 03:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.3.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782704451; cv=none; b=AdkazOOvAJm6FtnURGJIp3ayFqhh3Tg9tRP0cPa6uo02eQ3eAEvpN3qX8BcrC7vXkgWvwmmWdrZfqCucoyBDwwpEZMXwJm7QVBv681G/dcAavcijLQ1EcypCuzhDESpE3C1OOGNPz4O1w5REpPdunXnxE62E9YcEhtUv4FUM/8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782704451; c=relaxed/simple;
	bh=hwkxUyIsfpta/NE0NJqD/hBEaJak7J+Jufh8kCGuBuw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EsZhthDnOZQnX7d5G8hz0xLgZvfaTWLSUXwpZk4ngK8Lv5naB3LZrS1N5Er6yGZ2GZrJX6u4hGW004aTW2w3INmAMPv4ortZHUFn3L0sPizBpkUjY3tUb7wdWgpWoOEKM/qj/7Kewg6Y3r/a6rQwElsatg3+V2vP5pK4X/J/jTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=kWgwj6PG; arc=none smtp.client-ip=220.181.3.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="kWgwj6PG"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	<virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] virtio_pci: fix wrong queue index for admin vq in intx path
Date: Mon, 29 Jun 2026 11:35:38 +0800
Message-ID: <20260629033538.2476-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc5.internal.baidu.com (172.31.50.49) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1782704146;
	bh=aeXdvYgGpBbCs1bQTBcM6yPRYqaDQ3U5E+sGUIpE+Iw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=kWgwj6PGslBu7k8yslaD0JLzJzNwXuko/o2iR2Vkiz2PCxziJwHr6dnciehaCmF83
	 a5gmLmQfBkmvmIZWSsTILul5pev0JJngBBVafaJ8+mG+Ep4lyobwLIn/F0CMz1clGh
	 SufwtdXagdkImcPcinE28zGruPXLge182Bkg7ojp5jZ2ZQClOmMggYsFEYtW50naCf
	 hpRQ2w30B4+7Z8JtCRpilTFvEembxCuF9oxhzrS6tAeQxWzn09bSDhG/TgIMVd0jeF
	 tGGWdBlmotD4GyqkNUnocPxYReOWCIoH4LkdDGZkLfXeQOMEd5zFEVXMLqoVX4mqq5
	 WKOwSHcgZst2A==

From: Li RongQing <lirongqing@baidu.com>

In vp_find_vqs_intx(), the admin vq was set up using the local
queue_idx counter instead of avq->vq_index (the actual queue index
obtained from the device). This differs from vp_find_vqs_msix() which
correctly uses avq->vq_index. Using the wrong index causes the admin
virtqueue to be mapped to an incorrect hardware queue.

Fix it by using avq->vq_index consistent with the msix path.

Fixes: af22bbe1f4a5 ("virtio: create admin queues alongside other virtqueues")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/virtio/virtio_pci_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 164f480..10371ec 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -499,7 +499,7 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
 	if (!avq_num)
 		return 0;
 	sprintf(avq->name, "avq.%u", avq->vq_index);
-	vq = vp_setup_vq(vdev, queue_idx++, vp_modern_avq_done, avq->name,
+	vq = vp_setup_vq(vdev, avq->vq_index, vp_modern_avq_done, avq->name,
 			 false, VIRTIO_MSI_NO_VECTOR,
 			 &vp_dev->admin_vq.info);
 	if (IS_ERR(vq)) {
-- 
2.9.4

