Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE7E3FD4
	for <virtualization@lists.linux.dev>; Tue, 17 Dec 2024 03:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734407730; cv=none; b=WDrIcImMCgj7hwidJfm7oA7zcG+PiXpMZGV5VLJ3zggWdpjLeMVwloKIZM+sOZjphWvW6sROwfYmmjgHa2OENVhp+rSBOidqwzc3ns6Bwo1gychzJyav61IyIJVTSMSpxiVLzDGwX9HcTf78OETzMXsjfHgfOk3jjMLCGQZB5io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734407730; c=relaxed/simple;
	bh=PBIqoh0+ItZyIgHirEJhgwbzuTx438a3eeqecHpANFI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PC968edT0mWtqeKVP06hnmwpGwwfEPjzbGhgbvBUya5axPFuX4X5Rbvx8iiTxFGN//K7XwnVZnSIOdruIy08fuxgzmrxnBU0fLV86PTzUJ20pfyHUczlzbtgUooh/rfYcDN+lH+P95FYO2CT4fFOZ/CPEmmO9U/+kO58WClhPGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cn5USNwK; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cn5USNwK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ap3cS
	3JlynQ5mnXUthOMr7ekp9nV+5QCIucFh5o9xqw=; b=cn5USNwK+JTQUrMSOojQt
	SsJkf9GD+MdjrB2jnTGq9IJeCf5UoH/OY0hJ7yJfxXaGOsYjparv8S4Ku9BJb3WF
	nhB4mzox+yw9kGGy+CD6IKJMmnqgPKQIJcgI7LPS8L1q9APm1X+z6WsWa9EjJVuP
	xg4v/A/gHBv1lL02oWTQIg=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3l_P89WBnqKpaBA--.3706S4;
	Tue, 17 Dec 2024 11:54:39 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	arnd@arndb.de,
	viresh.kumar@linaro.org
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ma Ke <make_ruc2021@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] virtio: fix reference leak in register_virtio_device()
Date: Tue, 17 Dec 2024 11:54:32 +0800
Message-Id: <20241217035432.2892059-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3l_P89WBnqKpaBA--.3706S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWxCF1rXr47Ar43Zr4kCrg_yoW3urgEka
	109rZ2qF1UGF40yrW5Ar4Svrnaka4qqFs5ZF45tFyfA343ArsrXr17Xrn8WF15uw17Cr4D
	AFs5Krs5Zw1fujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRMbyCDUUUUU==
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbBXw24C2dg7nnCZQAAsW

When device_add(&dev->dev) failed, calling put_device() to explicitly
release dev->dev. Otherwise, it could cause double free problem.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 694a1116b405 ("virtio: Bind virtio device to device-tree node")
Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 drivers/virtio/virtio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index b9095751e43b..ac721b5597e8 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -503,6 +503,7 @@ int register_virtio_device(struct virtio_device *dev)
 
 out_of_node_put:
 	of_node_put(dev->dev.of_node);
+	put_device(&dev->dev);
 out_ida_remove:
 	ida_free(&virtio_index_ida, dev->index);
 out:
-- 
2.25.1

