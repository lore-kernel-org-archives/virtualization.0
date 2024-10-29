Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF26E204940
	for <virtualization@lists.linux.dev>; Tue, 29 Oct 2024 08:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730191588; cv=none; b=gkoGQ2wNA2TO/8wvG+ZH2rgL3B5KlM2MpF7pBOxr2VMRSeCrpyHipbLHAV4NAMXYBHO4m42VO6gIJHWs+uUsCrcMWfax8O4hC4okVPHDc+ODrx5Xy2mvTuqmGBq8qDFEa4mhGT+ke0Wi6TGqRaKFKEmGPKl4XMy4N1lnPnBqAio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730191588; c=relaxed/simple;
	bh=wZPGIzaVxpSzU7iP5qw8KfOY6es//JAet87HXgw1HAo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zk+2E8A8QUjt6VfRR2ETmg/pK6bWxXrSDWAEPXSrA1K+opQXo/O2hB8IKVsZ0Q4VZIXcZM0BTHPbYLrh/U7gNnDNCxj7QVc0DKD4STZQxs/8MZwWpft8mJn955nkTBr0bJbok+6UUaIbDARDUwT3JvcbJ/PQLtZDZ8zI3FXnnio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=udRfiqJX; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="udRfiqJX"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730191577; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=42obp0MsqZAIYzXHKbVbAqEFN7VlFdIoHEinuFgp9dA=;
	b=udRfiqJXE94XMrYUPe5Sg0IFN6HU9IU7K+BhsgwflQyDdKFOwJjtjh99+NYGR2PvCvXKQStGWj5h3DGl3F3Qvwn94ScWuTFPw2Z7+9FFunhrg1j8XVcuMWwVPTdVmbVzck5CVlMSMXttMMTJBQzXJmSYeoB+FrJH2MZWT8pJHwE=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WI9W1EZ_1730191575 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 29 Oct 2024 16:46:16 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net-next v1 0/4] virtio_net: enable premapped mode by default
Date: Tue, 29 Oct 2024 16:46:11 +0800
Message-Id: <20241029084615.91049-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: df8220a5376e
Content-Transfer-Encoding: 8bit

v1:
    1. fix some small problems
    2. remove commit "virtio_net: introduce vi->mode"

In the last linux version, we disabled this feature to fix the
regress[1].

The patch set is try to fix the problem and re-enable it.

More info: http://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@linux.alibaba.com

Thanks.

[1]: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com


Xuan Zhuo (4):
  virtio-net: fix overflow inside virtnet_rq_alloc
  virtio_net: big mode skip the unmap check
  virtio_net: enable premapped mode for merge and small by default
  virtio_net: rx remove premapped failover code

 drivers/net/virtio_net.c | 113 +++++++++++++++++++++++----------------
 1 file changed, 66 insertions(+), 47 deletions(-)

--
2.32.0.3.g01195cf9f

