Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BAD16E892
	for <virtualization@lists.linux.dev>; Fri, 21 Jun 2024 10:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718964839; cv=none; b=GSIV44AYkIZOkkELs1L+8ChMR3XqP2rkgLFhK3Ljh3RnORhuk6VdCYnnvn8SHz7iK6qozcNpTG8t6qHSwXrSf9AE0vgY65su+xNhdRevpOskcl4jIpVMESWRDa98Fpw4YMVPfGOomrvt9fV2ieqCaBrykIXuvXCVP/eTF14qnmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718964839; c=relaxed/simple;
	bh=H+iVrQ6EShMIb5pA0DE0fQxdrFQTOtSDbaixzspfdYM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V6/dajf5bU11tlI084z/O8V7MWiKq7cT4CrOV90QYEHRoIdq790FSDjRxHSSqRsMFpybp8X7uZCf/y7uAr7+z+uIgK8MG12eJ/B4pvvQxlg39mZDW1LaOqERdyX4kS3U74hhLIEIa5zHGXee4Saqdwb1+OuVGqTlhlongabdRdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DMV7szVM; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DMV7szVM"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718964834; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=06bRi18a2rHKR+TMi3cUkFCw+ljlSnrFlCaSX6QTHNU=;
	b=DMV7szVMQJwqgB6FWr/9MkfjD96ssE5MOgpf7wmkQSbLG6zDC3xtWUEmZilpUuAGq1u6z74V/r0532hP9vSXwMO/N41wdgqfKQLFp0/XfAppFf37q8WeEAI5J+fgpXZkwyYPlBhg8hwxq8490LwUFBGuLAqPjMVFtQ0U3Vzjeto=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=31;SR=0;TI=SMTPD_---0W8w4rvH_1718964833;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W8w4rvH_1718964833)
          by smtp.aliyun-inc.com;
          Fri, 21 Jun 2024 18:13:54 +0800
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
Subject: [PATCH net-next v15 0/5] ethtool: provide the dim profile fine-tuning channel
Date: Fri, 21 Jun 2024 18:13:48 +0800
Message-Id: <20240621101353.107425-1-hengqi@linux.alibaba.com>
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

For example,
on the server side, the virtio-net NIC with rx dim enabled has 8
queues and runs nginx.
The client uses the following command to send traffic to the server:
  ./wrk http://server_ip:80 -c 64 -t 5 -d 30

Then adjust the default rx-profile for server dim to

  {.usec =   1, .pkts = 256, .comps = n/a,},
  {.usec =   8, .pkts = 256, .comps = n/a,},
  {.usec =  30, .pkts = 256, .comps = n/a,},
  {.usec =  64, .pkts = 256, .comps = n/a,},
  {.usec = 128, .pkts = 256, .comps = n/a,}

The server PPS is improved by 20%+.

Please review, thank you very much!

Changelog
=====
v14->v15:
  - Modify the mod bit and add some hints.

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
 Documentation/networking/ethtool-netlink.rst |   8 +
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
 net/ethtool/coalesce.c                       | 273 ++++++++++++++++++-
 13 files changed, 681 insertions(+), 17 deletions(-)

-- 
2.32.0.3.g01195cf9f

