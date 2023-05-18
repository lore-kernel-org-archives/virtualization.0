Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C7AC77B7D
	for <virtualization@archiver.kernel.org>; Thu, 18 May 2023 13:56:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CEC9D4291E;
	Thu, 18 May 2023 13:56:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CEC9D4291E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=As/izmzG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UBP8iSbPyctk; Thu, 18 May 2023 13:56:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0660842903;
	Thu, 18 May 2023 13:56:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0660842903
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BDA02C0035;
	Thu, 18 May 2023 13:56:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8970CC002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 13:56:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6418A8445B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 13:56:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6418A8445B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=As/izmzG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RfpiiiFaWuyJ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 13:56:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7318984457
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7318984457
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 13:56:37 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f420618d5bso13506895e9.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 06:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684418195; x=1687010195;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MPzdKdRGQGElWUYovOVhZT8DMwrnx0aSVXCHunf9t6E=;
 b=As/izmzGYSC0uCCOTiNEMEWQHttyHnw/qT5g27C1MUAraum18e9vbbIcd1uBWgx6vC
 cO4wX5OzcnWDndLe9aLvteTZlEcVRzSaBWfOBfjKJfXCaNsbz/9zq7jBbMgnfadwAgGg
 qT2dOdGDo2r3+fmCM5Y6rYMdWd2JrFAZcfOUzNENAGmpnB7yaKulsK3dHXZn+GSSIRim
 Hl4qgHSj7jRacXc9ZvmoDC2ciE0DvQA80mdVGQTyLNjgx3W8Losc8znXsUCxzTfYMK4E
 71BtjV124+dqVQ5yO1QXKPPVW/5Pvyif9WNzbXPsRArmCwsFaQYsM8C3BxAD9ep22EXT
 Ow0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684418195; x=1687010195;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MPzdKdRGQGElWUYovOVhZT8DMwrnx0aSVXCHunf9t6E=;
 b=B4W62kaHbyRJ1a/Qk9DbS4rpd7cQqYCglYMbFatKMgi9zoV2bIgpOn/m3przDwcC0h
 sG42ysPbVJSM1cti20xcZQgIPuFnzTNA3Gl5ee5E30K2DV4d9jJ+hiBiyQnPb43qyAbe
 GLPTG8q6NyKbuPoE0Q2FMVGmwqFMcKFuZh3LT57uH6V8x0LUIsXn2mBVfLElBgZSiVye
 FrLKcuu+zqno38AyI8lWPZJHe9BrGTzVrMwm1T5Xj9rLddoNLLyqWnTbAM+qbTGlGb5Z
 B5gBsQiby5KlBtXr65iDOntN25021P2bAn5yD6tbSOijTOMzGSkNMCYELEercBpxINB0
 D8wQ==
X-Gm-Message-State: AC+VfDyn55u6DZBDF96myyYrgxNMb5ZfzCBIogWqKudgNGx+mnKPqfdF
 Z5LRqFYjZ+2VI6fODx29yLmzHw==
X-Google-Smtp-Source: ACHHUZ4KO5bq7EE1YgvTlu5at/kRF7zYw/DEuhR+gKplRgcp8q22BfKN7YzXPz82nsxzB+jpDTJn0w==
X-Received: by 2002:a05:600c:364c:b0:3f4:2267:10cf with SMTP id
 y12-20020a05600c364c00b003f4226710cfmr1548896wmq.32.1684418195586; 
 Thu, 18 May 2023 06:56:35 -0700 (PDT)
Received: from myrica (5750a5b3.skybroadband.com. [87.80.165.179])
 by smtp.gmail.com with ESMTPSA id
 p4-20020a05600c204400b003f0aefcc457sm5554965wmg.45.2023.05.18.06.56.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 06:56:35 -0700 (PDT)
Date: Thu, 18 May 2023 14:56:38 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH] iommu/virtio: Detach domain on endpoint release
Message-ID: <20230518135638.GB2587493@myrica>
References: <20230414150744.562456-1-jean-philippe@linaro.org>
 <20230510081157.GA3326511@myrica> <ZGT+44a6RYZ999kz@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZGT+44a6RYZ999kz@nvidia.com>
Cc: akihiko.odaki@daynix.com, will@kernel.org, joro@8bytes.org,
 virtualization@lists.linux-foundation.org, eric.auger@redhat.com,
 iommu@lists.linux.dev, robin.murphy@arm.com
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

On Wed, May 17, 2023 at 01:20:51PM -0300, Jason Gunthorpe wrote:
> On Wed, May 10, 2023 at 09:11:57AM +0100, Jean-Philippe Brucker wrote:
> 
> > > diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> > > index 5b8fe9bfa9a5..3d3d4462359e 100644
> > > --- a/drivers/iommu/virtio-iommu.c
> > > +++ b/drivers/iommu/virtio-iommu.c
> > > @@ -788,6 +788,28 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
> > >  	return 0;
> > >  }
> > >  
> > > +static void viommu_detach_dev(struct viommu_endpoint *vdev)
> > > +{
> > > +	int i;
> > > +	struct virtio_iommu_req_detach req;
> > > +	struct viommu_domain *vdomain = vdev->vdomain;
> > > +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(vdev->dev);
> > > +
> > > +	if (!vdomain)
> > > +		return;
> > > +
> > > +	req = (struct virtio_iommu_req_detach) {
> > > +		.head.type	= VIRTIO_IOMMU_T_DETACH,
> > > +		.domain		= cpu_to_le32(vdomain->id),
> > > +	};
> > > +
> > > +	for (i = 0; i < fwspec->num_ids; i++) {
> > > +		req.endpoint = cpu_to_le32(fwspec->ids[i]);
> > > +		WARN_ON(viommu_send_req_sync(vdev->viommu, &req, sizeof(req)));
> > > +	}
> > > +	vdev->vdomain = NULL;
> 
> Not for this patch, but something to work on..
> 
> I assume detach disconnects the container on the VFIO side and puts it
> into a BLOCKED state?

At the moment that depends on the VMM boot-bypass policy: if virtio-iommu
is booted with global-bypass set, then detaching will go back to an
identity-mapped container, not a BLOCKED state. If the global-bypass bit
is clear, then it does go back to a BLOCKED state. However QEMU has a
default policy of boot-bypass (because that allows booting a firmware or
OS that doesn't have the IOMMU drivers).

The driver can clear the global-bypass bit to change this behavior, but at
the moment we just follow the VMM boot policy.

> 
> Can you wrapper this into a BLOCKED domain like we are moving drivers
> toward, and then attach the blocked domain instead of introducing this
> special case?

Yes, I think the way the virtio-iommu driver should implement BLOCKED
domains is initially clearing the global-bypass bit, and then issuing
DETACH requests when the core asks to attach a BLOCKED domain. This has
the same effect as issuing an ATTACH request with an empty domain, but
requires fewer resources in the VMM.

Thanks,
Jean

> 
> I've been thinking about having some core code support to do fairly
> common pattern of 'parking' the iommu at some well defined translation
> mode, BLOCKED in this case.
> 
> Thanks,
> Jason
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
