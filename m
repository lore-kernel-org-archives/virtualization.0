Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E979E182DB
	for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 07:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718783905; cv=none; b=WGrYMUSFlHEA+8l3AdXhzD7m9uHo7k9VSXrJNfjpFXrMr8c5uu4bGT/PQyvPS38M6ZNbf/GV/a6lZrDkyKMlE9tlhyPrMysPs3dxLg+nsBGLV4r6jYFwYi9ifaW67N4M2r63RgHMptQa+53NXbcwvLVAvOLrwvSQUBWXEwLVd2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718783905; c=relaxed/simple;
	bh=F+nCQotwyBJ/AYl6K244TiJ9pbK87bZbSD51hie1cSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=eigiUQivffYfecR+AtC9D19ha88vbfiAg1bYcmrx5MlvjzpskGAiYAOkE9MHwVQXvuXIVBmXqC36+HNA7Qq0kreevAeTxb00rvn+H4yvh7aFLxU7GUQT+FS54GIXTyff/qbA9y20pn9uZk8omM9efbTFoSTYuYW5IrVQ/eePWp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MjvRIpvc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MjvRIpvc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718783902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ANzmvHUQ5AIaHRYaMSvxHwn59q2Kn3fvsfBTKnY6KpY=;
	b=MjvRIpvcokLwNkAQAqAViD+uoRu7PCC+2Dr+XE8GJJjo8uswTEFuiZFNKcQ/8jz6nGqzhO
	QG+krbcMjD08XlFhbAsPA6PIRJfuRMBNOp4y2X+vAVQHRaGBSkfhdmguvU10c/taxDNM3Q
	PRqgRWGrNuqT7YX3bPkyCVJre+6KIuU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-u9A99Q3WN6quD7QY1f_t4Q-1; Wed, 19 Jun 2024 03:58:21 -0400
X-MC-Unique: u9A99Q3WN6quD7QY1f_t4Q-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3636413fcc5so285543f8f.3
        for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 00:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718783900; x=1719388700;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ANzmvHUQ5AIaHRYaMSvxHwn59q2Kn3fvsfBTKnY6KpY=;
        b=sfg9gSnCqCBRhvZ4IgsL6043s5EJ0JUeztFjd3+GaSCHKldLsIOoYamOTHWSIOlRiK
         xPtLEM8Gxeb/ITILBjKZZBdpO1LYdGICap3D+ZQaNkYxpNftjfdeEiAUGSsGfZRkU4vC
         DaFMuECW4I6Wme5rh/lIGBLUYatfyavBDEL/uu9F2Oij2GLkfNJngnN+V+q+CzS/KpLS
         I2kp5oEzMlLVTgSSAVa4BenOydTMEI5QtpiMZpS4JYFBYGF8v43Jaaa9cB0khVtSj4nK
         5KyRO9AgBRjocGqwiImb9HlC1+Xl2Br1ckVdZg7WHiHfJY/eUbz9eKiYh+exe56hWa4W
         SzfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCfWIZYAoA7PR3agPFVsLLLIKazO6/tq3lEP7EQoGhver7KI1N8T+n0uYUGI+8Awbmztz2Mov+JuUbshT50TUV/PEtX80H1bieSZLexc0=
X-Gm-Message-State: AOJu0YwnKjZkxLPWElDiEKc0XskhsEYC9YDjEHVcnzDkifnVkx8nMOAc
	x17fDxZtZ0VrchzRkO8BP8EUEFFvIoTlG783600u8yHNlwj2AFrdronD+orbFYEwLOhbepXWueS
	LzeSACjWaxjO+4VYNBNLPwEOxIFYV6mBW6rgNBSYOVwdXf0r13vFFWOJy44FsN5RJ
X-Received: by 2002:adf:f04e:0:b0:360:9180:760f with SMTP id ffacd0b85a97d-36319a85e94mr1263561f8f.66.1718783899974;
        Wed, 19 Jun 2024 00:58:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWemWDy24QaqC3xrYRq1zbjmVl3kkTcoVG68ij7komu3mePTPqa6b8OU/wc/Neez6+/OKD1g==
X-Received: by 2002:adf:f04e:0:b0:360:9180:760f with SMTP id ffacd0b85a97d-36319a85e94mr1263536f8f.66.1718783899449;
        Wed, 19 Jun 2024 00:58:19 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750acfeasm16388562f8f.65.2024.06.19.00.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 00:58:18 -0700 (PDT)
Date: Wed, 19 Jun 2024 03:58:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Shunsuke Mie <mie@igel.co.jp>, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Subject: Re: [RFC] Legacy Virtio Driver with Device Has Limited Memory Access
Message-ID: <20240619035655-mutt-send-email-mst@kernel.org>
References: <20240614095033.GA59574@thinkpad>
 <CANXvt5ojosFbt60Gcfym1DX96W7SiX4X15dMGdSCVEPhUTpk=w@mail.gmail.com>
 <20240618054115-mutt-send-email-mst@kernel.org>
 <CANXvt5psZAkEOJtxO250n6vjZTK7as-F-4qr1Rc3awZsmqWCpQ@mail.gmail.com>
 <20240618061705-mutt-send-email-mst@kernel.org>
 <CANXvt5pDjvVwFLS3p0a4hx1-MUJGsKHnpEsjejYUcmvTeKyFmg@mail.gmail.com>
 <20240618064231-mutt-send-email-mst@kernel.org>
 <CANXvt5pbdsSMc9C-nV0MiOAJPVyxXKu5otwLp2yopqBdNLS26A@mail.gmail.com>
 <20240619032703-mutt-send-email-mst@kernel.org>
 <20240619073929.GA8089@thinkpad>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240619073929.GA8089@thinkpad>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jun 19, 2024 at 01:09:29PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Jun 19, 2024 at 03:32:41AM -0400, Michael S. Tsirkin wrote:
> > On Tue, Jun 18, 2024 at 09:51:41PM +0900, Shunsuke Mie wrote:
> > > 2024年6月18日(火) 19:47 Michael S. Tsirkin <mst@redhat.com>:
> > > >
> > > > On Tue, Jun 18, 2024 at 07:40:34PM +0900, Shunsuke Mie wrote:
> > > > > 2024年6月18日(火) 19:33 Michael S. Tsirkin <mst@redhat.com>:
> > > > > >
> > > > > > On Tue, Jun 18, 2024 at 07:15:47PM +0900, Shunsuke Mie wrote:
> > > > > > > Thank you for your response.
> > > > > > >
> > > > > > > 2024年6月18日(火) 18:47 Michael S. Tsirkin <mst@redhat.com>:
> > > > > > > >
> > > > > > > > On Tue, Jun 18, 2024 at 08:41:09AM +0900, Shunsuke Mie wrote:
> > > > > > > > > Let's clarify the situation.
> > > > > > > > >
> > > > > > > > > The Virtio device and driver are not working properly due to a
> > > > > > > > > combination of the following reasons:
> > > > > > > > >
> > > > > > > > > 1. Regarding VIRTIO_F_ACCESS_PLATFORM:
> > > > > > > > > - The modern spec includes VIRTIO_F_ACCESS_PLATFORM, which allows
> > > > > > > > > Physical DMAC to be used.
> > > > > > > > > - This feature is not available in the legacy spec.
> > > > > > > >
> > > > > > > > ... because legacy drivers don't set it
> > > > > > > >
> > > > > > > > > 2. Regarding Virtio PCIe Capability:
> > > > > > > > > - The modern spec requires Virtio PCIe Capability.
> > > > > > > >
> > > > > > > > It's a PCI capability actually. People have been asking
> > > > > > > > about option to make it a pcie extended capability,
> > > > > > > > but no one did the spec, qemu and driver work, yet.
> > > > > > > >
> > > > > > > > > - In some environments, Virtio PCIe Capability cannot be provided.
> > > > > > > >
> > > > > > > > why not?
> > > > > > > PCIe Endpoint Controller chips are available from several vendors and allow
> > > > > > > software to describe the behavior of PCIe Endpoint functions. However, they
> > > > > > > offer only limited functionality. Specifically, while PCIe bus communication is
> > > > > > > programmable, PCIe Capabilities are fixed and cannot be made to show as
> > > > > > > virtio's.
> > > > > >
> > > > > > Okay. So where could these structures live, if not in pci config?
> > > > > What does "these structures" refer to? PCIe Capabilities? virtio configs?
> > > >
> > > > Virtio uses a bunch of read only structures that look like this:
> > > >
> > > > struct virtio_pci_cap {
> > > >
> > > >         ..... [skipped, specific to pci config caps] ...
> > > >
> > > >         u8 cfg_type;    /* Identifies the structure. */
> > > >         u8 bar;         /* Where to find it. */
> > > >         u8 id;          /* Multiple capabilities of the same type */
> > > >         u8 padding[2];  /* Pad to full dword. */
> > > >         le32 offset;    /* Offset within bar. */
> > > >         le32 length;    /* Length of the structure, in bytes. */
> > > > };
> > > >
> > > >
> > > > The driver uses that to locate parts of device interface it
> > > > later uses.
> > > >
> > > >
> > > > Per spec, they are currently in pci config, you are saying some devices
> > > > can't have this data in pci config - is that right? Where yes?
> > > I understood. The configuration structure is in the space that is
> > > indicated by BAR0.
> > > Follows the instructions in the spec:
> > > ```
> > > 4.1.4.10 Legacy Interfaces: A Note on PCI Device Layout
> > > Transitional devices MUST present part of configuration registers in a
> > > legacy configuration structure in BAR0 in the first I/O region of the
> > > PCI device, as documented below.
> > > ...
> > > ```
> > 
> > No, and it's best everyone stopped talking about legacy like we
> > are going to add new features to it.
> > 
> > The configuration structure is in the space that is
> > indicated by the vendor specific structure, which is currently
> > in pci config space.
> > 
> > If use of a vendor specific structure in pci config space is
> > problematic, we can try to fix that by extending the virtio spec.
> > 
> 
> It is indeed problematic as the device vendors usually use those capability
> registers themselves and wouldn't allow users to configure them.
> 
> So if the spec is ammended to support other way of finding the virtio config
> structures, then it would really unblock us from supporting modern virtio
> devices.
> 
> - Mani

Okay.
Anyone from your side can join the virtio TC to champion this?
We don't have anyone knowledgeable about this protocol ATM AFAIK.


> > 
> > > >
> > > > > > --
> > > > > > MST
> > > > > >
> > > >
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

