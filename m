Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB9E242D6A
	for <virtualization@lists.linux.dev>; Thu, 29 May 2025 02:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748485427; cv=none; b=je+4q7NaLVvdZiOf7B0qNC84x4qWLAQOcYVGy6M45nBwQ5I+1TzywJGYqgHewWBw6B3HlCcBv9NehjKaDs4ypq9ep/GzF2LrMIqboCu7JpD27wKcRZfdGGArrZx581iJkGoC8YuzcQs57s9TNTf9jQ4YKkm1bBTbryACBvReLrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748485427; c=relaxed/simple;
	bh=8QP2bAPt4AJKcTljc8zaWDC7qeLtgVJNoRtLBeWnfto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pIcb5EbGgzfLdBQBo1yllbHDJ176MzfguNCC9JJqIVaatmHO5yBORK/K3ycavYN84A6spTYkFuAftdri7WQVFGndEN5PE5QTFPApLB+OARfi77skKJc1qCzvsQmF6qGWhRs6Ufg257tQjtlJqK4/9GzOZfTRHD+IUwOXST84Ccs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KvIMUw+q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KvIMUw+q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748485424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4pAhwizCUFXp7MX+Ed3OCbEQsG/dB7EmiP8FGYlOO1o=;
	b=KvIMUw+qXIPxe8UT4DBO0n6U8kL1lFA3ZzANGSitwcHnxToqFWWHv/wSzb8dyK3THeJTdw
	5f0KJLiGVhGTr0nAQXKUFtPyIFKN+xNWidB+AO8bTRJB8H+u3tudgDqVzDZD0OopO+TnYn
	XliPAO41Frn4l9ce6uqkn3vFpxU/Pxk=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-LaDghyBrPQyPdSIywF1Brg-1; Wed, 28 May 2025 22:23:40 -0400
X-MC-Unique: LaDghyBrPQyPdSIywF1Brg-1
X-Mimecast-MFC-AGG-ID: LaDghyBrPQyPdSIywF1Brg_1748485419
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b2c3e576201so1337241a12.0
        for <virtualization@lists.linux.dev>; Wed, 28 May 2025 19:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748485419; x=1749090219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4pAhwizCUFXp7MX+Ed3OCbEQsG/dB7EmiP8FGYlOO1o=;
        b=fcYLWFcKl+IqJJGipXwLLcNT5Isc2eFHrs0XaD1bD5AC/SHxU074UVucl8R9c9Yn6A
         CvuIoC+YnsgBffB4pCDIXfNsD+8+I9OV9riNUF8ghKMPMq7VCDe6tEw1F7Zs0+4q/FfA
         5ranZkU2wh9nKRBqtMchgPVOAEeTPDuTaGmhTg64DRqg9gFmZ48Djq58mZWZ6/1d8f40
         8fR+3ePhYMShs2Vx18Y9ELyzFI3HafRl3FLWc9RDh6f+480H+nDznvGd46vMZQTpmJog
         YrDCP40b5NDXmhyI7cLFHGicU82Si2MTfvrZ5+E5nXAMyUrLAtjHsSIr0C/wrUFVFCdq
         Q2aw==
X-Forwarded-Encrypted: i=1; AJvYcCW7dXIOus6Vioz9sdFCcjstIs/l3oQt5471K8JzgNB5v6Fu1GADvO+QsA/QP1i6b8sRD1czOmEtM323ipFOfw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyf2P8MDKNVXfvZRP+aGn2P6jc0g7XFu3S7vQt7cg0OJpWOt0Ht
	fYPDh4AE6uh01GUYv+LnPVDqGXV+yBQTIEc8xpQ4kjqKbePz7vdUgyWVMAP76F6rq58kUQv7Sbt
	2rH1EHwnckKM1pCkeFJ91F21QiuYPiarCKGuuMiwAMSy8HAfz+bnFglFDcJmyJV1LLM+cEBKFut
	Dz4HHS2FPNCR+UIdAQ99rciz/iEBdrXwWjs84Hw3GoFik=
X-Gm-Gg: ASbGncsyqOFKBZc+/1Vraq6fBLVafx8fd3h9hiFx7eBjYqqFxn9n06n9Alx5JWc6goj
	ctqdeuAGRkJm1qNCTR57bpmjxzgbrKM1uFgo09BuWQgPcni42+dha82r9iKQiSWaMZ5S1DQ==
X-Received: by 2002:a17:90b:2dc7:b0:311:b413:f5ce with SMTP id 98e67ed59e1d1-31214e91a5amr2442913a91.16.1748485419308;
        Wed, 28 May 2025 19:23:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbJMI07EpZilkM5JxdiosTizQrqYZyB/qRtI+w/FM5dBmfqE//T38u8vud/Cj9lDN3v2/ob0WOSKOvTGd//g0=
X-Received: by 2002:a17:90b:2dc7:b0:311:b413:f5ce with SMTP id
 98e67ed59e1d1-31214e91a5amr2442889a91.16.1748485418879; Wed, 28 May 2025
 19:23:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250528064234.12228-1-jasowang@redhat.com> <20250528084904-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250528084904-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 29 May 2025 10:23:27 +0800
X-Gm-Features: AX0GCFsWi2hAyo6cMAwsnlFmTUQ9cJ_sIixNLHLmIggVmxpTlfOkzhhCr9jarhs
Message-ID: <CACGkMEsd_Actjat0cjDdLW01ent8OgBCGjgwkP2UFFX+5rhOQw@mail.gmail.com>
Subject: Re: [PATCH V2 00/19] virtio_ring in order support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vR1PmPJbjSlysJK5fTmURdwew01rB5_B9kwthRqLUTQ_1748485419
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 8:51=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, May 28, 2025 at 02:42:15PM +0800, Jason Wang wrote:
> > Hello all:
> >
> > This sereis tries to implement the VIRTIO_F_IN_ORDER to
> > virtio_ring. This is done by introducing virtqueue ops so we can
> > implement separate helpers for different virtqueue layout/features
> > then the in-order were implemented on top.
> >
> > Tests shows 3%-5% imporvment with packed virtqueue PPS with KVM guest
> > testpmd on the host.
>
> ok this looks quite clean. We are in the merge window so not merging new
> intrusive stuff, but after rc2 or so pls ping me I will put it in next.

Ok, I will post a new v3 at that time since build bot found an issue.

Thanks

>
> > Changes since V1:
> >
> > - use const global array of function pointers to avoid indirect
> >   branches to eliminate retpoline when mitigation is enabled
> > - fix used length calculation when processing used ids in a batch
> > - fix sparse warnings
> >
> > Please review.
> >
> > Thanks
> >
> > Jason Wang (19):
> >   virtio_ring: rename virtqueue_reinit_xxx to virtqueue_reset_xxx()
> >   virtio_ring: switch to use vring_virtqueue in virtqueue_poll variants
> >   virtio_ring: unify logic of virtqueue_poll() and more_used()
> >   virtio_ring: switch to use vring_virtqueue for virtqueue resize
> >     variants
> >   virtio_ring: switch to use vring_virtqueue for virtqueue_kick_prepare
> >     variants
> >   virtio_ring: switch to use vring_virtqueue for virtqueue_add variants
> >   virtio: switch to use vring_virtqueue for virtqueue_add variants
> >   virtio_ring: switch to use vring_virtqueue for enable_cb_prepare
> >     variants
> >   virtio_ring: use vring_virtqueue for enable_cb_delayed variants
> >   virtio_ring: switch to use vring_virtqueue for disable_cb variants
> >   virtio_ring: switch to use vring_virtqueue for detach_unused_buf
> >     variants
> >   virtio_ring: use u16 for last_used_idx in virtqueue_poll_split()
> >   virtio_ring: introduce virtqueue ops
> >   virtio_ring: determine descriptor flags at one time
> >   virtio_ring: factor out core logic of buffer detaching
> >   virtio_ring: factor out core logic for updating last_used_idx
> >   virtio_ring: factor out split indirect detaching logic
> >   virtio_ring: factor out split detaching logic
> >   virtio_ring: add in order support
> >
> >  drivers/virtio/virtio_ring.c | 896 ++++++++++++++++++++++++++---------
> >  1 file changed, 684 insertions(+), 212 deletions(-)
> >
> > --
> > 2.31.1
>

