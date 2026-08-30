Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906392D12ED
	for <virtualization@lists.linux.dev>; Sun, 30 Aug 2026 06:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788072998; cv=none; b=hp1rkTOCnQ/V41OCqbWd09iTYOBZ/9L/i+eG4NJiympoQ5XqaVA2YFAv0dksqu9A3PIV5mOF+5ax99kH+nJxNc+vpf2oMNO2FvPaNi4iLhQB8Ozp5W8UNrmE28BvB8yjWW9NQoyhhcA0qafNeJl5ZaeLxpsleQeEdY8ly6+yeMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788072998; c=relaxed/simple;
	bh=oG6H0i7TFJakemrkVZ3AqA056ijFzBJqlUJomJ/b3nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=WLzGNrMh+EiamjL5Ej93zQs9JRd3ACZixMJcSPac5zGNTAgR8GHfyaVXgvEu04LO421fUCM6oMMUlC5Q6raux+QY69w4aZoHtwSxwrAfCv5fg56a3QV/qn1PEtO9bjDYals2zkh1P4EWYnMRClCBshi7l/J92oFJwRmY1fYSWBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VVh97H4v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VVh97H4v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788072995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FptnBRKcAtIMllxmw22IZ9BiQjAJd7jrnVJgzhqT6Fo=;
	b=VVh97H4voabtJ/WEeuzygtpOSHmpKjmRiFoGu+0tjTQ/2UJAZ7/XSa4EOoR1Q+IuE9IJvg
	XUmPxgkBgpISyNK+38Zu0Ri7Ne4xwivzD+SR54DX10LpSjA3XgKkZkZZvsHX15YwdaDpC2
	txTf0ySu+zHHzOFCDVu8LTR0CydmttM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-TQq3h2DePvylOj7zExLRnA-1; Sun, 30 Aug 2026 02:56:32 -0400
X-MC-Unique: TQq3h2DePvylOj7zExLRnA-1
X-Mimecast-MFC-AGG-ID: TQq3h2DePvylOj7zExLRnA_1788072991
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-482f4a554dcso2132941f8f.3
        for <virtualization@lists.linux.dev>; Sat, 29 Aug 2026 23:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788072991; x=1788677791;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FptnBRKcAtIMllxmw22IZ9BiQjAJd7jrnVJgzhqT6Fo=;
        b=ULIqVKv2TiuPiiZ2LZaIysXSkaMHTv6dAADXjfK/evEYqulu4WKpeXkkZOq3bKSzAa
         dVTflclLXcgPrxGORphIRHkp8DSo3AZu8lfaCHpZA66X7SaBtQw0p2wU5H7l3B9/t1Jl
         rBZnVrMKpfEDmbwuRs5rQea727olN4IKTE+QwpktQ3PLOxDLsuDl/6qPX3GPwJOuMcnu
         vw78i40ZG4sT+XPBKIo0vUJfiZSvrfSTh6zDMNJGOpVNubQeqhrNS0Fqc82EfrpT1OeA
         E+tW/AInB6x2tY/kfDAC4P+Nf+9LRb/OwiztI8pslKe1rFAOG4J4DiIlvCP2UimA6ZLK
         i5Lg==
X-Forwarded-Encrypted: i=1; AKwUvBz6AZ9Wa/lPtY92IMPSQRv/GlmFTZ8KpNTOqEGdOc6YuLtBXyFkLTf2hfBXqUfqNGZ51KeXNdZXMXDSJ2gTtA==@lists.linux.dev
X-Gm-Message-State: AFuF++naMclNwDB4SRur3MrWMS539mgWYeKPz2/nEpmkUZsITM47SKEF
	R1xh/7H/KWHfe3DMiG0JBr0Z5v7VAnfUqIc74PxdXUYlEMqtqjPw6QVJUju3fDrN9C4+U/gpzEX
	hOjNwplDhIyNNS4APYwgyxySILlNK+TAmmtXuu8u0PA8LQFojV1ppHVRiuQjCWKg6yOuS
X-Gm-Gg: AYBFou0H2Ml9c7K1AIdQb4WMbTyzZTte84+kltX00EfPacp+lOfr5WtaGml0+hqpuy3
	29Ns7fW4qX1Auo95mcuwc2A1jDIXaFvZ4jtWBTwrUhxovxAjkWZyDWz5IA1fIlBjN6KMCDW8VDZ
	KJXQpRKGYPtQwfFgBBxzk+rNaEqamR37WhsDUv9iLtQAjKeb+nnReufl5Zm47dpFRz3ZIKVBO7y
	BE7osDtcwAfHys3y94M7yIunLbxf4yd07yZ6gStpx+qW70p6XCIHdfxcnSM2Gj9snzuISA5zoR6
	zI55RvTfP5LRpSvsnmTEdkGJJw3lmWSgk3ahsEYNc1+lvWh4Y3kNHQAJMDiw/PYrWLojeeZyAPp
	hm+iWJHUaDaE/HygCAfJ61Hg=
X-Received: by 2002:a5d:5d81:0:b0:47f:c648:e280 with SMTP id ffacd0b85a97d-482f79bf13amr26808130f8f.18.1788072991097;
        Sat, 29 Aug 2026 23:56:31 -0700 (PDT)
X-Received: by 2002:a5d:5d81:0:b0:47f:c648:e280 with SMTP id ffacd0b85a97d-482f79bf13amr26808083f8f.18.1788072990509;
        Sat, 29 Aug 2026 23:56:30 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4843310ab29sm7006881f8f.0.2026.08.29.23.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 23:56:29 -0700 (PDT)
Date: Sun, 30 Aug 2026 02:56:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Brian Daniels <briandaniels@google.com>
Cc: aesteve@redhat.com, eperezma@redhat.com, gnurou@gmail.com,
	jasowang@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH] virtio: Add ID for virtio media
Message-ID: <20260830025559-mutt-send-email-mst@kernel.org>
References: <20260424123123-mutt-send-email-mst@kernel.org>
 <20260828180933.743887-1-briandaniels@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260828180933.743887-1-briandaniels@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XTNwX4aPb8B9OhSIA6_PnqEuVDFrMr8rISu5eqr-NC0_1788072991
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Aug 28, 2026 at 02:09:29PM -0400, Brian Daniels wrote:
> > On Fri, Apr 24, 2026 at 03:37:14PM +0200, Albert Esteve wrote:
> > > On Fri, Apr 24, 2026 at 3:07 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Thu, Apr 09, 2026 at 06:53:41PM +0200, Albert Esteve wrote:
> > > > > Hi,
> > > > >
> > > > >
> > > > > On Tue, Mar 10, 2026 at 9:41 AM Albert Esteve <aesteve@redhat.com> wrote:
> > > > > >
> > > > > > Add VIRTIO_ID_MEDIA definition for virtio-media.
> > > > > >
> > > > > > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > > > >
> > > > > Are there any thoughts on this patch, or any actions I need to take?
> > > > >
> > > > > Thanks,
> > > > > Albert
> > > >
> > > > Create a github issue and request a vote as documented in README.md
> > > 
> > > The inclusion of this ID was already voted and approved. The device
> > > already appears in the VirtIO v1.4 specification, with the same ID (as
> > > linked below). This patch is only meant to translate the decision to
> > > the kernel header.
> > > 
> > > >
> > > > > > ---
> > > > > > While the Linux driver for virtio media is currently under active
> > > > > > development and review [1], the VirtIO v1.4 specification has
> > > > > > already been published and oficially defines the media device type [2].
> > > > > >
> > > > > > Adding the device ID now allows other components and tools to reference it
> > > > > > before the driver lands, and ensures the kernel headers stay aligned
> > > > > > with the specification.
> > > > > >
> > > > > > [1] https://lore.kernel.org/linux-media/20250412-virtio-media-v3-1-97dc94c18398@gmail.com/
> > > > > > [2] https://docs.oasis-open.org/virtio/virtio/v1.4/virtio-v1.4.html#x1-82200022
> > > > > > ---
> > > > > >  include/uapi/linux/virtio_ids.h | 1 +
> > > > > >  1 file changed, 1 insertion(+)
> > > > > >
> > > > > > diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
> > > > > > index 6c12db16faa3a..f9056af0c6223 100644
> > > > > > --- a/include/uapi/linux/virtio_ids.h
> > > > > > +++ b/include/uapi/linux/virtio_ids.h
> > > > > > @@ -69,6 +69,7 @@
> > > > > >  #define VIRTIO_ID_BT                   40 /* virtio bluetooth */
> > > > > >  #define VIRTIO_ID_GPIO                 41 /* virtio gpio */
> > > > > >  #define VIRTIO_ID_SPI                  45 /* virtio spi */
> > > > > > +#define VIRTIO_ID_MEDIA                        48 /* virtio media */
> > > > > >
> > > > > >  /*
> > > > > >   * Virtio Transitional IDs
> > > > > >
> > > > > > ---
> > > > > > base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> > > > > > change-id: 20260310-virtio-media-id-b31179fcdc44
> > > > > >
> > > > > > Best regards,
> > > > > > --
> > > > > > Albert Esteve <aesteve@redhat.com>
> > > > > >
> > > >
> > 
> > 
> > Oh my bad. I misfiled it into the spec folder. I will take care of this.
> > Thanks!
> 
> Any plans to merge this in soon? This is a dependency of the virtio-media driver.
> 
> Thanks!
> Brian

just include it with the driver patchset itself please.

-- 
MST

