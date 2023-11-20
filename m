Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719C51B289
	for <virtualization@lists.linux.dev>; Mon, 20 Nov 2023 12:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="anXY541k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700483386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e4OC0yOur0IZ04mctIkt9Weg8mzI9CmT9lSe7QtjZ/I=;
	b=anXY541khFK8Fny1UxdF3iZ9modSvhXcSEPTh9DbrpgmNYqttbTro5gMpuqxhTyH8AvYZE
	aOxhRu0KI/+mnUGEm4Q5ERCyfXg/5wAOskyxuBFEpPzLr9fCleaMuLMs3YJ34R3EqvjbvD
	XQ766vxrU9HT39BfrwPisazJdJy6WQU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-D45Cv2LKN4KwPJTs_sp-4A-1; Mon, 20 Nov 2023 07:29:45 -0500
X-MC-Unique: D45Cv2LKN4KwPJTs_sp-4A-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4083c9b426fso11558435e9.2
        for <virtualization@lists.linux.dev>; Mon, 20 Nov 2023 04:29:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700483383; x=1701088183;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e4OC0yOur0IZ04mctIkt9Weg8mzI9CmT9lSe7QtjZ/I=;
        b=lQX28jiFuToGDvLZqvVzzFpWC77DW46XUMJGoMiNDD8hAONDkXxHbQYYR/3mFnbJkF
         p82vngeGB0RqA9+oZyz8aWOQQ6SaQa2qWXagff9fVjvvJ2AR+WpXeSMhuz6UNbhcohWG
         JqeFgfX/N0lBy/r1ziUuL8mAHrKOW1Mhtz4io5drRoH94TvxIXJcJp4YNAdW5r1KUpa7
         O6M1ffrC7P4DBGTtLrLoMqYjAXAkL7hSEn2e9FfHzPn66sQ2+hiKUzo7G2LmHp7wGzHn
         I0deejSOHQ1+g9D7TmTJrAENDCKHrFzWC603fSgSydIan++PVGFBJvgrNSCroqjvyF7w
         u+eA==
X-Gm-Message-State: AOJu0YwEGoqgS7KdMwPoq4m6zncmyO42WXL5GdhS9v5m2MouiHipGbiw
	gcHgAsbfgCckIqk0ZMovT5IuxPGqTxOLmniz1tta7hemFVoBGbs+g22Su0fywt08vz7cRhcuuVA
	PWGBSrFl7CeUhOR+sMiW6I0FUHkmxoAw6MDw=
X-Received: by 2002:a05:6000:18ad:b0:32d:b06c:d30b with SMTP id b13-20020a05600018ad00b0032db06cd30bmr5730137wri.55.1700483383318;
        Mon, 20 Nov 2023 04:29:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiA5hPdMs1obosTpxknc0+Rt9qQ0WLFLD6MUPyHppA14MnXYwOfQDTbg9QzN09h4w9KTDWZg==
X-Received: by 2002:a05:6000:18ad:b0:32d:b06c:d30b with SMTP id b13-20020a05600018ad00b0032db06cd30bmr5730124wri.55.1700483382944;
        Mon, 20 Nov 2023 04:29:42 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:626e:8b7b:4d17:fb61:4be1])
        by smtp.gmail.com with ESMTPSA id d16-20020adfe2d0000000b003316a2aedadsm10687712wrj.36.2023.11.20.04.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 04:29:42 -0800 (PST)
Date: Mon, 20 Nov 2023 07:29:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Reshetova, Elena" <elena.reshetova@intel.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
Subject: Re: Using packed virtqueues in Confidential VMs
Message-ID: <20231120072623-mutt-send-email-mst@kernel.org>
References: <20231116200245.GA336841@fedora>
 <DM8PR11MB5750765B1310C904A8B1B00BE7B4A@DM8PR11MB5750.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <DM8PR11MB5750765B1310C904A8B1B00BE7B4A@DM8PR11MB5750.namprd11.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Nov 20, 2023 at 10:13:15AM +0000, Reshetova, Elena wrote:
> Hi Stefan, 
> 
> Thank you for following up on this! Please find my comments inline. 
> 
> > -----Original Message-----
> > From: Stefan Hajnoczi <stefanha@redhat.com>
> > Sent: Thursday, November 16, 2023 10:03 PM
> > To: Reshetova, Elena <elena.reshetova@intel.com>
> > Cc: Michael S. Tsirkin <mst@redhat.com>; virtio-dev@lists.oasis-open.org;
> > virtualization@lists.linux.dev
> > Subject: Using packed virtqueues in Confidential VMs
> > 
> > Hi Elena,
> > You raised concerns about using packed virtqueues with untrusted devices at
> > Linux Plumbers Conference. I reviewed the specification and did not find
> > fundamental issues that would preclude the use of packed virtqueues in
> > untrusted devices. Do you have more information about issues with packed
> > virtqueues?
> 
> First of all a bit of clarification: our overall logic for making our first reference
> release of Linux intel tdx stacks [1] was to enable only minimal required
> functionality and this also applied to numerous modes that virtio provided. 
> Because for each enabled functionality we would have to do a code audit and
> a proper fuzzing setup and all of this requires resources. 

However, both with packed and split I don't think speculation barriers
have been added and they are likely to be needed.
I wonder whether your fuzzing included attempts to force spectre like 
leaks based on speculation execution.

> 
> The choice of split queue was a natural first step since it is the most straightforward
> to understand (at least it was for us, bare in mind we are not experts in virtio as
> you are) and the fact that there was work already done ([2] and other patches)
> to harden the descriptors for split queue. 
> 
> [1] https://github.com/intel/tdx-tools 
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/virtio?h=v6.6-rc4&id=72b5e8958738aaa453db5149e6ca3bcf416023b9
> 
> I remember looking at the packed queue long ago and noticing that at least
> some descriptor fields are under device control and I wasn’t sure why the similar 
> hardening was not done here as for the split case.

packed has R/W descriptors. This means however that data is copied over
from descriptor and validated before use.


> However, we had many
> issues to handle in past, and since we didn’t need the packed queue, we
> never went to investigate this further. 
> It is also possible that we simply misunderstood the code at that point.
> 
> > 
> > I also reviewed Linux's virtio_ring.c to look for implementation issues. One
> > thing I noticed was that detach_buf_packed -> vring_unmap_desc_packed trusts
> > the fields of indirect descriptors that have been mapped to the device:
> > 
> >   flags = le16_to_cpu(desc->flags);
> > 
> >   dma_unmap_page(vring_dma_dev(vq),
> >                  le64_to_cpu(desc->addr),
> >                  le32_to_cpu(desc->len),
> >                  (flags & VRING_DESC_F_WRITE) ?
> >                  DMA_FROM_DEVICE : DMA_TO_DEVICE);
> 
> 
> > 
> > This could be problematic if the device is able to modify indirect descriptors.
> > However, the indirect descriptor table is mapped with DMA_TO_DEVICE:
> > 
> >   addr = vring_map_single(vq, desc,
> >                           total_sg * sizeof(struct vring_packed_desc),
> >                           DMA_TO_DEVICE);
> > 
> > There is no problem when there is an enforcing IOMMU that maps the page with
> > read-only permissions but that's not always the case. 
> 
> We don’t use IOMMU at the moment for the confidential guest, since we don’t
> have to (memory is encrypted/protected) and only explicitly shared pages are
> available for the host/devices to modify. 
> Do I understand it correctly that in our case the indirect descriptor table will 
> end up mapped shared for this mode to work and then there is no protection? 
> 

I think this whole table is copied to swiotlb (this is what DMA_TO_DEVICE
AFAIK).

> Software devices (QEMU,
> > vhost kernel, or vhost-user) usually have full access to guest RAM. They can
> > cause dma_unmap_page() to be invoked with arguments of their choice (except
> > for
> > the first argument) by modifying indirect descriptors.
> > 
> > I am not sure if this poses a danger since software devices already have access
> > to guest RAM, but I think this code is risky. It would be safer for the driver
> > to stash away the arguments needed for dma_unmap_page() in memory that is
> > not
> > mapped to the device.
> > 
> > Other than that, I didn't find any issues with the packed virtqueue
> > implementation.
> 
> Thank you for looking into this! Even if we didn’t need the packed queue, 
> I am sure other deployments might need it and it would be the best for 
> virtio to provide all modes that are secure. 
> 
> Best Regards,
> Elena.
> 
> > 
> > Stefan

