Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AF92D0C7E
	for <virtualization@lists.linux.dev>; Thu, 14 May 2026 16:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778777117; cv=none; b=TS9z9PPlij9/Dt/H3JIbL6VMtQGHlyT58ewHvfbq12vCpbrfLgxV2liadp4EF5yqZYDyY4+OXdrFf9N64PfhbNBEpA2VLd48Zb90XdrUnSMj6qooLTAcgcZvidaKrDpws3+VpZ8e6e63jl/mgoregq9aBkaXt05CtfL7EJkOtRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778777117; c=relaxed/simple;
	bh=zZzMMRJMHDj4bAdx59InN/qWYOHXeVGUIGiGQSI5A2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cnMb/TdCudm3r/DG1/5+EE38BrdOwl3/3bbuiniBiZsQa/fHuQpwavuzpRx50G7Ng99MyAM1nzjeB3Bm8isJJT2CI/lOaifwoNInlkyDtufNtIRxHWQ3YFfQNbuLgNAOFOudUXjV1qFdiUhsshGKDMyiFmEUmmCu8fQD0Xfoy94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I9Y7mUmi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I9Y7mUmi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778777115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GE7Sq5sTYAoJOxhLn6zS0szJk7y05mcClLoUpAWwPBg=;
	b=I9Y7mUmi7VZpRRrL3l0hW4yoyJhdKKgtw6HNRWP4kwz1R+DcijcU905d3sKzaUoJR8Fyz+
	RXtMI37WvA7iPctz9MNb13REWSPhBirnmQEhIUc6mNE2V/EoaRDNlK66lmkYEGS1R4OPuX
	hnyb5FMeKJfr/rKf/C+QJEFS0nlSjWE=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-Ew_p_hS2NS6U6woUAQBjzg-1; Thu, 14 May 2026 12:45:13 -0400
X-MC-Unique: Ew_p_hS2NS6U6woUAQBjzg-1
X-Mimecast-MFC-AGG-ID: Ew_p_hS2NS6U6woUAQBjzg_1778777113
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8230d6d54a5so10120b3a.1
        for <virtualization@lists.linux.dev>; Thu, 14 May 2026 09:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778777113; x=1779381913;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GE7Sq5sTYAoJOxhLn6zS0szJk7y05mcClLoUpAWwPBg=;
        b=j1HWYe1ZqgAypzSz6Q4+J6S7HOI9m+M/jlCHslMrnatcjFG7Cn/7mtw5GmZIEpzpyK
         BGHBvcVcDr9La1H8bPYIYeqhAAYGGKVimRPYOYx1QV9G5xR7xVoJw0yOb/HhfCba2VmW
         mC/VhDMvMBoaYWZ7fvmcqlywLmg/tO/OPEronyGa9LDkKDeR5dE/TdDniHnLEoqMJsag
         Cp4B5G0Gv0MBu2RT6bMiYbHeoLypa3TgOM1gKoyUDhZJHAbNF1XAd6qwXDJ9DutIZtOg
         NFZwhLuhgTL+JC0hkBq9fC8nqocFPHkOI1OK8POzRRfsL52DyY4tBffQedESy6m1XN2w
         G+Cg==
X-Forwarded-Encrypted: i=1; AFNElJ/8sS6E19DEutPoakPq+rWAqfzU9TJB/x/1jVT92P3KEMoieMj3+JQnSK7ZSQnF0N71A/CxBNwSW2yZLuZ72g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyzVZ4JT7ZXAXfnardur+1S9lUxc6Oe4/Vk1yHKqi+iwrDuglbY
	klCcV1FF6Ev9v2UU2iEnNOa/vuFUDDONH5GMgDJ+bknL+8rZlCjjLQECpxguOpDBJP5Az0B+24Z
	6hSbZmmBywOlHWZZuKtBsnCvwufeFyMyRcHVk/R3SUuh3meUYHdlvrmxgqkOa7Hozw8gVJLKjCn
	LyTfozOEFt4IgvCyuYN9DqikkGUCjNLyzgaSSD44e6neE=
X-Gm-Gg: Acq92OE1yNdfKsxx5/xd2ypIaLpFkeIxuFpQ9LTC/ybjzYFOxdnhqcKUt8JA8lLIoN9
	DKLFGqb2YqHo2hOeAtGwO/Ts/TOu78tzPg+LgQi0Su6zDwpgC8FWbQ7HMNx47NkOY56SJElM6qA
	zEYtNQNdfGi2KAc38nnNBxxF/HplkCZerRXJFtsukPUnEIKB01h4p20VbcKARjUsS87jWyonvzn
	+i9eA==
X-Received: by 2002:a05:6a00:bc93:b0:837:8a0c:8f70 with SMTP id d2e1a72fcca58-83f18ec2d11mr4217036b3a.28.1778777112645;
        Thu, 14 May 2026 09:45:12 -0700 (PDT)
X-Received: by 2002:a05:6a00:bc93:b0:837:8a0c:8f70 with SMTP id
 d2e1a72fcca58-83f18ec2d11mr4217000b3a.28.1778777112018; Thu, 14 May 2026
 09:45:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260513105417.56761-1-sgarzare@redhat.com> <20260513105417.56761-2-sgarzare@redhat.com>
 <agXh36gUe1K6__Bk@sgarzare-redhat> <20260514111513-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260514111513-mutt-send-email-mst@kernel.org>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 14 May 2026 18:45:00 +0200
X-Gm-Features: AVHnY4I_HyzF3GHdZFExrbox_xrkjrz-SlkZ9VT6btL5CcXjAJ3lI9yS4iPlqv8
Message-ID: <CAGxU2F4qWcQTmXnH74V8xZKADLiEMUmCc0+ktW5fZOXdTP4Bdw@mail.gmail.com>
Subject: Re: [PATCH net v3 1/2] vsock/virtio: reset connection on receiving
 queue overflow
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>, 
	kvm@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SxzdE4SWR5q2JnnUEoX1mWUKjG_mhWCKWI_I50M-lH0_1778777113
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 May 2026 at 17:16, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, May 14, 2026 at 04:57:16PM +0200, Stefano Garzarella wrote:
> > On Wed, May 13, 2026 at 12:54:16PM +0200, Stefano Garzarella wrote:
> > > From: Stefano Garzarella <sgarzare@redhat.com>
> > >
> > > When there is no more space to queue an incoming packet, the packet is
> > > silently dropped. This causes data loss without any notification to
> > > either peer, since there is no retransmission.
> > >
> > > Under normal circumstances, this should never happen. However, it could
> > > happen if the other peer doesn't respect the credit, or if the skb
> > > overhead, which we recently began to take into account with commit
> > > 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue"),
> > > is too high.
> > >
> > > Fix this by resetting the connection and setting the local socket error
> > > to ENOBUFS when virtio_transport_recv_enqueue() can no longer queue a
> > > packet, so both peers are explicitly notified of the failure rather than
> > > silently losing data.
> > >
> > > Fixes: ae6fcfbf5f03 ("vsock/virtio: discard packets if credit is not respected")
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > ---
> > > net/vmw_vsock/virtio_transport_common.c | 19 ++++++++++++++-----
> > > 1 file changed, 14 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > > index 989cc252d3d3..4a4ac69d1ad1 100644
> > > --- a/net/vmw_vsock/virtio_transport_common.c
> > > +++ b/net/vmw_vsock/virtio_transport_common.c
> > > @@ -1350,7 +1350,7 @@ virtio_transport_recv_connecting(struct sock *sk,
> > >     return err;
> > > }
> > >
> > > -static void
> > > +static bool
> > > virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> > >                           struct sk_buff *skb)
> > > {
> > > @@ -1365,10 +1365,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> > >     spin_lock_bh(&vvs->rx_lock);
> > >
> > >     can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
> > > -   if (!can_enqueue) {
> > > -           free_pkt = true;
> > > +   if (!can_enqueue)
> > >             goto out;
> > > -   }
> > >
> > >     if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
> > >             vvs->msg_count++;
> > > @@ -1408,6 +1406,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> > >     spin_unlock_bh(&vvs->rx_lock);
> > >     if (free_pkt)
> > >             kfree_skb(skb);
> > > +
> > > +   return can_enqueue;
> > > }
> > >
> > > static int
> > > @@ -1420,7 +1420,16 @@ virtio_transport_recv_connected(struct sock *sk,
> > >
> > >     switch (le16_to_cpu(hdr->op)) {
> > >     case VIRTIO_VSOCK_OP_RW:
> > > -           virtio_transport_recv_enqueue(vsk, skb);
> > > +           if (!virtio_transport_recv_enqueue(vsk, skb)) {
> > > +                   /* There is no more space to queue the packet, so let's
> > > +                    * close the connection; otherwise, we'll lose data.
> > > +                    */
> > > +                   (void)virtio_transport_reset(vsk, skb);
> > > +                   sk->sk_state = TCP_CLOSE;
> > > +                   sk->sk_err = ENOBUFS;
> > > +                   sk_error_report(sk);
> >
> > sashiko reported some issues related to setting TCP_CLOSE state and not
> > removing the socket from the connect table:
> > https://sashiko.dev/#/patchset/20260513105417.56761-1-sgarzare%40redhat.com
> >
> > I'll change this by calling virtio_transport_do_close() and
> > vsock_remove_sock() in the next version.
> >
> > Stefano
> >
> > > +                   break;
> > > +           }
> > >             vsock_data_ready(sk);
> > >             return err;
> > >     case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
> > > --
> > > 2.54.0
> > >
>
>
> And so the bag of hacks grows. I feel this is energy not well spent.
> Please, let us fix this properly *first*. And then worry about how to
> backport.  Maybe it will not be so terrible to backport after all.
>

TBH I don't think this is an hack, but an issue we should fix in any case.
Regarding the second patch, I see your point, but it's a big change
that worries me. I'd like some more time to fix it properly without
rushing. Staying calm without realizing that userspace is broken like
we are now without this series :-(

That said, evaluating further, I think we have a similar issue also
with STREAM on the host side where the skb usually doesn't free space,
so we need a merge strategy also there.

So, I'd like to have time to fix both definitely. If you have time and
want to go ahead, please do.

Thanks,
Stefano

