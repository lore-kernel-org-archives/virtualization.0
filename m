Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFAB225A8
	for <virtualization@lists.linux.dev>; Tue, 10 Sep 2024 20:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725999520; cv=none; b=O6jjWy+q0prlJ6OLjq/9Gd/m6y0mZdCk3m/ssrioVVR15xmMDhlejJTsV6LqwXQ9/Py6zucOlCOHs5qKcB6nFJ4FAx7DMcRZWJPx267W8mjFR1+E+asLwZt6dOKDvbhg7t4/mP4x0TuqmUrITbYVfwf5d7MmYwdOssTXO3O2VdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725999520; c=relaxed/simple;
	bh=TAoZNcbkrffTNjvrTn00faJPH/qZ5L4usm0drwp9xAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sigxvJ/16S+W52mFUcpULEpRXuzaKnAOYPy189BPSqTTdtkf1WN0hcJTO+NsWJvsfEOttuMQKQzzEb389K7jO4ZKLB/DENdkHxKp9elkMoEWJqTDsoOKuDEQBmkwSBvlZIyWzqQVTpj60ZRiLlDYDc35Pm7ckGuTuIyWllkoyd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kv7H5s2Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kv7H5s2Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725999516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R98WPsv5DcjO+2fj601F0xB34R9dMYvuHz2AKaHWeKU=;
	b=Kv7H5s2QJ2TrkYsUJCQzsjjjtM/sIWPSSXQqM1LCQsvSuYURjRJU35V+MJGtRxKnA9N+RL
	qaJnAjia454MRclbifDpeXsLrgXap6Ouj6VXUQh4nF4rZm5ZvgDP6QmENh05mr6LNKXJf5
	BPZyX2EiFLYExXXTsMw2lLmaA96/uMs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-rn1YNrD3M12DrIeU3SUOfw-1; Tue, 10 Sep 2024 16:18:35 -0400
X-MC-Unique: rn1YNrD3M12DrIeU3SUOfw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a8d0d87f204so19012366b.1
        for <virtualization@lists.linux.dev>; Tue, 10 Sep 2024 13:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725999514; x=1726604314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R98WPsv5DcjO+2fj601F0xB34R9dMYvuHz2AKaHWeKU=;
        b=YtwgB+lMRW3Ibtx7RHpsbiqTMeZHPE2nzlMO43rweCNkZvqPSfp459sBMkM+1v+q6G
         PgepIr5N8bYFlKZqyee1I4nqupcZWYEUU8tJjgOU/pzBNgRjfX9BZS4hCuCrLiluNfeb
         Gq62ZjjheCXgYXc0d6qtees75+8kcQJ0GHIHJryJjFHo3lbayVM/A3OA+ugnwDgYkfMp
         WNfvuFM/3FUTrTYPfJs0HrZ7Ck4qz+3A1PP+Cby6fDVxB8sjHlW5Bm4M6JyZJANxO+YH
         HQHq/qAexz1WpUcDhZVSwBpzu+FAub1ycvziWccA3xf60s+Cw15DjAlrIF2G+cskKGgH
         Fxgw==
X-Forwarded-Encrypted: i=1; AJvYcCVty8NEHiXTiX2LkzGqaq4Vu+KU44/1+AQ+7MM2WFKUmt6f9WKpCMwGJ5m3piK7PFrSzqRQk0pdQw1GRsIXAA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw8q29DmjlveEdV126ZGztxVplTDZb3geIirTYx90xkenv7CxmU
	kKeI45o4FM7jRe7jhBnLKhAs0cyqtMFPwZmChDAaqxpAO3fADiWif1MZ9V+TrebqmBLtPJZZvgn
	Wlxs6klvjKCBLu24Xf/LU9+YEnFZ0Os3xfXvAELpHamUIJ6uSFUVW70JAFzh1/f1W
X-Received: by 2002:a17:907:d1a:b0:a8a:6bd8:b671 with SMTP id a640c23a62f3a-a8ffaac08abmr220659666b.5.1725999514329;
        Tue, 10 Sep 2024 13:18:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq5fbQ6BGaMv0cPkfGuaqAVwF+zGrA7/gctX0lOfIlCyL/ruUfB8xmIoU+UhSiCOfTzEqhiA==
X-Received: by 2002:a17:907:d1a:b0:a8a:6bd8:b671 with SMTP id a640c23a62f3a-a8ffaac08abmr220656666b.5.1725999513633;
        Tue, 10 Sep 2024 13:18:33 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:f5ce:2d9:5bfa:9916:aa0a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d5da53sm518761066b.209.2024.09.10.13.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 13:18:32 -0700 (PDT)
Date: Tue, 10 Sep 2024 16:18:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 3/5] virtio-mem: s390x support
Message-ID: <20240910161812-mutt-send-email-mst@kernel.org>
References: <20240910191541.2179655-1-david@redhat.com>
 <20240910191541.2179655-4-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240910191541.2179655-4-david@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 10, 2024 at 09:15:37PM +0200, David Hildenbrand wrote:
> Now that s390x code is prepared for memory devices that reside above the
> maximum storage increment exposed through SCLP, everything is in place
> to unlock virtio-mem support.
> 
> As virtio-mem in Linux currently supports logically onlining/offlining
> memory in pageblock granularity, we have an effective hot(un)plug
> granularity of 1 MiB on s390x.
> 
> As virito-mem adds/removes individual Linux memory blocks (256MB), we
> will currently never use gigantic pages in the identity mapping.
> 
> It is worth noting that neither storage keys nor storage attributes (e.g.,
> data / nodat) are touched when onlining memory blocks, which is good
> because we are not supposed to touch these parts for unplugged device
> blocks that are logically offline in Linux.
> 
> We will currently never initialize storage keys for virtio-mem
> memory -- IOW, storage_key_init_range() is never called. It could be added
> in the future when plugging device blocks. But as that function
> essentially does nothing without modifying the code (changing
> PAGE_DEFAULT_ACC), that's just fine for now.
> 
> kexec should work as intended and just like on other architectures that
> support virtio-mem: we will never place kexec binaries on virtio-mem
> memory, and never indicate virtio-mem memory to the 2nd kernel. The
> device driver in the 2nd kernel can simply reset the device --
> turning all memory unplugged, to then start plugging memory and adding
> them to Linux, without causing trouble because the memory is already
> used elsewhere.
> 
> The special s390x kdump mode, whereby the 2nd kernel creates the ELF
> core header, won't currently dump virtio-mem memory. The virtio-mem
> driver has a special kdump mode, from where we can detect memory ranges
> to dump. Based on this, support for dumping virtio-mem memory can be
> added in the future fairly easily.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>


> ---
>  drivers/virtio/Kconfig | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 42a48ac763ee..fb320eea70fe 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -122,7 +122,7 @@ config VIRTIO_BALLOON
>  
>  config VIRTIO_MEM
>  	tristate "Virtio mem driver"
> -	depends on X86_64 || ARM64 || RISCV
> +	depends on X86_64 || ARM64 || RISCV || S390
>  	depends on VIRTIO
>  	depends on MEMORY_HOTPLUG
>  	depends on MEMORY_HOTREMOVE
> @@ -132,11 +132,11 @@ config VIRTIO_MEM
>  	 This driver provides access to virtio-mem paravirtualized memory
>  	 devices, allowing to hotplug and hotunplug memory.
>  
> -	 This driver currently only supports x86-64 and arm64. Although it
> -	 should compile on other architectures that implement memory
> -	 hot(un)plug, architecture-specific and/or common
> -	 code changes may be required for virtio-mem, kdump and kexec to work as
> -	 expected.
> +	 This driver currently supports x86-64, arm64, riscv and s390x.
> +	 Although it should compile on other architectures that implement
> +	 memory hot(un)plug, architecture-specific and/or common
> +	 code changes may be required for virtio-mem, kdump and kexec to
> +	 work as expected.
>  
>  	 If unsure, say M.
>  
> -- 
> 2.46.0

