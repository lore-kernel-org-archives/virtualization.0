Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7133D3A8
	for <virtualization@lists.linux.dev>; Wed, 21 Feb 2024 09:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509237; cv=none; b=iWO7uMiZWU5nrGTnIqQ//payooX55HXPkyJluD3ZTVQI0r/u1kQlwHGT8/1BMG1UrsZ5/kQcqW4WAa2zfroC0wb7spOLk43E6YIQNUWuVqFdirMdqYCrBtwnWgCT6hyRTOPDRdKkJqx0izN9jR5/Wb6tnXq+npb/Ggi5q6H6HKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509237; c=relaxed/simple;
	bh=9rQKbf/XB71bS0VjPXbpawybpWP+a4gMQOoTUb1QXKM=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=t/XVS6fwW4PoqJ5TgkaRxUI9XXfr/gMWNQE6LfnTRZ4VnCA31FCB8EeAkKT6qWWQxwPSXirzp9y9LC4nXKQBq4ixu/WdpsrKekwFUnyn8HVHeaMmplg1lpJgV0bbxg1gYunoFXmiFSprANzbgT1DzFhQRqc7bHmT5LRdzxzEHpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xO0JVH2K; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xO0JVH2K"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708509232; h=Message-ID:Subject:Date:From:To;
	bh=iMfzMLI+K5kpzH+OCBW/f2plocUmWvxeNdyqymsPQs0=;
	b=xO0JVH2Kv0VVpcjMm1VbGojf+LRK9g++MikJEOptw3wU4cGq9cE2HI6nqcT6rCTGISz6of0nWjDPgz/+KpKyMfmpJxBpzIfXQdEu6HOV4hpW6bmSjkKIu9B0rRFBI+4KW8qEsUkN7PFdZzTLmAnBsfSPe0ei43k5cGwE3oaSlOM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W0zZSyp_1708509229;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W0zZSyp_1708509229)
          by smtp.aliyun-inc.com;
          Wed, 21 Feb 2024 17:53:49 +0800
Message-ID: <1708509152.9501102-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 1/2] xsk: Remove non-zero 'dma_page' check in xp_assign_dev
Date: Wed, 21 Feb 2024 17:52:32 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Yunjian Wang <wangyunjian@huawei.com>
Cc: <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>,
 <kvm@vger.kernel.org>,
 <virtualization@lists.linux.dev>,
 <xudingke@huawei.com>,
 Yunjian Wang <wangyunjian@huawei.com>,
 <mst@redhat.com>,
 <willemdebruijn.kernel@gmail.com>,
 <jasowang@redhat.com>,
 <kuba@kernel.org>,
 <davem@davemloft.net>,
 <magnus.karlsson@intel.com>
References: <1706089058-1364-1-git-send-email-wangyunjian@huawei.com>
In-Reply-To: <1706089058-1364-1-git-send-email-wangyunjian@huawei.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Wed, 24 Jan 2024 17:37:38 +0800, Yunjian Wang <wangyunjian@huawei.com> wrote:
> Now dma mappings are used by the physical NICs. However the vNIC
> maybe do not need them. So remove non-zero 'dma_page' check in
> xp_assign_dev.

Could you tell me which one nic can work with AF_XDP without DMA?

Thanks.


>
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> ---
>  net/xdp/xsk_buff_pool.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 28711cc44ced..939b6e7b59ff 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -219,16 +219,9 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>  	if (err)
>  		goto err_unreg_pool;
>
> -	if (!pool->dma_pages) {
> -		WARN(1, "Driver did not DMA map zero-copy buffers");
> -		err = -EINVAL;
> -		goto err_unreg_xsk;
> -	}
>  	pool->umem->zc = true;
>  	return 0;
>
> -err_unreg_xsk:
> -	xp_disable_drv_zc(pool);
>  err_unreg_pool:
>  	if (!force_zc)
>  		err = 0; /* fallback to copy mode */
> --
> 2.33.0
>
>
