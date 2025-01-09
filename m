Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39DC215F71
	for <virtualization@lists.linux.dev>; Thu,  9 Jan 2025 11:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736421020; cv=none; b=PNoWwRMM9xWzNNBv0OJnQXTKdPTzZwjbh6CD0mucAwc4X35IbzedoxGOYWVb2+0VhJkkbsuwe77Pt0uzC54S52iIWw4eULljtgB21QMDIXPxc+jj0aAEPiicJzZC5NiNIyzkXBTZrn3j5k7+oiuH3JbgPUCiUJoviz4U3uHekFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736421020; c=relaxed/simple;
	bh=UUeZRcbvFQU0IU5zd+krxlu/oPz539Cj6HEwFZKEK0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+FbPL/FKSOavbIe7wqA/LmwtKt3hqWjswrjgp9G6dfMl96cM6j1pmnulv5aFYBV5Uu5f/z6d625OzHuEYno+YBt24A9O1GajOJwNDmgxT0iIulPHDnUeaYIDD3j8YUt/dt1fkkLxC+76yaX3Jec4oB8K/7dmc70kEF67r4YipE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io; spf=pass smtp.mailfrom=theori.io; dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b=GJ1Svoky; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theori.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="GJ1Svoky"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2167141dfa1so13074985ad.1
        for <virtualization@lists.linux.dev>; Thu, 09 Jan 2025 03:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1736421018; x=1737025818; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7+ljKu7GZzEGvp6RrMbhl8PlBYJNNWnzxd6tP/33TRU=;
        b=GJ1SvokyTQv7YX9g35N4ozBIF1pDUY2ecFQ5tJRnUxDQ3GDOLYHmZIGxmc3Ha63LIw
         iOn1qMgCrz/JCVbSIWwB3Rb86rWU2UuGaivRDT6vdFmpxYcs/faZNvkgMmmWxikeynfD
         oqZcRhz4Up4SjFBiNCQJEdITCgsQoh3BcvhnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736421018; x=1737025818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+ljKu7GZzEGvp6RrMbhl8PlBYJNNWnzxd6tP/33TRU=;
        b=wsFaX3xFXpYH8HoIA4NkmmhaTxTeZwtvc48L0KPSUu5yBF/oXFfEVp+VPR6G5CxAc4
         8b2HR5VC24AAGavlf1pzfbRdTShfbFOIXWZ3hfQ8x24REjbn/UqfZgjR5n5vJdz+NPo5
         7r+smWWh30PsHEx7f3Ula17yGOK/xVv2KX6s/A7DGJ3MIugNWsvH19wZOGyFjWEZtWij
         INP+AroVBxe1DOtBzPczw7MwNTqndmnVR3ObqCX7Qe7KIHIv8PlxqRrK8ffD7aeGxLG0
         5UzuEB0lq8HC0fQVDru2OO8ff+8fMwfbObKIO3yo6Gwsy9Jy7SDJKXjBpzw2BmY3Jxxw
         LeSw==
X-Forwarded-Encrypted: i=1; AJvYcCVkJNCs9P62tT1FGQF/41iUxrn33zQlW2RUsDbLWU6P6rTuN6OhxaMcPpzYIunIoAVz3U3NxUMyrCRLQU72bw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwVXOmBnoXx3C9b5S+Sp6NMhxnrE4JZcuhkWU6IJRP/Rl56iJCC
	cEk4c/JIXhzOVqunC3h3cEkiER9gBaYqtvFO6pb/aG8BOwmxeANI5zvBE8xKqrs=
X-Gm-Gg: ASbGnctoHPUpVFj3gGs1Ur8STboAUXxxIhBJ0edrZmftiymbxdqw6u93G3BTZylf62q
	TmDiqaye+I2lUwuLvtfvIH3B6+wI1uMqVbrn8RrDCRtaW4utjcbZwMhuevfoT/FCBc1BEpS5jcT
	EclI3Plwi86GJAEHVEq0NGcl3a/oZRdgRVEkb5m0PMbPWX/FuVr9ssIf17QavUXYJXdBePA4ODb
	sHwKc2/zirJMbbDi3ULpiSQ/Nz8iLNsBypGVp38+20wE1GtBYPGB35ZhI1WOp6YFSthEw==
X-Google-Smtp-Source: AGHT+IE6kHjF6VMW7zKKnf4D3URfl2Zhbkt1AYg7UxtWOKnbCc5MRKenY3iXJIlmvTUmO1+DA+iBUw==
X-Received: by 2002:a17:903:2a90:b0:216:1079:82bb with SMTP id d9443c01a7336-21a8d6c7c8cmr46825095ad.19.1736421018208;
        Thu, 09 Jan 2025 03:10:18 -0800 (PST)
Received: from v4bel-B760M-AORUS-ELITE-AX ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a91767dd4sm10210695ad.23.2025.01.09.03.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 03:10:17 -0800 (PST)
Date: Thu, 9 Jan 2025 06:10:10 -0500
From: Hyunwoo Kim <v4bel@theori.io>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Wongi Lee <qwerty@theori.io>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	virtualization@lists.linux.dev,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Luigi Leonardi <leonardi@redhat.com>, bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>, Michal Luczaj <mhal@rbox.co>,
	kvm@vger.kernel.org, imv4bel@gmail.com, v4bel@theori.io
Subject: Re: [PATCH net 1/2] vsock/virtio: discard packets if the transport
 changes
Message-ID: <Z3+ukoUBYp5VVXRX@v4bel-B760M-AORUS-ELITE-AX>
References: <20250108180617.154053-1-sgarzare@redhat.com>
 <20250108180617.154053-2-sgarzare@redhat.com>
 <Z37Sh+utS+iV3+eb@v4bel-B760M-AORUS-ELITE-AX>
 <77plpkw3mp4r3ue4ubmh4yhqfo777koiu65dqfqfxmjgc5uq57@aifi6mhtgtuj>
 <Z3+TSNfTJr2X8oQV@v4bel-B760M-AORUS-ELITE-AX>
 <x3gyqgbor4syfy56j5qolppiec3du4hbkywncmlipt2sw6bp46@vtk4apoy7w3o>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x3gyqgbor4syfy56j5qolppiec3du4hbkywncmlipt2sw6bp46@vtk4apoy7w3o>

On Thu, Jan 09, 2025 at 11:59:21AM +0100, Stefano Garzarella wrote:
> On Thu, Jan 09, 2025 at 04:13:44AM -0500, Hyunwoo Kim wrote:
> > On Thu, Jan 09, 2025 at 10:01:31AM +0100, Stefano Garzarella wrote:
> > > On Wed, Jan 08, 2025 at 02:31:19PM -0500, Hyunwoo Kim wrote:
> > > > On Wed, Jan 08, 2025 at 07:06:16PM +0100, Stefano Garzarella wrote:
> > > > > If the socket has been de-assigned or assigned to another transport,
> > > > > we must discard any packets received because they are not expected
> > > > > and would cause issues when we access vsk->transport.
> > > > >
> > > > > A possible scenario is described by Hyunwoo Kim in the attached link,
> > > > > where after a first connect() interrupted by a signal, and a second
> > > > > connect() failed, we can find `vsk->transport` at NULL, leading to a
> > > > > NULL pointer dereference.
> > > > >
> > > > > Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
> > > > > Reported-by: Hyunwoo Kim <v4bel@theori.io>
> > > > > Reported-by: Wongi Lee <qwerty@theori.io>
> > > > > Closes: https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
> > > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > > > ---
> > > > >  net/vmw_vsock/virtio_transport_common.c | 7 +++++--
> > > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > > > > index 9acc13ab3f82..51a494b69be8 100644
> > > > > --- a/net/vmw_vsock/virtio_transport_common.c
> > > > > +++ b/net/vmw_vsock/virtio_transport_common.c
> > > > > @@ -1628,8 +1628,11 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> > > > >
> > > > >  	lock_sock(sk);
> > > > >
> > > > > -	/* Check if sk has been closed before lock_sock */
> > > > > -	if (sock_flag(sk, SOCK_DONE)) {
> > > > > +	/* Check if sk has been closed or assigned to another transport before
> > > > > +	 * lock_sock (note: listener sockets are not assigned to any transport)
> > > > > +	 */
> > > > > +	if (sock_flag(sk, SOCK_DONE) ||
> > > > > +	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
> > > >
> > > > If a race scenario with vsock_listen() is added to the existing
> > > > race scenario, the patch can be bypassed.
> > > >
> > > > In addition to the existing scenario:
> > > > ```
> > > >                     cpu0                                                      cpu1
> > > >
> > > >                                                               socket(A)
> > > >
> > > >                                                               bind(A, {cid: VMADDR_CID_LOCAL, port: 1024})
> > > >                                                                 vsock_bind()
> > > >
> > > >                                                               listen(A)
> > > >                                                                 vsock_listen()
> > > >  socket(B)
> > > >
> > > >  connect(B, {cid: VMADDR_CID_LOCAL, port: 1024})
> > > >    vsock_connect()
> > > >      lock_sock(sk);
> > > >      virtio_transport_connect()
> > > >        virtio_transport_connect()
> > > >          virtio_transport_send_pkt_info()
> > > >            vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_REQUEST)
> > > >              queue_work(vsock_loopback_work)
> > > >      sk->sk_state = TCP_SYN_SENT;
> > > >      release_sock(sk);
> > > >                                                               vsock_loopback_work()
> > > >                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_REQUEST)
> > > >                                                                   sk = vsock_find_bound_socket(&dst);
> > > >                                                                   virtio_transport_recv_listen(sk, skb)
> > > >                                                                     child = vsock_create_connected(sk);
> > > >                                                                     vsock_assign_transport()
> > > >                                                                       vvs = kzalloc(sizeof(*vvs), GFP_KERNEL);
> > > >                                                                     vsock_insert_connected(vchild);
> > > >                                                                       list_add(&vsk->connected_table, list);
> > > >                                                                     virtio_transport_send_response(vchild, skb);
> > > >                                                                       virtio_transport_send_pkt_info()
> > > >                                                                         vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_RESPONSE)
> > > >                                                                           queue_work(vsock_loopback_work)
> > > >
> > > >                                                               vsock_loopback_work()
> > > >                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_RESPONSE)
> > > >                                                                   sk = vsock_find_bound_socket(&dst);
> > > >                                                                   lock_sock(sk);
> > > >                                                                   case TCP_SYN_SENT:
> > > >                                                                   virtio_transport_recv_connecting()
> > > >                                                                     sk->sk_state = TCP_ESTABLISHED;
> > > >                                                                   release_sock(sk);
> > > >
> > > >                                                               kill(connect(B));
> > > >      lock_sock(sk);
> > > >      if (signal_pending(current)) {
> > > >      sk->sk_state = sk->sk_state == TCP_ESTABLISHED ? TCP_CLOSING : TCP_CLOSE;
> > > >      sock->state = SS_UNCONNECTED;    // [1]
> > > >      release_sock(sk);
> > > >
> > > >  connect(B, {cid: VMADDR_CID_HYPERVISOR, port: 1024})
> > > >    vsock_connect(B)
> > > >      lock_sock(sk);
> > > >      vsock_assign_transport()
> > > >        virtio_transport_release()
> > > >          virtio_transport_close()
> > > >            if (!(sk->sk_state == TCP_ESTABLISHED || sk->sk_state == TCP_CLOSING))
> > > >            virtio_transport_shutdown()
> > > >              virtio_transport_send_pkt_info()
> > > >                vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_SHUTDOWN)
> > > >                  queue_work(vsock_loopback_work)
> > > >            schedule_delayed_work(&vsk->close_work, VSOCK_CLOSE_TIMEOUT);	// [5]
> > > >        vsock_deassign_transport()
> > > >          vsk->transport = NULL;
> > > >        return -ESOCKTNOSUPPORT;
> > > >      release_sock(sk);
> > > >                                                               vsock_loopback_work()
> > > >                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_SHUTDOWN)
> > > >                                                                   virtio_transport_recv_connected()
> > > >                                                                     virtio_transport_reset()
> > > >                                                                       virtio_transport_send_pkt_info()
> > > >                                                                         vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_RST)
> > > >                                                                           queue_work(vsock_loopback_work)
> > > >  listen(B)
> > > >    vsock_listen()
> > > >      if (sock->state != SS_UNCONNECTED)    // [2]
> > > >      sk->sk_state = TCP_LISTEN;    // [3]
> > > >
> > > >                                                               vsock_loopback_work()
> > > >                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_RST)
> > > > 								   if ((sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {    // [4]
> > > > 								   ...
> > > > 							
> > > >  virtio_transport_close_timeout()
> > > >    virtio_transport_do_close()
> > > >      vsock_stream_has_data()
> > > >        return vsk->transport->stream_has_data(vsk);    // null-ptr-deref
> > > >
> > > > ```
> > > > (Yes, This is quite a crazy scenario, but it can actually be induced)
> > > >
> > > > Since sock->state is set to SS_UNCONNECTED during the first connect()[1],
> > > > it can pass the sock->state check[2] in vsock_listen() and set
> > > > sk->sk_state to TCP_LISTEN[3].
> > > > If this happens, the check in the patch with
> > > > `sk->sk_state != TCP_LISTEN` will pass[4], and a null-ptr-deref can
> > > > still occur.)
> > > >
> > > > More specifically, because the sk_state has changed to TCP_LISTEN,
> > > > virtio_transport_recv_disconnecting() will not be called by the
> > > > loopback worker. However, a null-ptr-deref may occur in
> > > > virtio_transport_close_timeout(), which is scheduled by
> > > > virtio_transport_close() called in the flow of the second connect()[5].
> > > > (The patch no longer cancels the virtio_transport_close_timeout() worker)
> > > >
> > > > And even if the `sk->sk_state != TCP_LISTEN` check is removed from the
> > > > patch, it seems that a null-ptr-deref will still occur due to
> > > > virtio_transport_close_timeout().
> > > > It might be necessary to add worker cancellation at the
> > > > appropriate location.
> > > 
> > > Thanks for the analysis!
> > > 
> > > Do you have time to cook a proper patch to cover this scenario?
> > > Or we should mix this fix together with your patch (return 0 in
> > > vsock_stream_has_data()) while we investigate a better handling?
> > 
> > For now, it seems better to merge them together.
> 
> Okay, since both you and Michael agree on that, I'll include your changes in
> this series, but adding a warning message, since it should not happen.
> 
> Is that fine with you?

Yes, I agree.

> 
> > 
> > It seems that covering this scenario will require more analysis and
> > testing.
> 
> Yeah, scheduling a task during the release is tricky, especially when we are
> changing the transport, so I think we should handle that better.
> 
> One idea that I have it to cancel delayed works in
> virtio_transport_destruct(), I'll test it a bit and add a patch for that in
> the next version of this series.

OK. once the patch is submitted, I will review it.

> 
> We also need to reset SOCK_DONE after changing the transports.
> 
> Thanks,
> Stefano
> 
