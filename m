Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC10439F9F
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 21:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785878587; cv=none; b=KoIkP8zEVHHQXIdC/vvGCdz39FBzrSdBIU5K0As27TLwrbL5bcCaH4ZeX02XKI50eF82lVw8Pd8MP45a9jVqDaC8Uw6hDFUdZZDR0JQbwcVT8Wq4cPRtRciVSWEKW+qZ0XezpoA4Gjvp79BLjrLadzoQDAGYA/Us9YPPlXkcwPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785878587; c=relaxed/simple;
	bh=MuiEg9wanhQYi6utuDkaViH6kGx3NTrf8+035iX5pB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=piXOGJ8D1MbxJz5RVmxz7HzDLTAnKYZQiepdNpnp4hNzE39KzZXwKcssKLjnxNVVXHhgyoXvBkEiDbYhLfS5Uq4rzLLEhB/x03iWOLEIcmkcWEW6jDx9NhyIEJoV69tyxgGza/uqZnSxQF5Jn9kKXY+ps8gbjNOh7ZZNNhD1b6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fxwUrX7N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fxwUrX7N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785878584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mGRg7FrOnjzxfTeNQiRd91leYz4HQZQa6zj2yMXk614=;
	b=fxwUrX7NbJYKUT7s/T7zaN1xgbNpsmDBAmliQyc8eeNlpOP9tWQT0Nec8fqbdbjk15Tc3B
	tHU+Zv6CQY9YzkIJwbaPIp7N30X6OuaZxgmVOltzjeAYTX+NimVwSt5BtMesV8XrdYNETd
	Y67hg/eybDpgbcm8BKi1nVDKJKLxoQo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-AL9Zv0JcOZucD0wmsBuz7Q-1; Tue, 04 Aug 2026 17:23:03 -0400
X-MC-Unique: AL9Zv0JcOZucD0wmsBuz7Q-1
X-Mimecast-MFC-AGG-ID: AL9Zv0JcOZucD0wmsBuz7Q_1785878582
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-495474a5fbcso2209105e9.1
        for <virtualization@lists.linux.dev>; Tue, 04 Aug 2026 14:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785878582; x=1786483382;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mGRg7FrOnjzxfTeNQiRd91leYz4HQZQa6zj2yMXk614=;
        b=iLs7EvusiYBtRXun9LWI9zwWVQMlIB3QnGAo0ZoO4vjP2Xg8xaw648nvMx0QWAYBB3
         giN3c34ACp2bBB0FGxDx0Z4MmDUuvRwwYTWGvmUb3C3zSnschjyckvQ1gIEqBA6HyMOv
         6FhHbKzTiplWu0IQTpfDjOwOtxPY6RZSp8Y67wnqg3raLmTeM2mxw6hjTnhb9MLrNB9Y
         izZPCMiYCDe9+SAarVLho4Uq+XphHAFT+lWnmem2h87QYrwwrOkLoG3GfZv60B2qCFdY
         d1z8WWS14yGqmcQsQYy51YT9dFGxOmyh15zrStDI2sKFf3Q6ZTxOAef0/56FkF4PiRNz
         biVw==
X-Forwarded-Encrypted: i=1; AHgh+Rq94vr6LHiVXSN76rjHf8o9wGO7R2sxRyt+uHqYXWy51duka18YOEUn3IO+rwdmUrIeme62rH3eWBVKicOm1Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEREx0pWQ0c0vIV/3sVY9GwgqB90NRKY0E/cioGsLyYvazodbm
	pqI5MoQTKOjVZ/WQk6v53+lizeLtwyVA5cekyVG0p27VlvfRLWaoszG1A/tJUDoUcnEiGfREp1t
	3UG3l4vm9t/iYOgJT3fe9HLHKn/T8CZ9mpuJrvuPARTZTiUWJf8PG1lS+mYXmJ/j/iS2q
X-Gm-Gg: AR+sD12qKc3/yEwlZ5QUyRkYkC9s1nn9F1CWqglZr6NqkxWzbuBXEQKU6yViAdZI9ue
	iELczg4F3mImSZ5AAEqEraXR5b2BUZkElTKSNC7XIgJKmd0esZ36uojsx6of2V+Wh07UIwMZouU
	T2HZtiVl777JiT+qwK+xq8Z2NIjthYveCS4y1U6XzoHXMRN/muLKEeFrXFdEjabVODyYH7LHnMe
	vaZHwfOW92eNiZZ69EgPrfKl6ILesT/MFc5qCQQkk2mNk6RhvyvUuMEVEMFtXwUA2mFaP1HC6rc
	V6FFhoQr5ysc+VQHO/h6x0lQ5AM9nAkJ2863DdZEFEgwpyDMDyJ4Xy/drHzqOCTqNohA61JGRJc
	g6roR6cUBXOLyGStbNm2gvQ==
X-Received: by 2002:a05:600c:8b23:b0:495:4d00:2fc0 with SMTP id 5b1f17b1804b1-4994e7bb12dmr12639425e9.12.1785878581702;
        Tue, 04 Aug 2026 14:23:01 -0700 (PDT)
X-Received: by 2002:a05:600c:8b23:b0:495:4d00:2fc0 with SMTP id 5b1f17b1804b1-4994e7bb12dmr12638885e9.12.1785878581251;
        Tue, 04 Aug 2026 14:23:01 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949f68f95sm138651955e9.0.2026.08.04.14.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 14:22:59 -0700 (PDT)
Date: Tue, 4 Aug 2026 17:22:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xiong Weimin <xiongweimin@kylinos.cn>
Cc: Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio-vdpa: Use queue id when setting vq affinity
Message-ID: <20260804172230-mutt-send-email-mst@kernel.org>
References: <20260804092649.1344478-1-xiongweimin@kylinos.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260804092649.1344478-1-xiongweimin@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6vg3SEGb7XaUZXd64jj6NEtawsIEPxiVxPCM1HkBw7o_1785878582
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 04, 2026 at 05:26:49PM +0800, Xiong Weimin wrote:
> When optional queues are skipped, pass the compressed vDPA queue id to
> set_vq_affinity() so affinity is applied to the queue that was actually
> created.
> 
> Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>


explain what the problem is please. don't just hint.


> ---
>  drivers/virtio/virtio_vdpa.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index de2af696d..6bcf4567a 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -352,7 +352,7 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>  			continue;
>  		}
>  
> -		vqs[i] = virtio_vdpa_setup_vq(vdev, queue_idx++, vqi->callback,
> +		vqs[i] = virtio_vdpa_setup_vq(vdev, queue_idx, vqi->callback,
>  					      vqi->name, vqi->ctx);
>  		if (IS_ERR(vqs[i])) {
>  			err = PTR_ERR(vqs[i]);
> @@ -360,7 +360,8 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>  		}
>  
>  		if (has_affinity)
> -			ops->set_vq_affinity(vdpa, i, &masks[i]);
> +			ops->set_vq_affinity(vdpa, queue_idx, &masks[i]);
> +		queue_idx++;
>  	}
>  
>  	cb.callback = virtio_vdpa_config_cb;
> -- 
> 2.43.0

