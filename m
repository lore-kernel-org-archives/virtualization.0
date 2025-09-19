Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728DE3093C9
	for <virtualization@lists.linux.dev>; Fri, 19 Sep 2025 12:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758283724; cv=none; b=q+8695ymHjHJUo0zFGaRXhaM7ontEMBdTazXdfUqEajsBmQLnhQ+MC6CY1D2JaR92/wzdMuduG4wuUXDKYx+E3vkyi4UeHFE+i9MV1zxbFNd2qtUD/rBZq/BHOgWL77tthApqMt/K6adppxrFlfLxwSUNc3lgyJcZbwjOxRHLrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758283724; c=relaxed/simple;
	bh=PU4BzVSUM6uCKa5w2l6OSfoECkEW3DTQ8YYJ6WsGxgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EvPv0FgUmtMy2m2Xsjn97VYCKp/rVCe8mgQ9wippoWNG6EIYjJ2ZnWzsgeUOrTAT0LW8gxDsJ1+60q9qCDLd2qJICZ375whl0i9X/4GuT8X8o1Wji9+po8H8ppvthV5rGA6iDvCHMwiaAKrWKGenPmrMkG5BmbpPh53Dx6Ic5ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NM5faOPK; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NM5faOPK"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6234995098eso1184822eaf.3
        for <virtualization@lists.linux.dev>; Fri, 19 Sep 2025 05:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758283721; x=1758888521; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ddOV/4AeMTKAaTlLO+S2d6s4wCcUbRWR+oBWKnZEc/A=;
        b=NM5faOPKVeGO7OjDsQsb/kScnAlkMlNFQLKuRGZu3eliqIUtYMGOKu4MSztvFXSA8u
         3p8+BUvdva99GmiPvIAdaKTsj5WhJKPXSlV7ug9b90uifo8AK2mUxla8i4KGDNaX1HsJ
         1BlDsXe6Jia88E+SNGgnbl2Og2YZ/OF2Y57U0cupj469mUJfuGePXac3V6mRmCqKcDzY
         oLUhYj/vHpEZHB5JrOkJRB+mpgK/4s+yCNuh9+EugGaFrVFQmCRZ3o1xhFmd/DnuEdyq
         Pq3NwkqZE7KjPgulME4PPdA7+RGudPp+b3MpDDH7csicxRztjsDwoxODGnBzOMqgQ11/
         QbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758283721; x=1758888521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddOV/4AeMTKAaTlLO+S2d6s4wCcUbRWR+oBWKnZEc/A=;
        b=MgX+/ZzOLoHMKGCSHcd7wEnv9oRGZWXxXenkUESW1uJY0Rm6pwSk3f4g9nseAAQrov
         2k8Ig+AwOAdX2KF0ukzCoArgo3feQ6gkqWJeCq//G2RZ2oSXbRt8Pgk2AoT4PTnmNGG/
         gwwEgZWME4TRqrpj+VG5NBI3bfTDzca10l/PrvN5zl7vcymFQ3rUhh3tfV1kSXLtKZdc
         VR5/UYEPKDypZGrSO46px/WokSTBuYsE8r6RSBjDPkzFwKAfCw7oDibVR4BaylGS3c6q
         qHFiXQmjEb8WXryLT83ewo9Yv6aKDbCIe/WH/5N4ltd9MDbIyLNqeSaxRBVuUmJEhg+x
         lWIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpxKnmZcL7xx2isQuhXSil/vR/mjQJVKXMx5iqpEx3sq4FmxKvbsBitXI/EAckeub+iA1pOMb/p6378Ad2ag==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3aRLjqhA/R/Vf5n1ux1/SeJss1d1f24HYzswMcX9fvotAIj/7
	Nms/cYV9+Zl5qUU6lTCbK5n2h0Zs+sMrkQq2uX5hdaQ4bU84f3gHy/B1IJkdDVeV88Y=
X-Gm-Gg: ASbGnct4l2CwTOHnqjdUYltznRf9GoxBYVN42OQ/kIOCYOIWYt8Kpnh97APNom9o3FC
	euQsvQTOXh7ydCY1NNkWEEGNtEeUTsHeZvWPI/S8f8ihkacNyqKU4TAneRbITPAlzftM33nReMB
	B/vbBp6FmoLAT0IfIubQFXfl/m+Vx653nT+DCNLGtuWjFi73o15bZ9ZeB6YYx3L7KsfaSn4SIou
	i3pgxKZvYANtWG4MzGEBFHcijPzugtZkzKBEQ1i2U7Gyi/I4/uVtPkpBtU5NN4QJm+QguqZUJVd
	kUA7Vva5XIw4hLN0WlNpt9nvOL893wUDQRZWrS51bBGZh3IsHpEMTJbPwWgubUoPpZuwWPDeQKH
	+QGKnhSQ=
X-Google-Smtp-Source: AGHT+IFaCWGfMylYUS564NQsUR0mWVuwnX1ZTO8LwVtBeK6iF/UthAXLSHYAnBZ/pCpVTkoFVFyzFQ==
X-Received: by 2002:a05:6820:2285:b0:621:7820:a28 with SMTP id 006d021491bc7-6272abee5f2mr1140086eaf.8.1758283721447;
        Fri, 19 Sep 2025 05:08:41 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7692a973dc1sm2326849a34.30.2025.09.19.05.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 05:08:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uzZup-000000097kO-1FuO;
	Fri, 19 Sep 2025 09:08:39 -0300
Date: Fri, 19 Sep 2025 09:08:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: Shyam Saini <shyamsaini@linux.microsoft.com>, thierry.reding@gmail.com,
	robin.murphy@arm.com, robh@kernel.org, joro@8bytes.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, virtualization@lists.linux.dev,
	jacob.pan@linux.microsoft.com, eric.auger@redhat.com,
	code@tyhicks.com, eahariha@linux.microsoft.com,
	vijayb@linux.microsoft.com, bboscaccy@linux.microsoft.com,
	saravanak@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	lizhi.hou@amd.com, clement.leger@bootlin.com
Subject: Re: [PATCH v4 3/4] arm-smmu: select suitable MSI IOVA
Message-ID: <20250919120839.GV1326709@ziepe.ca>
References: <20250909154600.910110-1-shyamsaini@linux.microsoft.com>
 <20250909154600.910110-4-shyamsaini@linux.microsoft.com>
 <aMw4I0AjKNPY6SOw@willie-the-truck>
 <20250918224322.GR1326709@ziepe.ca>
 <aM0HQ51DelZW_Rt8@willie-the-truck>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aM0HQ51DelZW_Rt8@willie-the-truck>

On Fri, Sep 19, 2025 at 08:33:23AM +0100, Will Deacon wrote:
> pieces and will need to work on the userspace side. It's not like
> MSI_IOVA2 is magically going to work (and I bet it won't be tested).

It could, if someone checks the default memory map a second constant
could be selected that works.

> > Nicolin has some patches on the iommufd side to let userspace select
> > the MSI address instead, but they are not done yet.
> 
> Maybe we should just wait for that? Carrying a temporary hack with ABI
> implications to support broken hardware isn't particularly compelling
> to me.

This patch would still be needed for kernel users.

Arguably the kernel users should just be using the iova allocator from
dma-iommu.c. This whole hard coded constant/sneaky uapi is just a hack
to make vfio work..

So maybe if the single constant doesn't work we could set some
indication that the caller must allocate the MSI iova, the kernel can
use the dma-iommu allocator and VFIO can just refuse to use the device
for now.

Jason
