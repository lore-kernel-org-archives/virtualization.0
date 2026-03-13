Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF27370D4E
	for <virtualization@lists.linux.dev>; Fri, 13 Mar 2026 07:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773388781; cv=none; b=N2lOzkJn4m3Rzx3UqNDpL9W9s4HUAMDtRw8ZymQ9y0mqWc/i1IEaqWeFLC4drOKmNMD7FvV8AdBKhnl1E4l0EUl7KvWfJRINtonMeIOTPDi0UpeVdAHaNply4AffC/kcj1zGjToiFiwZnEdbwuC/gXu/tDLM9pFjPi2BodYS8Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773388781; c=relaxed/simple;
	bh=MYyMMU1Du++tzLOlJtIp3iotj8PnHwwoUscHu/hkbzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ScP10lSu85BaCdm+FkidvMu5FjiQ15feuTPafEw0i8Us4FHmKZNuYfhXeCGhUTLybWKEVaebyzGZASJ55yngz7Y0ODoOCwWmbL489n/l26BQ0fy1zzskZerogRRjEQ7mqMfy5gKi5XGJvWzAYeuILTtiXLtOdhnOiWeMjdwmEvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iPxY4moK; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iPxY4moK"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773388771; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=RkewW+UPGm5sUsDrTafo2siuSQ5CLaL8ZZDVq9blTuc=;
	b=iPxY4moKTQMu2o7QCkkEwMlLKme+jrSbBM+jT9j8tPMX+ialxC+7JEFd+acAyyjlhm9hQS+tHp0zTGHTYb7Ahg45/Ocb401jnJ5LnpvhWsCiJCpmvuZEsmRsbmghUYrpQ4hplVxxlm6Rq+hmYwOMcCRfM9LWiBTRC2o/4+7yNE8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X-rej9y_1773388770;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X-rej9y_1773388770 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 13 Mar 2026 15:59:30 +0800
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
Subject: [PATCH net v10 0/2] virtio-net: fix for VIRTIO_NET_F_GUEST_HDRLEN
Date: Fri, 13 Mar 2026 15:59:28 +0800
Message-Id: <20260313075930.105466-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: ad5d7fbc23b6
Content-Transfer-Encoding: 8bit

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
 include/linux/virtio_net.h | 51 +++++++++++++++++++++++++++++++++++---
 3 files changed, 53 insertions(+), 6 deletions(-)

--
2.32.0.3.g01195cf9f

