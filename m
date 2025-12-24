Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD3D31961F
	for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 00:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536405; cv=none; b=G7b611aNH2guAyogG9xMqXfGrA2koHYgIW3Wyym51L8wSxtmGkvtwx124vYtlg33a8HJkAwTdR3+scrXFf/oGcn+Uu6RKlz1wO9ZonZ2txrKNRviDI5zQOPIsescUCK47N/1LioXDxp5bo2UOjV4tYziSLRSdiqdvgQWKqszDRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536405; c=relaxed/simple;
	bh=sFS4+xA1rBHK8SULr35EpPIJXUR4bRMrWWwSqousyp0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SQm08aJ3eHAQUNgwmuwnHDYAJCJ+zJ1/hY/VTKkL8dvl1HpO5mdc8axN6AUIBd10GlSenEWPVdxF39QfGdnj0XfyEWdtKn83+R0FzjMh7EmL9uZy2gfVx6Y1UreUcRFL5Yo0au1Tv4C8iXofkglnGyC67kp72MAAWwP7oestE7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hvjEuz1t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hvjEuz1t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766536402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IRp+itR0geGsFFd5fBgsJqVIZ6VLpIpPrW2fmsSooI8=;
	b=hvjEuz1tvBHChsY84jV2b/tmX9VybTXpaO9+Q6YHeGBAO6G50o8VhO0LRpX5rqmxmW2C61
	zzcVyWOXX8spMmHoD/7zvNUL7emPlNJ1t3hQhkp07EcKX7dZDR1JqiD9GnxM1Ax4E+DXjC
	SolMEtL6Jp4rl+PpBW6UDMRzgaDeAdI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-2rwKiU7DPS-LCc0VTA3fbg-1; Tue,
 23 Dec 2025 19:33:19 -0500
X-MC-Unique: 2rwKiU7DPS-LCc0VTA3fbg-1
X-Mimecast-MFC-AGG-ID: 2rwKiU7DPS-LCc0VTA3fbg_1766536398
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D784C1956058;
	Wed, 24 Dec 2025 00:33:17 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.39])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9D03C19560AB;
	Wed, 24 Dec 2025 00:33:14 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V10 00/19] virtio_ring in order support
Date: Wed, 24 Dec 2025 08:32:50 +0800
Message-ID: <20251224003309.23432-1-jasowang@redhat.com>
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

 drivers/virtio/virtio_ring.c | 931 +++++++++++++++++++++++++++--------
 1 file changed, 717 insertions(+), 214 deletions(-)

-- 
2.31.1

