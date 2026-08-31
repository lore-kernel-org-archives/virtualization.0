Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7673515E9
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 10:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170741; cv=none; b=IbOu85cL9112YM/xSu7rRYjmvwHlOb+Djo1Z3yeMdAIXamgFjC+X9N/p5P2lDP6zd7gM66S32mtJlBQzM/8Ify8ywSbot+Lad7kffxgkVLOz96bsX7SOU2DQb5SNqDZbOAj669AAsIqdvlTKEn1E5Mu127Jl7FoG0GyJhkKpN6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170741; c=relaxed/simple;
	bh=CuN+bOp7XPvvUDBhgRONwpopOkvVIRZtG41BqdWZ5/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UOVwmtGwgMaxEA+2L2QV/ERxx8ss4hUJpqa8mSCelSGaOH3xm8xiUaEmp3rldlLhkyPgLl0px704yIvvPvgzaKIopWxJ/PVxUo7VerHC/hSyk2pDxgv154yhV5JQrI6hzetx6vHZ7pVlk0RnpRgGNqzxuce+m/2oBu0O/0nVgh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IKV1Mguo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IKV1Mguo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788170738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CuN+bOp7XPvvUDBhgRONwpopOkvVIRZtG41BqdWZ5/A=;
	b=IKV1MguoMID20Zxy7XAYulkem2ZE7n10xK1d16fqVV4KoC8y5tKd1T8NoxpbGcl+llu3kY
	wl8VmfcaCFQl/S0+7pNsl8dFhYZtW9GMOQMDiNxMEjTOTrdyfyBQYzY5qyuRq21Ooo08cp
	wpsF8wjAjb7dtnB7Ibwny/aj6PzVyyw=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-c39xIEfmP8uCtpR0RngRLA-1; Mon, 31 Aug 2026 06:05:36 -0400
X-MC-Unique: c39xIEfmP8uCtpR0RngRLA-1
X-Mimecast-MFC-AGG-ID: c39xIEfmP8uCtpR0RngRLA_1788170736
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-822ce245c5aso47350697b3.1
        for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 03:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788170736; x=1788775536;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CuN+bOp7XPvvUDBhgRONwpopOkvVIRZtG41BqdWZ5/A=;
        b=YFJ3c0grlkoeAo6mlathOtVnsO6ihrOfjZX0pyzo4lmSjItx1rT1AnIjIuh/VCjVL2
         g2t22xB9EKkurmzKRJBFCBrQ4OlCQykyBh4N3QDLn+/AP1bDHi6FmtO2ZOZCoxKj0tOL
         o1wspj9UFz4IfZWWwV9hYtXnG9XF5nEP08B6FqUKzmCAT81EW6gdFwX3eqn1Rfx/J2By
         qJ5tPLS8azIQTCfyAdQRcB2mxNs//EDzFbmHI5UsPhp2d6XmHIK6xkSfYeW6rrN2InUo
         1I0h3s1PmjbPpTv1D8/yTouLo1NvUD9uL71ExZmAaMjBglwdBR5EA3ZZVIzR6kbschE2
         II1Q==
X-Forwarded-Encrypted: i=1; AKwUvBwI/hE5mGmsl3szlT9V773sg8RphUAwDBTFsXH8ZVAgPDPjC234bA93y+4fx8yBEOgaLV+I/VgWsDNxkgF1ew==@lists.linux.dev
X-Gm-Message-State: AFuF++mWT7DYxK8bgazWVgQa2rSLT86/DHfx+At7k35FZLTAo/VLqly2
	p5uoraScYZk5Ho+sdsrozafatYyIU3AzJGfUNxVGnXKDqBkkq7iurh11qf2bPCQ+9qpOAMm6mON
	/9/F2TdhIR9nPgvM4sbP68lxELxRhpNffvKBJY1tx3y4Pv/Nuz/KMycqmqYP2afXE7bQwbyEGCs
	VNuDusGD6C3M2Rqy8ULMZC/V0E9r9ohZe5yRcaYcZ2YL0=
X-Gm-Gg: AYBFou2VdWtBZKvWIO/2GjF9M13i/pQ5XgC2k3L9dfD0NtqyidzM7rpmSFMgzijVodC
	/hhxycGilQ5WQF/RjNAjGohn3nt3JUo2ATWG+HtxQlytmcvGM4Oj8w2pzAHL4bDCKwaGihXruYX
	OGva41pLv2R/3e1SqSYFwWwEzSD4h1qOPy1b8C8VNiBVd/Ii+utHrf+D6lz5tj5XCMlPeYYt88w
	jPwxst9ruZYg7aiVoyY9MlwprxYIj9DSgxixeopczVp3w3tEiIbIDvFfpI=
X-Received: by 2002:a05:690c:85:b0:81f:238a:1709 with SMTP id 00721157ae682-85d7055d29bmr74565987b3.34.1788170735842;
        Mon, 31 Aug 2026 03:05:35 -0700 (PDT)
X-Received: by 2002:a05:690c:85:b0:81f:238a:1709 with SMTP id
 00721157ae682-85d7055d29bmr74565757b3.34.1788170735365; Mon, 31 Aug 2026
 03:05:35 -0700 (PDT)
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
 <20260831042123-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260831042123-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 31 Aug 2026 12:04:57 +0200
X-Gm-Features: AcwNN1VlIGzZbrNlA6oR2V3j0xwPLBh0QARcrVS5gn5j0el32_TFBhTZtzi0e84
Message-ID: <CAJaqyWcRwoAWMU9EQE-qDNmpzjc4xheU4Y+MxTx2EF8vP6wEKg@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] virtio_ring: return -ENOMEM when a packed ring
 mapping fails
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alexander Graf <graf@amazon.com>, Jason Wang <jasowangio@gmail.com>, nh-open-source@amazon.com, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Halil Pasic <pasic@linux.ibm.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cQUgg2Q-4wLdoe3WaoTPWzLB3feow78dDW5giRGCkK0_1788170736
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 10:22=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Mon, Aug 31, 2026 at 10:17:56AM +0200, Eugenio Perez Martin wrote:
> > On Mon, Aug 31, 2026 at 8:21=E2=80=AFAM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Mon, Aug 31, 2026 at 08:00:00AM +0200, Eugenio Perez Martin wrote:
> > > > On Wed, Aug 26, 2026 at 2:47=E2=80=AFPM Eugenio Perez Martin
> > > > <eperezma@redhat.com> wrote:
> > > > >
> > > > > On Tue, Aug 18, 2026 at 11:15=E2=80=AFPM Alexander Graf <graf@ama=
zon.com> wrote:
> > > > > >
> > > > > > Commit f7728002c1c7 ("virtio_ring: fix return code on DMA mappi=
ng
> > > > > > fails") moved virtqueue_add_split() and virtqueue_add_indirect_=
packed()
> > > > > > to -ENOMEM, because virtio_queue_rq() maps -EIO to BLK_STS_IOER=
R and
> > > > > > the request fails. We still return -EIO from virtqueue_add_pack=
ed(),
> > > > > > and virtqueue_add_packed_in_order() copied that when it was add=
ed later.
> > > > > >
> > > > > > Guests that bounce their I/O through swiotlb (SEV-SNP, TDX, s39=
0 secure
> > > > > > execution) run the pool out with enough I/O in flight. On a spl=
it ring
> > > > > > virtio_queue_rq() reports BLK_STS_RESOURCE and the block layer =
requeues
> > > > > > the request. On a packed ring virtio_queue_rq() reports BLK_STS=
_IOERR
> > > > > > instead and the error reaches the filesystem.
> > > > > >
> > > > > > Return -ENOMEM from the packed unmap_release paths too. Both ar=
e reached
> > > > > > from a single goto on a failed mapping, which is where
> > > > > > vring_map_one_sg() already produces -ENOMEM.
> > > > > >
> > > > > > That way every ring layout reports the same errno, and the bloc=
k layer
> > > > > > requeues the request instead of failing it.
> > > > > >
> > > > > > Fixes: f7728002c1c7 ("virtio_ring: fix return code on DMA mappi=
ng fails")
> > > > > > Fixes: f6a15d854986 ("virtio_ring: add in order support")
> > > > >
> > > > > Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > >
> > > >
> > > > Even if I'd like to see this merged, I'm having second thoughts
> > > > because it introduces userland visible changes in some drivers. Are
> > > > them acceptable?
> > >
> > > I mean, fixing the kernel for the userspace is kinda what we do, righ=
t?
> > >
> >
> > Yes, but changing error codes returned from the kernel to userland
> > always reminds me of this old thread so I wanted to give a heads up:
> >
> > https://lkml.org/lkml/2012/12/23/75
> >
> > Now I don't think we're in the same situation, though; probably no
> > userland app checks the actual errno in these operations. However, the
> > userland apps are not limited to VMMs; they include actual subsystem
> > users that do not know the backend is a virtio device, so the base is
> > large. If you still think that will not be a problem, I'm totally in
> > :).
> >
> > Thanks!
>
> Well actual subsystem users for sure expect EIO on actual io errors no?
>

Yes, but code like drivers/scsi/virtio_scsi.c:virtscsi_queuecommand in
the kernel explicitely checks for -EIO, and had a different code path
to handle it than -ENOMEM. Even if both are valid, the visible
behavior of the code changes. My fear here is that we have similar
code in userland that we don't handle. I admit it is not very likely,
and I actually prefer making both split and packed to return the same
ERRNO, so if you're ok with the change I'm ok too.

