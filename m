Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB355466E
	for <virtualization@lists.linux.dev>; Tue,  9 Apr 2024 08:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712651895; cv=none; b=c8cCVdKXw1K5rJTB1CqmX5xvJS1wOwaLOdd+e5rgSl24urfeV8QrpdzaNJAIX6pdiqacTzb7eJvbfPR7JQvi5sICaWIim+dlylaJPgMGkIThoMBVvXT5N9V3Nm/w7YwmcncDcoyvggzk3RuPYBMYyzPPIGpyeM8tJFqCSaxSK9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712651895; c=relaxed/simple;
	bh=Hbp7838q55SRGc5rIvPvFjLLvIDmwcQ7nVxTyGq//58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gKaPDZvghw9tOEu/9XYqqe3Rdc2ucmjcQn+Da2DFTUVcyrUPm6kP0cs2ijtmd7F871PgG4F8MTVisISgLErqGMD1lgyI/6IL555KiCCxHjnP60IjREIdoQBeA7K4Wbi96RKvt/6IatJFbuxcppW5qeDL9n1H1vij98HHoe3sBz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pth/Dz9i; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pth/Dz9i"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712651890; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RSSlge0Z7qxaFlGL8HYnwu8sODFyD4rKErjmfaZTqpc=;
	b=pth/Dz9iabKlUdOlnWlV2GlPe5CXiJSdd3AVXfNaUfdLmPzHIz9zXZJbkRDd1yQuLoGjjTeya58zqxv2K4JjhcFiuoTs2fg+kQd4RnBgFOc5Wbfv8HgPK8TFqO0MYZBMktuWTgK9FBIVOl28P71uAnDJfBEZou0YMxTY+bfmwUs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W4DyeQT_1712651888;
Received: from 30.221.146.5(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4DyeQT_1712651888)
          by smtp.aliyun-inc.com;
          Tue, 09 Apr 2024 16:38:09 +0800
Message-ID: <51ef6c48-d644-43b8-9b44-12f6a91f7e05@linux.alibaba.com>
Date: Tue, 9 Apr 2024 16:38:08 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/4] ethtool: provide customized dim profile
 management
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1712547870-112976-1-git-send-email-hengqi@linux.alibaba.com>
 <1712547870-112976-2-git-send-email-hengqi@linux.alibaba.com>
 <20240408121324.01dc4893@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240408121324.01dc4893@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Will modify things as you sugguested.

Thanks!


在 2024/4/9 上午3:13, Jakub Kicinski 写道:
> On Mon,  8 Apr 2024 11:44:27 +0800 Heng Qi wrote:
>> +	nla_for_each_nested(nest, nests, rem) {
>> +		if (WARN_ONCE(nla_type(nest) != ETHTOOL_A_MODERATIONS_MODERATION,
>> +			      "unexpected nest attrtype %u\n", nla_type(nest)))
> Maybe just use the newly added nla_for_each_nested_type()
>
>> +			return;
>> +
>> +		ret = nla_parse_nested(tb_moder,
>> +				       ARRAY_SIZE(coalesce_set_profile_policy) - 1,
>> +				       nest, coalesce_set_profile_policy,
>> +				       extack);
>> +		if (ret ||
> if parsing failed it will set the right error and extack, just return
> the error
>
>> +		    !tb_moder[ETHTOOL_A_MODERATION_USEC] ||
>> +		    !tb_moder[ETHTOOL_A_MODERATION_PKTS] ||
>> +		    !tb_moder[ETHTOOL_A_MODERATION_COMPS]) {
> If you miss an attr you should use NL_SET_ERR_ATTR_MISS() or such.
>
>> +			NL_SET_ERR_MSG(extack, "wrong ETHTOOL_A_MODERATION_* attribute\n");
> no new line at the end of the exact string

