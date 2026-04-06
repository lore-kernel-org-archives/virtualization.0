Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F052EB84E
	for <virtualization@lists.linux.dev>; Mon,  6 Apr 2026 09:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775467585; cv=none; b=HQRfn6lo8QiGwnGaySpBNrH8BqKlSKhKBYF+wF/Z/AQ/jRBfoF0QaD9n8sXEQ0JZf5yzyGC6RZlomwLL2Oah7kpNMab5F/ohQETNbqbcu/iMrM9gksx0sgIjGCV4moMjH4YiFqPZ/zA9ZjWnOUMrZn24fO32OdBZYlor/Is1T70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775467585; c=relaxed/simple;
	bh=192CQ4hc+M5khI9m9NzTTc88XPmfxytoOQBY5466R2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=PzYAUMl3u2UgiCFZC7742Awr3gTrr8+Cot6T1Kdqzmnv0JMjf6S4CWHNts7ShHEIihaISiKapFIxMU3wUwi+oI7XJMXfIhKqUvjUZy4q9MoOhjJfNiYvePptEilAN80u4J1kmdpre7sXp0dzWLUHCNzTJdljmbuDu9oTJGHl+SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X79V02qw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X79V02qw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775467583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MqqPtNs3ANYvOJtJzCyDBuh3wrvsgELj1mRcfTFeetk=;
	b=X79V02qwxtYmzPEy3fijQHaHTP8SEm2GlbFIm+Ou5uGzQf+gy/8QfiHM3HToINTRlrD4bv
	AVCDcCRpJAvdR4I2UDa0VoTSBvwYXB3Gydc+7WLldwc8r1yCBpHDLiks/L5NLfyKYZio6N
	reoZrgUi33jjLhbiDoLfhrdJ2b0aJvs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-ioKIM14XOdu_dqdtOCFC-Q-1; Mon, 06 Apr 2026 05:26:22 -0400
X-MC-Unique: ioKIM14XOdu_dqdtOCFC-Q-1
X-Mimecast-MFC-AGG-ID: ioKIM14XOdu_dqdtOCFC-Q_1775467581
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d0de4bfb7so5392877f8f.3
        for <virtualization@lists.linux.dev>; Mon, 06 Apr 2026 02:26:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775467581; x=1776072381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MqqPtNs3ANYvOJtJzCyDBuh3wrvsgELj1mRcfTFeetk=;
        b=jOMaxe0ojCJwDvMe8zo11gRHVap3JbW8/KYfdMaE0+stVpjuB8Cv73W07Y5L0FMpZ0
         f/xgih5iOiBzelicOoj34cga/8jhL51yBp2Tj5asgHJxLVjyuhCiAMK4wqtMv+qsco74
         RC2cTX/81a+z87fved8QKjzpDbWWnCemkACndFarwZG9BFss8Zvs7gSh7VkJt5qoiFt8
         /mTSJQrLGSpmKavNqpQIuuqY1r57BLS4rKwNRrgXSnbl9rp8ZrtbwirWpAsCC+YMLSve
         dOOmSqbgmhRN8EInqyIAC+30SeX5Mpw4wJePHZyyc3joHS6Gq8F/PD19lj8Zjt/ypO5k
         LV0A==
X-Forwarded-Encrypted: i=1; AJvYcCUyj2A+nF0NDKM4nzfCQkJC7nfFUGzoWIylFei6fR3juSYB5HZuEg6fZLSRunBTjpi4y7kozUYiz2bEB9yqGA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwoDRNJqQ6Zk5ZMZTTm8wucVZVanmTvUvOlAwI4UNMpZfWnDFKM
	HwnHaVvyjJSlI6Y2/RnxyH1V48w0vul1i2h3GEaNXG19HMhrfOy+MuY290BtdCQIaKkm4iB0j5G
	tO8dfWqTr4Gr7Vt9ncdILp5sZCGyOjPBlgchMiXfrnrBWD+qOIi0yvJfFXdeNCZGFSgB9bI55rH
	ry
X-Gm-Gg: AeBDievO+YrV4Ue81iGkV4n+KEhfK9F/MImhq57vRoWj4bmvQsnJFjd7EPxUBs77KgD
	qHeBewHxXwz+wq0Gq8phMGZYzm2xjBXkmAbuDAwkkZh2M1jUH5FY4mmjxtu91a3QgSwPnZVJ9qd
	C1aU9pgbKBpb/IFaAz3iTNCB8nBpb5YDNTzZTU0cXMgqUEdM/EM7MDHuqz5VWLDNzbYvDjMMLRI
	XWnYlPVtwREnaokOGBuJ36ER3Fe29S45NemK4X2gVa3UHJIJfLGb9z+cI65RzpEKFaFQ5p46Vs+
	Fs+6IlhGAq8DQ7H9/iuu/4QYt7HwwhZwuo6V7Qnsw/xDslMe+NvkwHUBlJ+x+dQ/gGghgpc07i9
	vCjckWIr4Y+uycYAS
X-Received: by 2002:a05:6000:40da:b0:43c:fc5c:aa0b with SMTP id ffacd0b85a97d-43d292ec960mr16756663f8f.42.1775467580710;
        Mon, 06 Apr 2026 02:26:20 -0700 (PDT)
X-Received: by 2002:a05:6000:40da:b0:43c:fc5c:aa0b with SMTP id ffacd0b85a97d-43d292ec960mr16756634f8f.42.1775467580210;
        Mon, 06 Apr 2026 02:26:20 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1525:da00:3ac2:1a22:72ff:4256])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d214f2b63sm34917992f8f.28.2026.04.06.02.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 02:26:19 -0700 (PDT)
Date: Mon, 6 Apr 2026 05:26:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Clement Amar <clementamar@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: simplify of_node handling in
 virtio_device_of_init
Message-ID: <20260406052552-mutt-send-email-mst@kernel.org>
References: <20260406092159.136447-1-clementamar@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260406092159.136447-1-clementamar@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: p2IVvKbMKtY-IeXBkhTJqwyYW_raE5Hp9FsjhNBmAyw_1775467581
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 06, 2026 at 11:21:59AM +0200, Clement Amar wrote:
> Replace goto with return for simple error
> 
> Signed-off-by: Clement Amar <clementamar@gmail.com>

I don't see the point, sorry.

> ---
>  drivers/virtio/virtio.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 5bdc6b82b..b49113ea8 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -493,16 +493,12 @@ static int virtio_device_of_init(struct virtio_device *dev)
>  	 * Simply don't init of_node in this case.
>  	 */
>  	if (!of_device_is_compatible(np, compat)) {
> -		ret = 0;
> -		goto out;
> +		of_node_put(np);
> +		return 0;
>  	}
>  
>  	dev->dev.of_node = np;
>  	return 0;
> -
> -out:
> -	of_node_put(np);
> -	return ret;
>  }
>  
>  /**
> -- 
> 2.43.0

