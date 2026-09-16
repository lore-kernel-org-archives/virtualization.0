Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB054DD3B3
	for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 17:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789578419; cv=none; b=OHIJvYsabvOY7WAGD5wUJsRkoVCyANBGb6oflKwbL/PbOJQuut9qq9vbbLjVFQ3aiJQJEF6etO+PtG9brxIpJd/nsM9dPsM70P47w5FL1uRNNOFDZHW22hMZJwi19L4IQ7h6GWpxvkZpUu6/L1hRpOSdX5rQw3NKEyeBOx9KcII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789578419; c=relaxed/simple;
	bh=qfLN5WLAFy26QaPMK2Ae9ZgOW29L0epdNq5+HfGEGw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsFUvhwGCmaLUHspY7LbR/7bh/+L9husI2YL6/BxmBlQhyU5Psk71B+rKiKwqaJp0RiySlk4AfJyU7cJp7oJmTWvXHypcja6TSXTNvsjV16VVcRQQ0A4MEw1lB9StYJ3EJ0sF/SBeJmVCdvEvQaSabxWys4i8N0AbCfzBsFEaLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nK+naW7h; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nK+naW7h"
Received: by mail-oo2-f39.google.com with SMTP id 46e09a7af769-7ff1e4ffb3aso835966a34.1
        for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 10:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789578389; x=1790183189; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r0v/Glg/t1TxvoAL2KbqVzGsnLvj1ftPu+eZkPIP73o=;
        b=nK+naW7hlCU2NyVtk47+oUmrWktmBGEmmS0zjwQaiM373o6TuY3ptDtIiwdz6ADT5/
         9r1dlFQs7F/0loFkUlPf5r2pDIHas24TD2MgPStza3Om+pUk+3XGhcGNrTTBgffu2Ki3
         fcEE8m3NoxBP8yov+Y+mF0gk8eV7BBjuuww/Yi1FbezQuET0Sguzns6/Iuw836D5MfmH
         YI5hs47tc1cTmo5thHweqdeWC+HlbzQN8c12XyYnv+Dan/80GymdH1HlRIymqHPlFzdp
         w0anV1hxP+9kXRHO5JOLAIVBzELNwbM7jWFiIjXTT/IhWPQX9FccmVIRdXcvFT0LD4ZX
         Tlpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789578389; x=1790183189;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r0v/Glg/t1TxvoAL2KbqVzGsnLvj1ftPu+eZkPIP73o=;
        b=qsCjuxIASk6LPZ/rV4QQS8oHQARIL535w/cOI+oGia1hltpUk14dputpA6jgvjMEpH
         VAP3MacwDJEDnRpRWxbr6m1+Llegn708nom9pQg44UuOJEgETNZHa1aLX0Lage1J4Svj
         iIKhSkf9qLynTrZbgzC6IC4SOlW1bo/cyVxZRINvVybHzWAKXY1NqXTfsHGjzjVVKB87
         fun4NshgbIG4VDapQnhwaeJifL8KqgEk2+MJMkFOiy1Ztr7uM77lNcGj3mGt7I3dSGGx
         8hjcKEjgcHQ4jpyiCH0GofSlhUAutPvuSac6HH1wkhL87a8plBLkIprP8RhDX9pWJjhy
         s86w==
X-Forwarded-Encrypted: i=1; AKwUvBztbARXjsjEH6Q8PDVh3zuMHsG2Sofoo0ex9Rtv6aqiRZ22sqWXqdVTbvvhCgRIUCZc/C5halvaGWejuH6N2g==@lists.linux.dev
X-Gm-Message-State: AFuF++lSVIY/DGukASnbfM16h6BBAHJpm4HZZGVp0+aG4H0CUMOgwzzH
	f9pdKWoMx9HDcmmAd3ccjAmYaJEHzifNvxDGLP6aY0/w2p8ksEYK9RzB
X-Gm-Gg: AYBFou0o/okk/1+Tdx4KBGx3z3nR+K63Jy4HZzR85elKQlOmLs9mk62WgzMeurHZRiW
	7xYtY5eAVtcy3ewrntqHfqGhqW+BgHKrkD47fySQgPIa9n0KMDkdZZXY0znkmvH3EPTaKH+VW1r
	Q8du2geg1Hc9KkFcsDBzEhtQRaoiLBVRcoLc9zLUnvb8M19y6DaCkIxYoW8hu0o13Yog4Vyf5ir
	4peFjVwikUto2Xe5DXiW5tgt3c6WZOwfP+nRWz0Bjf/oBK7uLnJW0gLlCn9mSGeRlTZ5Jz0iZUl
	wh8QfMTfuhJvU/3IskMmOUafbg8RDmXFHGXJayOSMtGCF1tSfQKm6OpK0GfGknoo3Kkn9abAvJJ
	RQGgl4UP1rLgnptUHYwC8EFNqVElwEJ1RMOnz7uz9lwuh2i0EpKRkOp/HAS9nSiYwIO4eoL9QRG
	fsBsIpBr5bmkfwPz63hmsJR1CFZIHyeKnsoDxtJSu+eTMuIwgKUOCrPZs0R0Xcr75wx4OOVk5XZ
	4M45vCTKcaG7gJnf/YGZxLfdUKZg8Y=
X-Received: by 2002:a05:6830:2705:b0:806:1e7:4167 with SMTP id 46e09a7af769-80b2da2b31fmr3730712a34.13.1789578388877;
        Wed, 16 Sep 2026 10:06:28 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:46::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-80c46199e89sm362502a34.9.2026.09.16.10.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 10:06:28 -0700 (PDT)
Date: Wed, 16 Sep 2026 10:06:24 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	sargun@sargun.me, jlinbox@meta.com,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 3/6] vsock/virtio: support guest device network
 namespace
Message-ID: <aqrMkHgwZdEz1dq+@devvm29614.prn0.facebook.com>
References: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
 <20260902-vsock-guest-ns-v1-3-9995383e9a8b@meta.com>
 <aqlkWGyoUYrgQUzz@sgarzare-redhat>
 <aqmLFzcF3MmwRITz@devvm29614.prn0.facebook.com>
 <aqqNZX0gk0I6AbVG@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqqNZX0gk0I6AbVG@sgarzare-redhat>

On Wed, Sep 16, 2026 at 02:44:28PM +0200, Stefano Garzarella wrote:
> On Tue, Sep 15, 2026 at 11:14:47AM -0700, Bobby Eshleman wrote:
> > On Tue, Sep 15, 2026 at 05:47:02PM +0200, Stefano Garzarella wrote:
> > > On Wed, Sep 02, 2026 at 04:00:49PM -0700, Bobby Eshleman wrote:
> > > > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > > >
> > > > virtio-vsock did not have namespace support (the device was always
> > > > accessible to any global namespace).
> > > >
> > > > Make the virtio-vsock device assignable to a namespace and initialize it
> > > > to init_net. Because virtio-vsock and init_net are both hardcoded to
> > > > global mode, nothing changes until the assign ioctl is issued.
> > > >
> > > > When the device's local-mode namespace is being destroyed, received
> > > > packets are reset until new valid a namespace has been assigned and/or
> > > > automatically returned to, and the next RX batch begins (in
> > > > virtio_transport_rx_work). They are reset rather than dropped because
> > > > vsock does not retransmit, so a silent drop would leave the host waiting
> > > > for a timeout, and a connection request arriving in that window has no
> > > > socket whose teardown would tell it otherwise. This requires making
> > > > virtio_transport_reset_no_sock() available outside of the common code.
> > > >
> > > > When a device is assigned to a namespace, every already established
> > > > vsock socket that is no longer able to reach the device is forcibly
> > > > reset. For that reason, adding new sockets to the connected table must
> > > > be performed atomically with regards to namespace assignment. This
> > > > ensures that when the socket is added to the connected table that it
> > > > actually passes the new reachability conditions set by ns assignment. If
> > > > it wins the race to the table and does NOT pass the reachability tests,
> > > > then the reset sweep will correctly catch it. This is the purpose
> > > > of the new helper 'vsock_maybe_set_connected()'.
> > > >
> > > > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > > > ---
> > > > include/linux/virtio_vsock.h            |  2 ++
> > > > net/vmw_vsock/virtio_transport.c        | 28 ++++++++++++++++++++++------
> > > > net/vmw_vsock/virtio_transport_common.c | 28 +++++++++++++++++++++-------
> > > > 3 files changed, 45 insertions(+), 13 deletions(-)
> > > >
> > > > diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> > > > index f91704731057..9c68ce1d7fb4 100644
> > > > --- a/include/linux/virtio_vsock.h
> > > > +++ b/include/linux/virtio_vsock.h
> > > > @@ -286,6 +286,8 @@ void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *
> > > > u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 wanted);
> > > > void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit);
> > > > void virtio_transport_deliver_tap_pkt(struct sk_buff *skb);
> > > > +int virtio_transport_reset_no_sock(const struct virtio_transport *t,
> > > > +				   struct sk_buff *skb, struct net *net);
> > > > int virtio_transport_purge_skbs(void *vsk, struct sk_buff_head *list);
> > > > int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t read_actor);
> > > > int virtio_transport_notify_set_rcvlowat(struct vsock_sock *vsk, int val);
> > > > diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> > > > index 4f9aa9c4c3aa..a453a4f828dc 100644
> > > > --- a/net/vmw_vsock/virtio_transport.c
> > > > +++ b/net/vmw_vsock/virtio_transport.c
> > > > @@ -540,9 +540,14 @@ static bool virtio_transport_msgzerocopy_allow(void)
> > > > 	return true;
> > > > }
> > > >
> > > > +static bool virtio_transport_netns_assign_allow(void)
> > > > +{
> > > > +	return true;
> > > > +}
> > > > +
> > > > bool virtio_transport_stream_allow(struct vsock_sock *vsk, u32 cid, u32 port)
> > > > {
> > > > -	return vsock_net_mode_global(vsk);
> > > > +	return vsock_g2h_net_reachable(sock_net(sk_vsock(vsk)));
> > > > }
> > > >
> > > > static bool virtio_transport_seqpacket_allow(struct vsock_sock *vsk,
> > > > @@ -587,6 +592,7 @@ static struct virtio_transport virtio_transport = {
> > > > 		.seqpacket_has_data       = virtio_transport_seqpacket_has_data,
> > > >
> > > > 		.msgzerocopy_allow        = virtio_transport_msgzerocopy_allow,
> > > > +		.netns_assign_allow       = virtio_transport_netns_assign_allow,
> > > >
> > > > 		.notify_poll_in           = virtio_transport_notify_poll_in,
> > > > 		.notify_poll_out          = virtio_transport_notify_poll_out,
> > > > @@ -616,7 +622,7 @@ virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
> > > > 	struct virtio_vsock *vsock;
> > > > 	bool seqpacket_allow;
> > > >
> > > > -	if (!vsock_net_mode_global(vsk))
> > > > +	if (!vsock_g2h_net_reachable(sock_net(sk_vsock(vsk))))
> > > > 		return false;
> > > >
> > > > 	seqpacket_allow = false;
> > > > @@ -634,6 +640,9 @@ static void virtio_transport_rx_work(struct work_struct *work)
> > > > 	struct virtio_vsock *vsock =
> > > > 		container_of(work, struct virtio_vsock, rx_work);
> > > > 	struct virtqueue *vq;
> > > > +	struct net *net;
> > > > +
> > > > +	net = vsock_g2h_net_get();
> > > >
> > > > 	mutex_lock(&vsock->rx_lock);
> > > >
> > > > @@ -682,10 +691,14 @@ static void virtio_transport_rx_work(struct work_struct *work)
> > > >
> > > > 			virtio_transport_deliver_tap_pkt(skb);
> > > >
> > > > -			/* Force virtio-transport into global mode since it
> > > > -			 * does not yet support local-mode namespacing.
> > > > -			 */
> > > > -			virtio_transport_recv_pkt(&virtio_transport, skb, NULL);
> > > > +			if (unlikely(!net)) {
> > > > +				virtio_transport_reset_no_sock(
> > > > +					&virtio_transport, skb, &init_net);
> > > 
> > > Why init_net?
> > 
> > This parameter is actually unused by virtio_transport_reset_no_sock(),
> > its call to virtio_transport_send_pkt(), and even the eventual call to
> > virtio_transport_deliver_tap_pkt()... so maybe NULL w/ a comment would
> > be better?
> 
> mmm, should we remove that parameter if unused?

Sadly the vhost path uses it for its vhost_vsock lookup by CID. I guess
it would be needed by g2h too if it had multiple devices and had to
lookup by net+CID.

> 
> Anyway, not in this series/patch.
> 
> Here, anything is fine, just put a comment with the reason.


Sounds good!

Thanks,
Bobby
