Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [176.9.242.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535D51E87B
	for <virtualization@lists.linux.dev>; Mon,  3 Feb 2025 13:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738590298; cv=none; b=gZRaVmOsLnO86iK12knwyoMFqHy4MSyW/1/WGCCqYOMRcDhDufLg0xw6yJEBMtaEiTyCigELCuEls775JQoVlYnTcTgxXWD6NY+12fmLIC3vuuCSUe3T13pj5DK1MBsus7TdHa3FUHMnrBifyXbnb9OE2+E4HeXfyv0pMTf5t9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738590298; c=relaxed/simple;
	bh=9wHzKxaKrZ6WOM19ib3N/TZvqBRfBKfjWFnbI0sf11k=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=UG4NKjh13LtEpMyVdWa/OiSshqboCpbXtRXqP6QjklEiAX8LUVCiumm+9LmzOhJpxNPtCaazt8SQGVUQV8NU48cJq6zQCmdTpYhtZrVePvM6X+psXiCspa2A1eWPP5poHmwraL8Dc2hT+v1PC86nYvppl9d7GfsdV4UJQwJjCDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=176.9.242.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 44275101E6A35;
	Mon,  3 Feb 2025 14:44:54 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id DAF546087DD7;
	Mon,  3 Feb 2025 14:44:53 +0100 (CET)
X-Mailbox-Line: From 425ad57ca42ac6b19a61ed87051b05fe2b5170ff Mon Sep 17 00:00:00 2001
Message-ID: <425ad57ca42ac6b19a61ed87051b05fe2b5170ff.1738562694.git.lukas@wunner.de>
In-Reply-To: <cover.1738562694.git.lukas@wunner.de>
References: <cover.1738562694.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Mon, 3 Feb 2025 14:37:01 +0100
Subject: [PATCH 1/5] crypto: virtio - Fix kernel-doc of virtcrypto_dev_stop()
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Gonglei <arei.gonglei@huawei.com>
Cc: zhenwei pi <pizhenwei@bytedance.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio Perez <eperezma@redhat.com>, linux-crypto@vger.kernel.org, virtualization@lists.linux.dev
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

It seems the kernel-doc of virtcrypto_dev_start() was copied verbatim to
virtcrypto_dev_stop().  Fix it.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/crypto/virtio/virtio_crypto_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_mgr.c b/drivers/crypto/virtio/virtio_crypto_mgr.c
index 70e778aac0f2..bddbd8ebfebe 100644
--- a/drivers/crypto/virtio/virtio_crypto_mgr.c
+++ b/drivers/crypto/virtio/virtio_crypto_mgr.c
@@ -256,7 +256,7 @@ int virtcrypto_dev_start(struct virtio_crypto *vcrypto)
  * @vcrypto:    Pointer to virtio crypto device.
  *
  * Function notifies all the registered services that the virtio crypto device
- * is ready to be used.
+ * shall no longer be used.
  * To be used by virtio crypto device specific drivers.
  *
  * Return: void
-- 
2.43.0

