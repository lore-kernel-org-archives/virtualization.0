Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304E32F2910
	for <virtualization@lists.linux.dev>; Thu, 18 Sep 2025 22:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758235407; cv=none; b=g8jo0cvjOYbogC0GI2Seom+VOrI56kvobdiESuTk6DZvrWYkIimsirfYu8Z/o7JEviRtqvopvWqyxxv5EUzyQG1fBKqUjhBnBCD5QpaPi+NCUc90mQKii/s8DaLS8Lh9AjvMj0eSsqG6zvu4iT5Cb112Lc2jxcPZavn052wy/+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758235407; c=relaxed/simple;
	bh=fDYnNm7eu3SJ4B5X1G13qDmffBtSJHL09HIs45g3yFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JatnbBZLlzo0BJ0VG88obuRDK2tA+6CMkM9TcMqjlb74idfiF3V8RLDwJKIBkXtKrZaGkwxwDVR9TFLXyJDNQL9HJoPNzOA7romYobek0hzHXtOS5VYaP+5Pmv9YrkIHA2S7Gr0HqBO3I83fdObqn6xW/uQUq5FqAq0ZDsWqRZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UstTkKmh; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UstTkKmh"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-75731ec93bcso523173a34.1
        for <virtualization@lists.linux.dev>; Thu, 18 Sep 2025 15:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758235404; x=1758840204; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qnUwZStouFz5qxjD1Lj/dsD47M7aWuqj5p6Ia/ydEQA=;
        b=UstTkKmhxfcY/O4oA01xBeD3sNKR/S+LLWfI70OdWvVlAmA3+6xT5Plzm/eQ2lnyyN
         cDV0j1zCbyS6pRr2RCJzXCVbmlujx8JDkWF8ma6EZ/SuCRzpjIcp+TEj6RqmdrNr6LS1
         l4yJbp0x8dOikyB+mbOCD6ofhKHcRccXf2EVpq5/32GMfzhqHH2yZFKbWBuWMdTOMPgW
         K9SAXgL0y9OweAxagRvrF2pZLXkkmEqu6VKBLHFY4S8Y1uA9njtnOPk6W8p5HPHBGOsg
         zdTITMGk/A8PBiVoG0mhV/CWlGixJZmRQ1HhXX1yOl7ORJkb/vj3y2trzuA02y2tpll4
         Lefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758235404; x=1758840204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnUwZStouFz5qxjD1Lj/dsD47M7aWuqj5p6Ia/ydEQA=;
        b=ACGxqZUrjCoB6/q4VDm6Ox0gl36UrZwshj6eHZzgX6Vm3npgNf9TJf1CafOfgV7FaV
         2OWQZ348NBQGN3cbhWiiFIDttoQ4QPCxnOeDX2X8DYXXipFF0StcXvOGCy8U68gNuJZD
         GuJ/d0cX2fr3uDoE5aqqhsL59tLNJQMtE5ouGIqh40f48CIte35N78T2Fm9QJNhQQ/T+
         ++C+OgRNxCrJeQx+DRgOLsABXFtv2W3R4de3zCor1bMbk6SC4vbxSD5eFsNUB3eWmZg+
         e2qCkzI7a3k4m62dqOt1OORJG/cawa0dggk5Tc+SrzKbBdelEiwEqVj/cU0yOv5aymeT
         mI/g==
X-Forwarded-Encrypted: i=1; AJvYcCVQ0mGNrp3QX+ZXPn2tigwcg1FHQHlEtdcbVW5KAkWoPpxmgfkivwcOhTku8LvsRPQscEVqgemIpIqOYCMvpg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxthX+DEaU55zzALVum7W/7/ggNLyNMLaJPhNI2d6cbTTL6f8O3
	dviNnHE39UYd81xJyoX2iMuDk/RcI8+cV3Ry87kZEzcVwZpvNw9xtpLMOkSQE8hIGSM=
X-Gm-Gg: ASbGncsGFLNHAb3iafAHViJw25od+EmS0FqP+GNZXLMhuK263AnNCnJ0g1sJCsRzTXH
	UZs6MQZi370krM4ssgd4480fjVxfo9ona/oPmTbc8TWCeQA3nhAs/Eb7rzUNHJevQGUaCxGI1he
	+hfwF65LfLptwEFQpHu6XfvblTRytFKQE3LoTgO5PFUEo3+9tN1//P/R2clugBScNpRb47PjzFA
	nAWdu5A3iSd46D0RMvZoyJxy14jOTfmbWieokqtFwmM0D3lG4eTTMJJ1aES6972en8YNVq7HK/H
	RBBCv8GbH9h3Vp3dtoXkegG3EsYWR0mUet+Ssb7vf7i7HvDQt+hb34CBy/sPMfht4idte7v6ati
	gJTRNx3yDl4FzMdk=
X-Google-Smtp-Source: AGHT+IHKROKv4GiW5aFGatEtEb+qiEoA/WdhBpHSCZhcOfsuIyYvldoezk0nWsp/B7NH1cp0nPxRTw==
X-Received: by 2002:a05:6808:5289:b0:43d:21ba:b09f with SMTP id 5614622812f47-43d6c24559amr470351b6e.24.1758235404194;
        Thu, 18 Sep 2025 15:43:24 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43d5c85d269sm1274466b6e.23.2025.09.18.15.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 15:43:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uzNLW-000000091yf-0M6j;
	Thu, 18 Sep 2025 19:43:22 -0300
Date: Thu, 18 Sep 2025 19:43:22 -0300
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
Message-ID: <20250918224322.GR1326709@ziepe.ca>
References: <20250909154600.910110-1-shyamsaini@linux.microsoft.com>
 <20250909154600.910110-4-shyamsaini@linux.microsoft.com>
 <aMw4I0AjKNPY6SOw@willie-the-truck>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMw4I0AjKNPY6SOw@willie-the-truck>

On Thu, Sep 18, 2025 at 05:49:39PM +0100, Will Deacon wrote:
> Given that we're walking over the reserved regions to see if we have a
> collision with MSI_IOVA_BASE, why not allocate the base address
> dynamically if we detect a collision rather than having yet another
> hard-coded address which we can't guarantee won't be problematic in future?

I'm nervous about this. Right now the  MSI_IOVA is actually UAPI and
things like VFIO/qmeu need to accomodate it's placement in their own
memory maps.

Nicolin has some patches on the iommufd side to let userspace select
the MSI address instead, but they are not done yet.

So, randomly picking an address sounds like a bad idea to me, it would
almost certainly unpredictably break qemu..

Hopefully by the time we need a 3rd one we have the userspace MSI
control and then we could make reasonably make the kernel
automatically select.

Jason
