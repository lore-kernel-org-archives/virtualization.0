Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74D93E51F3
	for <virtualization@lists.linux.dev>; Mon, 13 Jul 2026 10:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783936820; cv=none; b=iQfhbMFeAT9C0+obYRccOl1mPKolIvCHNdTnN00OOYIUol901AbSsySCeDpZ4SWc3ILwl1fwV+7UQUpiy2J64jizTLNPBaXYAotyCUX0TwTvq3pFs7vrVCJwcBELhDwaG35rp9IR1fOWfjlYzm6GniVKGwMJDTOPBLJozEt3ghI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783936820; c=relaxed/simple;
	bh=OUCPGFYse6O3cBxKTLWZEZyZj7JqS2kufI+OGmui/MY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vf+rpBpEL6jzj4rj3WFB6Eyunh9+mp7VM6GgDQscgqGZkG1DT+QVKmpJd0ypEi4F6P39W38Ox8O0xBRNEst5nh5Jgf8CYHf5vKsTRAQJOEHewU0Ifmg4y9GB24a+YNsc8jOOx66rvGu9Jx0KUkMYvX6/wH9pcCP7gFX/9xK+gho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VbHKmZnd; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VbHKmZnd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=0t
	J+iQHpa1mNYQoyrcv8PkbzLES0TwRipKliQHzapmI=; b=VbHKmZndC1R0nK0PRW
	qZ5/tuTwNL8jSsQVdvgif6ZZUkA9w6/4t1w/JUALlNYJatYCBHLgNNc3eCw/YP8x
	eIFifsA1IEyGCSmBocIw398E1lz6TptgLZMFavY8GjzsZMSycbTZYNVS4eocpGFn
	lPj4AQd9eUPc8tFtTYc4H3ftc=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3a9Eot1Rq2NkzJQ--.22840S2;
	Mon, 13 Jul 2026 18:00:08 +0800 (CST)
From: weimin xiong <15927021679@163.com>
To: mst@redhat.com
Cc: jasowang@redhat.com,
	virtualization@lists.linux.dev,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: [PATCH] vdpa_sim: Document planned packed-ring support
Date: Mon, 13 Jul 2026 18:00:08 +0800
Message-ID: <20260713100008.100813-1-15927021679@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3a9Eot1Rq2NkzJQ--.22840S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF18urykJF48Zr13Zw43KFg_yoW3urb_Kw
	n3Ww40vF15Gr10y3W29FW3ZFyF93y7Jr95uas5Xw4fZ34DX3W2g3WDKFyjv3ZruFZayay3
	Gw4avFnrAw1fujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjsjjPUUUUU==
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC0QinMGpUtygc3wAA3s

From: xiongweimin <xiongweimin@kylinos.cn>

Note that VIRTIO_F_RING_PACKED should be advertised once vringh packed
helpers exist. No functional change.

Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev
---

--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
@@ -13,6 +13,10 @@
 #include <linux/vhost_iotlb.h>
 #include <uapi/linux/virtio_config.h>
 
+/*
+ * Once vringh packed helpers land, also advertise VIRTIO_F_RING_PACKED
+ * here so vdpa_sim can exercise HW-like packed rings.
+ */
 #define VDPASIM_FEATURES	((1ULL << VIRTIO_F_ANY_LAYOUT) | \
 				 (1ULL << VIRTIO_F_VERSION_1)  | \
 				 (1ULL << VIRTIO_F_ACCESS_PLATFORM))

