Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D57B361640
	for <virtualization@lists.linux.dev>; Mon, 13 Jul 2026 10:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783936807; cv=none; b=e+riH9fbssYEN/v5yGuqdNDNYEtlkwvVoV/iq9p2zVWaaQVSBBOBfRaMxWcpSwYxc0OM+agrBn0Q6Qpz9wskUnQkevIFiWympicEtbEACU33VP9p+MUdpXwH6PeActbejGK5MaoaaB+gzkWvAt+bYBM8DGNNs7vrr/dE0ayYDBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783936807; c=relaxed/simple;
	bh=OUCPGFYse6O3cBxKTLWZEZyZj7JqS2kufI+OGmui/MY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KSPddkvCOGQKCIiZLJfAHVQUB4ugl8uqCXWbd5senw6hnFz1uD55qG9uAnZHr9r0KR6H/Ng960fBKCHNfoebzCaj1mGTvlyuQ73N8EfM7FhKNQXliySCPUCA7oSN3AM3gBp7rn6Yi/o5BIm9g85r6UU5QZ3CdAW0Zangogp24Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Cx4lltcu; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Cx4lltcu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=0t
	J+iQHpa1mNYQoyrcv8PkbzLES0TwRipKliQHzapmI=; b=Cx4lltcuO49AicCfMr
	inIksmEyY+QgOXUDdgiMpaVApq0Q3eJDgoiYakH1620A8LajK4/IA2mOr124N1sM
	nDfWzhUOmLQpjev7S3AIJDE9ZLynW4wZK4oo7em4PQaJ7PTJYogZiYlyd+mkDAkU
	Bs23prc4IzA2KjrAP00PPRfCE=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDn8OcTt1RqMzVVJg--.53896S2;
	Mon, 13 Jul 2026 17:59:47 +0800 (CST)
From: weimin xiong <15927021679@163.com>
To: mst@redhat.com
Cc: jasowang@redhat.com,
	virtualization@lists.linux.dev,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: [PATCH] vdpa_sim: Document planned packed-ring support
Date: Mon, 13 Jul 2026 17:59:47 +0800
Message-ID: <20260713095947.100728-1-15927021679@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn8OcTt1RqMzVVJg--.53896S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF18urykJF48Zr13Zw43KFg_yoW3urb_Kw
	n3Ww40vF15Gr10y3W29FW3ZFyF93y7Jr95uas5Xw4fZ34DX3W2g3WDKFyjv3ZruFZayay3
	Gw4avFnrAw1fujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjaFAtUUUUU==
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC0RSiK2pUtxQbOQAA3z

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

