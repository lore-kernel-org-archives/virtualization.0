Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B73175A63
	for <virtualization@lists.linux.dev>; Mon,  9 Mar 2026 02:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773023841; cv=none; b=MmgAPXCD4COYoamcjrGYJl/um8fV7GMRau6zgQ+3Ry1yiOLpNd7n2P2V3uc2N4Aasn57/7Xoj+OF87cp6ktxw3of7wyvU/nk/6Dc5CvZ+9+Yud44L+DdXrzM9yjy673PXM3S6cKObMNvJsfSnF9xEzog5PxHj45YJEs36rGUIzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773023841; c=relaxed/simple;
	bh=+1UZMO/aE/eI5LAevtVrXz4Qhcrg8GjpwhgRa7j2f0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MH0TJESZQ5SH6Zga8YvPK+nQspwZZBFUYaQGi1uJ11Pq7moq7MB0zpbPWvLinr/Hw/ZVzVoabZUvEDSpNp7dJ7t64hmpU0zbcdYpiB2HsVtvhBM+f7WZ6OLO36XMi+bq3oR4/0EqOj/NYT8r1TnZXiczZFDhvcKhc1Farw3tBus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHJpJjwE; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHJpJjwE"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c736261ee8dso2543444a12.1
        for <virtualization@lists.linux.dev>; Sun, 08 Mar 2026 19:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773023840; x=1773628640; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G0ssvXDM+adMhEQm37I24yReQK8B//4NTlRkvkcGiMI=;
        b=SHJpJjwEMRKAowV82Lxd2u4FPQTVXqckkdn5scgwibu2LxXAq2sPDUUgiLvqPcaYkx
         vkgphKBrH4IiJ+/3K0BuSmh0C2L/6qUaERXqcXMd1qe6zJJa2e1AKtXJBw/9EjC3acDm
         uQrQkB5lMudsoTPd3Xl32YHBOiv58mDE411c1XWXJprMOsTZ9OvvXV3JIar9lxAGkazy
         c66sVDdoObW6dOMN4QrlluLoKmXbtgn1C+6Nk1fBgXvGJLDC0KAcoN3e5l3pmRLaoMWU
         ZrP0qWMNlm5CInP7M+9cBt0vzmjtzlRi0j2jhIqm3cS7nzPDDUq8r2QvYP/FaWeir9g9
         LqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773023840; x=1773628640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0ssvXDM+adMhEQm37I24yReQK8B//4NTlRkvkcGiMI=;
        b=B86cQS0hHvAmxDAeaErTqivHaA36AJUKeSqaQHiRmkNSUpPSl2ZYCSIjVuTZ5UaFVS
         KVS/+UfIuPsdYloavsjCPvewjmx6iSmoXqyWCw/RoNV4mlZu/TlYgFDjopWnXkzsXmOa
         gjW2vHjfB83mCewTK+38vgnJnkJiR8RC+v3ME2wEuLPZ/kcyxpqsWF1vxKQxU3YV79oW
         n2Wll1xMIRznCW6hRImJC9fStB3K2ckp6RVmJHetp4Pu87/KS52kzCWppEcOQBKtMToG
         1FDlPhFdRKLIX9X97VRCmDFsz0gOQiUVg0dbMeXr9sfmk9XaYXTvlyy7pMVkHO2lhFuP
         OE/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVvs9ro5kFqSwPAfAMbyW8gDYvM3hPFZ9MMX9HAcgfEF6Kzfc+d4KxZ2MtGA/ifInfUpm7JxGoOnrbW4PbDKA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxl++qRR5kLALPOe2FI2nXszQKXUoChPSCmYzLU2VqVolf3rJe9
	CtiKUnF03l9Q9BOQr7Z4X8gg/BLqC7ZaLvAZc1oBk4JuVDSUnrQuzmCT
X-Gm-Gg: ATEYQzyS7eQDZDbOQ/Q2O9c5faiXVmwq4TepNDD059hp0edfBjzWFBuLtdpVFboqoRN
	mSBGlQ2uAjmgJb3hOd5MR8V9+mSoZgUz766dwje+WG3t0i5RoEvymXd7INj07R0tNRyG434niCz
	W09fnrUrvFUePJomNuIdYUCQu1UeqGRqMSRmo9TJIFeGmc7rEtzNGvvrzbXby9k5cXKlk8owya+
	hmAUzGot/n8uN8w9lIf92YuWlYhqokQUFdQ52WushwVxgFzuDHiluJLgppQKdKOyDCnM4QAhTQV
	i3p5BAvvRz50xV26OrYRXBvzAnR07iGO92a5lT13rTM2DvvjY5cUOG/ErMiisVlMQn2U0LEaJco
	bhEh3YZeticZb1DZIeei2VQp1flxclFhKktF5imtpxsGtdaGeQaEHoKKsqz15su5ysq+Jt8Jk5c
	U/Q5otAeHKzGeN8bxsd36LLj37uPjaZAz4HBy+u7jUx/Y42Yjo3+lAMWlSk2OCfI4=
X-Received: by 2002:a17:90b:2ccb:b0:355:35b0:8b83 with SMTP id 98e67ed59e1d1-359be38ffdemr8097666a91.33.1773023839894;
        Sun, 08 Mar 2026 19:37:19 -0700 (PDT)
Received: from ywashizu-z4g4.kern.oss.ntt.co.jp ([222.151.198.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359bcbb13b7sm3485485a91.10.2026.03.08.19.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 19:37:19 -0700 (PDT)
From: Yui Washizu <yui.washidu@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: Yui Washizu <yui.washidu@gmail.com>,
	virtualization@lists.linux.dev
Subject: [PATCH] virtio: add num_vf callback to virtio_bus
Date: Mon,  9 Mar 2026 11:33:51 +0900
Message-ID: <20260309023353.652650-1-yui.washidu@gmail.com>
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
IFLA_NUM_VF and IFLA_VFINFO_LIST in RTM_GETLINK responses.  For a
virtio-net device, dev.parent points to the virtio_device, whose bus
is virtio_bus.  Without num_vf, SR-IOV VF information is silently
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

