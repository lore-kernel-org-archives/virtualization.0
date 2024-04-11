Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD2414F108
	for <virtualization@lists.linux.dev>; Thu, 11 Apr 2024 14:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844765; cv=none; b=fJWQJQJUPI3kn6kT6QiNDDPY+FqIbpmGPWxBw7sQfehVmG075z438lp6Ys/K66XSH3ad85eu8n+9aof8V9BMocyk6pu0w6OswVpjK9mfXKIY2tKPjBENJyhYL+LMy2/TBonPrGNaTBRijhxX5vlpuO3kxCQXXKvU1KKccR5WuZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844765; c=relaxed/simple;
	bh=gTVApN1Qfdpss3RHztY0NATJigY2s5M/5K8I5UU1onw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=C9HafXxts7G7t+yto2lQD49B59pmjr0RwNbDFMOaMo131m8fizDtLLmfY7JEO6l0notUKstu1AcdaF0yc3P+gvvGPLUMqWijW6aQEP1v3iUFTgEWMvrsCRpiqCprJNWtV9JRbDOlh+xv1Ooa2emY9TGYBaUlnCFnuVtp9r+YIis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ubaJ10Eq; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ubaJ10Eq"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712844755; h=From:To:Subject:Date:Message-Id;
	bh=p1eu6Dh2dhG2C9YSG0A3GrQUPqlg4q55WJ+XLJP6+GA=;
	b=ubaJ10Eq771GUURtdA45/9BEbdhJ97uapl1AUBhT74Nj0MgZi8/fTL1hWD4u9dAWX6Nb43NR1msciBE24IgcWhr3nLSi8PXBqYLz5ce1WuY/pSsY4PRZb02HcUzqq4ORMZ+SF3mFbwigEzyu2ETbc98quWd6o5AkFbqwm3wzEug=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W4LV1H2_1712844751;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4LV1H2_1712844751)
          by smtp.aliyun-inc.com;
          Thu, 11 Apr 2024 22:12:32 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next v6 0/4] ethtool: provide the dim profile fine-tuning channel
Date: Thu, 11 Apr 2024 22:12:27 +0800
Message-Id: <1712844751-53514-1-git-send-email-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

The NetDIM library provides excellent acceleration for many modern
network cards. However, the default profiles of DIM limits its maximum
capabilities for different NICs, so providing a way which the NIC can
be custom configured is necessary.

Currently, interaction with the driver is still based on the commonly
used "ethtool -C".

Since the profile now exists in netdevice, adding a function similar
to net_dim_get_rx_moderation_dev() with netdevice as argument is
nice, but this would be better along with cleaning up the rest of
the drivers, which we can get to very soon after this set.

Please review, thank you very much!

Changelog
=====
v5->v6:
  - Place the profile in netdevice to bypass the driver.
    The interaction code of ethtool <-> kernel has not changed at all,
    only the interaction part of kernel <-> driver has changed.

v4->v5:
  - Update some snippets from Kuba, Thanks.

v3->v4:
  - Some tiny updates and patch 1 only add a new comment.

v2->v3:
  - Break up the attributes to avoid the use of raw c structs.
  - Use per-device profile instead of global profile in the driver.

v1->v2:
  - Use ethtool tool instead of net-sysfs

V1 link:
https://lore.kernel.org/all/1710421773-61277-1-git-send-email-hengqi@linux.alibaba.com/#r

Heng Qi (4):
  linux/dim: move useful macros to .h file
  ethtool: provide customized dim profile management
  virtio-net: refactor dim initialization/destruction
  virtio-net: support dim profile fine-tuning

 Documentation/netlink/specs/ethtool.yaml     |  33 +++++
 Documentation/networking/ethtool-netlink.rst |   8 ++
 drivers/net/virtio_net.c                     |  45 +++++--
 include/linux/dim.h                          |  13 ++
 include/linux/ethtool.h                      |  12 +-
 include/linux/netdevice.h                    |  15 +++
 include/uapi/linux/ethtool_netlink.h         |  24 ++++
 lib/dim/net_dim.c                            |  10 +-
 net/core/dev.c                               |  63 +++++++++
 net/ethtool/coalesce.c                       | 184 ++++++++++++++++++++++++++-
 10 files changed, 383 insertions(+), 24 deletions(-)

-- 
1.8.3.1

