Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BCA3346A8
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 16:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195835; cv=none; b=l5Ub5gq1fqTXUO8pQKzCbdDk5oCSOBC8TK12BWS01REkk0ew0zyh084Ywae3hZbbNIciLaXdYeyvJrj8GumLnjqlFzjkBPm2k8OT3qNnORhPynq5JwjdtuM3sC1vi1HUNktFx0000pk5foftCBuklf0WuU7tJiQk9XRqS86d0gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195835; c=relaxed/simple;
	bh=+qbA+/9Ck9tfxa9LHrlBztPOE5aSsIXC3o1gk+hJN6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=geofZ4gfdEjUYPkfo0o2slxaPn0F6wsWCmHYf2qsss1cv8twIK5ot6i4vNNeEnZJ6IdOpHlWjt0mwBhnqGAwYDCM+IbgbvdYmiTBwaIp/z3gO/xJBzWvjmXFMqJOIOi8XxWfh8MAkAqU8prdrvHO00U9EaVnGyi+vEIx1O0Acos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NqyMZl8w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NqyMZl8w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781195833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eWdGvaSQvKVa3S4PGrfeAWGqXDPUkbvYNJj6KykbQhc=;
	b=NqyMZl8wSOr2wjD8YiqjNEUuVVktUWii2fw5kCKKff91+kJNGghcQubSeg3k8VtXOjeuhp
	bm3ONG3NtCZ6hMuL6GLc5qroo9ykqkCtkCwUwSBL4xnhnsgyHF6tZ/WetuLZtSpXrq+urd
	I/oYuu4kzhuiKtdaoDNKu+UaNR6mfa0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-287-iyK1gUEtOuyJcqdPms30_A-1; Thu,
 11 Jun 2026 12:37:12 -0400
X-MC-Unique: iyK1gUEtOuyJcqdPms30_A-1
X-Mimecast-MFC-AGG-ID: iyK1gUEtOuyJcqdPms30_A_1781195830
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 323421954B2B;
	Thu, 11 Jun 2026 16:37:04 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.53])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AAB911800591;
	Thu, 11 Jun 2026 16:36:59 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	virtualization@lists.linux.dev,
	Gabriel Goller <g.goller@proxmox.com>,
	Fiona Ebner <f.ebner@proxmox.com>
Subject: [PATCH v2 net] virtio_net: do not allow tunnel csum offload for non GSO packets
Date: Thu, 11 Jun 2026 18:36:48 +0200
Message-ID: <6c3b6c47fb05c100f384630dc48f3975cf37b67a.1781195144.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: h4OWBJWgEvSf6-nw7z1jICZ8Q4SaGgzNY6dYCfc1IIE_1781195830
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Fiona reports broken connectivity for virtio net setup using UDP tunnel
inside the guest and NIC with not UDP tunnel TSO support in the host.

Currently the virtio_net driver exposes csum offload for UDP-tunneled,
TCP non GSO packets. Such packet reach the host as CSUM_PARTIAL ones
with the 'encapsulation' flag cleared, as the virtio specification do
not support this specific kind of offload.

HW NICs with UDP tunnel TSO support - and those drivers directly
accessing skb->csum_start/csum_offset - are still capable of computing
the needed csum correctly, but otherwise the packets reach the wire with
bad csum on both the inner and outer transport header.

Address the issue explicitly disabling csum offload for UDP tunneled,
non GSO packets via the ndo_features_check op.

Fixes: 56a06bd40fab ("virtio_net: enable gso over UDP tunnel support.")
Reported-by: Fiona Ebner <f.ebner@proxmox.com>
Closes: https://bugzilla.proxmox.com/show_bug.cgi?id=7627
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
Tested-by: Gabriel Goller <g.goller@proxmox.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
 - deal with to-be-segmented skbs, too.
---
 drivers/net/virtio_net.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f4adcfee7a80..7d2eeb9b1226 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6222,6 +6222,19 @@ static void virtnet_free_irq_moder(struct virtnet_info *vi)
 	rtnl_unlock();
 }
 
+static netdev_features_t virtnet_features_check(struct sk_buff *skb,
+						struct net_device *dev,
+						netdev_features_t features)
+{
+	/* Inner csum offload is only available for GSO packets. */
+	if (skb->encapsulation &&
+	    (!skb_is_gso(skb) || netif_needs_gso(skb, features)))
+		return features & ~NETIF_F_CSUM_MASK;
+
+	/* Passthru. */
+	return features;
+}
+
 static const struct net_device_ops virtnet_netdev = {
 	.ndo_open            = virtnet_open,
 	.ndo_stop   	     = virtnet_close,
@@ -6235,7 +6248,7 @@ static const struct net_device_ops virtnet_netdev = {
 	.ndo_bpf		= virtnet_xdp,
 	.ndo_xdp_xmit		= virtnet_xdp_xmit,
 	.ndo_xsk_wakeup         = virtnet_xsk_wakeup,
-	.ndo_features_check	= passthru_features_check,
+	.ndo_features_check	= virtnet_features_check,
 	.ndo_get_phys_port_name	= virtnet_get_phys_port_name,
 	.ndo_set_features	= virtnet_set_features,
 	.ndo_tx_timeout		= virtnet_tx_timeout,
-- 
2.54.0

