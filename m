Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69AB3595C
	for <virtualization@lists.linux.dev>; Wed, 18 Dec 2024 09:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734513512; cv=none; b=BjI99XTz/qY4uZGGH1+29M79wsRNk+3I3fYwC+SuKlOS2A7FVI264CRWpEWgg769U2jiA6AuS3Gvef+5mfBpeZZvI6nN86aYB2bfMkIy8phGK0WoMJrl6Jlsde9Mrf75tU2wfCXJvUK7e6XDpTxJQ/v4m2Bgk2LKmaFdO1yqCNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734513512; c=relaxed/simple;
	bh=HSyDULdwQXu3xlcnyukj7r2kntKBqz06an3YCwlmq7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=B9XjInnK/CrNZpkOp6Xm/lNPTvwV3pW+WQd+rkMlfoZpTHX8op8v7sJqMlNx7rW6WWIyN1hu6rqNQS93zqRSwzhhQiDwGUqrukETga87QSJAOskx0hrUtpwnPCLtsWy21ampU8szp9YYfOeUj4oTS4ZVYdsFsTDNUvtw3ugVSb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zc/U2OL4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zc/U2OL4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734513509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RLeA091LzMVlS973SFASJBgcuRe2YSP+pMH6a6B7hJQ=;
	b=Zc/U2OL4Jxm6oiQI9Qdc1wS2dbqjrTBmDZlTIi+0ufn4IYhzQ6CQk70HsgwDKkBaGwdOkk
	LDJiLBs97STPDoOPCMh/zBtF2PFmOUSp3l5E+Wb0A/GVpwNamZW2xWjKsPV9lEjPSUrsqq
	ZQkdjxaEVI1+UJriTxCCC1iNw0va0Ag=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-cAtSTgUKP0uqAcBuK-H9sA-1; Wed, 18 Dec 2024 04:18:28 -0500
X-MC-Unique: cAtSTgUKP0uqAcBuK-H9sA-1
X-Mimecast-MFC-AGG-ID: cAtSTgUKP0uqAcBuK-H9sA
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-436248d1240so34041665e9.0
        for <virtualization@lists.linux.dev>; Wed, 18 Dec 2024 01:18:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734513507; x=1735118307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLeA091LzMVlS973SFASJBgcuRe2YSP+pMH6a6B7hJQ=;
        b=ogMp3pvC1eR0mn2wsiGwaPJiZmwhoBn9tWqF89zT6gyO3ydi7SC7912IZ1VIaRGrEE
         04q8EiFKL2OS/kcV0+WV69ltdagnJcfqm7s4Z1GkeMtwcHNdhqZC56GYicmsF1IjbbFw
         2eJn1Mv6Iotv2TyTdSxI34Fwkuz2T+4pTrAEoLqfqACG+1UsnmY3VFmIXS6T1rQY4YDV
         IiC9H8tWHnnLXT6C3XTp09/6ESQWon9HB1GsuOycZ3aeEZRVBli5zL8crAlyy/dHeR3z
         NmD7CzYBuPZMbVGnacfws9tnZDU0zYj8YIlqX7srIx+Jyb1Y3VjmHBd6c26X1gAtZsGc
         PEJA==
X-Forwarded-Encrypted: i=1; AJvYcCXlfF0+u2uUOQZZ59raGja7a+LnlrZx5IBSnc8VcRGWo2D3cJolc87vb4kqmfg1MlVGHmZka8r3GpJMinELzQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwcZvFE5J0V5kzYdJtVva59RIOKrgjaEZs6Xdd1d9UzMk022aZF
	vBtRY0xfQ5R8V4dFkJw3Q5yUMZ2sVjyHOL8X+741thF+UGMDQE6Ehw0ajMYMkGdfM7U4SPL7Z24
	Ktd2JKFtCJDmizT8epi+EnYVMCQCQARgbnhnLa/WcBskfti/pcXvvaWchSrQ6sPTP
X-Gm-Gg: ASbGncvvjYvATsNfTgBSSDwOTKwTlCJzzSdfcYAHi+yhoTrOf2n4x/zTDESqV9XqWGJ
	FhR5kWmcAjCtLjTkwJC78zhlXX9FjG9LaCtAshLzlF8pLsHaP5bwSjgtIL8qw1TGgVfa+AbP/We
	aoNqW8Ftt9smzronJwuDCYRED6qvJ+NhCGfPsfTnsZRSOKIUm1zQRHTmmY6uUAC8n9gSXQ/aDqS
	xraZ4xD3oXLlQ3O8IY20adZoJIXplIzAciUk59hVDI=
X-Received: by 2002:a05:600c:4748:b0:434:a1d3:a326 with SMTP id 5b1f17b1804b1-436553492e9mr15885215e9.6.1734513506926;
        Wed, 18 Dec 2024 01:18:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzQFTHFw7fnVGsOgmaN2fVP2YDadBMDrQRnfY9WghIfpNZbHV2iytk+s+GOfHa1YGNMY6H+Q==
X-Received: by 2002:a05:600c:4748:b0:434:a1d3:a326 with SMTP id 5b1f17b1804b1-436553492e9mr15884945e9.6.1734513506566;
        Wed, 18 Dec 2024 01:18:26 -0800 (PST)
Received: from redhat.com ([2.52.9.192])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c80470afsm13691223f8f.75.2024.12.18.01.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 01:18:25 -0800 (PST)
Date: Wed, 18 Dec 2024 04:18:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ma Ke <make_ruc2021@163.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	zhangweiping@didichuxing.com, cohuck@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] virtio: fix reference leak in register_virtio_device()
Message-ID: <20241218041403-mutt-send-email-mst@kernel.org>
References: <20241218031201.2968918-1-make_ruc2021@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241218031201.2968918-1-make_ruc2021@163.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZPl28MjW48710yljM3KyfdfvZCA5202F7tNdxzPq9Bc_1734513507
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 18, 2024 at 11:12:01AM +0800, Ma Ke wrote:
> Once device_add(&dev->dev) failed, call put_device() to explicitly
> release dev->dev. Or it could cause double free problem.
> 
> As comment of device_add() says, 'if device_add() succeeds, you should
> call device_del() when you want to get rid of it. If device_add() has
> not succeeded, use only put_device() to drop the reference count'.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: f2b44cde7e16 ("virtio: split device_register into device_initialize and device_add")
> Signed-off-by: Ma Ke <make_ruc2021@163.com>


Did you actually test this, triggering an error,
and with debug options enabled to find double free
and use after free? Which configurations?

Because if you did, you would find for example this
in drivers/virtio/virtio_vdpa.c:

        ret = register_virtio_device(&vd_dev->vdev);
        reg_dev = vd_dev;
        if (ret)
                goto err;

        vdpa_set_drvdata(vdpa, vd_dev);

        return 0;
        
err:    
        if (reg_dev)
                put_device(&vd_dev->vdev.dev);
        else
                kfree(vd_dev);
        return ret;




> ---
> Changes in v2:
> - modified the bug description to make it more clear;
> - changed the Fixes tag.
> ---
>  drivers/virtio/virtio.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index b9095751e43b..ac721b5597e8 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -503,6 +503,7 @@ int register_virtio_device(struct virtio_device *dev)
>  
>  out_of_node_put:
>  	of_node_put(dev->dev.of_node);
> +	put_device(&dev->dev);
>  out_ida_remove:
>  	ida_free(&virtio_index_ida, dev->index);
>  out:
> -- 
> 2.25.1
> 

