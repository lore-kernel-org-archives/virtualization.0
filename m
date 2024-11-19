Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C34D78C76
	for <virtualization@lists.linux.dev>; Tue, 19 Nov 2024 02:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731983921; cv=none; b=gMeCGUQT+P6tlrz5IQyL69wRRsY69vJ38RC2r6TyRRVRN2bqLLEIrwlc8l39gNv1AyrUZPLF06JaRqp5EpAJqmS5SII3B8WFWr09lqUIfRtDPHDfQSdX3UqNtScjpt0+KKbgJI8wEJgho5J3x2yF/HkhmTd1OA8i8MIuyMSE+qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731983921; c=relaxed/simple;
	bh=h88T5LRHfoxZhHhEif4Sh07cXOaKAeS9POEAI5tcdEk=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=TkUYWP0tYHPgj3yaSSI/Io2EqQZ1MXL2WrFUAJ4qMcRBdJ65L7txH5zUEJIwdrHuIMFEg/7TCaF2BAAuJ6RAabdv6cJzwmdc3K9W9NdL4r2YXpnnyZcOBbz70EffEUu/MRvioJ8itlXPMwQshGaaZLKZ7aW7pScQV8eK6Ub32NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qt5Z4fe8; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qt5Z4fe8"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731983910; h=Message-ID:Subject:Date:From:To;
	bh=BnlWL8nhE0ODFU1d/mjsNaaQOY7POexgc8mjipuLhaY=;
	b=qt5Z4fe8jjjOhzyVDK9m2Kctz2S93oCukadIb/OHPIs0f3kQ8nAq+dc1xaBF/v9X0whXX5bTFcup0CeWM2P9mANEsFKt+b7i0UqIwSiciaJQObpR4qKdj7amKDjlHrSnfXbeSCjPyz7nhIAzdnNgfrt6kNSgsqipwEqcZJ/VjO8=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WJmXkAK_1731983907 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 19 Nov 2024 10:38:28 +0800
Message-ID: <1731983829.623387-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio: remove the duplicate might_sleep()
Date: Tue, 19 Nov 2024 10:37:09 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "xiaowuding_jaguarmicro" <xiaowu.ding@jaguarmicro.com>
Cc: eperezma@redhat.com,
 virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 angus.chen@jaguarmicro.com,
 Xiaowu Ding <xiaowu.ding@jaguarmicro.com>,
 mst@redhat.com,
 jasowang@redhat.com
References: <20241118124056.1038-1-xiaowu.ding@jaguarmicro.com>
In-Reply-To: <20241118124056.1038-1-xiaowu.ding@jaguarmicro.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Mon, 18 Nov 2024 20:40:56 +0800, "xiaowuding_jaguarmicro" <xiaowu.ding@jaguarmicro.com> wrote:
> From: Xiaowu Ding <xiaowu.ding@jaguarmicro.com>
>
> The virtio_add_status function have done might_sleep(),so we can remove
> the duplicate calls.


Is there any problem here? If not, I think we can keep it.

Thanks.

>
> Signed-off-by: Xiaowu Ding <xiaowu.ding@jaguarmicro.com>
> ---
>  drivers/virtio/virtio.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index b9095751e..8352dfc1a 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -205,8 +205,6 @@ static int virtio_features_ok(struct virtio_device *dev)
>  {
>  	unsigned int status;
>
> -	might_sleep();
> -
>  	if (virtio_check_mem_acc_cb(dev)) {
>  		if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1)) {
>  			dev_warn(&dev->dev,
> --
> 2.27.0
>
