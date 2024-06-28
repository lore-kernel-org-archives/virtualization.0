Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3AB208B0
	for <virtualization@lists.linux-foundation.org>; Sat, 29 Jun 2024 01:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719623518; cv=none; b=Vj2lvapMGqw7T7vGEi+xrTKoArFVy8RudEjde6GI39d3fkc32BwdFsayo7HYf89O9GyB2nxep06x7gHxFz754JW1V8fW0vi0MadKHYB3XqFrPK2QyerJsWG5DRa+RqLxeumK3RPce4lsGI79EniZ6GNUGISdm3sgIL1X4r/gF7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719623518; c=relaxed/simple;
	bh=6F/k6dwYH218Hyi1PGuaEb/Ijjso6ev6K6yn6UDiB3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogBuyC1jrCStPniPTKnp1FodCZSVvSgtkKvbI+aocM01k9vT0/6wqLtxla1ouTI3v9NpU3c1zF0FnxXCLJLe+AiADh1pyuZbhpRuEkpDhNBLHc0D38OIjFvO5DGK2/8MWpI+hmi0s7Rt97ivO2OzLnXfv3wiO/OLtrS9AUS2XzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kdHUlDCX; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kdHUlDCX"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DD98B4056D
	for <virtualization@lists.linux-foundation.org>; Sat, 29 Jun 2024 01:11:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.508
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hLq8b0SG3sZe for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Jun 2024 01:11:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::134; helo=mail-il1-x134.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0ACC840131
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0ACC840131
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=kdHUlDCX
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0ACC840131
	for <virtualization@lists.linux-foundation.org>; Sat, 29 Jun 2024 01:11:52 +0000 (UTC)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-375f713a099so4803435ab.2
        for <virtualization@lists.linux-foundation.org>; Fri, 28 Jun 2024 18:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1719623512; x=1720228312; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zmaMdKg0RidMIfRNkaCLQQUn8DgSGfF9Lh4khZx7QZA=;
        b=kdHUlDCXWwxJE59yu5RVVrTpRk2Bgw1bV7zw0GL/3vEk7v4sxinVhR20S7NSgxXLQP
         kY6hzV8eBVB5cp+3x9IWrbusjrU9qBkIglBWgAATIY3DPf3P4JIwNqJJxUSObwyz2mbq
         Cbx9oyoDiMoylTmBMvVTx3JCDaZY7OYfJugfGsg/Vpn8ETDbeXvLqZVNTfhNYmnK85yU
         JShOHaNBKbRk5uoUTGXezG5DOn35EVrkLn5ef9efxBw8qrFBCee8PIdfvUYm6Iv8ixdU
         IW/xO8kJgm5nSU3jnSBdl5k6Vj2pc2LtDsyacx/Thc3WFf1eKHArdEet3Unj01rNGwX2
         k51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719623512; x=1720228312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmaMdKg0RidMIfRNkaCLQQUn8DgSGfF9Lh4khZx7QZA=;
        b=FAxIMu7euszryWPw77FEbgglnjuq3zRsVEQUNu26bBUxvm3JJzuCF6vP32nuvX0V0y
         +NNrcb9k4glWuzndG4Qxle3xUusRb6IIe7oGKh8jMWA5A6QnVhqtZg26HzL6WMEuZdHd
         CGATfGL2lwHMnSTqBXOdOlgfeYnpQVDpuX6hTIAanmWFeIiGBvEWHH+puHbQF6CQ5LIv
         PArgKGdkJ40Rn7sHjWNJo830Es7hARmw5x5Y1KAO7lbqoILiCbmiMOJH6gwe/QRrlbvt
         MX22cS/nYox4Yz85gIRTHa4ZTrNHp2CyKMwkrkXtsx90vBnRzLZquNtrQIMziQTqauyc
         NBdw==
X-Forwarded-Encrypted: i=1; AJvYcCWk/j1PJe5b6pqQzUxEC5eTRYFn2F4l/qoAUMk5KmbMp3p4RodmLJr5ULD2hJk5cxleeg3Kw8aVwpbQKXIsujrFM4E0stWLOxYQEdWucgd2OAHU8yWF/AZwcA==
X-Gm-Message-State: AOJu0YylfMqf+fIXCVQgiR6UvNgJM9HWEqsT3OFbLng3wd1S/txEz2hg
	kOsoIF5C2qSl8odwOBjmibw8W4wb4paOah7WUnn2oCIEQrF6HJPdU37FalwqmJc=
X-Google-Smtp-Source: AGHT+IEt4WuI6UUriXHM21a/iZG/YuB8wOThjfEiLBUbcEKDogKRn2+UhIh8HyJ2Q/QTwEKSXlIHrw==
X-Received: by 2002:a05:6e02:20e7:b0:376:492e:a13b with SMTP id e9e14a558f8ab-376492ea27amr214270955ab.28.1719623511924;
        Fri, 28 Jun 2024 18:11:51 -0700 (PDT)
Received: from ziepe.ca ([24.114.37.55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c69b53be5sm1784142a12.16.2024.06.28.18.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 18:11:51 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sNIw0-0004UM-BR;
	Fri, 28 Jun 2024 18:15:08 -0300
Date: Fri, 28 Jun 2024 18:15:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 02/10] iommu: Remove sva handle list
Message-ID: <Zn8n3Cs7JDxzpRPf@ziepe.ca>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
 <20240616061155.169343-3-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616061155.169343-3-baolu.lu@linux.intel.com>

On Sun, Jun 16, 2024 at 02:11:47PM +0800, Lu Baolu wrote:
> The struct sva_iommu represents an association between an SVA domain and
> a PASID of a device. It's stored in the iommu group's pasid array and also
> tracked by a list in the per-mm data structure. Removes duplicate tracking
> of sva_iommu by eliminating the list.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h      |  2 --
>  drivers/iommu/iommu-priv.h |  3 +++
>  drivers/iommu/iommu-sva.c  | 30 ++++++++++++++++++++----------
>  drivers/iommu/iommu.c      | 31 +++++++++++++++++++++++++++++++
>  4 files changed, 54 insertions(+), 12 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
