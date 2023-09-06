Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A175EB8FD0
	for <virtualization@archiver.kernel.org>; Wed,  6 Sep 2023 13:20:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8704941B33;
	Wed,  6 Sep 2023 13:20:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8704941B33
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ywkMJ6J1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RUxog8mTjccr; Wed,  6 Sep 2023 13:20:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 81288418B8;
	Wed,  6 Sep 2023 13:20:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 81288418B8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5FFE3C0039;
	Wed,  6 Sep 2023 13:20:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9FADC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Sep 2023 13:20:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B7927812F3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Sep 2023 13:20:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B7927812F3
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=ywkMJ6J1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1FO4cM-2ZJCu
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Sep 2023 13:20:29 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 65B1C812E9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Sep 2023 13:20:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 65B1C812E9
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40078c4855fso35818815e9.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 06 Sep 2023 06:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694006427; x=1694611227;
 darn=lists.linux-foundation.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ki5Uz9CgdK2xnF6/l+CWE0oH9syB5MP3FWtLwILQp2g=;
 b=ywkMJ6J1andb3DPS/mQtUOElEKosrpBgmEJ4NKk8NSXVjsFQNiMh4YxRCyB2w9C5gA
 O4DYaxPtZQF9kn9TVmbb3fe0bvbVikbciynIQT603pO+caot3tbWJ3sZCnTcgS1qgTyH
 td6OgxLnyUdxt+cvAJfj1200iSlt+JfRS04UWvNySEQv0rLyD38D0drA9bcxPRR0UNno
 4hCV1GNspIC/D9Se4lq9yRNxhEAYQ3toC9yg3TCBcL9I/wScpsebQ/dufL4xTfUGkjz7
 84mt4CojhBHKw8chQWYL/68NvMmjfGdzTCdG0sFsHNEjCIJJTwQ3uv5nzNi0bEv6fD3r
 TyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694006427; x=1694611227;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ki5Uz9CgdK2xnF6/l+CWE0oH9syB5MP3FWtLwILQp2g=;
 b=XRh+STWtFK3tIQWodV7I/sQyRlu2MDYihSueAEvEe6CkSco6ug28gzMYRCI4s5T9ue
 XHlf1XWajth5rE8EMt3LdcFbEc9lzlBTMOqXPtoCo7v/iTUDDxSrb+v1RH957zd9BL5H
 Lg/ZrAT8ndJnqeRtZYSg/hkbhJncr8tYuUliItdehnwgZn/7NlvEZ4vN6JeY1zVEPM19
 uyQ0lz8FGRddUTXhFAAI+qH5hi+MhVnJ4zGrx42vriVEBT5kmQBNOmuRSkLXtT8T0pIO
 OGJsOIuFaW8xgQ0oG09+dMB4vE8nVh1xxr0+m1xS1vHOJEEQ3n8oeyfypPx4JdwCXA54
 Cprg==
X-Gm-Message-State: AOJu0YwX84bO+lHJrihYikG5iLG/vxudh8YPivOxOaKFtuVFFUO9p5vC
 DB3IgshgSXFD37LUrYoHWwm+xTkJcDDXvFKSzCA=
X-Google-Smtp-Source: AGHT+IF4QWUQBcbeoUunoq7LEw1J08TG+zpBXE6UdNmhDhLqyVBkWUYDBW6gzLZzNF7OF2sRejDSKA==
X-Received: by 2002:a5d:574c:0:b0:317:55c:4936 with SMTP id
 q12-20020a5d574c000000b00317055c4936mr2512131wrw.9.1694006427137; 
 Wed, 06 Sep 2023 06:20:27 -0700 (PDT)
Received: from myrica ([2.220.83.24]) by smtp.gmail.com with ESMTPSA id
 x16-20020adfffd0000000b0031c8a43712asm20541623wrs.69.2023.09.06.06.20.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 06:20:26 -0700 (PDT)
Date: Wed, 6 Sep 2023 14:20:31 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Subject: Re: [PATCH 2/2] iommu/virtio: Add ops->flush_iotlb_all and enable
 deferred flush
Message-ID: <20230906132031.GA1528947@myrica>
References: <20230825-viommu-sync-map-v1-0-56bdcfaa29ec@linux.ibm.com>
 <20230825-viommu-sync-map-v1-2-56bdcfaa29ec@linux.ibm.com>
 <20230904153403.GB815284@myrica>
 <f1259993-2419-9c9e-30d3-0631ef938679@arm.com>
 <ba38b6d90e1f24f249ed8a18e65c403be6ff90e9.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ba38b6d90e1f24f249ed8a18e65c403be6ff90e9.camel@linux.ibm.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eric.auger@redhat.com, iommu@lists.linux.dev, Will Deacon <will@kernel.org>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Sep 06, 2023 at 09:55:49AM +0200, Niklas Schnelle wrote:
> On Mon, 2023-09-04 at 17:33 +0100, Robin Murphy wrote:
> > On 2023-09-04 16:34, Jean-Philippe Brucker wrote:
> > > On Fri, Aug 25, 2023 at 05:21:26PM +0200, Niklas Schnelle wrote:
> > > > Add ops->flush_iotlb_all operation to enable virtio-iommu for the
> > > > dma-iommu deferred flush scheme. This results inn a significant increase
> > > 
> > > in
> > > 
> > > > in performance in exchange for a window in which devices can still
> > > > access previously IOMMU mapped memory. To get back to the prior behavior
> > > > iommu.strict=1 may be set on the kernel command line.
> > > 
> > > Maybe add that it depends on CONFIG_IOMMU_DEFAULT_DMA_{LAZY,STRICT} as
> > > well, because I've seen kernel configs that enable either.
> > 
> > Indeed, I'd be inclined phrase it in terms of the driver now actually 
> > being able to honour lazy mode when requested (which happens to be the 
> > default on x86), rather than as if it might be some 
> > potentially-unexpected change in behaviour.
> > 
> > Thanks,
> > Robin.
> 
> I kept running this series on a KVM guest on my private workstation
> (QEMU v8.0.4) and while running iperf3 on a passed-through Intel 82599
> VF. I got a bunch of IOMMU events similar to the following as well as
> card resets in the host.
> 
> ..
> [ 5959.338214] vfio-pci 0000:04:10.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0037 address=0x7b657064 flags=0x0000]
> [ 5963.353429] ixgbe 0000:03:00.0 enp3s0: Detected Tx Unit Hang
>                  Tx Queue             <0>
>                  TDH, TDT             <93>, <9d>
>                  next_to_use          <9d>
>                  next_to_clean        <93>
>                tx_buffer_info[next_to_clean]
>                  time_stamp           <10019e800>
>                  jiffies              <10019ec80>
> ...
> 
> I retested on v6.5 vanilla (guest & host) and still get the above
> errors so luckily for me it doesn't seem to be caused by the new code
> but I can't reproduce it without virtio-iommu. Any idea what could
> cause this?

Adding Eric in case this looks familiar.

I don't have hardware to test this but I guess QEMU system emulation may
be able to reproduce the issue since it has an AMD IOMMU (unmaintained)
and igb, I can give that a try.

Thanks,
Jean

> 
> > 
> > > > Link: https://lore.kernel.org/lkml/20230802123612.GA6142@myrica/
> > > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > > ---
> > > >   drivers/iommu/virtio-iommu.c | 12 ++++++++++++
> > > >   1 file changed, 12 insertions(+)
> > > > 
> > > > diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> > > > index fb73dec5b953..1b7526494490 100644
> > > > --- a/drivers/iommu/virtio-iommu.c
> > > > +++ b/drivers/iommu/virtio-iommu.c
> > > > @@ -924,6 +924,15 @@ static int viommu_iotlb_sync_map(struct iommu_domain *domain,
> > > >   	return viommu_sync_req(vdomain->viommu);
> > > >   }
> > > >   
> > > > +static void viommu_flush_iotlb_all(struct iommu_domain *domain)
> > > > +{
> > > > +	struct viommu_domain *vdomain = to_viommu_domain(domain);
> > > > +
> > > > +	if (!vdomain->nr_endpoints)
> > > > +		return;
> > > 
> > > As for patch 1, a NULL check in viommu_sync_req() would allow dropping
> > > this one
> > > 
> > > Thanks,
> > > Jean
> 
> Right, makes sense will move the check into viommu_sync_req() and add a
> coment that it is there fore the cases where viommu_iotlb_sync() et al
> get called before the IOMMU is set up.
> 
> > > 
> > > > +	viommu_sync_req(vdomain->viommu);
> > > > +}
> > > > +
> > > >   static void viommu_get_resv_regions(struct device *dev, struct list_head *head)
> > > >   {
> > > >   	struct iommu_resv_region *entry, *new_entry, *msi = NULL;
> > > > @@ -1049,6 +1058,8 @@ static bool viommu_capable(struct device *dev, enum iommu_cap cap)
> > > >   	switch (cap) {
> > > >   	case IOMMU_CAP_CACHE_COHERENCY:
> > > >   		return true;
> > > > +	case IOMMU_CAP_DEFERRED_FLUSH:
> > > > +		return true;
> > > >   	default:
> > > >   		return false;
> > > >   	}
> > > > @@ -1069,6 +1080,7 @@ static struct iommu_ops viommu_ops = {
> > > >   		.map_pages		= viommu_map_pages,
> > > >   		.unmap_pages		= viommu_unmap_pages,
> > > >   		.iova_to_phys		= viommu_iova_to_phys,
> > > > +		.flush_iotlb_all	= viommu_flush_iotlb_all,
> > > >   		.iotlb_sync		= viommu_iotlb_sync,
> > > >   		.iotlb_sync_map		= viommu_iotlb_sync_map,
> > > >   		.free			= viommu_domain_free,
> > > > 
> > > > -- 
> > > > 2.39.2
> > > > 
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
