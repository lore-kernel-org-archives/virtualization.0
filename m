Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A5A7E59A
	for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 11:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228668; cv=none; b=Zp+V8m4ewwnZWE4orPoaqzm8/uGT+aU76+K/TuiYVe8x/aUtBN4Ue+Yu0RVQ3ioz9Xl7f/4uZmn354wD4Szqxnidj8QtAxlEeS2qc/5PNQqLSQSa7gu7mXlSJGXRfk7FkN/gz5erAWrL31ePr1JmYbDcBFiVzcShz7l47skjl3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228668; c=relaxed/simple;
	bh=2MMWKn18m+VDECLmv1RUa5PZYVUz48wy6CSEVb7G3eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=W/mmBtXP/C1GTdA6CPHkAYBlGAjzIgMXxd47Hsm9kbzwV789dYQV6jmR3m5PEIU4ZZLUT9X4j+HEqMJYYoPYg3vFhwIvzX3FiaXrMmNlrjbIKLLEb0RYsknChS/0Db8huICtqxOh0Y9mKeRrHrKaQE33vZYbdCJuc/chR+rGEHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f1NagM+c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f1NagM+c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719228663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B0hg8oljf2yX+wR8zqLOyjWPdm4DCBW1kliHhG2gJ1A=;
	b=f1NagM+cYarYbSeYklZUiV9+e3vAsCzsm9WuyQIF7taP/0nW2JQLsUsr5nFyo87Ozt17cC
	jyW0Y5ZZ8G5MlPpID6XUT5aXeJePZRMSm2ONDcalLuJ7scu7rUfr3+zAKprzEEuYgha6cJ
	pjmYMJrmK8nOQ2jmmwknNx7nXI+Oi+I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-iLfwoiUvOUO7MKhC9HfdNw-1; Mon, 24 Jun 2024 07:31:02 -0400
X-MC-Unique: iLfwoiUvOUO7MKhC9HfdNw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4248fa5daacso6359745e9.0
        for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 04:31:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719228660; x=1719833460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0hg8oljf2yX+wR8zqLOyjWPdm4DCBW1kliHhG2gJ1A=;
        b=KOSyMtNfZCPvQdYsZ4d2mDyWpetkn1Q6ppTFo/TuX/ua5fAnCIEkxegGv8g1Jm3peM
         +cqTNbPGzYOc8O9M1/j0HVue98Mr+v7CKY3kGzX9umMVREWPhj6n14I9zbmCr6b/fD1k
         xsZXszhXG6R1h9CaZPRRLmamDHeyEysg2R/KMHN6ma+smHGj6kWjfLvk43XpZraY6pO/
         snYyrmwbFbUrALleWj6lF/zOdCBlqX7+VLwPxo80HKZ1ZoX8pRFqqBJCJwn7JkzOTDbP
         IWaICE9INKYXbmNfNZz+POt4nzQpdycnxldLiZZka7iXd7vrZw5P1imypohs14hK52yY
         aTQQ==
X-Gm-Message-State: AOJu0YzziCLhmTx6MUalvqtzmFknMthqgP4M8GtT6Y73UYx8PGwT23hS
	6yf5uQyTnqJo3tx79pVEy9TtphVO2S0QQzfGD6MDRDsJDv8bZXFnoEKDOXhR8qjHAEqS5RdlaqM
	Raz0GQFiUIp7QDbsPqCRH6YqfR/bUGBVPkF0Dqoywpn+F8ZL638nS5vMrs/2ckMcOW4EoeG44+F
	U=
X-Received: by 2002:a05:600c:4d24:b0:421:aace:7aa9 with SMTP id 5b1f17b1804b1-4248cc271d6mr24576795e9.9.1719228659745;
        Mon, 24 Jun 2024 04:30:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0QpsKvaNqDImA3rEtzDmRaYrmLltWzFAviQ0NOZT+N0OVAJ9249VDTA8qrgd+cnOgNXmLuA==
X-Received: by 2002:a05:600c:4d24:b0:421:aace:7aa9 with SMTP id 5b1f17b1804b1-4248cc271d6mr24576645e9.9.1719228659131;
        Mon, 24 Jun 2024 04:30:59 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424817b5549sm136148025e9.23.2024.06.24.04.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 04:30:58 -0700 (PDT)
Date: Mon, 24 Jun 2024 07:30:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, parav@nvidia.com,
	feliu@nvidia.com, Heng Qi <hengqi@linux.alibaba.com>
Subject: Re: [PATCH virtio 7/8] virtio_pci_modern: use completion instead of
 busy loop to wait on admin cmd result
Message-ID: <20240624072340-mutt-send-email-mst@kernel.org>
References: <20240624090451.2683976-1-jiri@resnulli.us>
 <20240624090451.2683976-8-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240624090451.2683976-8-jiri@resnulli.us>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 24, 2024 at 11:04:50AM +0200, Jiri Pirko wrote:
> @@ -73,21 +91,30 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_device *vp_dev,
>  	    !((1ULL << opcode) & admin_vq->supported_cmds))
>  		return -EOPNOTSUPP;
>  
> -	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
> -	if (ret < 0)
> -		return -EIO;
> -
> -	if (unlikely(!virtqueue_kick(vq)))
> -		return -EIO;
> +	init_completion(&cmd->completion);
>  
> -	while (!virtqueue_get_buf(vq, &len) &&
> -	       !virtqueue_is_broken(vq))
> -		cpu_relax();
> +again:
> +	spin_lock_irqsave(&admin_vq->lock, flags);
> +	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
> +	if (ret < 0) {
> +		if (ret == -ENOSPC) {
> +			spin_unlock_irqrestore(&admin_vq->lock, flags);
> +			cpu_relax();
> +			goto again;
> +		}
> +		goto unlock_err;
> +	}
> +	if (WARN_ON_ONCE(!virtqueue_kick(vq)))
> +		goto unlock_err;
> +	spin_unlock_irqrestore(&admin_vq->lock, flags);
>  
> -	if (virtqueue_is_broken(vq))
> -		return -EIO;
> +	wait_for_completion(&cmd->completion);
>  
>  	return 0;
> +
> +unlock_err:
> +	spin_unlock_irqrestore(&admin_vq->lock, flags);
> +	return -EIO;
>  }
>  


The reason we had the virtqueue_is_broken check previously,
is because this way surprise removal works: it happens to set
vq broken flag on all vqs.


So if you are changing that to a completion, I think surprise
removal needs to trigger a callback so the completion
can be signalled.

I think the cvq work also needs this, BTW.




-- 
MST

