Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D6B1AE843
	for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 12:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722428095; cv=none; b=BTC7i9zfL6P9QpHC+urF0NswiC2fJBIECttqx4ClkZyDum0+tjYANQxBi79ESwDzfEj8IMN5hXlWcN4rPpV5WK/Q5koAfWW3K0bfqrzt36MuA0k9taqKbG7jKO3LW3g4BSKGg1faE2pSLT+cx0zUejn7Ck0fGlWhr0Jsg+W44no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722428095; c=relaxed/simple;
	bh=xDyq+YNzsuZmIA5MWTu0TYp70ynL/hAgNlh33JRK6GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=roFpEyRNy1gx9eV2Tk2FDxCVK0+DVVucY1pRfKHWqL4vi17l1u8/eR4u2YFtZ9ILJi+tHdk1jO459CUZQWbkWNhxH1LqDnQeGvWvpNB12xq9GYAaLsQHKa55P4By1zZMU/eyYU0QmTW+uDtcGWrT/zqVDbOVBBs3gtTUsUdx6To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FV50yzjN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FV50yzjN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722428091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9YKnyXQcFpO63RzG+wMvq5+IXaB3gH8ilGfOoPfmzUo=;
	b=FV50yzjN131S2durtYKa1EB7Ia+VdX7e5fdG3WyajZ2c8jcwpKcQkvyf/RgYLMvF9/Lkil
	m7iwh6YbaJGU3MpppsNsVQZ2d+piZ7Qhqbd6hDeOJVleBdCp5wV73VX56j0yficHY6oqmK
	Wh2Q3LP/cHTXYJ5sgHn79U+J8gaVUoQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-oR4GCN2KN3GP9MCg2HM2wQ-1; Wed, 31 Jul 2024 08:14:50 -0400
X-MC-Unique: oR4GCN2KN3GP9MCg2HM2wQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a7ac5d81e2dso537499666b.3
        for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 05:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722428089; x=1723032889;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9YKnyXQcFpO63RzG+wMvq5+IXaB3gH8ilGfOoPfmzUo=;
        b=TPILp+/xtdSLfF9Ga/7fj+GFo/YpKO82te/mB7dSKhN+aC0bTazvio4zLF6OCiHtt8
         aj7kI7XYRhG9i8+jE3MN68Ncx2q3f7IKTAivxqhAdh/3JioKvyri7+efHNDX+5aPTEcK
         m3VHkPzthFONUo/3WIr6twAeITlsE5n/WyqL+EOdjdinA2QHdgMBAFPJI397F3cPme78
         W9lKOUrRE8GGfORV6u5unOk8CBvBV/NZjPZ0JLj7Z41FiryYnEu2j03P9EXR3eR2wKrt
         qAFlKO2HuSBeOpZ/ftptkcUc5nzf7Sgby7K8CMXqMDQAxKie4K1w1/Yfo56yb7sq0Bre
         Wo1A==
X-Forwarded-Encrypted: i=1; AJvYcCUZ1WI3CBCqx8a9ySuLkbSIGGv0ol7xIcmI+UgAbUWhYI+CLKKFOjRgkCEyCiklDoPPwOmVar+rK+u4J9eMh2SklsOiIzGPziM14MCU7Lw=
X-Gm-Message-State: AOJu0YyXrp+fqkfFkEMCtyuV3pKmPFNmEKQvONroW3eqYvSARPm2opYf
	fUO0joQmHDCji2LZNr+v0BFz0S0eDWESEqUxZGzuryOyhAAHMIhPfWrqYxkfWIpD1t+mfWpndd8
	hnND3tBGxYnA2pqxvzTqckFZYHx6Dy3h18g22D5TIHL6NPVjqVxfHcUW+mTZKWUnl
X-Received: by 2002:a17:907:3da5:b0:a6f:59dc:4ece with SMTP id a640c23a62f3a-a7d3ffadd60mr1162294066b.2.1722428089066;
        Wed, 31 Jul 2024 05:14:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJ32tU5QkV3XxnRAEOGE5gGnHUsVrKVZIyaxJfKVGUTbxZ0SFn4wzHhukeXP8lcTRBjN/DCw==
X-Received: by 2002:a17:907:3da5:b0:a6f:59dc:4ece with SMTP id a640c23a62f3a-a7d3ffadd60mr1162289566b.2.1722428088281;
        Wed, 31 Jul 2024 05:14:48 -0700 (PDT)
Received: from redhat.com ([2.55.44.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad434a3sm760393866b.139.2024.07.31.05.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 05:14:47 -0700 (PDT)
Date: Wed, 31 Jul 2024 08:14:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	=?iso-8859-1?Q?EugenioP=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH net v2] virtio-net: unbreak vq resizing when coalescing
 is not negotiated
Message-ID: <20240731081409-mutt-send-email-mst@kernel.org>
References: <20240731120717.49955-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240731120717.49955-1-hengqi@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jul 31, 2024 at 08:07:17PM +0800, Heng Qi wrote:
> >From the virtio spec:
> 
> 	The driver MUST have negotiated the VIRTIO_NET_F_VQ_NOTF_COAL
> 	feature when issuing commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET
> 	and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET.
> 
> The driver must not send vq notification coalescing commands if
> VIRTIO_NET_F_VQ_NOTF_COAL is not negotiated. This limitation of course
> applies to vq resize.
> 
> Fixes: f61fe5f081cf ("virtio-net: fix the vq coalescing setting for vq resize")
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Acked-by: Eugenio Pé rez <eperezma@redhat.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
> v1->v2:
>  - Rephrase the subject.
>  - Put the feature check inside the virtnet_send_{r,t}x_ctrl_coal_vq_cmd().
> 
>  drivers/net/virtio_net.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0383a3e136d6..2b566d893ea3 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3658,6 +3658,9 @@ static int virtnet_send_rx_ctrl_coal_vq_cmd(struct virtnet_info *vi,
>  {
>  	int err;
>  
> +	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
> +		return -EOPNOTSUPP;
> +
>  	err = virtnet_send_ctrl_coal_vq_cmd(vi, rxq2vq(queue),
>  					    max_usecs, max_packets);
>  	if (err)
> @@ -3675,6 +3678,9 @@ static int virtnet_send_tx_ctrl_coal_vq_cmd(struct virtnet_info *vi,
>  {
>  	int err;
>  
> +	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
> +		return -EOPNOTSUPP;
> +
>  	err = virtnet_send_ctrl_coal_vq_cmd(vi, txq2vq(queue),
>  					    max_usecs, max_packets);
>  	if (err)
> @@ -3743,7 +3749,7 @@ static int virtnet_set_ringparam(struct net_device *dev,
>  			err = virtnet_send_tx_ctrl_coal_vq_cmd(vi, i,
>  							       vi->intr_coal_tx.max_usecs,
>  							       vi->intr_coal_tx.max_packets);
> -			if (err)
> +			if (err && err != -EOPNOTSUPP)
>  				return err;
>  		}
>


So far so good.
  
> @@ -3758,7 +3764,7 @@ static int virtnet_set_ringparam(struct net_device *dev,
>  							       vi->intr_coal_rx.max_usecs,
>  							       vi->intr_coal_rx.max_packets);
>  			mutex_unlock(&vi->rq[i].dim_lock);
> -			if (err)
> +			if (err && err != -EOPNOTSUPP)
>  				return err;
>  		}
>  	}

I don't get this one. If resize is not supported, we pretend it
was successful? Why?

> -- 
> 2.32.0.3.g01195cf9f

