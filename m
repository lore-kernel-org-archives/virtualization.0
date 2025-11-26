Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E76E31771E
	for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 06:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764139508; cv=none; b=VvSysTN8/H5OB8H1/UXegM7HcRflT4HEkAVK8inT1lWslkzWOrfXMc7Xc6ghFHtgfHjjk1zfPV8OtjBxHZj+CfPUSNgcHYbYSpRD0SnkaugMGSLJuDWnfkcNemeLHKL6rLQAiEGM/h/P5FXB+RQmVw8qQJbmdUOUughGy5uvWI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764139508; c=relaxed/simple;
	bh=DQ6bRODoblgAeg3XSk7omcQWdHBFsCnw6CmyRqth/B8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZC2ybDRB7WTlNuosSjwQ2z0AMwB1qcF7eTgJPNZRg8XyNEFwCdRCs5dufkLUr9kRNRW/9pLlxIfDQJVpHDIP2tjmyR/wve9iQtsgwWs98QHzx7xUVJ+EpRPai3tWorXt1vC1WcnfVNYQy9SGtU7Pv0MCqG5IxNqOAQa2gQvaK7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bzImQgLe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bzImQgLe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764139504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Npvcjha76DC1ejnGCP7oq3FFGj14mki1tnTcX/tgKc0=;
	b=bzImQgLeeKRulpM3Jn7CJiwCZJyJucwkznKDWhhxbKDoeqTrO3w+fx9WTDm83aHgfg40iS
	tGVc74k/S+OG2ghF0Bl2G8SkyGFUcbbcX0dZZipa9UXfynLJdqY0ZNjVlEh2uVjQqFa8l5
	Wi0iSoBDvYPRMupcfxteqwyBxG05gPA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-YX_cMKYcMCqlC2L8P8qz3w-1; Wed, 26 Nov 2025 01:45:00 -0500
X-MC-Unique: YX_cMKYcMCqlC2L8P8qz3w-1
X-Mimecast-MFC-AGG-ID: YX_cMKYcMCqlC2L8P8qz3w_1764139500
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-88237204cc8so145771786d6.2
        for <virtualization@lists.linux.dev>; Tue, 25 Nov 2025 22:45:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764139500; x=1764744300;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Npvcjha76DC1ejnGCP7oq3FFGj14mki1tnTcX/tgKc0=;
        b=MewmlCcaMVucFuvrLhuPF7+bnl0OhkfT6LGU2B6/kn0awe1ERzqxEWBZtTcu++RZU2
         Lj9c5JmjoHtzMmhQBlv4/BsZqiNGFKoY1R+7nc7Nj3cDW5MP47X4HBTzleT52u9BZwJy
         zeG483pO8O1LkAxSZQ1+cu+cOca6UPLFOj4Yx+3ntx8JZLmTIaRiUZwXdG4VQv0cz+zc
         ZPuNetN8p5QuUghodJfDEvWFzwIHHqsYynr4z+kha2TOqtg7PGct5DMH7IY43hq9dQZ+
         6Evs4VCpzgj5B9um+UhvDAMc7E3IAL8/p/utxsfSEgeD82rfwKLxR436O9xgyavutMld
         Phkg==
X-Forwarded-Encrypted: i=1; AJvYcCVLvT/NuyJ+sr5VroWlKrixqF3pSEg/bi+oqk1naYepptkZwER0K5q9A5szdcxiCjfvBbbsQvgajkR/Tx9/sg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxt97r44O/mNllXtmU9PrBHMDlH6BV0y4spFoJ0xRhOr7cOhjQV
	4KVSj71Bb1O4Iir3GJd6/UvyoMF1Psw1kUYf1Vwmj6JGW0MV4AvFOHkFQ8x889PDtOro+07+zbW
	hPTFngq884PA3HyiTTjhAUOcunwNxaG94qkyxUFFbfUa3IyeaqzJlLH4jCOBQHo3yvRR2
X-Gm-Gg: ASbGncvoxgE/CqmMhqTbKkYBzaxtBnljqlxHtDuK/YmgBNSbhuRkZVZhZVnX33961iP
	+Lc/WRgnNjceO0W6nZePqMB+423jSNfmOhe3NJVLRDCmSrpO3pzlCpdydUywJpS6k7dIKVV/iN9
	oYeALr5rV9n8IpquOPIddgucWctj1TIrtFux0nHLUw/jFB/gA6HkpyovKcQEVrjIqaGixOmuw6k
	QrvSu0xLS1nmSNBPKWD7xufzBotSHEJCVM/SXO4tLaoA5h9jaqHj2rska3vJxqoxfXdxbAVaeML
	doFrGjcpTrr42tHMnOjtqzTv4yUJm+qOLO3+//rde1IJLYcprSkILW9QLMl4CcKkR5itu2oYepv
	X/2uMZdUWNvHjvxG+XxNZQYiUQvxq4g==
X-Received: by 2002:a05:6214:4983:b0:729:9b59:bba6 with SMTP id 6a1803df08f44-8863b0030bcmr81663836d6.34.1764139499990;
        Tue, 25 Nov 2025 22:44:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFryAKS6j5tOcAHlHu78NLpdU4U4O+q9VC2+SQ+7lI/BXK39/K0QLkDWLrOK7gOYfRBdeiYUw==
X-Received: by 2002:a05:6214:4983:b0:729:9b59:bba6 with SMTP id 6a1803df08f44-8863b0030bcmr81663586d6.34.1764139499525;
        Tue, 25 Nov 2025 22:44:59 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e573909sm142973046d6.39.2025.11.25.22.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 22:44:59 -0800 (PST)
Date: Wed, 26 Nov 2025 01:44:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jon Kohler <jon@nutanix.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] MAINTAINERS: separate VIRTIO NET DRIVER and
 add netdev
Message-ID: <20251126014446-mutt-send-email-mst@kernel.org>
References: <20251126015750.2200267-1-jon@nutanix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251126015750.2200267-1-jon@nutanix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: n6I7d4_35MRkCQWQtUvEtj4g7tRxoskCCc6AX8NmGSM_1764139500
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Nov 25, 2025 at 06:57:48PM -0700, Jon Kohler wrote:
> Changes to virtio network stack should be cc'd to netdev DL, separate
> it into its own group to add netdev in addition to virtualization DL.
> 
> Signed-off-by: Jon Kohler <jon@nutanix.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> v2: Narrow down scope of change to just virtio-net (MST)
> v1: https://patchwork.kernel.org/project/netdevbpf/patch/20251125210333.1594700-1-jon@nutanix.com/
> 
>  MAINTAINERS | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e9a8d945632b..dfe80717b0af 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -27139,7 +27139,7 @@ S:	Maintained
>  F:	drivers/char/virtio_console.c
>  F:	include/uapi/linux/virtio_console.h
>  
> -VIRTIO CORE AND NET DRIVERS
> +VIRTIO CORE
>  M:	"Michael S. Tsirkin" <mst@redhat.com>
>  M:	Jason Wang <jasowang@redhat.com>
>  R:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> @@ -27152,7 +27152,6 @@ F:	Documentation/devicetree/bindings/virtio/
>  F:	Documentation/driver-api/virtio/
>  F:	drivers/block/virtio_blk.c
>  F:	drivers/crypto/virtio/
> -F:	drivers/net/virtio_net.c
>  F:	drivers/vdpa/
>  F:	drivers/virtio/
>  F:	include/linux/vdpa.h
> @@ -27161,7 +27160,6 @@ F:	include/linux/vringh.h
>  F:	include/uapi/linux/virtio_*.h
>  F:	net/vmw_vsock/virtio*
>  F:	tools/virtio/
> -F:	tools/testing/selftests/drivers/net/virtio_net/
>  
>  VIRTIO CRYPTO DRIVER
>  M:	Gonglei <arei.gonglei@huawei.com>
> @@ -27273,6 +27271,19 @@ W:	https://virtio-mem.gitlab.io/
>  F:	drivers/virtio/virtio_mem.c
>  F:	include/uapi/linux/virtio_mem.h
>  
> +VIRTIO NET DRIVER
> +M:	"Michael S. Tsirkin" <mst@redhat.com>
> +M:	Jason Wang <jasowang@redhat.com>
> +R:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> +R:	Eugenio Pérez <eperezma@redhat.com>
> +L:	netdev@vger.kernel.org
> +L:	virtualization@lists.linux.dev
> +S:	Maintained
> +F:	drivers/net/virtio_net.c
> +F:	include/linux/virtio_net.h
> +F:	include/uapi/linux/virtio_net.h
> +F:	tools/testing/selftests/drivers/net/virtio_net/
> +
>  VIRTIO PMEM DRIVER
>  M:	Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>  L:	virtualization@lists.linux.dev
> -- 
> 2.43.0

