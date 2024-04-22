Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0719A4A31
	for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 01:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713750858; cv=none; b=KkzFbY4NctDgauii+0ztH2X8zRNfz2wa5Decon01VN7uCWrUAHRxgd+kxA59s7TAj97s+vuW3oFrS6LGCDXVOjQL2Ka9u97K5Zku/lqW2+lxpnJcMOH2xQQHG6o/RNc17rfBsoHbyilgoYmdyH4aOdbRArchc+gPxlOU+6aHTvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713750858; c=relaxed/simple;
	bh=RI9oBferiUfhUZJIfb5WszLvNGIFPD09N8cV69d/2jA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mU921/dUiegLuHvvYKyym/5tvPiMKvICdjy0N2SSKQWvIyV+R6RymDWfqCRH+LbTLnFlwsNzfSBPyRcb/jaPjFM7DyN7dvWTwnNxrSrolLw7uNiDcX2qUGH8VpSdI+KDN/kzN766/ltPqkI3IXDrDlT663A83JV8n9Djc7gRsic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RXcdOw8p; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RXcdOw8p"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713750854; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=5EOVd0kTxPUl+7GWsixYT0vlMbIjWLtjuePm8Pe+IaE=;
	b=RXcdOw8p4Ct4K+dz0pCLAhlg5EtIFddKKM1N6o6M+FeIWcUQZSITko283Pv+21xI/odg9xiXVNTmpLZLgQ4ZEf38cXCcaQMadXDIVffuu4CD7JIBnWlwfTMHHGUFX9I2XGm3wewmfaFS6QD4TFo1E39X8l/8Jz2Xbvc/ipAZ6gs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W4yCK5L_1713750853;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W4yCK5L_1713750853)
          by smtp.aliyun-inc.com;
          Mon, 22 Apr 2024 09:54:13 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH vhost v1 7/7] virtio_net: remove the misleading comment
Date: Mon, 22 Apr 2024 09:54:03 +0800
Message-Id: <20240422015403.72526-8-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240422015403.72526-1-xuanzhuo@linux.alibaba.com>
References: <20240422015403.72526-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 2c089e81de7e
Content-Transfer-Encoding: 8bit

We call the build_skb() actually without copying data.
The comment is misleading. So remove it.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index eff8f16a9fe0..a8dac48a1be7 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -690,7 +690,6 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 
 	shinfo_size = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
-	/* copy small packet so we can reuse these pages */
 	if (!NET_IP_ALIGN && len > GOOD_COPY_LEN && tailroom >= shinfo_size) {
 		skb = virtnet_build_skb(buf, truesize, p - buf, len);
 		if (unlikely(!skb))
-- 
2.32.0.3.g01195cf9f

