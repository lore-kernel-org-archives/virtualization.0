Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA3E1F12F1
	for <virtualization@lists.linux.dev>; Tue,  1 Apr 2025 10:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743503725; cv=none; b=uLy52pepAJDF5pG2ecDkeCLV4JKVnvnRybnY0TZ25LyPVEeXIA7jVXMJLBGIU+634xIW5FiUq8sALMcF3i8oIS1mB03bzCbM70Btx4T1WYtfXsLjPCqpEMxbS/JVtGEcZq8wYt0Aaqwd7fYCdtwRVClmVQ3YZObq6a6HN2OtBVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743503725; c=relaxed/simple;
	bh=bB0Q88NaQ1z3A+sAKvbKfweAcqrwjXi0SB3rHqKzM6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3PJ1d0BUa+Lz8XUvK9cXqcFol3ky59q4EGwfRUugC/KGIXP7UeTRJPu8Tn5eSF2ajvcXStMhbfbFCxXi8nmDJ+LqBF/Pf9Dh/Cg2eRlGH4OanChZP/SQkLwDCWh+e9nNo8E/LZhSx+louNrI0UuFasI5idY020xqvYihFm8QYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S7KduqAL; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S7KduqAL"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43d0618746bso37169205e9.2
        for <virtualization@lists.linux.dev>; Tue, 01 Apr 2025 03:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743503722; x=1744108522; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=094SZ9fz+o6eVY5ZaePMpljZ6ZXESAEN9w/PXff7gsU=;
        b=S7KduqALguK4NWtjIOmz25qBDMhw4iAKyDMh8EFLnbGHKJ7yykeoVeFeTk3RQ6f5kl
         3GtyRhrJvXd+AqKv6yBoR/UTrA+HhQfV1r5i/kcUijGj5Br4857L0x5CssQlRXqiGuqm
         mSi3WPFAmRnLZGm31z0vKs7J8wMdxujLE+IrQkLgN3P/GS6tQaUH8HrL28oyq+BQpitm
         8NGkT5dlA3LmeLIaY1gnU20sn9oRJw9EGGemtpEQU6F80lUegrDZZXeGvTQOnnpAOi41
         oVFkbiNu8F6F5+6CkGfrJxkdN+6wchHu1QHuE9HRMgW1erbmC0Pppb/rZ4m6TC3E/ds5
         QC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743503722; x=1744108522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=094SZ9fz+o6eVY5ZaePMpljZ6ZXESAEN9w/PXff7gsU=;
        b=lteQ9FVAY0yAwoOOMlPD77KjAbcTuhseUXbBXxW6Xj5/3brn50E4FtJpqxGLGGMwCR
         UO1uU1bvUFVeocQjHtS2wLQK14AxaUaieglder8lXsO5zs9KjDx4L2OUjkgJGR1gJzjf
         8X6ZLNlvMje32aY0P9WYcqaBBIH75f3qwsDuBj4bOaeAAGe+sDRhOh7p6PJrGMOLDY87
         mOGTZ6sev0iUcQwGMsXF4ABN+f+S7xVoWJSTWMPy59ltQOREPOO2XqxFtPvSA93viVGX
         5S0ncbUNaI8eRzYm1+gL5XPMU75x12vqFmHDhgk3cOT6FdZNiCO5LtpURpqIpVpnE75S
         +D2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4myd1URnOE9CeExsD3pr1NcZpz2fl1bF3GvswPOGzp5sNDjz1MW5VMe2Mq1Brr0ef4P9t7Rb4l4ak5+UtMg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxVnD4FtPi/i3bMdeGp50mgclKVMowPNyp2myzcTVk9/AFB6EMc
	HIojfe2O7Md+WJvEM1UeGYNOnTDw4BGMztnbIe7b85yzqzRIwWLDkoEtjVR2ah0=
X-Gm-Gg: ASbGnctBprqrrqqzpankY6l6xVEGgYAkMFXxKXYBRv3x95WfZ9bjf2/SUsunSPhp7bw
	zAiliiKb7ZhT28vEFzeiahh8aPpw4bbnRADr9pRsqEAP1IXQndjpMaHJkN33GVWBXdOt0DvONOJ
	iZIgktG/WRlEtOEBIXXTH6otkq+aV9hddVppwTEpZBnKYMT/du+++IbQSDPXX02krDdqN5tb8RZ
	FNENu0I9NQwipJ6pvVlCZnPf+IMsiMqgtxPzBAyvsJkx5Y0Hqs89aoyubxZSkQZqJxK6+DtCqAk
	RE7h+l/VZPPrJ+fD9u4uP7KTJ64Zm1DnGXAas8E8CeA=
X-Google-Smtp-Source: AGHT+IH0MYFlI+kNZ16n6YuowDwZDpAgl0lcpbfUtl1S5hYwQqcUs9sspCA+WvoevEZPVnDHgpx5gw==
X-Received: by 2002:a05:600c:4e87:b0:43d:8ea:8d80 with SMTP id 5b1f17b1804b1-43db61d5fd2mr102696825e9.5.1743503721639;
        Tue, 01 Apr 2025 03:35:21 -0700 (PDT)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b658c87sm13912049f8f.9.2025.04.01.03.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 03:35:21 -0700 (PDT)
Date: Tue, 1 Apr 2025 11:35:19 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Joel Granados <joel.granados@kernel.org>
Cc: iommu@lists.linux.dev, David Woodhouse <dwmw2@infradead.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Rob Clark <robdclark@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Will Deacon <will@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
	virtualization@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-tegra@vger.kernel.org, pierrick.bouvier@linaro.org
Subject: Re: RFC iommutests_: Testing software for everything IOMMU
Message-ID: <20250401103519.GC2424925@myrica>
References: <5zoh5r6eovbpijic22htkqik6mvyfbma5w7kjzcpz7kgbjufd2@yw6ymwy2a54s>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5zoh5r6eovbpijic22htkqik6mvyfbma5w7kjzcpz7kgbjufd2@yw6ymwy2a54s>

On Fri, Mar 28, 2025 at 10:11:13AM +0100, Joel Granados wrote:
> Custom qemu device: pci-ats-testdev
> -------------------------------------
> To support IOMMU testing under qemu, the pci-ats-testdev [10]
> (different from pci-testdev [11]) was used to emulate DMA transactions.
> It is a full fledged pci device capable of executing emulated DMA
> accesses. It was originally intended to test Linux kernel interactions
> with devices that had a working Address Translation Cache (ATC) but can
> become a platform capable of testing anything PCI/IOMMU related if
> needed.

Yes please!  Maybe "pcie-testdev" rather than "pci-ats-testdev"?  There
are other PCIe features that are poorly tested at the moment, for example
PASID and PRI. The programming model of devices that actually implement
those can get too complex so we need something simpler to precisely stress
the IOMMU driver infrastructure. Driver unit-tests alone aren't good
enough for exercising TLB invalidation (DMA after removing a mapping must
crash), tricky cleanup paths (eg. killing a process bound to a device
that's issuing page requests), runtime PM, MSIs etc. I'm guessing testing
newer/future features like TDISP would also benefit from a simple device.

Some time back I needed a device like that to reproduce some tricky races
but never got round to implementing extra PCIe features. Although this one
[1] is based on virtio any programming interface should work as long as it
can instruct the device to send precise DMA transactions, ideally many in
parallel.

Thanks,
Jean

[1] https://jpbrucker.net/git/linux/log/?h=virtio-dmatest/latest
    https://jpbrucker.net/git/qemu/log/?h=virtio-dmatest/latest
