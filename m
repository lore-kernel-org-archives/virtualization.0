Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0CF9C04A6A
	for <virtualization@archiver.kernel.org>; Wed,  2 Aug 2023 13:44:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3DC3781771;
	Wed,  2 Aug 2023 13:44:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3DC3781771
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=MkqMmJNH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iQtXAoU6pt4d; Wed,  2 Aug 2023 13:44:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DDE8681992;
	Wed,  2 Aug 2023 13:44:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DDE8681992
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA8C5C0071;
	Wed,  2 Aug 2023 13:44:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 962A8C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Aug 2023 13:44:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7C26381992
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Aug 2023 13:44:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7C26381992
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yOXpu1CfV2qU
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Aug 2023 13:44:29 +0000 (UTC)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3EC0281443
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Aug 2023 13:44:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3EC0281443
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5633b7e5f90so5174071eaf.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Aug 2023 06:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1690983868; x=1691588668;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iaKT85TJhEtcFP9ANuQrpHynlBJz4qIcEmhrfVkT2f0=;
 b=MkqMmJNHF6SUb5Wg4wdkEMPdYqOcouWW7G77xUhqRubpPap1WIXCVLfpofpfoRg26Y
 dkkJRyGmK8uKOe1+9wlNIKM6rTtoZ3zkRuR83glbO0xUmlWTnsJKIu0ptTJZmF0s10Ry
 7nKBMssvjUTItFpD15ENyaZOwD5BIKVYdWl/IwwYVTSnGWh6SyfA3JUGxelbar8aNpFe
 765IoEhQsyzRpwTHH4gSRiDX0KKcnS/VMwIw82iGkQo3eHqpyIHn5n1xg9DM6kPGS5Ls
 +8pzxFQdedg3Q/tFWXR+e9EmpZh65FUTg+hWlL6g0lqm4O316Wkm40VZqWv0SoMt0iS/
 rHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690983868; x=1691588668;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iaKT85TJhEtcFP9ANuQrpHynlBJz4qIcEmhrfVkT2f0=;
 b=JomPkIVb05Yfc8vahZxT5/TWHlVhvjCEyDgrxbAsTPKhpyXa/BDvSW5j75yOxCHatM
 68VfLAlKSMYGxCH1MvrH/l4RatOc1mTs6RqKIw0Bn0m61wLaWgx2Esp2/75hr7cjKx5w
 Yur+NUa3r7oRJW+E062BuEm+96tZNcQNTVaIetUCB4lZNVC0zZ40UcQ/yldxx2OUjYpj
 PDSNq6UxpnbbXx/r76KSEfMT4bBt6S62XZIip01eVpHSmiASMFQfAxfZVisoFPdPTFdU
 pOFMIB/CRQrFKwN5DtPQ/K4wnsnn4twNJ6wYAErRYgaVvMEUextSVz72OFknthd6VO72
 wgZg==
X-Gm-Message-State: ABy/qLZ5j2ewlyKApL8UloNPmP+eRDT3PPEgmbnJ9DXSnhlKEASQ/qtv
 Ey/qbn7QPQeCMgj+zA/fYVkXaQ==
X-Google-Smtp-Source: APBJJlGIW2O7+amusHg/yl/NaQI+skiPGbXQqDGrrFAPEvK+fD1I90Tv962Nn8fzJAYM4LtJ250cWw==
X-Received: by 2002:a05:6358:724a:b0:135:5ede:f352 with SMTP id
 i10-20020a056358724a00b001355edef352mr8120539rwa.8.1690983866720; 
 Wed, 02 Aug 2023 06:44:26 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.25.194]) by smtp.gmail.com with ESMTPSA id
 e18-20020a0ce3d2000000b00635efe2f65csm5536749qvl.30.2023.08.02.06.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 06:44:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
 (envelope-from <jgg@ziepe.ca>) id 1qRC9J-0032yC-6I;
 Wed, 02 Aug 2023 10:44:25 -0300
Date: Wed, 2 Aug 2023 10:44:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [RFC] iommu/virtio: Use single flush queue (EXPERIMENTAL)
Message-ID: <ZMpduWLdRXhUEx6O@ziepe.ca>
References: <20230717-dma_iommu-v11-0-a7a0b83c355c@linux.ibm.com>
 <20230726111433.1105665-1-schnelle@linux.ibm.com>
 <20230802123612.GA6142@myrica>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230802123612.GA6142@myrica>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, Robin Murphy <robin.murphy@arm.com>,
 Lu Baolu <baolu.lu@linux.intel.com>
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

On Wed, Aug 02, 2023 at 01:36:12PM +0100, Jean-Philippe Brucker wrote:

> automatically get plugged into a VM without user intervention. Here I
> guess the devices we don't trust will be virtual devices implemented by
> other VMs. We don't have any method to identify them yet, so
> iommu.strict=1 and CONFIG_IOMMU_DEFAULT_DMA_STRICT is the best we can do
> at the moment.

VM's should work the same way as bare metal. The hypervisor should
pass in an ACPI/etc indication if specific devices are to be
untrusted. Otherwise the VM should assume trusted devices.

The hypervisor can already read all the VM's memory, it doesn't make
alot of sense for the VM to try and be defensive here in the general
case.

Jason
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
