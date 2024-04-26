Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B7113B591
	for <virtualization@lists.linux.dev>; Fri, 26 Apr 2024 06:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714114510; cv=none; b=kNN/4Tw9IiB4SjjzkkJBI5P7TmMNMvnqikJGs9cQS9Jj3iMJXAB+qOzhmyEBL7YW7JoltgbRaT8hrb9cMBITh6ntV3fZw6vacbZBAPDPzoUKSBK3PsWli33URgGgkEFzkjfDcJadDQIGZ9lv5j9z/UzFWj6IIRKkTwM9xuZ6eAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714114510; c=relaxed/simple;
	bh=/6sjowak/lauryCfOTb5rKSmJVlKqeh6jTSIGcjwXC8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fdlLjDVn4EfIbmd2bF2tGGIRmlkXfP9XyT/B6zFc4vuDOeivKQlQFGiD5wrA7vRxmbBCxJBcSpmcq6GasMphTORLtJSLrmgECrA7EJy9g1oVgDKAvKOkSqUqNwofPEUXbDGjt/oXKp0yyQa4VvxK7CMdIpeAtKViW6bn5E6XoqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xOmhzhOW; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xOmhzhOW"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714114484; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=UN/CLV4Scst1cNxtfpCHdnfclV3O9TGy+78D8TsHLvg=;
	b=xOmhzhOWvPmpzOKXkfq/aa0jx7mkEJTsLvMH0GJYY/BaCtIw408V2Cl6kIcq4ztNDE3FWK0swfVqb8zlWopXrj1JtqEyaGh/pe8++sjqamxnuxftCd1gFxuGDzCNpL+7cu5N+FSf3YCSKYowWFUKU64YSb0YCNfHaqZsSm3M7Q8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W5ILuwH_1714114481;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W5ILuwH_1714114481)
          by smtp.aliyun-inc.com;
          Fri, 26 Apr 2024 14:54:42 +0800
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
Subject: [PATCH net-next v2 0/2] virtio_net: support getting initial value of irq coalesce
Date: Fri, 26 Apr 2024 14:54:39 +0800
Message-Id: <20240426065441.120710-1-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 from Xuan: the virtnet cvq supports to get
result from the device.

Patch 2 reuses the VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET cmd to
get init coalesce value.

Changelog
==========
v1->v2:
  - Update patch1's commit log.

Heng Qi (1):
  virtio_net: get init coalesce value when probe

Xuan Zhuo (1):
  virtio_net: introduce ability to get reply info from device

 drivers/net/virtio_net.c | 92 ++++++++++++++++++++++++++++++++++------
 1 file changed, 78 insertions(+), 14 deletions(-)

-- 
2.32.0.3.g01195cf9f

