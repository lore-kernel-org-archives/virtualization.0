Return-Path: <SRS0=jbvZ=DC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD5CC4363D
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 08:48:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 219B3208B6
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 08:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RWh2LCU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 219B3208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8AF3B84E4E;
	Fri, 25 Sep 2020 08:48:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pcf8gXAer6EZ; Fri, 25 Sep 2020 08:48:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CC97C84C09;
	Fri, 25 Sep 2020 08:48:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B737EC0859;
	Fri, 25 Sep 2020 08:48:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DCC9C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 08:48:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 443A12E145
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 08:48:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xz8nC7gQKuzK
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 08:48:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com
 [209.85.218.68])
 by silver.osuosl.org (Postfix) with ESMTPS id 2F734204BA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 08:48:27 +0000 (UTC)
Received: by mail-ej1-f68.google.com with SMTP id i26so2515223ejb.12
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 01:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=emoRYvFV1+wXfCW/+6p/GyQoadovw+Jiwhu8aTMgKU0=;
 b=RWh2LCU3swUTd56gEVNeEdyA1NuXcjnKwsJ6epb6yxfVwwlLyFft7qyoYDwb4nSD9F
 2ctMzK3OnYPpBhfB1hXaN3ZqkBStmtssR+A0F4tTkVNttmHkadGMPbB/84TaovHS7yYy
 U4Aqwxn8iCPadf5Ycj4Ne+YqdCs5T2uajhIfJfOejoTRQ6KgTMCRPlUPsLbq7RGFqd1V
 781yi0atyQkM34kDqmrYHg12hbrVcr/yEJY8uPJsgmj8qRRMxkn4sKzK7JwrC1sZ46Qg
 EDnQpsCCVANaMSxML5qXH1UgJ69a32feNN9dx7qoyw3WHcd5oGHewMx8FT1MBaO7IOVU
 p8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=emoRYvFV1+wXfCW/+6p/GyQoadovw+Jiwhu8aTMgKU0=;
 b=DRmS7BphWkMc121pfEPR7pVq31X1LggvhHCHX6uV6Z+0FfA9IhBXEc35iXDjrjfvbp
 4ZMHyfrnzbY3l7zr1VHCnS1f4XsVQNS5Hy2VRy9zDgsqZih8/WkzTRWnbXNAM2Akcck5
 Nm9aQhNjf+Ud7US7xHauNwveS4MgYGkyBR/0OGB6hoOVM0cOZIo70MW+nLPUWvKVLRQm
 pekCoi69Tx/SD9pnwu+dv71YFNlGirVK+38J2DQELk+k0UugKSXI4rLgDCFsaZyL/8fo
 CA1oMcdRC3+XlXJ9gmtzPsZnskpFtr0sBTkJtl6Zem3wmPrmxbZtBQPI5ybJ765YU8lf
 3lSw==
X-Gm-Message-State: AOAM530FsqjEHTaQGrJIlTZJAKICQLkMHUoJ2Wq5EsAzup7E8XLtENNQ
 GZ9SdIrd5BISzUDPmslTzuWMwg==
X-Google-Smtp-Source: ABdhPJwrEYir8FTp3IhJ0bHKhMyHKLPJqzcUuhw51auhBeqZ1mDOELPLruwZjAdXUK33OCq9RAsS4A==
X-Received: by 2002:a17:906:5611:: with SMTP id
 f17mr1721401ejq.427.1601023705423; 
 Fri, 25 Sep 2020 01:48:25 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id m6sm1425837ejb.85.2020.09.25.01.48.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 01:48:24 -0700 (PDT)
Date: Fri, 25 Sep 2020 10:48:06 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org,
 virtualization@lists.linux-foundation.org,
 virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Message-ID: <20200925084806.GB490533@myrica>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200821131540.2801801-1-jean-philippe@linaro.org>
Cc: lorenzo.pieralisi@arm.com, mst@redhat.com, joro@8bytes.org,
 eric.auger@redhat.com, sebastien.boeuf@intel.com, bhelgaas@google.com
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

On Fri, Aug 21, 2020 at 03:15:34PM +0200, Jean-Philippe Brucker wrote:
> Add a topology description to the virtio-iommu driver and enable x86
> platforms.
> 
> Since [v2] we have made some progress on adding ACPI support for
> virtio-iommu, which is the preferred boot method on x86. It will be a
> new vendor-agnostic table describing para-virtual topologies in a
> minimal format. However some platforms don't use either ACPI or DT for
> booting (for example microvm), and will need the alternative topology
> description method proposed here. In addition, since the process to get
> a new ACPI table will take a long time, this provides a boot method even
> to ACPI-based platforms, if only temporarily for testing and
> development.
> 
> v3:
> * Add patch 1 that moves virtio-iommu to a subfolder.
> * Split the rest:
>   * Patch 2 adds topology-helper.c, which will be shared with the ACPI
>     support.
>   * Patch 4 adds definitions.
>   * Patch 5 adds parser in topology.c.
> * Address other comments.
> 
> Linux and QEMU patches available at:
> https://jpbrucker.net/git/linux virtio-iommu/devel
> https://jpbrucker.net/git/qemu virtio-iommu/devel

I'm parking this work again, until we make progress on the ACPI table, or
until a platform without ACPI and DT needs it. Until then, I've pushed v4
to my virtio-iommu/topo branch and will keep it rebased on master.

Thanks,
Jean

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
