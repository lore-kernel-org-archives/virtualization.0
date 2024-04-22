Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9491B947
	for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 20:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713818587; cv=none; b=Jem4t4vG5v2ZYlWpM7udeb4Lkyj8JkiRbeRjD0NuYA4InWrlWROs7nH5AT/olA2Kbi0G0q7ZHGfON7Y+fA/mFVVbbcK5w/CvzFwlSHf4d8+Bui4ILPDmNyqhxW3lD9UoAFygb5DQAsYNzEj1+B0zEAMmAW0UuRNdCYBdzTi7uEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713818587; c=relaxed/simple;
	bh=slNC76tY0xXsz+h+me9wrs6e3ibCLvTtVKhvJmNNPcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mpMoVViq1qCHNQAg8TMijG0A5iwlRAvVDan5gxhB1enC9hZJ7GciDi8f9PEMEcYh6SORo3fH5Zkhq/ls11lSo8tLPPwvzVW4yfY0TX2GUU+5iynrmV1Vsuvz3Yw1crMs5DoJgkys+DiiXn0HCTi95U9uz8HgjeanikUy2SLiDdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K4fBHei2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K4fBHei2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713818585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=axrUCqB/kLWWtQuGvwCZRb56JiNjqR3I+RwV3AHTxOM=;
	b=K4fBHei2XkGN79uDsE11Ej32TyeHuMIRZdy0F+6IbNXiXsqxpDelRmap66laE9LsKXWpFy
	z0dtOGz9vXJekrDx56qQCxCrcH+NdM8o+8jdnl4AYAYMgpGrs8ml+9o6LC1RflIfIh/1Qt
	jz1IcngDoqUd1hQOeQ7dIpzXEnHAds0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-w10yi75YPLO7xyVQ_ps1aA-1; Mon, 22 Apr 2024 16:43:03 -0400
X-MC-Unique: w10yi75YPLO7xyVQ_ps1aA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-346c08df987so2630463f8f.0
        for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 13:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713818582; x=1714423382;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=axrUCqB/kLWWtQuGvwCZRb56JiNjqR3I+RwV3AHTxOM=;
        b=HsX6tPcnhBaYpfzplSFj/ub+whWjQYfsZnsFA3KdDJT6a993j0hoWwN/Pg06ZUakyE
         VQxj1qypeytpfm1XE93lkI8OpMi24o2l/1S5tZVXFD1n99XaVRxuFFxgBrkh5XusFtmH
         MWAuCoIP0taWcH7Zk4v6hKlUK97RQkbUV//LuXxoQZmkzfvlYN96raZW6dvmO7AmcnJy
         eadZoJKjRkmVqTD/AF6XdEhKYzauSkM2T9wRGMACZKhatUajCqNxmIWrx8Hggt7Q+p3y
         p01xjQAAPl9xnfDA+4iz0ocQo3CKxAMP7VoXKcKoxPnvA/U2Sb8wza4n4/QUXxCEOs7i
         8uHA==
X-Forwarded-Encrypted: i=1; AJvYcCV9LGrUww7yKLHlrpy4soJZnqPTTT4RhUftD3nP9L3vvcpHqCCeccoEvsPEZpegPsCEDPB/tYqHcMBKKdm4SfLn0nryc0LCrf39rBibkMo=
X-Gm-Message-State: AOJu0Yx6SawJen2WALQ5XsGw40jpiUXd6qbsYICgZpZB2ZtVCmbg/7yE
	PV3aB911OVA4rhNLFYBYhd/nutWqJ/tkGZVD9UwI0seVrf1Ov37vlYzlFJBfn8+S1H3/4VOR9IP
	VDiDcVYiYkOuw4gEP9CRWNYJQ1M3z22C30A8Am+fkQ4QPHMM4ZvrWwR76tTfGBxrl
X-Received: by 2002:a5d:4287:0:b0:343:6b42:b3bb with SMTP id k7-20020a5d4287000000b003436b42b3bbmr509947wrq.31.1713818582358;
        Mon, 22 Apr 2024 13:43:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfLf+NtEDQrWtVM6Je4+xrBXM+WRwTMBeuPBmMCgY5u6y+WkC2fno3ieWoSirGBosMNr7FaQ==
X-Received: by 2002:a5d:4287:0:b0:343:6b42:b3bb with SMTP id k7-20020a5d4287000000b003436b42b3bbmr509932wrq.31.1713818581752;
        Mon, 22 Apr 2024 13:43:01 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7429:3c00:dc4a:cd5:7b1c:f7c2])
        by smtp.gmail.com with ESMTPSA id q4-20020adffec4000000b00347f6b5bb6dsm12869753wrs.30.2024.04.22.13.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 13:43:01 -0700 (PDT)
Date: Mon, 22 Apr 2024 16:42:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Srujana Challa <schalla@marvell.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	Vamsi Krishna Attunuru <vattunuru@marvell.com>,
	Shijith Thotton <sthotton@marvell.com>,
	Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>, eperezma <eperezma@redhat.com>
Subject: Re: [EXTERNAL] Re: [PATCH] virtio: vdpa: vDPA driver for Marvell
 OCTEON DPU devices
Message-ID: <20240422164108-mutt-send-email-mst@kernel.org>
References: <DS0PR18MB5368C214A318C026C6A64E45A0062@DS0PR18MB5368.namprd18.prod.outlook.com>
 <20240410071350-mutt-send-email-mst@kernel.org>
 <DS0PR18MB5368C21CDDE827AA2A496510A0062@DS0PR18MB5368.namprd18.prod.outlook.com>
 <CACGkMEvYXPPp9Jbkx4ucXL7WYBkCMggCJJHVZUg2JuNc7DMJPw@mail.gmail.com>
 <DS0PR18MB53685690485AACEEFB8D766CA0042@DS0PR18MB5368.namprd18.prod.outlook.com>
 <CACGkMEvg1ng88-v+ih+LnKgfiSNjJQZTLBkbdM4Z+t9oOosxbw@mail.gmail.com>
 <DS0PR18MB53684432E58CC810569D62D8A0042@DS0PR18MB5368.namprd18.prod.outlook.com>
 <CACGkMEtR-eEc3-MEMMvixZ4w93wNoJjeuqhgNsP=62oZfZHd5A@mail.gmail.com>
 <PH7PR18MB535426965C489176FA9D8281A0092@PH7PR18MB5354.namprd18.prod.outlook.com>
 <CACGkMEtMvb6HOebVxjn8070+PvtPp=9FAvuNA6uKd4NK+L996Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtMvb6HOebVxjn8070+PvtPp=9FAvuNA6uKd4NK+L996Q@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Apr 16, 2024 at 11:17:48AM +0800, Jason Wang wrote:
> On Mon, Apr 15, 2024 at 8:42 PM Srujana Challa <schalla@marvell.com> wrote:
> >
> > > Subject: Re: [EXTERNAL] Re: [PATCH] virtio: vdpa: vDPA driver for Marvell
> > > OCTEON DPU devices
> > >
> > > On Fri, Apr 12, 2024 at 5:49 PM Srujana Challa <schalla@marvell.com> wrote:
> > > >
> > > > > Subject: Re: [EXTERNAL] Re: [PATCH] virtio: vdpa: vDPA driver for
> > > > > Marvell OCTEON DPU devices
> > > > >
> > > > > On Fri, Apr 12, 2024 at 1:13 PM Srujana Challa <schalla@marvell.com>
> > > wrote:
> > > > > >
> > > > > >
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Jason Wang <jasowang@redhat.com>
> > > > > > > Sent: Thursday, April 11, 2024 11:32 AM
> > > > > > > To: Srujana Challa <schalla@marvell.com>
> > > > > > > Cc: Michael S. Tsirkin <mst@redhat.com>;
> > > > > > > virtualization@lists.linux.dev; xuanzhuo@linux.alibaba.com;
> > > > > > > Vamsi Krishna Attunuru <vattunuru@marvell.com>; Shijith Thotton
> > > > > > > <sthotton@marvell.com>; Nithin Kumar Dabilpuram
> > > > > > > <ndabilpuram@marvell.com>; Jerin Jacob <jerinj@marvell.com>;
> > > > > > > eperezma <eperezma@redhat.com>
> > > > > > > Subject: Re: [EXTERNAL] Re: [PATCH] virtio: vdpa: vDPA driver
> > > > > > > for Marvell OCTEON DPU devices
> > > > > > >
> > > > > > > On Wed, Apr 10, 2024 at 8:35 PM Srujana Challa
> > > > > > > <schalla@marvell.com>
> > > > > > > wrote:
> > > > > > > >
> > > > > > > > > Subject: Re: [EXTERNAL] Re: [PATCH] virtio: vdpa: vDPA
> > > > > > > > > driver for Marvell OCTEON DPU devices
> > > > > > > > >
> > > > > > > > > On Wed, Apr 10, 2024 at 10:15:37AM +0000, Srujana Challa wrote:
> > > > > > > > > > > > > > +
> > > > > > > > > > > > > > +       domain = iommu_get_domain_for_dev(dev);
> > > > > > > > > > > > > > +       if (!domain || domain->type ==
> > > > > > > > > > > > > > + IOMMU_DOMAIN_IDENTITY)
> > > > > > > {
> > > > > > > > > > > > > > +               dev_info(dev, "NO-IOMMU\n");
> > > > > > > > > > > > > > +               octep_vdpa_ops.set_map =
> > > > > > > > > > > > > > + octep_vdpa_set_map;
> > > > > > > > > > > > >
> > > > > > > > > > > > > Is this a shortcut to have get better performance?
> > > > > > > > > > > > > DMA API should have those greacefully I think.
> > > > > > > > > > > > When IOMMU is disabled on host and set_map/dma_map is
> > > > > > > > > > > > not set, vhost-vdpa is reporting an error "Failed to
> > > > > > > > > > > > allocate domain, device is not
> > > > > > > > > > > IOMMU cache coherent capable\n".
> > > > > > > > > > > > Hence we are doing this way to get better performance.
> > > > > > > > > > >
> > > > > > > > > > > The problem is, assuming the device does not have any
> > > > > > > > > > > internal
> > > > > > > IOMMU.
> > > > > > > > > > >
> > > > > > > > > > > 1) If we allow it running without IOMMU, it opens a
> > > > > > > > > > > window for guest to attack the host.
> > > > > > > > > > > 2) If you see perforamnce issue with
> > > > > > > > > > > IOMMU_DOMAIN_IDENTITY, let's report it to DMA/IOMMU
> > > > > > > > > > > maintiner to fix that
> > > > > > > > > > It will be helpful for host networking case when iommu is disabled.
> > > > > > > > > > Can we take the vfio pci driver approach as a reference
> > > > > > > > > > where user explicitly set "enable_unsafe_noiommu_mode"
> > > > > > > > > > using module
> > > > > param?
> > > > > > > > >
> > > > > > > > > vfio is a userspace driver so it's userspace's responsibility.
> > > > > > > > > what exactly ensures correctness here? does the device have
> > > > > > > > > an on-chip iommu?
> > > > > > > > >
> > > > > > > > Our device features an on-chip IOMMU, although it is not
> > > > > > > > utilized for host-side targeted DMA operations. We included
> > > > > > > > no-iommu mode in our driver to ensure that host applications,
> > > > > > > > such as DPDK Virtio user PMD, continue to function even when
> > > > > > > > operating in a no-
> > > > > IOMMU mode.
> > > > > > >
> > > > > > > I may miss something but set_map() is empty in this driver. How
> > > > > > > could such isolation be done?
> > > > > >
> > > > > > In no-iommu case, there would be no domain right, and the user of
> > > > > > vhost-vdpa(DPDK virtio user pmd), would create the mapping and
> > > > > > pass the PA (= IOVA) to the device directly. So that, device can
> > > > > > directly DMA to the
> > > > > PA.
> > > > >
> > > > > Yes, but this doesn't differ too much from the case where DMA API is
> > > > > used with IOMMU disabled.
> > > > >
> > > > > Are you saying DMA API introduces overheads in this case?
> > > > No actually, current vhost-vdpa code is not allowing IOMMU disabled
> > > > mode, If set_map/dma_map op is not set. Hence, we are setting set_map
> > > > with dummy api to allow IOMMU disabled mode.
> > > >
> > > > Following is the code snippet from drivers/vhost/vdpa.c
> > > >
> > > >       /* Device want to do DMA by itself */
> > > >         if (ops->set_map || ops->dma_map)
> > > >                 return 0;
> > > >
> > > >         bus = dma_dev->bus;
> > > >         if (!bus)
> > > >                 return -EFAULT;
> > > >
> > > >        if (!device_iommu_capable(dma_dev,
> > > IOMMU_CAP_CACHE_COHERENCY))
> > > >                 return -ENOTSUPP;
> > >
> > > Right, so here's the question.
> > >
> > > When IOMMU is disabled, if there's no isolation from the device on-chip
> > > IOMMU. It might have security implications. For example if we're using PA,
> > > userspace could attack the kernel.
> > >
> > > So there should be some logic in the set_map() to program the on-chip
> > > IOMMU to isolate DMA in that case but I don't see such implementation done
> > > in set_map().
> >
> > Our chip lacks support for on-chip IOMMU for host-side targeted DMA operations.
> > When using the DPDK virtio user PMD, we’ve noticed a significant 80% performance
> > improvement when IOMMU is disabled on specific x86 machines. This performance
> > improvement can be leveraged by embedded platforms where applications run in
> > controlled environment.
> > May be it's a trade-off between security and performance.
> >
> > We can disable the no-iommu support by default and enable it through some module
> > parameter and taint the kernel similar to VFIO driver(enable_unsafe_noiommu_mode) right?
> 
> Could be one way.
> 
> Michael, any thoughts on this?
> 
> Thanks

My thought is there's nothing special about the Marvell chip here.
Merge it normally. Then if you like work on a no-iommu mode in vdpa.


> > >
> > > >
> > > > Performance degradation when iommu enabled is not with DMA API but the
> > > > x86 HW IOMMU translation performance on certain low end x86 machines.
> > >
> > > This might be true but it's not specific to vDPA I think?
> > >
> > > Thanks
> > >
> > > >
> > > > >
> > > > > Thanks
> > > > >
> > > > > >
> > > > > > >
> > > > > > > > We observed performance impacts on certain low-end x86
> > > > > > > > machines when IOMMU mode was enabled.
> > > > > > > > I think, correctness is Host userspace application's
> > > > > > > > responsibility, in this case when vhost-vdpa is used with Host
> > > > > > > > application such as DPDK
> > > > > > > Virtio user PMD.
> > > > > > >
> > > > > > > Thanks
> > > > > > >
> > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Thanks
> > > > > > > > > >
> > > > > > > > > > Thanks.
> > > > > > > > > >
> > > > > > > >
> > > > > >
> > > >
> >

