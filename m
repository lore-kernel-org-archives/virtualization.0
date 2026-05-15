Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FA7401481
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 08:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833806; cv=none; b=q6GIqZS5+7JMqFdR+dvxRAoEj13bPwwBpp3mMTZxk7/7qclFZd+mtMo8enXePFeJ+w4wGCk5yVSIS735tS/5MmZVKNhCE18VGc7/F7iZkJovnJ7+wRCIuLnnvigir+7N5na77IpbylPyFPdMaacrVN/RfpM478GsUw4uzQ5+w1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833806; c=relaxed/simple;
	bh=EQ7IwlxGHE0J1foFsB+9uj3saln4eg27mwKY3T8VjcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gbVfJVP763LEWU/LJY5h9MEsRbdpzdg0YpztO4eYkuiQDON97+ocYzzUaKen/1uS6dXme9ulP7qLLcVuVJ8y1NJaVNmRzznx52NkoQaDCdTr/7XPx8EWtzJTCqPo0ejAmAxEeThhnYfhMk1id/jXVuCG9Kyc73mC8RKuKCDUS6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T1Z6FtJz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T1Z6FtJz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778833804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=muOsFm1ckUowqiVN5FPZIYRSKzSTI/TAawbrF7fG7TI=;
	b=T1Z6FtJzHblNELunaucrHq7N4H+6PsGFvBrKwYSz997ShFg4NcKQAyD7L6r35UYvGAwpcZ
	tl4zBk2He7aYCbwyhIVQiOrhZ0n1ywvbhBOL1B0x49xhaQBgbr/HuRv6f5VsGJao8nIzRa
	RhqYY7Jiam5Lb3YvJNTfy9wLoELa6U0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-cR4AQzeQNpuRf5kGSF29qA-1; Fri, 15 May 2026 04:30:02 -0400
X-MC-Unique: cR4AQzeQNpuRf5kGSF29qA-1
X-Mimecast-MFC-AGG-ID: cR4AQzeQNpuRf5kGSF29qA_1778833801
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48d127eb013so48365615e9.1
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 01:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778833801; x=1779438601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=muOsFm1ckUowqiVN5FPZIYRSKzSTI/TAawbrF7fG7TI=;
        b=h0ot0nLR2u84hPtUXnl0VNpphLJ5JSFK3tUAZKipitxcqo50HJNy8sQy5khSf1WCSF
         VBKR8txiUwBUUyMQCOltMnFX0BtSOxQw5lMC8q2sPq+YgNOwmI8fs+6Y8vvSC25JeqYA
         hxunUpcI5KLHejGRT0nKPbZuL7c+AiQXF4oqqS4chlxw/Wh7jzPF++oskFWp5sIV5yZO
         lW1dBmqt5/21llCfekphtpXlFStniNzUcbshX/97QyT4kAdB+3rW2OEqVafRzLGATXbK
         SVLoXrRYA/ucYdmnxCH5UFmlmVPmv8qn5dUf0dSOVAsQERVvsdLwqI2DjJ95RQMXxlCP
         g6PQ==
X-Forwarded-Encrypted: i=1; AFNElJ+yMh8E6RqAXdgM4EecEW9ozIkxTkHSnSyg8gmJ+OnYuhFBArdcoFbDJj2hktYlHG7vnSgPMRB9jaUBV6cZPw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxhwHmFhvudzwrOUtzDAVu19b2L9P80P/Av9G7a6BNBcXqKgrxV
	1WCNXLr/rQwhcn5ObUCWctLNHDz9TM3G2Vs1NhtovjQIE3Y6PgqO02RYPgmFzWCxg7BgHjrx1sj
	DiGXCZyetR18vJuBZWx7fkQEP1NjTGDfsAh+4Jgkx0x+tjSaZgVSgOnyTQxs5wD4bU6aT
X-Gm-Gg: Acq92OHt54VzFXFL59idbmDkePiexsQYcawgCEAPkuN2HUyKGCd5+dipjcHKeouSeM1
	xWyShPqCKAmvG2A8bOZ8Cu2qC4HkjnvDd2SS+EHv2s1yAtjPf14Njp2i1Al+SYCB/FP3TBj5yM2
	2nTcO5ItaNpTJk0Exz2apiD3jD6PgUv7XtG1m65O0uSWK/4VvYYVUQBFw9Sv31Qw4g9q5Ty1b6y
	44x68Ww8qqyLTvfB9ywypKYVQOytBnM+CSRUVk8ij1sHbiPEdzlKxO0mjcWRERuAHsZOjaN5wdc
	5gyPcjBmQO1tCUT/dxNpU4ZMQRbrGfCqgpvjdrntvtSUajthG+VjKT5EMc3DX/EV7mF6ex/rWtL
	qwzqquoTOhVkTvbkG+mOX22myQkhMmbQ3flRpicXtzmDrkpYmxi6ges4l/wfqlY9JH7v+RiJKfw
	==
X-Received: by 2002:a05:600c:a11c:b0:48a:5970:2003 with SMTP id 5b1f17b1804b1-48fe5fd483amr29432125e9.3.1778833800727;
        Fri, 15 May 2026 01:30:00 -0700 (PDT)
X-Received: by 2002:a05:600c:a11c:b0:48a:5970:2003 with SMTP id 5b1f17b1804b1-48fe5fd483amr29431715e9.3.1778833800267;
        Fri, 15 May 2026 01:30:00 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe2464sm13729817f8f.32.2026.05.15.01.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 01:29:59 -0700 (PDT)
Date: Fri, 15 May 2026 10:29:55 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, 
	virtualization@lists.linux.dev, Eric Dumazet <edumazet@google.com>, 
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net v3 1/2] vsock/virtio: reset connection on receiving
 queue overflow
Message-ID: <agbWNqhzvEHVBvC2@sgarzare-redhat>
References: <20260513105417.56761-1-sgarzare@redhat.com>
 <20260513105417.56761-2-sgarzare@redhat.com>
 <agXh36gUe1K6__Bk@sgarzare-redhat>
 <20260514111513-mutt-send-email-mst@kernel.org>
 <CAGxU2F4qWcQTmXnH74V8xZKADLiEMUmCc0+ktW5fZOXdTP4Bdw@mail.gmail.com>
 <20260514134347-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260514134347-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: augd_alEz9uiHKUO3jWRZ0UBjj2oWnValTzUaJQbyKY_1778833801
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, May 14, 2026 at 01:44:53PM -0400, Michael S. Tsirkin wrote:
>On Thu, May 14, 2026 at 06:45:00PM +0200, Stefano Garzarella wrote:
>> On Thu, 14 May 2026 at 17:16, Michael S. Tsirkin <mst@redhat.com> wrote:
>> >
>> > On Thu, May 14, 2026 at 04:57:16PM +0200, Stefano Garzarella wrote:
>> > > On Wed, May 13, 2026 at 12:54:16PM +0200, Stefano Garzarella wrote:
>> > > > From: Stefano Garzarella <sgarzare@redhat.com>
>> > > >
>> > > > When there is no more space to queue an incoming packet, the packet is
>> > > > silently dropped. This causes data loss without any notification to
>> > > > either peer, since there is no retransmission.
>> > > >
>> > > > Under normal circumstances, this should never happen. However, it could
>> > > > happen if the other peer doesn't respect the credit, or if the skb
>> > > > overhead, which we recently began to take into account with commit
>> > > > 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue"),
>> > > > is too high.
>> > > >
>> > > > Fix this by resetting the connection and setting the local socket error
>> > > > to ENOBUFS when virtio_transport_recv_enqueue() can no longer queue a
>> > > > packet, so both peers are explicitly notified of the failure rather than
>> > > > silently losing data.
>> > > >
>> > > > Fixes: ae6fcfbf5f03 ("vsock/virtio: discard packets if credit is not respected")
>> > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> > > > ---
>> > > > net/vmw_vsock/virtio_transport_common.c | 19 ++++++++++++++-----
>> > > > 1 file changed, 14 insertions(+), 5 deletions(-)
>> > > >
>> > > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> > > > index 989cc252d3d3..4a4ac69d1ad1 100644
>> > > > --- a/net/vmw_vsock/virtio_transport_common.c
>> > > > +++ b/net/vmw_vsock/virtio_transport_common.c
>> > > > @@ -1350,7 +1350,7 @@ virtio_transport_recv_connecting(struct sock *sk,
>> > > >     return err;
>> > > > }
>> > > >
>> > > > -static void
>> > > > +static bool
>> > > > virtio_transport_recv_enqueue(struct vsock_sock *vsk,
>> > > >                           struct sk_buff *skb)
>> > > > {
>> > > > @@ -1365,10 +1365,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
>> > > >     spin_lock_bh(&vvs->rx_lock);
>> > > >
>> > > >     can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
>> > > > -   if (!can_enqueue) {
>> > > > -           free_pkt = true;
>> > > > +   if (!can_enqueue)
>> > > >             goto out;
>> > > > -   }
>> > > >
>> > > >     if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
>> > > >             vvs->msg_count++;
>> > > > @@ -1408,6 +1406,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
>> > > >     spin_unlock_bh(&vvs->rx_lock);
>> > > >     if (free_pkt)
>> > > >             kfree_skb(skb);
>> > > > +
>> > > > +   return can_enqueue;
>> > > > }
>> > > >
>> > > > static int
>> > > > @@ -1420,7 +1420,16 @@ virtio_transport_recv_connected(struct sock *sk,
>> > > >
>> > > >     switch (le16_to_cpu(hdr->op)) {
>> > > >     case VIRTIO_VSOCK_OP_RW:
>> > > > -           virtio_transport_recv_enqueue(vsk, skb);
>> > > > +           if (!virtio_transport_recv_enqueue(vsk, skb)) {
>> > > > +                   /* There is no more space to queue the packet, so let's
>> > > > +                    * close the connection; otherwise, we'll lose data.
>> > > > +                    */
>> > > > +                   (void)virtio_transport_reset(vsk, skb);
>> > > > +                   sk->sk_state = TCP_CLOSE;
>> > > > +                   sk->sk_err = ENOBUFS;
>> > > > +                   sk_error_report(sk);
>> > >
>> > > sashiko reported some issues related to setting TCP_CLOSE state and not
>> > > removing the socket from the connect table:
>> > > https://sashiko.dev/#/patchset/20260513105417.56761-1-sgarzare%40redhat.com
>> > >
>> > > I'll change this by calling virtio_transport_do_close() and
>> > > vsock_remove_sock() in the next version.
>> > >
>> > > Stefano
>> > >
>> > > > +                   break;
>> > > > +           }
>> > > >             vsock_data_ready(sk);
>> > > >             return err;
>> > > >     case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
>> > > > --
>> > > > 2.54.0
>> > > >
>> >
>> >
>> > And so the bag of hacks grows. I feel this is energy not well spent.
>> > Please, let us fix this properly *first*. And then worry about how to
>> > backport.  Maybe it will not be so terrible to backport after all.
>> >
>>
>> TBH I don't think this is an hack, but an issue we should fix in any case.
>> Regarding the second patch, I see your point, but it's a big change
>> that worries me. I'd like some more time to fix it properly without
>> rushing. Staying calm without realizing that userspace is broken like
>> we are now without this series :-(
>>
>> That said, evaluating further, I think we have a similar issue also
>> with STREAM on the host side where the skb usually doesn't free space,
>> so we need a merge strategy also there.
>>
>> So, I'd like to have time to fix both definitely. If you have time and
>> want to go ahead, please do.
>>
>> Thanks,
>> Stefano
>
>Well my patch was a start, we just need a strategy how to avoid copying
>everything, right?

Yep, and then there's the question of how to handle EOM without a 
payload, but I think that's a special case. In theory, we don't support 
sending it, but I'm not sure if POSIX allows it or not.

That said, is it okay if I send a v4 of this series?

(I'm not sure if I'll be able to work on the merging next week)

Stefano

