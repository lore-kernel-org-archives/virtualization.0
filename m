Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3316713AA37
	for <virtualization@lists.linux.dev>; Tue, 18 Jun 2024 10:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718706814; cv=none; b=SjQ7U3+mmw6HALSTy0yFzai0ovSVuZJwI7L7Z2VdQ4fPd222LfQvNvvtPnbdYM5MLs6c50oLq3Slmsu1ugO/C30GEbc1bae9M7V+6IE5vwpLJ+PtT1XtExu2fGL4akQJBthufuioHPlanJd0lt6vmnJz1mQfmr017AH54JjjIeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718706814; c=relaxed/simple;
	bh=3R4ZmGYRCOnDC4CMT6od2Me4vHZyyR45godSVXHsnik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=aPcELsiJlsPPEwKRNIRif7IJsScRLY8jMCJnGK6J3/XeP9KDtPvcrSWnlaaQ1TdN/aJs+GabqKLNiVkWKMsTsh2enMUGolFr1r6xf9CURPgAkWEoOW5tvJLLAe6dL9JJrbvrxD84ZuGQvwzxQFbQHsaOakd8iXVe+E0uLRmd97Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CYSpdDCf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CYSpdDCf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718706811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f2CpynTXKAlpaIQ4wYDBqhxXchA8ClbLULqxJerRJ5E=;
	b=CYSpdDCfnkpJs5skXErp5WIaLEj8tGmAZly1/00ypxthZiLQCRlhTAb7EH1LvDxT/60qel
	bPTU90rjoVHGUu4xwSYBxK6o4yH4sdtL2mWeZRDgfaIRAIgcVltra0WzgRREOyG3ExbPod
	DeztgTSqSM7G17msbu7l9dIr1ybBdpc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-f9je8WQjM6mhYK_HcIIycg-1; Tue, 18 Jun 2024 06:33:27 -0400
X-MC-Unique: f9je8WQjM6mhYK_HcIIycg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4217b3d2044so40507175e9.0
        for <virtualization@lists.linux.dev>; Tue, 18 Jun 2024 03:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718706805; x=1719311605;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f2CpynTXKAlpaIQ4wYDBqhxXchA8ClbLULqxJerRJ5E=;
        b=lmGjBoiovNniyhbqWVyZpxMiz9U0oXx4n5dKzeALo05gWESQDNUckdUikxv27geiuZ
         gwFzV309HPe2q4K1oZF0EYGIsZttsxbp985xIhbc1+UxkVC5OPg2OZauHXxhL3/ImER/
         agdBRliDb/EjjrjbtMj7LkGApXIkHCNDhs+0j3EAngVvxAsLzJRZ2Y5+cFMcH0hCDAyb
         pftuhypAT4xbZCxyLB1wwLFWl2FO07GJECne9XB1NQummqgW52MerAfCUonKdE7uRw2N
         sI5tACdJXbvsETPaXesNySvFKGOYwSRYL3QM7KuWtQUQrkUQfawmAXdwlJq0935BTgHG
         wAfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1esCkTjVupu3GC+UntthtRkfR3sYYm64WA+2Hi3IoRckq3oEpfZh0wRrTeSohM2L+enNG6A13+bM/Dw8oDhOoH4dABErO4MbEyeCEbxU=
X-Gm-Message-State: AOJu0YxIGxjyNNAR8dG4r2W1XI6EVdEb5hFGXEZ6LlbNde4zUhozSp+3
	8laikFeHZZhu7rXlLxw/0QfYHcHH/5xy1D88xi0gbeTi66IX0HL+x38KFB6JADKhNpWNqiMcslC
	hJVTtvewF9hdIxnVXCm3MMmrnevVHlXnxw1J4ANqD/aJ+IrZ1Wbs6wBtNerp9jYCsxmSTgdkg
X-Received: by 2002:a05:600c:1d29:b0:421:79dc:56e4 with SMTP id 5b1f17b1804b1-42304862690mr89911115e9.41.1718706804949;
        Tue, 18 Jun 2024 03:33:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLRfy7oQumt6boNaSCbATqsBOpWpSCLkxQ2tSrk9aiZf1c10yHgUWugziswJPSySUZAewIvA==
X-Received: by 2002:a05:600c:1d29:b0:421:79dc:56e4 with SMTP id 5b1f17b1804b1-42304862690mr89910975e9.41.1718706804436;
        Tue, 18 Jun 2024 03:33:24 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:67bf:ebbb:9f62:dc29:2bdc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286eef70csm224360215e9.3.2024.06.18.03.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 03:33:23 -0700 (PDT)
Date: Tue, 18 Jun 2024 06:33:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shunsuke Mie <mie@igel.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Subject: Re: [RFC] Legacy Virtio Driver with Device Has Limited Memory Access
Message-ID: <20240618061705-mutt-send-email-mst@kernel.org>
References: <CANXvt5r00Y5VGKSFXFnwbvGF+fhh2uNvU5VBGwECA9yabK4=Uw@mail.gmail.com>
 <20240516125913.GC11261@thinkpad>
 <20240520090809-mutt-send-email-mst@kernel.org>
 <20240614095033.GA59574@thinkpad>
 <CANXvt5ojosFbt60Gcfym1DX96W7SiX4X15dMGdSCVEPhUTpk=w@mail.gmail.com>
 <20240618054115-mutt-send-email-mst@kernel.org>
 <CANXvt5psZAkEOJtxO250n6vjZTK7as-F-4qr1Rc3awZsmqWCpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CANXvt5psZAkEOJtxO250n6vjZTK7as-F-4qr1Rc3awZsmqWCpQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Jun 18, 2024 at 07:15:47PM +0900, Shunsuke Mie wrote:
> Thank you for your response.
> 
> 2024年6月18日(火) 18:47 Michael S. Tsirkin <mst@redhat.com>:
> >
> > On Tue, Jun 18, 2024 at 08:41:09AM +0900, Shunsuke Mie wrote:
> > > Let's clarify the situation.
> > >
> > > The Virtio device and driver are not working properly due to a
> > > combination of the following reasons:
> > >
> > > 1. Regarding VIRTIO_F_ACCESS_PLATFORM:
> > > - The modern spec includes VIRTIO_F_ACCESS_PLATFORM, which allows
> > > Physical DMAC to be used.
> > > - This feature is not available in the legacy spec.
> >
> > ... because legacy drivers don't set it
> >
> > > 2. Regarding Virtio PCIe Capability:
> > > - The modern spec requires Virtio PCIe Capability.
> >
> > It's a PCI capability actually. People have been asking
> > about option to make it a pcie extended capability,
> > but no one did the spec, qemu and driver work, yet.
> >
> > > - In some environments, Virtio PCIe Capability cannot be provided.
> >
> > why not?
> PCIe Endpoint Controller chips are available from several vendors and allow
> software to describe the behavior of PCIe Endpoint functions. However, they
> offer only limited functionality. Specifically, while PCIe bus communication is
> programmable, PCIe Capabilities are fixed and cannot be made to show as
> virtio's.

Okay. So where could these structures live, if not in pci config?

-- 
MST

