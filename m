Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983614266B0
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 08:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835472; cv=none; b=lR2YJ540AVQ9y+um+jZinX7BwPh/GmYFseEt9uv8oZUxyM3Vimm2pG+iyCbSHrCXHBWqX2EYBJbgfUO+6lVNJ5RscO7qqGa0kGAruX7+nYNv8n0C1tRf2hP+r4egKfs8j4VGPeSpQIr/YuN5BBV4AL34AcO0pV1XqsOgy7Dw51I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835472; c=relaxed/simple;
	bh=yiJc4Nt7lDDJQvZBzjmQQRrY7ovUUA6spxCpoO5M6TA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Fk9PET9T41IY744pabcvR/wQaHf/JUsgQqQYJDPjThAp9WaxgDeVWbiH35iaF1uLiiB8Efi9YlFbMnaqSwB1EI72P/YQDSkMnigdIMrNh9zlbjpumK/1zRkciHbUmZBXmZbKN7VQvgXc/f7c5uDxZ5ksJZhNKMIffGSvJSW6LSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PHicn5HD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PHicn5HD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778835468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=76MGKo7laS3q15QwVBANhPivXoLiqDoqFX8CsnX+SSM=;
	b=PHicn5HDA7k8ctrJsEuhXatYFXgMRd0TdEZTmTsztvPuIO9444FMZJOdgMYuCEKEuRH+kC
	uK6TuyUrSZ8mTE2Zc5/cyKsbzS208SY650Nrhb51DPKQIu10/HkmHsPFX8RYy8wv/VHh2S
	vio4a7SYyhSs8EZ/AbdGTIFeoOCUPio=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-ep59leUMNgi1erQ3H8GrJQ-1; Fri, 15 May 2026 04:57:47 -0400
X-MC-Unique: ep59leUMNgi1erQ3H8GrJQ-1
X-Mimecast-MFC-AGG-ID: ep59leUMNgi1erQ3H8GrJQ_1778835466
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44696b11265so9932243f8f.0
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 01:57:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778835466; x=1779440266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76MGKo7laS3q15QwVBANhPivXoLiqDoqFX8CsnX+SSM=;
        b=fz2p9noZAYScATVzque6sxujsiIsi+jVcclGqUnbngTJOj8JjKJYM1VZqjlV/TWIkx
         LA7aRcwMM7mE+i4mAuNX1Y84euILp0hSnW03B7uoGGc9A5pVZ/BbYfA+eUTMNwdrCcSC
         fNKY252dEExbtF4Z+vQcxH17DC9+LfMnEK12NhDXaHqCDC1OZBItiIiFynsJ5Ap2qhGW
         LBhkGtXDP9F1eeW/NRXM2PgRVtvphk74AnHjU1drEXrFYbr3X8HMVX1MnBjZVJ1yCniX
         PrBBvuUXOLRIbELt2UUxv3LqCBL4qTT++/C14y/Ik+fFj7RJEbE6IETefS7EZgphnWiq
         P9UA==
X-Forwarded-Encrypted: i=1; AFNElJ+yozF70MdCqIuKN19z8uucvmhXNGUCKg1o4BJS7Xc6aUyYdXYMOq1vhg0mhJqMJpIYwdfqacYIvAng41khgA==@lists.linux.dev
X-Gm-Message-State: AOJu0YybHlmrC1Y7APWjQnV3TM8QPgg+6ZI3uQViBULBVv+rGKlZjS+9
	NTKhuis5Axp9OmbHfF9hnOscHKG5QOFbIDChcTKoc/ZbHmHTNWSaul6YMRclCaYg7Qh+1IljYLB
	ob2YEG+FKYYelYZzpOhuOWbxbVY+2xvXmlAe3MaywBxBECO4DiXXUHEOkqw4tRFnjczG9
X-Gm-Gg: Acq92OEZOKb738i6/zPOPTKxArXJBGTeW9VHfwFeSWJ9c3FdTRJVfpoYIIPQLq2JGmf
	BVL5kXNooKjZ2HtJROGxW2U0gSNP74Eqrmu6CrlghbAfYYGhLigXjetXcFV17bowp7ky9He2ANV
	bnunsSAl41g4WA9HfES3i7xkOCv+HgKDbzM1oKaqEQbohnO77yqyBSvL1JY6m/Lfe138BAe9qnz
	j/S6SY2Yhx3a+LAeZd95OvU4B6II2BA6cbrNb54r3N8TcQhSIaRW+LJ+5BSAICk3ZI1ld4rem/Q
	4xe7ym335KZeGVA8uf9yevvV+lFLMUy1zcP7C93f5nGvW1Hyp7kqbigvhO/rQURjVm3E7HQ+irR
	a4L//GCPzzgPp
X-Received: by 2002:a05:6000:240b:b0:43c:f1a5:56f6 with SMTP id ffacd0b85a97d-45e5c5a8dc8mr4021853f8f.43.1778835465829;
        Fri, 15 May 2026 01:57:45 -0700 (PDT)
X-Received: by 2002:a05:6000:240b:b0:43c:f1a5:56f6 with SMTP id ffacd0b85a97d-45e5c5a8dc8mr4021803f8f.43.1778835465227;
        Fri, 15 May 2026 01:57:45 -0700 (PDT)
Received: from redhat.com ([31.187.78.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec3ac86sm13294048f8f.14.2026.05.15.01.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 01:57:44 -0700 (PDT)
Date: Fri, 15 May 2026 04:57:41 -0400
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
Message-ID: <20260515043940-mutt-send-email-mst@kernel.org>
References: <20260513105417.56761-1-sgarzare@redhat.com>
 <20260513105417.56761-2-sgarzare@redhat.com>
 <agXh36gUe1K6__Bk@sgarzare-redhat>
 <20260514111513-mutt-send-email-mst@kernel.org>
 <CAGxU2F4qWcQTmXnH74V8xZKADLiEMUmCc0+ktW5fZOXdTP4Bdw@mail.gmail.com>
 <20260514134347-mutt-send-email-mst@kernel.org>
 <agbWNqhzvEHVBvC2@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <agbWNqhzvEHVBvC2@sgarzare-redhat>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9NcZ56bqVyRJBu2C73YbWkKT5WgZ-nYQ-jQ_s3JjaJ4_1778835466
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 15, 2026 at 10:29:55AM +0200, Stefano Garzarella wrote:
> On Thu, May 14, 2026 at 01:44:53PM -0400, Michael S. Tsirkin wrote:
> > On Thu, May 14, 2026 at 06:45:00PM +0200, Stefano Garzarella wrote:
> > > On Thu, 14 May 2026 at 17:16, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Thu, May 14, 2026 at 04:57:16PM +0200, Stefano Garzarella wrote:
> > > > > On Wed, May 13, 2026 at 12:54:16PM +0200, Stefano Garzarella wrote:
> > > > > > From: Stefano Garzarella <sgarzare@redhat.com>
> > > > > >
> > > > > > When there is no more space to queue an incoming packet, the packet is
> > > > > > silently dropped. This causes data loss without any notification to
> > > > > > either peer, since there is no retransmission.
> > > > > >
> > > > > > Under normal circumstances, this should never happen. However, it could
> > > > > > happen if the other peer doesn't respect the credit, or if the skb
> > > > > > overhead, which we recently began to take into account with commit
> > > > > > 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue"),
> > > > > > is too high.
> > > > > >
> > > > > > Fix this by resetting the connection and setting the local socket error
> > > > > > to ENOBUFS when virtio_transport_recv_enqueue() can no longer queue a
> > > > > > packet, so both peers are explicitly notified of the failure rather than
> > > > > > silently losing data.
> > > > > >
> > > > > > Fixes: ae6fcfbf5f03 ("vsock/virtio: discard packets if credit is not respected")
> > > > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > > > > ---
> > > > > > net/vmw_vsock/virtio_transport_common.c | 19 ++++++++++++++-----
> > > > > > 1 file changed, 14 insertions(+), 5 deletions(-)
> > > > > >
> > > > > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > > > > > index 989cc252d3d3..4a4ac69d1ad1 100644
> > > > > > --- a/net/vmw_vsock/virtio_transport_common.c
> > > > > > +++ b/net/vmw_vsock/virtio_transport_common.c
> > > > > > @@ -1350,7 +1350,7 @@ virtio_transport_recv_connecting(struct sock *sk,
> > > > > >     return err;
> > > > > > }
> > > > > >
> > > > > > -static void
> > > > > > +static bool
> > > > > > virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> > > > > >                           struct sk_buff *skb)
> > > > > > {
> > > > > > @@ -1365,10 +1365,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> > > > > >     spin_lock_bh(&vvs->rx_lock);
> > > > > >
> > > > > >     can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
> > > > > > -   if (!can_enqueue) {
> > > > > > -           free_pkt = true;
> > > > > > +   if (!can_enqueue)
> > > > > >             goto out;
> > > > > > -   }
> > > > > >
> > > > > >     if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
> > > > > >             vvs->msg_count++;
> > > > > > @@ -1408,6 +1406,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> > > > > >     spin_unlock_bh(&vvs->rx_lock);
> > > > > >     if (free_pkt)
> > > > > >             kfree_skb(skb);
> > > > > > +
> > > > > > +   return can_enqueue;
> > > > > > }
> > > > > >
> > > > > > static int
> > > > > > @@ -1420,7 +1420,16 @@ virtio_transport_recv_connected(struct sock *sk,
> > > > > >
> > > > > >     switch (le16_to_cpu(hdr->op)) {
> > > > > >     case VIRTIO_VSOCK_OP_RW:
> > > > > > -           virtio_transport_recv_enqueue(vsk, skb);
> > > > > > +           if (!virtio_transport_recv_enqueue(vsk, skb)) {
> > > > > > +                   /* There is no more space to queue the packet, so let's
> > > > > > +                    * close the connection; otherwise, we'll lose data.
> > > > > > +                    */
> > > > > > +                   (void)virtio_transport_reset(vsk, skb);
> > > > > > +                   sk->sk_state = TCP_CLOSE;
> > > > > > +                   sk->sk_err = ENOBUFS;
> > > > > > +                   sk_error_report(sk);
> > > > >
> > > > > sashiko reported some issues related to setting TCP_CLOSE state and not
> > > > > removing the socket from the connect table:
> > > > > https://sashiko.dev/#/patchset/20260513105417.56761-1-sgarzare%40redhat.com
> > > > >
> > > > > I'll change this by calling virtio_transport_do_close() and
> > > > > vsock_remove_sock() in the next version.
> > > > >
> > > > > Stefano
> > > > >
> > > > > > +                   break;
> > > > > > +           }
> > > > > >             vsock_data_ready(sk);
> > > > > >             return err;
> > > > > >     case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
> > > > > > --
> > > > > > 2.54.0
> > > > > >
> > > >
> > > >
> > > > And so the bag of hacks grows. I feel this is energy not well spent.
> > > > Please, let us fix this properly *first*. And then worry about how to
> > > > backport.  Maybe it will not be so terrible to backport after all.
> > > >
> > > 
> > > TBH I don't think this is an hack, but an issue we should fix in any case.
> > > Regarding the second patch, I see your point, but it's a big change
> > > that worries me. I'd like some more time to fix it properly without
> > > rushing. Staying calm without realizing that userspace is broken like
> > > we are now without this series :-(
> > > 
> > > That said, evaluating further, I think we have a similar issue also
> > > with STREAM on the host side where the skb usually doesn't free space,
> > > so we need a merge strategy also there.
> > > 
> > > So, I'd like to have time to fix both definitely. If you have time and
> > > want to go ahead, please do.
> > > 
> > > Thanks,
> > > Stefano
> > 
> > Well my patch was a start, we just need a strategy how to avoid copying
> > everything, right?
> 
> Yep, and then there's the question of how to handle EOM without a payload,
> but I think that's a special case. In theory, we don't support sending it,
> but I'm not sure if POSIX allows it or not.

It seems to, but given we didn't allow it in the past, we probably
should not start now without a good solution.
Really we should add a feature bit for EOM to steal a byte from
buf_alloc. Or several bytes)

> That said, is it okay if I send a v4 of this series?
> 
> (I'm not sure if I'll be able to work on the merging next week)
> 
> Stefano


I do worry we are piling up hacks and we'll end up with races
for all our troubles. That said, up to you.

