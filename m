Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38B433D6E7
	for <virtualization@lists.linux.dev>; Wed, 12 Nov 2025 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762964039; cv=none; b=D98NMMhsfRCJqr1EwMyM6Shl34gdAqGRna7XmfMq1tKk9dcBlxv7TpQ2eOv8vBK2pzHUF56ABQkg/kHddHEhjuXG7SpXd4qTqrG9FkQCBOz4EFdXMVSLSZzffU1BbFVv1PdKKQYE3FfxTRMmVrrYjs/xb8iSa7hAd3Ju/YOwCt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762964039; c=relaxed/simple;
	bh=bV+9fG0+Nz41M14zo+PileUvvIjbjVs23HdEOcQZ0lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozwfqvS7rSwSmkSgRw6zU1y+Ia3ogaT/fY/Nf+vNxj5II9R1zfauJgKsXtfR8n/VQJtOkpm+wV958btvKnzy6NylJtXdw5ak4Vh15HuNlx4Q3KaUB92YqFtTE4IX6pLO3nPnqXwRk2vn28l76H1PS+JNlJ08PTYNT2p1LaPtP4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9nJw4Cc; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9nJw4Cc"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-787ff3f462bso8982857b3.0
        for <virtualization@lists.linux.dev>; Wed, 12 Nov 2025 08:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762964035; x=1763568835; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWXLxch4fPGZbP28s9KbUOromLS9hOdnT1C/CmmWTyg=;
        b=J9nJw4CcdKYFaMQquuiA2crnNAVClEDZYaOnpHqRZ372OeQZfyGFCwUxE3DXfGDfdW
         tjXOtLczUMOUHrtpNwLgK2THOzf9I/JYIbO7UwtJlxtY5DdoOf0rzAkSieoSqG/hIv8N
         +s92+9FpET4+2Od3wUKHYfNNPv4JJ/SODoKIFFNl+C/AOBGcERX2MGotsh9HoSFSGwiF
         uldB+bcE+M6ltjYecAwrK6WEcvD0u/OmNnlvur6SKeyuuFUVPtFMCCxtmM/85LJAdCk7
         sbhBS6aWjktWh2i52PkVcxeLNt7ZoF1BYQiX38E+tBTrOAKa+FjbDyYeUiFHLjcJyUxg
         BWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762964035; x=1763568835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWXLxch4fPGZbP28s9KbUOromLS9hOdnT1C/CmmWTyg=;
        b=PdHpFot1spq1jGyyM24af878oX9UkeM0/2C2cCOzKeJLJOuqXDhVNFNjB4jI2s4Y7y
         XXSoEt/W1z48jWTL5i8wDUH9FnJEMpMK6dbVQZsq3YqZks/tJUVuC0ToKlQpD0XdnDXE
         jbNoS7IVeaJF9IyzCz3qK3pUECCpQe2cYCQ12Y+QWrCZJbpUTISk8SoyQt7/7xqaBTz0
         +BpxmJE3iK/6AEGBDfMvhsaOq1jGSq+SgPoYwmqMRuapYanAaZltVVA5zVWGwjXXFA+3
         uKlUIfSLujobdBQxvq4olV+EI+ugxqnPsZ2bNQwxsSHHgm9MfLCpjn5ukOzfiejrB5W1
         XPEg==
X-Forwarded-Encrypted: i=1; AJvYcCVmmN/3YVesf0aGp8kCv1HtUGU30P2Dyo4lRC1B83haiZzBu5A5PYyeCjntNEyu0vHG7M6GQ5I5pXV68w2c8w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxjCzrcY0Sa3Di4Fh/vvwvp49rH6RHQO79aNuROxTkA5KedUm0i
	6cVAddDrQgD1/fdBCVGez7vPpekLYnIThtdH+9B3RKJip8GHW1o12cq2
X-Gm-Gg: ASbGnct20bRbO6dCE8BigIGM/JPQV2j4Q51kCWCROPBcdeYnui/tZfo2R4qo4hDtG3w
	/BSVkcUBo9i5UiVKJ8fK9V5B6RyeTz9uPlFabQ3wMhDQKzzpg26lyNMXKsCt5ewIGv0H6JPu2RB
	iCeMXgg0UsUR+uT136SIgHoA7xE38iLkhu1romi+OwZQgFDWZm0l4tpJAOjMoVRyYv09152LcAV
	boBG9WLXrWd6rHo60wgkuF0Jow2iZb1wjyuSMZibEViUFKM+EuC+ZkdV5g7MA7WS9/Q7E3CJPxa
	sgpa49npk3UkYTPuBXj3h8GSvwT00nybz4Go1dVXBRaDQEd9B7PtRtgwjZD1bRV3IGqcNwGHxd7
	pTOW9jEK/r5vWRJvYL59XB7i/DBsSr+64h9ddTOSjgYIoorspfk7X4BSZ17rmUohtElWLKWbE6b
	1FSOgFWo+SsQCUmG9neoQB2yGr2lI85i08R+NT
X-Google-Smtp-Source: AGHT+IG2G3P30kZcCv3rfJdtjQk8VSMOmNhJqxSYHopRVbIImAuf4PvnQsG3NnVMoqig5hhfdiiIcQ==
X-Received: by 2002:a05:690c:6c03:b0:787:c44d:4b39 with SMTP id 00721157ae682-78812f5873fmr32756047b3.4.1762964034456;
        Wed, 12 Nov 2025 08:13:54 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:4c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d6a20dd5sm43280497b3.52.2025.11.12.08.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 08:13:54 -0800 (PST)
Date: Wed, 12 Nov 2025 08:13:50 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v9 03/14] vsock/virtio: add netns support to
 virtio transport and virtio common
Message-ID: <aRSyPqNo1LhqGLBq@devvm11784.nha0.facebook.com>
References: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
 <20251111-vsock-vmtest-v9-3-852787a37bed@meta.com>
 <cah4sqsqbdp52byutxngl3ko44kduesbhan6luhk3ukzml7bs6@hlv4ckunx7jj>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cah4sqsqbdp52byutxngl3ko44kduesbhan6luhk3ukzml7bs6@hlv4ckunx7jj>

On Wed, Nov 12, 2025 at 03:18:42PM +0100, Stefano Garzarella wrote:
> On Tue, Nov 11, 2025 at 10:54:45PM -0800, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Enable network namespace support in the virtio-vsock and common
> > transport layer.
> > 
> > The changes include:
> 
> This list seems to have been generated by AI. I have nothing against it, but
> I don't think it's important to list all the things that have changed, but
> rather to explain why.

Sounds good, I'll keep that in mind on why vs what. I have been
experimenting with AI in my process, but sadly this list was mostly
hand-rolled. I guess exhaustive listing is an over-correction for too
sparse of commit messages on my part.

> 
> > 1. Add a 'net' field to virtio_vsock_pkt_info to carry the namespace
> >   pointer for outgoing packets.
> 
> Why?
> 
> > 2. Add 'net' and 'net_mode' to t->send_pkt() and
> >   virtio_transport_recv_pkt() functions
> 
> Why?
> 
> > 3. Modify callback functions to accept placeholder values
> >   (NULL and 0) for net and net_mode. The placeholders will be
> 
> Why 0 ? I mean VSOCK_NET_MODE_GLOBAL is also 0, no?
> So I don't understand if you want to specify an invalid value (like NULL) or
> VSOCK_NET_MODE_GLOBAL.
> 
> >   replaced when later patches in this series add namespace support
> >   to transports.
> > 4. Set virtio-vsock to global mode unconditionally, instead of using
> >   placeholders. This is done in this patch because virtio-vsock won't
> >   have any additional changes to choose the net/net_mode, unlike the
> >   other transports. Same complexity as placeholders.
> > 5. Pass net and net_mode to virtio_transport_reset_no_sock() directly.
> >   This ensures that the outgoing RST packets are scoped based on the
> >   namespace of the receiver of the failed request.
> 
> "Receiver" is confusing IMO, see the comment on
> virtio_transport_reset_no_sock().
> 
> > 6. Pass net and net_mode to socket lookup functions using
> >   vsock_find_{bound,connected}_socket_net().
> 
> mmmm, are those functions working fine with the placeholders?

They should resolve everything to global mode as this is why
virtio-vsock does by the end of this series, but I didn't run the
tests specifically on this patch.
> 
> If it simplifies, I think we can eventually merge all changes to transports
> that depends on virtio_transport_common in a single commit.
> IMO is better to have working commits than better split.

That would be so much easier. Much of this patch is just me trying to
find a way to keep total patch size reasonably small for review... if
having them all in one commit is preferred then that makes life easier.

The answer to all of the above is that I was just trying to make the
virtio_common changes in one place, but not break bisect/build by
failing to update the transport-level call sites. So the placeholder
values are primarily there to compile.

> 
> I mean, is this commit working (at runtime) well?

In theory it should, but I only build checked it.

> > 
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> > Changes in v9:
> > - include/virtio_vsock.h: send_pkt() cb takes net and net_mode
> > - virtio_transport reset_no_sock() takes net and net_mode
> > - vhost-vsock: add placeholders to recv_pkt() for compilation
> > - loopback: add placeholders to recv_pkt() for compilation
> > - remove skb->cb net/net_mode usage, pass as arguments to
> >  t->send_pkt() and virtio_transport_recv_pkt() functions instead.
> >  Note that skb->cb will still be used by loopback, but only internal
> >  to loopback and never passing it to virtio common.
> > - remove virtio_vsock_alloc_rx_skb(), it is not needed after removing
> >  skb->cb usage.
> > - pass net and net_mode to virtio_transport_reset_no_sock()
> > 
> > Changes in v8:
> > - add the virtio_vsock_alloc_rx_skb(), to be in same patch that fields
> > are read (Stefano)
> > 
> > Changes in v7:
> > - add comment explaining the !vsk case in virtio_transport_alloc_skb()
> > ---
> > drivers/vhost/vsock.c                   |  6 ++--
> > include/linux/virtio_vsock.h            |  8 +++--
> > net/vmw_vsock/virtio_transport.c        | 10 ++++--
> > net/vmw_vsock/virtio_transport_common.c | 57 ++++++++++++++++++++++++---------
> > net/vmw_vsock/vsock_loopback.c          |  5 +--
> > 5 files changed, 62 insertions(+), 24 deletions(-)
> > 
> > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > index 34adf0cf9124..0a0e73405532 100644
> > --- a/drivers/vhost/vsock.c
> > +++ b/drivers/vhost/vsock.c
> > @@ -269,7 +269,8 @@ static void vhost_transport_send_pkt_work(struct vhost_work *work)
> > }
> > 
> > static int
> > -vhost_transport_send_pkt(struct sk_buff *skb)
> > +vhost_transport_send_pkt(struct sk_buff *skb, struct net *net,
> > +			 enum vsock_net_mode net_mode)
> > {
> > 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> > 	struct vhost_vsock *vsock;
> > @@ -537,7 +538,8 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
> > 		if (le64_to_cpu(hdr->src_cid) == vsock->guest_cid &&
> > 		    le64_to_cpu(hdr->dst_cid) ==
> > 		    vhost_transport_get_local_cid())
> > -			virtio_transport_recv_pkt(&vhost_transport, skb);
> > +			virtio_transport_recv_pkt(&vhost_transport, skb, NULL,
> > +						  0);
> > 		else
> > 			kfree_skb(skb);
> > 
> > diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> > index 0c67543a45c8..5ed6136a4ed4 100644
> > --- a/include/linux/virtio_vsock.h
> > +++ b/include/linux/virtio_vsock.h
> > @@ -173,6 +173,8 @@ struct virtio_vsock_pkt_info {
> > 	u32 remote_cid, remote_port;
> > 	struct vsock_sock *vsk;
> > 	struct msghdr *msg;
> > +	struct net *net;
> > +	enum vsock_net_mode net_mode;
> > 	u32 pkt_len;
> > 	u16 type;
> > 	u16 op;
> > @@ -185,7 +187,8 @@ struct virtio_transport {
> > 	struct vsock_transport transport;
> > 
> > 	/* Takes ownership of the packet */
> > -	int (*send_pkt)(struct sk_buff *skb);
> > +	int (*send_pkt)(struct sk_buff *skb, struct net *net,
> > +			enum vsock_net_mode net_mode);
> > 
> > 	/* Used in MSG_ZEROCOPY mode. Checks, that provided data
> > 	 * (number of buffers) could be transmitted with zerocopy
> > @@ -280,7 +283,8 @@ virtio_transport_dgram_enqueue(struct vsock_sock *vsk,
> > void virtio_transport_destruct(struct vsock_sock *vsk);
> > 
> > void virtio_transport_recv_pkt(struct virtio_transport *t,
> > -			       struct sk_buff *skb);
> > +			       struct sk_buff *skb, struct net *net,
> > +			       enum vsock_net_mode net_mode);
> > void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *skb);
> > u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 wanted);
> > void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit);
> > diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> > index f92f23be3f59..9395fd875823 100644
> > --- a/net/vmw_vsock/virtio_transport.c
> > +++ b/net/vmw_vsock/virtio_transport.c
> > @@ -231,7 +231,8 @@ static int virtio_transport_send_skb_fast_path(struct virtio_vsock *vsock, struc
> > }
> > 
> > static int
> > -virtio_transport_send_pkt(struct sk_buff *skb)
> > +virtio_transport_send_pkt(struct sk_buff *skb, struct net *net,
> > +			  enum vsock_net_mode net_mode)
> > {
> > 	struct virtio_vsock_hdr *hdr;
> > 	struct virtio_vsock *vsock;
> > @@ -660,7 +661,12 @@ static void virtio_transport_rx_work(struct work_struct *work)
> > 				virtio_vsock_skb_put(skb, payload_len);
> > 
> > 			virtio_transport_deliver_tap_pkt(skb);
> > -			virtio_transport_recv_pkt(&virtio_transport, skb);
> > +
> > +			/* Force virtio-transport into global mode since it
> > +			 * does not yet support local-mode namespacing.
> > +			 */
> > +			virtio_transport_recv_pkt(&virtio_transport, skb,
> > +						  NULL, VSOCK_NET_MODE_GLOBAL);
> > 		}
> > 	} while (!virtqueue_enable_cb(vq));
> > 
> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > index dcc8a1d5851e..f4e09cb1567c 100644
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
> > @@ -413,7 +413,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> > 
> > 		virtio_transport_inc_tx_pkt(vvs, skb);
> > 
> > -		ret = t_ops->send_pkt(skb);
> > +		ret = t_ops->send_pkt(skb, info->net, info->net_mode);
> > 		if (ret < 0)
> > 			break;
> > 
> > @@ -527,6 +527,8 @@ static int virtio_transport_send_credit_update(struct vsock_sock *vsk)
> > 	struct virtio_vsock_pkt_info info = {
> > 		.op = VIRTIO_VSOCK_OP_CREDIT_UPDATE,
> > 		.vsk = vsk,
> > +		.net = sock_net(sk_vsock(vsk)),
> > +		.net_mode = vsk->net_mode,
> > 	};
> > 
> > 	return virtio_transport_send_pkt_info(vsk, &info);
> > @@ -1067,6 +1069,8 @@ int virtio_transport_connect(struct vsock_sock *vsk)
> > 	struct virtio_vsock_pkt_info info = {
> > 		.op = VIRTIO_VSOCK_OP_REQUEST,
> > 		.vsk = vsk,
> > +		.net = sock_net(sk_vsock(vsk)),
> > +		.net_mode = vsk->net_mode,
> > 	};
> > 
> > 	return virtio_transport_send_pkt_info(vsk, &info);
> > @@ -1082,6 +1086,8 @@ int virtio_transport_shutdown(struct vsock_sock *vsk, int mode)
> > 			 (mode & SEND_SHUTDOWN ?
> > 			  VIRTIO_VSOCK_SHUTDOWN_SEND : 0),
> > 		.vsk = vsk,
> > +		.net = sock_net(sk_vsock(vsk)),
> > +		.net_mode = vsk->net_mode,
> > 	};
> > 
> > 	return virtio_transport_send_pkt_info(vsk, &info);
> > @@ -1108,6 +1114,8 @@ virtio_transport_stream_enqueue(struct vsock_sock *vsk,
> > 		.msg = msg,
> > 		.pkt_len = len,
> > 		.vsk = vsk,
> > +		.net = sock_net(sk_vsock(vsk)),
> > +		.net_mode = vsk->net_mode,
> > 	};
> > 
> > 	return virtio_transport_send_pkt_info(vsk, &info);
> > @@ -1145,6 +1153,8 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
> > 		.op = VIRTIO_VSOCK_OP_RST,
> > 		.reply = !!skb,
> > 		.vsk = vsk,
> > +		.net = sock_net(sk_vsock(vsk)),
> > +		.net_mode = vsk->net_mode,
> > 	};
> > 
> > 	/* Send RST only if the original pkt is not a RST pkt */
> > @@ -1156,15 +1166,27 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
> > 
> > /* Normally packets are associated with a socket.  There may be no socket if an
> >  * attempt was made to connect to a socket that does not exist.
> > + *
> > + * net and net_mode refer to the net and mode of the receiving device (e.g.,
> > + * vhost_vsock). For loopback, they refer to the sending socket net/mode. This
> > + * way the RST packet is sent back to the same namespace as the bad request.
> 
> Could this be a problem, should we split this function?
> 
> BTW, I'm a bit confused. For vhost-vsock, this is the namespace of the
> device, so the namespace of the guest, so also in that case the namespace of
> the sender, no?
> 
> Maybe sender/receiver are confusing. What you want to highlight with this
> comment?
> 

Sounds good, I'll try to update it with clarification. The namespace
passed in needs to be the namespace of whoever sent the bad message.
For vhost-vsock (and probably virtio-vsock eventually) that will be the
device/guest namespace. For loopback, it is just the namespace of the
socket that sent the bad message.

> >  */
> > static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
> > -					  struct sk_buff *skb)
> > +					  struct sk_buff *skb, struct net *net,
> > +					  enum vsock_net_mode net_mode)
> > {
> > 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> > 	struct virtio_vsock_pkt_info info = {
> > 		.op = VIRTIO_VSOCK_OP_RST,
> > 		.type = le16_to_cpu(hdr->type),
> > 		.reply = true,
> > +
> > +		/* net or net_mode are not defined here because we pass
> > +		 * net and net_mode directly to t->send_pkt(), instead of
> > +		 * relying on virtio_transport_send_pkt_info() to pass them to
> > +		 * t->send_pkt(). They are not needed by
> > +		 * virtio_transport_alloc_skb().
> > +		 */
> > 	};
> > 	struct sk_buff *reply;
> > 
> > @@ -1183,7 +1205,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
> > 	if (!reply)
> > 		return -ENOMEM;
> > 
> > -	return t->send_pkt(reply);
> > +	return t->send_pkt(reply, net, net_mode);
> > }
> > 
> > /* This function should be called with sk_lock held and SOCK_DONE set */
> > @@ -1465,6 +1487,8 @@ virtio_transport_send_response(struct vsock_sock *vsk,
> > 		.remote_port = le32_to_cpu(hdr->src_port),
> > 		.reply = true,
> > 		.vsk = vsk,
> > +		.net = sock_net(sk_vsock(vsk)),
> > +		.net_mode = vsk->net_mode,
> > 	};
> > 
> > 	return virtio_transport_send_pkt_info(vsk, &info);
> > @@ -1507,12 +1531,12 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
> > 	int ret;
> > 
> > 	if (le16_to_cpu(hdr->op) != VIRTIO_VSOCK_OP_REQUEST) {
> > -		virtio_transport_reset_no_sock(t, skb);
> > +		virtio_transport_reset_no_sock(t, skb, sock_net(sk), vsk->net_mode);
> > 		return -EINVAL;
> > 	}
> > 
> > 	if (sk_acceptq_is_full(sk)) {
> > -		virtio_transport_reset_no_sock(t, skb);
> > +		virtio_transport_reset_no_sock(t, skb, sock_net(sk), vsk->net_mode);
> > 		return -ENOMEM;
> > 	}
> > 
> > @@ -1520,13 +1544,13 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
> > 	 * Subsequent enqueues would lead to a memory leak.
> > 	 */
> > 	if (sk->sk_shutdown == SHUTDOWN_MASK) {
> > -		virtio_transport_reset_no_sock(t, skb);
> > +		virtio_transport_reset_no_sock(t, skb, sock_net(sk), vsk->net_mode);
> > 		return -ESHUTDOWN;
> > 	}
> > 
> > 	child = vsock_create_connected(sk);
> > 	if (!child) {
> > -		virtio_transport_reset_no_sock(t, skb);
> > +		virtio_transport_reset_no_sock(t, skb, sock_net(sk), vsk->net_mode);
> > 		return -ENOMEM;
> > 	}
> > 
> > @@ -1548,7 +1572,7 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
> > 	 */
> > 	if (ret || vchild->transport != &t->transport) {
> > 		release_sock(child);
> > -		virtio_transport_reset_no_sock(t, skb);
> > +		virtio_transport_reset_no_sock(t, skb, sock_net(sk), vsk->net_mode);
> > 		sock_put(child);
> > 		return ret;
> > 	}
> > @@ -1576,7 +1600,8 @@ static bool virtio_transport_valid_type(u16 type)
> >  * lock.
> >  */
> > void virtio_transport_recv_pkt(struct virtio_transport *t,
> > -			       struct sk_buff *skb)
> > +			       struct sk_buff *skb, struct net *net,
> > +			       enum vsock_net_mode net_mode)
> > {
> > 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> > 	struct sockaddr_vm src, dst;
> > @@ -1599,24 +1624,24 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> > 					le32_to_cpu(hdr->fwd_cnt));
> > 
> > 	if (!virtio_transport_valid_type(le16_to_cpu(hdr->type))) {
> > -		(void)virtio_transport_reset_no_sock(t, skb);
> > +		(void)virtio_transport_reset_no_sock(t, skb, net, net_mode);
> > 		goto free_pkt;
> > 	}
> > 
> > 	/* The socket must be in connected or bound table
> > 	 * otherwise send reset back
> > 	 */
> > -	sk = vsock_find_connected_socket(&src, &dst);
> > +	sk = vsock_find_connected_socket_net(&src, &dst, net, net_mode);
> 
> Here `net` can be null, right? Is this okay?
> 

Yes, it can be null. net_eq() comparisons pointers (returns false), and
then the modes evaluate w/ GLOBAL == GLOBAL.

This goes away if we combine patches though.

Thanks again for the review!

Best,
Bobby
