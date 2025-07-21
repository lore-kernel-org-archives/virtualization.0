Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE3927EC80
	for <virtualization@lists.linux.dev>; Mon, 21 Jul 2025 08:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753085133; cv=none; b=lorA9NY/KryvKfAe7Zuff1/8IRAJUY4ZUfS+TT3IhY6knMWSz6bueLB7/0wLr+sGraj/ci+0U/7ZRlW1CmDFV5oXqh0u2EE++XLRTzSejtlTWB7XnhAoNlSfaA24ilyT4kFKSYLPDwIqqQsiT3nmAMO8QOCRPJnKOihd8PIFjr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753085133; c=relaxed/simple;
	bh=7UQ+sz4mAM0NbQoJk7vFgEdHdcc74MEORdPFpt1r/Dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOtOaDMzXt6sT4wmR72iaAbvu8gnrSILvjtpoo+xdp5S1zQOvcQH4z9JluaNHahsyAdZl+cFrYw9iZO1QGHmCf1GPWS68SkFAyk6ox/+drGfcda4JYnHNGtDLfbUIx4DLBpMfZ7kSkDLLcFItsZuENVyOIS1fZzTQ7WY5IZeG9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RwVa9CGv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RwVa9CGv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753085130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7UQ+sz4mAM0NbQoJk7vFgEdHdcc74MEORdPFpt1r/Dk=;
	b=RwVa9CGvxFlKKmaoJzjBXIivNoJE/YxPRhB864pJJgLkLqMtLTUbmeJwd+LczqPLZmv7Yz
	gRZnzjeh3HN4PvS8VAt/vPQgRJFhHi7g0VVbnY1F3Jv4TpQKFMAO27pB8wJUe1MRT55Ctf
	iszS7y5Wa8fctE7dhebMseZc3hz3e/A=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-Uzs2USISNj24mNcMX07NfQ-1; Mon, 21 Jul 2025 04:05:29 -0400
X-MC-Unique: Uzs2USISNj24mNcMX07NfQ-1
X-Mimecast-MFC-AGG-ID: Uzs2USISNj24mNcMX07NfQ_1753085128
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-315af08594fso3914289a91.2
        for <virtualization@lists.linux.dev>; Mon, 21 Jul 2025 01:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753085128; x=1753689928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7UQ+sz4mAM0NbQoJk7vFgEdHdcc74MEORdPFpt1r/Dk=;
        b=iI5XqqzHIbCU4vCF248PVPN6hJ45/BESISZrWtaat0xk0Hw0G0b0s0MYzovzi5VrvK
         yrhlfHLgOPmZQO9+GVb9I/hAjnlu8ytCAWX+C3db/anTOZUdPh/kDsWNu+V8z/RDcaXK
         URvOLkWN7MguPME8R0hk+BnHVUyZt0mMugX70GEokfqoEgYiUtFLTlck8ezpN+Ia4xQr
         8TgR8oZ1PzmS9m8BRtrD3SDAtxtdGj9Y7K1xwNgf4H3Sq5Jv7A97C49j953BE8kinsUk
         2lkbwrOg9c/JScCKmGQ59NQd18wyfvPv76g8GIoMeuM1ImN4exCPG/qx7X2Zdpnnx1UT
         cH0A==
X-Forwarded-Encrypted: i=1; AJvYcCWSUdOQDPvdaQCvrS+60tsgIM7KWHiXVuDXFzeIq7hE9SEXyxb/m5Pl8bwlaO6dZRNB4IqbFJoDzfIcJXXraw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzZUycLhEXnT3MzXrZS18v/zzeeoXhFyn/a/Q/qkGeFum6nN9bS
	zqk7J+AQYdvjx40oNudPNJKS8eD26RLApplaaC4GEtjkTkoumPh1x7mG7kHdlLVwAzK2/TdJiBV
	3nDaRAb2vHyD/xIFTG7WHsdD2ordd6lQs5I6WkQvkDZu9gKTlPVjZYzGr6fVD5z2Y9ip1myKzkU
	JOVM4xrFSUrVMNh1WXrUBQaMBH7+xb+7jIPaVa6nuQ+YU=
X-Gm-Gg: ASbGncuE4ENUvxjEZPrPepYYvr0wkqPDNYTpGKfNIgDi0Jo8GlJPwk7eo+zOqnR3mv2
	W8NOdNqMwICsyz+Nc+yeZ2DD8N/5Oe7IX48loeC7SXuF7c4AI64WfBz9defK1hIHCEoXTaS7wKn
	0YLj5+yBXLFDRLcKofZoc=
X-Received: by 2002:a17:903:46c6:b0:235:880:cf8a with SMTP id d9443c01a7336-23e256aeedamr288798695ad.15.1753085128466;
        Mon, 21 Jul 2025 01:05:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3Dbja7nAXl0q6kNuWhhr4T0q+P62Jj5wZ8N+sZk61dNuDLy22HK5Op3UULHuwJBGNpc/Vo/E/4K//6ScVLwU=
X-Received: by 2002:a17:903:46c6:b0:235:880:cf8a with SMTP id
 d9443c01a7336-23e256aeedamr288798415ad.15.1753085128091; Mon, 21 Jul 2025
 01:05:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250718091616.6140-1-jasowang@redhat.com> <20250718091616.6140-8-jasowang@redhat.com>
 <20250718053156-mutt-send-email-mst@kernel.org> <CACGkMEue4Wh3ocM2Pmn5E_nMzjHkJqd-MhYbPDY9pXdwMtqgXQ@mail.gmail.com>
In-Reply-To: <CACGkMEue4Wh3ocM2Pmn5E_nMzjHkJqd-MhYbPDY9pXdwMtqgXQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 21 Jul 2025 16:05:17 +0800
X-Gm-Features: Ac12FXyo_8synm61E4m4n9coHa8YmsWzZJDSCTemJRNc5JgB3AB-8QaFJxUUZls
Message-ID: <CACGkMEtxWrrq-9bW0w4eVyRbXra94oM-fEfPJOeWAOcNZVrjjw@mail.gmail.com>
Subject: Re: [PATCH V4 7/9] vdpa: rename dma_dev to map_token
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, hch@infradead.org, 
	Christoph Hellwig <hch@lst.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: z42bahhL7QvpPJnmRfM7SpCOoVe9-eSBjmI6R8KmM7k_1753085128
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 6:09=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Fri, Jul 18, 2025 at 5:37=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Fri, Jul 18, 2025 at 05:16:14PM +0800, Jason Wang wrote:
> > > Virtio core switches from DMA device to mapping token, let's do that
> > > as well for vDPA.
> >
> > Pls switch to imperative mood.
> >
> > And add explanation about what is going on and why please.
>
> I think this has been explained in patch [PATCH V4 6/9] virtio:
> introduce map ops in virtio core?
>
> """
> For the device or transport that doesn't do DMA,
> they can implement their own mapping logic without the need to trick
> DMA core. In this case the map_token is opaque to the virtio core that
> will be passed back to the transport or device specific map
> operations. For other devices, DMA API will still be used, so map
> token will still be the dma device to minimize the changeset and
> performance impact.
> """
>
> >
> > At least, document what are the actual types stored here.
>
> It is opaque to the virtio core and will be used as a token to be
> passed back when the virtio core wants to map/unmap a buffer. So it
> doesn't have a type.
>
> > I checked and it looks like vduse actually returns struct device * here=
, too?
>
> It's just a token, vduse can return anything that can be used to
> identify an iova domain. For example, it can return a pointer to
> iova_domain which will also work. If you prefer to use iova domain, I
> can change to use that in the next version.
>
> > So why do we need this, why lose all type safety?
>
> If you worry about the case that assumes map_token as dma device in
> virtio core. I can keep both map_token and dma_device and make the
> mutually exclusive, then:
>
> - when transport reports dma device, use DMA API
> - when transport reports map token, use map ops
>
> Does this work for you?

This seems to result in a lot of unnecessary code. I wonder if the
following would work:

Just document the requirement in vring_create_virtqueue_map, say
something like when a virtio device doesn't have a map operation,
map_token must be a pointer to struct device.

Please give me some advice so I can work on a new version..

Thanks

>
> Thanks

