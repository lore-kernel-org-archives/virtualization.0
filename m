Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D9D2459F7
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 05:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763529452; cv=none; b=tY8yk3Ir515BFj5En89oEx3+5krp4eVQLnvV9QSx1Yt6VNLBRWyhT4eGYx8fcls0QfdAiK2+y4kE9uorTQic07B7Dnax/EcrsqiO83qFIDgxXwL/5N+hIiQJEg3wjJLIJ//iCafAA1/xRwHLINUWIHy9DlOwiBGybLF+m7RaGA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763529452; c=relaxed/simple;
	bh=r/xLivIcby+I0JIBqSS5l9qwoUuGekn1n/qipDIzCdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Rooqb/e17dVrN2wCF/cmOUcKkBEMGrYQCgfVpaESZMo/kP8Ldj8eXbIuHZ5bG16X0ZD+pbkUNiY+thkVSN4+KFGD5rWYPiosJYFAiejRZoHaFDeb80L3YU/smFltbBa9lhsJaVtHvDhJ3+17+IYrrxJ2EQtBTXtFwdJXFdL++iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eGBZKaSu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eGBZKaSu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763529449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kygOZeQZScx/+YWQsjjbid1ISJrkxLoR4hmjl6DONVs=;
	b=eGBZKaSuM83mTlzFscUZDc+lLmmijqCs95xxmYK9AelXvA5Vil6YcVBDx0yF90dLHISYBh
	hl8z9uh6BF3aBpFpTVDz1pBN2oe7AGl3d+/dVxhW1KSDE7sk8vEkjSVx3uhDRUTt3snm8R
	MhD+P4BvFoAns+I2ZkjJ82f9aGiL6CA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-p68_KgHDOAulls4PdVQMNQ-1; Wed, 19 Nov 2025 00:17:27 -0500
X-MC-Unique: p68_KgHDOAulls4PdVQMNQ-1
X-Mimecast-MFC-AGG-ID: p68_KgHDOAulls4PdVQMNQ_1763529446
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4775d110fabso48182545e9.1
        for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 21:17:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763529446; x=1764134246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kygOZeQZScx/+YWQsjjbid1ISJrkxLoR4hmjl6DONVs=;
        b=YD1QSYcD74xlnTG28PqmDYV0vgCKhFQHG3mj3wWUl9Cc+Cal+hFrwxF1Qx8ko3vu55
         qHWuYQQ53OVMG4f/MTUYjvFHRjH7sjGyP+G5T3RY/1NCbW4SoqYwSjWzN4prakqnysgn
         9MK9HQjByMaOdH7KjWDEoRE08YjAI9bLsE5CRC3iuckbPd5+09q+qDVDVHKQdQWbZt8b
         755Jf8+O+M+rErR6Z+nXruyzf1BFhjUiNdkDDRFB+0To7PAExq0mgjZfGcIftifhV9Gd
         aPDyVxRmm4Qrya2aUjI904f7CSxp0VTUooCUmzAEg+9TuMG8XvO/ozZy01RQsM/H2x4D
         Y3rA==
X-Forwarded-Encrypted: i=1; AJvYcCUqVGus4U/QJN5X50yMkHY8Y0MmIMpwhv0Og44RcM1LrbZQcNi0iTJGShuxt5nJo1jMhBMj7h78Rzm4mdo45w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx57SlTkx98KTCLP+EAcIu7IvLvDj+eVn/y+eVOk3evfmEjI7HH
	C0Z5hkEjgk5WxvC9Fdj8aWJPqu9fU3BwavjkNFDpiFr0dd+6zRIOdPNo/tHj7J16qNY4+qxDi5l
	udjB3h6aBz/C0H3ktXLuS1TrBQ54OP1Yd8Of4JtGQUeRCkEgGQbwvHXwqecVawL6iQHoE
X-Gm-Gg: ASbGncvK8UKh9zd+3evvD8DCCc3h1FZ8CLuSmV0+4yPRyY/8v26leH9Q9Y977gWc8lu
	kc77dVEo0FAUdakDWYGiggYo5YOweJUPe+T8lJo+ERNOFs8n3YQhXOsI82OQNkHSRFf+NwTCUPX
	M7A76YNUbBmVCIg3A973P4OgH/BAAj8cCMYvXcx+Gm7A7NRS1bT4n5ZA29MNyHPXk+naIXx4zwM
	TRu3IkC1D+imEZqKla0Ctk+YpiPDz/PFLK1QIhdAtqyEwTHKdbtMDyqSHjailruacDK6BFNfAsM
	1nYEq50T4HAe7IoJa1WLUknxUldmEutYeu+ze6VSmOd0NZ82Jo27Buc9CsArdf0HKtsQ2R1OShd
	htcFiCySw4n8styA89fWJzP2Do6+Lig==
X-Received: by 2002:a05:600c:1f83:b0:477:54cd:2030 with SMTP id 5b1f17b1804b1-4778fe797afmr175911015e9.21.1763529446481;
        Tue, 18 Nov 2025 21:17:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhusV+p6YGO7+jMEFYDwD3HPY/3RYziImsrCCdOjkuWi+w+04YVq5vQMjbhRgwB2ne3qQ5rg==
X-Received: by 2002:a05:600c:1f83:b0:477:54cd:2030 with SMTP id 5b1f17b1804b1-4778fe797afmr175910865e9.21.1763529446024;
        Tue, 18 Nov 2025 21:17:26 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b0faf295sm27631655e9.0.2025.11.18.21.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 21:17:25 -0800 (PST)
Date: Wed, 19 Nov 2025 00:17:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Yishai Hadas <yishaih@nvidia.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Alex Williamson <alex@shazbot.org>, virtualization@lists.linux.dev
Subject: Re: [PATCH] virtio_pci: drop kernel.h
Message-ID: <20251119001641-mutt-send-email-mst@kernel.org>
References: <a1efb550481fc67973c0a86860e0724c8f5b9957.1763507303.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <a1efb550481fc67973c0a86860e0724c8f5b9957.1763507303.git.mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZklraISZ2YCOUiGwZ0n4Cx4uFA-zBF_nxA2aWIB3HRE_1763529446
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 18, 2025 at 06:08:37PM -0500, Michael S. Tsirkin wrote:
> UAPI headers really have no business pulling in kernel.h
> Drop it - it does not seem to be needed, either.
> 
> Fixes: 7c1ae151e812 ("virtio_pci: Introduce device parts access commands")
> Cc: "Yishai Hadas" <yishaih@nvidia.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Oops. Double checked and it's no good - I just had virtio disabled in
the config by mistake. Pls ignore.

> ---
>  include/uapi/linux/virtio_pci.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
> index c691ac210ce2..d1b31efc4d7d 100644
> --- a/include/uapi/linux/virtio_pci.h
> +++ b/include/uapi/linux/virtio_pci.h
> @@ -40,7 +40,6 @@
>  #define _LINUX_VIRTIO_PCI_H
>  
>  #include <linux/types.h>
> -#include <linux/kernel.h>
>  
>  #ifndef VIRTIO_PCI_NO_LEGACY
>  
> -- 
> MST

