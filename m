Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA60126C17
	for <virtualization@lists.linux.dev>; Fri, 27 Jun 2025 02:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750992148; cv=none; b=r+SybBKew7pV9DJV6K3iRpaGmA5gYCbP0UbEUx6JbGWsdprsJvEmg0veAFMRs02Q8DoySSZpCI8EIBCyYEiZOGcn8dWbxqs0sWHtmV1nziAWv1otswugKXWPmcYZQAPmRUV2gDe1INQQXOdlolUxpQTeDLT/DKLNd4xKamGajeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750992148; c=relaxed/simple;
	bh=SdTf8Z6fyK/HZshyR2WSEcVEDgIXDaUI6GJQaYYwApU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EADsvPvouTBIdDO+BPAGTDaWZWlHCbAmYOBA/hUdqC0lQedh+jP1zpMk55C4hk4xkbUQ2Ydj4rrAZZBzVyWo7Fzr8Sa8sXsqB5MMqVLZ6d23WyYTbs6sqKEEmkZpycZ41SXf8xlqE6nnU9xeCrJhbKGB09943YfLMIkbdD7ND+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d0dQb73b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d0dQb73b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750992145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0y4ogdWfKUskoLksqSv1cDEXTKy/QANfgQ8Wcutrwa0=;
	b=d0dQb73bjWmWdwk5GH5MUar6S+GT0Y8xB0TW1AzDh4X8UdngrIU3nRFFfldGhnWvAm6c0O
	NfcCOke5S8J583T8RTKUmyvLYQ7VilzgdpHm5quQOiEZN0EBJpVPLurqt/wQkApraeFMhW
	eOz7jxpKRKtl+E/DvULn2e1aN4Z+iKo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-HXbS-vp0MY614Dfjdg8-GQ-1; Thu, 26 Jun 2025 22:42:24 -0400
X-MC-Unique: HXbS-vp0MY614Dfjdg8-GQ-1
X-Mimecast-MFC-AGG-ID: HXbS-vp0MY614Dfjdg8-GQ_1750992144
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-31327b2f8e4so1521554a91.1
        for <virtualization@lists.linux.dev>; Thu, 26 Jun 2025 19:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750992143; x=1751596943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0y4ogdWfKUskoLksqSv1cDEXTKy/QANfgQ8Wcutrwa0=;
        b=DRgF/zNUW13QzL5iEEjq/MKOW3PEF7UgZbc8w0IdWV1+pZoW730p4dtM5GDDrKliQe
         GzP/hrTMFlnEgrcUylXxZYwqQHEAyR53Sql5+lr2n1hLZcRD5oh3et1Odb6AwgOaMVxO
         RkZ0Y9IbgQpfsWCVnXNkl40SXTkAqfugdR22HhCC4JMKbBkMfkzqAFsNgKwIIq3IqOTw
         nXA6vcQv986j75l79/gYXaqTZelJURL+Hg8pMZLxlZHeo5SREIJw34r0D8V5jlPOSGyG
         +0B0V3i0shyqvpVnjexTjLdfdhaqgzaVGFmR7IueXqtuGjmEGw+Kwonq9xMySP6++DDu
         zPcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWM1PcRix8msbVbXaqylYYE3vMVr3ptXgcKj6xmFSc5nRZvLMWJyPM6H2iVkjs6UprnPvqVmjKLWYdSQTRTgg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzEtVTyszH+THAUxycKq2s0qG+qlYrjyK5i+GYXWBKZX9U4gun5
	/TiXIPTfIBVuNlU9eVCRDjrUrnts95SIODV9hWMntpBPSgvv6wJMoNiAWEh5te9XUvIMuf9NSeV
	AKAAzHfmy2evvdsjEQ39PIDA7cbjXX9Klghj4KKU9s3YKTVaBcRJDKisNP8WtTxJ3wALlsK2N/O
	I8Vp4HVhPhvE/u8aJqd/rPA/yL5F5I9+ei7LP3h3ecqoo=
X-Gm-Gg: ASbGncvY390agb9COZFoWonjDJsFkiL5GIzWvNvkmFQn7ompQcegW2TZY+J91vKa5IJ
	Cj0WAgGqnklgw7eptLTI2xRRAl+9hFePXE+Q3ufbglr+i51yqfTHqKTX6GLmq5m06fkbqaYVGco
	yC
X-Received: by 2002:a17:90b:1f89:b0:312:1cd7:b337 with SMTP id 98e67ed59e1d1-318c911e00dmr1944398a91.5.1750992143514;
        Thu, 26 Jun 2025 19:42:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwGbHlkbt0ZZkXIHkgZ1VmAjcfzX3PaJulYFgYKAEcgaDwZicgMiljALERrT6XFmENjSrOdPALHnOlGHUcwhg=
X-Received: by 2002:a17:90b:1f89:b0:312:1cd7:b337 with SMTP id
 98e67ed59e1d1-318c911e00dmr1944344a91.5.1750992143051; Thu, 26 Jun 2025
 19:42:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250625160849.61344-1-minhquangbui99@gmail.com>
 <20250625160849.61344-2-minhquangbui99@gmail.com> <CACGkMEvioXkt3_zB-KijwhoUx5NS5xa0Jvd=w2fhBZFf3un1Ww@mail.gmail.com>
 <0bf0811e-cdb8-4410-9b69-1c38b06bbadf@gmail.com>
In-Reply-To: <0bf0811e-cdb8-4410-9b69-1c38b06bbadf@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 27 Jun 2025 10:42:11 +0800
X-Gm-Features: Ac12FXxdViEQWWA017DWAwJPntu53W5CWymI2HEGHOwPav-f88RyBtMLMqPNFP0
Message-ID: <CACGkMEsfU=84EYB_L6vusEbdnCLdQ_ri+izMGr+drC9z75LP_g@mail.gmail.com>
Subject: Re: [PATCH net 1/4] virtio-net: ensure the received length does not
 exceed allocated size
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: g-XwSAjkc6_MQyLzoLbHZ2mNPx7raAIZIlSiQzK4TKA_1750992144
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 11:34=E2=80=AFPM Bui Quang Minh
<minhquangbui99@gmail.com> wrote:
>
> On 6/26/25 09:34, Jason Wang wrote:
> > On Thu, Jun 26, 2025 at 12:10=E2=80=AFAM Bui Quang Minh
> > <minhquangbui99@gmail.com> wrote:
> >> In xdp_linearize_page, when reading the following buffers from the rin=
g,
> >> we forget to check the received length with the true allocate size. Th=
is
> >> can lead to an out-of-bound read. This commit adds that missing check.
> >>
> >> Fixes: 4941d472bf95 ("virtio-net: do not reset during XDP set")
> > I think we should cc stable.
>
> Okay, I'll do that in next version.
>
> >
> >> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> >> ---
> >>   drivers/net/virtio_net.c | 27 ++++++++++++++++++++++-----
> >>   1 file changed, 22 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >> index e53ba600605a..2a130a3e50ac 100644
> >> --- a/drivers/net/virtio_net.c
> >> +++ b/drivers/net/virtio_net.c
> >> @@ -1797,7 +1797,8 @@ static unsigned int virtnet_get_headroom(struct =
virtnet_info *vi)
> >>    * across multiple buffers (num_buf > 1), and we make sure buffers
> >>    * have enough headroom.
> >>    */
> >> -static struct page *xdp_linearize_page(struct receive_queue *rq,
> >> +static struct page *xdp_linearize_page(struct net_device *dev,
> >> +                                      struct receive_queue *rq,
> >>                                         int *num_buf,
> >>                                         struct page *p,
> >>                                         int offset,
> >> @@ -1818,17 +1819,33 @@ static struct page *xdp_linearize_page(struct =
receive_queue *rq,
> >>          page_off +=3D *len;
> >>
> >>          while (--*num_buf) {
> >> -               unsigned int buflen;
> >> +               unsigned int headroom, tailroom, room;
> >> +               unsigned int truesize, buflen;
> >>                  void *buf;
> >> +               void *ctx;
> >>                  int off;
> >>
> >> -               buf =3D virtnet_rq_get_buf(rq, &buflen, NULL);
> >> +               buf =3D virtnet_rq_get_buf(rq, &buflen, &ctx);
> >>                  if (unlikely(!buf))
> >>                          goto err_buf;
> >>
> >>                  p =3D virt_to_head_page(buf);
> >>                  off =3D buf - page_address(p);
> >>
> >> +               truesize =3D mergeable_ctx_to_truesize(ctx);
> > This won't work for receive_small_xdp().
>
> If it is small mode, the num_buf =3D=3D 1 and we don't get into the while=
 loop.

You are right, it might be worth mentioning this somewhere.

>
> >
> >> +               headroom =3D mergeable_ctx_to_headroom(ctx);
> >> +               tailroom =3D headroom ? sizeof(struct skb_shared_info)=
 : 0;
> >> +               room =3D SKB_DATA_ALIGN(headroom + tailroom);
> >> +
> >> +               if (unlikely(buflen > truesize - room)) {
> >> +                       put_page(p);
> >> +                       pr_debug("%s: rx error: len %u exceeds truesiz=
e %lu\n",
> >> +                                dev->name, buflen,
> >> +                                (unsigned long)(truesize - room));
> >> +                       DEV_STATS_INC(dev, rx_length_errors);
> >> +                       goto err_buf;
> >> +               }
> > I wonder if this issue only affect XDP should we check other places?
>
> In small mode, we check the len with GOOD_PACKET_LEN in receive_small.
> In mergeable mode, we have some checks over the place and this is the
> only one I see we miss. In xsk, we check inside buf_to_xdp. However, in
> the big mode, I feel like there is a bug.
>
> In add_recvbuf_big, 1 first page + vi->big_packets_num_skbfrags pages.
> The pages are managed by a linked list. The vi->big_packets_num_skbfrags
> is set in virtnet_set_big_packets
>
>      vi->big_packets_num_skbfrags =3D guest_gso ? MAX_SKB_FRAGS :
> DIV_ROUND_UP(mtu, PAGE_SIZE);
>
> So the vi->big_packets_num_skbfrags can be fewer than MAX_SKB_FRAGS.
>
> In receive_big, we call to page_to_skb, there is a check
>
>      if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
>          /* error case */
>      }
>
> But because the number of allocated buffer is
> vi->big_packets_num_skbfrags + 1 and vi->big_packets_num_skbfrags can be
> fewer than MAX_SKB_FRAGS, the check seems not enough
>
>      while (len) {
>          unsigned int frag_size =3D min((unsigned)PAGE_SIZE - offset, len=
);
>          skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, offset,
>                  frag_size, truesize);
>          len -=3D frag_size;
>          page =3D (struct page *)page->private;
>          offset =3D 0;
>      }
>
> In the following while loop, we keep running based on len without NULL
> check the pages linked list, so it may result into NULL pointer dereferen=
ce.
>
> What do you think?

This looks like a bug, let's fix it.

Thanks

>
> Thanks,
> Quang Minh.
>
> >
> >> +
> >>                  /* guard against a misconfigured or uncooperative bac=
kend that
> >>                   * is sending packet larger than the MTU.
> >>                   */
> >> @@ -1917,7 +1934,7 @@ static struct sk_buff *receive_small_xdp(struct =
net_device *dev,
> >>                  headroom =3D vi->hdr_len + header_offset;
> >>                  buflen =3D SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom)=
 +
> >>                          SKB_DATA_ALIGN(sizeof(struct skb_shared_info)=
);
> >> -               xdp_page =3D xdp_linearize_page(rq, &num_buf, page,
> >> +               xdp_page =3D xdp_linearize_page(dev, rq, &num_buf, pag=
e,
> >>                                                offset, header_offset,
> >>                                                &tlen);
> >>                  if (!xdp_page)
> >> @@ -2252,7 +2269,7 @@ static void *mergeable_xdp_get_buf(struct virtne=
t_info *vi,
> >>           */
> >>          if (!xdp_prog->aux->xdp_has_frags) {
> >>                  /* linearize data for XDP */
> >> -               xdp_page =3D xdp_linearize_page(rq, num_buf,
> >> +               xdp_page =3D xdp_linearize_page(vi->dev, rq, num_buf,
> >>                                                *page, offset,
> >>                                                XDP_PACKET_HEADROOM,
> >>                                                len);
> >> --
> >> 2.43.0
> >>
>

