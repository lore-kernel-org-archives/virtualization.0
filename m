Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505582E972E
	for <virtualization@lists.linux.dev>; Tue, 12 Aug 2025 17:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755020762; cv=none; b=VxwFHBB/oquwCRK/2YMNcsGl1v1a2H7gCGjWj7FKPuDd1lE2PRw9lK3LPVp2OWPpmBobvXAOYNXkEx3iSGyVmzYWQgudHlpX5cIy9pnRgxBvi6nGwXcGA9coGvGDclOy/Ex8W3AJtV7RZyVsJua4l63WdG4Rd47ZUDnVSLB1QiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755020762; c=relaxed/simple;
	bh=sLBrvqqsZtV1FCVTCMrMgsMw93cY6+eaaOKrjSt2vBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBuSu72nrCZSwBgMFWRvCENF2vYEprYG9kO6kbBSDDmr91Mv57lIzlMTjk0vKcs34bzMc0oMVtX9x3LfTR7lmXI7unEjHTOGOnrZE3yrR1YioUNsAasZvbMZNFHI4j0QVWChNJY7m/2PrQzFwUW28JFixWfL1SF9j7gxseqF1bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=1eh2HExZ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="1eh2HExZ"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76bddb92dc1so7248259b3a.0
        for <virtualization@lists.linux.dev>; Tue, 12 Aug 2025 10:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1755020759; x=1755625559; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+evhD+loaePWkAdN54jiK6XfwBYZ051YhjuuP6S/D8=;
        b=1eh2HExZmF9cEULsKFTfliamerXYBd47n3nE2oYc8OyH9iCzwWSie8fOm8HtyOXTtE
         P8zQAB4LuSzUQQeYXsXk6KKLf3aiNugCxPNRXxK6dL1BP6gJKy54jZfAv5yTNdDNvwGZ
         DVCj4RYb5ihlD4FMrDYHGV4/sXjsuVIsZ2ApFCzxfpR3SQYYAjR85GLwQnHQSl2znBR2
         nScQjuigvQl4F9oW6cHFZ5B4lf1gHFAHxFMHuoSmQ40oO79DSsJYxEDU17X0ue8hMRmQ
         frk122mPU0q4v1yTqdBlPSBKX1GM3B7iE3Ypq0iSW5pVsLxf+uZRN5loDNB7vkXgIo7A
         /LFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755020759; x=1755625559;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M+evhD+loaePWkAdN54jiK6XfwBYZ051YhjuuP6S/D8=;
        b=nzmS/q/QGNKi+6DBIla+8M2epYUre+wo9IPjc1TcQtKud9/z4w4cUlJrJi5mkfQul3
         JpopoRduEI2PIJzlQVsNAN2Z/vPedKG7sL0jPxf32na5bHGcu1tGkSDpgqRN+mt9YnHo
         za+Kme9cr7oeGAbcN8jB5zQZyj+6/BYenQC0Q1N3FRMkSkNro6ZpNGJsasEWT+Mf8haP
         afbMbWBqIAgGP3xj4ncZuMRvC47fALTljlv+Sk8HuNOmW54lElYhtAgadRu2TE+gcj8Y
         OYUWfEu6KO+R0XtFHesiC+HoPfpf3AhPFv8GnZC4NYBJgHzw1nwKJt6dgSy33w0j+kHA
         Fg1g==
X-Forwarded-Encrypted: i=1; AJvYcCXCy1YXzHgkhF208608rJPykpU7cGyFQwKLSG45psvrWi5TjgRkRGYV0axukhD97Ex0k08sLrBYpKeoPbC49A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCHNX61q93OGaXlogLSrDBeiVQLIUOpTOOHc8uy27wePOTCD7H
	+JGVHLZCWi2ibKAcigkWODi3hSdLWPaPQbMGf4Vo1w3j85HP+9W9nUlWE18Ob4As0NM=
X-Gm-Gg: ASbGncuwz2hwgFLCQqjKXq5DJBsofSA0Pkzwym/l6e6NIbBMMwfDA6xt/BDDR1qGI86
	X/0PthmV+2JmjOF6befK5t97Rle+F1vKf1k/PZgBgC8sOEPKOHGG8mEIiIBRsZsV0hpuTdZfb1B
	miw+JqL0ql0MmlD9yN1O0MXD/uxdbe8SiDfZz7AQZ3X//6rWO7vW7mJnrCxoVE/YokxtCBebFfl
	NFIxrVlxv+81FbAEsW1dL6Wgppbj6DC0c8YttubYp9dVCkSyMZztPY94xOeHe3jxZpFYL5b4RCa
	WNII+enYBeC4NRaE3XwFHc41RKMif0K9gi63hgfViL6XZft+X/lp4Q/DKcoBKiVDBpY8BERv0Ov
	76+NplMME+Js6xEiEbSeRt31TXRZcR3ddU7gR0J7/LbbNpqO43PfaSUkT5q/c+d/xQOpCZn8k
X-Google-Smtp-Source: AGHT+IHgeepKUmWcRSt+K6fwtVExxF9zuRBGrYePdQX+VK6gDgBfVe8guzcU2VXIutR11ypHY64Xyg==
X-Received: by 2002:a05:6a00:8d4:b0:76b:ffd1:7737 with SMTP id d2e1a72fcca58-76e20fb980dmr68959b3a.22.1755020759568;
        Tue, 12 Aug 2025 10:45:59 -0700 (PDT)
Received: from MacBook-Air.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c61dd2ce7sm8965276b3a.41.2025.08.12.10.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 10:45:59 -0700 (PDT)
Date: Tue, 12 Aug 2025 10:45:57 -0700
From: Joe Damato <joe@dama.to>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Konstantin Shkolnyy <kshk@linux.ibm.com>,
	"open list:VM SOCKETS (AF_VSOCK)" <virtualization@lists.linux.dev>,
	"open list:VM SOCKETS (AF_VSOCK)" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vsock/test: Remove redundant semicolons
Message-ID: <aJt91SSkBO486bg5@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Liao Yuanhong <liaoyuanhong@vivo.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Konstantin Shkolnyy <kshk@linux.ibm.com>,
	"open list:VM SOCKETS (AF_VSOCK)" <virtualization@lists.linux.dev>,
	"open list:VM SOCKETS (AF_VSOCK)" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20250812040115.502956-1-liaoyuanhong@vivo.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812040115.502956-1-liaoyuanhong@vivo.com>

On Tue, Aug 12, 2025 at 12:01:15PM +0800, Liao Yuanhong wrote:
> Remove unnecessary semicolons.
> 
> Fixes: 86814d8ffd55f ("vsock/test: verify socket options after setting them")
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>  tools/testing/vsock/util.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
> index 7b861a8e997a..d843643ced6b 100644
> --- a/tools/testing/vsock/util.c
> +++ b/tools/testing/vsock/util.c
> @@ -756,7 +756,6 @@ void setsockopt_ull_check(int fd, int level, int optname,
>  fail:
>  	fprintf(stderr, "%s  val %llu\n", errmsg, val);
>  	exit(EXIT_FAILURE);
> -;
>  }

This isn't a fixes since it doesn't fix a bug; it's cleanup so I'd probably
target net-next and drop the fixes tag.
