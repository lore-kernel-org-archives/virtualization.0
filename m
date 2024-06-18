Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A278C15279C
	for <virtualization@lists.linux.dev>; Tue, 18 Jun 2024 10:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718707656; cv=none; b=Fv+lwR/zi61KQgopb71R0ddCteJR0sKUV3F3abE2CKlv6jlHTWFDxZ5zNKLEEJLyNtvU+EZjuZGzcSpEXzxru52g+x9xD16WDs8Rq0MBCsvnApnSzlHSY/ISBkyBfvQmhy3CquhpqaSa9/NgnOVTVmRmtW12KUC6+L9fzeGtZxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718707656; c=relaxed/simple;
	bh=bbFDJ9d+NeKK+CO4zNLMqES2opGAC32Y6IWmOx4SgBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=cNUMLQoqdwKhXcQrkybDtkxgOtRnX16UvhQRbag+vYXgw0N2ttUyzwIS9SMT2ApEAU28tUHhw6ffrpR69NmLBU05ovuGEQpx3ecDPWXw/nPjfabAfLMvva8/vNxTaKAEUH4Z4cqiD6Cv8YRDIid2+FNB1x2mK819H2lN8GNzUBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J5HZVowC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J5HZVowC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718707653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EOUtL3UGrQmccc3gpNc49cvfnyOLInhzKNWaCqBhVrI=;
	b=J5HZVowCAWwuJ0Ntx2TsgkCSs05L0SzQALNbhe1UMZiw3PeaYwWCLwI3T8kLtU3KTba3UE
	laxsBSG6Bk+KVGmEsyMn08YypFa95K+1UPV87iSH0EPIV9fykr5FVUavoOT4r5CWjqO1H8
	MFlCWdaWMir4bjG2omwbrwNDPq9rNcg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-MRVtc8ysPEu6DgH92h1XKw-1; Tue, 18 Jun 2024 06:47:31 -0400
X-MC-Unique: MRVtc8ysPEu6DgH92h1XKw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-421739476b3so47567185e9.2
        for <virtualization@lists.linux.dev>; Tue, 18 Jun 2024 03:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718707650; x=1719312450;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EOUtL3UGrQmccc3gpNc49cvfnyOLInhzKNWaCqBhVrI=;
        b=r5s5/SWAPhLHMu+J2agr/N1lF61ZD3qa6eSTMSDz/bHOxu84OMUTTBYbZikDJdZOdu
         r9V4BLMZdkG1zmuFbntUUajjMiSYXVrOpWw53MK93Gx3iJI7G7F+/wD8v9Q1sHBvm2iC
         qoWYNl2ABjcPPXP2Xram+2xuluZB+1me9Y4ET4QCRNdsolOqoU8vaMl0dgDMQ+LjfBxT
         92QCXdZWYGzb393WMaRW/nSZI0ivT3xjbhrb6CCTcdepAwQf557ZjKQyOZkNAtVTEmoO
         KyT5AOlLOdGpYVkfdva7icS2nf3IptSlqPJhs5e3M6gAaHJEkD2+gNEKTAX742CKDvgt
         sKBw==
X-Forwarded-Encrypted: i=1; AJvYcCWjFEMOh0luBOjlUSY9cTEvWWRNdrdKQy1TMxgAtnI/C4K/8JlgEdq2x9rwNps7U8VKlFU5cpEG8l6tgbRctUDW3YxSNW6RHwASqBjkY1Q=
X-Gm-Message-State: AOJu0YzZnB+hSmw6TCRCpfqNs79jVeF1fZXSWh1G+rrf1/zwk+PVsIOR
	EddXyJL7DLJ3ZARtMSLRruJxhxMn0LXOdImKjgh7rLK+CKLPpFqxsRBH1rZyC8/Hx6eJBKam1qI
	kweo8Rc0OvZ7RVdqbBSWVISVQQwUPyeo+ZArkYnt9sHQGYztOqSL7Op1qxOJtXLG8
X-Received: by 2002:a05:600c:a01:b0:422:50d7:100b with SMTP id 5b1f17b1804b1-42304820c95mr111537585e9.14.1718707650486;
        Tue, 18 Jun 2024 03:47:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4ImD7bgDtwoo7yFTpUhWD2pMBpu08/uRi1Aski/T8Bq/xpyc9IGyMV0M6WmxVCM62NRmy4w==
X-Received: by 2002:a05:600c:a01:b0:422:50d7:100b with SMTP id 5b1f17b1804b1-42304820c95mr111537265e9.14.1718707649552;
        Tue, 18 Jun 2024 03:47:29 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:67bf:ebbb:9f62:dc29:2bdc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750935ecsm13902939f8f.3.2024.06.18.03.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 03:47:28 -0700 (PDT)
Date: Tue, 18 Jun 2024 06:47:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shunsuke Mie <mie@igel.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Subject: Re: [RFC] Legacy Virtio Driver with Device Has Limited Memory Access
Message-ID: <20240618064231-mutt-send-email-mst@kernel.org>
References: <CANXvt5r00Y5VGKSFXFnwbvGF+fhh2uNvU5VBGwECA9yabK4=Uw@mail.gmail.com>
 <20240516125913.GC11261@thinkpad>
 <20240520090809-mutt-send-email-mst@kernel.org>
 <20240614095033.GA59574@thinkpad>
 <CANXvt5ojosFbt60Gcfym1DX96W7SiX4X15dMGdSCVEPhUTpk=w@mail.gmail.com>
 <20240618054115-mutt-send-email-mst@kernel.org>
 <CANXvt5psZAkEOJtxO250n6vjZTK7as-F-4qr1Rc3awZsmqWCpQ@mail.gmail.com>
 <20240618061705-mutt-send-email-mst@kernel.org>
 <CANXvt5pDjvVwFLS3p0a4hx1-MUJGsKHnpEsjejYUcmvTeKyFmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CANXvt5pDjvVwFLS3p0a4hx1-MUJGsKHnpEsjejYUcmvTeKyFmg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Jun 18, 2024 at 07:40:34PM +0900, Shunsuke Mie wrote:
> 2024年6月18日(火) 19:33 Michael S. Tsirkin <mst@redhat.com>:
> >
> > On Tue, Jun 18, 2024 at 07:15:47PM +0900, Shunsuke Mie wrote:
> > > Thank you for your response.
> > >
> > > 2024年6月18日(火) 18:47 Michael S. Tsirkin <mst@redhat.com>:
> > > >
> > > > On Tue, Jun 18, 2024 at 08:41:09AM +0900, Shunsuke Mie wrote:
> > > > > Let's clarify the situation.
> > > > >
> > > > > The Virtio device and driver are not working properly due to a
> > > > > combination of the following reasons:
> > > > >
> > > > > 1. Regarding VIRTIO_F_ACCESS_PLATFORM:
> > > > > - The modern spec includes VIRTIO_F_ACCESS_PLATFORM, which allows
> > > > > Physical DMAC to be used.
> > > > > - This feature is not available in the legacy spec.
> > > >
> > > > ... because legacy drivers don't set it
> > > >
> > > > > 2. Regarding Virtio PCIe Capability:
> > > > > - The modern spec requires Virtio PCIe Capability.
> > > >
> > > > It's a PCI capability actually. People have been asking
> > > > about option to make it a pcie extended capability,
> > > > but no one did the spec, qemu and driver work, yet.
> > > >
> > > > > - In some environments, Virtio PCIe Capability cannot be provided.
> > > >
> > > > why not?
> > > PCIe Endpoint Controller chips are available from several vendors and allow
> > > software to describe the behavior of PCIe Endpoint functions. However, they
> > > offer only limited functionality. Specifically, while PCIe bus communication is
> > > programmable, PCIe Capabilities are fixed and cannot be made to show as
> > > virtio's.
> >
> > Okay. So where could these structures live, if not in pci config?
> What does "these structures" refer to? PCIe Capabilities? virtio configs?

Virtio uses a bunch of read only structures that look like this:

struct virtio_pci_cap {

	..... [skipped, specific to pci config caps] ...

        u8 cfg_type;    /* Identifies the structure. */
        u8 bar;         /* Where to find it. */
        u8 id;          /* Multiple capabilities of the same type */
        u8 padding[2];  /* Pad to full dword. */
        le32 offset;    /* Offset within bar. */
        le32 length;    /* Length of the structure, in bytes. */
};


The driver uses that to locate parts of device interface it
later uses.


Per spec, they are currently in pci config, you are saying some devices
can't have this data in pci config - is that right? Where yes?


> > --
> > MST
> >

