Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4983FCE7A81
	for <virtualization@archiver.kernel.org>; Mon, 25 Sep 2023 13:29:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C11CE4047B;
	Mon, 25 Sep 2023 13:29:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C11CE4047B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=iGS4i9B2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xK0eF_gLGiUB; Mon, 25 Sep 2023 13:29:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3B02C40185;
	Mon, 25 Sep 2023 13:29:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3B02C40185
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11F00C0039;
	Mon, 25 Sep 2023 13:29:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0918C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 13:29:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 87C6F40164
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 13:29:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 87C6F40164
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca
 header.a=rsa-sha256 header.s=google header.b=iGS4i9B2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AFgKfgntBA2T
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 13:29:44 +0000 (UTC)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8043A4015B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 13:29:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8043A4015B
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6562395dfcfso31997506d6.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 06:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1695648583; x=1696253383;
 darn=lists.linux-foundation.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oga/n0wXfl4psvEJuTUVdx2OlpRGQg6ZYgAQVtMIKuE=;
 b=iGS4i9B2qUjYsfMH9UfG24Sb2qch/2CxenlL7dUhstGT04mYukt9oLzKgbPiB4s8bg
 rfHkcNRH3Y45/NEG2QzEOvpJXLeT+U6r0yoQmRKe+I06mAbYLrsCvL9uOKiAvvxJgQQh
 5IbneF0fa/DMPGUK3jiXR4i4A5Qk9SSqLdXACPsO5VSMzIkJgJBLD7IJyDZh11cEOz8h
 cgxx2nvii7nCu7yCWmByfLm1UfzeIAca2LcohhU88+mL9TzJCrXFF1fEVrv9PTDh2XZA
 ANUJGGbwSTb0TLyOrWdRB2fNrLZnjUXR7Rren5amy1T1jvmdaDMEAEnkzQWpKsBBEtko
 bHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695648583; x=1696253383;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oga/n0wXfl4psvEJuTUVdx2OlpRGQg6ZYgAQVtMIKuE=;
 b=enuSjx0yl2DkpyciOzVLMlTlg9tkP5fiws53lP9kwBZ4sdFM2wMM+JXKYRzPl7lWqN
 c+BA5iFPWOuf4JBPwZta4N76Wo7fJCNelQ0WgfwgP9lVVPJtYwXny/2KNKLXH9tigF45
 YArvmO+tF1l4bgJoAwxPOqPe8TCdVBVSdDgAqjH893LFYxeJDOV0+SIUGtducgT9Yt8t
 tjBt7UCGPuWbkes2Ek/FtNqhNUwi9vHN3feYztMbUwOrPoQhaB7D3tZH9yprWlkrF06d
 R3QAC17cPrtWAL9jtDOZtWNPGUVBPXyf+RkXdP/sCa/t3WntGZNTlfAoHzEzKQ9iT0al
 HRZA==
X-Gm-Message-State: AOJu0Yzd3a/6MvLaK8uMbtiamZkqcSIktI//sL9HTKp3SRvPY3ABAChI
 Map4AOEQUuS3GAyJxqtBAO+PJgyWPy+eMKUlctA=
X-Google-Smtp-Source: AGHT+IEKfw0t5lrzqptyLs66b/Idloen/u4q+DsYXXRRj02Iy22p185Epb13OQZKjHg6eVfFlxN1qg==
X-Received: by 2002:a0c:f14a:0:b0:65a:fd46:c464 with SMTP id
 y10-20020a0cf14a000000b0065afd46c464mr3996185qvl.33.1695648583234; 
 Mon, 25 Sep 2023 06:29:43 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.26.201]) by smtp.gmail.com with ESMTPSA id
 u17-20020a0cf1d1000000b0065b1f90ff8csm155250qvl.40.2023.09.25.06.29.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 06:29:42 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
 (envelope-from <jgg@ziepe.ca>) id 1qklef-000rby-UV;
 Mon, 25 Sep 2023 10:29:41 -0300
Date: Mon, 25 Sep 2023 10:29:41 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
Message-ID: <20230925132941.GK13795@ziepe.ca>
References: <ae7e513b-eb86-97e2-bed0-3cca91b8c959@arm.com>
 <20230919081519.GA3860249@myrica> <20230919144649.GT13795@ziepe.ca>
 <20230922075719.GB1361815@myrica> <20230922124130.GD13795@ziepe.ca>
 <900b644e-6e21-1038-2252-3dc86cbf0a32@arm.com>
 <20230922162714.GH13795@ziepe.ca>
 <123c53c3-d259-9c20-9aa6-0c216d7eb3c0@arm.com>
 <20230922233309.GI13795@ziepe.ca>
 <ade90cd5-bbf1-f4f9-0511-75e0e18d1a83@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ade90cd5-bbf1-f4f9-0511-75e0e18d1a83@arm.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Niklas Schnelle <schnelle@linux.ibm.com>, Joerg Roedel <joro@8bytes.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux.dev, Will Deacon <will@kernel.org>
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

On Mon, Sep 25, 2023 at 02:07:50PM +0100, Robin Murphy wrote:
> On 2023-09-23 00:33, Jason Gunthorpe wrote:
> > On Fri, Sep 22, 2023 at 07:07:40PM +0100, Robin Murphy wrote:
> > 
> > > virtio isn't setting ops->pgsize_bitmap for the sake of direct mappings
> > > either; it sets it once it's discovered any instance, since apparently it's
> > > assuming that all instances must support identical page sizes, and thus once
> > > it's seen one it can work "normally" per the core code's assumptions. It's
> > > also I think the only driver which has a "finalise" bodge but *can* still
> > > properly support map-before-attach, by virtue of having to replay mappings
> > > to every new endpoint anyway.
> > 
> > Well it can't quite do that since it doesn't know the geometry - it
> > all is sort of guessing and hoping it doesn't explode on replay. If it
> > knows the geometry it wouldn't need finalize...
> 
> I think it's entirely reasonable to assume that any direct mappings
> specified for a device are valid for that device and its IOMMU. However, in
> the particular case of virtio, it really shouldn't ever have direct mappings
> anyway, since even if the underlying hardware did have any, the host can
> enforce the actual direct-mapping aspect itself, and just present them as
> unusable regions to the guest.

I assume this machinery is for the ARM GIC ITS page....

> Again, that's irrelevant. It can only be about whether the actual
> ->map_pages call succeeds or not. A driver could well know up-front that all
> instances support the same pgsize_bitmap and aperture, and set both at
> ->domain_alloc time, yet still be unable to handle an actual mapping without
> knowing which instance(s) that needs to interact with (e.g. omap-iommu).

I think this is a different issue. The domain is supposed to represent
the actual io pte storage, and the storage is supposed to exist even
when the domain is not attached to anything.

As we said with tegra-gart, it is a bug in the driver if all the
mappings disappear when the last device is detached from the domain.
Driver bugs like this turn into significant issues with vfio/iommufd
as this will result in warn_on's and memory leaking.

So, I disagree that this is something we should be allowing in the API
design. map_pages should succeed (memory allocation failures aside) if
a IOVA within the aperture and valid flags are presented. Regardless
of the attachment status. Calling map_pages with an IOVA outside the
aperture should be a caller bug.

It looks omap is just mis-designed to store the pgd in the omap_iommu,
not the omap_iommu_domain :( pgd is clearly a per-domain object in our
API. And why does every instance need its own copy of the identical
pgd?

Jason
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
