Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293E2324B32
	for <virtualization@lists.linux.dev>; Fri, 20 Mar 2026 02:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773973110; cv=none; b=Hf2gorUGA99bzYlfZly7lhOZ/QUe+zzIuj8mv2K4sJhVkyQ7To8IQGd2s3T3psLJmx0NmHINU5hw48w90lMA00NyeNyMe6p3MfYAcuFjCjvaNe5JMIY+5XtSbFnbQyvv2/WpAz/nEVjwUzf1I0Maqq/h1od0Bo2ZVw2WTRrdg50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773973110; c=relaxed/simple;
	bh=H74bMc39YOkASeARRE5W2jXwxfq5YprOQI9HpoZQJvg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WwjDdFaZbSLHpZenCFKkp9uijf0zBr/DU04hSR3ukrNOFK5YtbQjK+uaqLuxT32qlvsZNclU22BXhHynNJxKECQIeU3mzR7Fj7GTyX0ZkNoUJspQJiQDhjBU9hOcM7iAFcH19YGNS5ovo178CNNJBPJgfxKBXvM4uvSDli8H4OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=s9IX+NO9; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="s9IX+NO9"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773973099; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=RzIow3lYhzYELrv2HUKXaM/1pXNN4BTXgyhYVwM067A=;
	b=s9IX+NO9Z644bshxI/DMezdoZgKOqPJFaMRnfBRs7Nhup82NdASy1pkeWBwT6HlGPtRClo49fxvud/VwNZay25JytL/OWbZrhkRDG7bZXd4qvPUWDSCfOADUVoury8SGZIdF4/La/7XhGqa1pryfkSW1JshoaUkRcl7NZQuuZJE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X.JxA6q_1773973098;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X.JxA6q_1773973098 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 20 Mar 2026 10:18:19 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net v11 0/2] virtio-net: fix for VIRTIO_NET_F_GUEST_HDRLEN
Date: Fri, 20 Mar 2026 10:18:16 +0800
Message-Id: <20260320021818.111741-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: b52cc70b415f
Content-Transfer-Encoding: 8bit

v11:
  1. rename virtio_net_set_hdrlen() to __virtio_net_set_hdrlen(),
  virtio_net_set_tnl_hdrlen() to __virtio_net_set_tnl_hdrlen(), and add
  explicitly mention in a comment that such functions must be invoked only after
  virtio_net_hdr_from_skb()

v10:
  1. fix http://lore.kernel.org/all/202603122214.8Anoxrmq-lkp@intel.com

v9:
  1. Introduce new helpers to set hdr len, and virtio_net_hdr_tnl_from_skb
  calls them directly.

v8:
  1. move changes of virtio_net_hdr_from_skb for udp tunnel to #2
  2. remove change for num_sg

v7:
  1. fix bug reported by robot
  2. Still splitting into two commits, as the issues fixed originate from
     different commits. This separation makes it easier to selectively revert to
     previous versions.

v6:
  1. rename to guest_hdrlen
  2. introduce a function virtio_net_set_hdrlen to set the hdrlen

The commit be50da3e9d4a ("net: virtio_net: implement exact header length
guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
feature in virtio-net.

This feature requires virtio-net to set hdr_len to the actual header
length of the packet when transmitting, the number of
bytes from the start of the packet to the beginning of the
transport-layer payload.

However, in practice, hdr_len was being set using skb_headlen(skb),
which is clearly incorrect. This path set fixes that issue.

As discussed in [0], this version checks the VIRTIO_NET_F_GUEST_HDRLEN is
negotiated.


[0]: http://lore.kernel.org/all/20251029030913.20423-1-xuanzhuo@linux.alibaba.com







Xuan Zhuo (2):
  virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
  virtio-net: correct hdr_len handling for tunnel gso

 drivers/net/tun_vnet.h     |  2 +-
 drivers/net/virtio_net.c   |  6 ++++-
 include/linux/virtio_net.h | 53 +++++++++++++++++++++++++++++++++++---
 3 files changed, 55 insertions(+), 6 deletions(-)

--
2.32.0.3.g01195cf9f

