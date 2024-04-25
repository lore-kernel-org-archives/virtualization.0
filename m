Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE57E1494C8
	for <virtualization@lists.linux.dev>; Thu, 25 Apr 2024 12:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714049944; cv=none; b=k1uORU20zJ3719kR9sg51SUHYKydZDDXQsAsSEXzgO+FIaNOXHN8E1iRkgyw8cG5yBwfCZvxjDY+kvy8ylDkIbazUC7aYHawcq3MeWo2VH3MlyofFHvBBlbqODGxccmlF3h50gZfon318RVnymwOK5ZUXrnOC/1LWru2FnMO7co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714049944; c=relaxed/simple;
	bh=tyVjat1rjW2MAao+7FrJyWEzcCabOzU4xQ5JCwwV9uQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pzm6/zp9Vc3/HYoGQxYQMELbYeYTcv+BmtDCRpF/BVpe34vQVV3RJGCp+6069WaZAMVo4R4enF5N3uXhJ5hGmH2vuZxLMrE/dfXe/iz+3cQdUN+TC/1PlYgwknhEyNWnUaI3ys8M2zLqMIv6RG9KOl/6vEdurANgJNKgr6sLUHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=awYLGZyc; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="awYLGZyc"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714049938; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=WLs6Yn5APuAIgojgCyiuTy7J9kuBh6CD/M/N8iA90a0=;
	b=awYLGZycH64e5vse6LrGqgJLCngkW4hxFrilST8m9ymcASkz1yIcaW1ivguqXCz5unK0X66hJKAgPHa8mG43Qd28Kowbq/hzaltsBSUXGPonATTLBYjXUuWjFfMO2qv104MB6oDra9BHJHRZLsnjyp9eBGZZczB6CT9/BTo0njQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014016;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W5FRGNX_1714049935;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W5FRGNX_1714049935)
          by smtp.aliyun-inc.com;
          Thu, 25 Apr 2024 20:58:56 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 0/3] virtio_net: enable the irq for ctrlq
Date: Thu, 25 Apr 2024 20:58:52 +0800
Message-Id: <20240425125855.87025-1-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ctrlq in polling mode may cause the virtual machine to hang and
occupy additional CPU resources. Enabling the irq for ctrlq
alleviates this problem and allows commands to be requested
concurrently.

This patch set is on top of
https://lore.kernel.org/all/20240423035746.699466-1-danielj@nvidia.com/ ,
so patchwork may cause warnings.

Heng Qi (3):
  virtio_net: enable irq for the control vq
  virtio_net: fix possible dim status unrecoverable
  virtio_net: improve dim command request efficiency

 drivers/net/virtio_net.c | 268 +++++++++++++++++++++++++++++++++++----
 1 file changed, 240 insertions(+), 28 deletions(-)

-- 
2.32.0.3.g01195cf9f

