Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A66E6FE22
	for <virtualization@archiver.kernel.org>; Fri, 22 Sep 2023 12:41:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 203B3421FB;
	Fri, 22 Sep 2023 12:41:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 203B3421FB
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=AUWZGDoI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wShqbSM8uP7K; Fri, 22 Sep 2023 12:41:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2DE8041DBF;
	Fri, 22 Sep 2023 12:41:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2DE8041DBF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0B9FC0039;
	Fri, 22 Sep 2023 12:41:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 130D8C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 12:41:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DB30B4059D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 12:41:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DB30B4059D
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca
 header.a=rsa-sha256 header.s=google header.b=AUWZGDoI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y5gYvg24jJXH
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 12:41:33 +0000 (UTC)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E9E7B4010F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 12:41:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E9E7B4010F
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-77412b91c47so83060285a.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 05:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1695386491; x=1695991291;
 darn=lists.linux-foundation.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=N9+4wg+HvQjn8Tza5j/+95ICGHkpfpV9B3BnmaDCax4=;
 b=AUWZGDoIQa6lUSpbL0cGW5PeRT12B1DZ8mobDbso5DrPAKG0FRl7VhhwQzBUTI2F9m
 u60SLMyyGbRqH+B+p3ucmeL7fK0GZuZVLo0xS8ZWqeSMFKu4NktdtU5JjwsTJHu1L31I
 J0tYfJ0NvwPBtRxead6PIiiGBzF9PBlItf9SS11Rd8mR8gf/TiV+codFI/QZDXDRogdG
 Fc/1/4JbUETF5SC0ENxklqBJwjm5w0gKd/Xjj7pK0e4TMpnAVneYWA6QD5cbCn5pUHEN
 an32BRd0OmdqAVpX4aTDdqnzKadSOvMpqaR9ZLJQFvhgXA+GnOynMuDBbt7bIgJ2zUIl
 YXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695386491; x=1695991291;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N9+4wg+HvQjn8Tza5j/+95ICGHkpfpV9B3BnmaDCax4=;
 b=A9k+WsMG2U2NEPtRoiIAsWeS0AqEfogo6ckDMtbzAqmYvdKEmH2kc6N3k7MFI3ojip
 xfk+X18yzLEU1NGbjnRrOwbNrAT1dl5PQLVkQBWCTi6f8keLDNvV2otfEahoSMREPgfU
 tMA2NunczQU/T+VsEXlNwEHWdKudj8vY5dDBMxPgYrv0l3+ldsCX/K0mpYCXXEMj1lSP
 iXW3/YZL0k5lRUVLS4CQob4gsFG4p9f1AibMM96KhV1x+mHEQcX57bkRZI73+gg4ZvYU
 F2/1/o8Mv3ylPcGePJCWiTe2yWZUQKtoZyAQDYn9VV0ejyQbkjP24mOBaedzB+ojYwVr
 D4mA==
X-Gm-Message-State: AOJu0YwcINBcOzvMbT9JhcM7XKoYppQQQsJTbVfnDJkyQWX+tuS4kPq7
 oyd+DHJtaaHoFDMY0oE9uuvD/g==
X-Google-Smtp-Source: AGHT+IHZUGi7eIWQUvwurrjhwZAXvsjOtNC1C38Z7pyQadDkGDO1CCUf1Jp9zTCAUl/T8vTtva0wOQ==
X-Received: by 2002:a05:620a:371e:b0:767:e994:ff03 with SMTP id
 de30-20020a05620a371e00b00767e994ff03mr2794453qkb.15.1695386491706; 
 Fri, 22 Sep 2023 05:41:31 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.26.201]) by smtp.gmail.com with ESMTPSA id
 p13-20020a05620a056d00b007740c0e52edsm1209968qkp.89.2023.09.22.05.41.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 05:41:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
 (envelope-from <jgg@ziepe.ca>) id 1qjfTO-000Y4I-9h;
 Fri, 22 Sep 2023 09:41:30 -0300
Date: Fri, 22 Sep 2023 09:41:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v2 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
Message-ID: <20230922124130.GD13795@ziepe.ca>
References: <20230918-viommu-sync-map-v2-0-f33767f6cf7a@linux.ibm.com>
 <20230918-viommu-sync-map-v2-1-f33767f6cf7a@linux.ibm.com>
 <ae7e513b-eb86-97e2-bed0-3cca91b8c959@arm.com>
 <20230919081519.GA3860249@myrica> <20230919144649.GT13795@ziepe.ca>
 <20230922075719.GB1361815@myrica>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230922075719.GB1361815@myrica>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
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

On Fri, Sep 22, 2023 at 08:57:19AM +0100, Jean-Philippe Brucker wrote:
> > > They're not strictly equivalent: this check works around a temporary issue
> > > with the IOMMU core, which calls map/unmap before the domain is
> > > finalized.
> > 
> > Where? The above points to iommu_create_device_direct_mappings() but
> > it doesn't because the pgsize_bitmap == 0:
> 
> __iommu_domain_alloc() sets pgsize_bitmap in this case:
> 
>         /*
>          * If not already set, assume all sizes by default; the driver
>          * may override this later
>          */
>         if (!domain->pgsize_bitmap)
>                 domain->pgsize_bitmap = bus->iommu_ops->pgsize_bitmap;

Dirver's shouldn't do that.

The core code was fixed to try again with mapping reserved regions to
support these kinds of drivers.

Jason
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
