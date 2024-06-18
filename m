Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B563197A7B
	for <virtualization@lists.linux.dev>; Tue, 18 Jun 2024 02:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718679410; cv=none; b=Iu0L+mmKQJDoFTeNQlR6P1s+uUUM4SXFuy57sD6S+4Mp1RMTqsSQZErWZBdr8U6C89/HdMo7F0je0F26B8tN4OXPaqGT2r7836SKEtp1fP0lb0GwxnoArhcPLp/XXQxaI+VFziHQJRqV+oj5i33Wruf3QTYLv0Mrr5WgH3PL8P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718679410; c=relaxed/simple;
	bh=+MshPmHblm6iM9NgyporGfSjNK0JnormQPLXJUQ0jDI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mDkQxYFIQcrafHET0DzOy172MviRdUOr2bC70UO3TuwrHztzmpSKP4vxqVtxjzjxRhXILnjv7BnkHZ7/QNUnVvc58chILty46yjp/rjI6+cm2NQbwUZY37Hzhc8jMoH32JKqImgNKHe4xDwJW7tNy9ruF/0PsZ4X2A65HQoEfd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NNUHnkQm; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NNUHnkQm"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718679406; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=OzQUJeu4o6rO0toRIPj3mcwXDT38eU3Roh56NCFZeLE=;
	b=NNUHnkQmjCZ546bP0t5yo7xD1b8auUQbAFbpWnOtfePTRUY6KbXgcPo/+bzo9N8Ax5bTQoe08s+M98ueQZKOyz6OFeLaKnu9DcbavjDc+wmT9XvD5YoBjE3iVcC0vT/ZFg3fCSNkILzBD8kD/1/O7HwoHtK3EGz683lJaToDNWo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=31;SR=0;TI=SMTPD_---0W8iG1a0_1718679404;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W8iG1a0_1718679404)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 10:56:45 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Brett Creeley <bcreeley@amd.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Tal Gilboa <talgi@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	justinstitt@google.com,
	donald.hunter@gmail.com,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	awel Dembicki <paweldembicki@gmail.com>
Subject: [PATCH RESEND net-next v14 0/5] ethtool: provide the dim profile fine-tuning channel
Date: Tue, 18 Jun 2024 10:56:39 +0800
Message-Id: <20240618025644.25754-1-hengqi@linux.alibaba.com>
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

Currently, the way is based on the commonly used "ethtool -C".

Please review, thank you very much!

Changelog
=====
Jakub feedback: Use RESEND to refresh the review queue.

v13->v14:
  - Make DIMLIB dependent on NET (patch 2/5).

v12->v13:
  - Rebase net-next to fix the one-line conflict.
  - Update tiny comments.
  - Config ETHTOOL_NETLINK to select DIMLIB.

v11->v12:
  - Remove the use of IS_ENABLED(DIMLIB).
  - Update Simon's htmldoc hint.

v10->v11:
  - Fix and clean up some issues from Kuba, thanks.
  - Rebase net-next/main

v9->v10:
  - Collect dim related flags/mode/work into one place.
  - Use rx_profile + tx_profile instead of four profiles.
  - Add several helps.
  - Update commit logs.

v8->v9:
  - Fix the compilation error of conflicting names of rx_profile in
    dim.h and ice driver: in dim.h, rx_profile is replaced with
    dim_rx_profile. So does tx_profile.

v7->v8:
  - Use kmemdup() instead of kzalloc()/memcpy() in dev_dim_profile_init().

v6->v7:
  - A new wrapper struct pointer is used in struct net_device.
  - Add IS_ENABLED(CONFIG_DIMLIB) to avoid compiler warnings.
  - Profile fields changed from u16 to u32.

v5->v6:
  - Place the profile in netdevice to bypass the driver.
    The interaction code of ethtool <-> kernel has not changed at all,
    only the interaction part of kernel <-> driver has changed.

v4->v5:
  - Update some snippets from Kuba.

v3->v4:
  - Some tiny updates and patch 1 only add a new comment.

v2->v3:
  - Break up the attributes to avoid the use of raw c structs.
  - Use per-device profile instead of global profile in the driver.

v1->v2:
  - Use ethtool tool instead of net-sysfs.

Heng Qi (5):
  linux/dim: move useful macros to .h file
  dim: make DIMLIB dependent on NET
  ethtool: provide customized dim profile management
  dim: add new interfaces for initialization and getting results
  virtio-net: support dim profile fine-tuning

 Documentation/netlink/specs/ethtool.yaml     |  31 +++
 Documentation/networking/ethtool-netlink.rst |   4 +
 Documentation/networking/net_dim.rst         |  42 +++
 drivers/net/virtio_net.c                     |  54 +++-
 drivers/soc/fsl/Kconfig                      |   2 +-
 include/linux/dim.h                          | 113 ++++++++
 include/linux/ethtool.h                      |   4 +-
 include/linux/netdevice.h                    |   3 +
 include/uapi/linux/ethtool_netlink.h         |  22 ++
 lib/Kconfig                                  |   1 +
 lib/dim/net_dim.c                            | 144 +++++++++-
 net/Kconfig                                  |   1 +
 net/ethtool/coalesce.c                       | 263 ++++++++++++++++++-
 13 files changed, 667 insertions(+), 17 deletions(-)

-- 
2.32.0.3.g01195cf9f

