Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740D11D0956
	for <virtualization@lists.linux.dev>; Wed,  2 Oct 2024 14:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877739; cv=none; b=LypO0zWXBD+z7nGLtKFGtYHhU4XpHP5dF/qcTKQvdkEhIrpObiP1CRs/jEXDSOlpQMkj5Wo2095rHZjAO7oibu1JkiE2Y3eQLcklPyYmqSXOEsxwcR2CVhPdea4WP/q7cc+CdfcVCno5fdoUNTrUmXD+xfcNGiZ5GKt9WiZXN9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877739; c=relaxed/simple;
	bh=Frk2jjcDRjJQq7k8VaiE06LgSr0fC3zHmucqxnAwl2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mvdFkaGEwt/5wk4Bbj0Y1X8bN8mEZLm7AbKi1+q0aOxErXTrt16QjjvxjcP5TEAIH4cheqZQypBlfJm3RrATi4LbCEyhl79WpDrQypKl7IlFgGQ3v4yvmzwnfrts70ejYlfOsO+MAM4m3BVND6F5jWbx6D8uCdVtYvG/s6wWT9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aw+6It6q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aw+6It6q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727877736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bkyE5n67+2FhEmvlc1Gz1kCYfCQ3DT7+FsW83fvB9to=;
	b=aw+6It6qldUij9aDb26yTDIBCo3YbW9zHZORyRDFTch9hGhKGF4z/SPvug6LHfTdW4Ha3a
	JCAbcORal/aYQ+ziWO/1tOkQ1cuKjfBRFa6+/yZoTDGOx2gNiMIf5wC4qfLnW8wcJga0j0
	DJ0GqHx7tp7vbsPYLUqVjx6dLKEl5wM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-_92sLhxHOpuTVDhQr_IXLw-1; Wed, 02 Oct 2024 10:02:15 -0400
X-MC-Unique: _92sLhxHOpuTVDhQr_IXLw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a93d0b27d37so33161766b.0
        for <virtualization@lists.linux.dev>; Wed, 02 Oct 2024 07:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727877733; x=1728482533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkyE5n67+2FhEmvlc1Gz1kCYfCQ3DT7+FsW83fvB9to=;
        b=QNPLiHPe6fDzyF0HJiq5iMRRyx4CxD9U44EXxTdTyA4NON5r1XMo3d9KlAHmTCzQKe
         yaKJ/PKTG4itMZsY4n8uT6t61YbL8jT9l0f2gO5Q4xmCWEzrTBFP5bqPTrq4ewJgEXDu
         8ERaZBltL75QsvxvCzmMHiarSopt7uIQvaYvfO0sJ/tT+TCJ+3LQL4z02d1x9/6Sr/O/
         D0UceImMwo927KZgctAArAfLG4ZgMJsVbp2QeWWDz+HjI1pMVVYe36/iy2AXmq7uA/zf
         b0so49WF8+M759+iShyStMvP+UMR2rBDoPrmtOmdXSYLZrb27x0VGkxgEg6hTxpkeTrl
         m90Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFrq/AGLRM4PpOdb3R7mLkxIBsM2G3dt0oeHGE/1easEX4eaxdywcQwHRrg/w1tEe0BgCNpLGsMoi9rkEjlQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxxZZ/vsUWXT2w6gj745Q9NZ91WSE6wM0Ku2J8MA5wZft5/nJ6a
	bebXoykmCmzXQWUaZXjwhYqJu2zOrvvM6W0SB7ok0s7iIJ1Frr05X+WMe2dwSFbmGsBLYPt72g+
	ud9UejdpMwD8Gkt3997/SC/udFws2qJK+GeQggsPOT7F8oe7SeL57japk/CWM0Oux
X-Received: by 2002:a17:907:7ba1:b0:a7d:e956:ad51 with SMTP id a640c23a62f3a-a98f82450b8mr290197066b.21.1727877732693;
        Wed, 02 Oct 2024 07:02:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGelE8fxwK/xwgNE2Rv74byuFA2F7hxuFV/ZEUjU6Gi3oxGwmQvv3Bi4arRb61wV4RR9t3zOw==
X-Received: by 2002:a17:907:7ba1:b0:a7d:e956:ad51 with SMTP id a640c23a62f3a-a98f82450b8mr290190266b.21.1727877731869;
        Wed, 02 Oct 2024 07:02:11 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c299aca5sm873146366b.224.2024.10.02.07.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 07:02:11 -0700 (PDT)
Date: Wed, 2 Oct 2024 16:02:06 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Luigi Leonardi <luigi.leonardi@outlook.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Marco Pinna <marco.pinn95@gmail.com>, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] vsock/virtio: use GFP_ATOMIC under RCU read lock
Message-ID: <jfajjomq7wla2gf2cf2zwzyslxmnnrkxn6kvewwkexqwig52b4@fwh5mtjcdile>
References: <3fbfb6e871f625f89eb578c7228e127437b1975a.1727876449.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <3fbfb6e871f625f89eb578c7228e127437b1975a.1727876449.git.mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Oct 02, 2024 at 09:41:42AM GMT, Michael S. Tsirkin wrote:
>virtio_transport_send_pkt in now called on transport fast path,
>under RCU read lock. In that case, we have a bug: virtio_add_sgs
>is called with GFP_KERNEL, and might sleep.
>
>Pass the gfp flags as an argument, and use GFP_ATOMIC on
>the fast path.
>
>Link: https://lore.kernel.org/all/hfcr2aget2zojmqpr4uhlzvnep4vgskblx5b6xf2ddosbsrke7@nt34bxgp7j2x
>Fixes: efcd71af38be ("vsock/virtio: avoid queuing packets when intermediate queue is empty")
>Reported-by: Christian Brauner <brauner@kernel.org>
>Cc: Stefano Garzarella <sgarzare@redhat.com>
>Cc: Luigi Leonardi <luigi.leonardi@outlook.com>
>Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>---
>
>Lightly tested. Christian, could you pls confirm this fixes the problem
>for you? Stefano, it's a holiday here - could you pls help test!

Sure, thanks for the quick fix! I was thinking something similar ;-)

>Thanks!
>
>
> net/vmw_vsock/virtio_transport.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index f992f9a216f0..0cd965f24609 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -96,7 +96,7 @@ static u32 virtio_transport_get_local_cid(void)
>
> /* Caller need to hold vsock->tx_lock on vq */
> static int virtio_transport_send_skb(struct sk_buff *skb, struct virtqueue *vq,
>-				     struct virtio_vsock *vsock)
>+				     struct virtio_vsock *vsock, gfp_t gfp)
> {
> 	int ret, in_sg = 0, out_sg = 0;
> 	struct scatterlist **sgs;
>@@ -140,7 +140,7 @@ static int virtio_transport_send_skb(struct sk_buff *skb, struct virtqueue *vq,
> 		}
> 	}
>
>-	ret = virtqueue_add_sgs(vq, sgs, out_sg, in_sg, skb, GFP_KERNEL);
>+	ret = virtqueue_add_sgs(vq, sgs, out_sg, in_sg, skb, gfp);
> 	/* Usually this means that there is no more space available in
> 	 * the vq
> 	 */
>@@ -178,7 +178,7 @@ virtio_transport_send_pkt_work(struct work_struct *work)
>
> 		reply = virtio_vsock_skb_reply(skb);
>
>-		ret = virtio_transport_send_skb(skb, vq, vsock);
>+		ret = virtio_transport_send_skb(skb, vq, vsock, GFP_KERNEL);
> 		if (ret < 0) {
> 			virtio_vsock_skb_queue_head(&vsock->send_pkt_queue, skb);
> 			break;
>@@ -221,7 +221,7 @@ static int virtio_transport_send_skb_fast_path(struct virtio_vsock *vsock, struc
> 	if (unlikely(ret == 0))
> 		return -EBUSY;
>
>-	ret = virtio_transport_send_skb(skb, vq, vsock);

nit: maybe we can add a comment here:
         /* GFP_ATOMIC because we are in RCU section, so we can't sleep */
>+	ret = virtio_transport_send_skb(skb, vq, vsock, GFP_ATOMIC);
> 	if (ret == 0)
> 		virtqueue_kick(vq);
>
>-- 
>MST
>

I'll run some tests and come back with R-b when it's done.

Thanks,
Stefano

