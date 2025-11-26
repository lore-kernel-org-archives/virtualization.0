Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F9B4A0C
	for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 00:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764115485; cv=none; b=pWR1q1BYBwYtfJe9QkgpganDPWaS0ApgkfvXAI5NtiTEY/QTspx3px3xS92ZMszEIGgh4MR3iQTo/uNPsH3n8giM8oMggrHAVbmVnsD6cG4M65WQ8f8kh79XXVgLUSfVdxfEvk9EJ7qvBFYEPTMGat3NhMuWpJr3DmLqV4fmzFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764115485; c=relaxed/simple;
	bh=ike1WMWzvLmPlx5h/tCRlbzBaVx7z8muD6TccEz+uaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=krGWTeSGs9D8wkJZEl52ycH6ceSevHXGzRvMNC1I84ga8KQn3ocFKWDcynsuTgzrpiSs0NH4rQtNzUuy6hRcW5hjuI2Cn2defQXKt/4ZjSE1/djxhVxG2RoRzJSxDD5hF2wtcXQsb/2RNMP1yXLyFvrE4ZVey6Y15cJhCQFm7xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I33+ruBy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I33+ruBy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764115482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xTUyf4j0JVB1nQkzDa0c2Yn3+M9B9/NTb0nOVSMXyI4=;
	b=I33+ruByaslKP3z+4a7AQTMOPYY+pU1TT000lmvJJwvmmmXsg2uVNu78eH1+w4sZ8k+7yq
	AmdEF2yHTpWP39HGf07jrFkqI6i8XQDI488xhjeUF1I8ySPfkibXi0+qEsH+6XrHsWZ/Ie
	xb9bEIoIFI57UUAMlu2oyvu706G8uVU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-tmfnVYmfOQC8kP4iXknGSw-1; Tue, 25 Nov 2025 19:04:40 -0500
X-MC-Unique: tmfnVYmfOQC8kP4iXknGSw-1
X-Mimecast-MFC-AGG-ID: tmfnVYmfOQC8kP4iXknGSw_1764115479
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477563a0c75so32415865e9.1
        for <virtualization@lists.linux.dev>; Tue, 25 Nov 2025 16:04:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764115478; x=1764720278;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xTUyf4j0JVB1nQkzDa0c2Yn3+M9B9/NTb0nOVSMXyI4=;
        b=gaVmaBNT29sckYIWR5rwPPwA8qdT4BvqflaIufoF9Bx2lwaIvzQfVn3eCrqq9dgsMV
         /+od5CN32DzdEqqceagPsjZOCY2PNN0SNBpXvq+l+8hMAOrM1TcsLJrK6v1fsXxNd6tm
         SBrO452L7yncBXec1jfV0Fx4+rTb3XRDMFU2NX6DLQ8UTqxjT7N7XTtHS85sv2Inv+4R
         r+1nNcNPQhT4d0Fu4liYbhIZHOSBb+lryTZtay7N5dYRLU0jzqdPQzQuaGPLVYZGfJ47
         IOVpf2MJ3i14itwSVYrwkZK0LVrPwvpdGpx3bqXhey6Dve4tFiwtO2fcwPpmC1h83FLt
         mjLA==
X-Forwarded-Encrypted: i=1; AJvYcCVgy2nU8KUYQKb93fRoGQrrgqJwWzI/MO1buSaQi1MB7vGN9IkJDgwyGWj9G0tQv3LOLKtnEwaJmhPnBhHuug==@lists.linux.dev
X-Gm-Message-State: AOJu0YyUEoR0DAxD/d27YX/vDi6CYuWKQZ3CG3f960yGY4snVy5xu8cE
	sY3m2421KoANgYXKEHyc8aj8JzQ6oF3myhVJ5eqT/4CxCPCnAaInpixEjboUS2emK+dackGFwfN
	KX5DygCw/R0WjMoxIl5q6emz0Yd1h7LtHiEypT7XGk08JcQ7naJC5DDacGDLYahb0S1+QpeAheu
	Ie
X-Gm-Gg: ASbGncserQrli9BObkRjTq+M44nSAd6Ros9R7n28MfIdbrUfbu6wHiOQ62KayArTjmL
	XfRTCJOPP5gIcpIlO8v8lFUlfc5vewBSkB8+GZyPWaKEbwEe8r4tXlTTIDwNd3RtzbgcRVMiPbq
	/J4ckzhb5u1FKRTv4Em4FghTxUbXZZOek1FFhq7+nL8Eh2eMyzhdwN5qEwnjh+UKwi6v8PPXv6k
	9HbrnFeLVUZh7HVoxKQpnp2p1A12kOJhQAGTgiVsOFYvOgG/VQnb0tqbogaV18n5UTiL0Gytekv
	XpvsacLdL++Po7bgXBaAjnNgFhxg3LLKytKu3RcQZvmLkn2OuhrKxZhegjA7+9DV9jAEHr+cf47
	xxZGE8Yhl7U8hc6WDJAEodplVNcicsg==
X-Received: by 2002:a05:600c:6287:b0:477:7925:f7fb with SMTP id 5b1f17b1804b1-47904ad0724mr39869615e9.10.1764115478501;
        Tue, 25 Nov 2025 16:04:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGO6qZviFo/lEHybIQNV9gudmrKamo/T+9zD29CwkXnIFBmXmbvXnDigufHOe+9lYLZ7wSlA==
X-Received: by 2002:a05:600c:6287:b0:477:7925:f7fb with SMTP id 5b1f17b1804b1-47904ad0724mr39869425e9.10.1764115478064;
        Tue, 25 Nov 2025 16:04:38 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f49a7bsm36851184f8f.19.2025.11.25.16.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 16:04:36 -0800 (PST)
Date: Tue, 25 Nov 2025 19:04:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jon Kohler <jon@nutanix.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] MAINTAINERS: separate VIRTIO NET DRIVERS and
 add netdev
Message-ID: <20251125190356-mutt-send-email-mst@kernel.org>
References: <20251125210333.1594700-1-jon@nutanix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251125210333.1594700-1-jon@nutanix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: y4drE_LyvgdenBRGwtMJ-v_VkVZeJ9jYftWLYShdq1c_1764115479
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Nov 25, 2025 at 02:03:31PM -0700, Jon Kohler wrote:
> Changes to virtio network stack should be cc'd to netdev DL, separate
> it into its own group to add netdev in addition to virtualization DL.
> 
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> ---
>  MAINTAINERS | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e9a8d945632b..50cef0e5c7c8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -27139,29 +27139,23 @@ S:	Maintained
>  F:	drivers/char/virtio_console.c
>  F:	include/uapi/linux/virtio_console.h
>  
> -VIRTIO CORE AND NET DRIVERS
> +VIRTIO CORE
>  M:	"Michael S. Tsirkin" <mst@redhat.com>
>  M:	Jason Wang <jasowang@redhat.com>
>  R:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>  R:	Eugenio Pérez <eperezma@redhat.com>
>  L:	virtualization@lists.linux.dev
>  S:	Maintained
> -F:	Documentation/ABI/testing/sysfs-bus-vdpa
> -F:	Documentation/ABI/testing/sysfs-class-vduse
>  F:	Documentation/devicetree/bindings/virtio/
>  F:	Documentation/driver-api/virtio/
>  F:	drivers/block/virtio_blk.c
>  F:	drivers/crypto/virtio/
> -F:	drivers/net/virtio_net.c
> -F:	drivers/vdpa/
>  F:	drivers/virtio/
> -F:	include/linux/vdpa.h
>  F:	include/linux/virtio*.h
>  F:	include/linux/vringh.h
>  F:	include/uapi/linux/virtio_*.h
>  F:	net/vmw_vsock/virtio*
>  F:	tools/virtio/
> -F:	tools/testing/selftests/drivers/net/virtio_net/
>  
>  VIRTIO CRYPTO DRIVER
>  M:	Gonglei <arei.gonglei@huawei.com>
> @@ -27273,6 +27267,25 @@ W:	https://virtio-mem.gitlab.io/
>  F:	drivers/virtio/virtio_mem.c
>  F:	include/uapi/linux/virtio_mem.h
>  
> +VIRTIO NET DRIVERS
> +M:	"Michael S. Tsirkin" <mst@redhat.com>
> +M:	Jason Wang <jasowang@redhat.com>
> +R:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> +R:	Eugenio Pérez <eperezma@redhat.com>
> +L:	netdev@vger.kernel.org
> +L:	virtualization@lists.linux.dev
> +S:	Maintained
> +F:	Documentation/ABI/testing/sysfs-bus-vdpa
> +F:	Documentation/ABI/testing/sysfs-class-vduse
> +F:	drivers/net/virtio_net.c
> +F:	drivers/vdpa/
> +F:	include/linux/vdpa.h
> +F:	include/linux/virtio_net.h
> +F:	include/uapi/linux/vdpa.h
> +F:	include/uapi/linux/vduse.h
> +F:	include/uapi/linux/virtio_net.h
> +F:	tools/testing/selftests/drivers/net/virtio_net/
> +

vdpa/vduse is more or a core thing.
Just split include/linux/virtio_net.h things away.

>  VIRTIO PMEM DRIVER
>  M:	Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>  L:	virtualization@lists.linux.dev
> -- 
> 2.43.0

