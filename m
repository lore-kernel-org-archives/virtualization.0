Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BBB1A255A
	for <virtualization@lists.linux-foundation.org>; Tue, 22 Oct 2024 14:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729607429; cv=none; b=MSJIH2N7yIYs/vcy4hWrj+MwmuUBfz1mXn1Pvmj+7m44WPX+m4mIhPNC9FHe8OMbbEKk7JyDZEx18nldonu1cAXF9pqstjmiqa0JKpAwi9cPfsJhFVx37jnZaD1HQQYstj4aIWHN2khswK7mFXTcwf2XPQVErEqd8XeIPQBcG4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729607429; c=relaxed/simple;
	bh=k0amHKO6MIntAv5M0SzgajpPonlLOfoo6JXAgIJwIcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t725o/X78wxrpck2z2xS5e6L/OcJbOkT4U5XhWC85cYljJWJgN13m6E9jw3wP2z8/WTWOjChSw7V8+8/fTofxtbA3jcWqX3EebxBrXVDkTjK2gNwvpcIAJTeMyWC8FCyQ70m3j2Lq0CcDeCiu7W5MLAEBBvztN+AppOda52D1ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BVSWP0+G; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BVSWP0+G"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 63B9240384
	for <virtualization@lists.linux-foundation.org>; Tue, 22 Oct 2024 14:30:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0oxjIQVqm-BW for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Oct 2024 14:30:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::12b; helo=mail-lf1-x12b.google.com; envelope-from=zhangfei.gao@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B9EBD40391
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B9EBD40391
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=BVSWP0+G
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B9EBD40391
	for <virtualization@lists.linux-foundation.org>; Tue, 22 Oct 2024 14:30:24 +0000 (UTC)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-539e8586b53so5698968e87.1
        for <virtualization@lists.linux-foundation.org>; Tue, 22 Oct 2024 07:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729607422; x=1730212222; darn=lists.linux-foundation.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lp8dKdoQIA1w+n8BQQ++9JKmCC1EPM5x54cAk4kCfAY=;
        b=BVSWP0+GoExwB7SO8l4MXhSsX6nTD2fBipURPcL7Q4SwCXstB/GYZ/dU7En3fgCJge
         n+qHjUpSbAR4fCNfxIEL6ggxqrA5QrDI5MlW3L8YpWtlAKGrrUfILuF3Bk31lZbjUQmK
         JGsrMhMCafZZ3avdKdqse0lZV7JQF0hRcM7LPVGhNaZJxDMQ29+DhiAGPS1RysrYCPM7
         Trz+vfCoiT65ENDbGQ8mFZ1MCdFhISywRrx7dI0QR2hqEJuezLftF/iU/fA5wxC7x7X0
         fIuSA2U6hy8uAVQYgpT6aZ8mA62gWRIkNbpbSL0L3+X39lq0PEn8OuqgsY4iS0D/p/0x
         SwEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729607422; x=1730212222;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lp8dKdoQIA1w+n8BQQ++9JKmCC1EPM5x54cAk4kCfAY=;
        b=fNHJZop937qDBa1dUcAybs0LKM4+vxvESorEfz16RiSLzKhIRefCwt1zQVNHsAZXSH
         rWEiQzAemkvxoBdGKWGcavn1kVJvtIFnfOuSjg+Y2rXtqetYLAHTRtfaR10In3OV2FL/
         2FHA5gTccLR1MmAEmm3pZEAcMMH1sFmdMv2OQHgFofkAEoIjp5PuRjA3sjtWOWE9T0J+
         A4xc/CEv1Ka5f1vCxY8h1mxSc0J64KyxxPdDNhyCbdBEJAbC27wCb7nQv8G8fjh9MmRN
         BYhSiJFZMFxdadKUX1241AdyMnZdMKR8HwfEczVmkNURS3yBOxI+ROI9dnm+MZkxupLg
         UuRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfdj9a+2OD6ejndc1+6CSPooJV+UwpQRbksRSYEVdleBX7nzKvrDAm9wfnxzgvRZ2ciuYALT6m/mn++/BfEA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YznuwmvxvapIB5XEOUKpF8GymBra7qwV9jKY/wHwzomhJF1vD5u
	v4KRB58oGS/58INnSM1Ey/Fqauzjne2iKTQBZ5xQYOL0nVu/bfBZpsNbM6CS31ucKo3aXy3Huvr
	tQIikehYlUqeoui+Ug8rpfs1Z0lOAILvtpJH9Qw==
X-Google-Smtp-Source: AGHT+IEmsgyC/7BPZ0DVAIPPJOMrKuG0dVpOFVN4k5ykLXaGddAjQf1rjB9Wpg/JrSZFFy9ylzXvbFdWuCjJSeysOhI=
X-Received: by 2002:a05:6512:3d22:b0:539:ea18:437d with SMTP id
 2adb3069b0e04-53b13181fd5mr1172054e87.25.1729607422263; Tue, 22 Oct 2024
 07:30:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-8-baolu.lu@linux.intel.com> <CABQgh9EeKtYuu+vTTM0fwaKrLxdyC355MQxN8o8_OL9Y1NkE8A@mail.gmail.com>
 <20241015125420.GK1825128@ziepe.ca> <CABQgh9E+AnuyJgcM9tf1gEOUqcC_QSrA__Xha9sKYZp=NVRwhQ@mail.gmail.com>
 <20241016152503.GB4020792@ziepe.ca> <20241018135343.GA1914429@nvidia.com>
In-Reply-To: <20241018135343.GA1914429@nvidia.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Tue, 22 Oct 2024 22:30:10 +0800
Message-ID: <CABQgh9Hd0QCfEtVcMyXG+=KHuZdGGUA=kk5iL_ysOzfOpLh=-w@mail.gmail.com>
Subject: Re: [PATCH v8 07/10] iommufd: Fault-capable hwpt attach/detach/replace
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Nicolin Chen <nicolinc@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, 
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Oct 2024 at 21:53, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Wed, Oct 16, 2024 at 12:25:03PM -0300, Jason Gunthorpe wrote:
> > > > smmu-v3 needs some more fixing to move that
> > > > arm_smmu_master_enable_sva() logic into domain attachment.
> > >
> > > Will think about this, Thanks Jason
> >
> > Can you test it if a patch is made?
>
> Here it is:
>
> https://github.com/jgunthorpe/linux/commits/smmuv3_nesting/
>
> fa1528253d2210 iommu: Remove IOMMU_DEV_FEAT_SVA
> 5675560a272cf5 iommu/vt-d: Check if SVA is supported when attaching the SVA domain
> 94bc2b9525b508 iommu/arm-smmu-v3: Put iopf enablement in the domain attach path
>
> Let me know..

With these patches, do we still need ops->user_pasid_table?

if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) {
                attach_handle = iommu_attach_handle_get(dev->iommu_group,
                                fault->prm.pasid, 0);

// is attach_handle expected effect value here?
                if (IS_ERR(attach_handle)) {
                        const struct iommu_ops *ops = dev_iommu_ops(dev);

                        if (!ops->user_pasid_table)
                                return NULL;
                        /*
                         * The iommu driver for this device supports user-
                         * managed PASID table. Therefore page faults for
                         * any PASID should go through the NESTING domain
                         * attached to the device RID.
                         */
                        attach_handle = iommu_attach_handle_get(
                                        dev->iommu_group, IOMMU_NO_PASID,
                                        IOMMU_DOMAIN_NESTED);

Now I still need set ops->user_pasid_table, since attach_handle can not
return from the first iommu_attach_handle_get with fault->prm.pasid = 1,
but the second iommu_attach_handle_get with  IOMMU_NO_PASID,
suppose it is not expected?

Thanks
