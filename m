Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C514C97
	for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 02:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719197145; cv=none; b=BQePf/naPgfuCK1fTL2hypySs9EFnbCdpq/ecS2kvEunSatISNDAZMSxAnIbJbIcIphH2PIE32mBqMfVtfgtTKNHyrQVdiQfuBiMpw7b5rzd+FHsRl7UGSQHSoU5epcbTO0mIBBs/jQXQoA9Oxff5mwz6sZcQCelz0C1kWLPF6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719197145; c=relaxed/simple;
	bh=XC92MEoBDuw+dzFXqg9PSnivP55kcPz5nKy8QVj2YPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IYNlRtOPJsXOAdcNyJhczBVHubsGSktCRyPaW3HOqerNJpI8o7WUYrPm9orrXGXOAWZ54vpksgons3htWjDqQoBOM/lv/DnLdNSumF5Y1eT9FpPjmKKyIOaT4mCtiRaHXxs07r2GN5hokwgj5LE3JGkMTCkrngO8y+iMDCyOEzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UYQEgwfQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UYQEgwfQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719197142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CXcVRtn1cUdwEJYQmAZMfv47gdXae0jBBlAV4W8th1w=;
	b=UYQEgwfQE8f9jX1g4PFidmrCwe9gQa8gb2Qi31CVFnWGm8o1UygKndWT7eGZZRuxmrA411
	xwH+fQT4yG5z2ieydyKa3HH6jqi+jJVIcao5/Qczmq7AzKXjNGE2YL4K2z80eMJ0DQESsZ
	+TnTTzHj+AauVaEJygIlEIw6x65eT5s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-mTyUWo52McarW2ud3gBJtg-1; Sun,
 23 Jun 2024 22:45:37 -0400
X-MC-Unique: mTyUWo52McarW2ud3gBJtg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 76752195608C;
	Mon, 24 Jun 2024 02:45:35 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.150])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8D0AF3000218;
	Mon, 24 Jun 2024 02:45:27 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	venkat.x.venkatsubra@oracle.com,
	gia-khanh.nguyen@oracle.com
Subject: [PATCH V2 0/3] virtio-net: synchronize operstate with admin state on up/down
Date: Mon, 24 Jun 2024 10:45:20 +0800
Message-ID: <20240624024523.34272-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi All:

Currently, we don't synchronize the opersteate with the admin state
currently when prevent the link status to be propagated to the stacked
device on top of the virtio-net.

This patch fixes this issue.

Changes since V1:
- Try to reuse the virtio core facility to enable and disable the
  configure interrupt

Jason Wang (3):
  virtio: allow nested disabling of the configure interrupt
  virtio: export virtio_config_{enable|disable}()
  virtio-net: synchronize operstate with admin state on up/down

 drivers/net/virtio_net.c | 72 +++++++++++++++++++++++-----------------
 drivers/virtio/virtio.c  | 26 ++++++++++-----
 include/linux/virtio.h   |  5 ++-
 3 files changed, 63 insertions(+), 40 deletions(-)

-- 
2.31.1

