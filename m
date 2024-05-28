Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3320516D4E5
	for <virtualization@lists.linux.dev>; Tue, 28 May 2024 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716911199; cv=none; b=gJfyS2HR7b1/pnLjkbtB0k7jXfrjZwXu96hTb8EEEIDCNmjME/lnYCNvmKvonVegwry8jz1P6Q6J5lBueb5ChNv46I2Pw02Qp7NYnjC53Nv4bgtg38hB03O02WesRfOMncd8+5pe8lqsMkKmwFDI8gafCvEsLYGm4ZJjkcCF0Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716911199; c=relaxed/simple;
	bh=BBfWRtPKds2pzdydFqFBEcxuE06/q5m+4KF1Ene+vTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IJy1UtPUblSZJ1r78n5+vM+vRYOlEd25kbPUjm+AimnTJ94diRx6/JEMmiIE68SYPXyBmWIEDLV0WKOMkzs9AvH/+ygqLk0nxOEqFXTn8gu4WYvhvom8Hl0a0zO9aCVclUVWneGnWpXzbVtHANeA8EqBjZ/C/UNDl9VUrAj3cwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NuzrzrYR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NuzrzrYR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716911197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tD89fcMVEPyzDouOycEHqVw3lxLpSHxt2pMLaCqM9uY=;
	b=NuzrzrYRMWCSPV7BTSHX4TILph6YZ7RQfpxH4rW8NQ3OLCP4yf8nxTHags+sLGjsB5FVcD
	MU2+wa5sS/rAy1PfjB1WKmb7TWC3CAMLhFQo8Qd0PpkkNsKtGW7dHfb1XTudE2j8DVe5yh
	trtHpYwpMP+NFsVN9Vv0BP5gVl/GslQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447--Z3Sw3eCNlupnfa7RPitBA-1; Tue, 28 May 2024 11:46:35 -0400
X-MC-Unique: -Z3Sw3eCNlupnfa7RPitBA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2e734caac3bso6979521fa.3
        for <virtualization@lists.linux.dev>; Tue, 28 May 2024 08:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716911194; x=1717515994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tD89fcMVEPyzDouOycEHqVw3lxLpSHxt2pMLaCqM9uY=;
        b=noIwwOl85aFGu0BeVvm3zjkjoMIiA4S7t7OyKLA7HTsF3FBEEsB7rUTpo7otk/xh8J
         kIX04KzHUvFXjdEsGH8mwtV7yps+o4/egIdrot4h3kD58faYI+Cdm7IWSgjpUIw3/Z1z
         86Hijy54iTOYeQoXvbIE/QxMLQc0xhvPbo391kCkbkvxLKRdqKCCBM8bEb92sI0UwTmj
         si7VZYFSdCBWMt5OxGST7Cx6SMso9CP7n3Ofju1BlLt6J90kwB5zvzintp6YKY2/OWKX
         Q0puvHQBkZI7sNr2GoB6TazlR0HTTDd2h4zIdZx15w9mD/roGzkZxzsjRObffV8s/9R7
         gAmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXG4J5HG/NqJPPfOrUAqTl6SwxRVn49PFn9le/cEx7hxRHY32wmxwF4LOxoZJfju3A4PtVlr2zvLSdDDchNZBYgA3U8QfBxOnUCpaka8IE=
X-Gm-Message-State: AOJu0YyhqGt0LcskGI/cOqld2pAgZk+Q2ZeCYcg4odXtsK5ysJBqv7/8
	r/Rx76gGQZwNpyAmoQNA02IHEx6VqcwB2M7ZzO6NbwQt0r636JReFnqITUcPWTaJsUBlGcixb6V
	mvd4OCh3kwaMdfLz6AUrKlkV43b8Asl6sp2yabIn/5jKOsf//GMleS6jG9DSm1hp6
X-Received: by 2002:a2e:7d07:0:b0:2e1:ebec:1ded with SMTP id 38308e7fff4ca-2e95b0c0445mr70685171fa.25.1716911194265;
        Tue, 28 May 2024 08:46:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHoLO75bzkTh8Lpq4uxRpD+x0FYLdIBHOsi1XfbjLF0lJVBM82jLbAW9IQ1SZ2hkA2UP3z5g==
X-Received: by 2002:a2e:7d07:0:b0:2e1:ebec:1ded with SMTP id 38308e7fff4ca-2e95b0c0445mr70684151fa.25.1716911193571;
        Tue, 28 May 2024 08:46:33 -0700 (PDT)
Received: from redhat.com ([2.55.190.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100fad6ccsm179659745e9.32.2024.05.28.08.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 08:46:32 -0700 (PDT)
Date: Tue, 28 May 2024 11:46:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Daniel Jurgens <danielj@nvidia.com>
Subject: Re: [PATCH net 2/2] virtio_net: fix missing lock protection on
 control_buf access
Message-ID: <20240528114547-mutt-send-email-mst@kernel.org>
References: <20240528075226.94255-1-hengqi@linux.alibaba.com>
 <20240528075226.94255-3-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240528075226.94255-3-hengqi@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 28, 2024 at 03:52:26PM +0800, Heng Qi wrote:
> Refactored the handling of control_buf to be within the cvq_lock
> critical section, mitigating race conditions between reading device
> responses and new command submissions.
> 
> Fixes: 6f45ab3e0409 ("virtio_net: Add a lock for the command VQ.")
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>


I don't get what does this change. status can change immediately
after you drop the mutex, can it not? what exactly is the
race conditions you are worried about?

> ---
>  drivers/net/virtio_net.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 6b0512a628e0..3d8407d9e3d2 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2686,6 +2686,7 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
>  {
>  	struct scatterlist *sgs[5], hdr, stat;
>  	u32 out_num = 0, tmp, in_num = 0;
> +	bool ret;
>  	int err;
>  
>  	/* Caller should know better */
> @@ -2731,8 +2732,9 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
>  	}
>  
>  unlock:
> +	ret = vi->ctrl->status == VIRTIO_NET_OK;
>  	mutex_unlock(&vi->cvq_lock);
> -	return vi->ctrl->status == VIRTIO_NET_OK;
> +	return ret;
>  }
>  
>  static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
> -- 
> 2.32.0.3.g01195cf9f

