Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E4C15957E
	for <virtualization@lists.linux.dev>; Wed, 10 Apr 2024 11:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712748006; cv=none; b=uICNXHkKu/O3Y5jrnPmKslCCl48Lk2dfXxt6K1vz97k/dr3kYc3nLidOEIDd7nFoewoGjhTC9D0x1JsH34otCRbH+o7i7U9iUHGvKvzRXfFizt440UCKR7CSeULHLRT+Dwz3VyPmtomJIb9ECsd9heqP6zXgaYI9v7VtVsW9Z7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712748006; c=relaxed/simple;
	bh=LVZSqtyvdv4f4tPaVFCZBpBNjb8CFtFnZkrlQ8BGHi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YqTA+pwoCvCqwhFI5IJOPVcPtOmCHgMybzpG95+yssgKDx1SCE01nfAgSgXfW0MzmBXJvwDZR6o8TkSqJfss1xlsgBYUkLU6Afx3/Xj2pyFkAYunQhd41XqpKFunQ5sV5x2xgBv5ojv2qn5ru5KTCmgoPmu5eB9HFCaLbFERE84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eoGLiD4F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eoGLiD4F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712748003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VPXQJRbW5WzONSPTXPOCPmVVQbnzBIiiLSiKhj6xa8M=;
	b=eoGLiD4FYewnKZYPK7rWIz0TjltCjJhWJ0jm8CHUHIRFi7ONnN1XiFhuToGJgc6TFoRQbN
	SFz3ssNp8DsuaxwPhDAOmoFSbntojR1QAhgX8Fw6UYKyVR+5fca0GJqMNtGzXVSX3YLAwg
	rqbOjvXiyJ+UsNeZYerW3Glb/t5DOYk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-0I0YPdNCODqK_EC_Bo_vqw-1; Wed, 10 Apr 2024 07:20:00 -0400
X-MC-Unique: 0I0YPdNCODqK_EC_Bo_vqw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-343e54fc19bso3295135f8f.2
        for <virtualization@lists.linux.dev>; Wed, 10 Apr 2024 04:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712747999; x=1713352799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPXQJRbW5WzONSPTXPOCPmVVQbnzBIiiLSiKhj6xa8M=;
        b=Oyq753OEtP2I1pfHXRvh8VMRD71m37n2BSAi2TQTAtvMV39RtTjaM6RGl/k1kFjGA+
         8BSf0wGCzo8p7tB2F9fZh132FmInXvGDVzSVR7uyITiRehLr624Z4DChtTxXjQjMc2Fl
         CapG/JDz3etF5yjqHw6RbHcnEeyEu/J0i2hUuTjhbHhSosYvRzBnp6KnEfta4lYyX7t2
         mBpcjw6ZeWJvyrkTunBCQbm43ZU83eUq6AUiWVAH3DQ1Q8u1qC/kxfPSM1aY6NpNefMB
         r+dsM5LWuVZ3OTPzhPsR+3vho77zbmsmZq5WFztBwPgnC4Jiz692eG8qP0dfpA2FVgKu
         4itA==
X-Forwarded-Encrypted: i=1; AJvYcCUjcldPMjJfu94uXAEq2GW4lnwyuCkUPuOQj+C2fBfe648qTZU9I2ZcGKO2xbCBYVDM5CoTh9xOS0AjZIcshZbBVodiyEgkhkbIf+cv2zw=
X-Gm-Message-State: AOJu0YzRgwLyQS+IyuLDbKroP+SxvgduxZm5z7EMqZaJVOvUjZ10DWJU
	k19YzrVG/V5ajD6QsccYfy1lC9qKBGnftBzFp68ETXd7Rf/vdsscya73IVnLJ3Sk+fbkLrMvRDK
	MLhzLeN/BuXr/E73zKHxoxislJ+Cl37oqCSD4HsWtZvrDQ0cID20fMIqtb+kVrGll
X-Received: by 2002:a05:6000:cd1:b0:343:6c81:8fd3 with SMTP id dq17-20020a0560000cd100b003436c818fd3mr1573157wrb.24.1712747999407;
        Wed, 10 Apr 2024 04:19:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhs4nWNAwD9HCGVRC/3oTlEJcGOm4KJUHHSKm+3afcMVo78wtsFqJ/o+29CTvSuItdB/IDmg==
X-Received: by 2002:a05:6000:cd1:b0:343:6c81:8fd3 with SMTP id dq17-20020a0560000cd100b003436c818fd3mr1573146wrb.24.1712747998837;
        Wed, 10 Apr 2024 04:19:58 -0700 (PDT)
Received: from redhat.com ([2a02:14f:179:8bde:8cd:63ff:6fae:3872])
        by smtp.gmail.com with ESMTPSA id r12-20020a5d498c000000b00343e8968917sm13157941wrq.1.2024.04.10.04.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 04:19:58 -0700 (PDT)
Date: Wed, 10 Apr 2024 07:19:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: Jason Wang <jasowang@redhat.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	Vamsi Krishna Attunuru <vattunuru@marvell.com>,
	Shijith Thotton <sthotton@marvell.com>,
	Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>, eperezma <eperezma@redhat.com>
Subject: Re: [EXTERNAL] Re: [PATCH] virtio: vdpa: vDPA driver for Marvell
 OCTEON DPU devices
Message-ID: <20240410071350-mutt-send-email-mst@kernel.org>
References: <20240327112136.2897479-1-schalla@marvell.com>
 <CACGkMEuKhKOtqYUk4Sbv1QmVSuo3AJ1-tX13ZZxdbPmSSNYk9Q@mail.gmail.com>
 <DS0PR18MB53686F5F53AF5D26B7CE37B6A03A2@DS0PR18MB5368.namprd18.prod.outlook.com>
 <CACGkMEuAEsApX0ZT=FWVgtvYwpAVhzQGh_1yrUaN5f8A8K7iCw@mail.gmail.com>
 <DS0PR18MB5368C214A318C026C6A64E45A0062@DS0PR18MB5368.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <DS0PR18MB5368C214A318C026C6A64E45A0062@DS0PR18MB5368.namprd18.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 10, 2024 at 10:15:37AM +0000, Srujana Challa wrote:
> > > > > +
> > > > > +       domain = iommu_get_domain_for_dev(dev);
> > > > > +       if (!domain || domain->type == IOMMU_DOMAIN_IDENTITY) {
> > > > > +               dev_info(dev, "NO-IOMMU\n");
> > > > > +               octep_vdpa_ops.set_map = octep_vdpa_set_map;
> > > >
> > > > Is this a shortcut to have get better performance? DMA API should have
> > > > those greacefully I think.
> > > When IOMMU is disabled on host and set_map/dma_map is not set,
> > > vhost-vdpa is reporting an error "Failed to allocate domain, device is not
> > IOMMU cache coherent capable\n".
> > > Hence we are doing this way to get better performance.
> > 
> > The problem is, assuming the device does not have any internal IOMMU.
> > 
> > 1) If we allow it running without IOMMU, it opens a window for guest
> > to attack the host.
> > 2) If you see perforamnce issue with IOMMU_DOMAIN_IDENTITY, let's
> > report it to DMA/IOMMU maintiner to fix that
> It will be helpful for host networking case when iommu is disabled. 
> Can we take the vfio pci driver approach as a reference where user explicitly set 
> "enable_unsafe_noiommu_mode" using module param?

vfio is a userspace driver so it's userspace's responsibility.
what exactly ensures correctness here? does the device have
an on-chip iommu?

> > 
> > Thanks
> 
> Thanks.
> 

