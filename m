Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BC11F8691
	for <virtualization@lists.linux.dev>; Wed, 28 May 2025 06:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748414569; cv=none; b=MrNYcEi+csNH1ipysHnIbeKm1+bcce/7dkN58tZBp9K3Zghx5KDRDQzpvoYQpwUPR+hevktsaoKoO7ET7A3Z17vjpyCZA/3hZbdajQEgh4tsg3OkepZQMlyqRpH4RCRDoiB02FRoq2a6RwaWmx8Pb2lvf4UjJJlJ0YRFidFM1Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748414569; c=relaxed/simple;
	bh=NprGV7/kb7hsgBJxkiH+iF0r2UnHtyWFQxSyieQjimw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iX6SK2/11d9g242yRjY0bnY2DFM84edZaYjLeKo2Kpd+INul17caFi7xqCwiGGFqLIn4k9UQvXwauHb3zRc6CZPvbvGdvUKGouYCofsIukWgtmswvvjxT8MF2wAINrIyaW7+dPGtzoG7py0krQmuB04aS+z4SkXrgJ/68H1ZFkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WLpvnnY0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WLpvnnY0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748414566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R+8fs0hU/220f55PcUOc2NBsRpNINLPl/6hlzCtmT8g=;
	b=WLpvnnY0l2pwEg6NEc1VnP0ZBSH/bxJwrK1aITvQS4bAQf9UTHk0moCFkF2p5iKeKKIN3V
	h5tCFPLRokH86ipMIVL+aZmxeQ7EERjxrj4UURugsjox+ALYB6QbMdwPJ/qP38jNy4wccO
	H/WhIGOrwJmtmcyO6ZlsJl7qPz0EdZM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-Op7MFQKuNMW6EPvEhjGXwA-1; Wed,
 28 May 2025 02:42:43 -0400
X-MC-Unique: Op7MFQKuNMW6EPvEhjGXwA-1
X-Mimecast-MFC-AGG-ID: Op7MFQKuNMW6EPvEhjGXwA_1748414562
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F235B18003FC;
	Wed, 28 May 2025 06:42:41 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.248])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 44E251956095;
	Wed, 28 May 2025 06:42:37 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 00/19] virtio_ring in order support
Date: Wed, 28 May 2025 14:42:15 +0800
Message-ID: <20250528064234.12228-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hello all:

This sereis tries to implement the VIRTIO_F_IN_ORDER to
virtio_ring. This is done by introducing virtqueue ops so we can
implement separate helpers for different virtqueue layout/features
then the in-order were implemented on top.

Tests shows 3%-5% imporvment with packed virtqueue PPS with KVM guest
testpmd on the host.

Changes since V1:

- use const global array of function pointers to avoid indirect
  branches to eliminate retpoline when mitigation is enabled
- fix used length calculation when processing used ids in a batch
- fix sparse warnings

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
  virtio_ring: factor out split indirect detaching logic
  virtio_ring: factor out split detaching logic
  virtio_ring: add in order support

 drivers/virtio/virtio_ring.c | 896 ++++++++++++++++++++++++++---------
 1 file changed, 684 insertions(+), 212 deletions(-)

-- 
2.31.1

