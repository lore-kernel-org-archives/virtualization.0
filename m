Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FA137880E
	for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 16:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777048320; cv=none; b=ZPCcmo4Q17on1Qdz0v79EmlXP91r5wY7QVg5Spb2aP7DgeaZOHszCBFrMTlDW+UbP/vHMJyDy63x2cAQ+rFy2T5oXr8MnwAUnQVg6ETJjYdxQhXCS6hzdDOIPWcq87kGNLS6J6mJkRZ5jcopOpnSZx8jfQ1OqNHnDcjgOVYse5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777048320; c=relaxed/simple;
	bh=LfPBzP7DHNUHCLEaohkuL/OUj/J9i4oMih4DMmKE8J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Sin1EOLd31Mgl3CAUqMQ6NrLdFEEvwAjmdvE61DfIJEZgMLMG+Gg8Na21HVscorHlyWUce1XvKKKcLDTYp4HIl9CtBpZCdQHTk3qLX3TuwnuIxkbhA3WE8Fj7RyyR8ns75RwZBN3gByzI3hPm6nsienjn6RWboAeIQBRoMF4QA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TKKqNdRi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TKKqNdRi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777048317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GWUEY520tGPMzq0yC4BnOUgTkuV4SwdojhoysRAdt+k=;
	b=TKKqNdRibgDllRA0NL8nsM1JOxC/s+ZHcA50M71ddOkhQWev9CjENAD16Vi+mfNPwcuEFe
	OH+rFxUkThCanVlIMuTA6eA9rG5EXu+LQ7ZC2TD3itBIklc6kz2GSxYe108jq056rKjo5j
	Y6EcxskRr018jNGkjScRXf7sI9OwZt4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-PYsBoIbcPtejRLXohSJP5w-1; Fri, 24 Apr 2026 12:31:56 -0400
X-MC-Unique: PYsBoIbcPtejRLXohSJP5w-1
X-Mimecast-MFC-AGG-ID: PYsBoIbcPtejRLXohSJP5w_1777048315
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48a588ff84eso31457615e9.1
        for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 09:31:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777048315; x=1777653115;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GWUEY520tGPMzq0yC4BnOUgTkuV4SwdojhoysRAdt+k=;
        b=I508bF8HqmRhEPqcjqCSxP+6Z+nuF0ef5uV0G769HHQOUyO9OCUvMzq3jBlNIuEJXg
         j5h1AkAzTFrN0q8GDc/HG1rUCwU+U1OCylgDmtzTxxywyz6cDNVrxDTpfZwV7QAA7OAi
         sXeAAyKS/IVJrJw5IOmyf2YZtw2eizjnpns5jypkIAC9w+C2RdmL8tsXlLwUt/IHPUaF
         iLI7J+wpMn1azGbKmZRQ1TSozTyd7UYyBfp3peG+frQPCAH9ZFn6xlp0Kvp9lLuIaRAX
         Q7qCXBQ1QRIVrAInH5SgL1LEySaLleFQwatVbLDyVjZcD+6io7VGACekI68PkMqVVBos
         mn2g==
X-Forwarded-Encrypted: i=1; AFNElJ8wMCB2OB4wJiaA1WsrTaKcghfgvsCQef9/bGt6f0P9I9LoIiwHMl9gpgZ4w4m1qV3TmUmttbo4KCktnPs8Pg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZfDuldL9L5A9/Z5fPYTvq9reG0bFsSgKmBul5gouMN+aN+7+s
	EiyLQ6Pd1X0m4dvt4EbrdF9GHQ/75QX3mD3oqy3kGgoKFuGmf+BzqYjuZ5n8KbMV5uBNmrR4b+A
	7OPg9k4a11N6YyzP6GEkOyfhF8VzEC2k06WFLf7HOWc2c7xNw5lriRiuuxR3/0Dv88CD6
X-Gm-Gg: AeBDietkAhqJ3eogvBg7WGFSP2ZlQxjb6vu7f2NozCPiH9xu7pBzG/DJuEHkNFb9I4I
	6IB2FcXffdtKw2kPQ0qoZkclPqId9IFpzkXJS32IT86z0v+AqNoBh3QM/krrmbCpRyjZNqKdgLB
	ZvRSE5mWVlHE7gO4oMMF1rkno6wW+3ILFwWFjV63QqIFaAvOLktCw4VnJAFi0gPZVGgOCn7+tbe
	lGsXG70e8a3SVQTYFfYM3VRkgUdeD3nFS6+WpeeFRgUFilQrRXDh9tAokTQlXjxo/1VwIctzOHr
	gbcoFVS5nn3sG5L/89c3v/cdwImcP3OPgY9Dbog63QcwXtCDKbWI2cqY+n83+JRemFSv2yfK5j1
	EeK4NesZpfJCrUXelLDSO9Mdmgk1kF/xLjQsVmFLzw3Bl365iIyvFkr3nFNfrfew=
X-Received: by 2002:a05:600c:c085:b0:488:acbc:b2e with SMTP id 5b1f17b1804b1-488fb765b04mr385887595e9.17.1777048314902;
        Fri, 24 Apr 2026 09:31:54 -0700 (PDT)
X-Received: by 2002:a05:600c:c085:b0:488:acbc:b2e with SMTP id 5b1f17b1804b1-488fb765b04mr385887045e9.17.1777048314417;
        Fri, 24 Apr 2026 09:31:54 -0700 (PDT)
Received: from redhat.com (bzq-79-177-155-147.red.bezeqint.net. [79.177.155.147])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb74c68asm188968435e9.3.2026.04.24.09.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 09:31:53 -0700 (PDT)
Date: Fri, 24 Apr 2026 12:31:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	gnurou@gmail.com
Subject: Re: [PATCH] virtio: Add ID for virtio media
Message-ID: <20260424123123-mutt-send-email-mst@kernel.org>
References: <20260310-virtio-media-id-v1-1-be211bcf682b@redhat.com>
 <CADSE00+VyDf6hMAB79wP2koSQ3FznO_OJuGCZ6zN8zuCrwtZMg@mail.gmail.com>
 <20260424090616-mutt-send-email-mst@kernel.org>
 <CADSE00JEjrecyM==PyjX9LT5X62awYQOn3as-KFGYQrSD0+K_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CADSE00JEjrecyM==PyjX9LT5X62awYQOn3as-KFGYQrSD0+K_w@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 16KgOfpTvtR9hoRwHe5PD9a-qp8z8mXcwf-BslCL-gU_1777048315
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Apr 24, 2026 at 03:37:14PM +0200, Albert Esteve wrote:
> On Fri, Apr 24, 2026 at 3:07 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Apr 09, 2026 at 06:53:41PM +0200, Albert Esteve wrote:
> > > Hi,
> > >
> > >
> > > On Tue, Mar 10, 2026 at 9:41 AM Albert Esteve <aesteve@redhat.com> wrote:
> > > >
> > > > Add VIRTIO_ID_MEDIA definition for virtio-media.
> > > >
> > > > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > >
> > > Are there any thoughts on this patch, or any actions I need to take?
> > >
> > > Thanks,
> > > Albert
> >
> > Create a github issue and request a vote as documented in README.md
> 
> The inclusion of this ID was already voted and approved. The device
> already appears in the VirtIO v1.4 specification, with the same ID (as
> linked below). This patch is only meant to translate the decision to
> the kernel header.
> 
> >
> > > > ---
> > > > While the Linux driver for virtio media is currently under active
> > > > development and review [1], the VirtIO v1.4 specification has
> > > > already been published and oficially defines the media device type [2].
> > > >
> > > > Adding the device ID now allows other components and tools to reference it
> > > > before the driver lands, and ensures the kernel headers stay aligned
> > > > with the specification.
> > > >
> > > > [1] https://lore.kernel.org/linux-media/20250412-virtio-media-v3-1-97dc94c18398@gmail.com/
> > > > [2] https://docs.oasis-open.org/virtio/virtio/v1.4/virtio-v1.4.html#x1-82200022
> > > > ---
> > > >  include/uapi/linux/virtio_ids.h | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
> > > > index 6c12db16faa3a..f9056af0c6223 100644
> > > > --- a/include/uapi/linux/virtio_ids.h
> > > > +++ b/include/uapi/linux/virtio_ids.h
> > > > @@ -69,6 +69,7 @@
> > > >  #define VIRTIO_ID_BT                   40 /* virtio bluetooth */
> > > >  #define VIRTIO_ID_GPIO                 41 /* virtio gpio */
> > > >  #define VIRTIO_ID_SPI                  45 /* virtio spi */
> > > > +#define VIRTIO_ID_MEDIA                        48 /* virtio media */
> > > >
> > > >  /*
> > > >   * Virtio Transitional IDs
> > > >
> > > > ---
> > > > base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> > > > change-id: 20260310-virtio-media-id-b31179fcdc44
> > > >
> > > > Best regards,
> > > > --
> > > > Albert Esteve <aesteve@redhat.com>
> > > >
> >


Oh my bad. I misfiled it into the spec folder. I will take care of this.
Thanks!

