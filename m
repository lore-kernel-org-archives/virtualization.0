Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B41F77F1B
	for <virtualization@lists.linux.dev>; Tue,  2 Apr 2024 12:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712060001; cv=none; b=BoFJMwSIWeHcFHxl15Vom4kTz8Kl9AjeeG8O3Xgtx0UorI/CWsq1dZkOoFQICJJu4MQdiCS1k72/SZXBXnZ6PR0J0lAVB5Cami/Y246gwECgjfNU6stJKPvI4feNtaBuamfuw01hEBREym7IzRP4POo+Gjy18MZx8VcfvhYrTu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712060001; c=relaxed/simple;
	bh=XK4OTT6VC+B+XG7SIITThVz58AwJg8X2QabjnWlsH6A=;
	h=From:To:Cc:Subject:Date:Message-Id; b=C1bHMXTLOaQqqq84fndOXyXqOjcLn/PAgm9Kp9C1qOlu6ZpVtrJsUNkjq/D9TFcNj5F3d2OG5p8jFtgGdcKjpmbNDBGK7D9eBrAO6qKH3YmwaaAVVLCYBTKT9HFFfIOKbhhCaqItIh5vj5KroNamvyWvg/z8Ta/jtFDX5PuiThA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qM9wCsAA; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qM9wCsAA"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712059990; h=From:To:Subject:Date:Message-Id;
	bh=icRIIs4TR8+IsrlyXgj+2nMZMjoj3shYkTYVppy93Vs=;
	b=qM9wCsAAg5Ja5uVVNiDH4V9Coh+pTwKRvGCojZ0vA6j8mrgLTeSbZOnlG9q6DvQJAQxEBAELhz2z7tF4g48iOvLD9GBkAIGjGYVh9OWIweXtZcsEZBoaKc71lylk/AqtlS94D9DOEWKP17QgxA1kAA0O67EnkPBQjNuO+UIi2oA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W3oLGcp_1712059988;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W3oLGcp_1712059988)
          by smtp.aliyun-inc.com;
          Tue, 02 Apr 2024 20:13:09 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next v3 0/3] ethtool: provide the dim profile fine-tuning channel
Date: Tue,  2 Apr 2024 20:13:05 +0800
Message-Id: <1712059988-7705-1-git-send-email-hengqi@linux.alibaba.com>
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
used "ethtool -C". The driver declares its supported parameters based
on .supported_coalesce_params, and implements driver-related custom
restrictions in .set_coalesce and .get_coalesce.

Please review, thank you very much!

Changelog
=====
v2->v3:
  - Break up the attributes to avoid the use of raw c structs.
  - Use per-device profile instead of global profile in the driver.

v1->v2:
  - Use ethtool tool instead of net-sysfs

V1 link:
https://lore.kernel.org/all/1710421773-61277-1-git-send-email-hengqi@linux.alibaba.com/#r

Heng Qi (3):
  ethtool: provide customized dim profile management
  virtio-net: refactor dim initialization/destruction
  virtio-net: support dim profile fine-tuning

 Documentation/netlink/specs/ethtool.yaml     |  29 +++++
 Documentation/networking/ethtool-netlink.rst |   8 ++
 drivers/net/virtio_net.c                     |  79 ++++++++++---
 include/linux/dim.h                          |   7 ++
 include/linux/ethtool.h                      |  16 ++-
 include/linux/virtio_net.h                   |  11 ++
 include/uapi/linux/ethtool_netlink.h         |  24 ++++
 lib/dim/net_dim.c                            |   6 -
 net/ethtool/coalesce.c                       | 159 ++++++++++++++++++++++++++-
 9 files changed, 317 insertions(+), 22 deletions(-)

-- 
1.8.3.1

