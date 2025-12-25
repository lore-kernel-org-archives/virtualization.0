Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89693A1E82
	for <virtualization@lists.linux.dev>; Thu, 25 Dec 2025 04:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766636780; cv=none; b=k6rTrge9uobpdTqiYgySFEItiAmvtL2t/3s4CVXlPVzw1Z1p1U1dSWYU9yGHKfSzvKpXzi1GbBNyclRyTZ5OpK9eDRU28Bs3InCTnpuN70ddxzcFfa5qvYHk2FjX9BEowtILSvJRd4ds9U+ixWgVSIFOS+Uf1e6w3wReCBPhj8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766636780; c=relaxed/simple;
	bh=TH496lMTl3Du7p1+izxUE+TF7de3gVwg2xyeIhmz6Oo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oJSB2ZRtbtCOV42dGytrssx6tiLB9k7xpp3HQ7Vev9//RpCa2oyzHGKM88fIcudE9ePjwCX1+/xlGSztbva8uLvBzv1nt4VBidnHWBCeWbAO1MLA0JLBz9ETqpq3NXkTmucJRoQWhmHeAoW2G3eZ1O0BiycLbge44gpxKDHm6C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QTiYETwE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QTiYETwE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766636777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3Zg2/LSgDl/wmz32rGsEAWOPuER6ge+q62OLZbA0U/Q=;
	b=QTiYETwEBj8ZflhpL1S+wVXCiDRr0Yb8qMmGJUbWZl/FM3xTmEHSt8Sq5/ywEB3cjjfaUt
	TFPY02YNk0yccY3E98igIts7i4tGC9n1XwOdTvDlTJ4fhP1fQftSrLBCXl6t8QJ+14mHKu
	aOaP/zi8erKbMR4iuo/3ZJjOF6uh4v0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-1bpIB2diO5u7vdvwmQJ39w-1; Wed,
 24 Dec 2025 23:26:16 -0500
X-MC-Unique: 1bpIB2diO5u7vdvwmQJ39w-1
X-Mimecast-MFC-AGG-ID: 1bpIB2diO5u7vdvwmQJ39w_1766636775
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 303091956054;
	Thu, 25 Dec 2025 04:26:15 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.120.18])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9B3BE180049F;
	Thu, 25 Dec 2025 04:26:11 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V11 00/19] virtio_ring in order support
Date: Thu, 25 Dec 2025 12:25:49 +0800
Message-ID: <20251225042608.32350-1-jasowang@redhat.com>
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

Changes since v10:

- Remove the always false check of last_used against num
- Drop the extra "fix" in the commit log of patch 10

Changes sinve v9:

- Fix the total_len calcuation and count only in buffer length
- Fix the comment for the condtiion when batching is not detected

Changes since v8:

- Rebase to vhost.git linux-next branch
- Fix issue when indirect descriptor is disabled
- use UINT_MAX instead of vq->num to indicate no batching is pending
- Tweak the comments for used_entry
- Various coding style tweaks and typo fixes
- Try to use in_order varianet in in_order ops

Changes since v7:

- Rebase on vhost.git linux-next branch
- Tweak the comment to explain the usage of free_head

Changes since v6:

- Rebase on vhost.git linux-next branch
- Fix poking packed virtqueue in more_used_split_in_order()
- Fix calling detach_buf_packed_in_order() unconditonally in
  virtqueue_detach_unused_buf_packed()
- Typo and indentation fixes
- Fix wrong changelog of patch 7

Changes since v5:

- rebase on vhost.git linux-next branch
- reorder the total_len to reduce memory comsuming

Changes since v4:

- Fix build error when DEBUG is enabled
- Fix function duplications
- Remove unnecessary new lines

Changes since v3:

- Re-benchmark with the recent vhost-net in order support
- Rename the batched used id and length
- Other minor tweaks

Changes since v2:

- Fix build warning when DEBUG is enabled

Changes since v1:

- use const global array of function pointers to avoid indirect
  branches to eliminate retpoline when mitigation is enabled
- fix used length calculation when processing used ids in a batch
- fix sparse warnings

Jason Wang (19):
  virtio_ring: rename virtqueue_reinit_xxx to virtqueue_reset_xxx()
  virtio_ring: switch to use vring_virtqueue in virtqueue_poll variants
  virtio_ring: unify logic of virtqueue_poll() and more_used()
  virtio_ring: switch to use vring_virtqueue for virtqueue resize
    variants
  virtio_ring: switch to use vring_virtqueue for virtqueue_kick_prepare
    variants
  virtio_ring: switch to use vring_virtqueue for virtqueue_add variants
  virtio: switch to use vring_virtqueue for virtqueue_get variants
  virtio_ring: switch to use vring_virtqueue for enable_cb_prepare
    variants
  virtio_ring: use vring_virtqueue for enable_cb_delayed variants
  virtio_ring: switch to use vring_virtqueue for disable_cb variants
  virtio_ring: switch to use vring_virtqueue for detach_unused_buf
    variants
  virtio_ring: switch to use unsigned int for virtqueue_poll_packed()
  virtio_ring: introduce virtqueue ops
  virtio_ring: determine descriptor flags at one time
  virtio_ring: factor out core logic of buffer detaching
  virtio_ring: factor out core logic for updating last_used_idx
  virtio_ring: factor out split indirect detaching logic
  virtio_ring: factor out split detaching logic
  virtio_ring: add in order support

 drivers/virtio/virtio_ring.c | 927 +++++++++++++++++++++++++++--------
 1 file changed, 713 insertions(+), 214 deletions(-)

-- 
2.31.1

