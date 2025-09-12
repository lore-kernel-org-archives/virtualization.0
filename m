Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E232D663F
	for <virtualization@lists.linux.dev>; Fri, 12 Sep 2025 08:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757665635; cv=none; b=sYDyqPy9hhXCF1hfW/IX2kPUEYUAL1C5bpbOErDE0Lq2FrGEzPOsV/eTVxDY4jFKG6pHpYMV784aKQG1qFhDO423lHgAWhX3px8Op9xyNv8xk36mVrSxbZ3ZLjnlBiC2LprOdiVihhraWNygnxH4lG+PXsERhU4eZxKprlZTG4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757665635; c=relaxed/simple;
	bh=OhkrDdrpf9K9Y/Vcut/XZzSkCyLD31va3Wprom2uduE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TSQGjYqYwjKhObOtZ6Nc0aXo1B7Hd3f95SAcy+UoNtxTuz39WOqcB0XVkiakKoq+10SwmjT8tWuMEL+Mk5PPE6U1ikN3X14vNZUdQz8LpURDBslRJylmHV7bggB5q1IDlHphVjWA7pVG9kXqtgWZFlAaTuvDp1e64P2KC/rIZeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZUL9c3e8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZUL9c3e8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757665633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FHPTlBuTNvdrb4eYoAaIH5z9IayKPbhwWYepGjVwam4=;
	b=ZUL9c3e896lg+Sult8/7UNY0XccbVQKn0FusMzzEiH+rRec+5FwGmFJx+mvCRcMXFAR2Dz
	xd+phRqf/Q/GPmoH48aEYpPUVxi5BX8WFdsc17MYwsdRjKGHXj48tzZJp8Q/BhejGpZrCB
	I9EwSND2Bq8wzbLQs0MT/pqu0eL47Oc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-RJeBKFiIMPSsbgahKilthg-1; Fri,
 12 Sep 2025 04:27:08 -0400
X-MC-Unique: RJeBKFiIMPSsbgahKilthg-1
X-Mimecast-MFC-AGG-ID: RJeBKFiIMPSsbgahKilthg_1757665627
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 54EC1195FD30;
	Fri, 12 Sep 2025 08:27:07 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.167])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B990118004D8;
	Fri, 12 Sep 2025 08:27:01 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	eperezma@redhat.com
Cc: jonah.palmer@oracle.com,
	kuba@kernel.org,
	jon@nutanix.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] vhost-net: unbreak busy polling
Date: Fri, 12 Sep 2025 16:26:57 +0800
Message-ID: <20250912082658.2262-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Commit 67a873df0c41 ("vhost: basic in order support") pass the number
of used elem to vhost_net_rx_peek_head_len() to make sure it can
signal the used correctly before trying to do busy polling. But it
forgets to clear the count, this would cause the count run out of sync
with handle_rx() and break the busy polling.

Fixing this by passing the pointer of the count and clearing it after
the signaling the used.

Cc: stable@vger.kernel.org
Fixes: 67a873df0c41 ("vhost: basic in order support")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index c6508fe0d5c8..16e39f3ab956 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1014,7 +1014,7 @@ static int peek_head_len(struct vhost_net_virtqueue *rvq, struct sock *sk)
 }
 
 static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
-				      bool *busyloop_intr, unsigned int count)
+				      bool *busyloop_intr, unsigned int *count)
 {
 	struct vhost_net_virtqueue *rnvq = &net->vqs[VHOST_NET_VQ_RX];
 	struct vhost_net_virtqueue *tnvq = &net->vqs[VHOST_NET_VQ_TX];
@@ -1024,7 +1024,8 @@ static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
 
 	if (!len && rvq->busyloop_timeout) {
 		/* Flush batched heads first */
-		vhost_net_signal_used(rnvq, count);
+		vhost_net_signal_used(rnvq, *count);
+		*count = 0;
 		/* Both tx vq and rx socket were polled here */
 		vhost_net_busy_poll(net, rvq, tvq, busyloop_intr, true);
 
@@ -1180,7 +1181,7 @@ static void handle_rx(struct vhost_net *net)
 
 	do {
 		sock_len = vhost_net_rx_peek_head_len(net, sock->sk,
-						      &busyloop_intr, count);
+						      &busyloop_intr, &count);
 		if (!sock_len)
 			break;
 		sock_len += sock_hlen;
-- 
2.34.1

