Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3575D747
	for <virtualization@lists.linux.dev>; Thu, 14 Mar 2024 07:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710402589; cv=none; b=bfD/puRITh4j+fXtPYhEHxzJygoTWU+RoCcm90iNYSelseFlRbauoYrPX4aOAGBf8yXBeAsnvHpwwjMKb2q5cE0NHennXysBodr9fhxp5kFqdbZ+PaE914Y4nfewGOw97FnD3geS9T5bLyb8YOGutoPPwyOo5KfhaLs/om4elaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710402589; c=relaxed/simple;
	bh=au2T8EyQNZT1Y2JxCjARB4gUru0OlT7JfM1KnJZLoUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OWGDMEYG1BNW9xq3eq6TnIn/7J3WFsjYAd1QMHVbX4ZoN5nDBNjhqw6SDyCGhLdl8/sqnwYExmu8T8mN0yp9X8Zq0qj+Z2HtvBQSgxKuMKpGKYfF0aWq62DHNmeQHmXob/tiXjPgzm51vOoawvujgMgFvOqDBK6wPAoj2ABcwBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LY6RvdsO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LY6RvdsO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710402586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4k25JO+YyOBDjJ6GZlIvWxzo6WAx4koWTCdtMZJqhv8=;
	b=LY6RvdsOqQ9uNZGhVPJlvwUTBARCGgO2teLpv7jaV6oiD1HOU49f93rAs6QRcL1xRuOWET
	8n4FEtjt8Upe+O6cUJSe7DCoaIYqYOeWWKZthITtFRAZq/Ao/+9Js0hXFq38sqQuILVxEJ
	ezXu/2RqR8BJ3MOvBuncY58xZpqwTf8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-9gCeRlxeO9iXPE7lJWv7UA-1; Thu, 14 Mar 2024 03:49:42 -0400
X-MC-Unique: 9gCeRlxeO9iXPE7lJWv7UA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 85AEF81A260;
	Thu, 14 Mar 2024 07:49:42 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.81])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BA96B1121306;
	Thu, 14 Mar 2024 07:49:39 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: virtualization@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	yihyu@redhat.com,
	shan.gavin@gmail.com
Subject: [PATCH] virtio_ring: Fix the stale index in available ring
Date: Thu, 14 Mar 2024 17:49:23 +1000
Message-ID: <20240314074923.426688-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

The issue is reported by Yihuang Yu who have 'netperf' test on
NVidia's grace-grace and grace-hopper machines. The 'netperf'
client is started in the VM hosted by grace-hopper machine,
while the 'netperf' server is running on grace-grace machine.

The VM is started with virtio-net and vhost has been enabled.
We observe a error message spew from VM and then soft-lockup
report. The error message indicates the data associated with
the descriptor (index: 135) has been released, and the queue
is marked as broken. It eventually leads to the endless effort
to fetch free buffer (skb) in drivers/net/virtio_net.c::start_xmit()
and soft-lockup. The stale index 135 is fetched from the available
ring and published to the used ring by vhost, meaning we have
disordred write to the available ring element and available index.

  /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64              \
  -accel kvm -machine virt,gic-version=host                            \
     :                                                                 \
  -netdev tap,id=vnet0,vhost=on                                        \
  -device virtio-net-pci,bus=pcie.8,netdev=vnet0,mac=52:54:00:f1:26:b0 \

  [   19.993158] virtio_net virtio1: output.0:id 135 is not a head!

Fix the issue by replacing virtio_wmb(vq->weak_barriers) with stronger
virtio_mb(false), equivalent to replaced 'dmb' by 'dsb' instruction on
ARM64. It should work for other architectures, but performance loss is
expected.

Cc: stable@vger.kernel.org
Reported-by: Yihuang Yu <yihyu@redhat.com>
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 drivers/virtio/virtio_ring.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 49299b1f9ec7..7d852811c912 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -687,9 +687,15 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
 	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
 
-	/* Descriptors and available array need to be set before we expose the
-	 * new available array entries. */
-	virtio_wmb(vq->weak_barriers);
+	/*
+	 * Descriptors and available array need to be set before we expose
+	 * the new available array entries. virtio_wmb() should be enough
+	 * to ensuere the order theoretically. However, a stronger barrier
+	 * is needed by ARM64. Otherwise, the stale data can be observed
+	 * by the host (vhost). A stronger barrier should work for other
+	 * architectures, but performance loss is expected.
+	 */
+	virtio_mb(false);
 	vq->split.avail_idx_shadow++;
 	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
 						vq->split.avail_idx_shadow);
-- 
2.44.0

