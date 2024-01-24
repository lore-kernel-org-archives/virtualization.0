Received: from njjs-sys-mailin01.njjs.baidu.com (mx310.baidu.com [180.101.52.44])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613616310C
	for <virtualization@lists.linux.dev>; Wed, 24 Jan 2024 12:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.101.52.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706099218; cv=none; b=u0JY2rcN0gguHNVjDjCOYlBweuPCHyqZ0/C0/sl90FS0oJaxQnd+cvUiOnAyATSBaEZhgd62S891rmv506QkJPpfLErV6Fl5SLmYXGsfRPGh7bFyHsukQfPJCLhzSnvoJ7k7dSM7zD84PmXSp+cxDsgI4FC8evSW0Hw3ULeyQy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706099218; c=relaxed/simple;
	bh=CMswFOeTUIBoFSnMf2W+AZloBH9jJ7RAVEThMYwejlY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=sC5v3Focuy+PjOYKTglzcrCJfjmbyYatLmVSw0+UHSuRmhuJVOmQ0gz3My622zSTMLn3hOJzYSi/idz5qVwAobecrDHn4Bd/1Xvu3XVQwsOKhi/OfPW2qVrQmYwPHRAO/hBmmIdQZCG/yam7666ri+GZMgaMOCKek0MKLoBe2os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=180.101.52.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Received: from localhost (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
	by njjs-sys-mailin01.njjs.baidu.com (Postfix) with ESMTP id 076207F00043;
	Wed, 24 Jan 2024 20:10:34 +0800 (CST)
From: Li RongQing <lirongqing@baidu.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	arei.gonglei@huawei.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	virtualization@lists.linux.dev,
	linux-crypto@vger.kernel.org
Cc: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] virtio_crypto: remove duplicate check if queue is broken
Date: Wed, 24 Jan 2024 20:10:32 +0800
Message-Id: <20240124121032.8172-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.9.4
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

virtqueue_enable_cb() will call virtqueue_poll() which will check if
queue is broken at beginning, so remove the virtqueue_is_broken() call

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/crypto/virtio/virtio_crypto_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
index 43a0838..3607b6f 100644
--- a/drivers/crypto/virtio/virtio_crypto_core.c
+++ b/drivers/crypto/virtio/virtio_crypto_core.c
@@ -42,8 +42,6 @@ static void virtcrypto_ctrlq_callback(struct virtqueue *vq)
 			virtio_crypto_ctrlq_callback(vc_ctrl_req);
 			spin_lock_irqsave(&vcrypto->ctrl_lock, flags);
 		}
-		if (unlikely(virtqueue_is_broken(vq)))
-			break;
 	} while (!virtqueue_enable_cb(vq));
 	spin_unlock_irqrestore(&vcrypto->ctrl_lock, flags);
 }
-- 
2.9.4

