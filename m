Return-Path: <SRS0=sVkE=DB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3671AC4346E
	for <virtualization@archiver.kernel.org>; Thu, 24 Sep 2020 08:31:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A85622376F
	for <virtualization@archiver.kernel.org>; Thu, 24 Sep 2020 08:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JxmiTewQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A85622376F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 34B6587379;
	Thu, 24 Sep 2020 08:31:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AcowhmUurNtb; Thu, 24 Sep 2020 08:31:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6DD7F86F9C;
	Thu, 24 Sep 2020 08:31:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A270C0889;
	Thu, 24 Sep 2020 08:31:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F22F6C0051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 08:31:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id EA20C86A0E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 08:31:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HROxlJ9MbSOB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 08:31:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com
 [209.85.218.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 90D5F869C9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 08:31:36 +0000 (UTC)
Received: by mail-ej1-f65.google.com with SMTP id u21so3320373eja.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 01:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=iQLky5ZWJdFZQTUOK1fAqSj9E9vn3fC5tbC/RCI+f5o=;
 b=JxmiTewQDn+DVnAHs5YSCKXGT9ubPK/YQGSoDm86k7pdu51akn98y0gMvSdQrAKLVN
 O8mfewLHNsyNzndlhjkcDqtCXCMrX0Ejgi/Dr/u3JJa0kY7fnmGkkhTC8zh6wtROgN3R
 QmGd1E7DNjOrhV3SaSSLohUmmndRJccit3YqqlHXuVhnYphUN0ssoPq9DxEXbgFKGz1p
 VfNeLjJbe3KBnXoYeLJHS5J0+RM77PeCKO5CzxXjhnzO1Lr7AAlm4e3uhH6dHZwyltoo
 VRSbtBnHCu9qkPNJipDLql43zuJgP4lnfr2q2bbMivywCcFILBEMwmOWCOdmuyJeC3LM
 N+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iQLky5ZWJdFZQTUOK1fAqSj9E9vn3fC5tbC/RCI+f5o=;
 b=XyUY2lK3yTJRLVgxbguPBJECwkOQ5UQLrFrideNJUJKa4GbnuKl3rc4XiTJfM6b6/V
 oaWJIOAIPKV18HxAfawkIsOp1AFLkD01dfjSkQNvqMHZoxba6R9bDBfAlnrHbq4sS5gQ
 QFq95m4b1tfRSZ8y721nX00ZgAGWlmHACJniMMRCC4012b/z1k7Ffjl4OmM4XouS8oDG
 DxPfqRN+bVoEin9FtoJvvuPVMUjrTkny1rP7yQ9yiVd36gVJLL+MMbC+7E6F1kiV4+t3
 zQIcb9ge88hoq0tCpL0fovnHucbXRaRgzst6V6DT71Twp2R6Ubc5h2J/3RLS9WAeSu7R
 gnrg==
X-Gm-Message-State: AOAM533k6JKpPYPlRP3u1q61kF4aG/Jcew6JgSNB9DNJvA+7vH6pYI4u
 lIEPiov6y1/QMrlzWbeC8pdE5Q==
X-Google-Smtp-Source: ABdhPJwLzzXN+IyUsf3KGNT7aZtIbPoxS7jdNw92acn5PhSUI2Uv1RL6H8dlzn8f4ElxNCwc/0DyMA==
X-Received: by 2002:a17:906:2659:: with SMTP id
 i25mr3402228ejc.16.1600936294818; 
 Thu, 24 Sep 2020 01:31:34 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id q23sm1988704edw.41.2020.09.24.01.31.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 01:31:34 -0700 (PDT)
Date: Thu, 24 Sep 2020 10:31:16 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v3 2/6] iommu/virtio: Add topology helpers
Message-ID: <20200924083116.GA170808@myrica>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <20200821131540.2801801-3-jean-philippe@linaro.org>
 <21fce247-4c1c-b7a8-bcac-4d7b649eaeca@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <21fce247-4c1c-b7a8-bcac-4d7b649eaeca@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, lorenzo.pieralisi@arm.com, mst@redhat.com,
 linux-pci@vger.kernel.org, joro@8bytes.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, bhelgaas@google.com
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

On Fri, Sep 04, 2020 at 06:22:12PM +0200, Auger Eric wrote:
> > +/**
> > + * virt_dma_configure - Configure DMA of virtualized devices
> > + * @dev: the endpoint
> > + *
> > + * Setup the DMA and IOMMU ops of a virtual device, for platforms without DT or
> > + * ACPI.
> > + *
> > + * Return: -EPROBE_DEFER if the device is managed by an IOMMU that hasn't been
> > + *   probed yet, 0 otherwise
> > + */
> > +int virt_dma_configure(struct device *dev)
> > +{
> > +	const struct iommu_ops *iommu_ops;
> > +
> > +	iommu_ops = virt_iommu_setup(dev);
> > +	if (IS_ERR_OR_NULL(iommu_ops)) {
> > +		int ret = PTR_ERR(iommu_ops);
> > +
> > +		if (ret == -EPROBE_DEFER || ret == 0)
> > +			return ret;
> > +		dev_err(dev, "error %d while setting up virt IOMMU\n", ret);
> > +		return 0;
> why do we return 0 here?

So we can fall back to another method (ACPI or DT) if available

> Besides
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks!
Jean
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
