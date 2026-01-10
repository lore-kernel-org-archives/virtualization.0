Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103B21E515
	for <virtualization@lists.linux.dev>; Sat, 10 Jan 2026 23:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768088929; cv=none; b=fuwAOYjby9ijXtiJRGM38BCUZr/ecQN9hGvIUfKrZnTh5MSizClL3vUbdxQvYoTxMlKn4VfxnK5TYYv0ChBBxN0Y66h3Ae9xMEwMSVPajjff8Zv3g8/9h4aoQvyUOD8k/eAVYpuIpBhHEnwd3p+HoE9LCU7HMm5fbpAdF2toOHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768088929; c=relaxed/simple;
	bh=h0ql6NNHkH04blOJcCQeJQVZ/quwcbXv+V+NyIc09ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DCX+grhBQq4fW/g6+V1u9EviM8hypjQeFSW3hQmi23He8LCKbLR66C9c3D3knAvHeG6VF8Bl99Lann2ih5djhySJzp5Z2tUCQeekloXov54Ds6XnpSJBIsM5B5tt2wGdxWHY4G0VamNliFx27u8MBJGv7lS1d7/F/0mNeZZSz2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UytxUVaj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UytxUVaj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768088926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rlBQhD5n0Xt0auvthwhqai5/1JwyKFSNih4sW0Sc9kg=;
	b=UytxUVajLduzTtNgb0J3JxYM680IrALjVSSoJw2wVskCAGCI9dfrs6QgFYVeguZLjdDcsH
	ioFQvsLpd7NlS0TmL7+svC+gW7T0UKH310otJ2nYQLuU6t+gypgne0jwUn1p+GXZDQT0Fp
	4yU7+a3qohKj12AJC1DUQONl49q4k+U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-4bvauRPfNsmaqmszU9z1QA-1; Sat, 10 Jan 2026 18:48:45 -0500
X-MC-Unique: 4bvauRPfNsmaqmszU9z1QA-1
X-Mimecast-MFC-AGG-ID: 4bvauRPfNsmaqmszU9z1QA_1768088924
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-432488a0ce8so4035189f8f.2
        for <virtualization@lists.linux.dev>; Sat, 10 Jan 2026 15:48:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768088924; x=1768693724;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rlBQhD5n0Xt0auvthwhqai5/1JwyKFSNih4sW0Sc9kg=;
        b=tDtAk5+fyIEimlHNE3UB9GPfrEcRw/pPJE6f3kK06ochCk84ZjekswYRzTqoU0xL/e
         BXnf520MIA/w+jK4tXewOG9ZK9uW5e3shltISxnc6k8NXrrw/HCbCbaeu06ccKu7ZXc1
         qBMipqcXBVNpAp3yIaCK9WGMIVobrMkKK0hERtrUtiYqXsDixM/CNk9aw0Zqq10Ub4FS
         JMJyBxG+4sWQef/ZuHYEmEGSeUMO4gr6e425B6ie+K/00boMvKxfxOtNBugHpGo6Ytqp
         gn/UNz6CUZ/xFiL05goVqk5DRbgSARL/s2KK8xSanEEtUjEUEDbSNXLg4EawbQ+y0NVG
         N6JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUecEHUFu7qceefXMi1+pLNAU6zAw/BpoKQf9Nx0UeEOgh4fwNevtOa6kdUcj4cZLIUDpat3N/U7EOM3DcVLg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJoftCgRz006upBmYGpswkTRtbUHbdyrN1K0udarLbcR4ZX0X3
	Paiv9MTMrLbcf/qZg+k0AN/ikMDXIwAJsnYlclSJSXLAqglcoH3tHMZeIae/aLwwEbCXYS30E2E
	TmOVhnbER6zbjqE9Sw2q/u5arsJbjaOqfYtym1x4Z2YUug6JBreHoQMIi+U04aLLQtITfKLtWCV
	lQ
X-Gm-Gg: AY/fxX6sXppRE46/ikQlgYfVJOrh/ebqSLXymVJaZtXayCK0zwnBehrKUusqccZNIxC
	8y+ToOdhmzSJp9g5hhC8DjYBAz6GouOHPZMjeJrEy9L2z4ui2RwPopb+LT22G+wVjc5TlPNfA5s
	2i9beqUcm7lCGs8bDv63YNHS0regDUpainbjbt4esXhj1NIh2mkjgtRcphTPhbhsPnTIK0HnZgg
	avJyx0AnePve3sM6CyGC2rybYPuinf30baPBn3DCpGCZLPgVdPhKy10uoMTDsdBTgZ5oxuQDtvO
	/QFAqAOxCgGm1HmwpRyi1RwNJZK88dH+DxST7B0iFNi6jdpvxCZBQxzmKkWbWw8UJXYFEHZUrki
	78x3JEZqaNJhFOSSsqlCIllc7ijuWY7Y=
X-Received: by 2002:a05:6000:60f:b0:432:84ef:715b with SMTP id ffacd0b85a97d-432c3635410mr14859546f8f.0.1768088923858;
        Sat, 10 Jan 2026 15:48:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFy/XTpD8HvLWgUxV5E725ZVupCTTaM+lg4Ha1P92WnC07ztkKnxCIls1B33ddmlBmlX2WWWQ==
X-Received: by 2002:a05:6000:60f:b0:432:84ef:715b with SMTP id ffacd0b85a97d-432c3635410mr14859531f8f.0.1768088923361;
        Sat, 10 Jan 2026 15:48:43 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432dd78f5a8sm10071488f8f.27.2026.01.10.15.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 15:48:42 -0800 (PST)
Date: Sat, 10 Jan 2026 18:48:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>,
	jasowang@redhat.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH v11 05/12] vdpa: document set_group_asid thread safety
Message-ID: <20260110184728-mutt-send-email-mst@kernel.org>
References: <20260109152430.512923-1-eperezma@redhat.com>
 <20260109152430.512923-6-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260109152430.512923-6-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YJGy0Y5FG1hPFim7uBPmL69azYLSFbMt4S5CcBHl6_A_1768088924
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jan 09, 2026 at 04:24:23PM +0100, Eugenio Pérez wrote:
> Document that the function races with the check of DRIVER_OK.
> 
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
> Requested at
> https://lore.kernel.org/lkml/CACGkMEvXdV4ukZE6xhLL0sSN70G=AWVQgpRnH98Fr4btzMkK9g@mail.gmail.com/
> ---
>  include/linux/vdpa.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 4cf21d6e9cfd..cd1b1f1321b9 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -312,7 +312,9 @@ struct vdpa_map_file {
>   *				@idx: virtqueue index
>   *				Returns the affinity mask
>   * @set_group_asid:		Set address space identifier for a
> - *				virtqueue group (optional)
> + *				virtqueue group (optional).  It's not thread
> + *				safe to call this function concurrently with
> + *				set_status.

Let's be explicit about what to do.
"Caller must prevent this from being executed concurrently with
set_status"?


>   *				@vdev: vdpa device
>   *				@group: virtqueue group
>   *				@asid: address space id for this group
> -- 
> 2.52.0

