Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9513C18396B
	for <virtualization@lists.linux.dev>; Thu, 30 May 2024 09:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717060647; cv=none; b=eClaq6Y8fWQLaF7gIzY2ygjGvjvwyJt9umZgkurHAv1jbD16cH4rmMVT0eR5j9mXcvIDa/hTXQxUQkWcG33ybyTgZqrZYloURF+st39CFjNJVWHH0RbVL5eFyvK8kOgWqHZRK4GJwd4qMDEECIRYncWUicrPXv2/Kd7vYlbNRFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717060647; c=relaxed/simple;
	bh=eCjZ8iPR0gePB3DWkGaXrIHfnAGJITyGfXj0aAhawR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=FGZ5rqPW+FnlcM0WUIIxA/2mNF5rSyjlQXYFnkMjhk690fHXOtDdTo/tW7jVIPeEs6asBU3WkjJdUzmRlR8gMDt1lICTTNJAIzgZR+tr4iD5udYiuiS+SLjHeeJClitB+IPuF+MU7EI611a+SyGan3AR/W38ZcnHYWnYYS6y7fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eD6caFar; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eD6caFar"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717060644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OrOhFD1O2QLtQkci+Xy+Xp8cmUEIquXNNePUgb7FIXg=;
	b=eD6caFarGJu7I4lS1BP1kp0MQlY+bpw9KwrfK+mKPxMqcXfE0unSRAoICJDPDzuKu6wlRX
	8uouy+RCke0d3GdJnkwOp4mueZ+XkI33bARloZgbGrulPRNAmu72TWna24We8sYssRXbBT
	LfN6OVmT4fXFJm7D1TYMaBCUlLyi7pA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-quLyy39kN1CGRc8MMdQRjw-1; Thu, 30 May 2024 05:17:23 -0400
X-MC-Unique: quLyy39kN1CGRc8MMdQRjw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5234e83c4a6so482339e87.0
        for <virtualization@lists.linux.dev>; Thu, 30 May 2024 02:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717060639; x=1717665439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OrOhFD1O2QLtQkci+Xy+Xp8cmUEIquXNNePUgb7FIXg=;
        b=tZMHilL8dVbzcBu1GwW5YlNT2/55kytx09mvF5VcIfoja3KcoF1ZelfFTPe48dL4OK
         G8QTYtw5AYg/PSsQ7WYl3sKq5LxSp8MJJSVOXoXzGW4Maqy1xMhVeI+/2vTmokIu1cIu
         BIGY7rMFPRJqEjHwnwCeh7pJGHawpfknCnmxvBWZWJN+K/V+xC+qP5QvIgmZoun5HdH/
         yRqFUMmxawgRip7n+CBWmaaoa+wzcaAnJOGUcYkrtN+C6ZRcL0FRXoerG8PNLxiTebHg
         ahljrOpuQly/2h5U0/ZDM/QUz6Vw/VAet7/rJpFqwQBbOlM1bWNKP5M9IjBH+pL8sXj+
         gh4A==
X-Forwarded-Encrypted: i=1; AJvYcCXvn82J2u+QHYgOKIKwGDP5GY76Cohwcov09yvp4CsfnZZ0KLFYcjFjoQcFnDT9eYALFS1+XtRLcZF+B9NLoDCpl+W+3Bxck8Nd79mcx5c=
X-Gm-Message-State: AOJu0YzDOLUTdDsc+Bft6C0Ru62pIX7iFea4cPuv78XBp/TUCyF84oie
	pQcQM8zeYui1TP9qsXhU6UWSA7lxgY2zogN611SE3K2eyRk2P3uZOE/XfK3xCKBtkRH7yrPIaCz
	vIw3/U6qEBlai/Cp6a9s65sIpZq9yxrZOSkjH4mwMKAISY+UtzAzRKCT1KK3n0xVE
X-Received: by 2002:ac2:43d3:0:b0:523:91d1:12b2 with SMTP id 2adb3069b0e04-52b7d417fa5mr936466e87.6.1717060639263;
        Thu, 30 May 2024 02:17:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjFauER2nKzlXi7PQA0lj1JP6X1POmUioG5dsP6556DuIVQ6ua4CC0ROYuYqAI0GinJHxrhg==
X-Received: by 2002:ac2:43d3:0:b0:523:91d1:12b2 with SMTP id 2adb3069b0e04-52b7d417fa5mr936433e87.6.1717060638625;
        Thu, 30 May 2024 02:17:18 -0700 (PDT)
Received: from redhat.com ([2a02:14f:179:fb20:c957:3427:ac94:f0a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421270aeb18sm18992555e9.48.2024.05.30.02.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 02:17:18 -0700 (PDT)
Date: Thu, 30 May 2024 05:17:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Daniel Jurgens <danielj@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net v3 1/2] virtio_net: fix possible dim status
 unrecoverable
Message-ID: <20240530051705-mutt-send-email-mst@kernel.org>
References: <20240528134116.117426-1-hengqi@linux.alibaba.com>
 <20240528134116.117426-2-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240528134116.117426-2-hengqi@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 28, 2024 at 09:41:15PM +0800, Heng Qi wrote:
> When the dim worker is scheduled, if it no longer needs to issue
> commands, dim may not be able to return to the working state later.
> 
> For example, the following single queue scenario:
>   1. The dim worker of rxq0 is scheduled, and the dim status is
>      changed to DIM_APPLY_NEW_PROFILE;
>   2. dim is disabled or parameters have not been modified;
>   3. virtnet_rx_dim_work exits directly;
> 
> Then, even if net_dim is invoked again, it cannot work because the
> state is not restored to DIM_START_MEASURE.
> 
> Fixes: 6208799553a8 ("virtio-net: support rx netdim")
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 4a802c0ea2cb..4f828a9e5889 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4417,9 +4417,9 @@ static void virtnet_rx_dim_work(struct work_struct *work)
>  		if (err)
>  			pr_debug("%s: Failed to send dim parameters on rxq%d\n",
>  				 dev->name, qnum);
> -		dim->state = DIM_START_MEASURE;
>  	}
>  out:
> +	dim->state = DIM_START_MEASURE;
>  	mutex_unlock(&rq->dim_lock);
>  }
>  
> -- 
> 2.32.0.3.g01195cf9f

