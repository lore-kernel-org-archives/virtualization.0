Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6DE2FF65F
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 10:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788172447; cv=none; b=mxaOS928eMZ0sAh8eoBS/cWd7x6TZU8z4hwvsbkhPLnS84vD9RxO1TcSQ8i/d8OKKSPoWu6S/r5K4nal9CUZoLLpeB9c3tamyo9ykb448TU1++TaGA/wDMedq17rA50b/5dvSogOX8CaPFRNJ8+QzMrkwT+MkmPKM8y6d0s1X0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788172447; c=relaxed/simple;
	bh=EX0YETTdFugbFzcLbfaQoqmRAze/QrxuCiP5oYer/s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SmfmXgDXzOgEqLE2YBCfseNe8ukPq4iBZWnVShMEu1+zbEcEddHybG3/lDqPw3TIlqkXspWMYRtY4vnCGAY43wfJZDn1y6sGNFuqogi4YgsmwhhfDzERl+oOVoHg4DfokGW+0GOwUI3xwqAgdfHm20PUX3IjzsHEwWWrbMxqoN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RZ/SuPfu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RZ/SuPfu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788172434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YBfPage1ADEAqab+x6qmBvM3J+29ZPsFF3WCYCZQTV8=;
	b=RZ/SuPfuvO6Rmw6G5NgZX4dyBLTq6lSlF7s61SEubtRxe5xMRvEogSWdoMbSRFI6N1QfQw
	jr0wDHKTGreZqNP1GISkv6aI3JGw1jiy/hPeQAJ5OflVbRcFW1bOx16V3kafJ0Pk25km+E
	dYhGX9IKLbW1Ba/SgvXzNYPGaAbFOiw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-TMPdT9QOMm2ZlFktOt2nbQ-1; Mon, 31 Aug 2026 06:33:51 -0400
X-MC-Unique: TMPdT9QOMm2ZlFktOt2nbQ-1
X-Mimecast-MFC-AGG-ID: TMPdT9QOMm2ZlFktOt2nbQ_1788172430
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49a1b4ea633so30200135e9.0
        for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 03:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788172430; x=1788777230;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YBfPage1ADEAqab+x6qmBvM3J+29ZPsFF3WCYCZQTV8=;
        b=KREfeWyJv155h/iqmCDGI4Ci7lbkqh4hZ9KhL18bvNBXYRcOZEkbZCfLud+gMR43TZ
         1woRmZqU09qcnlknwSIv9pF5NaVrXtr+YhU0GIeHTyc6OXaJm+WyVTJsnKDzUc5DJtYI
         u94wiv1Cx6kC1uSO8yZk1WfqtoX+lwl6Xr/u2j95Xf//PMvHxfF2SWaz6lQ1++pAhnzW
         jOY9p2mcYu3ytRiFG9jjqjWL3nEPQo9lLPE0RKoozjV6jGVw5ICt40KED5PvndpfFZx9
         nui0bMqLnG9Uargp7EXmkWBtT0MZeGUOue95sV5yKT/r5y7DIDZHF9hy1jmAnNqhdRvN
         uf0w==
X-Forwarded-Encrypted: i=1; AHgh+Rr2VNESlkWxkLD7ABpKAxlRSEkUwzdl9e7uoWqNeINFGtDr9EL2vOppuup2vR4takzZeoeFueTp/v85Rkwsvw==@lists.linux.dev
X-Gm-Message-State: AFuF++mnXRAgSTnckvv4safy0fDiJo10KEcqQhj40q7BHDMLXKioAPrB
	V4Z/MlHiraJH17h9rZxz2/hd27FiKT5hMGuUZytXLqdjjcjhZZq9W9rbRwHzQeuEIdk/IV89Lfh
	wuXqGy2tyYL+gM046I2Ys9v+UjmaEaJsq6TTbg+KIKc2ceXyoP83HXX7cvGlCPnNxjMfd
X-Gm-Gg: AR+sD12FQZvDjD9rpPf4SoFulixir5wZqH4xN1rjQOEREfJ/nM92VMXGaSn5+wYvS3/
	McWUCLgvM/Afq+ifeFzBL2H+m2shXJrItyXbfgvrQVX6+Z1n++T1jdRWSCaobunCVOw4hHOls92
	lNt71paLNKYdcEiuIF9XbB6BRd5jRKhbZ7snDNDWxmsZ6Ffhxe1nGl/5+i6OYHDqZRNOApxnG9j
	ttrKw/VOHXk29W3XPoRKhNOnxZuIA+RG98ScqVLXcpQDAhx867DtV9L7iq5DWwKWXo4m/PEw+ms
	GTihQ3A5hf6NkwFwaxkV3/Zc9NGjFGT7PXdl/Bp//uizYskR/c4YPCfVFWFdJafKWoET9CenP3G
	ymu0qw25/gCITezsMFC755lY=
X-Received: by 2002:a05:600c:8b35:b0:498:943:ccc0 with SMTP id 5b1f17b1804b1-49cd9485480mr35259285e9.6.1788172430022;
        Mon, 31 Aug 2026 03:33:50 -0700 (PDT)
X-Received: by 2002:a05:600c:8b35:b0:498:943:ccc0 with SMTP id 5b1f17b1804b1-49cd9485480mr35258205e9.6.1788172429407;
        Mon, 31 Aug 2026 03:33:49 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cca1ed292sm217449405e9.8.2026.08.31.03.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 03:33:48 -0700 (PDT)
Date: Mon, 31 Aug 2026 06:33:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Alexander Graf <graf@amazon.com>, Jason Wang <jasowangio@gmail.com>,
	nh-open-source@amazon.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Halil Pasic <pasic@linux.ibm.com>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 04/12] virtio_ring: return -ENOMEM when a packed ring
 mapping fails
Message-ID: <20260831063307-mutt-send-email-mst@kernel.org>
References: <20260818211425.91009-1-graf@amazon.com>
 <20260818211425.91009-5-graf@amazon.com>
 <CAJaqyWeGaoamHzYRd1ZVUJ+6fx_4RWDim+jLO964qKtgZ=zogQ@mail.gmail.com>
 <CAJaqyWe1fKBwBXXxHqDV676Uw03Pvr0uLizPmHKqm+sqmY_LgA@mail.gmail.com>
 <20260831022012-mutt-send-email-mst@kernel.org>
 <CAJaqyWc-a5orY1Rg2S_PmdPWt6gcGFM7-FyN4Pqk5hPd8vi0PQ@mail.gmail.com>
 <20260831042123-mutt-send-email-mst@kernel.org>
 <CAJaqyWcRwoAWMU9EQE-qDNmpzjc4xheU4Y+MxTx2EF8vP6wEKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWcRwoAWMU9EQE-qDNmpzjc4xheU4Y+MxTx2EF8vP6wEKg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9pu64C9HWIEPxNaZA7cFJNvB4KIVuUO15KcIUwtfkK8_1788172430
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Aug 31, 2026 at 12:04:57PM +0200, Eugenio Perez Martin wrote:
> On Mon, Aug 31, 2026 at 10:22 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Aug 31, 2026 at 10:17:56AM +0200, Eugenio Perez Martin wrote:
> > > On Mon, Aug 31, 2026 at 8:21 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Mon, Aug 31, 2026 at 08:00:00AM +0200, Eugenio Perez Martin wrote:
> > > > > On Wed, Aug 26, 2026 at 2:47 PM Eugenio Perez Martin
> > > > > <eperezma@redhat.com> wrote:
> > > > > >
> > > > > > On Tue, Aug 18, 2026 at 11:15 PM Alexander Graf <graf@amazon.com> wrote:
> > > > > > >
> > > > > > > Commit f7728002c1c7 ("virtio_ring: fix return code on DMA mapping
> > > > > > > fails") moved virtqueue_add_split() and virtqueue_add_indirect_packed()
> > > > > > > to -ENOMEM, because virtio_queue_rq() maps -EIO to BLK_STS_IOERR and
> > > > > > > the request fails. We still return -EIO from virtqueue_add_packed(),
> > > > > > > and virtqueue_add_packed_in_order() copied that when it was added later.
> > > > > > >
> > > > > > > Guests that bounce their I/O through swiotlb (SEV-SNP, TDX, s390 secure
> > > > > > > execution) run the pool out with enough I/O in flight. On a split ring
> > > > > > > virtio_queue_rq() reports BLK_STS_RESOURCE and the block layer requeues
> > > > > > > the request. On a packed ring virtio_queue_rq() reports BLK_STS_IOERR
> > > > > > > instead and the error reaches the filesystem.
> > > > > > >
> > > > > > > Return -ENOMEM from the packed unmap_release paths too. Both are reached
> > > > > > > from a single goto on a failed mapping, which is where
> > > > > > > vring_map_one_sg() already produces -ENOMEM.
> > > > > > >
> > > > > > > That way every ring layout reports the same errno, and the block layer
> > > > > > > requeues the request instead of failing it.
> > > > > > >
> > > > > > > Fixes: f7728002c1c7 ("virtio_ring: fix return code on DMA mapping fails")
> > > > > > > Fixes: f6a15d854986 ("virtio_ring: add in order support")
> > > > > >
> > > > > > Acked-by: Eugenio Pérez <eperezma@redhat.com>
> > > > > >
> > > > >
> > > > > Even if I'd like to see this merged, I'm having second thoughts
> > > > > because it introduces userland visible changes in some drivers. Are
> > > > > them acceptable?
> > > >
> > > > I mean, fixing the kernel for the userspace is kinda what we do, right?
> > > >
> > >
> > > Yes, but changing error codes returned from the kernel to userland
> > > always reminds me of this old thread so I wanted to give a heads up:
> > >
> > > https://lkml.org/lkml/2012/12/23/75
> > >
> > > Now I don't think we're in the same situation, though; probably no
> > > userland app checks the actual errno in these operations. However, the
> > > userland apps are not limited to VMMs; they include actual subsystem
> > > users that do not know the backend is a virtio device, so the base is
> > > large. If you still think that will not be a problem, I'm totally in
> > > :).
> > >
> > > Thanks!
> >
> > Well actual subsystem users for sure expect EIO on actual io errors no?
> >
> 
> Yes, but code like drivers/scsi/virtio_scsi.c:virtscsi_queuecommand in
> the kernel explicitely checks for -EIO, and had a different code path
> to handle it than -ENOMEM. Even if both are valid, the visible
> behavior of the code changes.

For the better.

> My fear here is that we have similar
> code in userland that we don't handle. I admit it is not very likely,
> and I actually prefer making both split and packed to return the same
> ERRNO, so if you're ok with the change I'm ok too.

