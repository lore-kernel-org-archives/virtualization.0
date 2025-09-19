Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E05115853B
	for <virtualization@lists.linux.dev>; Fri, 19 Sep 2025 07:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758267128; cv=none; b=hO4sXmA48y9AOoGC5u6DiEPeo1pY91oPEXGpcf0KJdzduQIqF523qbW2B/QfGEGqwGH/YBC5K4AbzJ1d4KYUTQFz1PPNzVlbd0Bk8+HE4yLl7rL60zsAMArS7jWXaWEsKVvL9wOPpnB9VIUT8Wm+RQdC12pqr29Pa4N+NkX7mbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758267128; c=relaxed/simple;
	bh=Q9V10L3zpFt542NCMSXEmdPFVTCJ9BGBkLn+Yt2+Dqo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lb1JOT59bqHXrPapL6B1obEDzNuz5AO3iq5mz0/IRNSaMHpqOLCzw8ZU8t1LkLgKloYsdJKgZTLv7LEoUwuUoGTE1sYQcHQNdTG9iq4RapJZl3MnChCLUfPBE0uYb0z+UhJo3py7VVTaaCfzWSwwpj4n8ctCvYjOmQ7y3DOoDpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q16EL4Hs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q16EL4Hs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758267125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Cj8To7SQBh/tsj0Y0jXY9nEJTzI5ZwuQKEQXYkBKpnw=;
	b=Q16EL4HsQsNf0lyPqtmeLtcPaPqSy1bJXsJSslykVYPyyTU/OOJjY3zhnAIaRkjBDtpxxo
	3kbF6fBJ8+dR830FqdG8N5XQCzl8ELgX8C7iV2E35PrqvgrDsF8diPcIEuvOwDuE7ENpZv
	1cyc3fNETGIJtg5juJoAtc+GNAOAuBI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401--NN6HZk5OJCTgy-XABJ1Dw-1; Fri,
 19 Sep 2025 03:32:03 -0400
X-MC-Unique: -NN6HZk5OJCTgy-XABJ1Dw-1
X-Mimecast-MFC-AGG-ID: -NN6HZk5OJCTgy-XABJ1Dw_1758267122
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1ED8618002D6;
	Fri, 19 Sep 2025 07:32:02 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.45])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BC6821956045;
	Fri, 19 Sep 2025 07:31:58 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V6 00/19] virtio_ring in order support
Date: Fri, 19 Sep 2025 15:31:35 +0800
Message-ID: <20250919073154.49278-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hello all:

This sereis tries to implement the VIRTIO_F_IN_ORDER to
virtio_ring. This is done by introducing virtqueue ops so we can
implement separate helpers for different virtqueue layout/features
then the in-order were implemented on top.

Tests shows 2%-19% imporvment with packed virtqueue PPS with KVM guest
vhost-net/testpmd on the host.

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

 drivers/virtio/virtio_ring.c | 889 ++++++++++++++++++++++++++---------
 1 file changed, 678 insertions(+), 211 deletions(-)

-- 
2.31.1

