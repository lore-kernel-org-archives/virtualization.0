Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEA91DE3A9
	for <virtualization@lists.linux.dev>; Wed, 19 Mar 2025 19:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742411113; cv=none; b=LIEDReBLXFHrHsqxYB09MuGGj9hLVb+p6gVigzHL28YQKf3/GxwV2qpgQbEEsqV0cdYrnI3NYOFvUAr1x93Ei6//QnxYyv6lEid12DW3qTOzlBpwCSJQKyLhw8K1OuAYSF3zN3WmioIeD8Ywr4dftrAuIMn+aRxhnyqHgIN/G5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742411113; c=relaxed/simple;
	bh=Kv01JEx0IIZ+D1J60/PE70oFHhcpP5jrteoDemWZ0fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHoipBs7fCMA3v70u+0jA7gd1er3AI6+TsdBVXd7YSC13LCZ91upvCGFQPsjv19Y8d+Rk7l2m3KFJ4/NHY0f6vSvt8jrsLYp1sLnguV0UPGCNtWGYvuivpi9joBSMl8nT4htSNEf6Fn58xrh+rVYhIaXMwfSC8Zuq9avNWBYNAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QH9RHWE8; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QH9RHWE8"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22403cbb47fso139599905ad.0
        for <virtualization@lists.linux.dev>; Wed, 19 Mar 2025 12:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742411111; x=1743015911; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VDNDArzO5k1C3dDCqgw9lXaD8g8wObtXKLtFnSZBfiM=;
        b=QH9RHWE84nodnmg8Pq0lsnSFrcWJ1R3dC3qPc0RfZ2YM861jsKEa3DAHnWLYYjCt/+
         DPmvAPkmHFx8PVcxGx4xwvTKV3sTk7kIejFC/6tZR6dR4pvqI/dYwBwJkMy+nBPoSZr/
         KOJ8Mn2S9TF/yUWgapDETUn1/iDS2QNgbSroPW8i8GjcJrZ8VMDScpo3OjRP9QP9wxUq
         IBG7TYgA/TkaMZi1ggnWrkLwxUkoala+VcInBH9N3i6V8668oyCu2kNZ9JhzfvNNWlbm
         4BlTNeHasVqZLFETTfnCjWC9cNUG86kO5nLY66gUhJ9wJRaY3Q9Dy8J+7dcnb6ndsiNz
         x1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742411111; x=1743015911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDNDArzO5k1C3dDCqgw9lXaD8g8wObtXKLtFnSZBfiM=;
        b=oh+wieqKObRjIov2p3ALecRUcGa5JpzloADu5NANDscc1yO1cepIVKDzk/7dN2HtD3
         J7bizlTEIkHPE23i1V/wQ6g0JZpuyv9oY0tlFE9L2cZ2cTSzQ0XhQiFQWR3Lg5uYqt5L
         Ys/pV3YF0uL/SxCzXBbOJY0bTFKh7nTgfC89iay9xewFsoZ8cmwSgrmDoWDFt7FTR5ZG
         tXhhZepNo0AaQIGfU5oMvQAT90ex+rxwWHpVkJ8JN1dKsgcvnzGVRlNBunTu/O6m7yB5
         pC2uHP7PrlV4ofzblCtTYdNZljbCAs7f3YYPm39zWDV9MEA43UEk3nuBASuaETnaN4sa
         mMYg==
X-Forwarded-Encrypted: i=1; AJvYcCUbkX7i5E5ax6t85l8tQ7yaV3kOPjiFZ/0wps69lqoldvOGabZ/52X0u0mvK+LwetVphOaz2zAdYC4O4CGl6Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YynPAmSHprbiKIuDztQS3iw9pHpYb0gsw37TdND3MFMD5M8osRv
	ICXLRuc92HSBC/z/m5cJ7OOZAtFYm5ghfLd6zxWF6ElWoOA2hJyh
X-Gm-Gg: ASbGncsYBYdOmgCswkxwi2kCdCo2twuQcqR132oHntK1uy9QC6C139wbc7QwiV2sZHr
	ZoteiTZEQy+Rqhvj+Yak9kb4uCnh9lsk6Wte40+DF6pwE2mYQYJoV9x1VOsBKTG7YMaVDveaFv+
	1M1xWGhdqqeGtTvitzWm40vWpzdPOnvxZUPGIV1Xlhq1334R/RP2xA3c/spQq+j/tAvTIF5j95L
	Pe7ALueBkxJNDna403C+kVEgX5ZD4tcLc/jF29vJtxovvLn3YhHoES7fFU3RqnvxBMwrjLLd3hU
	OJKSbw6JHcZGRV/FfAuLne6wR7bJABN89bqQVBfAOSXpgCrT2crhLWgNSSMiGI7kTA==
X-Google-Smtp-Source: AGHT+IHgxm4iaNrZNGMW9Oz+3tncQIFyq+/H3ImvQRNH0Q4o5Ap8UBOH1MEb2qULK3uBV1U+pGjbMw==
X-Received: by 2002:a17:902:f605:b0:224:162:a3e0 with SMTP id d9443c01a7336-2265eeb78d7mr7863315ad.49.1742411110875;
        Wed, 19 Mar 2025 12:05:10 -0700 (PDT)
Received: from devvm6277.cco0.facebook.com ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba6cc7sm118713835ad.144.2025.03.19.12.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 12:05:10 -0700 (PDT)
Date: Wed, 19 Mar 2025 12:05:08 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH v2 2/3] vsock/virtio_transport_common: handle netns of
 received packets
Message-ID: <Z9sVZOflrjJj9uMR@devvm6277.cco0.facebook.com>
References: <20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com>
 <20250312-vsock-netns-v2-2-84bffa1aa97a@gmail.com>
 <6iepaq4rqd65lhpqfpplzurwkezdyrjolijrz4feqakh3ghbjy@fxoiw5yiyzp3>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6iepaq4rqd65lhpqfpplzurwkezdyrjolijrz4feqakh3ghbjy@fxoiw5yiyzp3>

On Wed, Mar 19, 2025 at 02:26:04PM +0100, Stefano Garzarella wrote:
> On Wed, Mar 12, 2025 at 01:59:36PM -0700, Bobby Eshleman wrote:
> > From: Stefano Garzarella <sgarzare@redhat.com>
> > 
> > This patch allows transports that use virtio_transport_common
> > to specify the network namespace where a received packet is to
> > be delivered.
> > 
> > virtio_transport and vhost_transport, for now, still do not use this
> > capability and preserve old behavior.
> 
> What about vsock_loopback?
> 

Also unaffected, I'll add that comment here too.

> > 
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@gmail.com>
> > ---
> > V1 -> V2
> > * use vsock_global_net()
> > * add net to skb->cb
> > * forward port for skb
> > ---
> > drivers/vhost/vsock.c                   |  1 +
> > include/linux/virtio_vsock.h            |  2 ++
> > net/vmw_vsock/virtio_transport.c        |  1 +
> > net/vmw_vsock/virtio_transport_common.c | 11 ++++++++++-
> > 4 files changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > index 802153e230730bdbfbbb6f4ae263ae99502ef532..02e2a3551205a4398a74a167a82802d950c962f6 100644
> > --- a/drivers/vhost/vsock.c
> > +++ b/drivers/vhost/vsock.c
> > @@ -525,6 +525,7 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
> > 			continue;
> > 		}
> > 
> > +		VIRTIO_VSOCK_SKB_CB(skb)->net = vsock_global_net();
> 
> I'd add an helper for that.
> 
> Or, can we avoid that and pass the net parameter to
> virtio_transport_recv_pkt()?
> 

Makes sense. I like that passing it in reduces the places that cb->net is
assigned.

> > 		total_len += sizeof(*hdr) + skb->len;
> > 
> > 		/* Deliver to monitoring devices all received packets */
> > diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> > index 0387d64e2c66c69dd7ab0cad58db5cf0682ad424..e51f89559a1d92685027bf83a62c7b05dd9e566d 100644
> > --- a/include/linux/virtio_vsock.h
> > +++ b/include/linux/virtio_vsock.h
> > @@ -12,6 +12,7 @@
> > struct virtio_vsock_skb_cb {
> > 	bool reply;
> > 	bool tap_delivered;
> > +	struct net *net;
> > 	u32 offset;
> > };
> > 
> > @@ -148,6 +149,7 @@ struct virtio_vsock_pkt_info {
> > 	u32 remote_cid, remote_port;
> > 	struct vsock_sock *vsk;
> > 	struct msghdr *msg;
> > +	struct net *net;
> > 	u32 pkt_len;
> > 	u16 type;
> > 	u16 op;
> > diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> > index f0e48e6911fc46cba87f7dafeb8dbc21421df254..163ddfc0808529ad6dda7992f9ec48837dd7337c 100644
> > --- a/net/vmw_vsock/virtio_transport.c
> > +++ b/net/vmw_vsock/virtio_transport.c
> > @@ -650,6 +650,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
> > 
> > 			virtio_vsock_skb_rx_put(skb);
> > 			virtio_transport_deliver_tap_pkt(skb);
> > +			VIRTIO_VSOCK_SKB_CB(skb)->net = vsock_global_net();
> > 			virtio_transport_recv_pkt(&virtio_transport, skb);
> > 		}
> > 	} while (!virtqueue_enable_cb(vq));
> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > index 256d2a4fe482b3cb938a681b6924be69b2065616..028591a5863b84059b8e8bbafd499cb997a0c863 100644
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
> > @@ -314,6 +314,8 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
> > 					 info->flags,
> > 					 zcopy);
> > 
> > +	VIRTIO_VSOCK_SKB_CB(skb)->net = info->net;
> > +
> > 	return skb;
> > out:
> > 	kfree_skb(skb);
> > @@ -523,6 +525,7 @@ static int virtio_transport_send_credit_update(struct vsock_sock *vsk)
> > 	struct virtio_vsock_pkt_info info = {
> > 		.op = VIRTIO_VSOCK_OP_CREDIT_UPDATE,
> > 		.vsk = vsk,
> > +		.net = sock_net(sk_vsock(vsk)),
> > 	};
> > 
> > 	return virtio_transport_send_pkt_info(vsk, &info);
> > @@ -1061,6 +1064,7 @@ int virtio_transport_connect(struct vsock_sock *vsk)
> > 	struct virtio_vsock_pkt_info info = {
> > 		.op = VIRTIO_VSOCK_OP_REQUEST,
> > 		.vsk = vsk,
> > +		.net = sock_net(sk_vsock(vsk)),
> > 	};
> > 
> > 	return virtio_transport_send_pkt_info(vsk, &info);
> > @@ -1076,6 +1080,7 @@ int virtio_transport_shutdown(struct vsock_sock *vsk, int mode)
> > 			 (mode & SEND_SHUTDOWN ?
> > 			  VIRTIO_VSOCK_SHUTDOWN_SEND : 0),
> > 		.vsk = vsk,
> > +		.net = sock_net(sk_vsock(vsk)),
> > 	};
> > 
> > 	return virtio_transport_send_pkt_info(vsk, &info);
> > @@ -1102,6 +1107,7 @@ virtio_transport_stream_enqueue(struct vsock_sock *vsk,
> > 		.msg = msg,
> > 		.pkt_len = len,
> > 		.vsk = vsk,
> > +		.net = sock_net(sk_vsock(vsk)),
> > 	};
> > 
> > 	return virtio_transport_send_pkt_info(vsk, &info);
> > @@ -1139,6 +1145,7 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
> > 		.op = VIRTIO_VSOCK_OP_RST,
> > 		.reply = !!skb,
> > 		.vsk = vsk,
> > +		.net = sock_net(sk_vsock(vsk)),
> > 	};
> > 
> > 	/* Send RST only if the original pkt is not a RST pkt */
> > @@ -1159,6 +1166,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
> > 		.op = VIRTIO_VSOCK_OP_RST,
> > 		.type = le16_to_cpu(hdr->type),
> > 		.reply = true,
> > +		.net = VIRTIO_VSOCK_SKB_CB(skb)->net,
> > 	};
> > 	struct sk_buff *reply;
> > 
> > @@ -1476,6 +1484,7 @@ virtio_transport_send_response(struct vsock_sock *vsk,
> > 		.remote_port = le32_to_cpu(hdr->src_port),
> > 		.reply = true,
> > 		.vsk = vsk,
> > +		.net = sock_net(sk_vsock(vsk)),
> > 	};
> > 
> > 	return virtio_transport_send_pkt_info(vsk, &info);
> > @@ -1590,7 +1599,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> > 			       struct sk_buff *skb)
> > {
> > 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> > -	struct net *net = vsock_global_net();
> > +	struct net *net = VIRTIO_VSOCK_SKB_CB(skb)->net;
> > 	struct sockaddr_vm src, dst;
> > 	struct vsock_sock *vsk;
> > 	struct sock *sk;
> > 
> > -- 
> > 2.47.1
> > 
> 

Thanks!

Best,
Bobby
