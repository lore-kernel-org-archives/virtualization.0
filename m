Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ED03D552
	for <virtualization@lists.linux.dev>; Wed, 14 Aug 2024 05:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723612967; cv=none; b=jVqCLabG8bSHT/FFZfy/A7BCodasipy++cz8q+/qiL5jEXdmR2TwuUszGbexJCitu+EiIPp+u1Qkf+h16wHgw0tfatmAQwqMdWzAlVTlGM5XzxQzJJuGCl41dzIo/WDorwwf3pvlY/17+e435644IPKPcQDHosquHb2dD4e49Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723612967; c=relaxed/simple;
	bh=IOCRvGR8JTbHqufXojjCfbAeFcEmkXITGBm9jIc66Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KMUhLmEgrLPyaMbu7P93n4v+Mz+bfxcfAwlFAXQfDLH53Mv4asGUevzKvNZezu3dMEwS+UbcHGF2sBTzWZv1BUzKuy2vbL/mtSpIFEFr5A9Bz2O9ULtgVLeQSf/AViRaK3u0B0eF8XKRmx7NCO2YAkqWBJX62JuaaENNA2aGjl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PVC61AGr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PVC61AGr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723612963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iLnxfC0hbO2g1lDT29unWn+v2IZLR7S+7ro5YQTLaS8=;
	b=PVC61AGrWCvi+5Y2ibU1r77/tFfXdbfR21+74//TTVWbmiZdabU05vWcTybcE5RmhkM9lH
	iGKcn2F0LEv89Eav2ZhupH+P+144sB6cOMT5q6l1Pn+kThQuqf6yKjbyhYQYZAxjhy6G1l
	idYrxnlFgqSyjzisAJ5+y3f8sNsi7l4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-iJ2CRsz3MQ6S2iZsqyXiig-1; Wed,
 14 Aug 2024 01:22:41 -0400
X-MC-Unique: iJ2CRsz3MQ6S2iZsqyXiig-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 331401955F40;
	Wed, 14 Aug 2024 05:22:39 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.38])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1AC3B1944A95;
	Wed, 14 Aug 2024 05:22:31 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	venkat.x.venkatsubra@oracle.com,
	gia-khanh.nguyen@oracle.com
Subject: [PATCH net-next v7 0/4] virtio-net: synchronize op/admin state
Date: Wed, 14 Aug 2024 13:22:24 +0800
Message-ID: <20240814052228.4654-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hi All:

This series tries to synchronize the operstate with the admin state
which allows the lower virtio-net to propagate the link status to the
upper devices like macvlan.

This is done by toggling carrier during ndo_open/stop while doing
other necessary serialization about the carrier settings during probe.

While at it, also fix a race between probe and ndo_set_features as we
didn't initalize the guest offload setting under rtnl lock.

Changes since V6:

- Add fix tag

Changes since V5:

- Fix sevreal typos
- Include a new patch to synchronize probe with ndo_set_features

Changes since V4:

- do not update settings during ndo_open()
- do not try to canel config noticiation during probe() as core make
  sure the config notificaiton won't be triggered before probe is
  done.
- Tweak sevreal comments.

Changes since V3:

- when driver tries to enable config interrupt, check pending
  interrupt and execute the nofitication change callback if necessary
- do not unconditonally trigger the config space read
- do not set LINK_UP flag in ndo_open/close but depends on the
  notification change
- disable config change notification until ndo_open()
- read the link status under the rtnl_lock() to prevent a race with
  ndo_open()

Changes since V2:

- introduce config_driver_disabled and helpers
- schedule config change work unconditionally

Thanks


Jason Wang (4):
  virtio: rename virtio_config_enabled to virtio_config_core_enabled
  virtio: allow driver to disable the configure change notification
  virtio-net: synchronize operstate with admin state on up/down
  virtio-net: synchronize probe with ndo_set_features

 drivers/net/virtio_net.c | 78 +++++++++++++++++++++++++---------------
 drivers/virtio/virtio.c  | 59 +++++++++++++++++++++++-------
 include/linux/virtio.h   | 11 ++++--
 3 files changed, 105 insertions(+), 43 deletions(-)

-- 
2.31.1

