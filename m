Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B2230F94E
	for <virtualization@lists.linux.dev>; Tue, 10 Mar 2026 06:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773123496; cv=none; b=tAUKwaaMsVpZvfkbaicXKOpG3yysNRoR9wharmF2zVc4bPmyl3qJVjQV/4aoVI04dICScjjfsAUCTWRMNGBcx/Y3MkhxqK02VUEVVbwJkRSGkCpa1B+qVMx2sh7ITLk4IRd6zZmOmg/ykaVpyHN+teUCIUp1A6jGlQycju9RmjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773123496; c=relaxed/simple;
	bh=l9W2ypyVrO6K0QFkPMcvEE5VNro1N2BGQH7uYBmSuz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=peCUXA/o+al+alT9MvV1ygzPLYrNGeXBJU7FCH7TfVwblRMsZYhzjbha5w43Zk7qAdlvxtpcj88ZIzFTBYa3SEsqTwCL+Dgc5J+w7FilJjZLOAnwyUQRZv3Jgd4cLOd94LCACJJ3cTYpvv3gUm4eA1ipF7DAObgrKYyv6/XMGZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7JFaXZd; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7JFaXZd"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35980423087so4559473a91.3
        for <virtualization@lists.linux.dev>; Mon, 09 Mar 2026 23:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773123495; x=1773728295; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tEytpFDereDRdBL7OMGncREQ5BA8ftiHbeoAtSZ/tmk=;
        b=V7JFaXZd81y+onzIImnZc68TvwfqkcEJtlEGCyxpZEMKr8B87VFV/QVhGHhm4fXu9D
         oP3BE3BUzDt8/AI8BZ3KHQbi8a0+s0Z22YlJ3IhVT5O2zte86OKolMobS1vJrJFAIDeb
         zaZfeLHPR8R86ti+aCCOKvJU+38zcZ9nViymApquIJlE8O7sJ4HjfNd6b8UoeHLo3bxi
         aRihzkFJ2lSVnSbt0/z67+UxSTz+K6bSwbse5Y2hdbpk+5hYGdMSJp63qAVBLulauc/h
         fgVWl0+rdRvz49wDTEnE/lMAvHD0MGjDkBW3Kxfii7j2HimglrmSACaZMUlQjvwa7Ow4
         XQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773123495; x=1773728295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEytpFDereDRdBL7OMGncREQ5BA8ftiHbeoAtSZ/tmk=;
        b=rj3F6+yldKh+5r57IkfIVkMt4i27/eloAEg3ytA6Ekf+6WmO0AnuFVNAZ+dKPGUSai
         eCD8Ypr5jMKHKYAnhGoGQyP5Lg/3cXvF3LHPeSSwOyvnNzurdvYFqJ4hStgI7Ac2NKPK
         oWEMfz3wb1RJv39BDJKlSbq18Dovb1oz9O0TLp7Fq5pj3ECCJhPZn/smelmym/vcJzb8
         006qGRGLKS1lUa9Uh1lE6y6Jkj0NSuQ37q+zkeTirVpe5M0MzuQ61UfLaYIvFqDNda8I
         YA0mmIuRv6Lx+qWb1EbZ/S++VKUMYTSJjUA87wG/VqaExvXIMtYNteijstnVyrkwin4Z
         WhAg==
X-Forwarded-Encrypted: i=1; AJvYcCUnFaz49Jj59xeTU+XXLNQo6N0FkwZWj8FHgK/oNyDj6PEVmAsQYdut1EdGAlY3BHD3solFfjPCxJifSrsFMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzkqi4VnjoGYoUs7FVcJY5OkCaB3bciWm58RlTLsnjFnJd1kaTX
	oDQyNJxr0WI5K0BVaEInssOxi2aOKqyUp34QXfNXG62yEv57H2t4IZ3A
X-Gm-Gg: ATEYQzzzRDGc/H91jzx1HIb5UY30vZ+yr7+LVl2weOCZOFYCARFI7A1OpSvSPbQY+Sz
	FFSumw8ApAiFGoWa5qcwkhbI/5wTnGujmfZqmSZtINiU5O7D7wPHKRdOfzWvgCQMjq4w0BMqoHe
	PCwJVtd5SgZ9Wx97pKfJFkCnlZUFFNOvdpdv7OSKctUFBuCQ/A47iQA9JmS9uES1DvMtGYQLRgb
	H7JSrT14Iw78SNTltwFZa9A9wR1NCWH28PYXgPBnLWfAqT7K5xY0L/qd/oqXkYt4kxckagOZeI9
	/N3A6UfbcvpM5jjkf5kze2p7lystGJzwIBFM2pXClZqhq9LeJ4vQz6/vvp8SxqrjbrEu2X3uMX2
	S7aOl8tb6WCo3OvlYu1uT+6yS3k0fFm3XbGv7gT7HXoir6Js75jcalNwMNBv50vene/7UPSVOq/
	zhxtWGfx70caYTG73XCoxmdKiCRwmH/GwOZ2S6YKB3/xjE9RVECiBx0Kx0QjTzfBE=
X-Received: by 2002:a17:90b:1d43:b0:340:b912:536 with SMTP id 98e67ed59e1d1-359be347dc9mr11870271a91.31.1773123494552;
        Mon, 09 Mar 2026 23:18:14 -0700 (PDT)
Received: from ywashizu-z4g4.kern.oss.ntt.co.jp ([222.151.198.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359f080db95sm2328020a91.9.2026.03.09.23.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 23:18:14 -0700 (PDT)
From: Yui Washizu <yui.washidu@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: Yui Washizu <yui.washidu@gmail.com>,
	virtualization@lists.linux.dev
Subject: [PATCH v2] virtio: add num_vf callback to virtio_bus
Date: Tue, 10 Mar 2026 15:14:52 +0900
Message-ID: <20260310061454.683894-1-yui.washidu@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent QEMU versions added support for virtio SR-IOV emulation,
allowing virtio devices to expose SR-IOV VFs to the guest.
However, virtio_bus does not implement the num_vf callback of bus_type,
causing dev_num_vf() to return 0 for virtio devices even when
SR-IOV VFs are active.

net/core/rtnetlink.c calls dev_num_vf(dev->dev.parent) to populate
IFLA_NUM_VF in RTM_GETLINK responses.  For a virtio-net device,
dev.parent points to the virtio_device, whose busis virtio_bus.
Without num_vf, SR-IOV VF information is silently
omitted from tools that rely on rtnetlink, such as 'ip link show'.

Add a num_vf callback that delegates to dev_num_vf(dev->parent),
which in turn reaches the underlying transport (pci_bus_type for
virtio-pci) where the actual VF count is tracked.  Non-PCI transports
are unaffected as dev_num_vf() returns 0 when no num_vf callback is
present.

Signed-off-by: Yui Washizu <yui.washidu@gmail.com>
---
 drivers/virtio/virtio.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 5bdc6b82b30b..299fa83be1d5 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -435,6 +435,14 @@ static void virtio_dev_shutdown(struct device *_d)
 	dev->config->reset(dev);
 }
 
+static int virtio_dev_num_vf(struct device *dev)
+{
+	struct virtio_device *vdev = dev_to_virtio(dev);
+
+	return dev_num_vf(vdev->dev.parent);
+}
+
+
 static const struct bus_type virtio_bus = {
 	.name  = "virtio",
 	.match = virtio_dev_match,
@@ -444,6 +452,7 @@ static const struct bus_type virtio_bus = {
 	.remove = virtio_dev_remove,
 	.irq_get_affinity = virtio_irq_get_affinity,
 	.shutdown = virtio_dev_shutdown,
+	.num_vf = virtio_dev_num_vf,
 };
 
 int __register_virtio_driver(struct virtio_driver *driver, struct module *owner)
-- 
2.47.3

