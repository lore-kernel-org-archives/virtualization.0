Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ADD20EA28
	for <virtualization@lists.linux.dev>; Thu,  7 Nov 2024 11:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730979603; cv=none; b=FX98WeXP+e4KpshiaMcKtYg6xuJZdtns8XKlCWTcKWfEN5fOOH91X+eSyn5dzxWLcuZOx/xDiVrn1bFa01TOE4u5GxCZ19wLBJZSrBCkEENmMhLjgZwhC5ryucMHoJZ8+AA1/GdUe5Z0PRdqSANtRDoy4gye4+hrt5v7+Vv9IiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730979603; c=relaxed/simple;
	bh=Dr1wnbMAcJ85mpqEQLLTPIf5QuKyNUdsjtKtaj8po5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gWSaWRtl97umSfiJAYNr7vbmaO0uJR2xjGDUqe1OxGn9JH97SaqeuCgDIl39zmFlhSNJnnDLMk/3H1VlqaAWkzLDmuVPWQa59ApoTDLcFVntSKcguiw28iW9E0PpV4bhyH2pmDfj3zygNU0YUZ29PqCAh35+MAxGzwGBvYD6O5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gG+DmtcU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gG+DmtcU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730979599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sU82hUgjAkYityCy1/Sw+2BlAMEi+LklRUiq4lsDGRk=;
	b=gG+DmtcUeVBgKP7GCruSWKAcPZaCPcq0SWNfjhigFS7qBcRmZ2PgXp2dCfb0n7lg6g+A/V
	gvgB41mOUyem2eFH9JTWNNMBsLT6xKmKJPFG44WFB5ypZRbbstyansDklz8oYgalzRvwmQ
	LtuFNnX62ML+tu6Hynh8uUJbsGFOdto=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-Yxa0gYL-O3OxmOPhAeeybA-1; Thu, 07 Nov 2024 06:39:58 -0500
X-MC-Unique: Yxa0gYL-O3OxmOPhAeeybA-1
X-Mimecast-MFC-AGG-ID: Yxa0gYL-O3OxmOPhAeeybA
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-288ba66682dso828129fac.2
        for <virtualization@lists.linux.dev>; Thu, 07 Nov 2024 03:39:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730979597; x=1731584397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sU82hUgjAkYityCy1/Sw+2BlAMEi+LklRUiq4lsDGRk=;
        b=jzJWs7vm+Z6RpzQkg8ExowbRBjAqbu4qWoERq86iI9C57UB5tjK5ssQoQh9VcsHF4O
         7R1szU5YqQ/v4osCaD8l/AnTUTiiVAWYq7SFlyfoPXJhBmYzVw2QWR6SFkxD0+D5ccRK
         EYYCPBAF5oYeYyLyOhGKZeBq1kzGG4nKUjtFQZQ2kWtRk3KpnQHphGAW1TqdTCCWahhQ
         rZwpPpk+TP5SGqCAi7xeo7c4QkgyJ7E/bHXRkvlgd3TGUxTHTSmmTve/JBg9DeVw88+S
         JRwqg/FuyNbHkMMYASYJBYQwXo91QIISRqD+4yyDnbthIAuKYVXq+EpLF2VJ8DxTRru1
         BfMQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4SMCLGWoOFUN4SPAOBKCWEICG4G5IMO7nn41IfpImi0aHWkmZXwFLd8WivqFtf/WKjVQ8r0FwS70mLg66kQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy71hMlvhuyB7BmwIIUA4eMCbXiJwIOdsOrVuB3izsKwnnYybRf
	TQ5uPwI/d3tWdN8n1O7jJh+HsK0gC0pWMIWSeum2PzxdUOy+qTUuCWqj2D4bN6fzltVA/Y3lJIn
	KEf8b3iCkXvcXWbOoNVXR9pxZm87jSjUZhKMajR+ylGbA0v/qxxQXeWrLX5K4LQhR
X-Received: by 2002:a05:6871:5308:b0:261:1f7d:cf71 with SMTP id 586e51a60fabf-2949effac5dmr21562498fac.34.1730979597365;
        Thu, 07 Nov 2024 03:39:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDq5fRIg01uNlVXiEtEZlPbiE6ggdZh6AZ5Ace6mGwQwi7O64CogCmEIHArE+Zd2OoFSmPhA==
X-Received: by 2002:a05:6871:5308:b0:261:1f7d:cf71 with SMTP id 586e51a60fabf-2949effac5dmr21562466fac.34.1730979596959;
        Thu, 07 Nov 2024 03:39:56 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29546c3d9cdsm296879fac.1.2024.11.07.03.39.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 03:39:56 -0800 (PST)
Message-ID: <41b0155f-bec4-4563-a92c-b30b0f5f9997@redhat.com>
Date: Thu, 7 Nov 2024 12:39:51 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/4] virtio_net: Update rss when set queue
To: Joe Damato <jdamato@fastly.com>, Philo Lu <lulie@linux.alibaba.com>,
 netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 andrew@daynix.com, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20241104085706.13872-1-lulie@linux.alibaba.com>
 <20241104085706.13872-5-lulie@linux.alibaba.com>
 <ZyqAovoIOYkNvtys@LQ3V64L9R2>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ZyqAovoIOYkNvtys@LQ3V64L9R2>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RzClUO0CeqVg7_ERSPy9m6sp8HuVkuPEJqe2phdK0Fs_1730979597
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/24 21:31, Joe Damato wrote:
> On Mon, Nov 04, 2024 at 04:57:06PM +0800, Philo Lu wrote:
>> RSS configuration should be updated with queue number. In particular, it
>> should be updated when (1) rss enabled and (2) default rss configuration
>> is used without user modification.
>>
>> During rss command processing, device updates queue_pairs using
>> rss.max_tx_vq. That is, the device updates queue_pairs together with
>> rss, so we can skip the sperate queue_pairs update
>> (VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET below) and return directly.
>>
>> Also remove the `vi->has_rss ?` check when setting vi->rss.max_tx_vq,
>> because this is not used in the other hash_report case.
>>
>> Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
>> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
>> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> ---
>>  drivers/net/virtio_net.c | 65 +++++++++++++++++++++++++++++++---------
>>  1 file changed, 51 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 59d9fdf562e0..189afad3ffaa 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -3394,15 +3394,59 @@ static void virtnet_ack_link_announce(struct virtnet_info *vi)
>>  		dev_warn(&vi->dev->dev, "Failed to ack link announce.\n");
>>  }
>>  
>> +static bool virtnet_commit_rss_command(struct virtnet_info *vi);
>> +
>> +static void virtnet_rss_update_by_qpairs(struct virtnet_info *vi, u16 queue_pairs)
>> +{
>> +	u32 indir_val = 0;
>> +	int i = 0;
>> +
>> +	for (; i < vi->rss_indir_table_size; ++i) {
>> +		indir_val = ethtool_rxfh_indir_default(i, queue_pairs);
>> +		vi->rss.indirection_table[i] = indir_val;
>> +	}
>> +	vi->rss.max_tx_vq = queue_pairs;
>> +}
>> +
>>  static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>>  {
>>  	struct virtio_net_ctrl_mq *mq __free(kfree) = NULL;
>> -	struct scatterlist sg;
>> +	struct virtio_net_ctrl_rss old_rss;
>>  	struct net_device *dev = vi->dev;
>> +	struct scatterlist sg;
>>  
>>  	if (!vi->has_cvq || !virtio_has_feature(vi->vdev, VIRTIO_NET_F_MQ))
>>  		return 0;
>>  
>> +	/* Firstly check if we need update rss. Do updating if both (1) rss enabled and
>> +	 * (2) no user configuration.
>> +	 *
>> +	 * During rss command processing, device updates queue_pairs using rss.max_tx_vq. That is,
>> +	 * the device updates queue_pairs together with rss, so we can skip the sperate queue_pairs
>> +	 * update (VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET below) and return directly.
>> +	 */
>> +	if (vi->has_rss && !netif_is_rxfh_configured(dev)) {
> 
> Does there need to be an error case when:
> 
> vi->has_rss && netif_is_rxfh_configured(dev)
> 
> to return EINVAL? I noted that other drivers don't let users adjust
> the queue count and return error in this case.

AFAICS the above is orthogonal to this patch - i.e. lack of check is
pre-existing and not introduced here. I'm not 110% sure the lack of
check is illegit, but I think it should eventually handled with a
separate patch/series.

Thanks,

Paolo

