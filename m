Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5244A1D63C6
	for <virtualization@lists.linux.dev>; Thu, 24 Jul 2025 06:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753339232; cv=none; b=SSMlV7pi/T+HCGImad/NoOc7QGDRutwc8g1Ia964RIKE2FYinckcgb0pUuIoP9JhVPalTBPCo1/V0PPYAX0t+y7DRFp497T5H3YXIe7n/F4hSasBBhsbLs5BB0lPaU4ic52xWJ/X/zLVxGqXVlwYvEX/rWCh+nC9U5LugtSanGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753339232; c=relaxed/simple;
	bh=rwwRIMsBKBF10c3wiNB9mwor3mxWPqYANvE15x2FOuM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N5JEP/Zg3SDKWlwIkkxPhCFd93l3/dDM2Hr5xrFTEqsiCu9oNbufa6lZbakIvnfS2xoLzwhSIl7YlOfK+ccD3BDbrj6ZaYYSt2IPypQtnEvnBamnVIRq7yYcvpy7XeTWqGrcqwx7yBemKoUSqsi015vhgeVgkkqpQ5HQDL64OD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gGw8re9c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gGw8re9c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753339229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pW9nIXNp/uZA+MmrFsZyDNxR+WnNcwTF4ql7qX7expM=;
	b=gGw8re9cj2flssRf0pTqJviSS0spwjtbsdMzWYBoNnRccAy3S5mbtmOd41mE12KO4ktsvY
	225s8TJK0YnFZf0uD04XxNYxCxV+0DhTOF6D+izeF7D/QSZcJ+cCFK0/1Qx6dUzagiMGEx
	tIRzzPyVx7sPaUY1pbjlqSL3cZiiKQQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-SEJcxdVBP9atuF6ikxEcmg-1; Thu,
 24 Jul 2025 02:40:27 -0400
X-MC-Unique: SEJcxdVBP9atuF6ikxEcmg-1
X-Mimecast-MFC-AGG-ID: SEJcxdVBP9atuF6ikxEcmg_1753339226
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ACAC9195608C;
	Thu, 24 Jul 2025 06:40:26 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.231])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0A98F180035E;
	Thu, 24 Jul 2025 06:40:22 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4 00/19] virtio_ring in order support
Date: Thu, 24 Jul 2025 14:39:58 +0800
Message-ID: <20250724064017.26058-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hello all:

This sereis tries to implement the VIRTIO_F_IN_ORDER to
virtio_ring. This is done by introducing virtqueue ops so we can
implement separate helpers for different virtqueue layout/features
then the in-order were implemented on top.

Tests shows 2%-19% imporvment with packed virtqueue PPS with KVM guest
vhost-net/testpmd on the host.

Changes since V3:

- Re-benchmark with the recent vhost-net in order support
- Rename the batched used id and length
- Other minor tweaks

Changes since V2:

- Fix build warning when DEBUG is enabled

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

 drivers/virtio/virtio_ring.c | 902 +++++++++++++++++++++++++++--------
 1 file changed, 690 insertions(+), 212 deletions(-)

-- 
2.39.5

