Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D820D12EBC9
	for <virtualization@lists.linux.dev>; Wed, 28 Feb 2024 11:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709118314; cv=none; b=HYeNFe0j7EAdcSHE8yjDXShADBRTRBcocG2WLEqvjRsGRFSFyAhBAHvUp43HoAjdaV2wpsjP7CuvdKcBwCZFz16cHxU6JF9v8Iyy8wR7cbcQm3063fwQcZGeavX6nV9eujbiKgJr8EpYrTEwlKxRFq947s6+ST0+8rgntla5qSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709118314; c=relaxed/simple;
	bh=fzby08iFoLHHuRG0MLFoUXRbZcJapueKM6rj/Q2uFY4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V+0BpbBFH0L0ggAb9Dd13yb1v8P6i1wl6MzKvJTeX/vs5ip99Ug9trrkTsntExDwdcN0lp1bGW0Mw1JioecJzbPg5xQweAjeinrKoS9akNOf6M9vYLzAIaLsl637Y8iGUOEdhw5K4MZ95Uj5d4pPVYczu6EOiWEA2UpAoKtzqXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TlBK83Vw5z2BdmP;
	Wed, 28 Feb 2024 19:02:52 +0800 (CST)
Received: from dggpemm500008.china.huawei.com (unknown [7.185.36.136])
	by mail.maildlp.com (Postfix) with ESMTPS id 813BE18002F;
	Wed, 28 Feb 2024 19:05:07 +0800 (CST)
Received: from localhost (10.174.242.157) by dggpemm500008.china.huawei.com
 (7.185.36.136) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 28 Feb
 2024 19:05:07 +0800
From: Yunjian Wang <wangyunjian@huawei.com>
To: <mst@redhat.com>, <willemdebruijn.kernel@gmail.com>,
	<jasowang@redhat.com>, <kuba@kernel.org>, <bjorn@kernel.org>,
	<magnus.karlsson@intel.com>, <maciej.fijalkowski@intel.com>,
	<jonathan.lemon@gmail.com>, <davem@davemloft.net>
CC: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<virtualization@lists.linux.dev>, <xudingke@huawei.com>,
	<liwei395@huawei.com>, Yunjian Wang <wangyunjian@huawei.com>
Subject: [PATCH net-next v2 0/3] tun: AF_XDP Tx zero-copy support
Date: Wed, 28 Feb 2024 19:04:41 +0800
Message-ID: <1709118281-125508-1-git-send-email-wangyunjian@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500008.china.huawei.com (7.185.36.136)

Hi all:

Now, some drivers support the zero-copy feature of AF_XDP sockets,
which can significantly reduce CPU utilization for XDP programs.

This patch set allows TUN to also support the AF_XDP Tx zero-copy
feature. It is based on Linux 6.8.0+(openEuler 23.09) and has
successfully passed Netperf and Netserver stress testing with
multiple streams between VM A and VM B, using AF_XDP and OVS.

The performance testing was performed on a Intel E5-2620 2.40GHz
machine. Traffic were generated/send through TUN(testpmd txonly
with AF_XDP) to VM (testpmd rxonly in guest).

+------+---------+---------+---------+
|      |   copy  |zero-copy| speedup |
+------+---------+---------+---------+
| UDP  |   Mpps  |   Mpps  |    %    |
| 64   |   2.5   |   4.0   |   60%   |
| 512  |   2.1   |   3.6   |   71%   |
| 1024 |   1.9   |   3.3   |   73%   |
+------+---------+---------+---------+

Yunjian Wang (3):
  xsk: Remove non-zero 'dma_page' check in xp_assign_dev
  vhost_net: Call peek_len when using xdp
  tun: AF_XDP Tx zero-copy support

 drivers/net/tun.c       | 177 ++++++++++++++++++++++++++++++++++++++--
 drivers/vhost/net.c     |  21 +++--
 include/linux/if_tun.h  |  32 ++++++++
 net/xdp/xsk_buff_pool.c |   7 --
 4 files changed, 220 insertions(+), 17 deletions(-)

-- 
2.41.0

