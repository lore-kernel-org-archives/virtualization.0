Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2FB1D0957
	for <virtualization@lists.linux.dev>; Wed,  2 Oct 2024 13:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876515; cv=none; b=H9chW23VciGjmaRCMK3yZ5bQ/MhgphPdDKj9G9fiKOAq4VBeab+28dxXjNEQLOqM4IH1Y/KsVPyXj4i5ew32v82GTGcOCefWCRTrwIVho057+ayD1izO9GgmcvL75qAWImblbNHWcHBWnyq2ptt7Ht8RfLS5aJYn27t87hCapDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876515; c=relaxed/simple;
	bh=5OZTexW1N2cYsiipBckmnTsow8NYUZJeFd0Dc1g6Amk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RGbwdldyA15l8vzC2i2fU+yXdcPOREBxAlOUG7cm1Jk9NXOKV8swPMp9gw7vtOy/mCqYFssAs6+WdU+zTwB/RFJEhkKNdhOTkBsoawC/T65lM3UizZI8LKwFzx892sFgaepKu82aY9vJBGHl8YJOrDL1OYKny/66/vM351yoRjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MtHRJow+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MtHRJow+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727876513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=UWQpm0mcyr3iomDUG9qlXZHim5cqJMh8ETQLI86SlcY=;
	b=MtHRJow+W3qV3Vp6GlXLHl5zmE1wIn0a4J3OTvvxMxxGVt2JfZyRoGVm+thCQVo1H1IUUW
	JDSI1yNyvabsBKuFk1hqeMprOTpY3ysOs9gNTdj5jvi+b726XcGEmB00vi7YUOwVdjNHC8
	ZlwFPEl7U2cxQrfrXuVMSZa4DmeslsA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-rb658YjVMROzaGw2mGhjfA-1; Wed, 02 Oct 2024 09:41:50 -0400
X-MC-Unique: rb658YjVMROzaGw2mGhjfA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a8a92ab4dd0so428260266b.1
        for <virtualization@lists.linux.dev>; Wed, 02 Oct 2024 06:41:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727876509; x=1728481309;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UWQpm0mcyr3iomDUG9qlXZHim5cqJMh8ETQLI86SlcY=;
        b=dJAQr4NIsWCC7aIAyziXHjasbMR0IJV839Ckjnfb1ZC8M6nfgNBLK+mECfP6BQnx0G
         xuj+wUjt6yYsR8hLixTDaddIHCFmQOzt3RLXg//nUV/5bmuIRztHPUuJqG4oGs9TSOv+
         d7LooonT9BvQuV0er84DCvSvPXa0E41OmoXFmNdV3DuAwXWWFz9lUbSF/p76QHrUsfXC
         5iC8cMSgNZHfZ+mrqGGruTgdWhN9aMaBu27o1IshNvEcTiBU+I3X5Y/XI4Ekt2QsgBV/
         1khlIe6j3H4LgKKe7siJg/zPx/W/kGvAg569q3zq06n5OzraGp2et6qE1qsEbhCoY9kH
         MQcw==
X-Forwarded-Encrypted: i=1; AJvYcCX1746jVKPOMud7vZIgFi1zKeRaoqFUOfvIvSzIyjL2egwazLU4u5ejSAaNOjG3k8okGxMPu4k9Yzr65XfsYg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yymw62qAxxhS9ABOa040pVNlEgjj5vEGXcoTCtDGwrG2I3bf6SU
	IffL/A+nAxFo8BrKDgbxzBH/i0yuSj4A3EXYLnbIJfqLP74ECZtBD1ieHl9XRLz8BYkwhgdy/5K
	JJ3XQfDv8XeD7LzlBSnMveON3x7Kzxwjyv7PztGL55xegxevbek91flygbSKPOsGQ
X-Received: by 2002:a17:907:6d1e:b0:a86:8917:fcd6 with SMTP id a640c23a62f3a-a98f838de30mr290162766b.60.1727876508858;
        Wed, 02 Oct 2024 06:41:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwRbtorkfQnEgLoH126u7jMASiHc1X3K7k60KPoDf4Uvq08XhmDqGPPCIGAMX5Sl2hbplPTQ==
X-Received: by 2002:a17:907:6d1e:b0:a86:8917:fcd6 with SMTP id a640c23a62f3a-a98f838de30mr290159466b.60.1727876508383;
        Wed, 02 Oct 2024 06:41:48 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17d:4f25:dd73:e931:ef00:4c45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c29844a1sm885087666b.172.2024.10.02.06.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 06:41:47 -0700 (PDT)
Date: Wed, 2 Oct 2024 09:41:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Luigi Leonardi <luigi.leonardi@outlook.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marco Pinna <marco.pinn95@gmail.com>,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH] vsock/virtio: use GFP_ATOMIC under RCU read lock
Message-ID: <3fbfb6e871f625f89eb578c7228e127437b1975a.1727876449.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

virtio_transport_send_pkt in now called on transport fast path,
under RCU read lock. In that case, we have a bug: virtio_add_sgs
is called with GFP_KERNEL, and might sleep.

Pass the gfp flags as an argument, and use GFP_ATOMIC on
the fast path.

Link: https://lore.kernel.org/all/hfcr2aget2zojmqpr4uhlzvnep4vgskblx5b6xf2ddosbsrke7@nt34bxgp7j2x
Fixes: efcd71af38be ("vsock/virtio: avoid queuing packets when intermediate queue is empty")
Reported-by: Christian Brauner <brauner@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Cc: Luigi Leonardi <luigi.leonardi@outlook.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Lightly tested. Christian, could you pls confirm this fixes the problem
for you? Stefano, it's a holiday here - could you pls help test!
Thanks!


 net/vmw_vsock/virtio_transport.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index f992f9a216f0..0cd965f24609 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -96,7 +96,7 @@ static u32 virtio_transport_get_local_cid(void)
 
 /* Caller need to hold vsock->tx_lock on vq */
 static int virtio_transport_send_skb(struct sk_buff *skb, struct virtqueue *vq,
-				     struct virtio_vsock *vsock)
+				     struct virtio_vsock *vsock, gfp_t gfp)
 {
 	int ret, in_sg = 0, out_sg = 0;
 	struct scatterlist **sgs;
@@ -140,7 +140,7 @@ static int virtio_transport_send_skb(struct sk_buff *skb, struct virtqueue *vq,
 		}
 	}
 
-	ret = virtqueue_add_sgs(vq, sgs, out_sg, in_sg, skb, GFP_KERNEL);
+	ret = virtqueue_add_sgs(vq, sgs, out_sg, in_sg, skb, gfp);
 	/* Usually this means that there is no more space available in
 	 * the vq
 	 */
@@ -178,7 +178,7 @@ virtio_transport_send_pkt_work(struct work_struct *work)
 
 		reply = virtio_vsock_skb_reply(skb);
 
-		ret = virtio_transport_send_skb(skb, vq, vsock);
+		ret = virtio_transport_send_skb(skb, vq, vsock, GFP_KERNEL);
 		if (ret < 0) {
 			virtio_vsock_skb_queue_head(&vsock->send_pkt_queue, skb);
 			break;
@@ -221,7 +221,7 @@ static int virtio_transport_send_skb_fast_path(struct virtio_vsock *vsock, struc
 	if (unlikely(ret == 0))
 		return -EBUSY;
 
-	ret = virtio_transport_send_skb(skb, vq, vsock);
+	ret = virtio_transport_send_skb(skb, vq, vsock, GFP_ATOMIC);
 	if (ret == 0)
 		virtqueue_kick(vq);
 
-- 
MST

