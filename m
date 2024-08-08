Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E443218EFDC
	for <virtualization@lists.linux.dev>; Thu,  8 Aug 2024 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723129421; cv=none; b=KeyWubTsrBBVCPQo2foKn3Lq+bHDFx/jNHlxeXA4EXUVfUgUdD5zwEXVecWj7af5VvGhWsSnvjNYmcyS4xsMJyKGh/ZvWcYUwSJhH5wGRPXqjVaQm6XxFqMqgcProZN71FnPxrFMYXdkjT/DHKsjtNM2KR4d3nwD2Q9npssFOPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723129421; c=relaxed/simple;
	bh=o9kLwDsO6A9K6j8xf/c6CW0vBtGgQqwBXtILXprIUiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=EWl8U7dkqyGzsXgDCbOF3LiyD/PbWC7vHqYnNpTj/1AKGhi5XgM4449QrGBuhwtkkAHUNrQi3LIFh4ubwvlkpw0FCaIOYvF5B8SgdjYMtyilXUgPAUoQYTmN18wqGCSUuQx2PmmSkaojkOR1R6VJ33dRErn0TepgHkhfaOTkWHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EouY+NhU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EouY+NhU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723129418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MibcXSoq2vjzsX8VjmQt+hKWDJBPxaePrDMf1gWfvyc=;
	b=EouY+NhUULmeSERaxV1+VaSs+kCs3KXbTGhxYEccPtvnqQEzZ9i2VlD42k9WJ2KQdBH3bx
	lwDw+BHaTk6Pe0DaH2lb7Wu9Bf5Z8U9xpkaHYcHhiMctGCOEc6emgci4zHY/trXr56sWHz
	sec0CTn1bQqSXu1J7/1kcosnujgIFKY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-lw7am_3cPT-MJ6mh56sp7w-1; Thu, 08 Aug 2024 11:03:37 -0400
X-MC-Unique: lw7am_3cPT-MJ6mh56sp7w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42809eb7b99so5810455e9.0
        for <virtualization@lists.linux.dev>; Thu, 08 Aug 2024 08:03:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723129416; x=1723734216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MibcXSoq2vjzsX8VjmQt+hKWDJBPxaePrDMf1gWfvyc=;
        b=ak3NBg1/IA8FHe9JRECmDMryOkYE/6kMAdCHmVw+LL6b02dYvSSQZqJI97H5ekCMyS
         sBTitpBesXlhVj5TEY7poAjQp5tCjWnRhCmLQZME3aKceqQp1oySvWnSQlkkOLJ6AeuI
         eHe/7vXCWXGZD2TOpkZ9UApaA50GRXhU0tMhFunXFLCtGcbAqiUnLDLuFfwUYV6+lRiQ
         Ej+ZlCD6fcnhKQN38u1XVjUmsmoLZB8nndgNWGWDob4CYoIn5he/VTfdzo8qwd5AU8Ex
         Q6AnCsaoUabu41BI0x1T+NKRfyeSSA0sBxy3rUI6I0ZQGZcJFXI1s7UeUSLc0MCLDWoh
         r3Yw==
X-Forwarded-Encrypted: i=1; AJvYcCW8zIYn0sqkTNjPYufyrPOJm/kxi+fiiXgJDdtMNZ+fcBTSJL5tIkbbaZUI1r6h5UC07pVM1yt8xSPHnWfSk0RxqOpZ9WoOpwoeK5NEdfA=
X-Gm-Message-State: AOJu0Yz485jyQ0lukRysRHPxLd9zbPuWksaI+DCWSjFiUtXPrbM7a+sx
	4gSnMyz2HMsnx2/NUJdYf4nDLRp8olzLt20oW4tLPTEoPv/vOk5wpmwACgTmBB6+9eTNnRMuAA+
	M7+Nlf3dglJHDOnD3Bshi7MadZkOO0Os8Vz7T8osFmzD8m4AxjDf7q1g8Ixm1+xpm
X-Received: by 2002:a05:600c:4710:b0:428:29e:67cc with SMTP id 5b1f17b1804b1-4290b85c350mr23190785e9.10.1723129415772;
        Thu, 08 Aug 2024 08:03:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0qZ8m6+/YQZHtmKvTjjY1k5UimGT+5++YmR8clsXsMTOPr7cpAXLzkVZUP/l7DqGVh9r5rA==
X-Received: by 2002:a05:600c:4710:b0:428:29e:67cc with SMTP id 5b1f17b1804b1-4290b85c350mr23189515e9.10.1723129414735;
        Thu, 08 Aug 2024 08:03:34 -0700 (PDT)
Received: from redhat.com ([2.55.14.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42905971993sm80105095e9.16.2024.08.08.08.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 08:03:34 -0700 (PDT)
Date: Thu, 8 Aug 2024 11:03:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Hongyu Ning <hongyu.ning@linux.intel.com>
Subject: Re: [PATCH] virtio: Remove virtio devices on device_shutdown()
Message-ID: <20240808105006-mutt-send-email-mst@kernel.org>
References: <20240808075141.3433253-1-kirill.shutemov@linux.intel.com>
 <20240808075701-mutt-send-email-mst@kernel.org>
 <yknu4iege3drk6t2x7pvm2l2cocg4r5qk5jzmboej6dqk5ym2z@g4clogtuuibe>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <yknu4iege3drk6t2x7pvm2l2cocg4r5qk5jzmboej6dqk5ym2z@g4clogtuuibe>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 08, 2024 at 04:15:25PM +0300, Kirill A. Shutemov wrote:
> On Thu, Aug 08, 2024 at 08:10:34AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Aug 08, 2024 at 10:51:41AM +0300, Kirill A. Shutemov wrote:
> > > Hongyu reported a hang on kexec in a VM. QEMU reported invalid memory
> > > accesses during the hang.
> > > 
> > > 	Invalid read at addr 0x102877002, size 2, region '(null)', reason: rejected
> > > 	Invalid write at addr 0x102877A44, size 2, region '(null)', reason: rejected
> > > 	...
> > > 
> > > It was traced down to virtio-console. Kexec works fine if virtio-console
> > > is not in use.
> > 
> > virtio is not doing a lot of 16 bit reads.
> > Are these the reads:
> > 
> >                 virtio_cread(vdev, struct virtio_console_config, cols, &cols);
> >                 virtio_cread(vdev, struct virtio_console_config, rows, &rows);
> > 
> > ?
> > 
> > write is a bit puzzling too. This one?
> > 
> > bool vp_notify(struct virtqueue *vq)
> > {       
> >         /* we write the queue's selector into the notification register to
> >          * signal the other end */
> >         iowrite16(vq->index, (void __iomem *)vq->priv);
> >         return true;
> > }
> 
> Given that we are talking about console issue, any suggestion on how to
> check?


If you do lspci -v on the device, we'll know where the BARs are,
and can compare to 0x102877002, 0x102877A44.

> > > 
> > > Looks like virtio-console continues to write to the MMIO even after
> > > underlying virtio-pci device is removed.
> > 
> > You mention both MMIO and pci, I am confused.
> 
> By MMIO, I mean accesses to PCI BARs. But it is only my *guess* on the
> situation, I have limited knowledge of the area. I am not drivers guy.
> 
> > Removed by what? In what sense?
> 
> So device_shutdown() iterates over all device and we hit the problem when
> we get to virtio-pci devices and call pci_device_shutdown on them.

Hmm that clears bus master.  So maybe what we see is actually
device trying to do DMA and failing? We'll need to know where do
these addresses are on your system.

> I *think* PCI BAR (or something else?) becomes unavailable after that but
> it is still accessed.
> 
> > > 
> > > The problem can be mitigated by removing all virtio devices on virtio
> > > bus shutdown.
> > > 
> > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>
> > 
> > A bit worried about doing so much activity on shutdown,
> > and for all devices, too. I'd like to understand what
> > is going on a bit better - could be a symptom of
> > a bigger problem (e.g. missing handling for suprise
> > removal?).
> 
> I probably should have marked the patch as RFC. The patch was intended to
> start conversation. I am not sure it is correct. This patch just happened
> to work in our setup.
> 
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov

