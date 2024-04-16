Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A3213AF9
	for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 02:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713234449; cv=none; b=eluNEidI4z7ZzLYARUyac1R7Y1VV5erhiD2Zlm0wpd+4uSYJEX/mERB6uWccXykwzmMjdGxLi8rv/gUbuVj0Sv8KMLYYS7lqKN/jB/hRIHRwvgGKCtxOLZsrFn6bbhPRU4XQC/0lIuguwycri6urCRJm4SjIoh8dDFu7XzzgYIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713234449; c=relaxed/simple;
	bh=klJSczXd7a5izXPTzPLWa4oItlqlCgcuCGH5GqNNFSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PSwRLCIwWWImaZ3UlW8rgdI190M2tGlJsOy9nYpetUWyCFJWiNWDDAelHu2hsD3pig1PvAUpzEpKA3Ov3Yd2nh3ENhdREDkxuvNeqTWFiMruKsOWVmUIdzvUH0zT+kRH9At5dhVxablpGh7NKClLahE27rLpMF56bM7VncETHZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=a5WIioG/; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="a5WIioG/"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713234444; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Ur6dE2kveXQmyC8klKyeWxv9058DN9W2YwUV0NRk0Mc=;
	b=a5WIioG/96wfKoQxoGu4rmOgkngVy/2vGAw3S0B4XtXtl2kzTjsqwGDmWUgg3duRJhQGTU2+gUVsA/LNH7V7G433KMQE/znUUta6xP99kcIK0ey9gax6ZryjOawFmxrNTnT/CQvjeWz6n12YZOw1VS55zzaSfOtOZjIpzgDyces=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W4fosp8_1713234442;
Received: from 30.221.148.212(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4fosp8_1713234442)
          by smtp.aliyun-inc.com;
          Tue, 16 Apr 2024 10:27:23 +0800
Message-ID: <e8d84e95-cab4-447c-b8f2-54444e80e556@linux.alibaba.com>
Date: Tue, 16 Apr 2024 10:27:21 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 2/4] ethtool: provide customized dim profile
 management
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Brett Creeley <bcreeley@amd.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20240415093638.123962-1-hengqi@linux.alibaba.com>
 <20240415093638.123962-3-hengqi@linux.alibaba.com>
 <20240415200343.GG2320920@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240415200343.GG2320920@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/16 上午4:03, Simon Horman 写道:
> On Mon, Apr 15, 2024 at 05:36:36PM +0800, Heng Qi wrote:
>
> ...
>
>> @@ -10229,6 +10230,61 @@ static void netdev_do_free_pcpu_stats(struct net_device *dev)
>>   	}
>>   }
>>   
>> +static int dev_dim_profile_init(struct net_device *dev)
>> +{
>> +#if IS_ENABLED(CONFIG_DIMLIB)
>> +	u32 supported = dev->ethtool_ops->supported_coalesce_params;
>> +	struct netdev_profile_moder *moder;
>> +	int length;
>> +
>> +	dev->moderation = kzalloc(sizeof(*dev->moderation), GFP_KERNEL);
>> +	if (!dev->moderation)
>> +		goto err_moder;
>> +
>> +	moder = dev->moderation;
>> +	length = NET_DIM_PARAMS_NUM_PROFILES * sizeof(*moder->rx_eqe_profile);
>> +
>> +	if (supported & ETHTOOL_COALESCE_RX_EQE_PROFILE) {
>> +		moder->rx_eqe_profile = kzalloc(length, GFP_KERNEL);
>> +		if (!moder->rx_eqe_profile)
>> +			goto err_rx_eqe;
>> +		memcpy(moder->rx_eqe_profile, rx_profile[0], length);
>> +	}
>> +	if (supported & ETHTOOL_COALESCE_RX_CQE_PROFILE) {
>> +		moder->rx_cqe_profile = kzalloc(length, GFP_KERNEL);
>> +		if (!moder->rx_cqe_profile)
>> +			goto err_rx_cqe;
>> +		memcpy(moder->rx_cqe_profile, rx_profile[1], length);
>> +	}
>> +	if (supported & ETHTOOL_COALESCE_TX_EQE_PROFILE) {
>> +		moder->tx_eqe_profile = kzalloc(length, GFP_KERNEL);
>> +		if (!moder->tx_eqe_profile)
>> +			goto err_tx_eqe;
>> +		memcpy(moder->tx_eqe_profile, tx_profile[0], length);
>> +	}
>> +	if (supported & ETHTOOL_COALESCE_TX_CQE_PROFILE) {
>> +		moder->tx_cqe_profile = kzalloc(length, GFP_KERNEL);
>> +		if (!moder->tx_cqe_profile)
>> +			goto err_tx_cqe;
>> +		memcpy(moder->tx_cqe_profile, tx_profile[1], length);
>> +	}
> nit: Coccinelle suggests that the kzalloc()/memcpy() pattern above
>       could be replaced with calls to kmemdup()

Good idea.

Thanks.

>> +#endif
>> +	return 0;
>> +
>> +#if IS_ENABLED(CONFIG_DIMLIB)
>> +err_tx_cqe:
>> +	kfree(moder->tx_eqe_profile);
>> +err_tx_eqe:
>> +	kfree(moder->rx_cqe_profile);
>> +err_rx_cqe:
>> +	kfree(moder->rx_eqe_profile);
>> +err_rx_eqe:
>> +	kfree(moder);
>> +err_moder:
>> +	return -ENOMEM;
>> +#endif
>> +}
>> +
>>   /**
>>    * register_netdevice() - register a network device
>>    * @dev: device to register
> ...

