Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBCA215048
	for <virtualization@lists.linux.dev>; Wed, 22 Jan 2025 16:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737563529; cv=none; b=qlhV54UK5Lnsmac8Ow/3P6pq/hvYmoMMft1swjeMioXXeLMZUBNCKfMxcSDtZC9p6x1ZgV9EQ5wgejnRnFa4yk1Wc6lbeUopQ3obN+KOay9m/R/ERh0pmgjQMTYQSjKFg5EM0xlWoBrFxtwXiO7xdGVenw9zZYZbAlugKZmX4pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737563529; c=relaxed/simple;
	bh=ifw5fEJjQmgVuftlsPV8gvcg6kL43PraehnpW6eZ0Bg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IBnmuHBe25UHR0d6cEB5tNLRPtmzGUKYhy2SYyEnJp3tKZQ1G6BBtZgbPNIIbrZHCXLe+v6UpyBr0D9brsTLzMR38KHIwgP01Wxy6fqOnlcDMJfHPGOK4E2kSiFIvHQYfqc53IyM2Stp6zD31OUpHedOQUg9IM1mxq6oabEfjSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y35N6QHt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y35N6QHt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737563527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Rd2ue5A/QzgxQsHbDR+w+IF06vmhIqAg5D2y3tBxP7k=;
	b=Y35N6QHtu13kwe5mPcqEiIdGqtU+lynqAF/ymbQ2LDKhfxxsMuynU2Sv9JK5RzspKeFONU
	mFpFLMB9fziXIdbuetJPeuvr8FzMsF2EAhJJcfvv3hFvWvshF8xnSg26wnVv8M13RksNgW
	dl1oEmNgLSrjicZyBL0To0R86WoK/Ug=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-dFlBCrtFOw-ay_fI_HajLw-1; Wed,
 22 Jan 2025 11:32:02 -0500
X-MC-Unique: dFlBCrtFOw-ay_fI_HajLw-1
X-Mimecast-MFC-AGG-ID: dFlBCrtFOw-ay_fI_HajLw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B15C195604F;
	Wed, 22 Jan 2025 16:32:00 +0000 (UTC)
Received: from eperezma-thinkpadt480s.rmtes.csb (unknown [10.39.193.171])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8A725195608A;
	Wed, 22 Jan 2025 16:31:56 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: linux-kernel@vger.kernel.org,
	mst@redhat.com,
	Hanna Reitz <hreitz@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	German Maglione <gmaglione@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtualization@lists.linux.dev
Subject: [RFC 0/5] virtiofs: map buffer out of virtqueue lock
Date: Wed, 22 Jan 2025 17:31:49 +0100
Message-ID: <20250122163154.1225353-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

This is useful for some setups like swiotlb or VDUSE where the DMA
operations are expensive and/or need to be performed with a write lock.

After applying this patch, fio read test goes from 1201MiB/s to
1211MiB/s.

---
Sending this series to obtain feedback if this is the right way to go.

Q: Do we need virtqueue_map_sgs? XDP directly call dma_map. Need to
profile.
TODO: Profile multiqueue.
TODO: Handling errors.
TODO: Do the same for hiprio queue.
TODO: Can we batch maps? virtiofs always sends many buffers.

Eugenio Pérez (4):
  vduse: add virtio_fs to allowed dev id
  virtiofs: Move stack sg to fuse_req
  virtio_ring: add virtqueue premapped out/in buffers support
  virtiofs: perform DMA operations out of the spinlock

Jason Wang (1):
  virtio_ring: introduce virtqueue_map/unmap_sgs()

 drivers/vdpa/vdpa_user/vduse_dev.c |   1 +
 drivers/virtio/virtio_ring.c       | 165 ++++++++++++++++++++++++++---
 fs/fuse/fuse_i.h                   |   7 ++
 fs/fuse/virtio_fs.c                |  68 +++++++-----
 include/linux/virtio.h             |  17 +++
 5 files changed, 220 insertions(+), 38 deletions(-)

-- 
2.48.1

