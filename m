Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAAE6CD54A8
	for <virtualization@archiver.kernel.org>; Tue, 19 Sep 2023 08:15:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6BA6E41BAF;
	Tue, 19 Sep 2023 08:15:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6BA6E41BAF
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=H7TkFisF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7jTSDKt0v3AM; Tue, 19 Sep 2023 08:15:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 52DC941B97;
	Tue, 19 Sep 2023 08:15:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 52DC941B97
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30CFEC0071;
	Tue, 19 Sep 2023 08:15:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80097C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 08:15:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4E9CC41B99
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 08:15:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4E9CC41B99
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MSUxMgo_UoCE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 08:15:16 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CB90741B97
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 08:15:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CB90741B97
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-32164a6af64so729451f8f.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 01:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695111314; x=1695716114;
 darn=lists.linux-foundation.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=z9DuA2m46Djcdz3icf/RXjOs6wp73S2oIUkhIKRMWaU=;
 b=H7TkFisFeFMO9bIH3j8Ddc4JO7Ai6y08pnmQUTdb3Iv6AEahtED7you3SzTRe2las5
 nIn1YlEmSnB91UMvQ2Gvy2qSJDapbuCd5vZTJ7BJznukchsOylDVD/VS0MuhqiKk4qR3
 WyLk+5L+n9bYhH6EpIy8YQQ+W1/KyeFxuH7CENwL/CRQLzQzTNTUO0fCqMz2Ezti0Jnx
 cRNxtYhUsGAtitGfWEUDs17/SoF7+IOEPAFY/pvPkgpCdetdJcEZZJ0o45jWY+X0fAar
 /CeKXFLPqfguGwjM3KliJj3YVhJ56MpxXuAxLdpdw1tT/8gC6WziYSOc4GUNf/ll6ScX
 LgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695111314; x=1695716114;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z9DuA2m46Djcdz3icf/RXjOs6wp73S2oIUkhIKRMWaU=;
 b=OVjJc97/2JupOq6T2+ANa0eMyma3ZiMwm0AjhJeviUN9ZUwvIdRwEaKHOm4RwA4v2w
 7N2yGfQI+GXjMPDQ1hqTfYNO5Mp5yTXfrpMFuQ/D0rKu2WG8kc3nLeVTzuIPwgZgSvJI
 aGqSrs3GTJDyNFXPJnNMi+GkOA/ueDBRbKhLjY/dbV/CAbAwZL0jisscauz4wqcZRD7K
 pGBIcfXkysFi8vSywu/qlxlU7aLQCoVeXN/OzlSJV4aEuDXG5FAYJvxTgrHm7MsT45uT
 +81bFOh+v4/nFaNq6OA+zdaiZDkT/LsALt3lxaLEfN/QsanC7hTizpKw7t3+yoENffI5
 KT7A==
X-Gm-Message-State: AOJu0YyTit02Iv8l57Wgzwhyt2yjFNi7aeErTxE+jxHONATVeANcgrNq
 i5bk2wTGnKpD4690e7oxOXgRRQ==
X-Google-Smtp-Source: AGHT+IFGBTaGE4GEoHpdTwySnKUr0nW2LPy/soxU/asQgYmN8W5lJXq9nrjAyrswMLLRTbyUplW17Q==
X-Received: by 2002:a05:6000:1865:b0:31f:f8c1:f43c with SMTP id
 d5-20020a056000186500b0031ff8c1f43cmr11762566wri.41.1695111313622; 
 Tue, 19 Sep 2023 01:15:13 -0700 (PDT)
Received: from myrica ([2a02:c7c:7290:b00:fd32:2b31:6755:400c])
 by smtp.gmail.com with ESMTPSA id
 o16-20020a5d4a90000000b0031ffb51f6f9sm10302003wrq.30.2023.09.19.01.15.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 01:15:13 -0700 (PDT)
Date: Tue, 19 Sep 2023 09:15:19 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
Message-ID: <20230919081519.GA3860249@myrica>
References: <20230918-viommu-sync-map-v2-0-f33767f6cf7a@linux.ibm.com>
 <20230918-viommu-sync-map-v2-1-f33767f6cf7a@linux.ibm.com>
 <ae7e513b-eb86-97e2-bed0-3cca91b8c959@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ae7e513b-eb86-97e2-bed0-3cca91b8c959@arm.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>, Joerg Roedel <joro@8bytes.org>,
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

On Mon, Sep 18, 2023 at 05:37:47PM +0100, Robin Murphy wrote:
> > diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> > index 17dcd826f5c2..3649586f0e5c 100644
> > --- a/drivers/iommu/virtio-iommu.c
> > +++ b/drivers/iommu/virtio-iommu.c
> > @@ -189,6 +189,12 @@ static int viommu_sync_req(struct viommu_dev *viommu)
> >   	int ret;
> >   	unsigned long flags;
> > +	/*
> > +	 * .iotlb_sync_map and .flush_iotlb_all may be called before the viommu
> > +	 * is initialized e.g. via iommu_create_device_direct_mappings()
> > +	 */
> > +	if (!viommu)
> > +		return 0;
> 
> Minor nit: I'd be inclined to make that check explicitly in the places where
> it definitely is expected, rather than allowing *any* sync to silently do
> nothing if called incorrectly. Plus then they could use
> vdomain->nr_endpoints for consistency with the equivalent checks elsewhere
> (it did take me a moment to figure out how we could get to .iotlb_sync_map
> with a NULL viommu without viommu_map_pages() blowing up first...)

They're not strictly equivalent: this check works around a temporary issue
with the IOMMU core, which calls map/unmap before the domain is finalized.
Once we merge domain_alloc() and finalize(), then this check disappears,
but we still need to test nr_endpoints in map/unmap to handle detached
domains (and we still need to fix the synchronization of nr_endpoints
against attach/detach). That's why I preferred doing this on viommu and
keeping it in one place.

Thanks,
Jean
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
