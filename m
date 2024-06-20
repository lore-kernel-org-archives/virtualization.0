Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB4F628
	for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 10:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718878754; cv=none; b=FXEMZsnEETYwrZ9MMO3Y7bXX7GR0C30JittjTQbIlriAKsdFjXUZNGNxSG9tsTKNqIJse1nE1Wq6rnq7eo/ULCLzKCdakxnS/tjppKvz1n8Lr5YlQuUpMwGFPIFZUwAFoipSHN/O2z3tP1NFebt34vjxiCqsB6VpSF36fYtwtNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718878754; c=relaxed/simple;
	bh=Er+BEVt2cdvQn+Yejxy1j025GsLkjeWL0otCVkNSEFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=N/iaEH4cMJzFlpU5xxT7lewKWlu/iMIIULU9d9EMo/7LYrp9HN7aRlSXIa5ONq1eS+erjQ5Ui21HAv5jMq1yI+OWvZr9bfZDQNS0xjxTaeEetRJ4og+EW9/COnxAnbpeGJtMxw6+2b/K5rDFYgNFWaqqueWU6Tm7AlRI5UT/Cow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hJtCd7rE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJtCd7rE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718878751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H2ImS6JTH2ZuM1A7SBaz+cGd1j9fE+qsCgMEKtpZ/zQ=;
	b=hJtCd7rEihR4LTnc++5bHUTSTKbXzlgTt6k4eBNqt0UknGMZDCM4Nci26fMSok/1s6ee5x
	SQv59l9+0/uW/HkkVMzM6l4moQRKBlK6QE0QHaRLSi+Jm1NsGDf4NHwGXO+mogQyxnmMkb
	f48OYMGWVVrueX2qpTwSucVgbJqgL6o=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-yQvduAC4MGisTxx-UlJuug-1; Thu, 20 Jun 2024 06:19:10 -0400
X-MC-Unique: yQvduAC4MGisTxx-UlJuug-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a6f0da6cd62so79607766b.1
        for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 03:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718878749; x=1719483549;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H2ImS6JTH2ZuM1A7SBaz+cGd1j9fE+qsCgMEKtpZ/zQ=;
        b=QybVKxxeLtd3W9OOXx8YM9xIczsh5NmyhahYMbjmGa8HRjPz+r6h9NlUCxPZlrn/Yb
         3j93AMmxGfDS4OJf4xN0gtNjDqu+2TdexD1gCyP0iaT/LOb+cDPSZyvug3iZsKmJduHy
         Wvfz5lXemD7tIOGpbcyddBu56bXwkrR35lDLOu4Z9UM+1dR2a9wjbGFI6ceFVAdGib3N
         mpwJaORlz9NEjvW7PACMcBxnHc088F7ZfkX0MROErCCLMUB3c+x1BH3K44Y/uQYgavNg
         gdjZQjh/vaJF2C8Uopmu7N1WIv1aHScrzvt1DUoqyGGV202qZvM0KxrOvqAlL0sISg7s
         SdXw==
X-Forwarded-Encrypted: i=1; AJvYcCU8UJKFw4BXJJnV4ei8+tieMEg1ipyXWZDT4mMXz9yYXnmHAcVC2XcOQQkrrSFUTcR71Oibh4yDkDvmz0nKJukMm4FjQXqQivrrr3j8sNU=
X-Gm-Message-State: AOJu0YxvaajorZaiwECUSqmdgZ4dw6PhNAhhC9AVY/TbVIPsPmEHJvyZ
	Z8IS9VVVmQwzBBnwnR2hdK2YjkJIJrMqalOEMIr6u1UPdFC+Qah3c/n4cKxz3LqZs+MtslQYZ/S
	Y27barZSPX56D26nkg2tpeI7UYE9FhRPasM00E8V7hiidKwNsNk89hByzU4Sf8bdS
X-Received: by 2002:a17:906:b214:b0:a6f:9f10:298d with SMTP id a640c23a62f3a-a6f9f102a59mr412608666b.11.1718878748915;
        Thu, 20 Jun 2024 03:19:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgWn0auDfZRu/u/e39ZUQLUb/5cjyxt3HpOwJi+0Yi5bYAGQXOGh5zFjF2jeRRn7rpCOf7Uw==
X-Received: by 2002:a17:906:b214:b0:a6f:9f10:298d with SMTP id a640c23a62f3a-a6f9f102a59mr412604566b.11.1718878748219;
        Thu, 20 Jun 2024 03:19:08 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56db61f6sm751624566b.57.2024.06.20.03.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 03:19:06 -0700 (PDT)
Date: Thu, 20 Jun 2024 06:19:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	Thomas Huth <thuth@linux.vnet.ibm.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH 2/2] virtio_net: fixing XDP for fully checksummed packets
 handling
Message-ID: <20240620061710-mutt-send-email-mst@kernel.org>
References: <20240617131524.63662-1-hengqi@linux.alibaba.com>
 <20240617131524.63662-3-hengqi@linux.alibaba.com>
 <CACGkMEvj8fvXkCxDFQ1-Cyq5DL=axEf1Ch1zVnuQUNQy6Wjn+g@mail.gmail.com>
 <1718680517.8370645-12-hengqi@linux.alibaba.com>
 <CACGkMEsa3AsPkweqS0-BEjSw5sKW_XM669HVSN_eX7-8KVG8tQ@mail.gmail.com>
 <1718875728.9338605-7-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1718875728.9338605-7-hengqi@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Jun 20, 2024 at 05:28:48PM +0800, Heng Qi wrote:
> On Thu, 20 Jun 2024 16:33:35 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > On Tue, Jun 18, 2024 at 11:17 AM Heng Qi <hengqi@linux.alibaba.com> wrote:
> > >
> > > On Tue, 18 Jun 2024 11:10:26 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > > > On Mon, Jun 17, 2024 at 9:15 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
> > > > >
> > > > > The XDP program can't correctly handle partially checksummed
> > > > > packets, but works fine with fully checksummed packets.
> > > >
> > > > Not sure this is ture, if I was not wrong, XDP can try to calculate checksum.
> > >
> > > XDP's interface serves a full checksum,
> > 
> > What do you mean by "serve" here? I mean, XDP can calculate the
> > checksum and fill it in the packet by itself.
> > 
> 
> Yes, XDP can parse and calculate checksums for all packets.
> However, the bpf_csum_diff and bpf_l4_csum_replace APIs provided by XDP assume
> that the packets being processed are fully checksumed packets. That is,
> after the XDP program modified the packets, the incremental checksum can be
> calculated (for example, samples/bpf/tcbpf1_kern.c, samples/bpf/test_lwt_bpf.c).
> 
> Therefore, partially checksummed packets cannot be processed normally in these
> examples and need to be discarded.
> 
> > > and this is why we disabled the
> > > offloading of VIRTIO_NET_F_GUEST_CSUM when loading XDP.
> > 
> > If we trust the device to disable VIRTIO_NET_F_GUEST_CSUM, any reason
> > to check VIRTIO_NET_HDR_F_NEEDS_CSUM again in the receive path?
> 
> There doesn't seem to be a mandatory constraint in the spec that devices that
> haven't negotiated VIRTIO_NET_F_GUEST_CSUM cannot set NEEDS_CSUM bit, so I check this.
> 
> Thanks.

The spec says:

\item If the VIRTIO_NET_F_GUEST_CSUM feature was negotiated, the
  VIRTIO_NET_HDR_F_NEEDS_CSUM bit in \field{flags} can be
  set: if so, the packet checksum at offset \field{csum_offset} 
  from \field{csum_start} and any preceding checksums
  have been validated.  The checksum on the packet is incomplete and
  if bit VIRTIO_NET_HDR_F_RSC_INFO is not set in \field{flags},
  then \field{csum_start} and \field{csum_offset} indicate how to calculate it
  (see Packet Transmission point 1).


So yes, NEEDS_CSUM without VIRTIO_NET_F_GUEST_CSUM is at best undefined.
Please do not try to use it unless VIRTIO_NET_F_GUEST_CSUM is set.

And if you want to be flexible, ignore it unless VIRTIO_NET_F_GUEST_CSUM
has been negotiated.





> > 
> > >
> > > Thanks.
> > 
> > Thanks
> > 
> > >
> > > >
> > > > Thanks
> > > >
> > > > > If the
> > > > > device has already validated fully checksummed packets, then
> > > > > the driver doesn't need to re-validate them, saving CPU resources.
> > > > >
> > > > > Additionally, the driver does not drop all partially checksummed
> > > > > packets when VIRTIO_NET_F_GUEST_CSUM is not negotiated. This is
> > > > > not a bug, as the driver has always done this.
> > > > >
> > > > > Fixes: 436c9453a1ac ("virtio-net: keep vnet header zeroed after processing XDP")
> > > > > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > > > ---
> > > > >  drivers/net/virtio_net.c | 20 +++++++++++++++++++-
> > > > >  1 file changed, 19 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index aa70a7ed8072..ea10db9a09fa 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -1360,6 +1360,10 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
> > > > >         if (unlikely(hdr->hdr.gso_type))
> > > > >                 goto err_xdp;
> > > > >
> > > > > +       /* Partially checksummed packets must be dropped. */
> > > > > +       if (unlikely(hdr->hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
> > > > > +               goto err_xdp;
> > > > > +
> > > > >         buflen = SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom) +
> > > > >                 SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > > > >
> > > > > @@ -1677,6 +1681,10 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
> > > > >         if (unlikely(hdr->hdr.gso_type))
> > > > >                 return NULL;
> > > > >
> > > > > +       /* Partially checksummed packets must be dropped. */
> > > > > +       if (unlikely(hdr->hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
> > > > > +               return NULL;
> > > > > +
> > > > >         /* Now XDP core assumes frag size is PAGE_SIZE, but buffers
> > > > >          * with headroom may add hole in truesize, which
> > > > >          * make their length exceed PAGE_SIZE. So we disabled the
> > > > > @@ -1943,6 +1951,7 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
> > > > >         struct net_device *dev = vi->dev;
> > > > >         struct sk_buff *skb;
> > > > >         struct virtio_net_common_hdr *hdr;
> > > > > +       u8 flags;
> > > > >
> > > > >         if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
> > > > >                 pr_debug("%s: short packet %i\n", dev->name, len);
> > > > > @@ -1951,6 +1960,15 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
> > > > >                 return;
> > > > >         }
> > > > >
> > > > > +       /* 1. Save the flags early, as the XDP program might overwrite them.
> > > > > +        * These flags ensure packets marked as VIRTIO_NET_HDR_F_DATA_VALID
> > > > > +        * stay valid after XDP processing.
> > > > > +        * 2. XDP doesn't work with partially checksummed packets (refer to
> > > > > +        * virtnet_xdp_set()), so packets marked as
> > > > > +        * VIRTIO_NET_HDR_F_NEEDS_CSUM get dropped during XDP processing.
> > > > > +        */
> > > > > +       flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
> > > > > +
> > > > >         if (vi->mergeable_rx_bufs)
> > > > >                 skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
> > > > >                                         stats);
> > > > > @@ -1966,7 +1984,7 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
> > > > >         if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
> > > > >                 virtio_skb_set_hash(&hdr->hash_v1_hdr, skb);
> > > > >
> > > > > -       if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
> > > > > +       if (flags & VIRTIO_NET_HDR_F_DATA_VALID)
> > > > >                 skb->ip_summed = CHECKSUM_UNNECESSARY;
> > > > >
> > > > >         if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
> > > > > --
> > > > > 2.32.0.3.g01195cf9f
> > > > >
> > > >
> > >
> > 

