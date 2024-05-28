Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE1C17E8FC
	for <virtualization@lists.linux.dev>; Tue, 28 May 2024 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716886316; cv=none; b=XNuQIy6OKyNMluXyyB8RMesEm3NXYFO482veGTwu5oria9Fww+XGS3lfkdhGg/AN+8ZafZGGXzY8zEbhqL5Vhr99jpAv7nyIq5knAC7BkCZyurVVjawleFLR+4DNyNr5F981obmMDNoVEqoTynkgTvFGz+8m9uib/JwYA/hDYIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716886316; c=relaxed/simple;
	bh=tG+bjTdkaqkL8cJb4mQDTBzcTFg5zRIZIUaUZU7PpVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dk2Ml61wZaod0vkH8E6zB70xAX7rVR1WJzhfNx4yNCxP8klHfwWAUK9qEk+ddAy0yJV85ddDsvWH1RkJcTrrEgiSK/Rh1qqqqZt+YmTQHddGBSZ5qEy6YuRjFNIXS9drF2/LvGrwu148QELFwu6hwMaQciZgxeo/Lzqmg4vCTko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=A2Xtk5TN; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="A2Xtk5TN"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716886311; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=iivq803/O52jK9cH2+dpdeqnc1dtQHPR5Vx6H25CXh8=;
	b=A2Xtk5TNqmo8WTmvng7kJeo1tlzTOf7EfgYtbHc5KWPAupoaQmjDCNwg39Pb3F/hp/xMcgYKsgvZC/Fu5XIpL8F7Q/lx3wXebjAwpRBd4EJqOlrKTu0niXaDmkqqTWG6zjT8laHYK4iaPTEcA0wbyHCFGMGPYCDCH5UCWllQX6w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W7P4tWJ_1716886309;
Received: from 30.221.144.199(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W7P4tWJ_1716886309)
          by smtp.aliyun-inc.com;
          Tue, 28 May 2024 16:51:50 +0800
Message-ID: <08795907-fb19-47d7-a8c9-3db0ecc91889@linux.alibaba.com>
Date: Tue, 28 May 2024 16:51:48 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] virtio-fs: add multi-queue support
To: Peter-Jan Gootzen <pgootzen@nvidia.com>, virtualization@lists.linux.dev,
 vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu
Cc: mst@redhat.com, dgilbert@redhat.com, yorayz@nvidia.comm,
 gurtovoy@nvidia.com, Yoray Zack <yorayz@nvidia.com>,
 Max Gurtovoy <mgurtovoy@nvidia.com>
References: <20240501153817.540855-1-pgootzen@nvidia.com>
 <20240501153817.540855-3-pgootzen@nvidia.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240501153817.540855-3-pgootzen@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Peter-Jan,

Thanks for the amazing work.

I'd just like to know if you have any plan of making fiq and fiq->lock
more scalable, e.g. make fiq a per-CPU software queue?  I think the
global fiq and fiq->lock can be a performance bottleneck after we have
supported mq.


-- 
Thanks,
Jingbo
