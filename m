Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BE0249ED
	for <virtualization@lists.linux-foundation.org>; Mon,  4 Dec 2023 13:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I/4myQB4"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 625A481398
	for <virtualization@lists.linux-foundation.org>; Mon,  4 Dec 2023 13:35:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 625A481398
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I/4myQB4
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d4hvwIZZDLrh
	for <virtualization@lists.linux-foundation.org>;
	Mon,  4 Dec 2023 13:35:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9C6C98139A
	for <virtualization@lists.linux-foundation.org>; Mon,  4 Dec 2023 13:35:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9C6C98139A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701696946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rPLjkMKhb/yN6uza/CZonJukPPzHmDUsgYusJt0FzJI=;
	b=I/4myQB4zCpwLWy9x5X1TwxIp6InAHTXhHnaRnNd3Tf/xnKo1Z1rrJXFwIscSHI6GeRYe1
	2o1ql9kXRzy+r7a3V7Y4yot9v7JG+ffEIsjuBotdYKzqprA/Uw5539Qb+130zQS9EpFM/H
	XZ3ilGA0GNTQzcHJDF0XNFhoB1Mw/yA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-q1CCXdWWNgCx7ftbYxcCKg-1; Mon, 04 Dec 2023 08:35:44 -0500
X-MC-Unique: q1CCXdWWNgCx7ftbYxcCKg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40b4e24adc7so31952465e9.0
        for <virtualization@lists.linux-foundation.org>; Mon, 04 Dec 2023 05:35:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701696943; x=1702301743;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rPLjkMKhb/yN6uza/CZonJukPPzHmDUsgYusJt0FzJI=;
        b=OQ7Ykt8uvOB0yAgLPqFGe3zOTNjn9TN+qo3v0EYNJfPEsXapbjg1aQvs3py+H8GKV/
         Bbt/y7DVoDidXE/3jFab+tghNQvwcnd58dRmBfQnsrQxfsXjfd0o3M39kxiJG9tt/1To
         MF9p+UpNKfBYDwuIcymi5/rzhCq4+M/GE8cSSZX31dRH/mdHn/vQSz2OvjTahJedX1LW
         rof2j3ZbDbaUmJ/Oe9OF0auS/Zle7rCVteMD7BNyywLh1Mu69AvpxKxQXDowzoCJldSB
         ifhFEKtSsjkwXDpS/I9I1MtF3u8j4elRmldggHRF7jCVe+H/BI0IxdtlD+WQHfgO/GID
         8vgw==
X-Gm-Message-State: AOJu0Yzh/p97WdD43gHdyb2+BjBNSF9nIRuCUOqZnbTatJkcZpTYkYHO
	5bRVTpQWOyqhPOoiN2TRIrTJotbF8RS+e/vePyeTP+ymZhS5j4MgtZtS53ICfb13Y/vKH8XKx6+
	IdfmCndadkpwYAh4ag+WWvRuyt0NTMohJA2DSBo2pSQ==
X-Received: by 2002:a05:600c:5249:b0:40b:4812:22e2 with SMTP id fc9-20020a05600c524900b0040b481222e2mr3037653wmb.11.1701696943441;
        Mon, 04 Dec 2023 05:35:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDp2grvGqA7ydmNhVKG2SPd8szY8OykiJCR53YNzSTxnrJyMz3Bw/UJ5gx/+EYILIKlV3bSQ==
X-Received: by 2002:a05:600c:5249:b0:40b:4812:22e2 with SMTP id fc9-20020a05600c524900b0040b481222e2mr3037640wmb.11.1701696943098;
        Mon, 04 Dec 2023 05:35:43 -0800 (PST)
Received: from redhat.com ([2.55.57.48])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c458c00b0040b4b66110csm15028901wmo.22.2023.12.04.05.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 05:35:42 -0800 (PST)
Date: Mon, 4 Dec 2023 08:35:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>, Eli Cohen <elic@nvidia.com>,
	Si-Wei Liu <si-wei.liu@oracle.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH V3] vdpa/mlx5: preserve CVQ vringh index
Message-ID: <20231204083524-mutt-send-email-mst@kernel.org>
References: <1699014387-194368-1-git-send-email-steven.sistare@oracle.com>
 <22981f62-5c57-41c4-8ed2-a11b7b93d062@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <22981f62-5c57-41c4-8ed2-a11b7b93d062@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

It's in my tee and I'm sending it to Linus.

On Mon, Dec 04, 2023 at 08:33:22AM -0500, Steven Sistare wrote:
> What's the decision here, pull it, or do not fix it?
> 
> - Steve
> 
> On 11/3/2023 8:26 AM, Steve Sistare wrote:
> > mlx5_vdpa does not preserve userland's view of vring base for the control
> > queue in the following sequence:
> > 
> > ioctl VHOST_SET_VRING_BASE
> > ioctl VHOST_VDPA_SET_STATUS VIRTIO_CONFIG_S_DRIVER_OK
> >   mlx5_vdpa_set_status()
> >     setup_cvq_vring()
> >       vringh_init_iotlb()
> >         vringh_init_kern()
> >           vrh->last_avail_idx = 0;
> > ioctl VHOST_GET_VRING_BASE
> > 
> > To fix, restore the value of cvq->vring.last_avail_idx after calling
> > vringh_init_iotlb.
> > 
> > Fixes: 5262912ef3cf ("vdpa/mlx5: Add support for control VQ and MAC setting")
> > 
> > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > Acked-by: Eugenio Pérez <eperezma@redhat.com>
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index 946488b8989f..ca972af3c89a 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -2795,13 +2795,18 @@ static int setup_cvq_vring(struct mlx5_vdpa_dev *mvdev)
> >  	struct mlx5_control_vq *cvq = &mvdev->cvq;
> >  	int err = 0;
> >  
> > -	if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ))
> > +	if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)) {
> > +		u16 idx = cvq->vring.last_avail_idx;
> > +
> >  		err = vringh_init_iotlb(&cvq->vring, mvdev->actual_features,
> >  					MLX5_CVQ_MAX_ENT, false,
> >  					(struct vring_desc *)(uintptr_t)cvq->desc_addr,
> >  					(struct vring_avail *)(uintptr_t)cvq->driver_addr,
> >  					(struct vring_used *)(uintptr_t)cvq->device_addr);
> >  
> > +		if (!err)
> > +			cvq->vring.last_avail_idx = cvq->vring.last_used_idx = idx;
> > +	}
> >  	return err;
> >  }
> >  

