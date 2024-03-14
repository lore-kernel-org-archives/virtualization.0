Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F765D744
	for <virtualization@lists.linux.dev>; Thu, 14 Mar 2024 13:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710421785; cv=none; b=fgc+Z8Bny1bKDyFdeAkVEIM/rjz0kzTJ8k3ApeFZhEPWlmY13+PgwawKjTq9vCOhTbKD0qOBoQhuL5JlUO2Gcur9158fHLRnDA/qncRhtt1x7Ta2ob6ocb9RaEIDYZl6wltgauTKgwRj/qGD//125deVORXJqVPzf3gJaMlxfsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710421785; c=relaxed/simple;
	bh=X+C4Lb37uB9McXdaw6/uGad+ij/t1LeB2+QKiBogxVY=;
	h=From:To:Subject:Date:Message-Id; b=U+uMXMbCKjP5mZxfIF8V9wAbL5+LTfDICvVdlzVKsmKNvVs5aTfHaUPxyFWJ7Qz6edkTQnYA7XaKDT2cV5icyGs2P8QJy+ITGnROAfPhRRguOU2C7skl9Ajz0sczRzu56ZykP86oaCDisQ099Yg3m8dqihlr0Da7eAOnS+QB248=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yVt1XFBP; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yVt1XFBP"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710421775; h=From:To:Subject:Date:Message-Id;
	bh=WxLutTnRoPbq6saJpMDkQW7pepYVttH65771Wfq4fM4=;
	b=yVt1XFBPFabjqdzHFcauT6pbIDaNKaHYKSjcgGLnpMir4irAr6F4s+PcJwP3Yvc0X20UPoNsrqzxSHOdNOPvHWnCttwAce9bQQkwkOjTHpP0w6BacL1SJj0dqWtTDbMU4VLLnsTt3jilcyK3CCWMIXfur5cfup67noWVkIzm/x4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W2Swf5l_1710421773;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W2Swf5l_1710421773)
          by smtp.aliyun-inc.com;
          Thu, 14 Mar 2024 21:09:34 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: "David S. Miller" <davem@davemloft.net>,
	Tal Gilboa <talgi@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Breno Leitao <leitao@debian.org>,
	Johannes Berg <johannes.berg@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [RFC PATCH 0/2] net: provides dim profile fine-tuning channels
Date: Thu, 14 Mar 2024 21:09:31 +0800
Message-Id: <1710421773-61277-1-git-send-email-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

The NetDIM library provides excellent acceleration for many modern
network cards. However, the default profiles of DIM limits its maximum
capabilities for different NICs, so providing a channel through which
the NIC can be custom configured is necessary.

Please review, thank you very much!

Heng Qi (2):
  net: add sysfs attributes for customized dim profile management
  virtio-net: support net sysfs to fine-tune dim profile

 Documentation/ABI/testing/sysfs-class-net |  17 +++
 drivers/net/virtio_net.c                  |  64 ++++++++++-
 include/linux/dim.h                       |   7 ++
 include/linux/netdevice.h                 |  35 ++++++
 lib/dim/net_dim.c                         |   6 --
 net/core/net-sysfs.c                      | 172 ++++++++++++++++++++++++++++++
 6 files changed, 294 insertions(+), 7 deletions(-)

-- 
1.8.3.1

