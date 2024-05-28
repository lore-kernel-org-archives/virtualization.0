Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A3916F822
	for <virtualization@lists.linux.dev>; Tue, 28 May 2024 13:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716903689; cv=none; b=qMN5wt61V2KNw0RHO+38w8ktUilrHq9qIjeTWyZh1gQoDbPZtwx24r0/HNEYVvKjQ5WrJ+Iz22l6H6ySovTGBllkKfjbDhbMPOlsV1Ex4jc6nsnE9n8E6IZmVUZKw6Sg3u2WFjqlEHnkm69dGF25oo1kgiqNMtHIk5ZRtjP1r4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716903689; c=relaxed/simple;
	bh=rqiMSGKF88615Fucsqgbc+8/T4twa5q3qGr1w1/mBXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H6Fp481+jgSvKD0cgTzY29+BF/rRQPWvXRfcDe3JOgVQx3uPM7U8y5I8nd2mdaCB2ckUBnjlp46FkH2tCTWW8hi8suN+m5BHiwNuMxwDb4i+z4Hdf2uZleD7bLBJrfVlcC2lXaqv+9sYVpnLy6MDQ80OueJ4C8mvqWoILTx4ceE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=h8aBfZBC; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="h8aBfZBC"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716903679; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Cb3xqpFTFN0vRi0E3r8bJEwHH0yYdFV9uIUFC99NfS0=;
	b=h8aBfZBCk7wBs5zcafczl4KvmTUCOcF1n/I3cHWN/GbbAMrLwq0FNTtP9lVgQKDC2nZ8374x5hpOBTjET0QxJwuxo/BYJzOs7mqKoczTQV44z0iBit2L8KkAFY9prwOVaJVzcLvu8wna7FIlssSNNz6zyMHtu4fMUf7ZlKtoeMM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W7PpeOA_1716903678;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W7PpeOA_1716903678)
          by smtp.aliyun-inc.com;
          Tue, 28 May 2024 21:41:18 +0800
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
	Daniel Jurgens <danielj@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net v3 1/2] virtio_net: fix possible dim status unrecoverable
Date: Tue, 28 May 2024 21:41:15 +0800
Message-Id: <20240528134116.117426-2-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240528134116.117426-1-hengqi@linux.alibaba.com>
References: <20240528134116.117426-1-hengqi@linux.alibaba.com>
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
index 4a802c0ea2cb..4f828a9e5889 100644
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

