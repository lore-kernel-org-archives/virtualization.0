Received: from out199-12.us.a.mail.aliyun.com (out199-12.us.a.mail.aliyun.com [47.90.199.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2798625333F
	for <virtualization@lists.linux.dev>; Thu,  8 Oct 2026 01:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791422563; cv=none; b=DSFt5x7ldotIZ6umiqFEHX7l4GGBxT60HNfuEpPQbZQ266hsGhvmFnX0MXfjjrqxGPgWLIQ/bW5QpDqH714m+ib1vuOrmedg0Ratnh8HRcEbJ1ewAZ086kDWl76TbXVKK4DB4WIusOYt4mnemFlVLkhwn2RyB0wW9KQr6/viKL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791422563; c=relaxed/simple;
	bh=uc4kwQMx7TYRNNY6p6KTiOQYIaCqWtRE4ben/hPGotI=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=ZHyPdzHk3eubT1LpX3GSsUU90m7ohy79WYaUUOihvmr7jluRDRrG5qX6rLpdZWfW+g9ny7j43KU1K59mJxBQ1zKujlAkEePJkTjFmBn8S/zsq50AVNgr+kl4vGKeo7yUYjBdq1blpkoFj9XQl9fbRdzQ7VFjC5bDV7J0L/2DD5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SBW2ur2x; arc=none smtp.client-ip=47.90.199.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SBW2ur2x"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1791422543; h=Message-ID:Subject:Date:From:To;
	bh=U5ODOOAC75gP3nf77qwKTJx/DrobReuOw0FDNNYKqd4=;
	b=SBW2ur2x5SZPUXoO1gdppOiiQiYvY7yNoqqEImae+DzQNb3zKlTqt10POEIxkMTKj3yiCJ4Za/bubj0ui+fowMTyT/dnZfO8YGEtHbKiJBb5QIrYHDWWgb4ekMYDI0w4XQUuG4sh2A89U2Arnj8jrsJnHLQfz1VVr9/hGiNb93Y=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0XCI8ODw_1791422541;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0XCI8ODw_1791422541 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 08 Oct 2026 09:22:21 +0800
Message-ID: <1791422498.2257345-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v2] virtio_ring: use shadow flags when detaching split descriptors
Date: Thu, 8 Oct 2026 09:21:38 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: sungbyeongchan <tjdqudcks0424@naver.com>
Cc: virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 sungbyeongchan <tjdqudcks0424@naver.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
References: <20261006102112.847280-1-tjdqudcks0424@naver.com>
In-Reply-To: <20261006102112.847280-1-tjdqudcks0424@naver.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Tue,  6 Oct 2026 19:21:12 +0900, sungbyeongchan <tjdqudcks0424@naver.com> wrote:
> Fixes: 72b5e8958738 ("virtio-ring: store DMA metadata in desc_extra for split virtqueue")
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: LLM
> Signed-off-by: sungbyeongchan <tjdqudcks0424@naver.com>
> ---
> Changes in v2:
> - Drop the commit message paragraphs as requested by Michael S. Tsirkin.

You misunderstood him.

We can not accept a commit without commit message.


> - Add Michael's Acked-by.
>
>  drivers/virtio/virtio_ring.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index db678f5a80e03..b4cb433df1dec 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -905,7 +905,6 @@ static unsigned detach_buf_split_in_order(struct vring_virtqueue *vq,
>  {
>  	struct vring_desc_extra *extra;
>  	unsigned int i;
> -	__virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
>
>  	/* Clear data ptr. */
>  	vq->split.desc_state[head].data = NULL;
> @@ -915,7 +914,7 @@ static unsigned detach_buf_split_in_order(struct vring_virtqueue *vq,
>  	/* Put back on free list: unmap first-level descriptors and find end */
>  	i = head;
>
> -	while (vq->split.vring.desc[i].flags & nextflag) {
> +	while (extra[i].flags & VRING_DESC_F_NEXT) {
>  		i = vring_unmap_one_split(vq, &extra[i]);
>  		vq->vq.num_free++;
>  	}
> --
> 2.43.0
>
