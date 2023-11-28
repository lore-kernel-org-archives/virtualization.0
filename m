Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8E15C3C0
	for <virtualization@lists.linux.dev>; Tue, 28 Nov 2023 23:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="S7cvX4lt"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-58d9dcdf201so1232114eaf.2
        for <virtualization@lists.linux.dev>; Tue, 28 Nov 2023 15:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701215638; x=1701820438; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IEFdBGBIPfDPsFioHp1AVnDQQb24hQej9vfPWpRMMTA=;
        b=S7cvX4ltKA2W5vX3M3S9YY+oDJ0zMseaDv2GXbs22IYf+lgAmryJdrSkZvG1tTLm6+
         0ZV1VRHyzD5C2ipcfraF+JNs4QRaW5XM1R5JY5I5eIonAuiwEvjMstxPV37cuM6Bvxzg
         KuOQSrAyIylsCFTFNr1SZmJYH8Fbksse08pyFa1knV+gZEOS5q1tKsvvQOi0e3c5ce5/
         B/hpL2lYHoSM8C0XcGLwOuexib3kBl4xBZYLoApDKR+nKszNTUFhutStzrh4lJpHAFW+
         9d2WKKOjm2Bm5m9HlRfu5WEk6ujG5vCGzenkJPS6dNdzO6a3BOydUreKQRTC4/OzWQaL
         mqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701215638; x=1701820438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEFdBGBIPfDPsFioHp1AVnDQQb24hQej9vfPWpRMMTA=;
        b=PsZfHKxICFpZ0h3/gqE3TyWvSC6oDBhSB3fpnwG+EhVN2tE1ZrxFdlvQ1SJuyGN2X5
         /il1B43REQ92NDGDAwjQisRAyvPEm3XYOdDeBGQkHKEVfX/v34JXsG6aIT8rneuPwyo/
         hE0kcQRw8u3QXBxtWnGf2l5I6xwxqdmxJk3H6/dpMPzGJpOv4gQMWpLwSsR/U015uNa0
         gL3oxetxM7Z3XNspisWcRMwZVqKm6YVIENEcJ6/1yAgyL3qvDH8FSS8/zwO2yyefmd3i
         0LOFBQZKS4aIe3oQHuyiDgCujbbvuv8F7M6CSs/G/P5PA9/2f9AN6AC2m4mzRiQrosog
         +OMA==
X-Gm-Message-State: AOJu0Yw6FKUe6arV5v9XU3Rg20Kxbo/psxj5Q5kuLsEXYj1W99yVOaru
	H6MeQQullavauCqZ/NsvTNY/Kg==
X-Google-Smtp-Source: AGHT+IG+JvDO46eVb/i8IDuwEuHhA2SVxYkTSZoGtbM2c6nncwzUAA0+bA0p676nl1Is/JNEkvg0HA==
X-Received: by 2002:a05:6820:160a:b0:58d:9bb6:c38c with SMTP id bb10-20020a056820160a00b0058d9bb6c38cmr7347167oob.3.1701215638582;
        Tue, 28 Nov 2023 15:53:58 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id 63-20020a4a0342000000b0058ad7b0b1a8sm2117307ooi.13.2023.11.28.15.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 15:53:58 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r87tt-005jIw-Fu;
	Tue, 28 Nov 2023 19:53:57 -0400
Date: Tue, 28 Nov 2023 19:53:57 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, alex.williamson@redhat.com,
	alim.akhtar@samsung.com, alyssa@rosenzweig.io,
	asahi@lists.linux.dev, baolu.lu@linux.intel.com,
	bhelgaas@google.com, cgroups@vger.kernel.org, corbet@lwn.net,
	david@redhat.com, dwmw2@infradead.org, hannes@cmpxchg.org,
	heiko@sntech.de, iommu@lists.linux.dev, jasowang@redhat.com,
	jernej.skrabec@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
	kevin.tian@intel.com, krzysztof.kozlowski@linaro.org,
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org, lizefan.x@bytedance.com,
	marcan@marcan.st, mhiramat@kernel.org, mst@redhat.com,
	m.szyprowski@samsung.com, netdev@vger.kernel.org,
	paulmck@kernel.org, rdunlap@infradead.org, robin.murphy@arm.com,
	samuel@sholland.org, suravee.suthikulpanit@amd.com,
	sven@svenpeter.dev, thierry.reding@gmail.com, tj@kernel.org,
	tomas.mudrunka@gmail.com, vdumpa@nvidia.com,
	virtualization@lists.linux.dev, wens@csie.org, will@kernel.org,
	yu-cheng.yu@intel.com
Subject: Re: [PATCH 16/16] vfio: account iommu allocations
Message-ID: <20231128235357.GF1312390@ziepe.ca>
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <20231128204938.1453583-17-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128204938.1453583-17-pasha.tatashin@soleen.com>

On Tue, Nov 28, 2023 at 08:49:38PM +0000, Pasha Tatashin wrote:
> iommu allocations should be accounted in order to allow admins to
> monitor and limit the amount of iommu memory.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

You should send the seperately and directly to Alex.

Jason
