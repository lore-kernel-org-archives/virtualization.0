Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DC6303CB7
	for <virtualization@lists.linux.dev>; Fri, 19 Sep 2025 08:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758269318; cv=none; b=S/DYt3QAxdqTEpPO9zIFvX5Xa0G3GSxxNSVYxssbO9CZP/XGqs5ZGXgYMY8+f3n/7MXMOtQ1p7Z72b17dH6q3hVgetUavYo1y+J8choRvaGg1xGs354jX/hXnD97WFauQoRk1WJaYLQvOk7vWIA7B8mpw9ochRY6c7p5fnVv1Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758269318; c=relaxed/simple;
	bh=VLZYffDAeaYgQlYikAN5MJfCakv0SHKRtux7+rgjz5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mu/QDtKJhZjYC7DVmpT0uVd0a6nd/qsuBYJ18UqQMkimSHppwp/OzOekywvppoy1nsmLed4RFPOxzfSQB5OAgyLT6p6L7yvFI/nRRdK071SRQ9uUlYZuaFJQNLumokjEoTqW1fqsKpyuPAbvmCmpLC+7llskE+Yh3nnZ9N4pICs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uxp/0H79; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uxp/0H79"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758269315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LIxzvraroGndXUseXRYHpQ4xGsj43fuuer+gtznNY3k=;
	b=Uxp/0H79F75avWKIEJNDXCT/HmbvS11rjO5bcGBWRjw+UXGTExG03FwCuoTIgkSh+3dz1h
	mqEKo2wgcxJNZSZU2OlOcypWbrMFcutc4UHMx/09ySGH9FpP3awI4q3RCPlPJ0wASCyv7O
	ycQoaa6x8fFKaZDjFda518MqCBvAbrY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-kufwwQQ1MDCuXj6KSvFeGw-1; Fri, 19 Sep 2025 04:08:33 -0400
X-MC-Unique: kufwwQQ1MDCuXj6KSvFeGw-1
X-Mimecast-MFC-AGG-ID: kufwwQQ1MDCuXj6KSvFeGw_1758269313
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45deddf34b9so18207175e9.1
        for <virtualization@lists.linux.dev>; Fri, 19 Sep 2025 01:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758269312; x=1758874112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LIxzvraroGndXUseXRYHpQ4xGsj43fuuer+gtznNY3k=;
        b=kFFWo/g3+d2M+7isSEMbp/xRAHyWgU/Vor2xEgGpvx0kUj1hbUawRk3mauhVFSJsGz
         Y1KXUTJh9rA8DcevT8a7o4yBIjt98V0Zs6tPRQsd9EFuSHI9iEH56ACyDyRRTk0PJvZC
         8dSFyzvTM/s+d3VFV9lzG7lsOSx/TSvhaoPIzXeWQrbpUBvucmqdBVVaw2stUugdGITW
         nlYGh1azVUbmRiAZP/4PsOhsxwYoShSWt+J0f+mogsO/WMURy8jsH1ME8hYg1V6uxnDH
         YgSLDEtD+Rricrh6dJv2+eo1Hk4/un9G1wHi6ZSRoCYxEJiVz9k0UBYr4d4D7z4H0W3H
         veyw==
X-Forwarded-Encrypted: i=1; AJvYcCU2PRBEGeWSz+HbD9xPkt0IAL3Km7Nrpochz64xr8nJkA/6DzbbCyZGWE32G4IOkc+NLY44GRYRWafnTw1wvQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxlaXXamy39ytT3UnHCixCkzwgQK8jBeObwF2VTqhx09gEDC9Ty
	DPaLN2CPKBkdUIDDqkSPoP7HHZN8wRp5u/6I8WQ8JgUBxf6deV9v5BsB2vWqEBadiwCqolTtpZG
	xj7fQ24sIH6Rdu5a1iIwFMgDQ+ETOuQHo1UkYgZyIMpNSCfQGBKnVm5hPMtjCCbYJFPFk
X-Gm-Gg: ASbGncucGcDXjFKpLitEmJbOLgFWrXbhXw8nyEqOUxdwJg6ILqPGnlPneOH3OWb60ek
	yjsosDAWFZraShFKil0fHy3+CXSdeVisMIpz6l/0A1mHxl8b2jIAf1Aln1LbynIp/nHCmn1XSL7
	2SmfQ93LKkxtyikOJ0WiB6KqTP+O5mt6XHO67ukcmJkLO2pcHhPICxJLIM2Wayu2ZJma0KCO7pu
	xYSpycGr5ZZaM5JNnGrIVYPZTVcNPZQi2anq0uIjZFKUp7NMGvZhgBTSgcONlPeFWMMLR82fxlT
	/LE71y2EBmmo/ttbPZPohu5ez0eDQ5M=
X-Received: by 2002:a05:600c:a316:b0:45b:86bb:af5f with SMTP id 5b1f17b1804b1-4650a0b8379mr52806665e9.6.1758269312585;
        Fri, 19 Sep 2025 01:08:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSYngzMvTigSbwISAEKdbUVkh+qjENhtjn2tbVqLzn3qz8kOruU3DQcxqKMxkEFwwZ+71K8w==
X-Received: by 2002:a05:600c:a316:b0:45b:86bb:af5f with SMTP id 5b1f17b1804b1-4650a0b8379mr52806335e9.6.1758269312176;
        Fri, 19 Sep 2025 01:08:32 -0700 (PDT)
Received: from redhat.com ([147.235.214.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f162726bsm73886815e9.7.2025.09.19.01.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 01:08:31 -0700 (PDT)
Date: Fri, 19 Sep 2025 04:08:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heng Qi <hengqi@linux.alibaba.com>, virtualization@lists.linux.dev
Subject: Re: [PATCH net] virtio-net: fix incorrect flags recording in big mode
Message-ID: <20250919040736-mutt-send-email-mst@kernel.org>
References: <20250919013450.111424-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEscCsCf8RC-xQzfTNMp94Ty4wTrBgLkF50OAQ+yF8xD-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEscCsCf8RC-xQzfTNMp94Ty4wTrBgLkF50OAQ+yF8xD-A@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WJaKjkGAtCJEwsSSYqqEbQObM22s0o-_B7oJEd0uPyM_1758269313
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Sep 19, 2025 at 10:11:55AM +0800, Jason Wang wrote:
> On Fri, Sep 19, 2025 at 9:35 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > The purpose of commit 703eec1b2422 ("virtio_net: fixing XDP for fully
> > checksummed packets handling") is to record the flags in advance, as
> > their value may be overwritten in the XDP case. However, the flags
> > recorded under big mode are incorrect, because in big mode, the passed
> > buf does not point to the rx buffer, but rather to the page of the
> > submitted buffer. This commit fixes this issue.
> >
> > For the small mode, the commit c11a49d58ad2 ("virtio_net: Fix mismatched
> > buf address when unmapping for small packets") fixed it.
> >
> > Fixes: 703eec1b2422 ("virtio_net: fixing XDP for fully checksummed packets handling")
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 975bdc5dab84..6e6e74390955 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2630,13 +2630,19 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
> >          */
> >         flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
> >
> > -       if (vi->mergeable_rx_bufs)
> > +       if (vi->mergeable_rx_bufs) {
> >                 skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
> >                                         stats);
> > -       else if (vi->big_packets)
> > +       } else if (vi->big_packets) {
> > +               void *p;
> > +
> > +               p = page_address((struct page *)buf);
> > +               flags = ((struct virtio_net_common_hdr *)p)->hdr.flags;
> > +
> 
> Patch looks good but a I have a nit:
> 
> It looks better to move this above?
> 
> if (vi->big_packets) {
>                void *p = page_address((struct page *)buf);
>                flags = ((struct virtio_net_common_hdr *)p)->hdr.flags;
> } else
>                flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
> 
> To avoid twice the calculations and reuse the comment.


I think duplicating a bit of code is better than branching twice.
So I would move the flags assignment down instead.


> >                 skb = receive_big(dev, vi, rq, buf, len, stats);
> > -       else
> > +       } else {
> >                 skb = receive_small(dev, vi, rq, buf, ctx, len, xdp_xmit, stats);
> > +       }
> >
> >         if (unlikely(!skb))
> >                 return;
> > --
> > 2.32.0.3.g01195cf9f
> >
> 
> Thanks

