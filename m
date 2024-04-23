Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436AD77F2D
	for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 11:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871908; cv=none; b=bPDzGAeCcINFVvM/MwfbUnTYbazj2a9YsT5CSQ93+2FFq2f6tBfx8icmKKGrz0Dz7OQj9pbjlNuMZN/LeqYpw77fy+n29awKn7uaHHG9KAVDcdfdPA7TEgKYraZG9zpK+MvMz3Inxx01Dd+HC/yH8xZ0wn02JJIpFPqeQzlcjtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871908; c=relaxed/simple;
	bh=1lPiGQ5shC4C7UOa4YIACl3pZn+ENy7c7yEhkeTIp38=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=adidXyjmbbu0DvjJpsYkH403Ih8dSB1Msi57yiA1jfeN4cvMBKBhhfsmwjL8iPgxI+mAneyiGSIei9UWbBafXY8A/d7JSlS/3cO1GDOPZygbmzl5sjx/1Ttl8Xocxsp3Qh5trLskHbRiF36BQUxPwBPN4l4vq+2xYGcALV0hqMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XtA9mcPP; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XtA9mcPP"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713871903; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=xoJ9YNLWXu7XQFYT7mcYJIil9lkfTlWRr3vGzICttBY=;
	b=XtA9mcPPFen/FB3BSDqiXtnxMOeK2FuWs0jeHjOuqgkXtdG8jZ9GFmbg+zOwCHODLiOnEm9zRuwPm1u/F2VRccX9trcWByOAYwZFfbEk2xPlE1QPpgGUo6YGQSxqhJxp0062uhobGRKQBB6dvEdaWQ1CXJx2KAP0VA6TVncN93w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W596LXQ_1713871901;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W596LXQ_1713871901)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 19:31:42 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next v6 0/8] virtio-net: support device stats
Date: Tue, 23 Apr 2024 19:31:33 +0800
Message-Id: <20240423113141.1752-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 75c95ace5f2d
Content-Transfer-Encoding: 8bit

As the spec:

https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82

The virtio net supports to get device stats.

Please review.

Thanks.

v6:
    1. remove 'maps'. check stats by if-else.

v5:
    1. Fix some small problems in last version
    2. Not report stats that will be reported by netlink
    3. remove "_queue" from  ethtool -S

v4:
    1. Support per-queue statistics API
    2. Fix some small problems in last version

v3:
    1. rebase net-next

v2:
    1. fix the usage of the leXX_to_cpu()
    2. add comment to the structure virtnet_stats_map

v1:
    1. fix some definitions of the marco and the struct







Xuan Zhuo (8):
  virtio_net: introduce device stats feature and structures
  virtio_net: remove "_queue" from ethtool -S
  virtio_net: support device stats
  virtio_net: device stats helpers support driver stats
  virtio_net: add the total stats field
  virtio_net: rename stat tx_timeout to timeout
  netdev: add queue stats
  virtio-net: support queue stat

 Documentation/netlink/specs/netdev.yaml | 104 +++
 drivers/net/virtio_net.c                | 969 ++++++++++++++++++++++--
 include/net/netdev_queues.h             |  27 +
 include/uapi/linux/netdev.h             |  19 +
 include/uapi/linux/virtio_net.h         | 143 ++++
 net/core/netdev-genl.c                  |  23 +-
 tools/include/uapi/linux/netdev.h       |  19 +
 7 files changed, 1247 insertions(+), 57 deletions(-)

--
2.32.0.3.g01195cf9f

