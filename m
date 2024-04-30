Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE4C180A8E
	for <virtualization@lists.linux.dev>; Tue, 30 Apr 2024 17:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714498309; cv=none; b=KGp5uSQxBayF4RMbast8YtONlD359xjxxTLxaBA8Elyb3YtRcYvWK+Ksw6Xlwn6/W1lQgVt26jC7CRoIuQzR76W8rfe9GuP8mlF8Y5ndFI6ObvFqx+EkdtSq5YjGiFPr65+FQJe1macMjLcJs8Aa00IMTC7fzxFWdszc1OgHdRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714498309; c=relaxed/simple;
	bh=35wJNzCtc3YlHo7W5Fcjr+gnMzorolWtmPw4Tagx2O8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mblivAx2uVD+EgWAazTnbRKOkAL1MwFw78RYE3RxaU62YITCfsUCLQl32TXGbkqkrK0nlrFAdqXPrV/njhd2/C8wDEL7YArD1ovuhfxQkNxSquA7K+kuydjJZQcPexPjja7k0s75UQNq1qVoYNgv3wmA8NYlKoIkUPWi0POCxII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Tah33pe4; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Tah33pe4"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714498298; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=WQP0KNwV8WJxKA5ty6Apja/BByTogFld6Sod7EGrQNI=;
	b=Tah33pe4ebKX60EsCZbrg7xmYJpKA82pCeIrdy+f3lf2vV1M9vSa5zUC+gRgYOqRuu3/+RIqLSGyiyYC5B5GiYAsdHDCFxoYgFoXxz/rHWkbGCLgWNGavyLdUXolmdbnb/uxbfpSD/wdgG9GzsrolXCt1dPXgrqCUD8h4P8Tv0Q=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0W5coJt0_1714498296;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W5coJt0_1714498296)
          by smtp.aliyun-inc.com;
          Wed, 01 May 2024 01:31:37 +0800
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
	justinstitt@google.com
Subject: [PATCH net-next v11 0/4] ethtool: provide the dim profile fine-tuning channel
Date: Wed,  1 May 2024 01:31:32 +0800
Message-Id: <20240430173136.15807-1-hengqi@linux.alibaba.com>
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

Heng Qi (4):
  linux/dim: move useful macros to .h file
  ethtool: provide customized dim profile management
  dim: add new interfaces for initialization and getting results
  virtio-net: support dim profile fine-tuning

 Documentation/netlink/specs/ethtool.yaml     |  31 +++
 Documentation/networking/ethtool-netlink.rst |   4 +
 drivers/net/virtio_net.c                     |  48 +++-
 include/linux/dim.h                          | 117 ++++++++
 include/linux/ethtool.h                      |   7 +-
 include/linux/netdevice.h                    |   5 +
 include/uapi/linux/ethtool_netlink.h         |  22 ++
 lib/dim/net_dim.c                            | 145 +++++++++-
 net/ethtool/coalesce.c                       | 278 ++++++++++++++++++-
 9 files changed, 642 insertions(+), 15 deletions(-)

-- 
2.32.0.3.g01195cf9f

