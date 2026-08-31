Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455A2345EDD
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 10:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788172810; cv=none; b=Kzan/Ruuzychs1GI/rzHzuBui+NzMAsAeILo4+8HyyNp7fbpqfrWN3utO4P7VyQO/xbJwdhdKyRwYVh4a1xU3yqlcZQQwAZLYJ8rnjkzSD9+UA7XsL9YhwxHM9wGelSO1sgCh7ZvSKV5QjY51V83qlGfF+9Gg1Zz4ETdNayvcPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788172810; c=relaxed/simple;
	bh=zPd7uNGErn7MGI9vtI7+1qSA8cY6vjT2EFeY8ANUrWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NUiQofuuTMw1pr10xFFsChWCnRGKhqENZuCYgVZvBbSVbFw93iH2TcMnjOrLdLhk4aKu/b3qFquLGaDE5WiNOOBW7ilF1ZCrrE5rD/0v7wllVSr7pJqQ1VfQEAue9WCGGM8Kyw/yVeY1OehoiRvHkN/xrv6EAhzUdf389/rpvaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OYsY9u9J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OYsY9u9J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788172808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zPd7uNGErn7MGI9vtI7+1qSA8cY6vjT2EFeY8ANUrWs=;
	b=OYsY9u9J9jB89dcyyf5MlAgTd9uCtDjabnUbox4Z7dTdGqYozjqHzxZOuA20xvrejpjNUF
	xLtAvrO8Neztaf6CdpSxePA0/Ymc0j+pULSTWr2MMyg7FHF9I2KHaySq7ncMJ1EjyO9SFN
	xGFMo4X/ppeIEeNnINQEGJVa/R/2Qpc=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-KKmDrPkJMVmYPersIoG1kg-1; Mon, 31 Aug 2026 06:40:05 -0400
X-MC-Unique: KKmDrPkJMVmYPersIoG1kg-1
X-Mimecast-MFC-AGG-ID: KKmDrPkJMVmYPersIoG1kg_1788172805
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-837aaa9a3f6so62973237b3.0
        for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 03:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788172805; x=1788777605;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zPd7uNGErn7MGI9vtI7+1qSA8cY6vjT2EFeY8ANUrWs=;
        b=Qw2mKyfyZXPeG2QMcBAz3ELQzbssg5nD+ikGBz5rhVnYWDJFA8FqlmyOsmHnlxybo0
         421Ywwz9tisy9+R7cKKSVK+UlzZxY3KUvj2jnAr/9rYtSOwEN0HUET1PrSBGUu0u9KPA
         K4pfcDBgo/ZBAWwg/++Qj+DYMHlF4CaY3eONZ4DZ8sCGGbuyNA9GPnndh+SiT3j/Ig8r
         9PXo6GRyFqXTp67IpV38spcgajg+RvjOqbVFNNvP5jDo3a+AU8yLB1DmBlo7+0If6xyr
         92lXn0mFlVTZqFBR6g9Jm/im+ICnec052w24VDdDnjqKyU18X7s8fuYa9ARFtXxPxj9I
         nu2Q==
X-Forwarded-Encrypted: i=1; AKwUvBybmJVawq/rGg0u8YRsTOw6uTl+AH4OfxXHn8oyd9MauIrHO2WSRZGVJnc4fdqiXjXb+E2uUX7jzhFaymPHFA==@lists.linux.dev
X-Gm-Message-State: AFuF++naWx1AN9GFnv79LAzTR+gubULV12Akxe2H4/hDR+ALY7xMMEm2
	rXpNQqEgloF8gU3aRUo0i600f3tFG48nmoyR/aHwsUjQ1rr/WgoUtKiZYAGNYiKbCAS6580uFEc
	YvPx3ru8u+A32AmxK6wuQ5ACGtFwN5k9jgpaZ6YA/E8mi/q6qDjWQ3FheVG0EcCecbg2cVgRKJT
	0r505WjPxq5mkvThUm+ub6OsEOD91iWgsWdX0Pfs4qxdE=
X-Gm-Gg: AYBFou1j/e0oEu02v/jCVWiaQuZdATw/wvcLD12ghZ8cjys30KNnrYgkHoZUoG8gz6x
	HG5WWPgS0k7LmDcS8DegAire9m3Mp/d3pmbPHBqac7os9IjyzclIYYFMy7wxXVffi4WjTktEPG6
	XbTvIvljprn26nZUbqlKburUx6NNsmgTlLoOi3nRNJANDZ2ZAAV8lNB/at6f171ux0a/7Ruhh1W
	Ty3zH2Mk4Kakh1lE6/vrYpkg5yv5ChOI5GR5/Wax0ZLPeUOHHQUkxrVLws=
X-Received: by 2002:a05:690c:309:b0:834:fadf:6050 with SMTP id 00721157ae682-864f57aea38mr31053067b3.16.1788172805054;
        Mon, 31 Aug 2026 03:40:05 -0700 (PDT)
X-Received: by 2002:a05:690c:309:b0:834:fadf:6050 with SMTP id
 00721157ae682-864f57aea38mr31052797b3.16.1788172804630; Mon, 31 Aug 2026
 03:40:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260818211425.91009-1-graf@amazon.com> <20260818211425.91009-5-graf@amazon.com>
 <CAJaqyWeGaoamHzYRd1ZVUJ+6fx_4RWDim+jLO964qKtgZ=zogQ@mail.gmail.com>
 <CAJaqyWe1fKBwBXXxHqDV676Uw03Pvr0uLizPmHKqm+sqmY_LgA@mail.gmail.com>
 <20260831022012-mutt-send-email-mst@kernel.org> <CAJaqyWc-a5orY1Rg2S_PmdPWt6gcGFM7-FyN4Pqk5hPd8vi0PQ@mail.gmail.com>
 <20260831042123-mutt-send-email-mst@kernel.org> <CAJaqyWcRwoAWMU9EQE-qDNmpzjc4xheU4Y+MxTx2EF8vP6wEKg@mail.gmail.com>
 <20260831063307-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260831063307-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 31 Aug 2026 12:39:28 +0200
X-Gm-Features: AcwNN1XqixT9XX9ulqXuds_8-rOHhQ_YFOF-lOx_ulmYah9DsENr0BDNXy5BV5c
Message-ID: <CAJaqyWfKK7A2mgi1uJ_DqF-XhAsXOGmko19emTwdFfQEhrCX0g@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] virtio_ring: return -ENOMEM when a packed ring
 mapping fails
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alexander Graf <graf@amazon.com>, Jason Wang <jasowangio@gmail.com>, nh-open-source@amazon.com, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Halil Pasic <pasic@linux.ibm.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Q11dqbs3eOurO3EcjKDU1UFpFWwUmajtk5yHsM2Lh_4_1788172805
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 12:33=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Mon, Aug 31, 2026 at 12:04:57PM +0200, Eugenio Perez Martin wrote:
> > On Mon, Aug 31, 2026 at 10:22=E2=80=AFAM Michael S. Tsirkin <mst@redhat=
.com> wrote:
> > >
> > > On Mon, Aug 31, 2026 at 10:17:56AM +0200, Eugenio Perez Martin wrote:
> > > > On Mon, Aug 31, 2026 at 8:21=E2=80=AFAM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Mon, Aug 31, 2026 at 08:00:00AM +0200, Eugenio Perez Martin wr=
ote:
> > > > > > On Wed, Aug 26, 2026 at 2:47=E2=80=AFPM Eugenio Perez Martin
> > > > > > <eperezma@redhat.com> wrote:
> > > > > > >
> > > > > > > On Tue, Aug 18, 2026 at 11:15=E2=80=AFPM Alexander Graf <graf=
@amazon.com> wrote:
> > > > > > > >
> > > > > > > > Commit f7728002c1c7 ("virtio_ring: fix return code on DMA m=
apping
> > > > > > > > fails") moved virtqueue_add_split() and virtqueue_add_indir=
ect_packed()
> > > > > > > > to -ENOMEM, because virtio_queue_rq() maps -EIO to BLK_STS_=
IOERR and
> > > > > > > > the request fails. We still return -EIO from virtqueue_add_=
packed(),
> > > > > > > > and virtqueue_add_packed_in_order() copied that when it was=
 added later.
> > > > > > > >
> > > > > > > > Guests that bounce their I/O through swiotlb (SEV-SNP, TDX,=
 s390 secure
> > > > > > > > execution) run the pool out with enough I/O in flight. On a=
 split ring
> > > > > > > > virtio_queue_rq() reports BLK_STS_RESOURCE and the block la=
yer requeues
> > > > > > > > the request. On a packed ring virtio_queue_rq() reports BLK=
_STS_IOERR
> > > > > > > > instead and the error reaches the filesystem.
> > > > > > > >
> > > > > > > > Return -ENOMEM from the packed unmap_release paths too. Bot=
h are reached
> > > > > > > > from a single goto on a failed mapping, which is where
> > > > > > > > vring_map_one_sg() already produces -ENOMEM.
> > > > > > > >
> > > > > > > > That way every ring layout reports the same errno, and the =
block layer
> > > > > > > > requeues the request instead of failing it.
> > > > > > > >
> > > > > > > > Fixes: f7728002c1c7 ("virtio_ring: fix return code on DMA m=
apping fails")
> > > > > > > > Fixes: f6a15d854986 ("virtio_ring: add in order support")
> > > > > > >
> > > > > > > Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > >
> > > > > >
> > > > > > Even if I'd like to see this merged, I'm having second thoughts
> > > > > > because it introduces userland visible changes in some drivers.=
 Are
> > > > > > them acceptable?
> > > > >
> > > > > I mean, fixing the kernel for the userspace is kinda what we do, =
right?
> > > > >
> > > >
> > > > Yes, but changing error codes returned from the kernel to userland
> > > > always reminds me of this old thread so I wanted to give a heads up=
:
> > > >
> > > > https://lkml.org/lkml/2012/12/23/75
> > > >
> > > > Now I don't think we're in the same situation, though; probably no
> > > > userland app checks the actual errno in these operations. However, =
the
> > > > userland apps are not limited to VMMs; they include actual subsyste=
m
> > > > users that do not know the backend is a virtio device, so the base =
is
> > > > large. If you still think that will not be a problem, I'm totally i=
n
> > > > :).
> > > >
> > > > Thanks!
> > >
> > > Well actual subsystem users for sure expect EIO on actual io errors n=
o?
> > >
> >
> > Yes, but code like drivers/scsi/virtio_scsi.c:virtscsi_queuecommand in
> > the kernel explicitely checks for -EIO, and had a different code path
> > to handle it than -ENOMEM. Even if both are valid, the visible
> > behavior of the code changes.
>
> For the better.
>

Yes, I agree on that :). So, if you're ok with the change,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

