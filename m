Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332898BE7
	for <virtualization@lists.linux.dev>; Fri, 21 Mar 2025 07:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742541484; cv=none; b=AKT/NxkMywTEQoHm+3WegMgoSaNFWZVZyfEPxEwfj7/dfVZd8p+BDdlhf/dUKbIdqnrfBcG07lbfEicH7LvTt+i4T6fw4CjXgK8ED0xIXc53uNlV1OM5clcP6wYXv1neCDWU6IlzwAtWsUorGcuF85nK+iHaPHB/t061r1V8SP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742541484; c=relaxed/simple;
	bh=Az2iaCs6AjpNK8WuURbopULbdHBFksgSv8kK2V+xfCc=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=MY3IgjV3TLkzDXXuThkmsMBkwiTxPrSd6iahL/4CsktFIPuDa97ldjd+p/Vv8X9I61yhYc8fywF/cAGm0yxVtenppmAc/rSymympzqiTuIqRx0nGo6BLBBTiQ/0Xw+jcKR4ILwON/AW/GZamotYai+4wuG4nZ4zGjTvZ51gnWUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tYbIlvx4; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tYbIlvx4"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742541473; h=Message-ID:Subject:Date:From:To;
	bh=QpT6TAhfiuDwI7Ss07pa7dcarLeE0EOAXbWNZWyjt7s=;
	b=tYbIlvx4SU770heupGB0tU7T7N/WXgCAZeQ4nns2SpCQzGzD8eBZkId90sBYvmzRL4yyfVYS8YzcERCDzkNCazx3bpnjjzgNSrMP6hO2eqYevP48ZVzTuzHxVXhs0aH9rGrZcrUNVvdio3jQ1PBZnR4wKrcydhMr4v/6xPwWkhg=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WSGdsj9_1742541471 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 21 Mar 2025 15:17:52 +0800
Message-ID: <1742541465.8308454-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 0/4] virtio_net: Fixes and improvements
Date: Fri, 21 Mar 2025 15:17:45 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org,
 devel@daynix.com,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Lei Yang <leiyang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Joe Damato <jdamato@fastly.com>,
 Philo Lu <lulie@linux.alibaba.com>
References: <20250321-virtio-v2-0-33afb8f4640b@daynix.com>
In-Reply-To: <20250321-virtio-v2-0-33afb8f4640b@daynix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Fri, 21 Mar 2025 15:48:31 +0900, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> Jason Wang recently proposed an improvement to struct
> virtio_net_rss_config:
> https://lore.kernel.org/r/CACGkMEud0Ki8p=z299Q7b4qEDONpYDzbVqhHxCNVk_vo-KdP9A@mail.gmail.com
>
> This patch series implements it and also fixes a few minor bugs I found
> when writing patches.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
> Changes in v2:
> - Replaced kmalloc() with kzalloc() to initialize the reserved fields.
> - Link to v1: https://lore.kernel.org/r/20250318-virtio-v1-0-344caf336ddd@daynix.com
>
> ---
> Akihiko Odaki (4):
>       virtio_net: Split struct virtio_net_rss_config
>       virtio_net: Fix endian with virtio_net_ctrl_rss
>       virtio_net: Use new RSS config structs
>       virtio_net: Allocate rss_hdr with devres
>
>  drivers/net/virtio_net.c        | 119 +++++++++++++++-------------------------
>  include/uapi/linux/virtio_net.h |  13 +++++
>  2 files changed, 56 insertions(+), 76 deletions(-)
> ---
> base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
> change-id: 20250318-virtio-6559d69187db
>
> Best regards,
> --
> Akihiko Odaki <akihiko.odaki@daynix.com>
>
