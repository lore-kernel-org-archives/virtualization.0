Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7859C17BA6
	for <virtualization@lists.linux.dev>; Wed, 23 Jul 2025 06:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753252150; cv=none; b=iILNbY6keClyANtatRcFeGW9638Eu/6kP2VTqaVXi7sF+Yrh/2af+BpB3JerFWzAMfRjN6PzSx8jyXkg2ACz2CFVcIrghtcb+IEBROZkhaAsTkmMiyKO1XnjzxZaElivcJdFZODgsv2WNK3bQsVa5NmfG5LvChA4HXVltlQRbgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753252150; c=relaxed/simple;
	bh=Ghwlk3kTDbZQBGISxo42bjvBoQv547SGlh07JJWLVxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=N1y+k8NOVMId3uhRzr7K0fZWosrCXLaKRTlLiVpUi9k2uECm8QfxTl0KgV4luHZACog4TL6EtUFPo+wQTBR97nCcnMXyFSMgX7UjtowNqGawJMYXcdEDLEsHN8woz/U8oYD+WPjI6nT83A/8M7kQa5zOw3XKgX/povbl5yN35aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OzDNUtwV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OzDNUtwV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753252147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QZUdBQvEfPR5r1LX4IvW/D9b1W3iMfej4fQneBrrkiw=;
	b=OzDNUtwVruO/eOHN6ueNzxX3Yl+78+41R8FVuexM2omJNmUxJem8ChGXTJPCT2q8bSWvM4
	jvgf2QQ3eTjuv8+HrUsOzysf9Qbjr438z+NMbzH55JS39g9ulmEa1hVH9V7HNuS5YZqbiL
	1LHH0EcyhAZkmwPfhBN9V0Lnyk9t4mw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-B5vQCJMDMTexF9Hr-lj0xg-1; Wed, 23 Jul 2025 02:29:05 -0400
X-MC-Unique: B5vQCJMDMTexF9Hr-lj0xg-1
X-Mimecast-MFC-AGG-ID: B5vQCJMDMTexF9Hr-lj0xg_1753252144
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4fabcafecso2900669f8f.0
        for <virtualization@lists.linux.dev>; Tue, 22 Jul 2025 23:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753252144; x=1753856944;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QZUdBQvEfPR5r1LX4IvW/D9b1W3iMfej4fQneBrrkiw=;
        b=aZ99kfv5zOEl1AH3YeCm55O1GGV9L/AVhHCogJ0DpHi6q2pjSFUl6UuoRfdQnu3ii/
         OhPHkvPpLKeH+Bfh6bevrabIEJXyHk2wJ4VOGuy6nmC4UafRJP7ADcxXSJmwWsyUn3Qi
         6WRUfsS49NK4/01tm03f466pi482U1DjRvPkqgrbmkD4EjsGtPF9wCQlPSCWR9YQ6+1W
         Ch4zygmiM524/aaz2fipomX+M+LrYhXsLxPCsAcaV49HVq7mJycfmwmcMTPZSv1Ksu9X
         ZZO88f1BrEGmPz5V36VIfYeO/TdvHqyVwWjaNfY3B7iZwKZRHruDE6SE1Qu6dPnkhDnZ
         tswg==
X-Forwarded-Encrypted: i=1; AJvYcCXxYSAkv96L6iLto/PAzQgDsEIr8hOi99m21yUIriKRj/iPrRh0JqYiI8m08S7Z38mzox3k1iOc5NIeqU4M+w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxn5Agi6fv3baV9ks4y74Fv7rHrstQ0UEg+SJDBPMh0ZhMOqvIb
	IYnMjEfkQjg30y4sbBlyU29YqMZdHtI7kNZ7zbMX6MkrOXvgU0I+KpLEL6PTSSRunUmHLGuXngC
	R3uiYMVCI4vgbHU4niJtkPi/OYDnUhh7BfnrL6QicViK9m8WoAGaP8eJ6fZGTmmY6Mc90
X-Gm-Gg: ASbGncuEjw5zSV6IcmmCUbP3O+zVI5whpLKWuCoPu77bTdo/9u+aPZZDbWRaFjWcgmL
	9fGRoM08UUO6T/oJq/LztiACXgJ7xd9f6HLX+y1OCEKdLQjsnZ2S/atpfLyO0YyvCgyug2oK6/i
	lSoHsuV8ryuu8egTmWR1MjkFAmoTp3+AirqkR1Xc1+3rf1S792OWiwGtDegsbLm+KBaXddgjPzF
	a172t1Yp3Dm2qET4jOEfe8i0k3wrklVVywhMabMgIcfJuZMbRiTA4asgVHAuDfkSWnNU9nSwSlk
	IryRVsSgvFImUY5o3ipOH8Ujdeiz1RNIGkM=
X-Received: by 2002:adf:9c92:0:b0:3a4:ee40:6c85 with SMTP id ffacd0b85a97d-3b768f16439mr1003857f8f.54.1753252143923;
        Tue, 22 Jul 2025 23:29:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGv2E3l8pukG3KFkSZlA7z2/gDgSiHmODzD9BMp8Vh9nmvdqdugMzvFrFF+sNxb33vx4C1cWA==
X-Received: by 2002:adf:9c92:0:b0:3a4:ee40:6c85 with SMTP id ffacd0b85a97d-3b768f16439mr1003843f8f.54.1753252143494;
        Tue, 22 Jul 2025 23:29:03 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:153d:b500:b346:7481:16b2:6b23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45869199461sm12392995e9.8.2025.07.22.23.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 23:29:03 -0700 (PDT)
Date: Wed, 23 Jul 2025 02:29:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, hch@infradead.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V4 7/9] vdpa: rename dma_dev to map_token
Message-ID: <20250723021457-mutt-send-email-mst@kernel.org>
References: <20250718091616.6140-1-jasowang@redhat.com>
 <20250718091616.6140-8-jasowang@redhat.com>
 <20250718053156-mutt-send-email-mst@kernel.org>
 <CACGkMEue4Wh3ocM2Pmn5E_nMzjHkJqd-MhYbPDY9pXdwMtqgXQ@mail.gmail.com>
 <CACGkMEtxWrrq-9bW0w4eVyRbXra94oM-fEfPJOeWAOcNZVrjjw@mail.gmail.com>
 <20250722131746-mutt-send-email-mst@kernel.org>
 <CACGkMEt+mLO9xL3LaJE7XJV_-YiUVeJgSm3oWAhDmmvwhfwXfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEt+mLO9xL3LaJE7XJV_-YiUVeJgSm3oWAhDmmvwhfwXfA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: l34FY_UYGXmVc6u8D5jrrO9pSWQCmCl6cp9BkQM3KqU_1753252144
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jul 23, 2025 at 01:54:37PM +0800, Jason Wang wrote:
> On Wed, Jul 23, 2025 at 1:26 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Jul 21, 2025 at 04:05:17PM +0800, Jason Wang wrote:
> > > On Fri, Jul 18, 2025 at 6:09 PM Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > On Fri, Jul 18, 2025 at 5:37 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Fri, Jul 18, 2025 at 05:16:14PM +0800, Jason Wang wrote:
> > > > > > Virtio core switches from DMA device to mapping token, let's do that
> > > > > > as well for vDPA.
> > > > >
> > > > > Pls switch to imperative mood.
> > > > >
> > > > > And add explanation about what is going on and why please.
> > > >
> > > > I think this has been explained in patch [PATCH V4 6/9] virtio:
> > > > introduce map ops in virtio core?
> > > >
> > > > """
> > > > For the device or transport that doesn't do DMA,
> > > > they can implement their own mapping logic without the need to trick
> > > > DMA core. In this case the map_token is opaque to the virtio core that
> > > > will be passed back to the transport or device specific map
> > > > operations. For other devices, DMA API will still be used, so map
> > > > token will still be the dma device to minimize the changeset and
> > > > performance impact.
> > > > """
> > > >
> > > > >
> > > > > At least, document what are the actual types stored here.
> > > >
> > > > It is opaque to the virtio core and will be used as a token to be
> > > > passed back when the virtio core wants to map/unmap a buffer. So it
> > > > doesn't have a type.
> > > >
> > > > > I checked and it looks like vduse actually returns struct device * here, too?
> > > >
> > > > It's just a token, vduse can return anything that can be used to
> > > > identify an iova domain. For example, it can return a pointer to
> > > > iova_domain which will also work. If you prefer to use iova domain, I
> > > > can change to use that in the next version.
> > > >
> > > > > So why do we need this, why lose all type safety?
> > > >
> > > > If you worry about the case that assumes map_token as dma device in
> > > > virtio core. I can keep both map_token and dma_device and make the
> > > > mutually exclusive, then:
> > > >
> > > > - when transport reports dma device, use DMA API
> > > > - when transport reports map token, use map ops
> > > >
> > > > Does this work for you?
> > >
> > > This seems to result in a lot of unnecessary code. I wonder if the
> > > following would work:
> > >
> > > Just document the requirement in vring_create_virtqueue_map, say
> > > something like when a virtio device doesn't have a map operation,
> > > map_token must be a pointer to struct device.
> > >
> > > Please give me some advice so I can work on a new version..
> > >
> > > Thanks
> > >
> > > >
> > > > Thanks
> >
> >
> > How about something like this?
> >
> > typedef union {
> >         struct device *dma_dev;
> >         struct vduse_iova_domain *iova_domain;
> >         void *ptr;
> > } virtio_dma_dev_t;
> >
> >
> >
> > Now, just pass this around.
> > You can also add an enum with the pointer:
> >
> > typedef struct {
> >         union {
> >                 struct device *dma_dev;
> >                 struct vduse_iova_domain *iova_domain;
> >                 void *ptr;
> >         };
> >         enum {
> >                 VIRTIO_DMA,
> >                 VIRTIO_IOVA
> >         } type;
> > } virtio_dma_dev_t;
> >
> > (possibly only on debug builds, if you find it's costly?)
> 
> I've considered something like this, but it looks more like trying to
> hard-code the runtime type information which I'm not sure we really
> need.
> Assuming the token or DMA device won't be changed after the probe. Let
> the transport to report one of the dma_dev or mapping_token should be
> sufficient.

you mean the enum? Not strictly necessary - more of a defence in depth
thing.

> 
> Let me try and see.
> 
> Thanks
> 
> >
> > This allows encapsulation and asserts that the type is right.
> >
> >
> > --
> > MST
> >

