Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826E22E11AE
	for <virtualization@lists.linux.dev>; Fri, 13 Jun 2025 18:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749838428; cv=none; b=aX/sjzjBsuIwqhtfT3nkrAvR11P7z8Ye70/QQ2zJ6GO6HlA/Ad+MLT/3/R7Pe9oCps02fju65xrfxv9BqiMdcSrQdQRecoyE+2raY16V9wkdeljujNrN7hcQXVOVVvey0LJ8ho2kWvgWo4fgdTFf/s8VlKL8lW6zSFPDy2AoI/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749838428; c=relaxed/simple;
	bh=UmgzyBzQ/jgUw39z2VUJbMgNeLwbSTLTYJ0VBxIVoxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKfUU1ev9wuZ8d8P1X+eNORpiM16CfisTgTHsCoFqGjYS9hIFaSzLzXISZj7AhhJ3U/ddHkyyrrrHz3YshFA+SkgHi39QaqucwQ3aZTMMyMFho+XdQpCetT6YEjD6zKFJEiMHVeWT4N8RL2R4o8a7x+5X3n7vNmQpd/+ukOwgk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mWJmb/jC; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mWJmb/jC"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6077dea37easo4646764a12.3
        for <virtualization@lists.linux.dev>; Fri, 13 Jun 2025 11:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749838425; x=1750443225; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0INhtq8UslCI0h3j7LA2BL7iWR70QyFmUejwynW5DK0=;
        b=mWJmb/jCfbRc+Kv2imDhSKhBR6ZPfv8zKz53c+8zBvGepQQhydql69/KzMEnH4V3gc
         APJ1k0OiljuJAi2Jt7nMgnndZUZjrQUOsCCOvxi4axMUlcGMTC7pUVaNC+PDGa8JPCef
         Py1DvK2fIwRgrV/inWYuIY3Z8SnPVOjbVirUnCCtqglJptxorW9uS3yGNzQUXWrML43g
         f9RJI5hjn7zmjcNgDKcTOmXfyxeMRH6JlvmqLtSSSq1FcbJL0BqIrgelOKJ3T99wdVoM
         yjsNpptYDTHU66HPC0GI1CvFhCzedJtraW+4brZVYH5ZIsEIaVyIk72qrczK32wMQ/K8
         Ty5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749838425; x=1750443225;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0INhtq8UslCI0h3j7LA2BL7iWR70QyFmUejwynW5DK0=;
        b=sMpbGmfJROldNvGvaokOpDEhaZYX8zxtluuw9WEDjt/zH3AeQetIeM1Q2V9HQpJxFF
         iD4eje0DRimXWMMDcct4H3pmHIM51Imsqpdpa5Nks/ksOwLAhXtSVhy2TK5bbfJ93hV/
         m6mq27g0pkd7H/aMJnV2iuWZgSIxaukBVl4CUco+i6/XkBcANlI242yKVZ6tceoRaOJ8
         bMC9pAxDdsjbEZyirf6yNyVgwL0lSdfqV68wTZURNEne1sAhtNRPzQd5jHAqRyERZZvl
         2N5iQG5XF6ApJLzocjNn+dSJ9f7i40R6s+yz5jW37xPKJ2YCANYXFvO2dZw/n8OV87og
         LOaA==
X-Forwarded-Encrypted: i=1; AJvYcCV5a+0pKKl2Py7SxHHX5c3+C5EwZB1Z60dHjlqJZmaFyyh7eZGoLx+3/BU3FOqiJJz7btxBCYTuCedansWVMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyXHaVLbBlrd6Xuou95jkfumjJ6aOrclfl5XmjNDG4W7a8qZVSe
	t2JTZDWjR8RK7si+Wq+xDZoDP1BJN9GPnhC4FAKLvo0nL2Mil/IbeudvxAchDDX9nc4=
X-Gm-Gg: ASbGnct6CxVUYJeYJODpOLh6UkEVPPWHemOrkHKdYQNmJu3Je9uAoUqOSyBeqmCEXWC
	Vo9JSgR/2swsY6bGlJI6K4ubSbvi7K3P+S4Pibe3NZHkfJzUzhl/+h2rNFD9fbicmQDxap7EqT8
	9VqiaX22/uLDJPRpOie36SE+Jlz+t6Eose3X0OaXdntAuvJ+wxclwLVHNtuMrjeAv0k+LLbF4TG
	Cjvs6aFHPX/uIa1T3dGBwFk7OgvE8q0aZ5QZldimHXBrr5zFSh6Bc/jh9yyhE1Ru/kxI+9i6f3L
	xL8KiZWAH5V6D6y2UDAyCkmPUC8NnnQXc0qTg8a6fUe67KGmlq+PI5XwojDe41dLz13FFvivnjZ
	6QdrPt+rF03I=
X-Google-Smtp-Source: AGHT+IE7chg7Stgbh4Yr4tdDPknvVXXUYCN1Cbm/Af0sSgXY5X2QBDtOR02WyyHHfHlz7aluSu81iw==
X-Received: by 2002:a05:6402:2550:b0:5f3:857f:2b38 with SMTP id 4fb4d7f45d1cf-608d0948ae9mr218552a12.17.1749838424741;
        Fri, 13 Jun 2025 11:13:44 -0700 (PDT)
Received: from myrica (92.40.185.95.threembb.co.uk. [92.40.185.95])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608b4a94d18sm1502508a12.67.2025.06.13.11.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 11:13:44 -0700 (PDT)
Date: Fri, 13 Jun 2025 19:13:45 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, virtualization@lists.linux.dev,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	devel@spectrum-os.org, Alyssa Ross <hi@alyssa.is>
Subject: Re: Virtio interrupt remapping
Message-ID: <20250613181345.GA1350149@myrica>
References: <c40da5dc-44c0-454e-8b1d-d3f42c299592@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c40da5dc-44c0-454e-8b1d-d3f42c299592@gmail.com>

Hi,

On Fri, Jun 13, 2025 at 01:08:07PM -0400, Demi Marie Obenour wrote:
> I’m working on virtio-IOMMU interrupt remapping for Spectrum OS [1],
> and am running into a problem.  All of the current interrupt remapping
> drivers use __init code during initialization, and I’m not sure how to
> plumb the struct virtio_device * into the IOMMU initialization code.
> 
> What is the proper way to do this, where “proper” means that it doesn’t
> do something disgusting like “stuff the virtio device in a global
> variable”?

I'm not familiar at all with interrupt remapping, but I suspect a major
hurdle will be device probing order: the PCI subsystem probes the
virtio-pci transport device relatively late during boot, and the virtio
driver probes the virtio-iommu device afterwards, at which point we can
call viommu_probe() and inspect the device features and config.  This can
be quite late in userspace if virtio and virtio-iommu get loaded as
modules (which distros tend to do).

The way we know to hold off initializing dependent devices before the
IOMMU is ready is by reading the firmware tables. In devicetree the
"msi-parent" and "msi-map" properties point to the interrupt remapping
device, so by reading those Linux knows to wait for the probe of the
remapping device before setting up those endpoints. The ACPI VIOT
describes this topology as well, although at the moment it does not have
separate graphs for MMU and interrupts, like devicetree does (could
probably be added to the spec if needed, but I'm guessing the topologies
may be the same for a VM).  If the interrupt infrastructure supports
probe deferral, then that's probably the way to go.

Thanks,
Jean

