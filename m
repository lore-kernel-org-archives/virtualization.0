Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D45E71759
	for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 13:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188295; cv=none; b=OomuGb/20hCm996EOBrt/7z3aab+HM5KCo/o5kidL+5hSrRdYfJn2hUr6CbZpslGi4XiS6jBwjeLGxVmy/gogcAkcM7lbW1w+DBvpT4exNkeTD/idIxHILyduWGl1aLEWFGrg60xG30kgRfbtgZJasrRLwKHyuyQ98prbynrZbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188295; c=relaxed/simple;
	bh=/d7SjLufAQYsTDwWiGfZ1o7V3HHcOo3FsxfQLwOlhTc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b//Bn3U+qSbd8C0nDVtKwy/AjyUkEnPgViFbDKsBSPW2X5vt8hCE6TXtUJ9GMOZX+SamTH7XEyK45u1ZlqBIx07lLYYfVGvfgi5mWCxOvRbVTyPxp3I0bhfmbURGvlNGmu68dvBRlrWX/Dp8MUUATpSFHG2gFRsJHxCQM3VSFNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=b7VES+pl; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="b7VES+pl"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713188289; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=UtZX1IVwmOAZ6ZRj7d+cgmeMsf+v3RERAAt01/sNS8A=;
	b=b7VES+plcnAefRwayh1ycPpZ66zp1xelKJgcLcZVBtkVn46tz+DgsnhpWL+CGDY/VNBME7pZi6BHmPSCX8+UTx7iX0mPFNWw+jNn+W7et4uzUOQcUtVAtJ9X97IQDFMzDdLBG0vq/2ZzQmsE1Fn8k5E10wRrlJ9Z/5SiFHrMDSo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W4diK3k_1713188287;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4diK3k_1713188287)
          by smtp.aliyun-inc.com;
          Mon, 15 Apr 2024 21:38:08 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Brett Creeley <bcreeley@amd.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH RESEND net-next v7 0/4] ethtool: provide the dim profile fine-tuning channel
Date: Mon, 15 Apr 2024 21:38:03 +0800
Message-Id: <20240415133807.116394-1-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
v6->v7:
  - A new wrapper struct pointer is used in struct net_device.
  - Add IS_ENABLED(CONFIG_DIMLIB) to avoid compiler warnings.
  - Profile fields changed from u16 to u32.

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

Heng Qi (4):
  linux/dim: move useful macros to .h file
  ethtool: provide customized dim profile management
  virtio-net: refactor dim initialization/destruction
  virtio-net: support dim profile fine-tuning

Heng Qi (4):
  linux/dim: move useful macros to .h file
  ethtool: provide customized dim profile management
  virtio-net: refactor dim initialization/destruction
  virtio-net: support dim profile fine-tuning

 Documentation/netlink/specs/ethtool.yaml     |  33 +++
 Documentation/networking/ethtool-netlink.rst |   8 +
 drivers/net/virtio_net.c                     |  46 +++--
 include/linux/dim.h                          |  13 ++
 include/linux/ethtool.h                      |  11 +-
 include/linux/netdevice.h                    |  24 +++
 include/uapi/linux/ethtool_netlink.h         |  24 +++
 lib/dim/net_dim.c                            |  10 +-
 net/core/dev.c                               |  83 ++++++++
 net/ethtool/coalesce.c                       | 201 ++++++++++++++++++-
 10 files changed, 430 insertions(+), 23 deletions(-)

-- 
2.32.0.3.g01195cf9f

