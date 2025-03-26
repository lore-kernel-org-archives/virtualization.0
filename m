Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53777191499
	for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 06:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742971234; cv=none; b=jA8ORdk+70X73Oo55mBoeWlJnzB8VsvrM8xVGntPUnC+w9d9OmxMf2GwBiMDwz4NMJONn9sPVQ8JabhbtM66DvNbAU8kD6OV59N+hzTUuK40WPaG5FKcVKwjCgzKZRwwdfwqCvC1+z+efJrdnkOYFv30B8cUy0/vbVSDEisG/Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742971234; c=relaxed/simple;
	bh=6q09F5c4pHQQSvnekcl2wDEjLn2OddB7yXpI33oM3j8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WYDtCHNwyCjwAqzMMMJqvmm0cGEnCxIewpI4WXwpFApOq/gyoWZX4eF6d1ZilczYYinsuf96H9biLV3jA3Cr7KhXr8WG2IKRbWxG7DtPkD+dIfCIJ/FFp597S+gXieHN2/In8X3hGyH44hWGyhIMYPADwrSODQ3w7qSMNCVtEyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=anjHkXYP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="anjHkXYP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742971231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ezHVFsZe1v4BDvN1xzAQ5TFbS1moNinE5s1cTaUBmso=;
	b=anjHkXYPVKuX1hhyZYEAdNbkPP4gSmI6jnpGtiOuzuZ7ao7IPi2HwDkriFY7gs5fFhG0l0
	TKLR6YssbzIBlqjlZFc+MzsnwmbTVPBC8uLvh+Zhhb3JmgdKvPPGqAc5vHg0miygA97vu7
	wTEtW+DV1EInsV65v0Awl3DuaF8ir+g=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-AKAmUNGrPBuNoaaVJMsoEw-1; Wed, 26 Mar 2025 02:40:25 -0400
X-MC-Unique: AKAmUNGrPBuNoaaVJMsoEw-1
X-Mimecast-MFC-AGG-ID: AKAmUNGrPBuNoaaVJMsoEw_1742971224
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff58318acaso18216291a91.0
        for <virtualization@lists.linux.dev>; Tue, 25 Mar 2025 23:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742971224; x=1743576024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ezHVFsZe1v4BDvN1xzAQ5TFbS1moNinE5s1cTaUBmso=;
        b=tGeJdGsQa/qJ45T4ANsfh0BqQt22/4Zt/bCWcI3XLcqYUv9z6kCqkTOMfCo0s/a5c4
         9+0oYTvxGe7Jazdyuzi1R8x29hFewUqZaRXbV5uRPtA54ZWVM+838uxWyijr3Fll67EF
         BBWv5SKDrNdQqSZ1wmRRCo1+f50o6xk/cWQ58sdgFkRsT3Eau/BO8gQ8+7v6PlnYfxfo
         W68EX4VAzvsXl860i7+bY5WQWeXOpMPl+UxfcItdRoICKMGGO4c6kfqnZmir33P8N+3d
         vVtZes30pg62FxKJaya3F6B6uaFFo4UiGfD8UZ0m15Yv7CT8lbPqbG9Fgpzlgl1N/R6Z
         17/g==
X-Forwarded-Encrypted: i=1; AJvYcCW6zTgOXkX4RxAiyxpc6SM21m7Dqos8EAwnWxrLntif8iYL/HwNfnPPIatcaIDrGKPjOfyRYGjK6T//qcnFXw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxUsFYyPor8i0t4aSq6KbVVZPmDteUkaFwZmGf/ZRn+btPR7pIM
	yZaFf8IqXUe6bmk+pqOSUymCjaKidFosyvMOb2gnUapJLT02TkcDI/xJriN7CoaVkyLsBTZxtId
	Y2+djqzlKuIO+x/3iCb4gGOQFzEhE4Zrc9Ll0IYWA2y/PRmoYBzC7Oro0rllrPMT7WDwaJgHzpx
	NSKtzUbLsIcHLlLn+mBf+6gTDi50OJmPLZNAkR9P0=
X-Gm-Gg: ASbGncvWoCZUXWePg3Cg9ecWlk1rlTt9f1ymubER6yRj4XG/RnBP+/Sh7q5IKu/A4Co
	AQ/mw8RsiDPzF464Z2T3mECUCgYKL2CiVqypB0nH0GeUNV+17M7xObgkCv/bCLQ99AW9d60w=
X-Received: by 2002:a17:90b:1d51:b0:2ff:62f3:5b31 with SMTP id 98e67ed59e1d1-3030ff06711mr31920767a91.29.1742971224330;
        Tue, 25 Mar 2025 23:40:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFUGcW4JXSeMZI46/HJNxiBTQIzR50w5i1JUFe2fdLyrEXV1sMUCl3RQeMRWq9Y5cXb5aVu+LPH0QeOT9MfrA=
X-Received: by 2002:a17:90b:1d51:b0:2ff:62f3:5b31 with SMTP id
 98e67ed59e1d1-3030ff06711mr31920735a91.29.1742971223830; Tue, 25 Mar 2025
 23:40:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com> <CAPpAL=x4BWNh__YpzkzpErkseh04FT7WNLmg=xMXtfZ0S9BabQ@mail.gmail.com>
In-Reply-To: <CAPpAL=x4BWNh__YpzkzpErkseh04FT7WNLmg=xMXtfZ0S9BabQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 07:39:47 +0100
X-Gm-Features: AQ5f1JqS06N3aPblaGlfScL2r-BwUXS_ZG-zwaqN3wVN6CTRzZJOuSitX0ZLN4Q
Message-ID: <CAJaqyWdtKEYiY2tBB0F477LqxVs8fzaix96551WSMa=KdT3C5Q@mail.gmail.com>
Subject: Re: [PATCH 00/19] virtio_ring in order support
To: Lei Yang <leiyang@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qH9nMzRnAdPKR51C1wmKnCZVzySSHZeyn1IXfvHOAJc_1742971224
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 3:44=E2=80=AFPM Lei Yang <leiyang@redhat.com> wrote=
:
>
> QE tested this series of patches with virtio-net regression tests,
> everything works fine.
>

Hi Lei,

Is it possible to test this series also with virtio-net-pci,...,in_order=3D=
on?

Thanks!

> Tested-by: Lei Yang <leiyang@redhat.com>
>
> On Mon, Mar 24, 2025 at 1:45=E2=80=AFPM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > Hello all:
> >
> > This sereis tries to implement the VIRTIO_F_IN_ORDER to
> > virtio_ring. This is done by introducing virtqueue ops so we can
> > implement separate helpers for different virtqueue layout/features
> > then the in-order were implmeented on top.
> >
> > Tests shows 5% imporvemnt in RX PPS with KVM guest + testpmd on the
> > host.
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
> >   virtio_ring: move next_avail_idx to vring_virtqueue
> >   virtio_ring: factor out split indirect detaching logic
> >   virtio_ring: add in order support
> >
> >  drivers/virtio/virtio_ring.c | 856 ++++++++++++++++++++++++++---------
> >  1 file changed, 653 insertions(+), 203 deletions(-)
> >
> > --
> > 2.42.0
> >
> >
>

