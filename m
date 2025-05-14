Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E762276036
	for <virtualization@lists.linux.dev>; Wed, 14 May 2025 12:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747226435; cv=none; b=PgHkGSejbPVqt5V8uQYFM+OKkDa1lkE4ovAYx+JZ9V8At+tkBdYQN0ccyxYm22fczae7qneYets78SFAWTAKutVEarq/Lm8PYT23/qscyiRHztBvNN0teBeG9HDNLrNImjkvha4SQhWlajXn1DwBH+oF6F0ppw3BOlZplEja8WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747226435; c=relaxed/simple;
	bh=l4VZADMEVJnFAQXvFf7wgOzQJUelFDiQAhhzyWvjj6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=S0D9VsMs+R22s20jMEqsXd43Rx9Zl6ron2x+NFysyid1jYmhAFp7O3q29C/BDUYplGxLNcbS8XKiu8zXnKmuyRNzvrT/yQpip/hOHSVUTozLgbahRafXE4h73WRiOhq5j+yyfRXBgIiMHWSlsmaKAwBCa8r0RpzONBKbsXJEoyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i9t8gw9/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i9t8gw9/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747226432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fw0llZnGO4F7e+OkKHs7xd6962MpvChnUrZgYDDb9I0=;
	b=i9t8gw9/jRIxZUg5E8dQEBfurTXN+hd/ga6gWOO+djgPKwPgiE4MMemQYjXRkoad+dHC3r
	T0uvteG2WjF3OOBmQhYtd6725T+eYviiQoDEFZEBhqZ0ugqMq6RN0EOYrPG5P6ASRIVWcg
	muXr2QYLG8PtQJHo+lLQKtBj2uP7IGQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-IGSExqU7Oaq06sjLwtlelA-1; Wed, 14 May 2025 08:40:31 -0400
X-MC-Unique: IGSExqU7Oaq06sjLwtlelA-1
X-Mimecast-MFC-AGG-ID: IGSExqU7Oaq06sjLwtlelA_1747226430
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a0b394504cso419477f8f.1
        for <virtualization@lists.linux.dev>; Wed, 14 May 2025 05:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747226430; x=1747831230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fw0llZnGO4F7e+OkKHs7xd6962MpvChnUrZgYDDb9I0=;
        b=LcL3bnr4CCD8/3km51B76LL1krNbD2QRptlqcdZZvWYZCD4ONAyuE0PyUJekd3W8cC
         9DtTyAYtIIjo8YZBLpBUoyXGvXQTs8CMU6I8H5IUASg1b0B63gEXlIrEQ49SQrCUbf6g
         5qsk6XGdcxvO4p/mZdt4vEQP/hNtvKZXcY1iFSiQmdJ+cjeTgjbYaoX0d/9brcTnJYFU
         2GPpPHxJyoh920KCgc2CzXKqliR5YJc5D5+QFVplwMCTTvm7QOQEDm5Ug/cYbrEiq2hM
         hHiTQmmMVQk3xcLke1h/WN3HXzH5xdwxQwCnb3UGPX3s4Y90wGvGMY+zPnzI5IWhUnpV
         N6OQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXV/jm3K1wwHVF3/EdZuSuz8KG0eVPuIthMVp/3kIjwZKs2fbm6s7m2PER/Kmw2wTQUnL35R5vZ2rDiUkhiw==@lists.linux.dev
X-Gm-Message-State: AOJu0YybmMzRdDqsCay2iyYgssbbFIhwkikbtYUacKICENfqONnWXCKN
	7lgq/NNUsdQ2Qvy/OmgcHO5OhfkwHDv8AFPpS97KeJFHsmc8f1F+ZGwPT7Sxn5y2qBUtIlT/DRS
	NdRVO59kEnEZUQ2mIMmHSvoFrp8Dn9BEhRJoQ+uDvMVrUJ8DS8wiBoJ0vbjScY45r
X-Gm-Gg: ASbGncuXNki/w8yeUEpidN11fnBQ4AVsKLg7+oF3oS8D63xi9P5Whn24ximORjeAG47
	pcZgaTOGphnLIeMQYjiPC1q/4O+lsEmC9/myutkqnwxWSEjJz0bSORNSuZXPMAz7WZm/8V59ZvB
	/UMomyHaZ3Hded4ocnhF0bbsx0RRbeF8wUtEg4XUCYt8qHaPm8IoFtjlhqRLXXGIgBB2CuKiEwp
	C6EZ+cn9ypV1ynii6/O2bxMY+BCCcOoigUTDEETjxJiUr3jjRvu+NZwg3jtkDmHtExVyuMvv0Fg
	G840kg==
X-Received: by 2002:a5d:5888:0:b0:3a1:f70a:1f65 with SMTP id ffacd0b85a97d-3a348ac78demr3422307f8f.0.1747226430090;
        Wed, 14 May 2025 05:40:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/IcHyOtPZThhQmfsHZwZgx5RVpTsWbFQFnsQ1d9kN5ycuPeVc3HAClS1rLwLne8I1m0Er5A==
X-Received: by 2002:a5d:5888:0:b0:3a1:f70a:1f65 with SMTP id ffacd0b85a97d-3a348ac78demr3422283f8f.0.1747226429725;
        Wed, 14 May 2025 05:40:29 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ebd6asm19922424f8f.35.2025.05.14.05.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 05:40:28 -0700 (PDT)
Date: Wed, 14 May 2025 08:40:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, israelr@nvidia.com,
	virtualization@lists.linux.dev, linux-block@vger.kernel.org,
	oren@nvidia.com, nitzanc@nvidia.com, dbenbasat@nvidia.com,
	smalin@nvidia.com, larora@nvidia.com, izach@nvidia.com,
	aaptel@nvidia.com, parav@nvidia.com, kvm@vger.kernel.org
Subject: Re: [PATCH v1 0/2] virtio: Add length checks for device writable
 portions
Message-ID: <20250514083313-mutt-send-email-mst@kernel.org>
References: <20250224233106.8519-1-mgurtovoy@nvidia.com>
 <20250227081747.GE85709@fedora>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250227081747.GE85709@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: h8tjPlFrSLZm2sBH-92fwlgFf-UUtQHh3pzP4x5pWvw_1747226430
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 27, 2025 at 04:17:47PM +0800, Stefan Hajnoczi wrote:
> On Tue, Feb 25, 2025 at 01:31:04AM +0200, Max Gurtovoy wrote:
> > Hi,
> > 
> > This patch series introduces safety checks in virtio-blk and virtio-fs
> > drivers to ensure proper handling of device-writable buffer lengths as
> > specified by the virtio specification.
> > 
> > The virtio specification states:
> > "The driver MUST NOT make assumptions about data in device-writable
> > buffers beyond the first len bytes, and SHOULD ignore this data."
> > 
> > To align with this requirement, we introduce checks in both drivers to
> > verify that the length of data written by the device is at least as
> > large as the expected/needed payload.
> > 
> > If this condition is not met, we set an I/O error status to prevent
> > processing of potentially invalid or incomplete data.
> > 
> > These changes improve the robustness of the drivers and ensure better
> > compliance with the virtio specification.
> > 
> > Max Gurtovoy (2):
> >   virtio_blk: add length check for device writable portion
> >   virtio_fs: add length check for device writable portion
> > 
> >  drivers/block/virtio_blk.c | 20 ++++++++++++++++++++
> >  fs/fuse/virtio_fs.c        |  9 +++++++++
> >  2 files changed, 29 insertions(+)
> > 
> > -- 
> > 2.18.1
> > 
> 
> There are 3 cases:
> 1. The device reports len correctly.
> 2. The device reports len incorrectly, but the in buffers contain valid
>    data.
> 3. The device reports len incorrectly and the in buffers contain invalid
>    data.
> 
> Case 1 does not change behavior.
> 
> Case 3 never worked in the first place. This patch might produce an
> error now where garbage was returned in the past.
> 
> It's case 2 that I'm worried about: users won't be happy if the driver
> stops working with a device that previously worked.

Interestingly, when virtio core unmaps buffers, it always syncronizes
the whole range.
virtio net jumps through hoops to only sync a part.

So Max, my suggestion is to maybe try a combination of dma sync +
unmap, and then this becomes an optimization.

It might be worth it, for when using swiotlb - but the gain will
have to be measured.





> Should we really risk breakage for little benefit?
> 
> I remember there were cases of invalid len values reported by devices in
> the past. Michael might have thoughts about this.
> 
> Stefan


