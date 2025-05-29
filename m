Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B51DEAFA
	for <virtualization@lists.linux.dev>; Thu, 29 May 2025 00:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748479110; cv=none; b=egg7uvmelabexEN6yax+aqcyJXU7rENns1S21dOywgCXHQY2yhLGeydugWGqQOpBCoj/6fFEWR/G7wGRyWR4QjtPHJoYViuqc+5KEnlu0AwNw/TaB5erN7aBVrSnHCjNaI5K1WKvgG4ri2x3QIzS9oXBOPyLzDHSwZILSxfKfVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748479110; c=relaxed/simple;
	bh=ze/vE+pLOw8LtKqumJmv32tL8OFv0ndyxShmm8Q5lTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRhE7yFJgVmnCUlbd5eEKaU/F54WDOElSmWI/TiGrZo4qOb6+/WgzlUk7Mur7mo+afiKXBmaVxHx8UodvaqpoLLFxKUqXiXU4J7JTMrTuXQrkbbekwyAYIU8vdSdwf+As66atnvb+FwrTh733WFpgVFf1OVJ6x4HyRDEShhz234=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=pH+kIo9J; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pH+kIo9J"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6f8a70fe146so7193996d6.0
        for <virtualization@lists.linux.dev>; Wed, 28 May 2025 17:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1748479108; x=1749083908; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sVQkha02xf9SMmtYT1jV9HNI/f56xB5GG/vabKlGDf4=;
        b=pH+kIo9JCIM989xAeZgCTlHvTWVlV3FIi+EyRdOk30GYUcTtC1b1WxqmG3iktVw8u9
         mfKFJSEB54m8Y63LxACD4PssiWCsp3ZvRgIhUhLNvLLb0tF9xiM4H0Tn5ClQAZFniTsO
         0Vdhx1JN5hg6lWYCdTRRs4tMsYSwX7zYSQXUrDjiMeDR2bIrJwO0x5m7N3GCfSJA/DFs
         01om6YaSlJL+NBd1ZELL0nLVQFclw+Cg4YSWVfnChg7ISGG1Pg4SnfaeEu+cnQxRm1As
         OSX9Jp8i2WzdNcSCCD1f8VAs+pN4BJltOv0zAKuogPGlJMKVMMyJq7SKnaPnYn37+uv5
         y8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748479108; x=1749083908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVQkha02xf9SMmtYT1jV9HNI/f56xB5GG/vabKlGDf4=;
        b=nq+3ZTF7718W1lEvkJ+SHIvwo5ZnlisLpmU/1R7jOlB5rMysNQyF+Rm+YTC6JYErXo
         TqgMGjTBwC5Fvk3E9KpTtwxq8+rqhRuxUHzbW/w1MkqqwHpaSGrrlTUGju6a2lxQAtoM
         rtZGqxJMCwCYCeKfU+Tt85ymWErs1i6BDFay9nic1xRBcCcrDJtqVVLF8xj0MUF9AaIS
         XH9NdPE/iC2tjTq4/bjts/94B/zLofH9iDoU3TRxWI5JT5HOqI7RirhCOUL93atZzfeQ
         sZx4xLdnTUtifGiV4kumVB4CYw1DU3jf4qbOovLYO9gYZhsf7Tir8/kgnxYhSjsTxF/Q
         wyxw==
X-Forwarded-Encrypted: i=1; AJvYcCVM2tU6KY/RVkWw+pYtBjCYRZvgY/FVuC8Ch3mvePK0xz25QEvB35MC9YSRzS71+1rOFOv1wgUBz58OEZ3OfA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxlcqRGgkiae5jGa0Pv4hDnkvK9jfZYk2NaB+ady+Z8Py4ZQC3d
	oAaTw5hVu/pALwTUAMIElFkK89gCoJD9FOxvgmpVMBveGa02hIdwkS97xLsE7tJi30k=
X-Gm-Gg: ASbGnct1H8N/W9PIipGg8XdDh1J/Fbtbw/ovvvHQY1zaaUa+2zW0cmFFBCxwN7AHa5w
	uF2uGyE4q1tiAIiuL4m7KoLiVIP+C7bQ45YB049oeZX7ls6hmOSw+oBojVYG6yDrsYgjZMN2Ie8
	ntXrjTQ0HuFG0lQe7S/QQV2uHI4OcYN6oJJtIZVW1cdgx22mCMwDrG8nrSf7J1QbDTou3r2g4ny
	ZpJTJQag8wA9wQazudkTyWs8trhIyAtVpMh7ztiOMOSI95ZMeF5AI0t8gYtHwaXeBS46fHcLI4u
	8HPvDio8we46CPLZz901J63jHH09KLi0gcMc7SaQ+CT/RyLvoAYRrzA2+DdBE/KXrjWKQXSw3V0
	AI+R+rjHu9wmbvE2yFzfVPrjxSvo=
X-Google-Smtp-Source: AGHT+IGrrQU6seLehXMngMNgswY4d6WsTh2X0qCSzttXJecRsw5bF1myMzmOuM/dLs2M8hI+8CLE1g==
X-Received: by 2002:a05:6214:234e:b0:6fa:c85a:20c0 with SMTP id 6a1803df08f44-6fac85a2328mr4035616d6.28.1748479107982;
        Wed, 28 May 2025 17:38:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac6d337aesm2521866d6.8.2025.05.28.17.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 17:38:27 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uKRHu-00000000qmU-32Wy;
	Wed, 28 May 2025 21:38:26 -0300
Date: Wed, 28 May 2025 21:38:26 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Shyam Saini <shyamsaini@linux.microsoft.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	virtualization@lists.linux.dev, will@kernel.org,
	eric.auger@redhat.com, code@tyhicks.com,
	eahariha@linux.microsoft.com, vijayb@linux.microsoft.com
Subject: Re: [PATCH v2 0/3] arm-smmu: select suitable IOVA
Message-ID: <20250529003826.GA192517@ziepe.ca>
References: <20250410225030.2528385-1-shyamsaini@linux.microsoft.com>
 <20250410230008.GA6905@ziepe.ca>
 <67fff12d.650a0220.208c7c.d69dSMTPIN_ADDED_BROKEN@mx.google.com>
 <20250416181759.GF493866@ziepe.ca>
 <20250520224224.GA16365@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250525190703.GD12328@ziepe.ca>
 <20250527205428.GA14019@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250528000425.GC146260@ziepe.ca>
 <68379171.170a0220.191ee0.8d6bSMTPIN_ADDED_BROKEN@mx.google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68379171.170a0220.191ee0.8d6bSMTPIN_ADDED_BROKEN@mx.google.com>

On Wed, May 28, 2025 at 03:42:55PM -0700, Jacob Pan wrote:

> > All IOVA that the platform cannot DMA from should be reported in the
> > reserved_regions file as "reserved". You must make your platform
> > achieve this.
> > 
> Just to double confirm, the expected reserved region should be marked as
> "direct" instead of "msi", right?

I don't know, it depends what is wrong with this platform.

"msi" is the SW_MSI region created by the iommu driver, ignore it.

"reserved" should be from the DT and it says "my platform is broken,
this IOVA doesn't work, don't use it"

"direct" is something entirely different, it also should come from the
DT and it says "must be mapped 1:1 (iova:physical) at all times" which
usually means some FW or other component is controlling the device and
doing DMA using that physical memory space which is unknown to the OS.

Both cases would interfere with the MSI so if the DT/ACPI declares
such regions that overlap with the SW_MSI address then Linux should
select another SW_MSI address.

From a linux perspective "reserved" just ignores those IOVA spaces
while "direct" sets up 1:1 translations there. So FW using direct
incorrectly could become a security problem.

Jason
