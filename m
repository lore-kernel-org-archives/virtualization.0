Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E889F2B9BE
	for <virtualization@lists.linux-foundation.org>; Sat, 29 Jun 2024 01:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719623521; cv=none; b=enudi6BBJyLy2EDvk+azd0ri+1M0Z+s/ekK26f7V1J5S1ZFjZvb3aezFVvh/TZIxTn1yxYYieSsKVk9uyEnLDU0SzlwDzZ7Vod+FdedFt0Gj9pkzgZT0XRXQLVcC+mt1hFyDWNtZsiG+nvHaBiGzc6cH20viAPczQ69QzMRblnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719623521; c=relaxed/simple;
	bh=owo+cNn/TUw6Wew2s0YPnRqOgIVxnweK7ckD+KeIf3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YydNLFp0CMSXxeoH2kORMnTiuCQ3GDltSqjOFvVX/POCCUV5nkJMekAg+Z6W/V8gN5nWmgAVr3d8D1N57HrBzAFz79Tatzo+1ma3LRMLLpLlzYyUvmbcIjz93EKtjqgmJLDJ3EOSkBARZSN0pM2nnFshMTlHs/V7qhC1+yxcxo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UutEpBGU; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UutEpBGU"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2FE2540131
	for <virtualization@lists.linux-foundation.org>; Sat, 29 Jun 2024 01:11:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L_ajfjiXWrvU for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Jun 2024 01:11:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::133; helo=mail-il1-x133.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 65CE3400E7
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 65CE3400E7
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=UutEpBGU
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 65CE3400E7
	for <virtualization@lists.linux-foundation.org>; Sat, 29 Jun 2024 01:11:56 +0000 (UTC)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-378d954e505so4568265ab.1
        for <virtualization@lists.linux-foundation.org>; Fri, 28 Jun 2024 18:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1719623515; x=1720228315; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rdZPgDV7aIl0J73xlRHxxXH5BwM06TOu62VfOoYuq0w=;
        b=UutEpBGUBBPKO+pG9MZmUsZvj1V8AVWDmCedTZySINFlHw0VWvO/9pwiidrhDRzfnE
         efjw3ZMbk9hwexzkZDJGRMmuPRZbVr8q4NesAQSCyx2imK7vaSppKONfUpkOr7VvselM
         quea6HqOyXZzRvDVUD2hblyVArhZtBPoQN4t9rFihUetw8GCtKETcmPFsuDCsIxVYQSB
         2D6JBn3+BNKN9uIfXub4VY1z3LEl8sv+FJ/TlQd4y+LaPk60QHEAc5jEhm8xkCTFwcOt
         /47dP1VlrgtOkDqFbjQcIIDejD13FDCshBsHfPXC3YyQfL82EOsv+u6iSLR59TD2L1rF
         LUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719623515; x=1720228315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdZPgDV7aIl0J73xlRHxxXH5BwM06TOu62VfOoYuq0w=;
        b=lkhHOp44eDFnRK0qcI4oXNvYaIGwIOz6zUPLOFnxSmJ/hSQkcqx/QAL65fD+CChvFn
         HPreohUfAhBABi9XJOH0t1apgL9cCNlnjtWw1i3vR5nSM/LOxgi3oF0CQ3tY5uE0N26l
         TL3X4+cWqIBbgAOvINJ8xVkWwWa6mOubr6yMosWMC7fMtG2//1TU2X1U8nQZKZl9xAbg
         3IiaRPSjpvXT7pvNgzNt29nh7xnMbhchQguy/jprLNAhmmF91eXbOX9GjkcyFccI/yfA
         Nj9+gFBuCQvJ0PkezFGIKWAxRDqIqoWRCZ/x07fWfYIpbAsB4xraDjtdqfioAfdzlyqB
         hXbg==
X-Forwarded-Encrypted: i=1; AJvYcCUh7AX0vIgBrrtjm0OZR2FdMvian7zZ/fmOLPPnw3C+Y8w40m8iQfJuos80M9lrnQKYKenvnear1YAo1NoF2feBa0R063yeH9AKZeRqhDJOPIl8YwuJa5vC+g==
X-Gm-Message-State: AOJu0YzH2BoYbtwOtn89g3uCm/KLgOsfZwqeJ7dHSSK238R1+KdFSzkC
	+56X5m7GN6ere5HJCtpA+/WsBtl32D2mS8TPk/5Zvge+fbnzpB1DvqqKINfxacs=
X-Google-Smtp-Source: AGHT+IHX2JUaclIoPrHTyWd3NWpAL4bg4r61iFuy9mfBP9il15TCI+aZkWxWAJEJRM9M8Gi0RE+u5w==
X-Received: by 2002:a92:c24d:0:b0:374:97b4:dbd1 with SMTP id e9e14a558f8ab-3763f633817mr217872295ab.18.1719623515458;
        Fri, 28 Jun 2024 18:11:55 -0700 (PDT)
Received: from ziepe.ca ([24.114.37.55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c69b53be5sm1784142a12.16.2024.06.28.18.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 18:11:54 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sNJr9-0004o0-Ot;
	Fri, 28 Jun 2024 19:14:11 -0300
Date: Fri, 28 Jun 2024 19:14:11 -0300
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
Subject: Re: [PATCH v7 06/10] iommufd: Add iommufd fault object
Message-ID: <Zn81szS0G27keAwB@ziepe.ca>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
 <20240616061155.169343-7-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616061155.169343-7-baolu.lu@linux.intel.com>

On Sun, Jun 16, 2024 at 02:11:51PM +0800, Lu Baolu wrote:
> @@ -6,6 +6,7 @@ iommufd-y := \
>  	ioas.o \
>  	main.o \
>  	pages.o \
> +	fault.o \
>  	vfio_compat.o

Keep sorted

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
