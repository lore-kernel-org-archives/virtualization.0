Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54671D0DF7
	for <virtualization@lists.linux.dev>; Wed,  6 Nov 2024 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883589; cv=none; b=It65XzZeZKQAFzqYt2IdmMTfinFVI8G9xdBNG17kIBkkSFJCSZptYBgj0HwGZh0qGz+NUzg0USLx4nqWcct37Y4sJO2Jr0V+FIzfSYUzgLTsCOXKkO5WtWRp9VwfN5NcQQyC43aNp2qb9qoyEheKmuMb55kLv1qm4kpAhg6x9+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883589; c=relaxed/simple;
	bh=Eu+9GLCUs+ZL9T5JhqY4naszVNfrhG7aUHNrkoZ5HJc=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=Cc+wkZTw85w1D7phOVb0SRztaSJH3vLlGgYM+SvObErtinwcqZBnVJ+RtjsNJhV+7Ks/kWiNQ+z0nlW0AZtrjobGmjlwOakXfp2/c/BU9kfDE0lzGLS+FdJpHo06sJvClYmw194NanvqFdH8l6bQHX59hR7+ZYWvbo3kBUfmQOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DvqXowYl; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DvqXowYl"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730883584; h=Message-ID:Subject:Date:From:To;
	bh=U/vSd1bKneBHb9JmFxdGvWQlHRxiwwioW2TGCsju+hY=;
	b=DvqXowYlqmXDXf8L9WGd+dTJl6+SdIXxJyKkdRV8qGWXZINiSfsGTqECh0P9fVeMmOIuQ3ug00rC+rNT2Ju1NhcOo+KJd8CN8YQSvKKytG0jUwFo/VPD66gDuTFbNaYuCd7Tt0E/s5mMx8Y8F0jmxjiVnqBWfcYHcl07dPNbTQM=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WIqiKNA_1730883583 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 06 Nov 2024 16:59:44 +0800
Message-ID: <1730883538.0293355-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net 0/4] virtio_net: Make RSS interact properly with queue number
Date: Wed, 6 Nov 2024 16:58:58 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Philo Lu <lulie@linux.alibaba.com>
Cc: mst@redhat.com,
 jasowang@redhat.com,
 eperezma@redhat.com,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 andrew@daynix.com,
 virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20241104085706.13872-1-lulie@linux.alibaba.com>
In-Reply-To: <20241104085706.13872-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Hi Jason, could you review this firstly?

Thanks.

On Mon,  4 Nov 2024 16:57:02 +0800, Philo Lu <lulie@linux.alibaba.com> wrote:
> With this patch set, RSS updates with queue_pairs changing:
> - When virtnet_probe, init default rss and commit
> - When queue_pairs changes _without_ user rss configuration, update rss
>   with the new queue number
> - When queue_pairs changes _with_ user rss configuration, keep rss as user
>   configured
>
> Patch 1 and 2 fix possible out of bound errors for indir_table and key.
> Patch 3 and 4 add RSS update in probe() and set_queues().
>
> Please review, thanks.
>
> Philo Lu (4):
>   virtio_net: Support dynamic rss indirection table size
>   virtio_net: Add hash_key_length check
>   virtio_net: Sync rss config to device when virtnet_probe
>   virtio_net: Update rss when set queue
>
>  drivers/net/virtio_net.c | 119 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 100 insertions(+), 19 deletions(-)
>
> --
> 2.32.0.3.g01195cf9f
>
