Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C512E3392
	for <virtualization@lists.linux.dev>; Mon, 24 Mar 2025 05:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742795029; cv=none; b=TQHNAyTQCMY0j0eKrGq7slN+f4HQRpJr4EqL6ABZuxsIcTr5goyN967DO6h+rpzvMcjGyvT7HHpmcOOdUT+pwJQ7HuF3q7tWWEUboe+WnYgibyKOgh9+w0XJ2ZGqbeHJS6iAsfNvtKBqsz8byPNP6vSsn6C3q2DFHW95BGQlXj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742795029; c=relaxed/simple;
	bh=PWQNwj4o+97umD22mpG4yFt/EhzSO5pYFCiU+qailsA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=dSia1yHWCNpoH47KNZMOOE8dhWMzXrevOJhKjY9TH/VFzXMGDfFprhjJHGLzxSmZDl7ZhJ0BzNQkADau+a/N0NegLIarl2wBJfUePWSZ8ReCCmnU8AQBGu7wJ01L8tDp6B+r+NoqNUu6gVGJ2QVkfQqAEwmO1+znkjEo4FK9t70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dhQago7T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dhQago7T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742795026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rxalDJd2tioM926pC9tYvVuvYVo1mSFnpX2boX7T/cI=;
	b=dhQago7THlypyXX2XKYvWYF1EiXpxmIYHxcPu4PuHYf7Vj7tJzFS9PU2OgsQk7bn9UULhd
	L98Y0DHOCqaFzJKAYK4dZ8n9Z+KHnZbBB0DS9Ojz2x5J24un+GMKNrq59w54/YOEDiJE8b
	lPP4Dte2nmTxcybHGtToMn/HOP2mY6Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-Y_mElzBVMxu0EZ2Eq5enpg-1; Mon,
 24 Mar 2025 01:43:42 -0400
X-MC-Unique: Y_mElzBVMxu0EZ2Eq5enpg-1
X-Mimecast-MFC-AGG-ID: Y_mElzBVMxu0EZ2Eq5enpg_1742795021
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0969B1801A07;
	Mon, 24 Mar 2025 05:43:41 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.200])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 46465180A801;
	Mon, 24 Mar 2025 05:43:36 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/19] virtio_ring in order support
Date: Mon, 24 Mar 2025 13:43:14 +0800
Message-ID: <20250324054333.1954-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hello all:

This sereis tries to implement the VIRTIO_F_IN_ORDER to
virtio_ring. This is done by introducing virtqueue ops so we can
implement separate helpers for different virtqueue layout/features
then the in-order were implmeented on top.

Tests shows 5% imporvemnt in RX PPS with KVM guest + testpmd on the
host.

Please review.

Thanks

Jason Wang (19):
  virtio_ring: rename virtqueue_reinit_xxx to virtqueue_reset_xxx()
  virtio_ring: switch to use vring_virtqueue in virtqueue_poll variants
  virtio_ring: unify logic of virtqueue_poll() and more_used()
  virtio_ring: switch to use vring_virtqueue for virtqueue resize
    variants
  virtio_ring: switch to use vring_virtqueue for virtqueue_kick_prepare
    variants
  virtio_ring: switch to use vring_virtqueue for virtqueue_add variants
  virtio: switch to use vring_virtqueue for virtqueue_add variants
  virtio_ring: switch to use vring_virtqueue for enable_cb_prepare
    variants
  virtio_ring: use vring_virtqueue for enable_cb_delayed variants
  virtio_ring: switch to use vring_virtqueue for disable_cb variants
  virtio_ring: switch to use vring_virtqueue for detach_unused_buf
    variants
  virtio_ring: use u16 for last_used_idx in virtqueue_poll_split()
  virtio_ring: introduce virtqueue ops
  virtio_ring: determine descriptor flags at one time
  virtio_ring: factor out core logic of buffer detaching
  virtio_ring: factor out core logic for updating last_used_idx
  virtio_ring: move next_avail_idx to vring_virtqueue
  virtio_ring: factor out split indirect detaching logic
  virtio_ring: add in order support

 drivers/virtio/virtio_ring.c | 856 ++++++++++++++++++++++++++---------
 1 file changed, 653 insertions(+), 203 deletions(-)

-- 
2.42.0

