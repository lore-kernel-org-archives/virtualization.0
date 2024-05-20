Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EE713398E
	for <virtualization@lists.linux.dev>; Mon, 20 May 2024 13:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716211388; cv=none; b=ZXgHEYtevRt7j20h6+67eTU5wEhiK4H7htglpVMUbsTEbgDELFgBVZ0nbB1TDCNUCeXo+ketz4glPUofW0vqbNFn/O+EL98zMju4ze0vBnxTzserJzfc0qwM39XzHe2guswKoboLjNzJGPEDor3b7DbMpYfiKqd8jp3eZJNAALo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716211388; c=relaxed/simple;
	bh=VtzriDnmPJgFVcPERMtIx+lichjMLk1jaHjkRVNmgr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HGyqRvTijdbh12ToPnL00LI7Qy4D2ejkt0zLKLeB2jqlHJdOSbv/B6qRrKNTFdkyZojO5B4GJZjA3fZBnchg8fxAo/OUxC2u99YOx3K5USph+R8IfhQo0c9c3GvSerZjU3yLCVKRI6Xt4Pd3td04zcEVZ8WIVnwAonasg6ZTNns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H3MeCew+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H3MeCew+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716211386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M8c4UCZlVP1N9HFMkZD0c7EJUI94ZrVHCqdtZ52aP+0=;
	b=H3MeCew+AMRQLmI22MqMECGY/Zx+2UfoMTBwvO7bTU1FcgAZyA3QaD7MRc4mKL5eCDQyaK
	ShvGOB0e4rSkUivDIOGzm0aos5/6rkSf0FdlXasF7SnX5ofz0UVAV53Za7uf+YCEuHB/E4
	8CZNIpJPub+9A1ncMp9TNBGmbuO/3QI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-DIcWHDbqOQKKqEvmruNtdw-1; Mon, 20 May 2024 09:23:03 -0400
X-MC-Unique: DIcWHDbqOQKKqEvmruNtdw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-34d7e948a41so5955920f8f.1
        for <virtualization@lists.linux.dev>; Mon, 20 May 2024 06:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716211380; x=1716816180;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M8c4UCZlVP1N9HFMkZD0c7EJUI94ZrVHCqdtZ52aP+0=;
        b=rk075lVrwZTkMtD0tlOLCO+fhsjH71ajgVrKxQG1KpL4QIiORv+hM79EydGV6noeqm
         UbxQ4tsHy2wR2uBhObuHkPfAccIzTlPq6DNvZ4/KoC8DEXcksBVsKz6oJf5iaNUVRFR5
         fIbusd1ZuHNiDCjmu0fNW0I/OHTPdza2XsxTiltPg7JuNtU0XnJ9ZA6g7E2kyDRuabLU
         m+TrvvafjZN9TOzEJjwNpOw4bcC5wxdRo4dcexZa/0M4rc12cQOuatln4gxCe3wFJ3An
         CivTrq7RryqFwKmte32869nqXBmRuS9CdtkY3kiao9LyKNa2W82n0mgMd0rnbvY/gSSU
         W9hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnXs2sqO9r+A/oqI8s0S7Gj0vPOlS/wEV3UIU6B0B5twZPS/sCjykc9w64Fv6I6dOe4Cd1kMYZEGnon+pxiCnOwS254EQHbFBnsPrVZxg=
X-Gm-Message-State: AOJu0YxCGIwTRvCAsIfbvOf2wn8WVQ+3SmjrZHsWp5m9FJM7sstz+YpT
	e4q0S8dgWc2kNmYxMxwSWnQ2JvN5BX8TDYMlmTxHLB6z43JnmsKTTxGg6usB/iAWykTef0wYaev
	2P05958KwJzEc9XAB1nkpXPmlY+BVOF7nE0oz9utNpMt5Kp9JjENflsRiCEjD09k3
X-Received: by 2002:adf:e586:0:b0:34c:b2df:6f01 with SMTP id ffacd0b85a97d-3504a737f13mr20902221f8f.21.1716211379552;
        Mon, 20 May 2024 06:22:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvYYkoaNDOEOiv6UGBH49UdkV0uZVjDLOJ6mISaM0QTUkwRoAiGrdAfBIOdnKoXAedrbzI6Q==
X-Received: by 2002:adf:e586:0:b0:34c:b2df:6f01 with SMTP id ffacd0b85a97d-3504a737f13mr20902203f8f.21.1716211378979;
        Mon, 20 May 2024 06:22:58 -0700 (PDT)
Received: from redhat.com ([2a02:14f:177:b718:2429:1dc5:dc6b:7d42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a7748sm29370373f8f.49.2024.05.20.06.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 06:22:58 -0700 (PDT)
Date: Mon, 20 May 2024 09:22:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Shunsuke Mie <mie@igel.co.jp>, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Subject: Re: [RFC] Legacy Virtio Driver with Device Has Limited Memory Access
Message-ID: <20240520090809-mutt-send-email-mst@kernel.org>
References: <CANXvt5r00Y5VGKSFXFnwbvGF+fhh2uNvU5VBGwECA9yabK4=Uw@mail.gmail.com>
 <20240516125913.GC11261@thinkpad>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240516125913.GC11261@thinkpad>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, May 16, 2024 at 02:59:13PM +0200, Manivannan Sadhasivam wrote:
> On Thu, May 16, 2024 at 01:38:40PM +0900, Shunsuke Mie wrote:
> > Hi virtio folks,
> > 
> 
> You forgot to CC the actual Virtio folks. I've CCed them now.
> 
> > I'm writing to discuss finding a workaround with Virtio drivers and legacy
> > devices with limited memory access.
> > 
> > # Background
> > The Virtio specification defines a feature (VIRTIO_F_ACCESS_PLATFORM) to
> > indicate devices requiring restricted memory access or IOMMU translation. This
> > feature bit resides at position 33 in the 64-bit Features register on modern
> > interfaces. When the linux virtio driver finds the flag, the driver uses DMA
> > API that handles to use of appropriate memory.
> > 
> > # Problem
> > However, legacy devices only have a 32-bit register for the features bits.
> > Consequently, these devices cannot represent the ACCESS_PLATFORM bit. As a
> > result, legacy devices with restricted memory access cannot function
> > properly[1]. This is a legacy spec issue, but I'd like to find a workaround.
> > 
> > # Proposed Solutions
> > I know these are not ideal, but I propose the following solution.
> > Driver-side:
> >     - Implement special handling similar to xen_domain.
> > In xen_domain, linux virtio driver enables to use the DMA API.
> >     - Introduce a CONFIG option to adjust the DMA API behavior.
> > Device-side:
> > Due to indistinguishability from the guest's perspective, a device-side
> > solution might be difficult.
> > 
> > I'm open to any comments or suggestions you may have on this issue or
> > alternative approaches.
> > 
> > [1] virtio-net PCI endpoint function using PCIe Endpoint Framework,
> > https://lore.kernel.org/lkml/54ee46c3-c845-3df3-8ba0-0ee79a2acab1@igel.co.jp/t/
> > The Linux PCIe endpoint framework is used to implement the virtio-net device on
> > a legacy interface. This is necessary because of the framework and hardware
> > limitation.
> > 
> 
> We can fix the endpoint framework limitation, but the problem lies with some
> platforms where we cannot write to vendor capability registers and still have
> IOMMU.
> 
> - Mani

What are vendor capability registers and what do they have to do
with the IOMMU?


> -- 
> மணிவண்ணன் சதாசிவம்

