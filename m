Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C2E3FF8B7
	for <virtualization@lists.linux.dev>; Thu, 14 May 2026 15:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778771793; cv=none; b=hXspvzVEaYZILlSXdMndnnm2KmbECbqbWAUWAee4UbWTPkh6f8knfX9NZosNvJPg1sGWOt/vTJEmXxPFduQCSXP51q2Dq4e62HAksEOTYC12Hxf/GygcHVwsu25QnFYzJf1QGdhl5w26Q0rcHhY7KOgvAey6RJrq8xnu6Hya4Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778771793; c=relaxed/simple;
	bh=q7uNPrD0eUP4HNkAIIdlYAOXifDzpyw/ZOQANdgddGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gRaP4NdYmvmd90xV4xS/1CZicp0cXagQCwQw6cXdm05ooUk5Djqs47DoSB0KjKydO5cmwDAUjGsmgU8yap8UZ3eucKUawNcBig66NTrGLqn/2F1A2tl/xEtdi4oJoLrcFnHHx8/9kK28hVU0MZzOpWF8eIaL7ChEdazIeUxmXbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GAVRkAaS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GAVRkAaS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778771790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s6SqjJFaYe/G8HVu0q1mvVzTnaE1hb029hYuoyhIe+M=;
	b=GAVRkAaShD1YrlSwka6pg5vvD0Rl9ve68a1ulF/VEsCHsSbAbC8xC85u2MvaQzQHaEgGxo
	tpDAGFqv95otJcIU06UOSKS85SmOZ+j2i0BFcD0zwua4B4d9mCvsNVtELtD8Pf7gMz+/Ma
	WOjqqYGUER4gU6/qjpNfC0Sm3oq9BGM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-DBJMIO92P9q0JWLko8h4Fw-1; Thu, 14 May 2026 11:16:29 -0400
X-MC-Unique: DBJMIO92P9q0JWLko8h4Fw-1
X-Mimecast-MFC-AGG-ID: DBJMIO92P9q0JWLko8h4Fw_1778771788
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48d1b294dfeso70628905e9.0
        for <virtualization@lists.linux.dev>; Thu, 14 May 2026 08:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778771788; x=1779376588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6SqjJFaYe/G8HVu0q1mvVzTnaE1hb029hYuoyhIe+M=;
        b=AhG24P2pCxpRE/fUaULYtuyU/VDA1CnQKIR/TfkBj2FoVc8Qh9e6+uevlhJzIuxBzW
         mfn5P5sn02bIzpdp6lye4663o5CGjbkOxQtiBhY2AA4WOqjkZ/tukS9Firkw+xvEbXXC
         Hr3M303Ax4CiwlIozRJNXRZGQONZpHD4GqN9ITrKuQasX2mN314aE0a7MHPubvuqA/48
         /4qZEfYnoX16K3Z6SvddAKyNQ2tE6KzQK54eR/QfB6whhHUcoKro7Ua12Icj6wmPgpJY
         JCHTl8R2f47XmGrl2xBt8OlQV4MRqyFp1x9liF9rQIscgYk1Y+UzmlmBGje+zXjdQA3z
         tanw==
X-Forwarded-Encrypted: i=1; AFNElJ/e84BzPxFSCxQvgVrjpsuyPrbTWMZOU9yw8YTb+l7oAt/b0jOJi8vAo4LN1W02OsvdUJiTMj9xFRsFp/3O8Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4ZxTjs4AESkORjHwBtqQApWbMSXhyHP6Ghkirz8DHn1PaX0I/
	/ef8lfRZsC7NbYvaefWQBgz9EcT1Z2p63Fyh3ULgdBkxj8aVJd5mQTgIFVw95idTSvQVlwTEe0v
	tnMDpV9DnXMz/UOcn3C8lNiGyAszNRFWF9cA76IyRvhiaWKJIU2M4/18jocpJdgdtJ2BS
X-Gm-Gg: Acq92OFZHWK5fN6vfnX7Vy1d5FZA6o/2f0mgwqFAhtCfKr290nfXYL/EXT/yMlKaMib
	ktJx3NLvTgKKjaNugp25AWAMeTZB4EaflGF7IL/T5n0VAqslQrXeKAMnPSYpNrr/xqSL1I1Oj3c
	EvVYGZXBOs6uRvIxtqEENR3Cuya5OK32nxksRQhAU/rgTSj0n0TX9GkDuga0as7RCSRjbmwjpxc
	ppng+asXABXW0Dci75IJGCRsh60M5eeRTXuL2ABZYtGlrc4lSlVAUIh/ClkXe0ZzDzc6F5thJZ9
	tWQsTiDqxqJszHGqDOmhDF/9szKobWiU7y6CL/qtx83H9lFXBIX67OmR+3a4ziFAyCEFuHWBFD3
	itaAkXbhVcZ7Yy0tqGZsl7u4OfEb0njmmTuJtj6i2
X-Received: by 2002:a05:600c:4fc9:b0:489:1c1f:35f1 with SMTP id 5b1f17b1804b1-48fc9a030eemr107778285e9.4.1778771787728;
        Thu, 14 May 2026 08:16:27 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc9:b0:489:1c1f:35f1 with SMTP id 5b1f17b1804b1-48fc9a030eemr107777655e9.4.1778771787145;
        Thu, 14 May 2026 08:16:27 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e767d0bsm6761145f8f.3.2026.05.14.08.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 08:16:26 -0700 (PDT)
Date: Thu, 14 May 2026 11:16:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtualization@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net v3 1/2] vsock/virtio: reset connection on receiving
 queue overflow
Message-ID: <20260514111513-mutt-send-email-mst@kernel.org>
References: <20260513105417.56761-1-sgarzare@redhat.com>
 <20260513105417.56761-2-sgarzare@redhat.com>
 <agXh36gUe1K6__Bk@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <agXh36gUe1K6__Bk@sgarzare-redhat>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vl_xKOaAGx5uplYjVvQwM_Ul1Ydg3gi6vymPK7tfF0w_1778771788
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 14, 2026 at 04:57:16PM +0200, Stefano Garzarella wrote:
> On Wed, May 13, 2026 at 12:54:16PM +0200, Stefano Garzarella wrote:
> > From: Stefano Garzarella <sgarzare@redhat.com>
> > 
> > When there is no more space to queue an incoming packet, the packet is
> > silently dropped. This causes data loss without any notification to
> > either peer, since there is no retransmission.
> > 
> > Under normal circumstances, this should never happen. However, it could
> > happen if the other peer doesn't respect the credit, or if the skb
> > overhead, which we recently began to take into account with commit
> > 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue"),
> > is too high.
> > 
> > Fix this by resetting the connection and setting the local socket error
> > to ENOBUFS when virtio_transport_recv_enqueue() can no longer queue a
> > packet, so both peers are explicitly notified of the failure rather than
> > silently losing data.
> > 
> > Fixes: ae6fcfbf5f03 ("vsock/virtio: discard packets if credit is not respected")
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> > net/vmw_vsock/virtio_transport_common.c | 19 ++++++++++++++-----
> > 1 file changed, 14 insertions(+), 5 deletions(-)
> > 
> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > index 989cc252d3d3..4a4ac69d1ad1 100644
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
> > @@ -1350,7 +1350,7 @@ virtio_transport_recv_connecting(struct sock *sk,
> > 	return err;
> > }
> > 
> > -static void
> > +static bool
> > virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> > 			      struct sk_buff *skb)
> > {
> > @@ -1365,10 +1365,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> > 	spin_lock_bh(&vvs->rx_lock);
> > 
> > 	can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
> > -	if (!can_enqueue) {
> > -		free_pkt = true;
> > +	if (!can_enqueue)
> > 		goto out;
> > -	}
> > 
> > 	if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
> > 		vvs->msg_count++;
> > @@ -1408,6 +1406,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> > 	spin_unlock_bh(&vvs->rx_lock);
> > 	if (free_pkt)
> > 		kfree_skb(skb);
> > +
> > +	return can_enqueue;
> > }
> > 
> > static int
> > @@ -1420,7 +1420,16 @@ virtio_transport_recv_connected(struct sock *sk,
> > 
> > 	switch (le16_to_cpu(hdr->op)) {
> > 	case VIRTIO_VSOCK_OP_RW:
> > -		virtio_transport_recv_enqueue(vsk, skb);
> > +		if (!virtio_transport_recv_enqueue(vsk, skb)) {
> > +			/* There is no more space to queue the packet, so let's
> > +			 * close the connection; otherwise, we'll lose data.
> > +			 */
> > +			(void)virtio_transport_reset(vsk, skb);
> > +			sk->sk_state = TCP_CLOSE;
> > +			sk->sk_err = ENOBUFS;
> > +			sk_error_report(sk);
> 
> sashiko reported some issues related to setting TCP_CLOSE state and not
> removing the socket from the connect table:
> https://sashiko.dev/#/patchset/20260513105417.56761-1-sgarzare%40redhat.com
> 
> I'll change this by calling virtio_transport_do_close() and
> vsock_remove_sock() in the next version.
> 
> Stefano
> 
> > +			break;
> > +		}
> > 		vsock_data_ready(sk);
> > 		return err;
> > 	case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
> > -- 
> > 2.54.0
> > 


And so the bag of hacks grows. I feel this is energy not well spent.
Please, let us fix this properly *first*. And then worry about how to
backport.  Maybe it will not be so terrible to backport after all.

