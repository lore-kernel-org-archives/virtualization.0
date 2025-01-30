Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8791E9B24
	for <virtualization@lists.linux.dev>; Thu, 30 Jan 2025 15:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738252654; cv=none; b=fi4fDg4xhkUdV5q8nA1h14gGWgxUlwVWGdsqCkZiE1xUPBMEeGj1uHOdqjrRY5terMtgXCmpTUzP9APQ6RnftLaWa2GBc8xlRnz3RBQyYHOJd/YTIJTJudy+jPaxVBJP/eXgwrmE4L/1q4Zc2fd9difRdoGlIgfHjKMxwQQ4og8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738252654; c=relaxed/simple;
	bh=G2KWCKxGBBnMxM2TX/y2N4+aloxOeEzYQkrSkO2/u8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=n5RQ8mO12jXXU6uvJS61012WmpDP2A0ZYFH9aLA9NftkJN6mS3IrjuBexoglvZjFfkADyQUPqzFG5WzkGgHFMXlikLVNbbrxImwTJ+kvQMM7jQR/j3pR3dC96gIpUUbbiM50iRw9al7c30aLahRqDrW+qgwAIGPHS6AhGJLZqGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HgiVo4+e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HgiVo4+e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738252651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OfIfoDV3TmglxAm7xSDzWNpXN75A+eqXicgT0bWuM1E=;
	b=HgiVo4+ekz5zONbWgIGDT2vWAV7mH9kly2Agsa/PneyHRxZhZXSrVOecYnU0dJSgpeV/7c
	oAwXtwEQ+hpZJ/sOqoJwnkroWyLe1pnE79xT9Rfous26R9qxbjSnEpvvD2j3C3tD/MIWO3
	rf5EZURVRco1iReSY+Ndi+UeuToMC5E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-H-SN-caxPY6t-CEAtT2Y3g-1; Thu, 30 Jan 2025 10:57:30 -0500
X-MC-Unique: H-SN-caxPY6t-CEAtT2Y3g-1
X-Mimecast-MFC-AGG-ID: H-SN-caxPY6t-CEAtT2Y3g
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4362153dcd6so4940715e9.2
        for <virtualization@lists.linux.dev>; Thu, 30 Jan 2025 07:57:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738252649; x=1738857449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfIfoDV3TmglxAm7xSDzWNpXN75A+eqXicgT0bWuM1E=;
        b=wpsITu6ZDG4boIADFOSrYBD7Vy88cmU3nen817ZUbXRrgUiyRhUcg/fzuTYnQncVag
         igwir4RUt6kWZ6IevC/eJrPgNLS0Kg17q0M7w1yPNq3HvOW/frdqGMuXOaAA9vQBXnEd
         cv44J03D/ODTxSoQXB/ekZLELATKUAth0Zgw3bn1Y+83HWYk8x3qEtV1wle7QDmKDDez
         1/8hktctVRaKCSznrEZkps66qAe/LfIM5KTb/ESxQlZaZZY1cqGTBbfDSzCEQg3C0jrO
         PYZgBLpL51DOyKzRyUId1VeWeK4kCQ2z/TBwJVMNoMlUUUWouVxmaff+SpAeTrmjbSJR
         bSHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQ0Fxu71FMsCpNHgnE8lYlLawe0AjJSUW0uaeWA0sBLroryONsxYEJlpkwJjr0vhothun2grPBSGdcwU6djA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxrIMO4CKWFYS73nTjL1saidPGwd5C/Rufhzb1p3cLLFSdDqDnb
	dliQPLzCafcaDoGwK3Apf/O5X9H2bq9CLdUA4lcqqtKs2FpD4Xdw9mZMFUwTgMDrskX7X+pjvg3
	cXb0Tek+N5ugUuxETR9CG8pcuvJK5F5UZ5OsQ1tRFx9fv7Q5QbOoGzfZfCI+M6MHZ
X-Gm-Gg: ASbGncufP58jTYfYnpQJ2a4UBGpRDPjcM7PYsP7B3sNKfSrblOYn596TqwlEzCek8Fn
	duIfD+SRBksCJjHUaRB5z4pRKwIYjvQi6prnaEk0p4R/wJANnz25agJ6A8VKWVjPFy++07KSPQG
	fxpAVrpsRJevmJIZlpgDwjfyw1eOg3B0qq1gD7yj9ReMntjyzrSf0zNyOlt0DtmibEW8y803p20
	b7uNdPynUqc8KW687ijNiW2kPvUWlNkaykf9GQji4IoergrQmQJADdjgwDBbooAh0lA1iuj+gj6
X-Received: by 2002:a05:600c:198b:b0:434:a468:4a57 with SMTP id 5b1f17b1804b1-438dc428740mr61154845e9.26.1738252648689;
        Thu, 30 Jan 2025 07:57:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpsduzY13GpiVBA+ILTsmN21ZsHEQqq7w157Dzff267xbbLPcjTMCqC0hm/7ck3TRq9eaZoA==
X-Received: by 2002:a05:600c:198b:b0:434:a468:4a57 with SMTP id 5b1f17b1804b1-438dc428740mr61154675e9.26.1738252648348;
        Thu, 30 Jan 2025 07:57:28 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:25e:64cf:ae20:59ee:ed31:b415])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438e244ef41sm27952285e9.32.2025.01.30.07.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 07:57:27 -0800 (PST)
Date: Thu, 30 Jan 2025 10:57:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Israel Rukshin <israelr@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	virtualization@lists.linux.dev,
	Linux-block <linux-block@vger.kernel.org>,
	Nitzan Carmi <nitzanc@nvidia.com>, kvm@vger.kernel.org
Subject: Re: [PATCH 2/2] virtio_blk: Add support for transport error recovery
Message-ID: <20250130105700-mutt-send-email-mst@kernel.org>
References: <1732690652-3065-1-git-send-email-israelr@nvidia.com>
 <1732690652-3065-3-git-send-email-israelr@nvidia.com>
 <20250130154837.GB223554@fedora>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250130154837.GB223554@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7atDJHlLyCGiZAFW912JrdMz42PyKW1GlD3sVCzwBWg_1738252649
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 30, 2025 at 10:48:37AM -0500, Stefan Hajnoczi wrote:
> On Wed, Nov 27, 2024 at 08:57:32AM +0200, Israel Rukshin wrote:
> > Add support for proper cleanup and re-initialization of virtio-blk devices
> > during transport reset error recovery flow.
> > This enhancement includes:
> > - Pre-reset handler (reset_prepare) to perform device-specific cleanup
> > - Post-reset handler (reset_done) to re-initialize the device
> > 
> > These changes allow the device to recover from various reset scenarios,
> > ensuring proper functionality after a reset event occurs.
> > Without this implementation, the device cannot properly recover from
> > resets, potentially leading to undefined behavior or device malfunction.
> > 
> > This feature has been tested using PCI transport with Function Level
> > Reset (FLR) as an example reset mechanism. The reset can be triggered
> > manually via sysfs (echo 1 > /sys/bus/pci/devices/$PCI_ADDR/reset).
> > 
> > Signed-off-by: Israel Rukshin <israelr@nvidia.com>
> > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > ---
> >  drivers/block/virtio_blk.c | 28 +++++++++++++++++++++++++---
> >  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

Sorry this is in Linus' tree, I can not attach your ack.


