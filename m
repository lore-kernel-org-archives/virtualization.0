Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE186166B
	for <virtualization@lists.linux.dev>; Wed, 29 Nov 2023 21:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Lp5uPDC+"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-423871dc183so1465611cf.2
        for <virtualization@lists.linux.dev>; Wed, 29 Nov 2023 13:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701294586; x=1701899386; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cpfJU5sAguyt0/G2iahMIWT2bpNq5anO26/F530wIyY=;
        b=Lp5uPDC+mdT1yXJredYQDmUmgob6XCvFiBu9hllnH3jX3lSKmFtvlVERj6OKdn4dol
         60fUWpt6HbFoPduUxgrwmCaRj6SV4T5RB80o0+SRqd/jtiK/7e7VqhvuM2W+qNu/Mq0G
         cYy1KasC4Rfk24yN3j/McFFVkrzt+FwuBToWzJzbUmQh3dcWpF72wwMoCLGsE+kxukfr
         7Wy5NmqHPCmTqQMS+8nxbbgjNrP9f93GWbI4J+JDadzg+d9B1qY4BgFPMvk+raN5z0GM
         VnS1tw/9KgHZ4eUJPnTQi4Ly326P8ivptQfxJRlnMM0oy7md5RLBBZibBWW1nZo/PXTA
         mjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701294586; x=1701899386;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cpfJU5sAguyt0/G2iahMIWT2bpNq5anO26/F530wIyY=;
        b=In7DYbENgOQBu10Iy0cOskf+XPFNKhK33zR/ywPfSKO4Ic00gUjy9Cq+ojnomQo0Y9
         n3cxGoQ1V/+DxCcUpxvvTCi1+KPeGyZxHhD+uRrpMNQtKi0AeZ555eiAlYNQMD1NTS6n
         wJiedui0cKoS4HlECbBNGuiET/G8wULkQIJFn1eAW6MNYlUho8eHg29RIc/+hZdML/Gw
         6NjCJ514ag3LXst+2WMgiKO7gW/FcHP0sP4LEB6yA+dCMMOeboQ834VwGNFH9soswMFK
         mzHbqSQlXf2kH1PGF1LxT8Na9/k0hsPTG5t2RK/WN4/MtBxpk+RrogTi957RX3Ty40BP
         qyMw==
X-Gm-Message-State: AOJu0Yx5gc7eiW7CYLJHbd1hbZyLNy2h4mGS2u5beCDCvVrC2B6UOGGl
	e9i+hnOxyGnAa65ns7PAN7QyTqmDI+CH9CPo0iDlOQ==
X-Google-Smtp-Source: AGHT+IHQGnPttzbf2bAdb5gwZpT0Nh8amOSeNRZF+eb1/SrYiR5d7rhV+9FkDuUK6ClQ83baR1dhxHx1LVYRiRyKJoI=
X-Received: by 2002:a05:622a:34c:b0:41e:213d:3c8e with SMTP id
 r12-20020a05622a034c00b0041e213d3c8emr22630747qtw.32.1701294586528; Wed, 29
 Nov 2023 13:49:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <20231128204938.1453583-5-pasha.tatashin@soleen.com> <ca7a025d-8154-4509-b8ab-2a17e53ccbef@app.fastmail.com>
In-Reply-To: <ca7a025d-8154-4509-b8ab-2a17e53ccbef@app.fastmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 29 Nov 2023 16:49:10 -0500
Message-ID: <CA+CK2bB-TMCgpjvuXRigNaaA2Zmj=r3PHTQMaqs5W-9FkE3roQ@mail.gmail.com>
Subject: Re: [PATCH 04/16] iommu/io-pgtable-dart: use page allocation function
 provided by iommu-pages.h
To: Janne Grunau <j@jannau.net>
Cc: akpm@linux-foundation.org, alex.williamson@redhat.com, 
	alim.akhtar@samsung.com, Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev, 
	Lu Baolu <baolu.lu@linux.intel.com>, bhelgaas@google.com, cgroups@vger.kernel.org, 
	corbet@lwn.net, david@redhat.com, David Woodhouse <dwmw2@infradead.org>, hannes@cmpxchg.org, 
	heiko@sntech.de, iommu@lists.linux.dev, jasowang@redhat.com, 
	jernej.skrabec@gmail.com, jgg@ziepe.ca, jonathanh@nvidia.com, 
	Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>, krzysztof.kozlowski@linaro.org, 
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, 
	linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
	lizefan.x@bytedance.com, Hector Martin <marcan@marcan.st>, mhiramat@kernel.org, 
	mst@redhat.com, m.szyprowski@samsung.com, netdev@vger.kernel.org, 
	paulmck@kernel.org, rdunlap@infradead.org, 
	Robin Murphy <robin.murphy@arm.com>, samuel@sholland.org, suravee.suthikulpanit@amd.com, 
	Sven Peter <sven@svenpeter.dev>, thierry.reding@gmail.com, tj@kernel.org, 
	tomas.mudrunka@gmail.com, vdumpa@nvidia.com, virtualization@lists.linux.dev, 
	wens@csie.org, Will Deacon <will@kernel.org>, yu-cheng.yu@intel.com
Content-Type: text/plain; charset="UTF-8"

> Reviewed-by: Janne Grunau <j@jannau.net>

Thank you,
Pasha
