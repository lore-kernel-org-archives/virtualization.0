Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4291A0AFF
	for <virtualization@lists.linux.dev>; Thu,  1 Aug 2024 13:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722518634; cv=none; b=eQ1J+zJLRWYmAKeUyGpZSiuSphq/iKZAWsXXDX7QlsytUtWpkjsJXn8wb6z+arKI2uyTvRFuaWUocNAWJVFFJNsaj/3KNd8JhrF9CVRM4FtUyHHmrya+UdF2DC4IVwwD3qT8q2Nc8qxbF5At3jUoprp7ArCEhCqM6/SxMh/lp0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722518634; c=relaxed/simple;
	bh=wuruu1gVyucbxUH3Qf7G/JYs6iQmFD1AW8zZkd5bSFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tfv5bgKO/ustz6AutbQjIwz64qGVl3tMcWCPEZKHfvfYwImqLP54ZYz3dwUD8zEveFYnhHFtQ5bGBsXQWUcwHko06fSQIOOCSGYXzYL2uGqJZadB60nAukXCNGxjh9DVjK5ur7OetbxKSD/0Z0zyxbdGNG6qbq+xv98STi93GNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Fbpwk/u5; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Fbpwk/u5"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722518624; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=21Crsi8z2e5Y5WnMRGR745jK4syZ6mZ6kO+JL+4hvkM=;
	b=Fbpwk/u5y1uSO+UHtznBpNIsUzJYkfj4PSJjdgVJrF7OdvO5es2+e54b+MDcPgR7rCpTSfk0yicPp34EPM0N80jJVNFb4gSve4Paqsu5Sl9KZG5RX553+bTD9OGDyrCwcvh9RZvpaB/fciUvgUOrZUFoUA+ZZP/HVSAvm+iDIgQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0WBtsEFx_1722518621;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0WBtsEFx_1722518621)
          by smtp.aliyun-inc.com;
          Thu, 01 Aug 2024 21:23:42 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net v4 2/2] virtio-net: unbreak vq resizing when coalescing is not negotiated
Date: Thu,  1 Aug 2024 21:23:38 +0800
Message-Id: <20240801132338.107025-3-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240801132338.107025-1-hengqi@linux.alibaba.com>
References: <20240801132338.107025-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Don't break the resize action if the vq coalescing feature
named VIRTIO_NET_F_VQ_NOTF_COAL is not negotiated.

Fixes: f61fe5f081cf ("virtio-net: fix the vq coalescing setting for vq resize")
Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Eugenio Pé rez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
v3->v4:
  - Add a comment.

v2->v3:
  - Break out the feature check and the fix into separate patches.

v1->v2:
  - Rephrase the subject.
  - Put the feature check inside the virtnet_send_{r,t}x_ctrl_coal_vq_cmd().

 drivers/net/virtio_net.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index b1176be8fcfd..3f10c72743e9 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3749,7 +3749,11 @@ static int virtnet_set_ringparam(struct net_device *dev,
 			err = virtnet_send_tx_ctrl_coal_vq_cmd(vi, i,
 							       vi->intr_coal_tx.max_usecs,
 							       vi->intr_coal_tx.max_packets);
-			if (err)
+
+			/* Don't break the tx resize action if the vq coalescing is not
+			 * supported. The same is true for rx resize below.
+			 */
+			if (err && err != -EOPNOTSUPP)
 				return err;
 		}
 
@@ -3764,7 +3768,7 @@ static int virtnet_set_ringparam(struct net_device *dev,
 							       vi->intr_coal_rx.max_usecs,
 							       vi->intr_coal_rx.max_packets);
 			mutex_unlock(&vi->rq[i].dim_lock);
-			if (err)
+			if (err && err != -EOPNOTSUPP)
 				return err;
 		}
 	}
-- 
2.32.0.3.g01195cf9f

