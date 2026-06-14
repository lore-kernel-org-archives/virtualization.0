Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E4E2848BA
	for <virtualization@lists.linux.dev>; Sun, 14 Jun 2026 19:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781465395; cv=none; b=I11Mm96lYgYU+CxiGbP3+6zJwsmKNt0utEqCVcif2Wg4nH7z5v65ZG4SvvK2i3eqtJv09l82SXgHk5TbmTSDgDg2bDRIWYjENrE7ngAOEKsQOR5vGG1k8axddzvdJDKKoKl/jutXTJAMlE4X5WBTPOtxFnmRb1/NrL7QDYY/D1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781465395; c=relaxed/simple;
	bh=CSg0YZ4b1saGbeK/3fq2xrN4WdQC6l/mdlg8Tzb8zlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UowuM6E2NFdsqZ8QCiVdSECpV7mTPYZFnEMRkTT2qrMhK6vDc/lbESRDaIoY0UtavYvrs8VggExd3COgekLntfUgUd6UR0XRllgCxpZaKP1w/7f8x3A+7VlkPoTFqHO4QBJVEZqTKNxBVDzX/lMDIMUv0/3zrg9BbxQsoZGDI18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iyq5T8U5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iyq5T8U5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781465392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vpgsCWY04Ero7XAmbrGxjHAhswt6Bct4cgGHg8NRGnY=;
	b=Iyq5T8U5fCWFVXiVWEEVdyFPZZ+eGFed9Dl15Qq5dAi/wAEJn/tpoQNBsCYz273XQZhl0B
	EyvVCcCkYFi3Qt8yEyiuHWinvOYwwxhmcLr1gA8/BYDH/csV0JkyGJG1AOPdzYwC3nRbM8
	3JheDOJMg53Nkj6jFn4kT51UWIsG+jc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-PBFKh-_6MmCcx-QqH2wxXg-1; Sun, 14 Jun 2026 15:29:51 -0400
X-MC-Unique: PBFKh-_6MmCcx-QqH2wxXg-1
X-Mimecast-MFC-AGG-ID: PBFKh-_6MmCcx-QqH2wxXg_1781465390
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490b7959b9fso25451665e9.2
        for <virtualization@lists.linux.dev>; Sun, 14 Jun 2026 12:29:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781465390; x=1782070190;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vpgsCWY04Ero7XAmbrGxjHAhswt6Bct4cgGHg8NRGnY=;
        b=JRyXfFTu2xICpzsqPoQE8KGp8b1RE10rNiu/Aof6kYFOOLGLpJ7whxBxs2rog4n3jw
         DA8HF+zwTQeLftyI0BAAOTUGt684xBH3b653KNyLkj+y5+suLlh/B7YI3LXq6xCOKMzf
         lAIsm0FCF1Hq0CTzLIkQ4EAvP3S8+q0dhVn3YnHzbIl4kmP6PiFfT6+r8csDDSfUOVoB
         eEruxBdYT68kcpGqp+lugCTsYwfRU1jgi9zXV9sMG55j/SGcwjAeDttO7rlVfsnKsW86
         a2TUpAQ3iuMtXTRk+ApM4Nbu+uOaPMFmGzLnUgK1IdTgfb6xVdJTVHVNFGGw5NP4eVSD
         MYWQ==
X-Forwarded-Encrypted: i=1; AFNElJ/dud13TbK11byIoVAy+IniVBIIumDmhWRE1HPtvzyrOq8m+FIVXyhrEQpvxoQrAE6UM5cJpi+yEItx62Pnsw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrK6CeWOEdaIdNbNfQaEb49VhMkev6LWNdWm174n51gnah+g3l
	kpJNOm5bLYO2h9uHOxd+pvh2ARkjgTkxaqcILtajCd4pCRoqgvgzdEqXbDqeIGt1sdjCq+4h26O
	gLzsDgVtjH6KT9qa2lDk5mK24OeFBBkPoAZeFV0E4srfn4Tg0b/Z70X4HrqRtPC647pI/
X-Gm-Gg: Acq92OFzW74nXunSd9EoOVb9cIBOdb5m0V/F81ICXFNxsZNNfqut0DeVQrSsYrDIYvw
	TQP2i32ZuC3j8AG7AyEyH7nyPf3G+YgkRBZp4ccQTrJsjy9q8+xX1338rvCNlxm9z56Vex8ksjM
	xNV/xGUD6L6A4TdKFMzINnnR63Rx8HMvwyQt11hL0oh+hDiA6nMqvhNk718k48tg0ftkzeNu6f6
	JrLW1ovlZAf6DRr7lA6QAgnbcoLzbo4CpZK12kOA/1wLOXUep/0vnO6LTAv0qqK1209nyiCcyyK
	ZxJBYTcFBEe7gnwSx/tQxiFhtcF2uwM7GIW33xf3q2jd21uXr0ycS0gOEnDJGq9W7dc/uEnFT4Y
	Vp7TqKpuM3rPooifk3kb3SmrWFZIubbeFf2o86PS5dC8=
X-Received: by 2002:a05:600c:c3dc:20b0:490:adb6:793d with SMTP id 5b1f17b1804b1-490ec4fbd85mr106061955e9.26.1781465390235;
        Sun, 14 Jun 2026 12:29:50 -0700 (PDT)
X-Received: by 2002:a05:600c:c3dc:20b0:490:adb6:793d with SMTP id 5b1f17b1804b1-490ec4fbd85mr106061735e9.26.1781465389701;
        Sun, 14 Jun 2026 12:29:49 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922031b7d2sm198939285e9.5.2026.06.14.12.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 12:29:49 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:29:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	minhquangbui99@gmail.com, bestswngs@gmail.com
Subject: Re: [PATCH net v3] virtio-net: fix len check in receive_big()
Message-ID: <20260614152904-mutt-send-email-mst@kernel.org>
References: <20260611024616.1408317-1-xmei5@asu.edu>
 <20260611014519-mutt-send-email-mst@kernel.org>
 <CAPpSM+Q=NM0WeBmZvyOEkyx73VU10AOHQjPbWDSet675B7AnCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAPpSM+Q=NM0WeBmZvyOEkyx73VU10AOHQjPbWDSet675B7AnCA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8F4DWI2ZRSLGNvS-aQn-TV6EmqesHE4OPudrSF3W1_E_1781465390
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sat, Jun 13, 2026 at 01:15:02PM -0700, Xiang Mei wrote:
> On Wed, Jun 10, 2026 at 10:56 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Jun 10, 2026 at 07:46:16PM -0700, Xiang Mei wrote:
> > > receive_big() bounds the device-announced length by
> > > (big_packets_num_skbfrags + 1) * PAGE_SIZE.  That is still too loose:
> > > add_recvbuf_big() sets sg[1] to start at offset
> > > sizeof(struct padded_vnet_hdr) into the first page, so the chain
> > > actually carries hdr_len + (PAGE_SIZE - sizeof(padded_vnet_hdr)) +
> > > big_packets_num_skbfrags * PAGE_SIZE bytes -- 20 bytes less than the
> > > check allows for the common hdr_len == 12 case.
> > >
> > > A malicious virtio backend can announce a len in that gap.  page_to_skb()
> > > then walks one frag past the page chain, storing a NULL page->private
> > > into skb_shinfo()->frags[MAX_SKB_FRAGS], which is both an out-of-bounds
> > > write past the static frag array and a NULL frag handed up the rx path.
> > >
> > > Bound len by the size add_recvbuf_big() actually advertised.
> > >
> > > Fixes: 0c716703965f ("virtio-net: fix received length check in big packets")
> > > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >
> > Thanks for the patch! Something small to improve:
> >
> > > ---
> > > v3: revoke 2/2 and add Xuan Zhuo's Reviewed-by tag
> > >
> > >  drivers/net/virtio_net.c | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index f4adcfee7a80..afe73eda1491 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -1999,15 +1999,17 @@ static struct sk_buff *receive_big(struct net_device *dev,
> > >                                  struct virtnet_rq_stats *stats)
> > >  {
> > >       struct page *page = buf;
> > > +     unsigned long max_len;
> >
> > Assignment can happen here?
> >
> > >       struct sk_buff *skb;
> > >
> > >       /* Make sure that len does not exceed the size allocated in
> > >        * add_recvbuf_big.
> > >        */
> > > -     if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE)) {
> > > +     max_len = vi->hdr_len + (PAGE_SIZE - sizeof(struct padded_vnet_hdr)) +
> > > +               vi->big_packets_num_skbfrags * PAGE_SIZE;
> >
> > Took me a while to figure out what is going on, but I finally
> > understand:
> >
> >
> > Reducing
> > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE
> >
> > (what we allocated)
> >
> > by sizeof(struct padded_vnet_hdr) - vi->hdr_len
> >
> >
> > right?
> >
> > So clearer as:
> >
> >
> >         unsigned long max_len = (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE -
> >         sizeof(struct padded_vnet_hdr) + vi->hdr_len;
> >
> Right, that's the same value. Yours reads better!
> 
> I'll fold this into the next respin. One thing I'd like to settle
> first: David suggested storing this in a vi field computed once at the
> probe (it's a per-device constant) and just comparing len against it
> on the datapath, instead of re-deriving it in receive_big() each time.
> I'll wait for his take on that and send a single v4 that covers both.
> 
> Xiang

I don't mind.

> >
> >
> >
> > > +     if (unlikely(len > max_len)) {
> > >               pr_debug("%s: rx error: len %u exceeds allocated size %lu\n",
> > > -                      dev->name, len,
> > > -                      (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE);
> > > +                      dev->name, len, max_len);
> > >               goto err;
> > >       }
> > >
> > > --
> > > 2.43.0
> >

