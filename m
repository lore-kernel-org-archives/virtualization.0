Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7E218E20
	for <virtualization@lists.linux.dev>; Tue, 17 Dec 2024 05:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734414662; cv=none; b=oF/Iw2ypNOAxT3FvVl+TeY4AG0lmhXURGt/WfK7shIkNsH3HpCkiArS0RPrOHN6THVXATgfquinBjGOlHkdUuRgQH2TwbGjWTt2jQmKwnpyvTgWp+JsDLIxdD3fpK8RH/s7o3UdCRN2IObYtKx0sTxIxhQbUmeF7BHmx+N08+WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734414662; c=relaxed/simple;
	bh=bPwQShof+vswbSf/CYo+caDqGjI4PPBpNF2MsWMY7Hs=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=UhNlh+3rpOhStklE8rTkQ6YND9aSTcF6vI2ezhrLeMAbhGBsPaWU4gxLL3ZUbpB1OVQadd66o9QcG2loLS11g3sdyTwuHcc8h0VpB7WbqiVQ6hlaRLlfoTaJmLIuGsSiXJYLJKTKR4fU9WjuQyyKzvWz1Hw7QJ47OpPCYqBgp5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sD4oeyqs; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sD4oeyqs"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734414656; h=Message-ID:Subject:Date:From:To;
	bh=k594UHrD4sW4gyFiUBIeQmb6/7gl1rH5o5a9yezmc84=;
	b=sD4oeyqs21VLo3R90ztoS5EQnBNbjB635VPVuvsWX8Uf+/1grD2DrS96L6sRUL6DDm5fTdq52wdE03ej9Z7DtzcUHEKYjlTZ25KuryMohT3WhvBqLE/WqkGh/kJvhNxmzDVSJ/5wTA+bDRE6X0sYTbG1LDzTfFTIV6gaKqeKbdo=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WLhajSd_1734414655 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 17 Dec 2024 13:50:56 +0800
Message-ID: <1734414558.011073-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio: fix reference leak in register_virtio_device()
Date: Tue, 17 Dec 2024 13:49:18 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Ma Ke <make_ruc2021@163.com>
Cc: virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Ma Ke <make_ruc2021@163.com>,
 stable@vger.kernel.org,
 mst@redhat.com,
 jasowang@redhat.com,
 eperezma@redhat.com,
 arnd@arndb.de,
 viresh.kumar@linaro.org
References: <20241217035432.2892059-1-make_ruc2021@163.com>
In-Reply-To: <20241217035432.2892059-1-make_ruc2021@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Tue, 17 Dec 2024 11:54:32 +0800, Ma Ke <make_ruc2021@163.com> wrote:
> When device_add(&dev->dev) failed, calling put_device() to explicitly
> release dev->dev. Otherwise, it could cause double free problem.

Who frees it doublely?
If device_add() failed, the put_device is called inside device_add(),
why we need to call it again?

Maybe you need to say more?

Thanks.


>
> Found by code review.
>
> Cc: stable@vger.kernel.org
> Fixes: 694a1116b405 ("virtio: Bind virtio device to device-tree node")
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>  drivers/virtio/virtio.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index b9095751e43b..ac721b5597e8 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -503,6 +503,7 @@ int register_virtio_device(struct virtio_device *dev)
>
>  out_of_node_put:
>  	of_node_put(dev->dev.of_node);
> +	put_device(&dev->dev);
>  out_ida_remove:
>  	ida_free(&virtio_index_ida, dev->index);
>  out:
> --
> 2.25.1
>
