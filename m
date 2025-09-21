Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261902765EA
	for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 20:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758488381; cv=none; b=jUeW7DiH49HP81J5gdfOdnRXWJAcS9MbAJQqN2eWTtp+q/7CwcilwL+lRC0SqgohS4ApPExhxheHgaRLK6D19WjyolW0QZYHaMzHGTV68QtvOQDIv65dxFVbIPgNkngTUzmhAQrtLZwPWAX3i3OmXD0X1SIki7FL+pCnzI9ohz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758488381; c=relaxed/simple;
	bh=i7pW9HwRwP2c7GQu7cmSv4/uxHxGCvk/Ta/jaDGnmYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nfFWwfmluKhl4F3MrT9qv9u4293GvYRsxQtz+lateekTz6DDdN6ylo1FwgPtFkOzjKQmHm93RYOEu7HcP6QNBUAP0QN9IlUaKw/cDPGt0EaogJsEmoqIqjwq+CfvT6iz/Uwv49b9kPelWeghEjgbz99f/lc/F6ejkLVVwwZhYOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uc23reFv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uc23reFv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758488379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cccTVUHrijNSX4z+x7tgOWrfdy/5n+8UzzmA9bxQJ4s=;
	b=Uc23reFvm6uJZmX2rTDVjweww81LYP6Zkt+vjDui3VqlXdbFBfT8BA6xI/Jt13Br6KviuC
	CTaYfnIFN/egykOPu5MKzCAX6Xtx9HDa6UR/XgJv25OPqcdZWvhxnjhW3obDRoQL0kBDkM
	NZsa2pLB3PnghSXzM/4yUd36trcZBqw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-V3PLs4seOvWNHZaZXzd_fA-1; Sun, 21 Sep 2025 16:59:37 -0400
X-MC-Unique: V3PLs4seOvWNHZaZXzd_fA-1
X-Mimecast-MFC-AGG-ID: V3PLs4seOvWNHZaZXzd_fA_1758488376
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45de18e7eccso18205245e9.0
        for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 13:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758488376; x=1759093176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cccTVUHrijNSX4z+x7tgOWrfdy/5n+8UzzmA9bxQJ4s=;
        b=fXPUQjw6gtI5WSpWEjHkfFApNMGU2+ptDguWU9yw6dOWbE6odQZPQB/zq7xMHOOXWb
         Q2S6V/Si2s02/03i+PXXAqGi6b2VrmSsXhYQQVq2o89Bxabb7ZfNzvWSFWuXqoEScWzw
         AIzfzisXGrVBdf+ddbHZFwhGBjpY02mm5IxUhy6EemoLtwJuhTB4Bg44DjBdpjoGTJDH
         w4sP7Sv5LVKc0g5Tu6FiTJFj6bD4GQwH2GGWU68/ERPzuUG7yQEs2wrgVp/jCWhcyHCr
         0EMXueeqHupBZFBWumKiy2KWaszTE7AiHg2mOrPN/g4kd2GQhTNvsRl+PvS86o9F63P+
         93kg==
X-Forwarded-Encrypted: i=1; AJvYcCXyFbDIhF1S1soCIMYvad2CS3Vxydxx7OlW/s8jThDiN5OqZwIEqsIS5xRYB6kF4YnBrTcmDkJkzRwq+jMgEw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/SptZ6KbXQacm4hmcVYJteZZ58zosZ1rMA7f48jqjIfhVvUHi
	vYy1YcNow4Pe0C1cOEmZ2X9mtq4kjic59P8+qIiq75Ff7+Pn/1xYpcr6u3W9NFfSyln8xdz01xF
	vabn3JjP2qOwnR0dX7ACRXHHYv1N0Yc7G1d0TwktM5xmvsj+zAhSlQpD0K9ZKhwApP3tr
X-Gm-Gg: ASbGncsPPUGXPfGE/s+N+fYCtNVvJM/b0KeYtm5IMUTIC6CorJQQn4InwFty+0roKoU
	0yvuO34t7sjNSum2GYZoj8knScj/2kx8ouvemRIYGCisVE7AdZnHhhEPkYsxq1Gg57tmWkEREOX
	BaBRN+9PSUurcKRzbVsKxDQ8Roy5fv6Kao49FoynpUf2jSdq6UPhvOz1Mp9Ucw0XJBlI8pPGfAm
	rg98tbGykvvo5LNbV88BR4wgYlOpVHWfoocLYdZ9zuqHtr9c/1M0Y+wCvk+5RojhuahX4z98NTr
	VpqwYLMBRef2exgO5SErdNaYJyXIb1WPDrc=
X-Received: by 2002:a05:600c:3b20:b0:45f:2805:91df with SMTP id 5b1f17b1804b1-467efb044f0mr75179875e9.20.1758488376295;
        Sun, 21 Sep 2025 13:59:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+9gyh4b7Pe6vwSysrkjuIQgt/cb1zE0T12QzGBFLzTc0cFE1MvWmSWaHwMUzYdnnxQL7Ozw==
X-Received: by 2002:a05:600c:3b20:b0:45f:2805:91df with SMTP id 5b1f17b1804b1-467efb044f0mr75179775e9.20.1758488375860;
        Sun, 21 Sep 2025 13:59:35 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3fa9e584309sm3897012f8f.49.2025.09.21.13.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 13:59:34 -0700 (PDT)
Date: Sun, 21 Sep 2025 16:59:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: jasowang@redhat.com, eperezma@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost: vringh: Modify the return value check
Message-ID: <20250921165746-mutt-send-email-mst@kernel.org>
References: <20250910091739.2999-1-zhangjiao2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250910091739.2999-1-zhangjiao2@cmss.chinamobile.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LSWv6HpGaaSQgWn5gERvJWfQg5O2eH5N1T7zQHGnwGg_1758488376
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 10, 2025 at 05:17:38PM +0800, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> The return value of copy_from_iter and copy_to_iter can't be negative,
> check whether the copied lengths are equal.
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>

Well I don't see a fix for copy_to_iter here.


                ret = copy_to_iter(src, translated, &iter);
                if (ret < 0)
                        return ret;





> ---
>  drivers/vhost/vringh.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 9f27c3f6091b..0c8a17cbb22e 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -1115,6 +1115,7 @@ static inline int copy_from_iotlb(const struct vringh *vrh, void *dst,
>  		struct iov_iter iter;
>  		u64 translated;
>  		int ret;
> +		size_t size;
>  
>  		ret = iotlb_translate(vrh, (u64)(uintptr_t)src,
>  				      len - total_translated, &translated,
> @@ -1132,9 +1133,9 @@ static inline int copy_from_iotlb(const struct vringh *vrh, void *dst,
>  				      translated);
>  		}
>  
> -		ret = copy_from_iter(dst, translated, &iter);
> -		if (ret < 0)
> -			return ret;
> +		size = copy_from_iter(dst, translated, &iter);
> +		if (size != translated)
> +			return -EFAULT;
>  
>  		src += translated;
>  		dst += translated;
> -- 
> 2.33.0
> 
> 

