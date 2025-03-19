Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2831A2566F2
	for <virtualization@lists.linux.dev>; Wed, 19 Mar 2025 13:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742390779; cv=none; b=iDDwLUOu4DH6j9k66MAFDJKVKEXgAAbaj8K9v4TyMvtPFdZgwOpoMsbQuYR+rx+GDqCUwrijp70X6+VrYVNT34EPfWZhlBOYz1T9Q1Du3RaqXKECCS5vMdyr63MGUkyaQtRevcfHWIaxD0E40ZYY6w7R4rtXLEqB3FHnZ9X7U/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742390779; c=relaxed/simple;
	bh=ld5eJNWi/v1i0gmIRHdZaRFv9fDwhRMDqEbIo4PLTEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=AFXxOQkTbho2cAvCHwocV6ARoe+ZXsO88EC9wzjSK5Kc87ojv2qFforc/Y6HVB6IpeDLo5GCXGZ2UvTurEw/7zz/ksvP+x1ZHBYS+NoRoSP3XzDPlb1pzJMv9/Cel1MudIXvI/FSAArGCOWTSIxIaIwFozvvyHhDeSaUB+wN9aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q/jTHkpf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q/jTHkpf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742390777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jaUUXRh1EbOiBGq2k3FaF6z5tXEmrMKUqLsPsZxaMf4=;
	b=Q/jTHkpfBCZoKa2KR2uxteMWMdChbnFQk+41hnWSn3JIPIZW6Kq6/Lw7hAhsbNTOXFPvEc
	n9UZFNGC41zh1tc9QSo5PoJDU4sAfYrz1rG1+jjDgF2aNCQgH1kIo1j4bR8nyg2SeVOnTc
	rabcnqaciwBJ96Qg6YXa9Q+HESOi6cA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-f_-tUHFjPKewvBwwnB_yOg-1; Wed, 19 Mar 2025 09:26:15 -0400
X-MC-Unique: f_-tUHFjPKewvBwwnB_yOg-1
X-Mimecast-MFC-AGG-ID: f_-tUHFjPKewvBwwnB_yOg_1742390774
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5e623fe6aa2so7945705a12.2
        for <virtualization@lists.linux.dev>; Wed, 19 Mar 2025 06:26:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742390774; x=1742995574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jaUUXRh1EbOiBGq2k3FaF6z5tXEmrMKUqLsPsZxaMf4=;
        b=v8DhBDsCQK9jgV5RQNVa5bPvWv7R4qqT2mRLMTXHTAxwGge2cTxRW/zLSdSm/rUkry
         lQpT8g6rJIUROzroJIjZeDa8BVRqCuDeDrcYtUGQibKWAKkaqeJfQ2TaYNrfAAj638y5
         S7gYxvoNqWewprlrEQOnTXQn0oTFoyT4jT2IVJpQH7PJSdrp8rVxe9i3OH73gbgNK4oI
         Xa3/ynBA3Wo+jAU8vLCXr2Ol7crDNULsxTGMwcx6YYl49+4wrNwoHJVs7vWSIaWaG2mb
         quBHQgJhm3uJsIAJi073fI5fX2F0r10gKxTX8aew+vr19aRPyA4S1AAShEq6iHLM6epI
         GQOA==
X-Forwarded-Encrypted: i=1; AJvYcCWqErB/TK1ci9Az2CDGvFK8nkGgw1o1uPgrgEiBgcAyhglFRvTDRlIEpvKFbE+NYZH0a0QGLdtFJJnvOz2xHw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw0PIhTpYGGc4MYqt263mKPxVTRZpn3VPSqi7C52q7tFAYs/WHV
	1AdnVIvcOZKTSxIVT669TrGhcuWJLrLIDygI3dlId1Q6Vf3vUZv1GaK3SmXJ6GHM4egLWxCXero
	lAg+JCo6jxhpOs28NBlp2tALNJPq8FOYJ333yEVIexqm+NyozBeJWyDQMvZh/6Uy3
X-Gm-Gg: ASbGncu8Mb6OWSP/risk8KnWTqzlW7EhBhgeW2uefrQy0hnXSWvlqZGMg2hsiMwvW+v
	o7GLU2KmsFcXx3Pfpof0jcqL4AOyx73ylmGjV8+c3n+8ueeJMjc4PCe60CWSFnMUK+cuEedd5Zo
	8neRo3K26TtiPH4cjY00+wTUxcHENQ9d9YsMf7qaSCvB2coJYIRooFNS1SFcANQIUXPBHJhXdYD
	ecRvX4gYliMvrziu1plkQzQGHRMWYjqUGZ50YjtrUG9gJofD11vRlYhruCc6cTne9EpITBu5dAF
	Se4gvqLFFE1fTzVRrtCCFrlNTk/tEJ3i6tvTsu5hQ+NilNn3MYFrdjX8gTUMhw==
X-Received: by 2002:a05:6402:4302:b0:5e5:827d:bb1c with SMTP id 4fb4d7f45d1cf-5eb80fa41c6mr2676011a12.25.1742390774231;
        Wed, 19 Mar 2025 06:26:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUtpdb4r2CtbTyHsr8WLwRcIUuXEpJ1mxKBLWGBT+tn/rPN0UQLhFx+xPQA07eNa19/oKOAQ==
X-Received: by 2002:a05:6402:4302:b0:5e5:827d:bb1c with SMTP id 4fb4d7f45d1cf-5eb80fa41c6mr2675817a12.25.1742390772409;
        Wed, 19 Mar 2025 06:26:12 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-53.retail.telecomitalia.it. [79.53.30.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e81692e583sm9064993a12.16.2025.03.19.06.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 06:26:11 -0700 (PDT)
Date: Wed, 19 Mar 2025 14:26:04 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, "David S. Miller" <davem@davemloft.net>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 2/3] vsock/virtio_transport_common: handle netns of
 received packets
Message-ID: <6iepaq4rqd65lhpqfpplzurwkezdyrjolijrz4feqakh3ghbjy@fxoiw5yiyzp3>
References: <20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com>
 <20250312-vsock-netns-v2-2-84bffa1aa97a@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250312-vsock-netns-v2-2-84bffa1aa97a@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KVdgudhnCNSCjI25t30-LBXwNIwU5Ne-yG-e9tgxiAM_1742390774
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Mar 12, 2025 at 01:59:36PM -0700, Bobby Eshleman wrote:
>From: Stefano Garzarella <sgarzare@redhat.com>
>
>This patch allows transports that use virtio_transport_common
>to specify the network namespace where a received packet is to
>be delivered.
>
>virtio_transport and vhost_transport, for now, still do not use this
>capability and preserve old behavior.

What about vsock_loopback?

>
>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@gmail.com>
>---
>V1 -> V2
> * use vsock_global_net()
> * add net to skb->cb
> * forward port for skb
>---
> drivers/vhost/vsock.c                   |  1 +
> include/linux/virtio_vsock.h            |  2 ++
> net/vmw_vsock/virtio_transport.c        |  1 +
> net/vmw_vsock/virtio_transport_common.c | 11 ++++++++++-
> 4 files changed, 14 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 802153e230730bdbfbbb6f4ae263ae99502ef532..02e2a3551205a4398a74a167a82802d950c962f6 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -525,6 +525,7 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
> 			continue;
> 		}
>
>+		VIRTIO_VSOCK_SKB_CB(skb)->net = vsock_global_net();

I'd add an helper for that.

Or, can we avoid that and pass the net parameter to 
virtio_transport_recv_pkt()?

> 		total_len += sizeof(*hdr) + skb->len;
>
> 		/* Deliver to monitoring devices all received packets */
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 0387d64e2c66c69dd7ab0cad58db5cf0682ad424..e51f89559a1d92685027bf83a62c7b05dd9e566d 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -12,6 +12,7 @@
> struct virtio_vsock_skb_cb {
> 	bool reply;
> 	bool tap_delivered;
>+	struct net *net;
> 	u32 offset;
> };
>
>@@ -148,6 +149,7 @@ struct virtio_vsock_pkt_info {
> 	u32 remote_cid, remote_port;
> 	struct vsock_sock *vsk;
> 	struct msghdr *msg;
>+	struct net *net;
> 	u32 pkt_len;
> 	u16 type;
> 	u16 op;
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index f0e48e6911fc46cba87f7dafeb8dbc21421df254..163ddfc0808529ad6dda7992f9ec48837dd7337c 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -650,6 +650,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
>
> 			virtio_vsock_skb_rx_put(skb);
> 			virtio_transport_deliver_tap_pkt(skb);
>+			VIRTIO_VSOCK_SKB_CB(skb)->net = vsock_global_net();
> 			virtio_transport_recv_pkt(&virtio_transport, skb);
> 		}
> 	} while (!virtqueue_enable_cb(vq));
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 256d2a4fe482b3cb938a681b6924be69b2065616..028591a5863b84059b8e8bbafd499cb997a0c863 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -314,6 +314,8 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
> 					 info->flags,
> 					 zcopy);
>
>+	VIRTIO_VSOCK_SKB_CB(skb)->net = info->net;
>+
> 	return skb;
> out:
> 	kfree_skb(skb);
>@@ -523,6 +525,7 @@ static int virtio_transport_send_credit_update(struct vsock_sock *vsk)
> 	struct virtio_vsock_pkt_info info = {
> 		.op = VIRTIO_VSOCK_OP_CREDIT_UPDATE,
> 		.vsk = vsk,
>+		.net = sock_net(sk_vsock(vsk)),
> 	};
>
> 	return virtio_transport_send_pkt_info(vsk, &info);
>@@ -1061,6 +1064,7 @@ int virtio_transport_connect(struct vsock_sock *vsk)
> 	struct virtio_vsock_pkt_info info = {
> 		.op = VIRTIO_VSOCK_OP_REQUEST,
> 		.vsk = vsk,
>+		.net = sock_net(sk_vsock(vsk)),
> 	};
>
> 	return virtio_transport_send_pkt_info(vsk, &info);
>@@ -1076,6 +1080,7 @@ int virtio_transport_shutdown(struct vsock_sock *vsk, int mode)
> 			 (mode & SEND_SHUTDOWN ?
> 			  VIRTIO_VSOCK_SHUTDOWN_SEND : 0),
> 		.vsk = vsk,
>+		.net = sock_net(sk_vsock(vsk)),
> 	};
>
> 	return virtio_transport_send_pkt_info(vsk, &info);
>@@ -1102,6 +1107,7 @@ virtio_transport_stream_enqueue(struct vsock_sock *vsk,
> 		.msg = msg,
> 		.pkt_len = len,
> 		.vsk = vsk,
>+		.net = sock_net(sk_vsock(vsk)),
> 	};
>
> 	return virtio_transport_send_pkt_info(vsk, &info);
>@@ -1139,6 +1145,7 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
> 		.op = VIRTIO_VSOCK_OP_RST,
> 		.reply = !!skb,
> 		.vsk = vsk,
>+		.net = sock_net(sk_vsock(vsk)),
> 	};
>
> 	/* Send RST only if the original pkt is not a RST pkt */
>@@ -1159,6 +1166,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
> 		.op = VIRTIO_VSOCK_OP_RST,
> 		.type = le16_to_cpu(hdr->type),
> 		.reply = true,
>+		.net = VIRTIO_VSOCK_SKB_CB(skb)->net,
> 	};
> 	struct sk_buff *reply;
>
>@@ -1476,6 +1484,7 @@ virtio_transport_send_response(struct vsock_sock *vsk,
> 		.remote_port = le32_to_cpu(hdr->src_port),
> 		.reply = true,
> 		.vsk = vsk,
>+		.net = sock_net(sk_vsock(vsk)),
> 	};
>
> 	return virtio_transport_send_pkt_info(vsk, &info);
>@@ -1590,7 +1599,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> 			       struct sk_buff *skb)
> {
> 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
>-	struct net *net = vsock_global_net();
>+	struct net *net = VIRTIO_VSOCK_SKB_CB(skb)->net;
> 	struct sockaddr_vm src, dst;
> 	struct vsock_sock *vsk;
> 	struct sock *sk;
>
>-- 
>2.47.1
>

