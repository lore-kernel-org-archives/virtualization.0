Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308C413BC30
	for <virtualization@lists.linux.dev>; Tue,  9 Jul 2024 08:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720512162; cv=none; b=aBZK8R2DEVbEcmlgR53R+l1kGOYHacpEuHQ2vi1NPjo+T24a6a3GgMoFiPsZ6v9k3T/w2kvoGKbIInd9/9sobt6lWfO6shEHxuwK5D/p8wFOgdvvIbLrDVWbWFDEsV7CtMmk7b5tR55wkNa2UBDPvrJnAcnJCjR8B/X0Lkrlxzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720512162; c=relaxed/simple;
	bh=8bjvqhIUHv06pwEVOdLngXv4a3q5jy3kMHzCrcTRqSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dHwcH1zYSSMUl4ArrijWKZ1mq4ebC3QOqwGidD5+ofee/KFSZ/zZHVhFyXHSu7XFuaVPnAJGoSFvutuRorG9xnLnyB98LswMCbB9C4BJlC8I+c9KUM+0g1Db2pYIUaY7MBbw7DTp+/MkfDeVFMXg3rrLUbtDsED9HqUTgpCTx7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dp86UQZ/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dp86UQZ/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720512159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z2XY86t79jfijXCYuzeepS/qeKvZxJClxQpdTwloLiQ=;
	b=dp86UQZ/j3yKsjOnyRmO+Xham3heE1UftHC1ZaFNNbeslkidcE1rXnxiR2mrf09LIKkpe2
	yfH9TCLez2uCgjhBsyCL5ZiCFrYjxC/lIdHaw5DmqHU6a54qyEpfktJYUdyK1Ftt0jGaYY
	v/eQfYewN9/k0K4KO0seLovrc+ezwt8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-qB1dxj1HP-SbrUjy8u08Zw-1; Tue,
 09 Jul 2024 04:02:34 -0400
X-MC-Unique: qB1dxj1HP-SbrUjy8u08Zw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4142A1936185;
	Tue,  9 Jul 2024 08:02:32 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.184])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 64E9E3000184;
	Tue,  9 Jul 2024 08:02:25 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH net-next v3 0/3] virtio-net: synchronize op/admin state
Date: Tue,  9 Jul 2024 16:02:11 +0800
Message-ID: <20240709080214.9790-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi All:

This series tries to synchronize the operstate with the admin state
which allows the lower virtio-net to propagate the link status to the
upper devices like macvlan.

This is done by toggling carrier during ndo_open/stop.

Changes since V2:

- introduce config_driver_disabled and helpers
- schedule config change work unconditionally

Jason Wang (3):
  virtio: rename virtio_config_enabled to virtio_config_core_enabled
  virtio: allow driver to disable the configure change notification
  virtio-net: synchronize operstate with admin state on up/down

 drivers/net/virtio_net.c | 64 ++++++++++++++++++++++++----------------
 drivers/virtio/virtio.c  | 59 ++++++++++++++++++++++++++++--------
 include/linux/virtio.h   | 11 +++++--
 3 files changed, 93 insertions(+), 41 deletions(-)

-- 
2.31.1

