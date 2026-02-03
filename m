Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C142F39C2
	for <virtualization@lists.linux.dev>; Tue,  3 Feb 2026 09:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770109386; cv=none; b=uz8t9JME2z0HayaFlnbAxa2L5BgYRmzs/I/D74GDJgEvp6T+0TPufcYwkFj16ucP2C8bTbsVf4aM0M/HxwOkWkhOqvRa5FhxLLVwW+0n7i0xyJPLu9Ws4B2o7FsKNiuQTEszVEGtwIEongO4cC6B1q1xfrm8TIKfoAd4m4FDeGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770109386; c=relaxed/simple;
	bh=ey7g09tmHjrHthyWzQN5oKiXS3ZjDFHwb12bh0pLlOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cNZiARgohvcO0G4j8Laf5SBmG/ZkSt7upaC5hDSIZOK2PnL9L46LtRSuvryk0NygR8B1FmK0kKmCFZdUvp5mlJlMU8xudcynpJ2Y7pf1QMWpKqAy+1uQrgXbjyOyt+Ukzdl9TXuhm2d6Gi0q1ciuEWzLZ6vVrfC86LZyFfpFj7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OoknCRS2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OoknCRS2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770109384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=omsa6WLS8Wo1EZoK0PAaA8UmJG221+tHcswjEXaWc9c=;
	b=OoknCRS24bxhUDEvQuot4JtvFHxXAkDla1uSHjfVTDtdZeqkPS8okRYbWeBZeJIIDcqOyY
	pyKV+u4HDgiTMUSZ3pvdivt62qqQedv5ow1x11qNKmtIqKTuZ/HzbNaiqCp9ZpkeWzPtnj
	TrJBERjxm0Y3UZyfFxzUF9nK5ma6Zpo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-AqI_tSuIMhW9w84CJsFyoQ-1; Tue, 03 Feb 2026 04:03:01 -0500
X-MC-Unique: AqI_tSuIMhW9w84CJsFyoQ-1
X-Mimecast-MFC-AGG-ID: AqI_tSuIMhW9w84CJsFyoQ_1770109380
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4802bb29400so67487615e9.0
        for <virtualization@lists.linux.dev>; Tue, 03 Feb 2026 01:03:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770109380; x=1770714180;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=omsa6WLS8Wo1EZoK0PAaA8UmJG221+tHcswjEXaWc9c=;
        b=HJzH2SeoVN3UrN44TSP8fl1QIsPUmuHk9THOuittgm7+WgP+kUBwlFwQi9Njp7oVr6
         DkJKDhm5q7Hfg5KhaE0zEmlVcHQEim8DTR0MlC01i++w9SOcyDalVlyzBAqvF27pZac7
         /58uKSLHXbEQay7XvcLg4KMhzePurg6KVimVbiHYxkM/aTdeNDgSGrcfLO1g5NIDJkx2
         QKch3NG8TsaddyEwDqDc2VkgzcIrMjgslPzhuSxvx+EJY4FGGEVmRofSrNaIi/JZiOuC
         EGtkUsDM2YYT+hWBESZiX3OEOK6RKCRgwsPnr20jB172dRVzK3X1yE+Eaale66BKe6Dt
         5feQ==
X-Gm-Message-State: AOJu0YzIu3Pt3eFFNXsSeXlPR5yAu+1hgyvb3iuMU6kGLjHYP4+gOo7P
	yUqWNU3ezce42n32s0OrsYWUoesiO6AtZAV1GEm4WIOGogiSeHzSKf4kWA7K32ZZJQLQCpRH54V
	pvFhnkG2I5eKjnRBascj6eWOyWY9xodvNzSbp6Ng6Ejp1Ar9U+0OKeKJXfRw/PzGb0JPv
X-Gm-Gg: AZuq6aJO7a6OVJ+2dACXQIq/GL/OF2vRKlJ4PHYJ05eJV8LzWKJlz/BYnAHplggIeeb
	faGHtau/RJa77QmEi1Ta2sdVpNTpZyAAGNIdAiqprldJ/SQ7MG9EmlIck9wz+BD2Ttf0p3QKkRy
	AWvsGnQdZFmyWIJiQTvYlMexcQvHPwVZmXHTlPUOKcw/UPArI2tbdUGie9mftAPNVW+eh25T+o8
	ZeYPjmSYQyNGnbx6mVWO2fVokkTXsuGo3AdWJ7hn74dquvAcscp4dNp6Ugxkt7tNuipHsndz21d
	vPV9yS0bEWiIQBCnOuZtPz1f0W1zdwjgmNgs6NiT8Kjx7jydX2l87xn/vkQUClHQqNuWHKQbZWU
	WQV8OIB9lzlM=
X-Received: by 2002:a05:600d:8449:b0:482:ef72:5778 with SMTP id 5b1f17b1804b1-482ef7258admr100181275e9.8.1770109379865;
        Tue, 03 Feb 2026 01:02:59 -0800 (PST)
X-Received: by 2002:a05:600d:8449:b0:482:ef72:5778 with SMTP id 5b1f17b1804b1-482ef7258admr100180885e9.8.1770109379457;
        Tue, 03 Feb 2026 01:02:59 -0800 (PST)
Received: from [192.168.88.32] ([150.228.93.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830512e0edsm51945985e9.7.2026.02.03.01.02.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 01:02:58 -0800 (PST)
Message-ID: <51ea0ddd-07d0-4995-8c0c-faf526c2a8b2@redhat.com>
Date: Tue, 3 Feb 2026 10:02:54 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 05/12] virtio_net: Query and set flow filter
 caps
To: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org,
 mst@redhat.com, jasowang@redhat.com
Cc: virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20260202170518.9076-1-danielj@nvidia.com>
 <20260202170518.9076-6-danielj@nvidia.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260202170518.9076-6-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eIaqAZ4PHll4lTtrtHvdbb12hk7beP3mb9nRdakzaH0_1770109380
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/2/26 6:05 PM, Daniel Jurgens wrote:
> +/**
> + * struct virtio_net_ff_selector - Selector mask descriptor
> + * @type: selector type, one of VIRTIO_NET_FF_MASK_TYPE_* constants
> + * @flags: selector flags, see VIRTIO_NET_FF_MASK_F_* constants
> + * @reserved: must be set to 0 by the driver and ignored by the device
> + * @length: size in bytes of @mask
> + * @reserved1: must be set to 0 by the driver and ignored by the device
> + * @mask: variable-length mask payload for @type, length given by @length
> + *
> + * A selector describes a header mask that a classifier can apply. The format
> + * of @mask depends on @type.
> + */
> +struct virtio_net_ff_selector {
> +	__u8 type;
> +	__u8 flags;
> +	__u8 reserved[2];
> +	__u8 length;
> +	__u8 reserved1[3];
> +	__u8 mask[];

Is a `__counted_by(length)` annotation relevant above?

> +};
> +
> +#define VIRTIO_NET_FF_MASK_TYPE_ETH  1
> +#define VIRTIO_NET_FF_MASK_TYPE_IPV4 2
> +#define VIRTIO_NET_FF_MASK_TYPE_IPV6 3
> +#define VIRTIO_NET_FF_MASK_TYPE_TCP  4
> +#define VIRTIO_NET_FF_MASK_TYPE_UDP  5
> +#define VIRTIO_NET_FF_MASK_TYPE_MAX  VIRTIO_NET_FF_MASK_TYPE_UDP
> +
> +/**
> + * struct virtio_net_ff_cap_mask_data - Supported selector mask formats
> + * @count: number of entries in @selectors
> + * @reserved: must be set to 0 by the driver and ignored by the device
> + * @selectors: packed array of struct virtio_net_ff_selectors.
> + */
> +struct virtio_net_ff_cap_mask_data {
> +	__u8 count;
> +	__u8 reserved[7];
> +	__u8 selectors[];

Similar point here for `selectors[] __counted_by(count)` and `actions[]
__counted_by(count)` below.

/P

