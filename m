Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72CC2E84F
	for <virtualization@lists.linux.dev>; Mon, 18 Mar 2024 11:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710760286; cv=none; b=KU52CaIDePGvgDKMuhA4x5vsoB2ju18Loa5/SYGDN+Wdc51l52xU6kuGy09Sg+id9wO0255ZB43W1AafAWsmvdKNp9wg30xKv2DrFrumdTxuBiNIoEhKAeBaRkLS2q3/6YcXTzOtpQH676VQrJZT+hS5Vl8KFuhOoQpgKjQI7tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710760286; c=relaxed/simple;
	bh=fCgqSvcHzLUQLwSslusWMTUlaB5KtdB3z8BRGYI+lwY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AQC8EqEOunQklhT83cd4plXmQiMbRDWDgSMZR1W2UB2eH6BjXtsoGs9/luQGvuWlYD4IRpt5VDs3j+iw9/ppYQWRXZmqVxGlnsdIx/ESmtppA1+Y4+7gwvqrpVNnbOPweB2N5QHdmF8xDr08gkoKbDxDf8dw7fHnL1r8QlJEOS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=T9TZljfg; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="T9TZljfg"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710760281; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=SO6YPIuQxLYvEFLdr9SIDSwamm3sbpWOMdAZN1KZ5YM=;
	b=T9TZljfgArWmfXuOBqNGebEkgirOoVYzBDdJ642/QsgactTCmg9WjTLJEiJd/tQsU5KzuacY8DA202av64YkwbGEd7U4IlSDF5OM2v6L2GCP7JDtFCltuv2eBYtXD1kju6CSL2ybmnWAPtna3N+H5Gt5/WNs3O+ojIolyQoa/no=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W2mLkWk_1710759962;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W2mLkWk_1710759962)
          by smtp.aliyun-inc.com;
          Mon, 18 Mar 2024 19:06:03 +0800
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
Subject: [PATCH net-next v5 0/9] virtio-net: support device stats
Date: Mon, 18 Mar 2024 19:05:53 +0800
Message-Id: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 0059ee1bd6b4
Content-Transfer-Encoding: 8bit

As the spec:

https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82

The virtio net supports to get device stats.

Please review.

Thanks.

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






Xuan Zhuo (9):
  virtio_net: introduce device stats feature and structures
  virtio_net: virtnet_send_command supports command-specific-result
  virtio_net: remove "_queue" from ethtool -S
  virtio_net: support device stats
  virtio_net: stats map include driver stats
  virtio_net: add the total stats field
  virtio_net: rename stat tx_timeout to timeout
  netdev: add queue stats
  virtio-net: support queue stat

 Documentation/netlink/specs/netdev.yaml | 104 ++++
 drivers/net/virtio_net.c                | 755 +++++++++++++++++++++---
 include/net/netdev_queues.h             |  27 +
 include/uapi/linux/netdev.h             |  19 +
 include/uapi/linux/virtio_net.h         | 143 +++++
 net/core/netdev-genl.c                  |  23 +-
 tools/include/uapi/linux/netdev.h       |  19 +
 7 files changed, 1013 insertions(+), 77 deletions(-)

--
2.32.0.3.g01195cf9f

