Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224EF1D52B
	for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 21:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718831964; cv=none; b=rI4qjEe2JE7kTUBxqF+SIp1Mf81Z88elaA3qpFoumdFArJe00tDeG/u23McBeicTrpVxYYKaYMSJNYo6cj4uaMv2SlcI7EMp/v4G7mzHiCzQeagDnOyLo7EVgIC+DEUpzRI21gZvNNtTvxOT0HAikhiXh0xstmpwShphf3WgKq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718831964; c=relaxed/simple;
	bh=1Ce8gcRoTKYSWpgEWUBkg5anrDwkybwW1A6fHT7RRIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=erByWlPNO7ITpUDT5e/aTBfZYcFdWKsj3y/hd9mckhsjFvNrHOAdaN/QUu6PouNtXQs/QFDqrn2cCAeeigq8uViEU6vrj/gohxPzHUCs6/hKpOdiAWjw6KToY7cGMbiAEownaxqqead1OfsevSyuvqrk3Fuveis+okjNnsFGWiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZJQPZkB3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJQPZkB3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718831962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pyA5CudA7O0PgaW118fS8b02IgMtRvyv3vvcJOCw90A=;
	b=ZJQPZkB3hWEBulARQQpQBWXP+qzqpy3dlN1knLhrnu3iUL/rg26nmR/rYazx6e49b9bhsS
	F7HjmpliL2xfhtCWzS0BAjgN5MWkqU4Ad7A7EqlvgJ0P7OqPO60HL/XLRj+bJoAPEeCLcx
	LaDNAYaCLaTbQa6hchxrOyL6UBPw8cM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-25p0AqJiOyaBwR1ZM3SsRA-1; Wed, 19 Jun 2024 17:19:20 -0400
X-MC-Unique: 25p0AqJiOyaBwR1ZM3SsRA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a6def6e9ef2so125857366b.0
        for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 14:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718831959; x=1719436759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyA5CudA7O0PgaW118fS8b02IgMtRvyv3vvcJOCw90A=;
        b=wgQgr+G1b/sr74inQsOfWRocdf79jYINov1tfzn+ty/DO7exsvMbhqfQrguXacPa5B
         jGuChs4bQBGwrtVnTjps5j3Mwkks3RxDq0JiuHLzwf55fibQsitIs97WDdHBZs7Z0ov4
         FTqFHuxpiYKa/AKz7/9CBskG6qNXAqtJqJNIdYL1ygClER+S5kkBuLUyFyiarGzgg62m
         PnuRlVss1ml12k/waNPFKIZD4MGyE9yOZ5bXfWMbCbBPBWcyEU1jpgzzMcrAFYgiNoks
         Luqg4pkvwz07mjAiiWf9Nq0R4rK5dfvihKF5Isf7wjL3Y+O7nDp6YUg82bSlju9m+0jv
         ANnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbLxveaPiFra0oyRSaapdVHDxKJfZh5zatoN8z3cG2V1t8A3ZU0izasNgru8ap2zNX6UIDLRgFn5zZ88CbZFKUfYUPUzEuoUjrCLMxKmc=
X-Gm-Message-State: AOJu0YwTenUvgnyFcQ5BSYa3SQsu2tYy2GS/5xcZn0oZMP4CBhIks9SZ
	2MlRH5lKIck9AU5oeSXpPNTbWVz+xbjhHYCD/KX+Z9GAO17i4tEEWCNp8hNydPYLUuh3htFyp/i
	INCF9VVFHXduEA1qFK+Fi6yYbgARgyKJkb2iXndOdchy7eF1CjwRyGrwG/93EqCfj
X-Received: by 2002:a17:907:d042:b0:a6f:9550:c0ee with SMTP id a640c23a62f3a-a6fa430f3f1mr279054866b.18.1718831959629;
        Wed, 19 Jun 2024 14:19:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsWpQfosd6XLXCX0/v81p8K+m9L7egl97NzLkFQEGBLzQrVHcJPuTz69VY7zbV8VWIpHPdFQ==
X-Received: by 2002:a17:907:d042:b0:a6f:9550:c0ee with SMTP id a640c23a62f3a-a6fa430f3f1mr279053166b.18.1718831959121;
        Wed, 19 Jun 2024 14:19:19 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f6ac22e57sm562749866b.177.2024.06.19.14.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 14:19:18 -0700 (PDT)
Date: Wed, 19 Jun 2024 17:19:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4 2/5] virtio_net: enable irq for the control vq
Message-ID: <20240619171708-mutt-send-email-mst@kernel.org>
References: <20240619161908.82348-1-hengqi@linux.alibaba.com>
 <20240619161908.82348-3-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240619161908.82348-3-hengqi@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 20, 2024 at 12:19:05AM +0800, Heng Qi wrote:
> @@ -5312,7 +5315,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>  
>  	/* Parameters for control virtqueue, if any */
>  	if (vi->has_cvq) {
> -		callbacks[total_vqs - 1] = NULL;
> +		callbacks[total_vqs - 1] = virtnet_cvq_done;
>  		names[total_vqs - 1] = "control";
>  	}
>  

If the # of MSIX vectors is exactly for data path VQs,
this will cause irq sharing between VQs which will degrade
performance significantly.

So no, you can not just do it unconditionally.

The correct fix probably requires virtio core/API extensions.

-- 
MST

