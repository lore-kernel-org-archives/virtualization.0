Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187D6A48
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Nov 2023 00:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OMQrU8VK"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7FD8E82036
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Nov 2023 00:33:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7FD8E82036
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=OMQrU8VK
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L35LW-14E2ER
	for <virtualization@lists.linux-foundation.org>;
	Thu,  9 Nov 2023 00:33:07 +0000 (UTC)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B6C4082032
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Nov 2023 00:33:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B6C4082032
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1f03db0a410so147575fac.1
        for <virtualization@lists.linux-foundation.org>; Wed, 08 Nov 2023 16:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1699489986; x=1700094786; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XpvSVpOIuoICwr0eisYk7Xi99IWTfuOr8GvS2fUSAq4=;
        b=OMQrU8VKc7z+OdZ6W9Sj7EHwlGkBf1U2r9eY4xM+8HGvF+WzYcD/jwDfsAyj9Pq5A1
         wzPq+aFRlEaeRt0esfaLu43Oy3lcM4o9Lt3gfYpE40Gsk7qBmdJ+OlnEt2zxoUGoGuXk
         gP2Sn6rwv1erLK+IdQArEzN8uKJpoNR01/q0b4JQ3XAR2abp+pNpEztmvUy/BLAjVfau
         tzEK+TT+9YDlr3HYlp7nIJiD8yBfUfcADO6QZSoc+eVH85uftsadZ0BAZtM1dgAi5SZV
         qbaZcbybJDl4kYv2Xauj0NhPPx6VUKmJaevst0CQqIKIQHvW4GkrIVYVccQzmRPZg2Ro
         I9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699489986; x=1700094786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XpvSVpOIuoICwr0eisYk7Xi99IWTfuOr8GvS2fUSAq4=;
        b=da872FmnQ2UrE/fvqJePuE81wfLm/CVkG1UWdazIm9vHH2cHUA4yTvX/Uv0i7c0wIp
         LCOTjsFkPlIpMaaecDAG4GrMQGem5C30vJpSjinMdp33RcVUFO62ZoxOw3LtYZpRwkLf
         ZaOpdNkfDclCl64b+k4y1oqWqSpV/olwlOVznJmVC3MRshpVP2GbdVgY6q1OllqDGm7Y
         TJSFGRcHEnRe1KX+lp3aD8gaDIhvp2sIg7H9fqZU6+vtpUeHC2EY4tCsVDa9T+vB04DA
         xH2WhtAVkng61jKqvVuYA/HzhO9ATd+M+Dyv7XgfhW3C3u2UUTgVz6LCwThqWb5RBI9Y
         SCLA==
X-Gm-Message-State: AOJu0YxuMj9kblSAlCQxsklzNpC8YU7PkptThAO92R6JG8Qf7Q7W56ax
	ToQf5mmTRoez8Tsnn1N0ROwl6Q==
X-Google-Smtp-Source: AGHT+IF96nOKOaNh89TNNrC8DvAIA42Xn4IPrYpq+5CGXZoyWBXuWbQokFnyps+CZE1BYCDOJhxJVg==
X-Received: by 2002:a05:6870:1290:b0:1f0:36b6:ef26 with SMTP id 16-20020a056870129000b001f036b6ef26mr3049223oal.46.1699489986633;
        Wed, 08 Nov 2023 16:33:06 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id ki14-20020a056871bcce00b001eb7196de06sm508956oac.54.2023.11.08.16.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 16:33:05 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r0sym-001jjD-8L;
	Wed, 08 Nov 2023 20:33:04 -0400
Date: Wed, 8 Nov 2023 20:33:04 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Zhang, Tina" <tina.zhang@intel.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/5] iommu/vt-d: Add generic IO page table support
Message-ID: <20231109003304.GG4634@ziepe.ca>
References: <20231106071226.9656-1-tina.zhang@intel.com>
 <20231106071226.9656-3-tina.zhang@intel.com>
 <20231106193228.GU4634@ziepe.ca>
 <MW5PR11MB5881FC3D9DBF14D6BD07025489AFA@MW5PR11MB5881.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR11MB5881FC3D9DBF14D6BD07025489AFA@MW5PR11MB5881.namprd11.prod.outlook.com>

On Thu, Nov 09, 2023 at 12:10:59AM +0000, Zhang, Tina wrote:

> > If this is going to happen can we also convert vt-d to actually use the io page
> > table stuff directly and shuffle the code around so it is structured like the rest of
> > the io page table implementations?

> Converting VT-d driver to use io page table involves much code
> change. I made a local version of it, and it didn't prove much
> benefit.

Well, it structures the code in a similar way to all the other
drivers, though I admit to having not looked closely at the io page
table stuff.
 
> VT-d only supports one 1st-stage IO pgtable format and one 2nd-stage
> IO pgtable format. So, the current IO pgtable handling operations
> seems more efficient comparing to adding another layer callbacks in
> them.

I would like to de-virtualize those callbacks, is is completely
pointless when we have per-format iommu_domain ops now.

Jason
