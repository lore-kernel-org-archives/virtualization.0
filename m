Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2703D1CAD
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 08:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788164566; cv=none; b=RzD1mq5CbFt5BJtT9NvpPuh4Ye9aRyq9TYzGk9k1YauUEAAHC3/2b61qYLptyE3zqpU2hOabSDr0VJSTIL4j+trlOM76GkCDNamgN0bhYb2KaWCcaXkmWFBKBZSXdhZbKiXhCSiBhUmoKsPSpB6M1atvllNjq0vYDWmW+f4kI4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788164566; c=relaxed/simple;
	bh=ewcFfqU8CqD6R09UPqNsBXPaWuT6EWWWC1rlaEeomq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=E79JLg2RNCkz2WU4ZXyGvvSuZc55ZT4kNdGGHKvFjX9iB8KndCYohm48KIBvKGFEXWcVWw+1PYXa++7TeF7EwQXUpRZys8v8P5c07il1meS3ajalThb1eAAa9mXhiEek07Ys7Kbb1ImP1d2RuHcwAhw3AYOa46Nstyxy7SOYsh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QqDIHK2r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QqDIHK2r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788164564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VPHstyAOOWZWJ4A5+/zkt6f6u2lf2fP9VtPqxWkdkUg=;
	b=QqDIHK2rXDCyFkMmbiVq6ap2SmvTFDZcZ/fFTBTCwgaie0psL5E52s3MdeUWk7JZbptIbK
	KN7bAWlMKAinO/sFXssh8vSpx9aUTy0RGtr4/92hwda6gwULA65jPsdvVBbguKz/h3XSAv
	PcTYS7lOY8h10avDTgOKeW0PvEmvw9Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-5OZOntbHNVmnUiF4MBbQBQ-1; Mon, 31 Aug 2026 04:22:41 -0400
X-MC-Unique: 5OZOntbHNVmnUiF4MBbQBQ-1
X-Mimecast-MFC-AGG-ID: 5OZOntbHNVmnUiF4MBbQBQ_1788164560
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-482e8e1ac69so2108198f8f.0
        for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 01:22:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788164560; x=1788769360;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VPHstyAOOWZWJ4A5+/zkt6f6u2lf2fP9VtPqxWkdkUg=;
        b=ruMz56MF600bRHvXY0s5ZdJYSqBuHD16VG8hqg7MdhgPfJ/cvR8iQ9dr18rPneYJxO
         j9NhkNL6pME9mIEgr2m1emGymddrnsrZEr7Z2Fp/P9MJ27f6/mn6AdJ9KolWFSEtUYqb
         jHkpyw9hB9AJ8YKoMIZzsSNFXv7TxIjeUea7ACulkmwasTj2kVHsbeMpdyCEFD038eW2
         nYL76IRZ56mGXfF92ufg1ukIlvz4I8zE0IfyM8PmWnvfRsj74oXtM326PlXuY7L/kF+i
         MiWkwkqoM3rNMZgqw6vgwHmrpnivT3JI2QfJQN/UURSp2ubMvGfew/ARNQE7T9iNPgWo
         vdFg==
X-Forwarded-Encrypted: i=1; AKwUvBx3wooNQi0Ec73HJ7Km/yL9E1f5xc43t0bg/B5r2YJ61nEr5IDos1CIcsTiNObpKuYaU8jnu3cHARinVoKyjg==@lists.linux.dev
X-Gm-Message-State: AFuF++l7riIeThjjYPRpFEqQdVwdyr7P1cYYFk2t1+eM6wivIkZ1lQcX
	ie8b6iFZG5zNjp7HunmSfliweIF8ODF6ATJECYI0v/CC0an7hpPfeoH7s6oOZb/l5B+LXSrDmjD
	tgSs8SvPwxoRfefq8osjdTkNKMtwE0bI4Z2Z4O9dM1jX11tcScbwJGSYhKMJu9f2mIoM1
X-Gm-Gg: AYBFou0H2NyG5ylrWAx4A9Ds9goJSlydLEGw46a0sj0mOuRvbDwyhnUYkpl9E3RlFHR
	m6EC3km7RI8DmegWZL1gs3WD6/t0spy7WFdZLSeM629/8aK+QBs/Mjd+0/wUBtGWYP9oiSJmlN5
	xnD7yHZW15UePcfp6EEfR4AFY8WoAVI4rHpdMkTzoqEj8OpwNavEwxQyR6QO5HDLZmIrC9zljnU
	ef7o0z+GCxf0NA+/w1kpEBe+BWgAd1YEPGm9tHTFGYkjZeC+Zusxq4qgVut7w8xvyQ4QsTbZHgr
	TIVX7dCNp9e3XOCU9wORvZXqASHcaJ+kCUTYJ8xSuKSLwRRaoa3d776G2+Nr26MD7a3sSi6a6VC
	DO2iWVWvTKqdCDt9MCZcWX4M=
X-Received: by 2002:a05:6000:4b18:b0:47f:8cd3:4bed with SMTP id ffacd0b85a97d-484397969b4mr11533805f8f.5.1788164559862;
        Mon, 31 Aug 2026 01:22:39 -0700 (PDT)
X-Received: by 2002:a05:6000:4b18:b0:47f:8cd3:4bed with SMTP id ffacd0b85a97d-484397969b4mr11533708f8f.5.1788164559100;
        Mon, 31 Aug 2026 01:22:39 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbab3f16sm23490350f8f.1.2026.08.31.01.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 01:22:38 -0700 (PDT)
Date: Mon, 31 Aug 2026 04:22:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Alexander Graf <graf@amazon.com>, Jason Wang <jasowangio@gmail.com>,
	nh-open-source@amazon.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Halil Pasic <pasic@linux.ibm.com>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 04/12] virtio_ring: return -ENOMEM when a packed ring
 mapping fails
Message-ID: <20260831042123-mutt-send-email-mst@kernel.org>
References: <20260818211425.91009-1-graf@amazon.com>
 <20260818211425.91009-5-graf@amazon.com>
 <CAJaqyWeGaoamHzYRd1ZVUJ+6fx_4RWDim+jLO964qKtgZ=zogQ@mail.gmail.com>
 <CAJaqyWe1fKBwBXXxHqDV676Uw03Pvr0uLizPmHKqm+sqmY_LgA@mail.gmail.com>
 <20260831022012-mutt-send-email-mst@kernel.org>
 <CAJaqyWc-a5orY1Rg2S_PmdPWt6gcGFM7-FyN4Pqk5hPd8vi0PQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWc-a5orY1Rg2S_PmdPWt6gcGFM7-FyN4Pqk5hPd8vi0PQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OFpRL6Hg4gEBTKl0GQTHJIFgeq2Qo1Rojr1BkQc4E34_1788164560
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Aug 31, 2026 at 10:17:56AM +0200, Eugenio Perez Martin wrote:
> On Mon, Aug 31, 2026 at 8:21 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Aug 31, 2026 at 08:00:00AM +0200, Eugenio Perez Martin wrote:
> > > On Wed, Aug 26, 2026 at 2:47 PM Eugenio Perez Martin
> > > <eperezma@redhat.com> wrote:
> > > >
> > > > On Tue, Aug 18, 2026 at 11:15 PM Alexander Graf <graf@amazon.com> wrote:
> > > > >
> > > > > Commit f7728002c1c7 ("virtio_ring: fix return code on DMA mapping
> > > > > fails") moved virtqueue_add_split() and virtqueue_add_indirect_packed()
> > > > > to -ENOMEM, because virtio_queue_rq() maps -EIO to BLK_STS_IOERR and
> > > > > the request fails. We still return -EIO from virtqueue_add_packed(),
> > > > > and virtqueue_add_packed_in_order() copied that when it was added later.
> > > > >
> > > > > Guests that bounce their I/O through swiotlb (SEV-SNP, TDX, s390 secure
> > > > > execution) run the pool out with enough I/O in flight. On a split ring
> > > > > virtio_queue_rq() reports BLK_STS_RESOURCE and the block layer requeues
> > > > > the request. On a packed ring virtio_queue_rq() reports BLK_STS_IOERR
> > > > > instead and the error reaches the filesystem.
> > > > >
> > > > > Return -ENOMEM from the packed unmap_release paths too. Both are reached
> > > > > from a single goto on a failed mapping, which is where
> > > > > vring_map_one_sg() already produces -ENOMEM.
> > > > >
> > > > > That way every ring layout reports the same errno, and the block layer
> > > > > requeues the request instead of failing it.
> > > > >
> > > > > Fixes: f7728002c1c7 ("virtio_ring: fix return code on DMA mapping fails")
> > > > > Fixes: f6a15d854986 ("virtio_ring: add in order support")
> > > >
> > > > Acked-by: Eugenio Pérez <eperezma@redhat.com>
> > > >
> > >
> > > Even if I'd like to see this merged, I'm having second thoughts
> > > because it introduces userland visible changes in some drivers. Are
> > > them acceptable?
> >
> > I mean, fixing the kernel for the userspace is kinda what we do, right?
> >
> 
> Yes, but changing error codes returned from the kernel to userland
> always reminds me of this old thread so I wanted to give a heads up:
> 
> https://lkml.org/lkml/2012/12/23/75
> 
> Now I don't think we're in the same situation, though; probably no
> userland app checks the actual errno in these operations. However, the
> userland apps are not limited to VMMs; they include actual subsystem
> users that do not know the backend is a virtio device, so the base is
> large. If you still think that will not be a problem, I'm totally in
> :).
> 
> Thanks!

Well actual subsystem users for sure expect EIO on actual io errors no?

