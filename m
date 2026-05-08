Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946393CFF4A
	for <virtualization@lists.linux.dev>; Fri,  8 May 2026 10:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778236402; cv=none; b=n5oMLcKrWT5v+H6d6gGvlvNxBQsq0dKOnYjpc4bLOqK4BvkFpYg+aumgQob9TtCDQ5YF2/bUGJq+uEkvmv5UUeTVViddKWkRBcmA5mYCN1nb/zit/1qQcsy3AE2u5OMj3Y/3/VddEqo9/8f5ucd5gDLRlZmYOt4Y7oCfjthv5Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778236402; c=relaxed/simple;
	bh=qol90EnXXDrSrjd/vykAjPr3QHnGmGUfUyYQ32R9u4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LcGGUjiCOaC37anBfyvq7rpx/fuufXX4U1Y4HwgX/QG1r6TZoPPpA8Thh48JkXSkduMoWT/84co2fOxsoLP9nvaYyfO8Mi7nkiu+A/T2XU8K4pC0yDVj02JD+ORKTh85ggve3t3LubDmLiplqOBWHHzd/Tekb6WXKqZS2GKcOg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RrXJBym0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RrXJBym0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778236399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ju82bmy4dZEitjOvynFPa4kwr04F31Fyfwzj/fLoDtk=;
	b=RrXJBym0ZPT4XzfAYV1QAPQnT3MYo+yQgchYvEBQ5L2Ko/Diazp0Lm+XhChW/lyAnRRVYn
	B2vyPRIEFwYIyrCeUJINrCcqU8x1JfwJgKu0Ir1LT6Dl10lHIOp5i3hXDSR6M/SWRDtiac
	e7zc4s/YbEpp34TEfrQX1qBwynk5iT4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-GVq3EkCcN1yhSbfa4La8RA-1; Fri, 08 May 2026 06:33:18 -0400
X-MC-Unique: GVq3EkCcN1yhSbfa4La8RA-1
X-Mimecast-MFC-AGG-ID: GVq3EkCcN1yhSbfa4La8RA_1778236397
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-44d83e45febso2270477f8f.0
        for <virtualization@lists.linux.dev>; Fri, 08 May 2026 03:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778236397; x=1778841197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ju82bmy4dZEitjOvynFPa4kwr04F31Fyfwzj/fLoDtk=;
        b=O+lmm/IfqIAdjWo9F0aQbjmbPdmVZYTgsMqeEuQMiBj6u3k9bYZhpYBioS9UCchfEP
         npV9/22JoR9/BSHVKzSbrNu+TCiYDa2K44cP6J9dqTmKQdTw8pmAhf9arvyA5+asO01h
         cFulm0nqlupHU+P08BW9+WKgEoYpdnlPiKOUvHzXQP26fWZsxGPQWVVlrDgZq4wUDJqM
         5n+WCG2Hk2nz72J3/fiLUzPOVHexrAeuBFMwepBZmC97i0pkQFLiBELow4D0LJBI41BY
         KfXH6J1VluNeH4xwFNGM2HdJUW6iKjoeoh9lpQLXS+pK+sHI481aog0b8qGzqVJ/rVvw
         YxFA==
X-Forwarded-Encrypted: i=1; AFNElJ9gXLtZjkccxqoI6dnZy23GPpWDB3QFTILd1KSs1tZMqPD5mTjRKw4Xkd4Nw/5dJkqO9KskzdTPdO4Iq1sz/w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyaX3G6KcyugneTxaIF+FdwzAvf6E3IKSL4XolXJ5duJf3kN0Qn
	q9kLdLPWdlQL68GiWkHvnwyDgwydYJT3YNGlv5EnbNT8RWtWxcaMDuoUcFFxs1xBOqv14ScDFic
	NW9oDAd+XPF8pMiw1g09sQVFVE9Eo9kGyrIIlboXTYNqU06rTuvETum+fLtq9nmCcDl5z
X-Gm-Gg: AeBDievQy5gja8nAMS/O0hZjNLgtG4WGgSOlPgvIMDZCMxrgj/GbnmD1YP78moPHphl
	mdCiK6h7cCRM+fREqPnPzcz2chfULjHuuvCfCq3aLDtoyx06vXSCnRMVrFMNKQ4BW7/CaF9SHLz
	KOkZKTMV8EtAfJsvKBh0XbIJR3w1eFRRZmd+JmDVPhZj1Z4eAfvoC50IfO77NezdHEX95+tp971
	vf6hvAyYZRDjK2jWbL/xLWFb5Jf7rRT1vgscGDbDCLKjG5+16qa2PIqM4A/vWtTKC/Im8f1+5su
	4XdM8hbslrl6BINJRs7CphhQypk96Z5GAyzO3LMJQdYIjEC4V/65jf21Ndy3D+HAavQRW+Rw+Yj
	/1QPRuKhzesudiZ1PF7i1X0VwCnIfaMixvbGxX4eD3Es+rhsUIQU=
X-Received: by 2002:a05:600c:15cc:b0:48e:635a:18c3 with SMTP id 5b1f17b1804b1-48e635a19afmr34049065e9.4.1778236397189;
        Fri, 08 May 2026 03:33:17 -0700 (PDT)
X-Received: by 2002:a05:600c:15cc:b0:48e:635a:18c3 with SMTP id 5b1f17b1804b1-48e635a19afmr34048745e9.4.1778236396605;
        Fri, 08 May 2026 03:33:16 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e68ed0f7csm28272525e9.1.2026.05.08.03.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 03:33:16 -0700 (PDT)
Date: Fri, 8 May 2026 06:33:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtualization@lists.linux.dev,
	"David S. Miller" <davem@davemloft.net>,
	Jason Wang <jasowang@redhat.com>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead accounting to
 preserve full buf_alloc
Message-ID: <20260508063104-mutt-send-email-mst@kernel.org>
References: <20260508092330.69690-1-sgarzare@redhat.com>
 <20260508055125-mutt-send-email-mst@kernel.org>
 <af2y2Fyp7H-om-ur@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <af2y2Fyp7H-om-ur@sgarzare-redhat>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KM9ryEo-ZU2MDHoWof2pIcQM9HIQ-N8mcFKuQGUA-nk_1778236397
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 08, 2026 at 12:01:50PM +0200, Stefano Garzarella wrote:
> On Fri, May 08, 2026 at 05:53:07AM -0400, Michael S. Tsirkin wrote:
> > On Fri, May 08, 2026 at 11:23:30AM +0200, Stefano Garzarella wrote:
> > > From: Stefano Garzarella <sgarzare@redhat.com>
> > > 
> > > After commit 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb
> > > queue"), virtio_transport_inc_rx_pkt() subtracts per-skb overhead from
> > > buf_alloc when checking whether a new packet fits. This reduces the
> > > effective receive buffer below what the user configured via
> > > SO_VM_SOCKETS_BUFFER_SIZE, causing legitimate data packets to be
> > > silently dropped and applications that rely on the full buffer size
> > > to deadlock.
> > > 
> > > Also, the reduced space is not communicated to the remote peer, so
> > > its credit calculation accounts more credit than the receiver will
> > > actually accept, causing data loss (there is no retransmission).
> > > 
> > > This also causes failures in tools/testing/vsock/vsock_test.c.
> > > Test 18 sometimes fails, while test 22 always fails in this way:
> > >     18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch
> > > 
> > >     22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
> > >     Resource temporarily unavailable
> > > 
> > > Fix this by introducing virtio_transport_rx_buf_size() to calculate the
> > > size of the RX buffer based on the overhead. Using it in the acceptance
> > > check, the advertised buf_alloc, and the credit update decision.
> > > Use buf_alloc * 2 as total budget (payload + overhead), similar to how
> > > SO_RCVBUF is doubled to reserve space for sk_buff metadata.
> > > The function returns buf_alloc as long as overhead fits within the
> > > reservation, then gradually reduces toward 0 as overhead exceeds
> > > buf_alloc (e.g. under small-packet flooding), informing the peer to
> > > slow down.
> > > 
> > > Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > 
> > 
> > unfortunately, this is a bit of a spec violation and there is no guarantee
> > it helps.
> 
> Loosing data like we are doing in 059b7dbd20a6 is even worse IMHO.
> 
> > 
> > a spec violation because the spec says:
> > Only payload bytes are counted and header bytes are not
> > included
> > 
> > and the implication is that a side can not reduce its own buf_alloc.
> > 
> > no guarantee because the other side is not required to process your
> > packets, so it might not see your buf alloc reduction.
> > 
> > as designed in the current spec, you can only increase your buf alloc,
> > not decrease it.
> 
> We never enforced this, currently an user can reduce it by
> SO_VM_SOCKETS_BUFFER_SIZE and we haven't blocked it since virtio-vsock was
> introduced, should we update the spec?


it's not that we need to enforce it, it's that all synchronization
assumes this. as in, anyone can use an old copy until they run out
of credits.


> > 
> > what can be done:
> > - more efficient storage for small packets (poc i posted)
> > - reduce buf alloc ahead of the time
> 
> That's basically what I'm doing here: I'm using twice the size of
> `buf_alloc` (just like `SO_RCVBUF` does for other socket types) and telling
> the other peer just `buf_alloc`.
> 
> But then, somehow, we have to let the other person know that we're running
> out of space. With this patch that only happens when the other peer isn't
> behaving properly, sending so many small packets that the overhead exceeds
> `buf_alloc`.
> 
> Stefano

what is "not proper" here, it is up to the application what to send.


> > 
> > > ---
> > >  net/vmw_vsock/virtio_transport_common.c | 31 +++++++++++++++++++++----
> > >  1 file changed, 27 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > > index 9b8014516f4f..94a4beb8fd61 100644
> > > --- a/net/vmw_vsock/virtio_transport_common.c
> > > +++ b/net/vmw_vsock/virtio_transport_common.c
> > > @@ -444,12 +444,32 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> > >  	return ret;
> > >  }
> > > 
> > > +/* vvs->rx_lock held by the caller */
> > > +static u32 virtio_transport_rx_buf_size(struct virtio_vsock_sock *vvs)
> > > +{
> > > +	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
> > > +	/* Use buf_alloc * 2 as total budget (payload + overhead), similar to
> > > +	 * how SO_RCVBUF is doubled to reserve space for sk_buff metadata.
> > > +	 */
> > > +	u64 total_budget = (u64)vvs->buf_alloc * 2;
> > > +
> > > +	/* Overhead within buf_alloc: full buf_alloc available for payload */
> > > +	if (skb_overhead < vvs->buf_alloc)
> > > +		return vvs->buf_alloc;
> > > +
> > > +	/* Overhead exceeded buf_alloc: gradually reduce to bound skb queue */
> > > +	if (skb_overhead < total_budget)
> > > +		return total_budget - skb_overhead;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> > >  					u32 len)
> > >  {
> > > -	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
> > > +	u32 rx_buf_size = virtio_transport_rx_buf_size(vvs);
> > > 
> > > -	if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
> > > +	if (!rx_buf_size || vvs->buf_used + len > rx_buf_size)
> > >  		return false;
> > > 
> > >  	vvs->rx_bytes += len;
> > > @@ -472,7 +492,7 @@ void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *
> > >  	spin_lock_bh(&vvs->rx_lock);
> > >  	vvs->last_fwd_cnt = vvs->fwd_cnt;
> > >  	hdr->fwd_cnt = cpu_to_le32(vvs->fwd_cnt);
> > > -	hdr->buf_alloc = cpu_to_le32(vvs->buf_alloc);
> > > +	hdr->buf_alloc = cpu_to_le32(virtio_transport_rx_buf_size(vvs));
> > >  	spin_unlock_bh(&vvs->rx_lock);
> > >  }
> > >  EXPORT_SYMBOL_GPL(virtio_transport_inc_tx_pkt);
> > > @@ -594,6 +614,7 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> > >  	bool low_rx_bytes;
> > >  	int err = -EFAULT;
> > >  	size_t total = 0;
> > > +	u32 rx_buf_size;
> > >  	u32 free_space;
> > > 
> > >  	spin_lock_bh(&vvs->rx_lock);
> > > @@ -639,7 +660,9 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> > >  	}
> > > 
> > >  	fwd_cnt_delta = vvs->fwd_cnt - vvs->last_fwd_cnt;
> > > -	free_space = vvs->buf_alloc - fwd_cnt_delta;
> > > +	rx_buf_size = virtio_transport_rx_buf_size(vvs);
> > > +	free_space = rx_buf_size > fwd_cnt_delta ?
> > > +		     rx_buf_size - fwd_cnt_delta : 0;
> > >  	low_rx_bytes = (vvs->rx_bytes <
> > >  			sock_rcvlowat(sk_vsock(vsk), 0, INT_MAX));
> > > 
> > > --
> > > 2.54.0
> > 

