Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702841A5BA3
	for <virtualization@lists.linux.dev>; Sun, 18 May 2025 21:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747604105; cv=none; b=l2WYvf912BJxtJkywEOq5JwcpervzTWWR+VzxbOddKbeHUHcgsph3Pk/Jokix4kd7gg0JHGUC7+8mUBF3DZI+BkgFPRIzp5sIPqqEiM8Y6DZ/tjgdS6ji34U6egUHfersrZugoYS/b85I0BkkeGuuOD4UFy2EzCncQJ93r+SPjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747604105; c=relaxed/simple;
	bh=i0UDS7ryfYcPCMwpdiJCN/3dodGTDQwtvPmmnU5MzBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YhTde5oblLNgGDMN8zT5/5LztyLWODgXlByRGigLY+hKlLaSzZFz6fvs2KzoNUFg093hhPOtwJyZBy6CEYURaKaGK34XN2sGX3Lf8ckFEAqCDheLMuelatfVPlR391c635ZuhMp4jcl31IENo5nJwJMTwWKMlSU/63GG2rAonSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NST0I6VL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NST0I6VL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747604101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HAhV+nhTtB3oWTNdnOV38bF76ng9ASrCOJfLirGrigw=;
	b=NST0I6VLRt9/PLIVQieLr93Ca4j9e72GHuxmC/zn40nqPrgDYIguOWW5qNds+1mO9gghdv
	4eUn1XajAjnfiDSwR55NofNkm9zPWH9QbQ6x9v4NXZgYacuta0RtncieSUWQmB+eelkWh7
	xwYReL4CiTqmO4fo/YH0PZWn3gw1Jqo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-bfYTjnzqP-auLwHoK0vE9w-1; Sun, 18 May 2025 17:34:59 -0400
X-MC-Unique: bfYTjnzqP-auLwHoK0vE9w-1
X-Mimecast-MFC-AGG-ID: bfYTjnzqP-auLwHoK0vE9w_1747604099
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cf172ffe1so29207155e9.3
        for <virtualization@lists.linux.dev>; Sun, 18 May 2025 14:34:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747604098; x=1748208898;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HAhV+nhTtB3oWTNdnOV38bF76ng9ASrCOJfLirGrigw=;
        b=VUYNR1GISVFDI+tp5aqZCEh6P+6gHgjgYVRQBKga1lWWoxoAJGPslwfwLO5u6UumCj
         afebr+Q4J+xjing1A641coBOIR66lgFt0/MnU5j8TUgfPK//+TsDmkCyFc3sGSX1yJJz
         AmQMwyDejlW2DxjGlzSJcYJ2+5BQ9Hjo9r5piwt29+OnsgNkG07OsmcQSh35FfvXxz2n
         zrhlgR6BXHD7hJqz4Ev4gd6VZRD3FNww4t5RUdU7+3+zwJ14Iig1h1evIJzAUMhjxViK
         a2yGNbeludOJtsY8qDHL0fIQJKUx1JIPDDQz7irOeUOhCB8fewMszyd4dA92FKPNA9Iv
         v5gg==
X-Forwarded-Encrypted: i=1; AJvYcCWopf4iRq8KMNd7wfAgbXetfLqIo74XPdA38EEl+n/ezqV19FGiMRlw9w4FmPucHD20eaz3cSpy7KowMgw1Hg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzGBATVoLNK7M0ikgXtJJXY9ubx8sF5yt5NRcCWQCTg+mmIO4LT
	Pqrrx8dMXYtRjjcaoul6Z24/63JfTGn/HIcfPkFSnCh7vkQY22wAl049NN/c7lgqIP9AdLY9Mrg
	LpVjR/DN5jJbHYGeLZXno8RZYN/xBCwaOm+8HtEZSLuk2tGUNndouAULUtK0xWsXyHBF0
X-Gm-Gg: ASbGncuFuDejqo3A2Akg0ODcz2017ymSp80oWs8H9NR5Jm/4ke9a2WhNEa28jwUOXho
	tqOJaPf3nPuSmoBDiujYbSM9C4lyagI57PKqkm2DBMCe0Bkku/xRFzbqQiIkrTAGXfXCAtwIe6P
	LYpM3aKvhWXO+Q2Lpkp7lHJqdBetHBbNtQssL7SXnUnx3qH006qABo+8OCHGmutNl/aue7L1GUQ
	KsWt+7iC1FVmmf/NUU95AZnvzoTfuCM44/EQKX/nUCe7TX7RMaBc9Z4ln370zQ3LYlD1onKezAh
	LRIerQ==
X-Received: by 2002:a05:600c:890b:b0:442:ffaa:6681 with SMTP id 5b1f17b1804b1-442ffaa6b6fmr59316755e9.28.1747604098620;
        Sun, 18 May 2025 14:34:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1oH302delN9nxpqrLIprfMWk3Ho5eH4z0R+50eE4GeFmN2TZ6xrwqN7ULXYhrVRrz8ClBGw==
X-Received: by 2002:a05:600c:890b:b0:442:ffaa:6681 with SMTP id 5b1f17b1804b1-442ffaa6b6fmr59316695e9.28.1747604098314;
        Sun, 18 May 2025 14:34:58 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f9053b4dsm144106535e9.4.2025.05.18.14.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 14:34:57 -0700 (PDT)
Date: Sun, 18 May 2025 17:34:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/19] virtio_ring in order support
Message-ID: <20250518173443-mutt-send-email-mst@kernel.org>
References: <20250324054333.1954-1-jasowang@redhat.com>
 <CAPpAL=x4BWNh__YpzkzpErkseh04FT7WNLmg=xMXtfZ0S9BabQ@mail.gmail.com>
 <CAJaqyWdtKEYiY2tBB0F477LqxVs8fzaix96551WSMa=KdT3C5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWdtKEYiY2tBB0F477LqxVs8fzaix96551WSMa=KdT3C5Q@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: n1GOMbWleFzOHEaZgkJ1k2w5mnFw5CMDdnAIC7mjOSE_1747604099
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Mar 26, 2025 at 07:39:47AM +0100, Eugenio Perez Martin wrote:
> On Mon, Mar 24, 2025 at 3:44 PM Lei Yang <leiyang@redhat.com> wrote:
> >
> > QE tested this series of patches with virtio-net regression tests,
> > everything works fine.
> >
> 
> Hi Lei,
> 
> Is it possible to test this series also with virtio-net-pci,...,in_order=on?
> 
> Thanks!


Lei, what do you think?

> > Tested-by: Lei Yang <leiyang@redhat.com>
> >
> > On Mon, Mar 24, 2025 at 1:45 PM Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > Hello all:
> > >
> > > This sereis tries to implement the VIRTIO_F_IN_ORDER to
> > > virtio_ring. This is done by introducing virtqueue ops so we can
> > > implement separate helpers for different virtqueue layout/features
> > > then the in-order were implmeented on top.
> > >
> > > Tests shows 5% imporvemnt in RX PPS with KVM guest + testpmd on the
> > > host.
> > >
> > > Please review.
> > >
> > > Thanks
> > >
> > > Jason Wang (19):
> > >   virtio_ring: rename virtqueue_reinit_xxx to virtqueue_reset_xxx()
> > >   virtio_ring: switch to use vring_virtqueue in virtqueue_poll variants
> > >   virtio_ring: unify logic of virtqueue_poll() and more_used()
> > >   virtio_ring: switch to use vring_virtqueue for virtqueue resize
> > >     variants
> > >   virtio_ring: switch to use vring_virtqueue for virtqueue_kick_prepare
> > >     variants
> > >   virtio_ring: switch to use vring_virtqueue for virtqueue_add variants
> > >   virtio: switch to use vring_virtqueue for virtqueue_add variants
> > >   virtio_ring: switch to use vring_virtqueue for enable_cb_prepare
> > >     variants
> > >   virtio_ring: use vring_virtqueue for enable_cb_delayed variants
> > >   virtio_ring: switch to use vring_virtqueue for disable_cb variants
> > >   virtio_ring: switch to use vring_virtqueue for detach_unused_buf
> > >     variants
> > >   virtio_ring: use u16 for last_used_idx in virtqueue_poll_split()
> > >   virtio_ring: introduce virtqueue ops
> > >   virtio_ring: determine descriptor flags at one time
> > >   virtio_ring: factor out core logic of buffer detaching
> > >   virtio_ring: factor out core logic for updating last_used_idx
> > >   virtio_ring: move next_avail_idx to vring_virtqueue
> > >   virtio_ring: factor out split indirect detaching logic
> > >   virtio_ring: add in order support
> > >
> > >  drivers/virtio/virtio_ring.c | 856 ++++++++++++++++++++++++++---------
> > >  1 file changed, 653 insertions(+), 203 deletions(-)
> > >
> > > --
> > > 2.42.0
> > >
> > >
> >

