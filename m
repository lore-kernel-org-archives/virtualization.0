Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAC417C64
	for <virtualization@lists.linux.dev>; Wed, 24 Jan 2024 09:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706089050; cv=none; b=DmwnVbKRopcva6TIEWcqGWGOZbR9OvhQ4y2Q89woqf1z/J2/lfJlkX7dglaqArqo+OfK0L5Y/p14UKzz3DvsDH+5nhxKC0RMojIbnWK1s8Qwy5pTcog56E4xro2S5nE3ppyUJKNT45ZdojHfpoU8rf29qqJ3x0VAt3DRXwtd3+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706089050; c=relaxed/simple;
	bh=i+ZM0hNIhVIqVlp2Bod0gvVtrEZ+RF/w+9JYxHJo0Rk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pKn0vaR6MJ7R+1nTOPONxn1UK+ewaHW5Tx+qggJIXD2O+ofEoTVel0mfSUBF+CHIloigUk8TZQiCdVxu1nyzjUHoP8NcuTm1pGZcNxKRHo/JDs98NiLP7acufT224knNwSjaaQYGkq7khQX+EnSJ9ADZmY4+22GcP9198J/Nduc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TKf2k2yDlz1gxyB;
	Wed, 24 Jan 2024 17:35:42 +0800 (CST)
Received: from dggpemm500008.china.huawei.com (unknown [7.185.36.136])
	by mail.maildlp.com (Postfix) with ESMTPS id 75F99140155;
	Wed, 24 Jan 2024 17:37:26 +0800 (CST)
Received: from localhost (10.174.242.157) by dggpemm500008.china.huawei.com
 (7.185.36.136) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Jan
 2024 17:37:26 +0800
From: Yunjian Wang <wangyunjian@huawei.com>
To: <mst@redhat.com>, <willemdebruijn.kernel@gmail.com>,
	<jasowang@redhat.com>, <kuba@kernel.org>, <davem@davemloft.net>,
	<magnus.karlsson@intel.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <virtualization@lists.linux.dev>,
	<xudingke@huawei.com>, Yunjian Wang <wangyunjian@huawei.com>
Subject: [PATCH net-next 0/2] tun: AF_XDP Rx zero-copy support
Date: Wed, 24 Jan 2024 17:37:24 +0800
Message-ID: <1706089044-28932-1-git-send-email-wangyunjian@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500008.china.huawei.com (7.185.36.136)

Now, some drivers support the zero-copy feature of AF_XDP sockets,
which can significantly reduce CPU utilization for XDP programs.

This patch set enables tun to also support the AF_XDP Rx zero-copy
feature, with the following changes:
1. The unnecessary 'dma_page' check has been removed when binding
the AF_XDP socket to the device, as it is not needed for the vNIC.
2. A check has been added when consuming the buffer in
vhost_net_buf_produce(), as the vq's rx_array may be empty after
AF_XDP Rx zero-copy is enabled.
3. The peek_len function is now used to consume a xsk->desc and
retrieve its length.
4. AF_XDP Rx zero-copy support has been added for tun.

This patchset is based on Linux 6.4.0+(openEuler 23.09) and has
successfully passed Netperf and Netserver stress testing with
multiple streams between VM A and VM B, using AF_XDP and OVS.

With this patch applied, the system CPU usage for OVS' PMD has
decreased from 59.8% to 8.8% while forwarding 700000pps. 

Yunjian Wang (2):
  xsk: Remove non-zero 'dma_page' check in xp_assign_dev
  tun: AF_XDP Rx zero-copy support

 drivers/net/tun.c       | 165 +++++++++++++++++++++++++++++++++++++++-
 drivers/vhost/net.c     |  18 +++--
 net/xdp/xsk_buff_pool.c |   7 --
 3 files changed, 176 insertions(+), 14 deletions(-)

-- 
2.33.0

