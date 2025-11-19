Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA764330B03
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 09:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763542922; cv=none; b=ZOavTTHZnKVkAzidTSXoNmLzyr684i33NptI82SkNd9lsF5QGUkzGtblBiVq4bIKOoe3dMj7X90pGAzOD+S8zi4qg/IzP4AzArgGMn1O5Zh147GwhsGkskbI3bgiySTcshXDUWY/LDiDIUgk0nVpU8nFTlrkMwxnNO8SqH+ZWco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763542922; c=relaxed/simple;
	bh=VGU4QRUO7tcjHFdgZ+nHt0HxE/FdqAYY5WJX1HtZVac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=byJdTensVBlsfZNBRbYgOe0CGpxDvP5fyw4YlPnH/XQj8BS+6XE9MQGdmZkc1s+SYEMDECasulWkz1SJrUJ/PIgeQ6AWV/TGGFHy2vQkru4BF9w+b0RZ3+qanOjUGApuBA6h3UcnLbpHK17ABMp0jQNknsG79cJg5ELLTYjFlvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V+6gpxI5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V+6gpxI5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763542918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OT/rflnGD4jHalNS1sxjnUWeBFWffn/nuDxbFQiIS2E=;
	b=V+6gpxI5Q6w27HkdUuH+pX60HvquzXvjK9MElYsDSm72LsjRDVMGEWmn7kVEaVkZ+wDTvZ
	lozKoAWU3K3PEQ9KdeJQ10dwKw1PHWOOkBCFgxnuw6VEyL6n63u78H+Phun4v1uexnmNNE
	E1Ptd2WgRE51Gmw9lVh52dBG53rUvE0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-tog5WUYhMXSNDBBL53ojoA-1; Wed, 19 Nov 2025 04:01:57 -0500
X-MC-Unique: tog5WUYhMXSNDBBL53ojoA-1
X-Mimecast-MFC-AGG-ID: tog5WUYhMXSNDBBL53ojoA_1763542916
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42b5556d80bso4612802f8f.2
        for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 01:01:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763542916; x=1764147716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OT/rflnGD4jHalNS1sxjnUWeBFWffn/nuDxbFQiIS2E=;
        b=LHSnLAIZvQ+OCVXGWdg9ChcLWn/m5VJKvZaSN1iJAIpj8UzrTrNLNa+Xw8U5h9kYiw
         MQ5BZIYl5QuQvjT0ncalMkUYj5qoCkmhSxe+a1p13pklwXH6VVe693q/mGW13tSuQYtk
         ypZGcMoienIzJcIAzgyRMEaTcEv/7Jpj+g20PJxQ/iN3Xi6vT3vRMB2UJODpNZ3v0wRJ
         /S8/MKC1y1xiKapHo03PIigBA1znUXUbvb3YPZ3mLt12ynPQkpwdjOypcB7w/eC99AD1
         DbdwiqVeSxBFWs6mOlPBwqTWFLHOYqCqKc3GIyNU3A/BPcZIuevFhr8moWZBhTzs8lP1
         0KwA==
X-Forwarded-Encrypted: i=1; AJvYcCU3p5cjZ61HsUwjQEnJB9QWgJFubSmh4o91cXHPWS8n1K0ZWsOJjL5tToG3ydY/nYOgqyMGL1uyDcPEpAnxiA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2yXxmMIkA0jnrvTxsStsxM6wavAFYBF/sFJq94mPLwHMK/HtK
	SC6dP25VbQYeI0FhpjMo4NFxzMvC2kAU2yuuGTAbqLU8c3sE1FazfMVDCLvcF6/0G9hCzaRLArc
	kKJkNNSJKZ5P8ucif3vrpgrt0oSRdu91s78lb0aN1iEJaf3YRyWF5mLnleGka16hk5BMe
X-Gm-Gg: ASbGncsvtBq/XPb0H2XUpVRZ7GHhO+qam/xvIbZCpuDn96yDTa01cBk8xgSgc8EfTTk
	bpzDwzki/SRdvpqiP7OrEMpEucmaq/jSNNdssvNemxd4Vz/fWb5Ec4JMQjM7lw9JSXR6T2MkCCb
	d3WNUvt/t3rqo28vChaOiUlXswpsWRpqeWqAbbX30EszZYnNNf+4/XBWT7vVbEDDVrpnFvJ9qVN
	op/Uup12tNLJEz2zHYfOqJ6yN5btwieNaJUBDxzVDw+l8KAld5mmDTTaL5o/F4RrLrSRgm0Yeqf
	tSFULij1Aw2a1YaYRWsfatGuCW9oYDdAXFy+OMjtwLCkyFlpaNqtb4uSKrCrNLd23SC8qhWXaw6
	E6upIlTq0Wm2ChFREWXdYxJSM+m51VA==
X-Received: by 2002:a05:6000:2001:b0:42b:4247:b07e with SMTP id ffacd0b85a97d-42b5934b278mr20025973f8f.25.1763542916181;
        Wed, 19 Nov 2025 01:01:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxqSjRc606HQPYSuwRei/TlibJFpVfltszgkpJzG1O/Vry2+3uLQ41MDE1dXj3mXKLydFfyA==
X-Received: by 2002:a05:6000:2001:b0:42b:4247:b07e with SMTP id ffacd0b85a97d-42b5934b278mr20025921f8f.25.1763542915714;
        Wed, 19 Nov 2025 01:01:55 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b8a0sm37444435f8f.25.2025.11.19.01.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 01:01:55 -0800 (PST)
Date: Wed, 19 Nov 2025 04:01:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 08/12] virtio_net: Use existing classifier
 if possible
Message-ID: <20251119035943-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-9-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251118143903.958844-9-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0ixEUz3NPwUV7NetRcbo9VDeckg8JWWLyf-uR5OyxQE_1763542916
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 18, 2025 at 08:38:58AM -0600, Daniel Jurgens wrote:
> Classifiers can be used by more than one rule. If there is an existing
> classifier, use it instead of creating a new one.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
> v4:
>     - Fixed typo in commit message
>     - for (int -> for (
> 
> v8:
>     - Removed unused num_classifiers. Jason Wang
> ---
>  drivers/net/virtio_net.c | 40 +++++++++++++++++++++++++++-------------
>  1 file changed, 27 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index de1a23c71449..f392ea30f2c7 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -299,7 +299,6 @@ struct virtnet_ff {
>  	struct virtio_net_ff_cap_mask_data *ff_mask;
>  	struct virtio_net_ff_actions *ff_actions;
>  	struct xarray classifiers;
> -	int num_classifiers;
>  	struct virtnet_ethtool_ff ethtool;
>  };
>  
> @@ -6827,6 +6826,7 @@ struct virtnet_ethtool_rule {
>  /* The classifier struct must be the last field in this struct */
>  struct virtnet_classifier {
>  	size_t size;
> +	refcount_t refcount;
>  	u32 id;
>  	struct virtio_net_resource_obj_ff_classifier classifier;
>  };


BTW if you are going to use refcount_t you should include
refcount.h not rely on some other header to pull it in for you.

-- 
MST

