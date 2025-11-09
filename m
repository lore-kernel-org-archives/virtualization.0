Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AAA26C39B
	for <virtualization@lists.linux.dev>; Sun,  9 Nov 2025 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762724496; cv=none; b=NVElYQuCGGQ6s7x714NXEv4aObsXjisQHEazJ3Od7SyD8J6SF7d/dtIIATtomG4ei1pmBnxZRyOGW/ZXYwTXegdW+UNgH1J7hntGvNYGrjJrciOpUItOV1Kj4yXrk5QX3f3wE9r2yD9WyMeORt2RC2XnqmOhSKWDRwPyOLgnwN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762724496; c=relaxed/simple;
	bh=MOXxoILwQbdykOXtyBXgWf/d9Fx289+axW8lU9Jrt4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=F9YiYEdPOsVv8p3NvmhtivLN1jDEStcFax4cVc4x+MUTNWIVLAsg2WP8yGAI/Xt0mLA+C/kudQjqVaTnKY+X249o5bLpFa+kE2akCnEsey1zxlJM2SVkP4YZzN35emUjWl244K3VICaY+ghTBxRI3H2OHeoImZWdpb+a9VEKRtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IFhMkdl8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IFhMkdl8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762724493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ou3QgqFqB6sfyJ3NXy+JTUo8mN1dmsPv5vKTpn4Fnxk=;
	b=IFhMkdl85RnGW/RT3eTGJZHlorwkHaR5bP4YOncXOLfSdRldid3EdKm4CBvKDMeyluRoVY
	akGBzOfwmiEtyN4UVs4gtFdbmMDHqceIPO8j/TZrngr9hmMbJcdJF+rRxP79Ebjkb9xQ1c
	mUAZAEov+y7CbYFcLjjNQKaKHwFtvoM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-mbsU9NHJOF2xjeIBochJlA-1; Sun, 09 Nov 2025 16:41:32 -0500
X-MC-Unique: mbsU9NHJOF2xjeIBochJlA-1
X-Mimecast-MFC-AGG-ID: mbsU9NHJOF2xjeIBochJlA_1762724491
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4775d8428e8so17878375e9.0
        for <virtualization@lists.linux.dev>; Sun, 09 Nov 2025 13:41:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762724491; x=1763329291;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ou3QgqFqB6sfyJ3NXy+JTUo8mN1dmsPv5vKTpn4Fnxk=;
        b=u43eHn2a7wMq1jLxkRB5+yTGELm0p2pm8rIidehcCSwegR2t8VXvb11mKj5XCKvSCk
         6ubcwaB+2zpsUGcg9Cj8vS2Q2gnJSygx+rHNo584mrAcun0LLsC1FsWaYEG52cBcHqfS
         EvAVkRX5sVCztUyWrMhLtK+wULj9ec7po7e9hCgzcYnY+tTK3XzlBtRFCETl9mugYYrd
         AC7xteDhRuNLPoqDf4R4wIW38fSYbyRhlz71cE/L+tb3x6JEtaZfNmLWmAn333FoANqU
         s8O2+hQWYLx2dJNAxGFCUB5BD5AiAYKH4bWw6Fgap8hnWQc7IJSXXQWavurJpKRWTKES
         pLuw==
X-Forwarded-Encrypted: i=1; AJvYcCWTNzwZV48G2QGL64PSXO380o0JdIEejrInNjnrntHTS+9C7H1H64bpslZZj/faFxcvXUBvQm9JB190APh/lg==@lists.linux.dev
X-Gm-Message-State: AOJu0YypWoTGJ7LWnf7IRJwnLQSo+17YkgiHH2wTrLLuLsdtfLdn4Wk6
	SSFiCtazXV4Ww/k2RUTdCJrHZ+daBd4urCxApQmHbqX5/4Q4+knKySAMl+6mbKwx9rGxSmQzNVG
	lH0juVmwVWZJ5SAmYSLNw7qOzMgJ/wfYbTjHv5f+ESgKOQgG71VXST4yJA4kh+mHq7FWO
X-Gm-Gg: ASbGncv27GEU+4FzkYzvYwmXokUoMysvXVO6V+ThqOn/dpknROZv83tttwqqnZmjEFa
	DEFIKYDGeGCMhSA8u410W2s0PRk930a2BJVQ1mRKEJqHwe4MJwDZfwhDdgRqh2WeQQz2ZbCunqZ
	hj6OaDSrheQ+4NVOWW8gLmWYbmqiX7W5Ov3yRm+1E6iV94oJqxJZs7S6czbjl4/9c/i3qHKs7wB
	qnuEJqqyYhTtUfTIBCMmpvLLZHGmUN1D19wWrN1MzfJtSW1VAbhxGX4y/JY8UshJfI0pWuPmnYL
	6nuDu+jJTkHThNo3Ib6RWisWsfR6gCWeYvoTqUhqMyVhV7lpdoUDxlZtcrzocMq5hQA=
X-Received: by 2002:a05:600c:5490:b0:46e:7247:cbc0 with SMTP id 5b1f17b1804b1-4777323eca9mr53344985e9.18.1762724491179;
        Sun, 09 Nov 2025 13:41:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1Eoz8suLN8Yuo5spcVXTWIg7FsaQrpGd7DV8hop1FnHX8vSDgZC19+T9HKTUAvIcP7b/r3A==
X-Received: by 2002:a05:600c:5490:b0:46e:7247:cbc0 with SMTP id 5b1f17b1804b1-4777323eca9mr53344775e9.18.1762724490668;
        Sun, 09 Nov 2025 13:41:30 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1536:2700:9203:49b4:a0d:b580])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776d39c8f8sm159375465e9.3.2025.11.09.13.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 13:41:30 -0800 (PST)
Date: Sun, 9 Nov 2025 16:41:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heng Qi <hengqi@linux.alibaba.com>,
	Willem de Bruijn <willemb@google.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net v4 3/4] virtio-net: correct hdr_len handling for
 VIRTIO_NET_F_GUEST_HDRLEN
Message-ID: <20251109163911-mutt-send-email-mst@kernel.org>
References: <20251029030913.20423-1-xuanzhuo@linux.alibaba.com>
 <20251029030913.20423-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEu=Zs-T0WyD7mrWjuRDdufvRiz2DM=98neD+L2npP5_dQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEu=Zs-T0WyD7mrWjuRDdufvRiz2DM=98neD+L2npP5_dQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -B3H0hgYXKRJ3HeSEOKQOtpoZusqG7xBkHnOfwoD284_1762724491
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Oct 30, 2025 at 10:53:01AM +0800, Jason Wang wrote:
> On Wed, Oct 29, 2025 at 11:09 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > The commit be50da3e9d4a ("net: virtio_net: implement exact header length
> > guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
> > feature in virtio-net.
> >
> > This feature requires virtio-net to set hdr_len to the actual header
> > length of the packet when transmitting, the number of
> > bytes from the start of the packet to the beginning of the
> > transport-layer payload.
> >
> > However, in practice, hdr_len was being set using skb_headlen(skb),
> > which is clearly incorrect. This commit fixes that issue.
> 
> I still think it would be more safe to check the feature

which feature VIRTIO_NET_F_GUEST_HDRLEN ?


> and switch to
> the new behaviour if it is set. This seems to be more safe.
> 
> But I'm fine if it's agreed that this could be the way to go.
> 
> >
> > Fixes: be50da3e9d4a ("net: virtio_net: implement exact header length guest feature")
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  include/linux/virtio_net.h | 22 ++++++++++++++++------
> >  1 file changed, 16 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > index 710ae0d2d336..6ef0b737d548 100644
> > --- a/include/linux/virtio_net.h
> > +++ b/include/linux/virtio_net.h
> > @@ -217,25 +217,35 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
> >
> >         if (skb_is_gso(skb)) {
> >                 struct skb_shared_info *sinfo = skb_shinfo(skb);
> > +               u16 hdr_len = 0;
> >
> >                 /* In certain code paths (such as the af_packet.c receive path),
> >                  * this function may be called without a transport header.
> >                  * In this case, we do not need to set the hdr_len.
> >                  */
> >                 if (skb_transport_header_was_set(skb))
> > -                       hdr->hdr_len = __cpu_to_virtio16(little_endian,
> > -                                                        skb_headlen(skb));
> > +                       hdr_len = skb_transport_offset(skb);
> >
> >                 hdr->gso_size = __cpu_to_virtio16(little_endian,
> >                                                   sinfo->gso_size);
> > -               if (sinfo->gso_type & SKB_GSO_TCPV4)
> > +               if (sinfo->gso_type & SKB_GSO_TCPV4) {
> >                         hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV4;
> > -               else if (sinfo->gso_type & SKB_GSO_TCPV6)
> > +                       if (hdr_len)
> > +                               hdr_len += tcp_hdrlen(skb);
> > +               } else if (sinfo->gso_type & SKB_GSO_TCPV6) {
> >                         hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV6;
> > -               else if (sinfo->gso_type & SKB_GSO_UDP_L4)
> > +                       if (hdr_len)
> > +                               hdr_len += tcp_hdrlen(skb);
> > +               } else if (sinfo->gso_type & SKB_GSO_UDP_L4) {
> >                         hdr->gso_type = VIRTIO_NET_HDR_GSO_UDP_L4;
> > -               else
> > +                       if (hdr_len)
> > +                               hdr_len += sizeof(struct udphdr);
> > +               } else {
> >                         return -EINVAL;
> > +               }
> > +
> > +               hdr->hdr_len = __cpu_to_virtio16(little_endian, hdr_len);
> > +
> >                 if (sinfo->gso_type & SKB_GSO_TCP_ECN)
> >                         hdr->gso_type |= VIRTIO_NET_HDR_GSO_ECN;
> >         } else
> > --
> > 2.32.0.3.g01195cf9f
> >
> 
> Thanks

