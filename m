Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D75746B8
	for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 02:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713320586; cv=none; b=EsBWJ+S2MsC1j7bzs6yCxTV1+orBsvfQ33XZ3GiYXbkZsdUwoWTj/3pL5geLarVeBw3XbwweNZvcjzrmeEecQ/TTHtZyZ36eKw62UeVq0jfyTuwpyijsEX41KqfuJdo/iSCHSYQLEom/hq+46Nd6aqLZpwTFHeN0AWtQAypCaL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713320586; c=relaxed/simple;
	bh=b6z9a2sq+XyqS26y6EiD/zKw6EXQNsuBhU7W3ax7Kjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kbk14itsMezkbjWN8tUy/+vJ9ZBdwwledRRvVyg8O46zdYfgMq/q/pkx6oQIdeRQkMPI+M01Geb7wr6Ci88N0NtCJ3cnWx0pbSZ7Y2SYHi/I8NuqaFoPfabNGAIVwIyUZZ6MTRfv7GTT7f5qH7s6y8kRNDRxtCe/SoGDnYojLhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dKv6WGLH; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dKv6WGLH"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713320576; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=E55CPw2jBiMvRQ6oD9WS9XetsEfEvIXR5GCoyNY9BDk=;
	b=dKv6WGLHtqi3UKeTbIuYmBfKtbCSjz/YwihGLrbEa3GMa18DCmm7/E9pr7lWKP9ggJo4ekjgFsyjX9us1hpZOerwdfNpOeS+vGrOrc+L2MD4hfMCprO2WKqpfJWAAjyTJocTLZCO3xpSVxPpc40VhR1iu+3i+6St+SnFVR/xkhU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W4jWXJf_1713320573;
Received: from 30.221.148.177(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4jWXJf_1713320573)
          by smtp.aliyun-inc.com;
          Wed, 17 Apr 2024 10:22:54 +0800
Message-ID: <1abdb66a-a080-424e-847d-1d2f5837bbc4@linux.alibaba.com>
Date: Wed, 17 Apr 2024 10:22:52 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 0/4] ethtool: provide the dim profile
 fine-tuning channel
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Simon Horman <horms@kernel.org>, Brett Creeley <bcreeley@amd.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20240416122950.39046-1-hengqi@linux.alibaba.com>
 <20240416173836.307a3246@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240416173836.307a3246@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/17 上午8:38, Jakub Kicinski 写道:
> On Tue, 16 Apr 2024 20:29:46 +0800 Heng Qi wrote:
>> Please review, thank you very much!
> Please stop posting code which does not compile.
> The mailing list is for reviewing code, not build testing it.

Sorry, three versions v7, RESEND v7, v8 in two days, this may have 
caused a mess.
RESEND v7 has addressed possible bot warnings, and v8 is a fix for 
Simon's comment.

Have you encountered compilation problems in v8?

Anyway, I'll bide my time on v8 to avoid another mess. ^^

Thanks.
