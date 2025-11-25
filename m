Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EACD2D2397
	for <virtualization@lists.linux.dev>; Tue, 25 Nov 2025 07:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764054533; cv=none; b=ik8auqozmvRnWIIn06KQplxwBrVORod6uDHtwNSyCsOF+8e5WUXsJESUeprlspmdZsYro9M4unPC/199FOt5RPMiPXXMxSnUtYpq855KJ1fQrtSMSYbfzKIzNWw1/NXG80HL/7Fxp0EjOSXoa8rMwuIHwuwg90MlKXSrMM8aylo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764054533; c=relaxed/simple;
	bh=okuKd6fV2ZiJA/xLi77rl5o3wdrvXtgnthpfYG5fFwc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V8COdYk0/rfLJG1N14jluWHQtRL7MSgloDiaQQS0oBbGNjjwB0gEpdVMW2L3Nn9fjQ6AmYncA/sF7IPlw27Nj5RzK1OEtLAAH9zs4yHTrlBpeyGvLpsWd2tjKigb4ijTqESWVJHtQVzbVpOJm/n67tfAi+0qJRTV2tMbxzv8dEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y3f76NZb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y3f76NZb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764054530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BEuLzs2xS11PQBPf26iqv7CLmfAqiIx0rrHXJA1bSuw=;
	b=Y3f76NZbcAasBHnPfVyD6YuNf/g/3s3C9eJK38gwad/qoyrTBZLi9YjCzrIHwTZCABD+os
	esUugSMAl3ObIKLnZ2HIvDCgYGGaXH7M0FWzqESyYSTppSmB0fUi44ahTPMJv0fp0mS3qq
	lmJ7IKFN4BJTTC29uBlibOc9N4+tkJY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-Y-SECgy8OFi4El746XIdgg-1; Tue,
 25 Nov 2025 02:08:46 -0500
X-MC-Unique: Y-SECgy8OFi4El746XIdgg-1
X-Mimecast-MFC-AGG-ID: Y-SECgy8OFi4El746XIdgg_1764054525
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 504471800358;
	Tue, 25 Nov 2025 07:08:45 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.120.4])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 91F991956056;
	Tue, 25 Nov 2025 07:08:40 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V9 00/19] virtio_ring in order support
Date: Tue, 25 Nov 2025 15:08:19 +0800
Message-ID: <20251125070838.70736-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hello all:

This sereis tries to implement the VIRTIO_F_IN_ORDER to
virtio_ring. This is done by introducing virtqueue ops so we can
implement separate helpers for different virtqueue layout/features
then the in-order were implemented on top.

Tests shows 2%-19% imporvment with packed virtqueue PPS with KVM guest
vhost-net/testpmd on the host.

Changes since V8:

- Rebase to vhost.git linux-next branch
- Fix issue when indirect descriptor is disabled
- use UINT_MAX instead of vq->num to indicate no batching is pending
- Tweak the comments for used_entry
- Various coding style tweaks and typo fixes
- Try to use in_order varianet in in_order ops

Changes since v7:

- Rebase on vhost.git linux-next branch
- Tweak the comment to explain the usage of free_head

Changes since V6:

- Rebase on vhost.git linux-next branch
- Fix poking packed virtqueue in more_used_split_in_order()
- Fix calling detach_buf_packed_in_order() unconditonally in
  virtqueue_detach_unused_buf_packed()
- Typo and indentation fixes
- Fix wrong changelog of patch 7

Changes since V5:

- rebase on vhost.git linux-next branch
- reorder the total_len to reduce memory comsuming

Changes since V4:

- Fix build error when DEBUG is enabled
- Fix function duplications
- Remove unnecessary new lines

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

 drivers/virtio/virtio_ring.c | 930 +++++++++++++++++++++++++++--------
 1 file changed, 716 insertions(+), 214 deletions(-)

-- 
2.31.1

