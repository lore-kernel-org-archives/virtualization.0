Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D38781AD7
	for <virtualization@lists.linux.dev>; Mon, 26 Aug 2024 06:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653015; cv=none; b=IWSkVkkS/uf5PLHXrKR3VaxSUuF/vLBbBWY3Fcu/8dVFoZtCtH1oO63ElrHMSjP1RFUc/hcsjc8Y+sYddSwg1Ni1OFZ3gaOyGI7MCNQK72wV6wIcN2yitK3ZGcaa/KFdgGl8w/6uk42uxdrRNdPMfcaC47jKYiN+3Ka0wYXbzJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653015; c=relaxed/simple;
	bh=OxH7DwkvlaSlLEvipNmqgwxmyasajvhgDEfCExvjRjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mIpXDP0Hhkr+aZZq+BlKp6ISPnLKUbHOVEYUBAtrFDI1KCbu0BWzKuRDRkX6li/fw3jwAkMxx5GGfG2yC41yuz9iL2HrlfbtsS/niuekoVTluz/0kG4YM6y9uU+DyxHQ2fSUgRV8yFmFe2HJAaeAQ6pAHohUz7bFty57a/n2xJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h5erD15G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h5erD15G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724653013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dB1NfwLF4sboQ9oAiJsmEAd6cRRc4sOW3f5DA5Z/91g=;
	b=h5erD15GfJ4+04rSjlqJg8SocqzQ6ttg/ib1zQOa5uRqSZ6v6BWBcK5JYBH/QPMjfJVzEJ
	uA01hyjlUExPnAw0H6A8GVPmX8FPlJ5VE+DQP7szgyxyT4ty0fLhCgiNWo6EPbxKB8mMPd
	gtqudkCm1QiIY/5kYKN7B/J8c6HE7vc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-REpn4_7bNkmVtpWs5xOxWA-1; Mon, 26 Aug 2024 02:16:49 -0400
X-MC-Unique: REpn4_7bNkmVtpWs5xOxWA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2d3d68d032fso4660904a91.3
        for <virtualization@lists.linux.dev>; Sun, 25 Aug 2024 23:16:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724653009; x=1725257809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dB1NfwLF4sboQ9oAiJsmEAd6cRRc4sOW3f5DA5Z/91g=;
        b=e0J3p8jMlnJkOEBH1ziBuvVBonBZAszlcg2KdHifSv/f6Dj6e6oJjcZeg6xuska8os
         WifJjXjguRX7KNJBwsxN6Ru3wqTpVGh/pLA40JyO2aTKqALHETOFWVHRpJhEzGjeLLau
         gEBgpLjvnd09o7rXNleGQR2vEi0qfpT8d4j+fwx8rHvrtXfANX4L3HK4Z6CE3CsP4c0l
         5EBjlnGp/Mmi28pqgNynk8Y4NDJief/aBnKfm8MW5P46/9boqd7dP/iRHTpatxvQzDYu
         HFh0bURs0pNVFX2wj/Q3EHmOAtWz29isICngm97ZPBQOjpvwtEu6F1RGBaHMJAluRKLS
         HCEQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8vpBOU4fQKvYbvK51D0lo7Fi93uZECLX20WkmMhqCS4koQZyAhggOZP/Av9JbEyVrPcMhR39N8tCR6+7W3w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTNLtuSnJBaX9UThjlxJlzXcnpzvfuw9BjDOJn9LlvYwgZQGjx
	Uu7wC+7HaspozZmg/3chj8h70E3IrKNmE0TG/yo0Bsh5sPrswVPK+iF0UMva/FfkFNVpk9Swin+
	2zpIxDMy5z1T9mNrqfl0n3cg+XOzABP29iZjqmIAzSzC9MSCUkVwwvNVVSx3vLecSCio8+YY7Lq
	G73Uum/JseaJjHEt4Mh9YO8qpiqcU8sxPLCpq2z5I=
X-Received: by 2002:a17:90a:6287:b0:2d3:cd27:c480 with SMTP id 98e67ed59e1d1-2d646d247f9mr9809266a91.33.1724653008869;
        Sun, 25 Aug 2024 23:16:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0WjIzDYmdUX7OY9EeJBLH76SMB2mi2zdVZl4NauXJ/eBoNO23zRck1BCKv7ZS6PzenwJTH61bASpm1vxRFd8=
X-Received: by 2002:a17:90a:6287:b0:2d3:cd27:c480 with SMTP id
 98e67ed59e1d1-2d646d247f9mr9809253a91.33.1724653008351; Sun, 25 Aug 2024
 23:16:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240824035817.1163502-1-hch@lst.de>
In-Reply-To: <20240824035817.1163502-1-hch@lst.de>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 Aug 2024 14:16:36 +0800
Message-ID: <CACGkMEsK8k=yX2ZytMJQhdZi4PS9-7KLUYmf2oGLu-UvNEYzug@mail.gmail.com>
Subject: Re: clearly mark DMA_OPS support as an architecture feasture
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Bingbu Cao <bingbu.cao@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-media@vger.kernel.org, 
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 24, 2024 at 11:58=E2=80=AFAM Christoph Hellwig <hch@lst.de> wro=
te:
>
> Hi all,
>
> we've had a long standing problems where drivers try to hook into the
> DMA_OPS mechanisms to override them for something that is not DMA, or
> to introduce additional dispatching.
>
> Now that we are not using DMA_OPS support for dma-iommu and can build
> kernels without DMA_OPS support on many common setups this becomes even
> more problematic.
>
> This series renames the option to ARCH_DMA_OPS and adds very explicit
> comment to not use it in drivers.  The ipu6 and vdpa_sim/user drivers
> that abuse the mechanism are made to depend on the option instead of
> selecting it with a big comment, but I expect this to be fixed rather
> sooner than later (I know the ipu6 maintainers are on it based on a
> previous discussion).
>

I will try to fix the simulator considering virtio has already had
mapping ops now.

Thanks

