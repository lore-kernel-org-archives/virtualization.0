Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F3021348
	for <virtualization@lists.linux.dev>; Fri, 15 Aug 2025 00:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755218404; cv=none; b=LtLl7xZSoXJZv830YUPf9jrqfFZVa8ubse0/Dhy/eJVRV+H+Sk1hhz4MDWv0BymXQ1dQInUeQpYewXbchXAWWRac3k1cDXRVMOUBsyELxp7AZgY4WfTG2GkkYY4vsaqn3lzpKLGCW32+FUdHIxc7IaWdDurgp0ObHMTJL8rJ99Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755218404; c=relaxed/simple;
	bh=6/sdWQJeWOfXNeyHNijjYMueBETIfV4LG3tVO9cWGsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6gmDRQx0hQtBW67CTmcY3WveGSc83U7hNggLRMSup9URtylCz9r4qhNYwxQG4dtbRQu2jc+sSthVpIvcc7xTKPiOPcUeNKDOct95LlZDdOOvhDXZkA/UfQfJtt0gkoyMZ5v6ddOQkfDRa6mcEHcf4KfjVxmJX4Tkcv0I6dfqbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=K0JOMUOO; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="K0JOMUOO"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-435de70ed23so898284b6e.1
        for <virtualization@lists.linux.dev>; Thu, 14 Aug 2025 17:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1755218401; x=1755823201; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hr3wKIH0ILNJrROQ8e7R3YmlW6yepWJRJ+67Lc0p55k=;
        b=K0JOMUOOJjM7qLidKnTS9Gouotn8hakrXCbX76qQGznjLhDZsqUQb10gcNx8+WUb1g
         wz2kr4CivbC0mSQWbjoFXTk6g4jWjgaHvO8T5M3fGoDxHixkQenoNw53UG6XM5M1HlFo
         SZNpjxrkSYSv0QspGk9JuAtGRx63nbQF+vmSxT2BOw05aR2HdV1BqD4WtNFfFfA4j5bB
         kfCURil9bdxny4A9rcww/4zi1ydUs5bGvtC1CiKBNg4L311RXnUGDKuThqjyUAy+9f/S
         I1KV6OnYT1hOQ/0txxPAke25j6r+76XBV+OWsu6FWzqDdq/DNbAUPMN6e41/P1x1NVAu
         LyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755218401; x=1755823201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hr3wKIH0ILNJrROQ8e7R3YmlW6yepWJRJ+67Lc0p55k=;
        b=NGgDWTCtYlb+aDr1OwePp5KASkIafSLhDv0Rc7UTmIWAWcWETgV8pIJ3fl+FkjCy8T
         E5axrpzwnygFPhelyTus8Gz7fz50Y2o5DipmxP0TSIbcpxBl6ZFdKMtbavcyZOOwOpWu
         0mKd1TwyMXIBaxbve4/mCyLj7w1/WJA0GMNP0vEvYvMK0CtJvjKb9pjsGm4uJhyJjreb
         ntokedOEtrMN+EdVnthqa4voebbXDPkey3CFkWqDXVn1MqV9AqMue4XofSn0EFtxPIQd
         MZ51N0xpHAkEhD06I5JyMv1gIO65Aa01MNhJ2Gv/rAGB2SRI6YO3DUmpuC/i++5JiFly
         FWRQ==
X-Forwarded-Encrypted: i=1; AJvYcCV514WPBEr22u3BOmngydLumx+ORGW3ZRjIDpyG+oewgsOLgnjr8N6NMpeyCBeAT+K1d2vMJZMMYlhE3CDAcg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxh0cI4O7EYsbAYb1zd/IMyKYptFs0tmMs73QKLnONXUQz2BkiC
	rSN/uMnXJt1yFc93qlcOX3Fj+5eUEuQ1t+MSWfNViuY/KWjbzqfjsLIxDrTDAz5Jl6M=
X-Gm-Gg: ASbGncuriNGjI4mNdcA4I8NxtL0Bhi8caq5h6KEXx6z4fxkhmuv8EpvMqR4WKCdpK42
	C1CpDRkHMBZsLQrZnHOZoCT4Po0V5Vr/zuqoewK1oFiicP3WWmkPFLYEKBLIO/TU4rWvqtjE3NV
	SEIhXmT44RKW8i4GYhbiPEPWW1WxVg3+CHbCI8lBHaRS25NGFRNTl+oG9huwuHF3IC9c32TDQ2Q
	zo3VQg7O2UQoSyOUEVrHxntDJGWxcVjBXgjvUwiJv5f90YcTXdpwza8S8eHTdiLE5weekYzrRTh
	W80qdksxLjvWw8bweDPHVQbR3tKP74xPCFA37oS2s7U98yqzeXJCm8muihwMP5+Lnx8kCxXx
X-Google-Smtp-Source: AGHT+IHz/V+zZ7uzfzwx637Ui4sGjmYjl6eL7eDG1gc5kCGFqOg5QIIhe2oPTd/JaDh2sRuwhvdoeg==
X-Received: by 2002:a05:6808:1a14:b0:434:54a:40bc with SMTP id 5614622812f47-435ec3bc7eamr73006b6e.1.1755218401405;
        Thu, 14 Aug 2025 17:40:01 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-310ab87a099sm3458fac.1.2025.08.14.17.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 17:40:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1umiUA-00000003TLB-28WR;
	Thu, 14 Aug 2025 21:39:58 -0300
Date: Thu, 14 Aug 2025 21:39:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, virtualization@lists.linux.dev,
	will@kernel.org, jacob.pan@linux.microsoft.com,
	eric.auger@redhat.com, code@tyhicks.com,
	eahariha@linux.microsoft.com, vijayb@linux.microsoft.com,
	bboscaccy@linux.microsoft.com, robh@kernel.org,
	saravanak@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	lizhi.hou@amd.com, clement.leger@bootlin.com
Subject: Re: [PATCH v3 2/3] iommu/of: fix device tree configuration for PCI
 devices
Message-ID: <20250815003958.GE599331@ziepe.ca>
References: <20250806215539.1240561-1-shyamsaini@linux.microsoft.com>
 <20250806215539.1240561-3-shyamsaini@linux.microsoft.com>
 <20250808121515.GE377696@ziepe.ca>
 <20250814233018.GA31418@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814233018.GA31418@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Thu, Aug 14, 2025 at 04:30:18PM -0700, Shyam Saini wrote:
> or were you referring to [2]?
> 
> In that case, the PCI child node data needs to be parsed, which is
> currently handled individually by each host controller driver.

Yes, this looks like it may be what I was thinking of, the pci@1,0
specifes the BDF effectively
 
> This might not be a strong argument, but since firmware updates tend
> to happen less frequently than OS updates, any addition or modification
> to the FDT would require a firmware update. Wouldn't it be more
> maintainable to keep this logic in Linux, which is easier to update
> and typically updated more often?

The DT is supposed to describe the HW, if the PCI device has an issue
with its dma ranges then it seems reasonable to me the FW will use the
existing standards based way to describe that issue?

Presumably this is a fixed issue of the platform. You never did
explain how your system has such werdio behavior, or how something
like iommu=pt can function on it...

Jason
