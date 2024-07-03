Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C2917B423
	for <virtualization@lists.linux.dev>; Wed,  3 Jul 2024 13:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720013005; cv=none; b=MqFuqQP1rXDmgSArbn5yNSapLwBbLq+bLh8+mfSvSGpo4R1OyXmTm8ku8pR7hNwlF35LGtwk0RMTxOVfxRfEC2WfnB/H2XaTcWQcemJraesRSVpq9fHT14NsNoAbt0k5fErONgI684uE/TrDjIG/LWhPFU6Z6ihDdHexeNzGiAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720013005; c=relaxed/simple;
	bh=IazLPdVkZkP9wwNOF7elgDermnHaCZCNFh1DES2m4p0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntSfV3o9WvieZq26Vu52s3p+ZXQ71zGFBKNTA/PIQGEyr4LX4qAyeZzvHmDM/C4+pwCEJH6KCQS3/WbglTQESJ8bz6LSMP6NKN1EdP17Q7uD8TpLr144Kr2ft5nc1eTxgY/gL9OuuDwjKEfMwk1yXdKWHfGy+7tV5gVuo/ddW8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=3IxMFDAF; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="3IxMFDAF"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42561c16ffeso41585385e9.3
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 06:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720013002; x=1720617802; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bg7ig0lUgxWATZU3zNAoWAcn79HUXshYb+guOFSJRX4=;
        b=3IxMFDAFVuDykKz63LZ2s8HOnMldrbEK23uffVx2yUrNHYdPaN97gMhKbsexTq0+CW
         K3gw1ryIUrlHi2yoTHzYd11w01QqrEOT2vWMYz7qlCmcIho/r+nZBIGky4iIDVCYtgxH
         /zX2Xc719Aq+uifZ+08tEWW2zrgOxezDT2SMExaL4aj4YA5+n7LSx5iiCfzbcX+WEkEB
         eKvgjbdcZ46xDlLCAxgBz/l6HwCh31hMjyU9KWoFU0eQ8rkkJSQ4dN5kux/Lk94oeLYw
         cLA8QSFzAYsZYDx1o7pwTKrzviT4DWe/Vod+nqsuQ23AFUfxW1WnjK8AoT3VMlJt0GX1
         MGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720013002; x=1720617802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bg7ig0lUgxWATZU3zNAoWAcn79HUXshYb+guOFSJRX4=;
        b=Wms45E2NcZzJ5lyUnESaQ1T6XA1izi4KQ1hBc4yAcEfoYKMKgef5061zxLcE4iI84m
         3Nil+uByS+6wFwnDuEEnLpHqr3uf1hkZTPivBmuAJ/EPtx0xfDwNfOf7YCEXIyKa1Vzc
         An+d4UEProSToqRzFDEefArOJxbmgUGQNnqVhCBevBlyJetqaKVque3YQb9D12Ei2tOg
         eJRBPVttUFs6HIjWG1pYgb9iGL9tvH4Qp7tzUjceohnlmt3uqxoAqgTUiyMQlWmuJogn
         LnXcZS80gxzz1P58x9COUWP1+U2xiohwprpjKA6Pda/cfRg/OiVe81zWjX1yX8cdI3Ek
         b1dw==
X-Gm-Message-State: AOJu0YznpfiiDq6lvNavdmbFcPScmGRIaZRV3qmlvP0pFELH9OBQKiA8
	Xr+rNwH+o9/bQwkCIDYYeL3XjMgL/woPftIpI9+FaicjiYyI8ckphO458XYm4xM=
X-Google-Smtp-Source: AGHT+IHj9c4vXVzkyoJEIACwEEWCxCm12GZSPqAFM/xZEfIYLdzOHl9g1jF0ODokuHB+WBxKurllxg==
X-Received: by 2002:a05:600c:1d1a:b0:424:a578:fc1 with SMTP id 5b1f17b1804b1-4257a05c0a3mr76791125e9.25.1720013002036;
        Wed, 03 Jul 2024 06:23:22 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0c0f99sm245144375e9.41.2024.07.03.06.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 06:23:21 -0700 (PDT)
Date: Wed, 3 Jul 2024 15:23:20 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, parav@nvidia.com,
	feliu@nvidia.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH virtio 04/19] virtio: introduce virtio_queue_info struct
 and find_vqs_info() config op
Message-ID: <ZoVQyC2dhBw2tx_Q@nanopsycho.orion>
References: <20240703123913.969202-1-jiri@resnulli.us>
 <20240703123913.969202-5-jiri@resnulli.us>
 <20240703085123-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703085123-mutt-send-email-mst@kernel.org>

Wed, Jul 03, 2024 at 03:02:58PM CEST, mst@redhat.com wrote:
>On Wed, Jul 03, 2024 at 02:38:58PM +0200, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Introduce a structure virtio_queue_info to carry name, callback and ctx
>> together. In order to allow config implementations to accept config op
>> with array of virtio_queue_info structures, introduce a new
>> find_vqs_info() op. Do the needed conversion in virtio_find_vqs_ctx().
>> Note that whole virtio_find_vqs_ctx() is going to be eventually removed
>> at the and of this patchset.
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>>  include/linux/virtio_config.h | 51 ++++++++++++++++++++++++++++++++---
>>  1 file changed, 48 insertions(+), 3 deletions(-)
>> 
>> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
>> index 82a1d798b2f1..21029afeede1 100644
>> --- a/include/linux/virtio_config.h
>> +++ b/include/linux/virtio_config.h
>> @@ -18,6 +18,16 @@ struct virtio_shm_region {
>>  
>>  typedef void vq_callback_t(struct virtqueue *);
>>  
>> +struct virtio_queue_info {
>
>I'd do virtio_queue_info -> virtqueue_info

Okay.

>
>linux$ git grep virtqueue_|wc -l
>734
>linux$ git grep virtio_queue_|wc -l
>7
>
>
>
>> +	const char *name; /* mainly for debugging, may be NULL for vq
>
>Capital M pls.
>vq -> a virtqueue

Okay.


>
>> +			   * unused by driver.
>> +			   */
>> +	vq_callback_t *callback; /* May be NULL for vq that do
>
>do -> does

Okay.


>
>> +				  * not need a callback.
>> +				  */
>
>
>        /*
>         * Use this style for comments
>	 * which do not fit on one line, please.
>         */
>	int and_the_code_comes_here_afterwards;
>
>
>
>	
>> +	bool ctx;
>> +};
>> +
>>  /**
>>   * struct virtio_config_ops - operations for configuring a virtio device
>>   * Note: Do not assume that a transport implements all of the operations
>> @@ -58,6 +68,12 @@ typedef void vq_callback_t(struct virtqueue *);
>>   *	names: array of virtqueue names (mainly for debugging)
>>   *		include a NULL entry for vqs unused by driver
>>   *	Returns 0 on success or error status
>> + * @find_vqs_info: find virtqueues and instantiate them.
>> + *	vdev: the virtio_device
>> + *	nvqs: the number of virtqueues to find
>> + *	vqs: on success, includes new virtqueues
>> + *	vqs_info: array of virtqueue info structures
>
>See, here you actually said "virtqueue info"

:)


>
>> + *	Returns 0 on success or error status
>>   * @del_vqs: free virtqueues found by find_vqs().
>>   * @synchronize_cbs: synchronize with the virtqueue callbacks (optional)
>>   *      The function guarantees that all memory operations on the
>> @@ -109,6 +125,10 @@ struct virtio_config_ops {
>>  			struct virtqueue *vqs[], vq_callback_t *callbacks[],
>>  			const char * const names[], const bool *ctx,
>>  			struct irq_affinity *desc);
>> +	int (*find_vqs_info)(struct virtio_device *vdev, unsigned int nvqs,
>> +			     struct virtqueue *vqs[],
>> +			     struct virtio_queue_info vqs_info[],
>> +			     struct irq_affinity *desc);
>>  	void (*del_vqs)(struct virtio_device *);
>>  	void (*synchronize_cbs)(struct virtio_device *);
>>  	u64 (*get_features)(struct virtio_device *vdev);
>> @@ -117,7 +137,7 @@ struct virtio_config_ops {
>>  	int (*set_vq_affinity)(struct virtqueue *vq,
>>  			       const struct cpumask *cpu_mask);
>>  	const struct cpumask *(*get_vq_affinity)(struct virtio_device *vdev,
>> -			int index);
>> +						 int index);
>>  	bool (*get_shm_region)(struct virtio_device *vdev,
>>  			       struct virtio_shm_region *region, u8 id);
>>  	int (*disable_vq_and_reset)(struct virtqueue *vq);
>> @@ -210,14 +230,39 @@ static inline bool virtio_has_dma_quirk(const struct virtio_device *vdev)
>>  	return !virtio_has_feature(vdev, VIRTIO_F_ACCESS_PLATFORM);
>>  }
>>  
>> +static inline
>> +int virtio_find_vqs_info(struct virtio_device *vdev, unsigned int nvqs,
>> +			 struct virtqueue *vqs[],
>> +			 struct virtio_queue_info vqs_info[],
>> +			 struct irq_affinity *desc)
>> +{
>> +	return vdev->config->find_vqs_info(vdev, nvqs, vqs, vqs_info, desc);
>> +}
>> +
>>  static inline
>>  int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
>>  			struct virtqueue *vqs[], vq_callback_t *callbacks[],
>>  			const char * const names[], const bool *ctx,
>>  			struct irq_affinity *desc)
>>  {
>> -	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, ctx,
>> -				      desc);
>> +	struct virtio_queue_info *vqs_info;
>> +	int err, i;
>> +
>> +	if (!vdev->config->find_vqs_info)
>> +		return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks,
>> +					      names, ctx, desc);
>> +
>> +	vqs_info = kmalloc_array(nvqs, sizeof(*vqs_info), GFP_KERNEL);
>> +	if (!vqs_info)
>> +		return -ENOMEM;
>> +	for (i = 0; i < nvqs; i++) {
>> +		vqs_info[i].name = names[i];
>> +		vqs_info[i].callback = callbacks[i];
>> +		vqs_info[i].ctx = ctx ? ctx[i] : false;
>> +	}
>> +	err = virtio_find_vqs_info(vdev, nvqs, vqs, vqs_info, desc);
>> +	kfree(vqs_info);
>> +	return err;
>>  }
>>  
>>  static inline
>> -- 
>> 2.45.2
>
