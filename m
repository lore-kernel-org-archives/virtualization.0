Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7E62F4A
	for <virtualization@lists.linux.dev>; Wed, 23 Jul 2025 05:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753250094; cv=none; b=L+iEgKlyOboUwhOPN+Z6AvRLIe3qIBG/D1g0wWaTOduLKlZScy4Faq2bi/yoFaIU/njAjemY3hIohQenaBvOcHblcXWB45+KirTRoWim5p/ydQF3HoQbAi6d9J+YwDsw1pN1Iz9bEaGV76Fz6FaUxxlUsFKS7+3rMQC+IZ2EdWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753250094; c=relaxed/simple;
	bh=zf2Wlb7Ift34ysEfsoLpeIPw5lDouMgTKNbR5q0NdQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L82xfwgpY/3KkvinBWQaYN8BHWhxk9d0CGqHoORMy7gPWWUP1YNFI0V7eSUAMQ60vJ0/HCRDmzBQT83DpYDTB8A26I+/MVTgesdWr8hguAGVxg0u0s6ex/2ZcxyslaDzI9fZwnSJnMG71nalORphZgD8MlH/X51gYMt5MDa0Yjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fsL59AMw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fsL59AMw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753250091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oqWgWRsseAIy1ZQW/9u1dfWPa0QgpiATWf558L1Lh/4=;
	b=fsL59AMw6U3226uRND4r8hfdkAcIDme8OyY7Uw/zEltKLD2mSuIeEDBlkN90qOiX8oGdPU
	OIh5KVYpCazJeW4GcuNOGqZw3yXlWC6jpF8vgnGLKnUtsu5HTh9pBvp8yNAv5YxZn8D82x
	YvKZko6hxga0UbmCgl44T8/tcGn7aJ4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-piBrCOC_Ore3JcUvn8vt_A-1; Wed, 23 Jul 2025 01:54:50 -0400
X-MC-Unique: piBrCOC_Ore3JcUvn8vt_A-1
X-Mimecast-MFC-AGG-ID: piBrCOC_Ore3JcUvn8vt_A_1753250089
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-31218e2d5b0so9616793a91.2
        for <virtualization@lists.linux.dev>; Tue, 22 Jul 2025 22:54:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753250089; x=1753854889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oqWgWRsseAIy1ZQW/9u1dfWPa0QgpiATWf558L1Lh/4=;
        b=Uwwyoi/f09HTk9Ob7kqc4BhzGrOsMNHKqUcr7vzMui4LziNVp6LXYXAxUbUiI2cPWe
         IB7JDGrEorB0iQ0gAJ2iZOFO8qRoBuhi5UZSfKnpl9wBZidXsxnbie1TrEwg/EFl1f/U
         0pr0rnfDdNV8A8vRWZiZBq0SWa0D6ezpBQyB9qDu/qNaaZ2i4eDeEw5/wyFlewdIZ3ix
         zOG4lL5zlznbKdcu/vG0CGal+dnxJH33k2C3Abt0zigAvu6hmp1GbnxFJ4nwhYO3ph9V
         9B3XPP0cG5qDvufQFbqswvuJXevO2qt+fSS81DUOwGT0firQ6yMUHbEMDHcKzAmO6fHK
         8b/A==
X-Forwarded-Encrypted: i=1; AJvYcCVui2PFNeklXMHDjZWvlvBTaiAlgvuf0Nc1MLWoHRMlyYkPo0XV6i7X/2el0IZBDu93ch9iRqGbarY84h3t5Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz3HMUlWMRejn6lRinmf2qqjTlpcupoteOkLul4U3xxaxIkD1MN
	B7Sakg5No6l1njIbsAWbyQ2uBwz0hjHQ11L880BOi9cRnkq9iLEhPLQvglDGMaF5qCGcSQBH5Ik
	usQCNi55bMRszi0sIUJN2fpEMosoLzLwi7isNJHBkgunyA1XhU88BqhioHpW2TIWvGUJ0noUV0S
	cNvg4u2RYQsPzaz+aF7V4rkZpb8XuD7S+8cPg8h7xG49E=
X-Gm-Gg: ASbGncslEiZfS5npsdWurTH7cdviPsr0/0vgjJxTIsE0A4dU1lYbuC1BDL4P1/OCQG3
	kNVkb//Yb+FdFM6i0/IoqJ1bbGVcAGLIFcyI0owQ72knp81YDTFkhlQfIJAv2SyePoNoDISNH5+
	UYf1c6e1fMZmJLzW4OnlI=
X-Received: by 2002:a17:90b:5487:b0:311:f99e:7f4a with SMTP id 98e67ed59e1d1-31e507cddb3mr2853724a91.26.1753250089047;
        Tue, 22 Jul 2025 22:54:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFg3YXIMNSjOiKB94IAoqLxFOx4RrEgnsVtpgEXv95MbhQb/qhPbpH2qJwosv2tYiH6S3MUzHPmJV2ZldFCtY8=
X-Received: by 2002:a17:90b:5487:b0:311:f99e:7f4a with SMTP id
 98e67ed59e1d1-31e507cddb3mr2853706a91.26.1753250088576; Tue, 22 Jul 2025
 22:54:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250718091616.6140-1-jasowang@redhat.com> <20250718091616.6140-8-jasowang@redhat.com>
 <20250718053156-mutt-send-email-mst@kernel.org> <CACGkMEue4Wh3ocM2Pmn5E_nMzjHkJqd-MhYbPDY9pXdwMtqgXQ@mail.gmail.com>
 <CACGkMEtxWrrq-9bW0w4eVyRbXra94oM-fEfPJOeWAOcNZVrjjw@mail.gmail.com> <20250722131746-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250722131746-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 23 Jul 2025 13:54:37 +0800
X-Gm-Features: Ac12FXxXu_ZDpFAvHW50BwUk-EMm2aY6L-G-T-sU76NLXVRyb3_-TnJMpl1pFnA
Message-ID: <CACGkMEt+mLO9xL3LaJE7XJV_-YiUVeJgSm3oWAhDmmvwhfwXfA@mail.gmail.com>
Subject: Re: [PATCH V4 7/9] vdpa: rename dma_dev to map_token
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, hch@infradead.org, 
	Christoph Hellwig <hch@lst.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Y1MRDNOsknzX-Sz4IIQVSLLXan9Z_S44rz7zsLwmdM4_1753250089
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 1:26=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Jul 21, 2025 at 04:05:17PM +0800, Jason Wang wrote:
> > On Fri, Jul 18, 2025 at 6:09=E2=80=AFPM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Fri, Jul 18, 2025 at 5:37=E2=80=AFPM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > > >
> > > > On Fri, Jul 18, 2025 at 05:16:14PM +0800, Jason Wang wrote:
> > > > > Virtio core switches from DMA device to mapping token, let's do t=
hat
> > > > > as well for vDPA.
> > > >
> > > > Pls switch to imperative mood.
> > > >
> > > > And add explanation about what is going on and why please.
> > >
> > > I think this has been explained in patch [PATCH V4 6/9] virtio:
> > > introduce map ops in virtio core?
> > >
> > > """
> > > For the device or transport that doesn't do DMA,
> > > they can implement their own mapping logic without the need to trick
> > > DMA core. In this case the map_token is opaque to the virtio core tha=
t
> > > will be passed back to the transport or device specific map
> > > operations. For other devices, DMA API will still be used, so map
> > > token will still be the dma device to minimize the changeset and
> > > performance impact.
> > > """
> > >
> > > >
> > > > At least, document what are the actual types stored here.
> > >
> > > It is opaque to the virtio core and will be used as a token to be
> > > passed back when the virtio core wants to map/unmap a buffer. So it
> > > doesn't have a type.
> > >
> > > > I checked and it looks like vduse actually returns struct device * =
here, too?
> > >
> > > It's just a token, vduse can return anything that can be used to
> > > identify an iova domain. For example, it can return a pointer to
> > > iova_domain which will also work. If you prefer to use iova domain, I
> > > can change to use that in the next version.
> > >
> > > > So why do we need this, why lose all type safety?
> > >
> > > If you worry about the case that assumes map_token as dma device in
> > > virtio core. I can keep both map_token and dma_device and make the
> > > mutually exclusive, then:
> > >
> > > - when transport reports dma device, use DMA API
> > > - when transport reports map token, use map ops
> > >
> > > Does this work for you?
> >
> > This seems to result in a lot of unnecessary code. I wonder if the
> > following would work:
> >
> > Just document the requirement in vring_create_virtqueue_map, say
> > something like when a virtio device doesn't have a map operation,
> > map_token must be a pointer to struct device.
> >
> > Please give me some advice so I can work on a new version..
> >
> > Thanks
> >
> > >
> > > Thanks
>
>
> How about something like this?
>
> typedef union {
>         struct device *dma_dev;
>         struct vduse_iova_domain *iova_domain;
>         void *ptr;
> } virtio_dma_dev_t;
>
>
>
> Now, just pass this around.
> You can also add an enum with the pointer:
>
> typedef struct {
>         union {
>                 struct device *dma_dev;
>                 struct vduse_iova_domain *iova_domain;
>                 void *ptr;
>         };
>         enum {
>                 VIRTIO_DMA,
>                 VIRTIO_IOVA
>         } type;
> } virtio_dma_dev_t;
>
> (possibly only on debug builds, if you find it's costly?)

I've considered something like this, but it looks more like trying to
hard-code the runtime type information which I'm not sure we really
need.

Assuming the token or DMA device won't be changed after the probe. Let
the transport to report one of the dma_dev or mapping_token should be
sufficient.

Let me try and see.

Thanks

>
> This allows encapsulation and asserts that the type is right.
>
>
> --
> MST
>

