Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6D327055F
	for <virtualization@lists.linux.dev>; Thu, 11 Dec 2025 08:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765441820; cv=none; b=fv5SmUkbKdx67RUP3IBvRA+qJrnFAq9Fxom3oS9kucMc8iz61JuAuMmnbI3F+OlR5AHh0TfAgaEY9lF5EdK2F58fYO43qMhdTjlXU8etcblLuTVMiosA++JOzgM1yUn1Rx0f3+5DvDdKqZ+vq2PSLwy1xTVbrcVAPvXZMqBholk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765441820; c=relaxed/simple;
	bh=vx2flSiC2ZzOI6DHmbaRJhsf8cDKzOr34NF/08N2QWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=NNcYzWuRMSDJfvJV/EpcoIUi8gHFZ3hQ1axKxHdfCACKpahD89LFbpmGwosX5KweaSNJO+rklmZOPXF2YzV0bku+4OuH5O2vy+nLVG//6ZOQgMdVBfpjja+bDA/acSmorVgcmHBvZwjCF9aANc7FxYzk0mpcCFbeHDu3EveWYHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EHiJIiDd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EHiJIiDd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765441816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3idtZY7mSmwvuTMlPGQ2Fz6MYA6aCNvj4wJ0sTbDzCg=;
	b=EHiJIiDdHyvOSAmmcGX3t5foQ8vZrG5kgY926VSPQ2ABvUO+4k8JTjWdKddnf3+CjeTrlr
	jLhiMGmPN/49YjiqHaHTHdleFTPUyCa7I/Z7a0Amhk90ZNJm0wZMFJFAPYIYRcbH4tZVdS
	0p7zlcB7uIJkKpTKgy6T25FKUSxDQ1k=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-i1_o9OTtMQuMaBaF73xhcw-1; Thu, 11 Dec 2025 03:30:14 -0500
X-MC-Unique: i1_o9OTtMQuMaBaF73xhcw-1
X-Mimecast-MFC-AGG-ID: i1_o9OTtMQuMaBaF73xhcw_1765441814
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-64161017e34so1024849a12.1
        for <virtualization@lists.linux.dev>; Thu, 11 Dec 2025 00:30:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765441814; x=1766046614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3idtZY7mSmwvuTMlPGQ2Fz6MYA6aCNvj4wJ0sTbDzCg=;
        b=wQii2gBAcAxGfL5iylHJSdzNKJvGEyfi/2G9z3FU3W4NjLYDx4uOrXCs+dDAhs/wKZ
         J3NPKDXaN7MUG38gj/lOHooi2yP2c8gRmrFVPKR0QOupvuRj28Nv/IrX11zCmLTVqcuA
         BonPn0G4JVxlyuLbE0GeWDQHOxdEOkGUaN+JsKH0K443wZ31LmfcpCqZGbjc88U8xqkl
         J22Lfyqg7wOoHGgynnGN6+zt+oY9c+PNsTJiRb58LeunBYzlDTw5s5sgrTVKSgjzC10/
         UK1s3uPkI+8/sVjk28ph05M2fEOzkfbuhbtVfO01DJ4IWe2ID2nWe9Q3xYRP9Yj6OUim
         DE9A==
X-Forwarded-Encrypted: i=1; AJvYcCXtNYQo5pgxIkY++h2DQ6bZz9Jl5Lq0sxutT9OwV2Jd5p0T51Sc0qWBCNziuuInZRLadEG4+BsxG18yQJGbTQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz85Sbe1snyKZ4yVdXsA7N8/Wd8bf0O0S5/gdTnohhJ6rORuHnt
	MaDrGd6awF9RFHsHBzDqLlRf6T51pJQy5KOfvMAy6DRJkL4zQXHeWuCMQkf7Ei9yxY8SkngvBvm
	R8dseDyK9xGEuv4So2wppqR7y643nhQ00/a+hODUtqJs2eoO+/6mEr4SDUtO6QRkkgsL/
X-Gm-Gg: AY/fxX5jJsUxiElM7wDR3/7/Ym6JVJxO0jtC+nKtj/5123fzHWIHtelyX8/v8g3lSwz
	uZ/n2OLwqWN94CxJx1wiao8lw0XXAPYZ827VDZhi7T9rNaNQodXtokmyfrygl3gPyz/P+AuXScz
	jMiDBfuu6UcHE8KU32X114skY0XKCCf0V4WYq3J6i1xn0OQwOBjAxH6VXwCMAwdzxv8/+bQi1CE
	2K2VE63CvS3iTQqDiuNajs0geS0pUnC6WY1wzTiGl5CcJ3d/CBHpUzp0drtmyIT5y0AkjSU2mWT
	dfCuOCmRZapubG7GA2FMO9Kn//rHktINWywMci0Ihv7a6V/M1NSvKtx48a98Hsb/kNb3Q61GM7g
	xGB1k9g57UOn9mFLzjdhEXaZ5jOpBzSuCHWNXeZyfFZHiem6UMvIIVzkyAD3/Ow==
X-Received: by 2002:a05:6402:2786:b0:645:1078:22aa with SMTP id 4fb4d7f45d1cf-6496cbbc23cmr4596716a12.19.1765441813622;
        Thu, 11 Dec 2025 00:30:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuwQjT4UHTBmwDXqoTBxPbsneTQexl6Aw6I9Srmcye45B0nUYzXfaqL0GoFMZfWMLEuTvP7A==
X-Received: by 2002:a05:6402:2786:b0:645:1078:22aa with SMTP id 4fb4d7f45d1cf-6496cbbc23cmr4596676a12.19.1765441813080;
        Thu, 11 Dec 2025 00:30:13 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6498204fbb3sm1831786a12.8.2025.12.11.00.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 00:30:12 -0800 (PST)
Date: Thu, 11 Dec 2025 09:30:06 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] vsock/virtio: Fix error code in
 virtio_transport_recv_listen()
Message-ID: <xz4ukol5bvxmk2ctrjtvpyncipntjlf4bdr7kjdam2ig5gf7ho@vuuwwu7asj7i>
References: <aTp2q-K4xNwiDQSW@stanley.mountain>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aTp2q-K4xNwiDQSW@stanley.mountain>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RV-51UwKy2SYixwYZAql8p4Bt_BwYps6iWsHWk35WIs_1765441814
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Dec 11, 2025 at 10:45:47AM +0300, Dan Carpenter wrote:
>Return a negative error code if the transport doesn't match.  Don't
>return success.
>
>Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>Cc: stable@vger.kernel.org
>Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
>---
>From static analysis.  Not tested.
>
> net/vmw_vsock/virtio_transport_common.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index dcc8a1d5851e..77fbc6c541bf 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1550,7 +1550,7 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
> 		release_sock(child);
> 		virtio_transport_reset_no_sock(t, skb);
> 		sock_put(child);
>-		return ret;
>+		return ret ?: -EINVAL;

Thanks for this fix. I think we have a similar issue also in 
net/vmw_vsock/vmci_transport.c introduced by the same commit.
In net/vmw_vsock/hyperv_transport.c we have a similar pattern, but the 
calling function return void, so no issue there.

Do you mind to fix also that one?

Sending a v2 to fix both or another patch just for that it's fine by me,
so:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

