Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1486A13C910
	for <virtualization@lists.linux.dev>; Thu, 23 May 2024 07:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716450425; cv=none; b=Sw+s/lkhcZKRY1mO6dnIkldC4Z5ukTuRgLTkimUhVS33ayPFbM4iPID3b5ySlCefmzaPgZVQJlYBBGnJGGU11rV7+62cRi+SsQKlldKLnuWazBadnuwWI/nonWr07pYQSaEnTwR/xN7zeQ8G+sOVgvxmU92g2CQiyi2lyAcs/+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716450425; c=relaxed/simple;
	bh=TvT6VYbQgTqNcXIbLD3Dj1uS6Dn3C+N4s09kqBwvqys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WIcss9qYzYZtmrzj2nZbYEBDunjqsapL5FMLNVswlg3z6+g5DVtljhHckfL2QdvpGsshM+dnmlxAM9U2jto/CrB1+f37ymubQS/99aIVD0WNB2bfDq6xC+Hri277rCXnkHAf0ZZqHXYjKwNx67Tzeh9ZYSUH8Zbgd4A0O+25kN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hjxVvL24; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hjxVvL24"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716450415; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=z9nK7dlyl+m+FuB7YaIkvYcVATW9vu+e81GH40eGe4o=;
	b=hjxVvL24VW1+kvpGA/xaJdZefL2RwD5EVqRNLHT0wD1XA1taAofHQppHQLbqCwWDReUvahAVoMJd0rLsbPT3oh1D11guIFH/ypIPgAG/9dsZuubs/nsg8LA5PrB5vHIQYS4Eg4qx/8tiDewSkajqSlDwa0+wGvZyDj3aFXUZsW8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W724CkT_1716450413;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W724CkT_1716450413)
          by smtp.aliyun-inc.com;
          Thu, 23 May 2024 15:46:54 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net v2 1/2] virtio_net: fix possible dim status unrecoverable
Date: Thu, 23 May 2024 15:46:50 +0800
Message-Id: <20240523074651.3717-2-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240523074651.3717-1-hengqi@linux.alibaba.com>
References: <20240523074651.3717-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the dim worker is scheduled, if it no longer needs to issue
commands, dim may not be able to return to the working state later.

For example, the following single queue scenario:
  1. The dim worker of rxq0 is scheduled, and the dim status is
     changed to DIM_APPLY_NEW_PROFILE;
  2. dim is disabled or parameters have not been modified;
  3. virtnet_rx_dim_work exits directly;

Then, even if net_dim is invoked again, it cannot work because the
state is not restored to DIM_START_MEASURE.

Fixes: 6208799553a8 ("virtio-net: support rx netdim")
Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 4e1a0fc0d555..1cad06cef230 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4417,9 +4417,9 @@ static void virtnet_rx_dim_work(struct work_struct *work)
 		if (err)
 			pr_debug("%s: Failed to send dim parameters on rxq%d\n",
 				 dev->name, qnum);
-		dim->state = DIM_START_MEASURE;
 	}
 out:
+	dim->state = DIM_START_MEASURE;
 	mutex_unlock(&rq->dim_lock);
 }
 
-- 
2.32.0.3.g01195cf9f

