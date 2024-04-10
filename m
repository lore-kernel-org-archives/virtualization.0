Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B4564A
	for <virtualization@lists.linux.dev>; Wed, 10 Apr 2024 03:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712718804; cv=none; b=LvT9x9eIw48fUyNACmh5Ky6CqkgYcQ34Y4wii94o4A8z8vVyuRja5WckFoIpNn4BPedgUgwj5H2htUudKTn3jn582XzaOkeiSVpQ3NHeUDCvU32cfY7hIOjpfpYe9Rhov6MR4ZYkdolt+LKpjsiWvI1QiEEVuXgvG2nuDlGqvN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712718804; c=relaxed/simple;
	bh=wvEgyk3NZQlKLuu84W7KDUZ3iF87v5vXeh/4kYtby10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LoG9jtwtChSWBC7DQAwDxqy6nz/xJUDYFgzjz6K6q27jIwLRQYdQ/LqI0snNrQyiI5UTOqD/QwQ1AR/WSdu8D6qmfAa47KabOTurmHpVA74zVO/ODkv59T3VjCOG3eHCH2+8yJveQ2jTlF2PxaS1cn1hZKubPjRWMFmqWEiK10U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=b8Laj1y4; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="b8Laj1y4"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712718799; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=F4KaBEfcefOiJnTDntEDlBTr829WslVYeJ1u0b9cvjg=;
	b=b8Laj1y4Z7mi2V7U9JjRXsmgkKUs0OQqGzVrGnQK40domrtro2+gqNmpDiylpAZDn5avGDRit/7NWaoriGNcaAKF4ruMs11+sntKCXqJdStsEspt3X7Zw9xs7VuqxZJs3yttI9h5l67It+3NLSv6fFO+dw00sgn6KZoQ0a33quA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W4GJFM-_1712718796;
Received: from 30.221.148.212(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4GJFM-_1712718796)
          by smtp.aliyun-inc.com;
          Wed, 10 Apr 2024 11:13:17 +0800
Message-ID: <a07d16d9-60cf-4263-abd5-a1adea0959ad@linux.alibaba.com>
Date: Wed, 10 Apr 2024 11:13:15 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/4] ethtool: provide customized dim profile
 management
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1712664204-83147-1-git-send-email-hengqi@linux.alibaba.com>
 <1712664204-83147-2-git-send-email-hengqi@linux.alibaba.com>
 <20240409184400.4e5444f3@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240409184400.4e5444f3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/10 上午9:44, Jakub Kicinski 写道:
> On Tue,  9 Apr 2024 20:03:21 +0800 Heng Qi wrote:
>> +/**
>> + * coalesce_put_profile - fill reply with a nla nest with four child nla nests.
>> + * @skb: socket buffer the message is stored in
>> + * @attr_type: nest attr type ETHTOOL_A_COALESCE_*X_*QE_PROFILE
>> + * @profile: data passed to userspace
>> + * @supported_params: modifiable parameters supported by the driver
>> + *
>> + * Put a dim profile nest attribute. Refer to ETHTOOL_A_MODERATIONS_MODERATION.
> unfortunately kdoc got more picky and it also wants us to document
> return values now,

Will add it.

> you gotta add something like
>
>   * Returns: true if ..
>
> actually this functions seems to return negative error codes as bool..

This works, in its wrapper function its error will be passed.:)

>
>> +static bool coalesce_put_profile(struct sk_buff *skb, u16 attr_type,
>> +				 const struct dim_cq_moder *profile,
>> +				 u32 supported_params)
>> +{
>> +	struct nlattr *profile_attr, *moder_attr;
>> +	bool valid = false;
>> +	int i;
>> +
>> +	for (i = 0; i < NET_DIM_PARAMS_NUM_PROFILES; i++) {
>> +		if (profile[i].usec || profile[i].pkts || profile[i].comps) {
>> +			valid = true;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (!valid || !(supported_params & attr_to_mask(attr_type)))
>> +		return false;
>> +
>> +	profile_attr = nla_nest_start(skb, attr_type);
>> +	if (!profile_attr)
>> +		return -EMSGSIZE;
>> +
>> +	for (i = 0; i < NET_DIM_PARAMS_NUM_PROFILES; i++) {
>> +		moder_attr = nla_nest_start(skb, ETHTOOL_A_MODERATIONS_MODERATION);
>> +		if (!moder_attr)
>> +			goto nla_cancel_profile;
>> +
>> +		if (nla_put_u16(skb, ETHTOOL_A_MODERATION_USEC, profile[i].usec) ||
>> +		    nla_put_u16(skb, ETHTOOL_A_MODERATION_PKTS, profile[i].pkts) ||
>> +		    nla_put_u16(skb, ETHTOOL_A_MODERATION_COMPS, profile[i].comps))
> u16 in netlink is almost always the wrong choice, sizes are rounded
> up to 4B, anyway, let's use u32 at netlink level.

OK.

Thanks for your comments.




