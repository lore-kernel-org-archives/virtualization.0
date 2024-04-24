Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F29715B574
	for <virtualization@lists.linux.dev>; Wed, 24 Apr 2024 13:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713964270; cv=none; b=d7j59CGrdoQ/kWaYLGw/l+zYBZefQDRh9sY9aEU03fIBott94z1P+C3R8lvY2J00vGrSvIqbqTEWd/ZISwm4z7gFQwUkuUIVgZy0fiqK1Px4VhwbVwdj8KN7N1aGVRHf98vcaFEdGvhFAYE4XnCEFiAGcDLgFkspYTKr8yItskA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713964270; c=relaxed/simple;
	bh=LIDqAQu4uQ/HQYk5mOyL+t0L0UHjVQlLHfWCIRPYElM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RpLjYrePgpWXSOlIgwPyG0SIWCHh3Acwc3QztIqKdMr6mYG/yeRj8V3QXXnSoj6F5rV2/6/tF49fgUpdA2ciN+1yiVUjzEtYHuIyZ2G9y2Rq4bQ7fXbFm9Q62YIbgns4AlfKbmyQ0jUC1zrzuuWvDMoJCDX7s3PlD6xvjE9Z8EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mG1VWUhR; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mG1VWUhR"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713964259; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=wdSVvWDX+Np6cNQGBuY/SvU5jYu+onGWyo5SDaMi794=;
	b=mG1VWUhRTMKU43NhqP5wyHBfXUM/mwECp1MXj0oLmzx2ZqxzGG2rr3+p5HuBeHOq4XHWbVH8rLE5Ode0Of8mkf2OZPUeD10EDpn9/PcRAnVHywc8tHGYH2tETshBeB1tqR+qxxa9HRCg2GI8rIop17XCPBVyfQuild9gxnI7USg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0W5CPai0_1713964256;
Received: from 30.221.148.255(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W5CPai0_1713964256)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 21:10:58 +0800
Message-ID: <76b75fcc-aa2f-4c75-b28f-7f7a513a2cf1@linux.alibaba.com>
Date: Wed, 24 Apr 2024 21:10:55 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heng Qi <hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v9 2/4] ethtool: provide customized dim profile
 management
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Brett Creeley <bcreeley@amd.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Tal Gilboa <talgi@nvidia.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jiri Pirko <jiri@resnulli.us>, Paul Greenwalt <paul.greenwalt@intel.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>, "justinstitt@google.com"
 <justinstitt@google.com>
References: <20240417155546.25691-1-hengqi@linux.alibaba.com>
 <20240417155546.25691-3-hengqi@linux.alibaba.com>
 <20240418174843.492078d5@kernel.org>
 <96b59800-85e6-4a9e-ad9b-7ad3fa56fff4@linux.alibaba.com>
 <20240422113943.736861fc@kernel.org>
In-Reply-To: <20240422113943.736861fc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

@@ -227,7 +315,19 @@ const struct nla_policy ethnl_coalesce_set_policy[] = {
>>>>    	[ETHTOOL_A_COALESCE_TX_AGGR_MAX_BYTES] = { .type = NLA_U32 },
>>>>    	[ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES] = { .type = NLA_U32 },
>>>>    	[ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS] = { .type = NLA_U32 },
>>>> +	[ETHTOOL_A_COALESCE_RX_EQE_PROFILE]     = { .type = NLA_NESTED },
>>>> +	[ETHTOOL_A_COALESCE_RX_CQE_PROFILE]     = { .type = NLA_NESTED },
>>>> +	[ETHTOOL_A_COALESCE_TX_EQE_PROFILE]     = { .type = NLA_NESTED },
>>>> +	[ETHTOOL_A_COALESCE_TX_CQE_PROFILE]     = { .type = NLA_NESTED },
>>> NLA_POLICY_NESTED(coalesce_set_profile_policy)
>> This doesn't work because the first level of sub-nesting of
>> ETHTOOL_A_COALESCE_RX_CQE_PROFILE is ETHTOOL_A_PROFILE_IRQ_MODERATION.
> So declare a policy for IRQ_MODERATION which has one entry -> nested
> profile policy?

Still doesn't work because one profile corresponds to 5 IRQ_MODERATION sub-nests.

In the same example, strset also uses NLA_NESTED.

Thanks.


