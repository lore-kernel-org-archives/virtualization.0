Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BA6174EC6
	for <virtualization@lists.linux.dev>; Mon, 15 Jul 2024 07:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721030259; cv=none; b=p/8mkKkUAKpUGUqenBhb2UurD6rTaSpMGl32m6xyKqAHcZO1gL3MndJvJ2lJMGQJCQMJITylXh03p4KqIrpEddzd+OgKvuwywNmLz+Sztbbd5TdnBAJV+QchjC99j3ZbqO9FJTLXgidDshMXvoLLvDJ5v8cCNN0fvvq/Ua5N8Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721030259; c=relaxed/simple;
	bh=8shu+2e9JhJxmpbA3vTsnedBT0xcNg6jWPl8rSHe3lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+6XN7wH5CmjVKV/1xnYkstn8v6S5l+uhKZQzY0aJr1oH+CTyOX5JKQifZGl0usA6HOOONBzXUc4qmPiyICbeu3hQ6254fiDtI/FppM29oIf27GDV7E8Q0Nw0NPZH2mzdJm2rGlSpCAIpRhrFcugcftEBKrZb+hUSU5DNUoOMBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=eblNgoS0; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="eblNgoS0"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52ea929ea56so7338998e87.0
        for <virtualization@lists.linux.dev>; Mon, 15 Jul 2024 00:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1721030254; x=1721635054; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y9G5iVN1CoTDCk7EstONqDF7BjrP6GmY9qcnEjTY9Vk=;
        b=eblNgoS0CORogq/K2bPWf6iFgqUxCcys+EJfu0PTl6k/9sCMCkCUI4wIRMSR2dBK10
         n4Q9viDOW/xKPLyy5AfbhTot/tKz4jEZO4mT9dJYLoM0IS7T9m7iavBaKglH8LCCmyai
         aL67VIR63oslzVaHkBM+JBGGKyJdy7nZhmte9TFPEueqYDGMsORO9TfWq95vMhzwutuD
         RHgVcMPzTz8GFNw+RDQc6N+iAxVM+++x4QNwtBahTviJQZxM6uhgMI5QdUQjkF+3Mojf
         CmujYgNHYn2QBSLIxjvjzm9GoTmP4SsasSUx33CBBcegHcRO5WBN393SdnoEX2MJXgEl
         8xTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721030254; x=1721635054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9G5iVN1CoTDCk7EstONqDF7BjrP6GmY9qcnEjTY9Vk=;
        b=Fto/VHvQHsHn/7rKDH5pT3CQFCARhANH7eZr0KKrk82RsmHwtn18ndebun1wmLc8Bn
         ZWODsrSBeso2E446P4uh8cd2wLFbNvDdclssQLpCpb6zSRm3DGkMVbkRvkH44Hys+xmh
         98QM5+E7SNLNyQEZNCtZyMw52jRGunEYWa28Z6VOBgzMfZ114VgCXUSmpZKgMncKnHRn
         9x86iPRfOhz1Keqz5mws/EN8tYRVGmmf2voWV2ii8KizFIRlmAw82+jmDRuYFLRur7iG
         97yAHSiwte8WbN87bgUWZH+ywfT88ukOaAwgwLjV8oZ0VROqcVvyUzBpVPwARw1W93GW
         43jg==
X-Forwarded-Encrypted: i=1; AJvYcCUGeMDIJ87QtqdYbjwGqw0sfI0i1eXoSe+ZODabSFo8sUTUcmGv+4bmLi8VHpgkLBUV31BkKuhYq8nPcbXn+KaT8NXuXDXcEKm4+gjVsJI=
X-Gm-Message-State: AOJu0YxgQvo9n9JT5EQQgQdYAi4GUpz+iFxsjSk57Uu0NR12+015QiD6
	JP2fFLqtLELVH6ZWVy1ztaUbNFzao8hJNgjZSSAyxsHeOnEYD/HQnjiZjQADLeI=
X-Google-Smtp-Source: AGHT+IGYuC58ORbxox2CioSmCxZrLUXUpmRyEzFy4niv41cc0zfR0FDYh04gt7GyRddbr55r/ghNzA==
X-Received: by 2002:a05:6512:2111:b0:52e:73f5:b7c4 with SMTP id 2adb3069b0e04-52eb99a3645mr11959474e87.37.1721030253997;
        Mon, 15 Jul 2024 00:57:33 -0700 (PDT)
Received: from localhost ([37.48.50.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5b7388sm189606766b.55.2024.07.15.00.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 00:57:33 -0700 (PDT)
Date: Mon, 15 Jul 2024 09:57:31 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	Feng Liu <feliu@nvidia.com>,
	"hengqi@linux.alibaba.com" <hengqi@linux.alibaba.com>
Subject: Re: [PATCH virtio v2 10/13] virtio_pci_modern: create admin queue of
 queried size
Message-ID: <ZpTWa5_9RWQCLCAY@nanopsycho.orion>
References: <20240710063601.2000149-1-jiri@resnulli.us>
 <20240710063601.2000149-11-jiri@resnulli.us>
 <20240714035231-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481152D9CF63DD6AA6611E8DCA02@PH0PR12MB5481.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR12MB5481152D9CF63DD6AA6611E8DCA02@PH0PR12MB5481.namprd12.prod.outlook.com>

Sun, Jul 14, 2024 at 04:28:29PM CEST, parav@nvidia.com wrote:
>
>
>> From: Michael S. Tsirkin <mst@redhat.com>
>> Sent: Sunday, July 14, 2024 1:25 PM
>> 
>> On Wed, Jul 10, 2024 at 08:35:58AM +0200, Jiri Pirko wrote:
>> > From: Jiri Pirko <jiri@nvidia.com>
>> >
>> > Don't limit the admin queue size to VIRTIO_AVQ_SGS_MAX and rather rely
>> > on the queried queue size.
>> >
>> > Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> 
>> I have some doubts about this one. Can't we limit the size to something
>> sensible? E.g. max number of CPUs? Number of VFs? I don't see why we
>> should just follow what device did blindly, the device has no idea about use
>> so would tend to over-provision.
>>
>+1.
>I agree with Michael, we can possibly do min(max_cpus, device_supplied_limit).
>When more use cases of it arise, this can be improved in future to use larger limit.

Why max_cpus? How number of cpus is related here?

regarding max VFs is also value coming from the device,
why is that better?

For other queues, we also use number provided by the device. Why here
the behaviour whould be different? Device should know what scale to
prepare for, why to be smart here?



> 
>> > ---
>> >  drivers/virtio/virtio_pci_modern.c | 3 +--
>> >  1 file changed, 1 insertion(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/virtio/virtio_pci_modern.c
>> > b/drivers/virtio/virtio_pci_modern.c
>> > index 5ceb4b2c18df..a649c9dc436d 100644
>> > --- a/drivers/virtio/virtio_pci_modern.c
>> > +++ b/drivers/virtio/virtio_pci_modern.c
>> > @@ -550,8 +550,7 @@ static struct virtqueue *setup_vq(struct
>> virtio_pci_device *vp_dev,
>> >  	if (index >= vp_modern_get_num_queues(mdev) && !is_avq)
>> >  		return ERR_PTR(-EINVAL);
>> >
>> > -	num = is_avq ?
>> > -		VIRTIO_AVQ_SGS_MAX : vp_modern_get_queue_size(mdev,
>> index);
>> > +	num = vp_modern_get_queue_size(mdev, index);
>> >  	/* Check if queue is either not available or already active. */
>> >  	if (!num || vp_modern_get_queue_enable(mdev, index))
>> >  		return ERR_PTR(-ENOENT);
>> > --
>> > 2.45.2
>
