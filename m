Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA28474416
	for <virtualization@lists.linux.dev>; Sun,  2 Jun 2024 19:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717357785; cv=none; b=Z6nBRTgVRmXV0ZAut6nfGVnilB4TiYwFnVgRCyKTYTyaGc1te+ZHbWe4LnHCeGZ7lsksg0KwCR8LsT0WNdzSz4EFMFLGId44GzS9nnyEQa2DAPAiv9V3Kz0Bzcm4WiuMZzZu0kldYMHToY+Bz3urlR7gkcAdTdvZreFvjq8A/JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717357785; c=relaxed/simple;
	bh=M9t7D758wg1n2wNHyOFIFaoOT3WTZ1VqpV/s/jCVuVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IZurWoGbsP/i5//oD0ua6OWk4j3Bq0CRhykhII3Z5uT4ejCwpWS/TPyHFNjRpLZRhcgl3r8d5NGviaDCKXzTu0JXgu5O9BP5Udklx7DQYO+N0KcR/ynNUNtIFPery7MkuNTpWgzNDHxCPnUss+TVBdw8r2JK5yzyESQSAuMXS4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XS6BWPZj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XS6BWPZj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717357782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bt+ZjDVXY3zkF1B/fEssYKB4/7ls0IVbAE3Y1l6PtqI=;
	b=XS6BWPZjq8aEJfQAGTKU7qGV66fZNfT8RSVjtsBAfRHT1RULnzXfEgtwiQ89Ak+DdHixxW
	PbW+IDLMaMp+rswtsY3V7SG8oxhYr4iIk/3cK3oGA+7iI4vJlORf7VUqrcyhL1D/RrJkrA
	NjrFpDst6ibUJCh4BrGQyxKgoNYQmok=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-uSGCrLExOweYLI-IhzraHA-1; Sun, 02 Jun 2024 15:49:41 -0400
X-MC-Unique: uSGCrLExOweYLI-IhzraHA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-35dcde1be6cso1799124f8f.1
        for <virtualization@lists.linux.dev>; Sun, 02 Jun 2024 12:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717357780; x=1717962580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bt+ZjDVXY3zkF1B/fEssYKB4/7ls0IVbAE3Y1l6PtqI=;
        b=ExowQ2W5druUZcL/sL7j0U4Y3NORncJnM0V4wUIUx6nxv8bojEu1ChNtvQ4fim/PiZ
         mgMtWAxKHyRBWNGThZEvb5Ffgqq8z1O4K+thhIz6/6T/tVqNGuQGvOJpuFktEgJWwUvG
         ugNu7fnm8wHstffVIET8yUgbjKDjp/+ozAWZCdU93gKWy/tBjlyw5HYLfadFfdjeMS9V
         QV734CL6XNSyPZpxAqptjEPVxisZ/cFVgDR01zRNHPhc9bYbPqlgNR/ntbLKH3Hzgseo
         iv0PL2nU2W7GCijKL4rMHEUe/X4EFk9DbxWZEOOo5tuTXT4Jmb4YMfrHAdknjN3B1wnM
         tHcw==
X-Forwarded-Encrypted: i=1; AJvYcCVl4gnqIDKtqTzt1K+2uea8i4ISFpI/nbTA5Gqrqvxj3oEHhEYEVJ0nDjF01aAFiB3ExFGQzrZb6qq54rFkPeDAyIM8x/fVB7KJyLiIoRc=
X-Gm-Message-State: AOJu0Ywb49bRulYbVBuCcX7R5lfaz9Fl8BjjPbgDbgJkSlgu0OBybit+
	NpUHat+/eEB72J+k1F38DXVySLKAyJR5vgV5BCPFRazVEDGOZUYvIgf2rHTpYWPk4gyRM5AIKF7
	SB5O1GpOrqDzIvsh3GWG0wyzfs2dN2PGh02bgKcPu3LWEsMVcfdhu/B6kfiksY380
X-Received: by 2002:adf:efd1:0:b0:354:f3eb:798f with SMTP id ffacd0b85a97d-35e0f271879mr5106919f8f.24.1717357780124;
        Sun, 02 Jun 2024 12:49:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaH6NHn486xmqFzkFGryjdeLFfTPdavIcViZsBWpSee643TdPvXLm6tIXLabuZQXKZG8g3eg==
X-Received: by 2002:adf:efd1:0:b0:354:f3eb:798f with SMTP id ffacd0b85a97d-35e0f271879mr5106902f8f.24.1717357779493;
        Sun, 02 Jun 2024 12:49:39 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:950b:d4e:f17a:17d8:5699])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35e574748ffsm1860549f8f.87.2024.06.02.12.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 12:49:38 -0700 (PDT)
Date: Sun, 2 Jun 2024 15:49:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 00/12] virtnet_net: prepare for af-xdp
Message-ID: <20240602154757-mutt-send-email-mst@kernel.org>
References: <20240530112406.94452-1-xuanzhuo@linux.alibaba.com>
 <20240530075003-mutt-send-email-mst@kernel.org>
 <1717203689.8004525-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1717203689.8004525-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 01, 2024 at 09:01:29AM +0800, Xuan Zhuo wrote:
> On Thu, 30 May 2024 07:53:17 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Thu, May 30, 2024 at 07:23:54PM +0800, Xuan Zhuo wrote:
> > > This patch set prepares for supporting af-xdp zerocopy.
> > > There is no feature change in this patch set.
> > > I just want to reduce the patch num of the final patch set,
> > > so I split the patch set.
> > >
> > > Thanks.
> > >
> > > v2:
> > >     1. Add five commits. That provides some helper for sq to support premapped
> > >        mode. And the last one refactors distinguishing xmit types.
> > >
> > > v1:
> > >     1. resend for the new net-next merge window
> > >
> >
> >
> > It's great that you are working on this but
> > I'd like to see the actual use of this first.
> 
> I want to finish this work quickly. I don't have a particular preference for
> whether to use a separate directory; as an engineer, I think it makes sense. I
> don't want to keep dwelling on this issue. I also hope that as a maintainer, you
> can help me complete this work as soon as possible. You should know that I have
> been working on this for about three years now.
> 
> I can completely follow your suggestion regarding splitting the directory.
> However, there will still be many patches, so I hope that these patches in this
> patch set can be merged first.
> 
>    virtio_net: separate virtnet_rx_resize()
>    virtio_net: separate virtnet_tx_resize()
>    virtio_net: separate receive_mergeable
>    virtio_net: separate receive_buf
>    virtio_net: refactor the xmit type
> 
> I will try to compress the subsequent patch sets, hoping to reduce them to about 15.
> 
> Thanks.


You can also post an RFC even if it's bigger than 15. If I see the use
I can start merging some of the patches.

> 
> >
> > >
> > > Xuan Zhuo (12):
> > >   virtio_net: independent directory
> > >   virtio_net: move core structures to virtio_net.h
> > >   virtio_net: add prefix virtnet to all struct inside virtio_net.h
> > >   virtio_net: separate virtnet_rx_resize()
> > >   virtio_net: separate virtnet_tx_resize()
> > >   virtio_net: separate receive_mergeable
> > >   virtio_net: separate receive_buf
> > >   virtio_ring: introduce vring_need_unmap_buffer
> > >   virtio_ring: introduce dma map api for page
> > >   virtio_ring: introduce virtqueue_dma_map_sg_attrs
> > >   virtio_ring: virtqueue_set_dma_premapped() support to disable
> > >   virtio_net: refactor the xmit type
> > >
> > >  MAINTAINERS                                   |   2 +-
> > >  drivers/net/Kconfig                           |   9 +-
> > >  drivers/net/Makefile                          |   2 +-
> > >  drivers/net/virtio/Kconfig                    |  12 +
> > >  drivers/net/virtio/Makefile                   |   8 +
> > >  drivers/net/virtio/virtnet.h                  | 248 ++++++++
> > >  .../{virtio_net.c => virtio/virtnet_main.c}   | 596 +++++++-----------
> > >  drivers/virtio/virtio_ring.c                  | 118 +++-
> > >  include/linux/virtio.h                        |  12 +-
> > >  9 files changed, 606 insertions(+), 401 deletions(-)
> > >  create mode 100644 drivers/net/virtio/Kconfig
> > >  create mode 100644 drivers/net/virtio/Makefile
> > >  create mode 100644 drivers/net/virtio/virtnet.h
> > >  rename drivers/net/{virtio_net.c => virtio/virtnet_main.c} (93%)
> > >
> > > --
> > > 2.32.0.3.g01195cf9f
> >

