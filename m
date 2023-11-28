Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FAD495DD
	for <virtualization@lists.linux.dev>; Tue, 28 Nov 2023 22:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="INNf2Tn2"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-58d98188dc0so1249545eaf.3
        for <virtualization@lists.linux.dev>; Tue, 28 Nov 2023 14:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701212144; x=1701816944; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wfgEOy2prfurtAfhJK/0Guihsou0dTaccer75iSoWso=;
        b=INNf2Tn2CzWmJgDEYImmQXqL/CRWuGH78l5kUawYTGfDRnmVjr7HCUXkpf4VHJG3Vx
         qg0dvTTWCPeVUppUQXgqYrZijxW7Vk0iBPsvJnlg3Bh6RfMO1cR/bsp7E/k7eNGq5IEX
         hxsT1ah6aeldFWDStakKCRJalO6z5eZT16PjsMvQzFpagXggiFYegrfwIlPKkvoj7J2V
         01Qxblv0/ivK8Ioakz77anYROfpu1HXoWvWP6MYuu1Fhksn0ItgH3n3xfwSkoiyLEyH1
         t33FVp/pbHFnxS/0IOmOlkInh8IgwUP3kpGyfVObuwue+nPDgLT+B32MR8a7/Ukedp6e
         2dKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701212144; x=1701816944;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wfgEOy2prfurtAfhJK/0Guihsou0dTaccer75iSoWso=;
        b=kaV1B7Zhzyfz56fr/vne0+1alR235Wq7hcuqpebo/Pu8xw+D/QWH4R3PT5Xq9zNmVk
         eT5KgUvkabNyfvPe8vnrkF74iuqTi+r2CG0epCdbdbJJ7OUd959M7X/Bs3CGuOJ/mCuc
         wApOcGvIKrwAWAjjgekgNlsYlsWwqpJOwXbNSQcnWnAU11RCE/mA/LPmSPlgIU2nYJJN
         0EEoocGgIUUScorbyxG/qKuLx0HtGCDxuXLXTReFy1jFUVPziFAKobp2yf6F1PjTupMT
         FnktsQhn7hXKAiXp7wA26fcEAsZ0GSZbf/JrJ2jK1ZXnd8kWe/4XOXECOrLcEOC8CqbR
         bJ5w==
X-Gm-Message-State: AOJu0Yza+B2ZI6pd+rv1M1xs8UrUou2pflLLVFkwUqYDYF9C5hsdGtXU
	Pa3LlApHi9i3Rp8WvOtiImEOv2D7QZi0zqF+D2Nedw==
X-Google-Smtp-Source: AGHT+IHisXYdh3pxH8NCFygwpTk8sa04O8TeLdxM3oMX+99Z92ajNHfOBhWjaeIXy0J8F2P4nyXD+nsTEaXIGG5EBsc=
X-Received: by 2002:a05:6358:724c:b0:16d:fb29:d78 with SMTP id
 i12-20020a056358724c00b0016dfb290d78mr15947280rwa.2.1701212143714; Tue, 28
 Nov 2023 14:55:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <20231128204938.1453583-6-pasha.tatashin@soleen.com> <8e1961c9-0359-4450-82d8-2b2fcb2c5557@arm.com>
In-Reply-To: <8e1961c9-0359-4450-82d8-2b2fcb2c5557@arm.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 28 Nov 2023 17:55:07 -0500
Message-ID: <CA+CK2bDFAi1+397fd4cYetUgmHxqE2hUG4fa2m9Fi3weykQdpA@mail.gmail.com>
Subject: Re: [PATCH 05/16] iommu/io-pgtable-arm-v7s: use page allocation
 function provided by iommu-pages.h
To: Robin Murphy <robin.murphy@arm.com>
Cc: akpm@linux-foundation.org, alex.williamson@redhat.com, 
	alim.akhtar@samsung.com, alyssa@rosenzweig.io, asahi@lists.linux.dev, 
	baolu.lu@linux.intel.com, bhelgaas@google.com, cgroups@vger.kernel.org, 
	corbet@lwn.net, david@redhat.com, dwmw2@infradead.org, hannes@cmpxchg.org, 
	heiko@sntech.de, iommu@lists.linux.dev, jasowang@redhat.com, 
	jernej.skrabec@gmail.com, jgg@ziepe.ca, jonathanh@nvidia.com, joro@8bytes.org, 
	kevin.tian@intel.com, krzysztof.kozlowski@linaro.org, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, lizefan.x@bytedance.com, marcan@marcan.st, 
	mhiramat@kernel.org, mst@redhat.com, m.szyprowski@samsung.com, 
	netdev@vger.kernel.org, paulmck@kernel.org, rdunlap@infradead.org, 
	samuel@sholland.org, suravee.suthikulpanit@amd.com, sven@svenpeter.dev, 
	thierry.reding@gmail.com, tj@kernel.org, tomas.mudrunka@gmail.com, 
	vdumpa@nvidia.com, virtualization@lists.linux.dev, wens@csie.org, 
	will@kernel.org, yu-cheng.yu@intel.com
Content-Type: text/plain; charset="UTF-8"

> >               kmem_cache_free(data->l2_tables, table);

We only account page allocations, not subpages, however, this is
something I was surprised about this particular architecture of why do
we allocate l2 using kmem ? Are the second level tables on arm v7s
really sub-page in size?

Pasha
