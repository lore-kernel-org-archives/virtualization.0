Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A64F1C433EF
	for <virtualization@archiver.kernel.org>; Mon, 29 Nov 2021 15:37:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4129560A86;
	Mon, 29 Nov 2021 15:37:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T70iBXYHbJve; Mon, 29 Nov 2021 15:37:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F330360685;
	Mon, 29 Nov 2021 15:37:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5621C0012;
	Mon, 29 Nov 2021 15:37:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C697C000A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 15:37:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2C4204019E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 15:37:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HYwJSdsaJf-T
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 15:37:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2675340128
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 15:37:12 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id s13so37796087wrb.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 07:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=QNaHQe0sEt+Xz04cYV/MIlXb8cf/E2M9X4MAcvVxnPY=;
 b=jZT480wxvUl1wAeMTBT1goDqfM/CUNl3b3WLq0yuxBBxM9hmwt7jYsKrDnHVlAYgCq
 9taCx7GjoIFFKh6wPGbIm7V6djMjeHgD+ecYpG/ghbLjNU5D+scLE0lFxAjlTKRqTWe+
 RCBO6c7funI7wNn1LyWz/P5Cj+g3wRH3XFK+Zzy409Xl7LRxsPJEENGMHXTnWqEXEvlk
 dBiBniZ55PYJM/8ytfSKwaxWLJovM+yp5gCjdQPDKhX4nLegcXfTBGqOTUcoA8thRiww
 Ep9ARVrZ46+60YzrFq6BrXMX9/RUADTqo46rN3ll4ga7YP6/39VZKl+NcnZd3MT8GbJk
 xSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QNaHQe0sEt+Xz04cYV/MIlXb8cf/E2M9X4MAcvVxnPY=;
 b=p3UWH8FRFz61Z19B5wqSrpSrT9SrlsNgoNxKcJOg3SKMVp7l7lfKAczY7SEyxDtiDj
 5KvO0MTL+owJB+S6Cf6lsJWOLQC0tNPnJPjBp5rd+wWpJUMH6ZWt0hy1gRC//44qcAFV
 uKdxdO7ES00IryDmyWUvcnj8TUSqIoLfMU8hbJ5kFhnXlDPQt4rwQJj8GfXqiJov1ou/
 pWGNBkZcu8YbrXXYTragDDvGNe+02cq2IfNn1TWOK0S8SZ0njeo8QdoBCzdbS3AvV4Lj
 uQQ/XjYAuiXDsow8yJiipfRq3e/lHR/yRr3DrKm5YOkxXC9U4SNnfofSDNBIiwTItKCg
 jrZA==
X-Gm-Message-State: AOAM53090DwrR1fIKbK5paVeQnOCEB7X7wulsp7mVybNqFUQKuFWNbHV
 wznrIDwQiQtNM6a7OVKcAisjYQ==
X-Google-Smtp-Source: ABdhPJydH8DkXqyeN9Ia758m64cpVXoMOUT0emD3QhRO3MqqbhLn7G/GysWuevCbIseRjFknYEcsbg==
X-Received: by 2002:a5d:5643:: with SMTP id j3mr35495829wrw.138.1638200230316; 
 Mon, 29 Nov 2021 07:37:10 -0800 (PST)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id z5sm25105381wmp.26.2021.11.29.07.37.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Nov 2021 07:37:09 -0800 (PST)
Date: Mon, 29 Nov 2021 15:36:47 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v2 2/5] iommu/virtio: Support bypass domains
Message-ID: <YaTzj6x0nIYoL1WD@myrica>
References: <20211123155301.1047943-1-jean-philippe@linaro.org>
 <20211123155301.1047943-3-jean-philippe@linaro.org>
 <fd03ac99-9bd4-197b-26c8-dcc5de1b3057@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fd03ac99-9bd4-197b-26c8-dcc5de1b3057@redhat.com>
Cc: mst@redhat.com, joro@8bytes.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, pasic@linux.ibm.com,
 iommu@lists.linux-foundation.org, sebastien.boeuf@intel.com, will@kernel.org
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

On Sat, Nov 27, 2021 at 05:18:28PM +0100, Eric Auger wrote:
> Hi Jean,
> 
> On 11/23/21 4:52 PM, Jean-Philippe Brucker wrote:
> > The VIRTIO_IOMMU_F_BYPASS_CONFIG feature adds a new flag to the ATTACH
> > request, that creates a bypass domain. Use it to enable identity
> > domains.
> >
> > When VIRTIO_IOMMU_F_BYPASS_CONFIG is not supported by the device, we
> > currently fail attaching to an identity domain. Future patches will
> > instead create identity mappings in this case.
> >
> > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> >  drivers/iommu/virtio-iommu.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> > index 80930ce04a16..ee8a7afd667b 100644
> > --- a/drivers/iommu/virtio-iommu.c
> > +++ b/drivers/iommu/virtio-iommu.c
> > @@ -71,6 +71,7 @@ struct viommu_domain {
> >  	struct rb_root_cached		mappings;
> >  
> >  	unsigned long			nr_endpoints;
> > +	bool				bypass;
> >  };
> >  
> >  struct viommu_endpoint {
> > @@ -587,7 +588,9 @@ static struct iommu_domain *viommu_domain_alloc(unsigned type)
> >  {
> >  	struct viommu_domain *vdomain;
> >  
> > -	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
> > +	if (type != IOMMU_DOMAIN_UNMANAGED &&
> > +	    type != IOMMU_DOMAIN_DMA &&
> > +	    type != IOMMU_DOMAIN_IDENTITY)
> >  		return NULL;
> >  
> >  	vdomain = kzalloc(sizeof(*vdomain), GFP_KERNEL);
> > @@ -630,6 +633,17 @@ static int viommu_domain_finalise(struct viommu_endpoint *vdev,
> >  	vdomain->map_flags	= viommu->map_flags;
> >  	vdomain->viommu		= viommu;
> >  
> > +	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
> > +		if (!virtio_has_feature(viommu->vdev,
> nit: couldn't the check be done before the ida_alloc_range(),
> simplifying the failure cleanup?

It could, but patch 5 falls back to identity mappings, which is better
left at the end of the function to keep the error path simple. I put this
at the end already here, so patch 5 doesn't need to move things around.

Thanks,
Jean
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
