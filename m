Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8926684039
	for <virtualization@lists.linux.dev>; Tue, 27 May 2025 01:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748309241; cv=none; b=lMATC4g+lwx44nRq3SmqIeZd4VtcrbWOgwK3ENSNEncJCV+1B1tT0vQJcAwpdniJ2yVGCRhnF6K8192fsF6CVHHOYwL43pJIvE0XhBTkrw5OeVRCAjBrGDS/s1iaC4n93LJ9o3rt7WzKdgVqUcU2l6kluxjosGb1ukn/vhNrbPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748309241; c=relaxed/simple;
	bh=FFKS18dYV5Y8MHYJB2kMbWfKFB4Nsx/TPtY/OyRPyFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D5xX2VlCUJqrnrStLOTwnsoZLm7ra3pdnx98UWwaJpWxDc9YgFGp83p0arSS6A83MINK753wVUclR9m1jgOmMjUUOV3q8aw4uQ91wGsnJmScNZfYtwlnFB2lIOWTu3jZvdnoO2tHhMVrp6CFcEqS5sWqQTwoFzZjLzOC1gtqQEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bn65vfV2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bn65vfV2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748309238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3x4oTme+lZoqSj5iXtS0M9usiPX4bxGfp/DJRe7z3no=;
	b=bn65vfV2ryzuOSan4szidsY3WurX5wbW6zLQ2dbE2eDCDNMVx8tatChA0qWGWQjCfZ3Eov
	fitJnF7loX8kmhas21e1rFQbqEtwKtyDuTS+/FqJTme9cOIUhsBfqRfMOw0PSDV6mzBmjc
	fGpPxnwJazDNt6CM5WmPRIO11Xu7NFU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-qU2MTYqFMnCR7ihb8a0GVA-1; Mon, 26 May 2025 21:27:17 -0400
X-MC-Unique: qU2MTYqFMnCR7ihb8a0GVA-1
X-Mimecast-MFC-AGG-ID: qU2MTYqFMnCR7ihb8a0GVA_1748309236
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ad55a32b7afso167544466b.3
        for <virtualization@lists.linux.dev>; Mon, 26 May 2025 18:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748309236; x=1748914036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3x4oTme+lZoqSj5iXtS0M9usiPX4bxGfp/DJRe7z3no=;
        b=NlUi9zVouQ7Ad34wGmzhve1iB3AgpgVM4YlU/oukf/7GWORBRkf9y8jzSXkRwCkMwv
         CLQT+IESTd42HrTHtJWRlJZA+Z3BfN7PymIFA4u2lgjdb9cFuBUMjXbphkItJrC8oRRz
         dlUA8GHKfcOb4jSZg4eWl12YJb7cRhESF0AgzKGye4mNUt/mMqyBEnZz4/b6C8Jcm/Cg
         z5/PDFpP2xEPNTARYQ3pjf2dMRZRGfJrOSjdwIbZrYqAWTqaRt9rpDYjBABCfTHySkoN
         KSUKA6cU5tKqsvXX5Zd0+pCfdKKZ3Ham1qE8aApCUCbJJOQRkQ4b0xXScWDK49d1ipeb
         0k9g==
X-Forwarded-Encrypted: i=1; AJvYcCVKYDvSUMxo1EkwVWjrky5KeYlDWRek2ODiazak7ozSOFIW0W/aMYSNGuhBqcwrsKWngeDdIQPDQBWG1TT9zw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+ORB7vwdakU4reXWXpB74l5xntLISnoVLJrB5iEYt74WWH3Go
	9uI43SIFbpQp70DN45gBc66yjgj12g1MYoQGz3otc9AxyeS/Nl4PnhacdIf+g4i8wom+z/rlbyN
	4lCqWc7FUGDmbsDbzrlfBZeR7EwuqRouMwrR1m7g0cHaCS9JPqjVKqbV4rgsMuUvQ9NlDRNfud4
	c5SphWgThqdpLSqGov2+rMFAKzGTTsMNRvVaw1xeSkCQE=
X-Gm-Gg: ASbGnctocHwWaQXg2JWRB+LYPyPp+03A2D0zUzO6wfss/IKrLyf3XH9h3u6mvn6qprz
	9gb1tm5NZNrz5Fg/PpSNTlOnq0Cj2cdQIPIlbU5+ifBeT9UHh4bAVqgsTrQpv8u4Kd6nQVg==
X-Received: by 2002:a17:907:c26:b0:ad4:fb9a:ab36 with SMTP id a640c23a62f3a-ad85b03b2a7mr1022780866b.5.1748309235938;
        Mon, 26 May 2025 18:27:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoNFm7L9s5ZKvOxaLRZiEkKRCVhf+AcjOxcEfulOX78/o+U1rspOYdTK2k8m/1vEqOWfjdxnI22a2qLEer4Sk=
X-Received: by 2002:a17:907:c26:b0:ad4:fb9a:ab36 with SMTP id
 a640c23a62f3a-ad85b03b2a7mr1022780266b.5.1748309235570; Mon, 26 May 2025
 18:27:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com> <CAPpAL=x4BWNh__YpzkzpErkseh04FT7WNLmg=xMXtfZ0S9BabQ@mail.gmail.com>
 <CAJaqyWdtKEYiY2tBB0F477LqxVs8fzaix96551WSMa=KdT3C5Q@mail.gmail.com>
 <20250518173443-mutt-send-email-mst@kernel.org> <CAPpAL=zhKD7q3OmcR9_nWqMXk1grz0gNJ2Wqk923k4i+kuMfgw@mail.gmail.com>
In-Reply-To: <CAPpAL=zhKD7q3OmcR9_nWqMXk1grz0gNJ2Wqk923k4i+kuMfgw@mail.gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 27 May 2025 09:26:39 +0800
X-Gm-Features: AX0GCFulx4w1yysYV3ELshmY7Ct7E7TGXNXAtA90EnSMjyBRj3ZkTj5E7rSOd2g
Message-ID: <CAPpAL=x4vRMXFBvEpwrJv6xUZgYrgB41=d1qdDBzENp0NM4O1Q@mail.gmail.com>
Subject: Re: [PATCH 00/19] virtio_ring in order support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>, Jason Wang <jasowang@redhat.com>, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DaOW6Ke7D2_kkGJ6wG4QMRMFh4Dq9z4nH57pcnj0Zkg_1748309236
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 3:01=E2=80=AFPM Lei Yang <leiyang@redhat.com> wrote=
:
>
> On Mon, May 19, 2025 at 5:35=E2=80=AFAM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Wed, Mar 26, 2025 at 07:39:47AM +0100, Eugenio Perez Martin wrote:
> > > On Mon, Mar 24, 2025 at 3:44=E2=80=AFPM Lei Yang <leiyang@redhat.com>=
 wrote:
> > > >
> > > > QE tested this series of patches with virtio-net regression tests,
> > > > everything works fine.
> > > >
> > >
> > > Hi Lei,
> > >
> > > Is it possible to test this series also with virtio-net-pci,...,in_or=
der=3Don?

Virtio-net regression tested pass with virtio-net-pci,...,in_order=3Don.

Tested-by: Lei Yang <leiyang@redhat.com>
> > >
> > > Thanks!
> >
> >
> > Lei, what do you think?
>
>
> Sure,  I will test it and provide test results ASAP.
>
> Thanks
> Lei
> >
> >
> > > > Tested-by: Lei Yang <leiyang@redhat.com>
> > > >
> > > > On Mon, Mar 24, 2025 at 1:45=E2=80=AFPM Jason Wang <jasowang@redhat=
.com> wrote:
> > > > >
> > > > > Hello all:
> > > > >
> > > > > This sereis tries to implement the VIRTIO_F_IN_ORDER to
> > > > > virtio_ring. This is done by introducing virtqueue ops so we can
> > > > > implement separate helpers for different virtqueue layout/feature=
s
> > > > > then the in-order were implmeented on top.
> > > > >
> > > > > Tests shows 5% imporvemnt in RX PPS with KVM guest + testpmd on t=
he
> > > > > host.
> > > > >
> > > > > Please review.
> > > > >
> > > > > Thanks
> > > > >
> > > > > Jason Wang (19):
> > > > >   virtio_ring: rename virtqueue_reinit_xxx to virtqueue_reset_xxx=
()
> > > > >   virtio_ring: switch to use vring_virtqueue in virtqueue_poll va=
riants
> > > > >   virtio_ring: unify logic of virtqueue_poll() and more_used()
> > > > >   virtio_ring: switch to use vring_virtqueue for virtqueue resize
> > > > >     variants
> > > > >   virtio_ring: switch to use vring_virtqueue for virtqueue_kick_p=
repare
> > > > >     variants
> > > > >   virtio_ring: switch to use vring_virtqueue for virtqueue_add va=
riants
> > > > >   virtio: switch to use vring_virtqueue for virtqueue_add variant=
s
> > > > >   virtio_ring: switch to use vring_virtqueue for enable_cb_prepar=
e
> > > > >     variants
> > > > >   virtio_ring: use vring_virtqueue for enable_cb_delayed variants
> > > > >   virtio_ring: switch to use vring_virtqueue for disable_cb varia=
nts
> > > > >   virtio_ring: switch to use vring_virtqueue for detach_unused_bu=
f
> > > > >     variants
> > > > >   virtio_ring: use u16 for last_used_idx in virtqueue_poll_split(=
)
> > > > >   virtio_ring: introduce virtqueue ops
> > > > >   virtio_ring: determine descriptor flags at one time
> > > > >   virtio_ring: factor out core logic of buffer detaching
> > > > >   virtio_ring: factor out core logic for updating last_used_idx
> > > > >   virtio_ring: move next_avail_idx to vring_virtqueue
> > > > >   virtio_ring: factor out split indirect detaching logic
> > > > >   virtio_ring: add in order support
> > > > >
> > > > >  drivers/virtio/virtio_ring.c | 856 ++++++++++++++++++++++++++---=
------
> > > > >  1 file changed, 653 insertions(+), 203 deletions(-)
> > > > >
> > > > > --
> > > > > 2.42.0
> > > > >
> > > > >
> > > >
> >

