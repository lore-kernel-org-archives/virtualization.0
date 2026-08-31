Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030CF3D9DDF
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 08:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788164320; cv=none; b=bP3/2bDrZxRh+tjBDtwZ+76Dbw1WDdMfMj4VN9L0OLwZCa/k3GSNkj82sK/dy3VfQpz3esyAACIRM07hhWdzVSuYBfVRyEEhOk1jVadcemqE7qUPO6w34jEDoyk/pqyxqp+/CPuU9hnI9+K9lJ8h6FYIwVvOohkQ/CBbAqWcrD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788164320; c=relaxed/simple;
	bh=FA91Z0TTWF8Jg5MST5f2D77GHmEYMdOhAhawJNJVwUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s0OqWOwH2kXaVooTGTiZaaZ/tDYADDACS4IrArb5RJOG77uDWegmwYoZvWKw8e6LfaRcoL2LO3IgF/93Jzndm6/9k909hURpyBgYmLN0H7EKNDWzJt4sgR5cpAtqHRJT2D7dq54s/OFaIDOVCPuc8vAjaqQwXIrjZgmjlhbYvKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i0OA4s9k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i0OA4s9k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788164318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FA91Z0TTWF8Jg5MST5f2D77GHmEYMdOhAhawJNJVwUs=;
	b=i0OA4s9kZjLkG37cdrGw+tPLkr5p+3CbXMjkJCfluND9eqx3QR+vdUCix7HSbhQZL4M0xr
	O0N0xM38+VlychAHuClABGwIEBWCZnxw2B+3LMftBCaJegJ3fkUNG+Tzt9WCQTlsfyJCMz
	1d+OnSTLMILUGr2gHF3/22sXXxmCW/M=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-xoXQhIwmN_mB5Df5GdZX4w-1; Mon, 31 Aug 2026 04:18:34 -0400
X-MC-Unique: xoXQhIwmN_mB5Df5GdZX4w-1
X-Mimecast-MFC-AGG-ID: xoXQhIwmN_mB5Df5GdZX4w_1788164314
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-8648f12d52aso10235657b3.0
        for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 01:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788164314; x=1788769114;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FA91Z0TTWF8Jg5MST5f2D77GHmEYMdOhAhawJNJVwUs=;
        b=bHujsZBnpRmHShcFDBFGcmLZ0PedyRExhb3ACgLdmUpjRhTtG9bak1wwCQUZgi4Ta4
         jiGMuMGijd37prXpXFhyHVmwtOtnqHgzPdiltK7vUOKwe6BVcG2Y3b2pLe/HchGskOo7
         Z4Uv88ugDEJwHWYkaUBOpcwPJEATDtEzfmCUm0E1xpfOv3M6RpF4C8hYCpm+jaO1vu27
         2ddZxtO31YzX3fZtdQ/XhiBkUbnVkLHPlaMKvqFXiVQqe3EY3AxdHb7kXPG5lxFBvMWZ
         LOJb4pqStMm9WFoN2vIsB9T/h8nKA1scaCfMBDLRmCkShp+uchmCBnoj008JI/0XR5ES
         BvMg==
X-Forwarded-Encrypted: i=1; AKwUvBzw0MVngB0aqKlNYsiI22I3s92fi8gjz1xfcqNcfN1UZJkpCb/HGl1EZPD0ofP92JdrGOpgDsYe3tNQdnUpEQ==@lists.linux.dev
X-Gm-Message-State: AFuF++k7PjRYxcBpoDvuhVsbPlBMRgjsymnGPmxqXQqZ3QKTX5SKMJF9
	jLsyJi0I+xfCS7u8qab/xV0yB8Y+UfT8qLmPdWBvZt4mUzYZl432v7KcbfyNb1c7gZt6t/O/51x
	hjLXnJiBxiJWHQPCFAI6OXsCrqAM7a79bu22AhPJaSKj+cxGCs/kcjoR0kf04ZTH41xPpJ9k2aU
	M0rGeH4Eq+E2dlVeOzylNfyZJouAe5CQLoWvr/BaCFQkQ=
X-Gm-Gg: AYBFou2vGyOeFBv2nXBmepWJcUO5rEeRhdrzVRGAjfAncrPJUfaamoMnjIRwRHr76wg
	R9GUKgqkrVAagUtQWQwAf1x1c4c0OgVaIVi0ahK6aMXLjgyQ0UmNXj1ASQ8wP7RJVq3rVQBg9H+
	rMg0B1ndBpdWtkxPcTLL1Skmyq3+r3oRQKAb0K/7mccVhw7l72DmAGrA8GltRrBMbLvdxkXDltu
	JW0OdvRaWnoPB06hS+GKW6daE5Mc/MP9XC745mGveYVhNCaJ0j54MAY0Pk=
X-Received: by 2002:a05:690c:d1c:b0:80e:c332:1796 with SMTP id 00721157ae682-864f424051cmr19065577b3.10.1788164313611;
        Mon, 31 Aug 2026 01:18:33 -0700 (PDT)
X-Received: by 2002:a05:690c:d1c:b0:80e:c332:1796 with SMTP id
 00721157ae682-864f424051cmr19065427b3.10.1788164313135; Mon, 31 Aug 2026
 01:18:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260818211425.91009-1-graf@amazon.com> <20260818211425.91009-5-graf@amazon.com>
 <CAJaqyWeGaoamHzYRd1ZVUJ+6fx_4RWDim+jLO964qKtgZ=zogQ@mail.gmail.com>
 <CAJaqyWe1fKBwBXXxHqDV676Uw03Pvr0uLizPmHKqm+sqmY_LgA@mail.gmail.com> <20260831022012-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260831022012-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 31 Aug 2026 10:17:56 +0200
X-Gm-Features: AcwNN1WheummLpWtW7LZn6dlmsoQ7mHWDchQmoKxwqk99R4q9CywoIs821OVsqM
Message-ID: <CAJaqyWc-a5orY1Rg2S_PmdPWt6gcGFM7-FyN4Pqk5hPd8vi0PQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] virtio_ring: return -ENOMEM when a packed ring
 mapping fails
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alexander Graf <graf@amazon.com>, Jason Wang <jasowangio@gmail.com>, nh-open-source@amazon.com, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Halil Pasic <pasic@linux.ibm.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OWMK9Ats7O_3SHVcfGWjqjpVmYMtAClXIOpxWj7_mh0_1788164314
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 8:21=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Aug 31, 2026 at 08:00:00AM +0200, Eugenio Perez Martin wrote:
> > On Wed, Aug 26, 2026 at 2:47=E2=80=AFPM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Tue, Aug 18, 2026 at 11:15=E2=80=AFPM Alexander Graf <graf@amazon.=
com> wrote:
> > > >
> > > > Commit f7728002c1c7 ("virtio_ring: fix return code on DMA mapping
> > > > fails") moved virtqueue_add_split() and virtqueue_add_indirect_pack=
ed()
> > > > to -ENOMEM, because virtio_queue_rq() maps -EIO to BLK_STS_IOERR an=
d
> > > > the request fails. We still return -EIO from virtqueue_add_packed()=
,
> > > > and virtqueue_add_packed_in_order() copied that when it was added l=
ater.
> > > >
> > > > Guests that bounce their I/O through swiotlb (SEV-SNP, TDX, s390 se=
cure
> > > > execution) run the pool out with enough I/O in flight. On a split r=
ing
> > > > virtio_queue_rq() reports BLK_STS_RESOURCE and the block layer requ=
eues
> > > > the request. On a packed ring virtio_queue_rq() reports BLK_STS_IOE=
RR
> > > > instead and the error reaches the filesystem.
> > > >
> > > > Return -ENOMEM from the packed unmap_release paths too. Both are re=
ached
> > > > from a single goto on a failed mapping, which is where
> > > > vring_map_one_sg() already produces -ENOMEM.
> > > >
> > > > That way every ring layout reports the same errno, and the block la=
yer
> > > > requeues the request instead of failing it.
> > > >
> > > > Fixes: f7728002c1c7 ("virtio_ring: fix return code on DMA mapping f=
ails")
> > > > Fixes: f6a15d854986 ("virtio_ring: add in order support")
> > >
> > > Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > >
> >
> > Even if I'd like to see this merged, I'm having second thoughts
> > because it introduces userland visible changes in some drivers. Are
> > them acceptable?
>
> I mean, fixing the kernel for the userspace is kinda what we do, right?
>

Yes, but changing error codes returned from the kernel to userland
always reminds me of this old thread so I wanted to give a heads up:

https://lkml.org/lkml/2012/12/23/75

Now I don't think we're in the same situation, though; probably no
userland app checks the actual errno in these operations. However, the
userland apps are not limited to VMMs; they include actual subsystem
users that do not know the backend is a virtio device, so the base is
large. If you still think that will not be a problem, I'm totally in
:).

Thanks!

