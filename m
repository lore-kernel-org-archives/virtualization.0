Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D48323766
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Nov 2023 18:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v9N2Y53d"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CCEA3408D4
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Nov 2023 18:38:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CCEA3408D4
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=v9N2Y53d
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id so59iZqdMExe
	for <virtualization@lists.linux-foundation.org>;
	Mon, 20 Nov 2023 18:38:27 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6695C4064F
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Nov 2023 18:38:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6695C4064F
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-33139ecdca7so2916351f8f.0
        for <virtualization@lists.linux-foundation.org>; Mon, 20 Nov 2023 10:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700505505; x=1701110305; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kg0bpxRdcL8t4yRhGzqbCgUsQk8IIqBGTHsR5xQerDs=;
        b=v9N2Y53d6pymLKdrraoL6t6HXknKjK3ji1RFbkGJnw7yh4i8RJzrF6IWaQvu5knjJw
         hWfdGAsj536S9Ny33VprUTarGGVZ3ckRiGeFqWQVikxk/5HssOcuQTpiCYiWvBPoamDl
         Q4x/akbnjrHDkG8iG/kdpkukLt53GTaA4FsTVycLOscxhZvSPkaOZvSHzuOzgGOY4WAL
         utMYM04uOpmt9Cx/CDjWNm1aXtTIReuaFR+qK5K30DQPT0CWXLuhrUm/h6TI8KVwMTsf
         YooFrkamllV6WkOL/3jokTobafqD8boadu7R/n6TfuwR+uHpHE0ZVpbA+DTi+p6F5bDR
         MWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700505505; x=1701110305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kg0bpxRdcL8t4yRhGzqbCgUsQk8IIqBGTHsR5xQerDs=;
        b=hP4nWcUm/Kt2Lb72EPzgRxdIH0E8UB+D/WwRbf9Ebk0ijVNg4FVm3RhhiOcTEE0JtF
         A1ipETPJRU53zA5Ag+h7mQGg5DANZlX1UYiIA8SzfqjSpiK52US0KL5xeRYU9MSJDZmv
         i4w6HYLoijC7mjMeYoyRELUV3bg30ya9lyD9uD3R4GJQ2Xa6csXemjnvOH2sUDRJkdGy
         VFYhumdB7EcEXwybOGGozc+5aa5XY/p9lx48Q/tmS/Vd7Lej4Ze2pnfzQIjpwoQY53Cl
         9LET5JxeoNt5xuHWRKiRTL8V9W+V3MfMK3mjZMYzgme7zoYWwBC3j1HHlRnFGp81ZbI7
         jRqw==
X-Gm-Message-State: AOJu0YweRZtRvIQvgryDSAQMYsNrLH9cxVQeyWEUCEA5q0SDznQPIHDF
	/MIz7JFAdNgnqD08di3c4m54Wg==
X-Google-Smtp-Source: AGHT+IHMunydcfDqafYEVS8rh4UBWcg4B9mAZ2t8F2fQH+JRl/yole2wNILvFQ9UWlf9jYlmdOnM/g==
X-Received: by 2002:a05:6000:18a9:b0:332:c9c3:2cd3 with SMTP id b9-20020a05600018a900b00332c9c32cd3mr2386984wri.47.1700505504906;
        Mon, 20 Nov 2023 10:38:24 -0800 (PST)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id y4-20020a5d4ac4000000b003316c8ad545sm10939806wrs.76.2023.11.20.10.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 10:38:24 -0800 (PST)
Date: Mon, 20 Nov 2023 18:38:33 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] iommu/virtio: Enable IOMMU_CAP_DERRED_FLUSH
Message-ID: <20231120183833.GA38524@myrica>
References: <20231120-viommu-sync-map-v3-0-50a57ecf78b5@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120-viommu-sync-map-v3-0-50a57ecf78b5@linux.ibm.com>

Hi Niklas,

On Mon, Nov 20, 2023 at 03:51:55PM +0100, Niklas Schnelle wrote:
> Hi All,
> 
> Previously I used virtio-iommu as a non-s390x test vehicle[0] for the
> single queue flushing scheme introduced by my s390x DMA API conversion
> series[1]. For this I modified virtio-iommu to a) use .iotlb_sync_map
> and b) enable IOMMU_CAP_DEFERRED_FLUSH. It turned out that deferred
> flush and even just the introduction of ops->iotlb_sync_map yield
> performance uplift[2] even with per-CPU queues. So here is a small
> series of these two changes.
> 
> The code is also available on the b4/viommu-deferred-flush branch of my
> kernel.org git repository[3].
> 
> Note on testing: I tested this series on my AMD Ryzen 3900X workstation
> using QEMU 8.1.2 a pass-through NVMe and Intel 82599 NIC VFs. For the
> NVMe I saw an increase of about 10% in IOPS and 30% in read bandwidth
> compared with v6.7-rc2. One odd thing though is that QEMU seemed to make
> the entire guest resident/pinned once I passed-through a PCI device.
> I seem to remember this wasn't the case with my last version but not
> sure which QEMU version I used back then.

That's probably expected, now that boot-bypass is enabled by default: on
VM boot, endpoints are able to do DMA to the entire guest-physical address
space, until a virtio-iommu driver disables global bypass in the config
space (at which point the pinned memory is hopefully reclaimed by the
host). QEMU enables it by default to mimic other IOMMU implementations,
and to allow running firmware or OS that don't support virtio-iommu. It
can be disabled with boot-bypass=off

> @Jean-Philippe: I didn't include your R-b's as I changed back to the
> nr_endpoints check and this is like 30% of the patches.

Thank you for the patches. For the series:

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
