Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4B02010FD
	for <virtualization@lists.linux.dev>; Thu,  9 Jan 2025 09:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736413591; cv=none; b=FReyXUCa/GetMTJrIPi5TlPmhfrC7H30wyC1EWhTpH8Kpjjztssa3hlEDrYKJ6mrB9Kg3yd8BH8PcUrWDQlpfgC5UwuK7DZuMPvTgo+Yt1sWBZgs66ePDJVndJflesgrpORCXK3T4+Uct2IFBv0HmiUhyHzWbUwId0y+LwOgKXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736413591; c=relaxed/simple;
	bh=/QGyM01prQzG0mTpP+PKjbu8zo0LVi9zV42sNzHhZxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nNMU3JAC68kl3oF/9X6Zqr5r4jk/pI82T19zj+7LNn0QzX45fPXgBhfDuQnqjRQkGvvIM2DWKL4aYBnTxD0uULy2k4WXDR32VyevI+4I3fQBlpV8sU/9qJxZ9osRYk5E5AQ0K1BC6rK29NGEMEzx+xwTwR9RhJFi9dtREnexOHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HXGPjGcz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HXGPjGcz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736413588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fq/6xWdewBnkqjsFyBmYvqMniHrBBGp8CbrRgVyKKlI=;
	b=HXGPjGczKkwmLP2qTBiNf0wj6UrxoVAejKotf+h4/V7D4h3nf/p39jHshCuaRNB/3y+B8W
	UZA0PDunNtcW6W9B+i3VnFwUaxPhpTdXkNd3WAcftkVrFZ201Yq4XGIf7oy3zytSbVdZfH
	w8+8DPErQk9rrX1LcvDhm+GLam7EQcc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-0nZ3IJC9NuWYl3AK_M1yGQ-1; Thu, 09 Jan 2025 04:06:27 -0500
X-MC-Unique: 0nZ3IJC9NuWYl3AK_M1yGQ-1
X-Mimecast-MFC-AGG-ID: 0nZ3IJC9NuWYl3AK_M1yGQ
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5d3eea3b9aaso470033a12.1
        for <virtualization@lists.linux.dev>; Thu, 09 Jan 2025 01:06:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736413586; x=1737018386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fq/6xWdewBnkqjsFyBmYvqMniHrBBGp8CbrRgVyKKlI=;
        b=rJV+rIyAPXpW8sA83V+Mqmnake42uZjAJ9RLzWZX2eNLjHzCaJISbquMVkjhtJ8Bhy
         mKs+3BWX45OEMFxvEACzbNPKMCN+zazGdKOE4I679kL+gPZxvdRsjwCOcHiZx/iGI4Af
         qIW6aKrTHB/5zR/imEwbhEvto7REsYPvaztUFMEDhkPdeQqWs6srrZ1Swl4lUWz/i2E8
         yt00o57y0cMoACXfGfWszdXFod2Q8zYMNm2rwHfVDNsAICC2VBgrntjc73gLujUiFMvD
         5hbdfxyynrjHY0cQSUsX9Fd0Fms7wKQM77EWRE8UFMPY29rSHYdUa7qMehEL4cYf3evW
         GRsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVouyiQCTuox7Y35mfg1E1L75SXCVh92M+Hp3pP0e2REY3W77cKWsx8SXLL6j2JI+oQ4WszBm5/UTH4X+1UmQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZN5BTWJL3OChfZCAjcuHztDIX3W9+YHlVy4VokNQtlVbgCuR4
	VAIFFj2La7tgA18KYdhHw6ncjwwyfLSctHfG3f1xkoi4Pcpeinikx6xkJH248YrkltXq4lbxwn6
	5Fept0wtd+2Z2JqRKFyhau4nHCTMrS3sGwiKypxM3UqJlN+G2tGMOclcHNycIpmkb
X-Gm-Gg: ASbGnct5MmT/E0ZN5pNAB7k5CviLdv473XquVwdNSEeVnqat9MZ1VIQFkcr/tbUlLWT
	n8gGcp7zkJ7RYmH+ALbNQt2X1KWIyo8jINklByQh3jdNCHD/947JN3STvVxsVFpb8F71DXd1rff
	Hf9YI5C8andIluR+LeRbrEjsls+IVgg8qip8tqNqP11bkH46Vh5HKx1QNAWH+SIi1d0sRpl87EM
	cSM8ds3Kypb4srOW6b2iVVlzv7XR3OC87E3oBiU8iFG1VyqHNY=
X-Received: by 2002:a05:6402:530f:b0:5d1:2377:5af3 with SMTP id 4fb4d7f45d1cf-5d972e00027mr12379758a12.5.1736413585680;
        Thu, 09 Jan 2025 01:06:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMeDUq48ZiEO5NB+/CECsRZI/hOj1DbWFgJdIBm69MXifXS36ORET2SuFFSlHmTy+PIRAewQ==
X-Received: by 2002:a05:6402:530f:b0:5d1:2377:5af3 with SMTP id 4fb4d7f45d1cf-5d972e00027mr12379693a12.5.1736413585228;
        Thu, 09 Jan 2025 01:06:25 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:d62d:93ef:d7e2:e7da:ed72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c9562ea8sm49942566b.93.2025.01.09.01.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 01:06:24 -0800 (PST)
Date: Thu, 9 Jan 2025 04:06:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Hyunwoo Kim <v4bel@theori.io>, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
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
	Jakub Kicinski <kuba@kernel.org>, Michal Luczaj <mhal@rbox.co>,
	kvm@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net 1/2] vsock/virtio: discard packets if the transport
 changes
Message-ID: <20250109040604-mutt-send-email-mst@kernel.org>
References: <20250108180617.154053-1-sgarzare@redhat.com>
 <20250108180617.154053-2-sgarzare@redhat.com>
 <Z37Sh+utS+iV3+eb@v4bel-B760M-AORUS-ELITE-AX>
 <77plpkw3mp4r3ue4ubmh4yhqfo777koiu65dqfqfxmjgc5uq57@aifi6mhtgtuj>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <77plpkw3mp4r3ue4ubmh4yhqfo777koiu65dqfqfxmjgc5uq57@aifi6mhtgtuj>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: chm_8I7-qFwb5JOeoUXX9kE99AASZIMOkSQ5liFkUZE_1736413586
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 09, 2025 at 10:01:31AM +0100, Stefano Garzarella wrote:
> On Wed, Jan 08, 2025 at 02:31:19PM -0500, Hyunwoo Kim wrote:
> > On Wed, Jan 08, 2025 at 07:06:16PM +0100, Stefano Garzarella wrote:
> > > If the socket has been de-assigned or assigned to another transport,
> > > we must discard any packets received because they are not expected
> > > and would cause issues when we access vsk->transport.
> > > 
> > > A possible scenario is described by Hyunwoo Kim in the attached link,
> > > where after a first connect() interrupted by a signal, and a second
> > > connect() failed, we can find `vsk->transport` at NULL, leading to a
> > > NULL pointer dereference.
> > > 
> > > Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
> > > Reported-by: Hyunwoo Kim <v4bel@theori.io>
> > > Reported-by: Wongi Lee <qwerty@theori.io>
> > > Closes: https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > ---
> > >  net/vmw_vsock/virtio_transport_common.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > > index 9acc13ab3f82..51a494b69be8 100644
> > > --- a/net/vmw_vsock/virtio_transport_common.c
> > > +++ b/net/vmw_vsock/virtio_transport_common.c
> > > @@ -1628,8 +1628,11 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> > > 
> > >  	lock_sock(sk);
> > > 
> > > -	/* Check if sk has been closed before lock_sock */
> > > -	if (sock_flag(sk, SOCK_DONE)) {
> > > +	/* Check if sk has been closed or assigned to another transport before
> > > +	 * lock_sock (note: listener sockets are not assigned to any transport)
> > > +	 */
> > > +	if (sock_flag(sk, SOCK_DONE) ||
> > > +	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
> > 
> > If a race scenario with vsock_listen() is added to the existing
> > race scenario, the patch can be bypassed.
> > 
> > In addition to the existing scenario:
> > ```
> >                     cpu0                                                      cpu1
> > 
> >                                                               socket(A)
> > 
> >                                                               bind(A, {cid: VMADDR_CID_LOCAL, port: 1024})
> >                                                                 vsock_bind()
> > 
> >                                                               listen(A)
> >                                                                 vsock_listen()
> >  socket(B)
> > 
> >  connect(B, {cid: VMADDR_CID_LOCAL, port: 1024})
> >    vsock_connect()
> >      lock_sock(sk);
> >      virtio_transport_connect()
> >        virtio_transport_connect()
> >          virtio_transport_send_pkt_info()
> >            vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_REQUEST)
> >              queue_work(vsock_loopback_work)
> >      sk->sk_state = TCP_SYN_SENT;
> >      release_sock(sk);
> >                                                               vsock_loopback_work()
> >                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_REQUEST)
> >                                                                   sk = vsock_find_bound_socket(&dst);
> >                                                                   virtio_transport_recv_listen(sk, skb)
> >                                                                     child = vsock_create_connected(sk);
> >                                                                     vsock_assign_transport()
> >                                                                       vvs = kzalloc(sizeof(*vvs), GFP_KERNEL);
> >                                                                     vsock_insert_connected(vchild);
> >                                                                       list_add(&vsk->connected_table, list);
> >                                                                     virtio_transport_send_response(vchild, skb);
> >                                                                       virtio_transport_send_pkt_info()
> >                                                                         vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_RESPONSE)
> >                                                                           queue_work(vsock_loopback_work)
> > 
> >                                                               vsock_loopback_work()
> >                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_RESPONSE)
> >                                                                   sk = vsock_find_bound_socket(&dst);
> >                                                                   lock_sock(sk);
> >                                                                   case TCP_SYN_SENT:
> >                                                                   virtio_transport_recv_connecting()
> >                                                                     sk->sk_state = TCP_ESTABLISHED;
> >                                                                   release_sock(sk);
> > 
> >                                                               kill(connect(B));
> >      lock_sock(sk);
> >      if (signal_pending(current)) {
> >      sk->sk_state = sk->sk_state == TCP_ESTABLISHED ? TCP_CLOSING : TCP_CLOSE;
> >      sock->state = SS_UNCONNECTED;    // [1]
> >      release_sock(sk);
> > 
> >  connect(B, {cid: VMADDR_CID_HYPERVISOR, port: 1024})
> >    vsock_connect(B)
> >      lock_sock(sk);
> >      vsock_assign_transport()
> >        virtio_transport_release()
> >          virtio_transport_close()
> >            if (!(sk->sk_state == TCP_ESTABLISHED || sk->sk_state == TCP_CLOSING))
> >            virtio_transport_shutdown()
> >              virtio_transport_send_pkt_info()
> >                vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_SHUTDOWN)
> >                  queue_work(vsock_loopback_work)
> >            schedule_delayed_work(&vsk->close_work, VSOCK_CLOSE_TIMEOUT);	// [5]
> >        vsock_deassign_transport()
> >          vsk->transport = NULL;
> >        return -ESOCKTNOSUPPORT;
> >      release_sock(sk);
> >                                                               vsock_loopback_work()
> >                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_SHUTDOWN)
> >                                                                   virtio_transport_recv_connected()
> >                                                                     virtio_transport_reset()
> >                                                                       virtio_transport_send_pkt_info()
> >                                                                         vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_RST)
> >                                                                           queue_work(vsock_loopback_work)
> >  listen(B)
> >    vsock_listen()
> >      if (sock->state != SS_UNCONNECTED)    // [2]
> >      sk->sk_state = TCP_LISTEN;    // [3]
> > 
> >                                                               vsock_loopback_work()
> >                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_RST)
> > 								   if ((sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {    // [4]
> > 								   ...
> > 							
> >  virtio_transport_close_timeout()
> >    virtio_transport_do_close()
> >      vsock_stream_has_data()
> >        return vsk->transport->stream_has_data(vsk);    // null-ptr-deref
> > 
> > ```
> > (Yes, This is quite a crazy scenario, but it can actually be induced)
> > 
> > Since sock->state is set to SS_UNCONNECTED during the first connect()[1],
> > it can pass the sock->state check[2] in vsock_listen() and set
> > sk->sk_state to TCP_LISTEN[3].
> > If this happens, the check in the patch with
> > `sk->sk_state != TCP_LISTEN` will pass[4], and a null-ptr-deref can
> > still occur.)
> > 
> > More specifically, because the sk_state has changed to TCP_LISTEN,
> > virtio_transport_recv_disconnecting() will not be called by the
> > loopback worker. However, a null-ptr-deref may occur in
> > virtio_transport_close_timeout(), which is scheduled by
> > virtio_transport_close() called in the flow of the second connect()[5].
> > (The patch no longer cancels the virtio_transport_close_timeout() worker)
> > 
> > And even if the `sk->sk_state != TCP_LISTEN` check is removed from the
> > patch, it seems that a null-ptr-deref will still occur due to
> > virtio_transport_close_timeout().
> > It might be necessary to add worker cancellation at the
> > appropriate location.
> 
> Thanks for the analysis!
> 
> Do you have time to cook a proper patch to cover this scenario?
> Or we should mix this fix together with your patch (return 0 in
> vsock_stream_has_data()) while we investigate a better handling?
> 
> Thanks,
> Stefano

better combine them imho. 

