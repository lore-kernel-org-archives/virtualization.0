Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4019F1B0402
	for <virtualization@lists.linux.dev>; Fri, 13 Jun 2025 01:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749779597; cv=none; b=P2jXhr5Gxgik0q7HoOOs29V3Pti3sUsZcL8bKX65Duw6ACpZgncBIQseBvnF89NOFR4G5CGOKInaRLfRWr5yjMyzeT0SZnU8sisF75FiwcksbaVp+F5yGgfRlocRvoEpvBeiAxq3nCfrSpKefzfnQYfsa45uDHGme5LMKH9hXMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749779597; c=relaxed/simple;
	bh=q2CeiThjXnBn+PX0vpfkOk8gxArW4doBcjm6JOl6Xd4=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=OcdDk+zBOyiqFGrJjwXacNJwMJ09EtyCtow8nCiUYb/shySGDtiIha9L/Gf+VGQsm2ABxmyKe5RR+YL7YKOM8fd6pCAs6drt1ElybU4SyKkcU0S+Sakl0V+1D8vP2doxRqoYocxen6GK717cDMvvVM4f9pgWqk+a9exs0fEv/lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=D11dQ9Fr; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="D11dQ9Fr"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1749779593; h=Message-ID:Subject:Date:From:To;
	bh=5Oe5PaQlPk7LtILWAf2eOzYErXMVWS9+usSmUJzI5Dc=;
	b=D11dQ9Fr8ZhlYdkGKecfmI9RBh52MBPq1oKo+h7vm4DNEUnzEWUJAM4AhRbDcYyNIWxvUBsfyuxj1UB2zMKnQnCr7WPI20FtoM+0NB6P1jH0iVeKOVBQXEKF1zA2RJYJV1EX8/FW+6w+n0xD4L2ETY7r/q8RQ4i2pRmozDDCKbs=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WdifYuV_1749779592 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 13 Jun 2025 09:53:12 +0800
Message-ID: <1749779585.8414617-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio: document ENOSPC
Date: Fri, 13 Jun 2025 09:53:05 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <2e6ec46b8d5e6755be291cec8e2ec57ef286e97b.1748356035.git.mst@redhat.com>
In-Reply-To: <2e6ec46b8d5e6755be291cec8e2ec57ef286e97b.1748356035.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Tue, 27 May 2025 10:27:19 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> drivers handle ENOSPC specially since it's an error one can
> get from a working VQ. Document the semantics.
>
> Reported-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
>  drivers/virtio/virtio_ring.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index b784aab66867..97ab0cce527d 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2296,6 +2296,10 @@ static inline int virtqueue_add(struct virtqueue *_vq,
>   * at the same time (except where noted).
>   *
>   * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
> + *
> + * NB: ENOSPC is a special code that is only returned on an attempt to add a
> + * buffer to a full VQ. It indicates that some buffers are outstanding and that
> + * the operation can be retried after some buffers have been used.
>   */
>  int virtqueue_add_sgs(struct virtqueue *_vq,
>  		      struct scatterlist *sgs[],
> --
> MST
>
