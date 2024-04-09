Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C8F129E81
	for <virtualization@lists.linux.dev>; Tue,  9 Apr 2024 12:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712664212; cv=none; b=PslEw3Ypq2qXwZy9u+c/DcT8DLdRcnW5qNhfMibAcNvQG3N4ePdJZIjHqNWUyJvOcjQ45/wG/4EDfHw98WaRWHvpaSEYMlLb3iSRqTmHzt38cKOK4fFzdDMLrvs0CwGd83H7yBvd222XJtuAWrncurne2mLxIOJomTDFvLqM3jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712664212; c=relaxed/simple;
	bh=NB2Ik+IT/LX3n0oEUH2mUD/DRjiv4bwnANBVWYCCcuo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=DIau5wdTRlr4k/arV/mouzBlEBKR0odmjzLCmWgpRw+Wfzdi3Q1mLWJf6SQNpJbJ++OCJdSSwewgO1arjtdwVsZgWVyMJalrA3j98NFOyoA8+1NUmn7ZElsTMcjXxYrEe88vxpkgF+SbNt8v6lRsGhjAWaxYv8nqvnEEXH3DWa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tyJTKwbz; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tyJTKwbz"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712664205; h=From:To:Subject:Date:Message-Id;
	bh=+4cg4XZ/7lUfV+Czo+JlkdDx39ShI/3XveZMjCcdaIs=;
	b=tyJTKwbzCunhjZWE2cGL5JJ7ToqaDlEEMjoaVpUSVE1D+tNbe4kqNMTr/1FTW7i2f0rVX1euHD0qfej8jRbCpsXxxEoG+6niGM29gbCef74yJSkpPaHNRmLqKwtQx0cJqZ3gQtcOvudw/3Dng0tS2cRzKpinHSV/ofILAAa8vl8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W4EdXWf_1712664204;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4EdXWf_1712664204)
          by smtp.aliyun-inc.com;
          Tue, 09 Apr 2024 20:03:25 +0800
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
Subject: [PATCH net-next v5 0/4] ethtool: provide the dim profile fine-tuning channel
Date: Tue,  9 Apr 2024 20:03:20 +0800
Message-Id: <1712664204-83147-1-git-send-email-hengqi@linux.alibaba.com>
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
  ethtool: provide customized dim profile management
  linux/dim: move profiles from .c to .h file
  virtio-net: refactor dim initialization/destruction
  virtio-net: support dim profile fine-tuning

 Documentation/netlink/specs/ethtool.yaml     |  33 +++++
 Documentation/networking/ethtool-netlink.rst |   8 ++
 drivers/net/virtio_net.c                     |  78 ++++++++++--
 include/linux/dim.h                          |  45 +++++++
 include/linux/ethtool.h                      |  16 ++-
 include/uapi/linux/ethtool_netlink.h         |  24 ++++
 lib/dim/net_dim.c                            |  44 -------
 net/ethtool/coalesce.c                       | 172 ++++++++++++++++++++++++++-
 8 files changed, 360 insertions(+), 60 deletions(-)

-- 
1.8.3.1

