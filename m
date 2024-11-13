Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAB0170A27
	for <virtualization@lists.linux.dev>; Wed, 13 Nov 2024 06:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731479543; cv=none; b=E5WcwGHh2snJhDry9vXx9ZhPrYO7QKP+6w29VRvjNF4ss97vPk9ktX9nTRuDe9G7i33B3q9QIzjhETfJOjXbZk0LDJntIuW6uK5l/WC3pLIKWoc7lCsr7njYB0w3x3jNbxUyNcoveOCF0FOsPDu5jJZ04XbPbNSJUUKLX+lRHSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731479543; c=relaxed/simple;
	bh=dfPlndrRvx5LRPZ+CoWGofFBd31blE9k7qzq28w1Fn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UC6TJFR/rWfihJ/U9b1OY4j0RTzM6G9k6drBAv+8ixwiwyEwtPpKizABAwB240fxjhgJAiZbKHDdLu9StWzkRoHAqn7euMEqEtn8oy8zZfNfnUgRoIWJs2vumFYTYnZOTWtnEL2+kghGXHvPoJeyXdzZkigH0IzluxtYazVyHV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AR2KwfE1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AR2KwfE1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731479541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0tpZJUhLYkQvz4/1c+WZKWxrz55qwMuTFTv1urMtlfE=;
	b=AR2KwfE1sU9T4PqANJWjB++TCVQpmw5dcHNyfCADVoXtkfsrdqW004s4TPF2ImdfsrVbNv
	Ohu7TuYTcccdDLfXVlqRvwWGV9Kw7tCo49BUfXb1BN0y6djbwAe8A8jy+OuCL0SonjzX1v
	Cfx4vb8E9eNN0EocpXnZbbiORO628bc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-lUm45JQ8NUq_AVWbg2I3EQ-1; Wed, 13 Nov 2024 01:32:17 -0500
X-MC-Unique: lUm45JQ8NUq_AVWbg2I3EQ-1
X-Mimecast-MFC-AGG-ID: lUm45JQ8NUq_AVWbg2I3EQ
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d5606250aso3335378f8f.2
        for <virtualization@lists.linux.dev>; Tue, 12 Nov 2024 22:32:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731479536; x=1732084336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tpZJUhLYkQvz4/1c+WZKWxrz55qwMuTFTv1urMtlfE=;
        b=DQg1HFq+jxyMorLJ3vVLVbvvqyFN494HhkrD4fXl7Ph/+LyPVVESf4Ag4V1gDpRPtp
         lH4Jat1EUDUSL4lbPeUJ+qD7snwDbRa5zCy8r2nUO9XDhDTWF5B8n/rGsSHtbDAYswZS
         Qz1feedeqBXCzly6sqa9GyTaJKpYrTeUcvb8UrrHNJcdue1Q4X1ns24VopZxbgwGWP17
         i62jltw6M8LmjQ0eq59dafNCiXMdooYqmOeJBfp5ezdWfav10QyaQBn0UmMOS8YsrISM
         a8VEpJTsfX2vTt1Sjjw1KlQPAqq1QUVBp2n3HHGgr8z27dbCnyEfZ2B5H1Sb5XEZAeaZ
         l4xQ==
X-Gm-Message-State: AOJu0YzpptOGyQfzBucIRI7xU+tE5yOfWpKZ7WTH3IRokKWyeKJ0su+U
	p4M8XfAvtbIMviq2UtxA1sblRVR4+txnAcWgDYtOQURbjokH40K0M4oxmHDoKTojsrOamh0UXgI
	/OvbJuu9S4MaNebGmy0NTn/QoKy8tkGJS3ufGMA7hI+uVgIghrFqk54YiIRfnFmBL
X-Received: by 2002:a05:6000:70d:b0:37d:3e6d:3c2f with SMTP id ffacd0b85a97d-381f1883bc1mr15818762f8f.47.1731479536586;
        Tue, 12 Nov 2024 22:32:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFm7j62RQtg2vMQRf7xE09cRkKXHfFgJ32M3aHTjmYlfby7/gQk3bMsScUdd8LU3HRpv1DW5w==
X-Received: by 2002:a05:6000:70d:b0:37d:3e6d:3c2f with SMTP id ffacd0b85a97d-381f1883bc1mr15818736f8f.47.1731479536229;
        Tue, 12 Nov 2024 22:32:16 -0800 (PST)
Received: from redhat.com ([2a02:14f:17b:c70e:bfc8:d369:451b:c405])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9f8984sm17650303f8f.71.2024.11.12.22.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 22:32:15 -0800 (PST)
Date: Wed, 13 Nov 2024 01:32:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: virtualization@lists.linux.dev, Si-Wei Liu <si-wei.liu@oracle.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio Perez Martin <eperezma@redhat.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 2/2] vdpa/mlx5: Fix suboptimal range on iotlb
 iteration
Message-ID: <20241113013149-mutt-send-email-mst@kernel.org>
References: <20241021134040.975221-1-dtatulea@nvidia.com>
 <20241021134040.975221-3-dtatulea@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241021134040.975221-3-dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WYDaCxgAgRRcy8WtNJy5fgj43BgaSpTN2BijSbPC-Ww_1731479537
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 21, 2024 at 04:40:40PM +0300, Dragos Tatulea wrote:
> From: Si-Wei Liu <si-wei.liu@oracle.com>
> 
> The starting iova address to iterate iotlb map entry within a range
> was set to an irrelevant value when passing to the itree_next()
> iterator, although luckily it doesn't affect the outcome of finding
> out the granule of the smallest iotlb map size. Fix the code to make
> it consistent with the following for-loop.
> 
> Fixes: 94abbccdf291 ("vdpa/mlx5: Add shared memory registration code")


But the cover letter says "that's why it does not have a fixes tag".
Confused.

> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  drivers/vdpa/mlx5/core/mr.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index 7d0c83b5b071..8455f08f5d40 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -368,7 +368,6 @@ static int map_direct_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_direct_mr
>  	unsigned long lgcd = 0;
>  	int log_entity_size;
>  	unsigned long size;
> -	u64 start = 0;
>  	int err;
>  	struct page *pg;
>  	unsigned int nsg;
> @@ -379,10 +378,9 @@ static int map_direct_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_direct_mr
>  	struct device *dma = mvdev->vdev.dma_dev;
>  
>  	for (map = vhost_iotlb_itree_first(iotlb, mr->start, mr->end - 1);
> -	     map; map = vhost_iotlb_itree_next(map, start, mr->end - 1)) {
> +	     map; map = vhost_iotlb_itree_next(map, mr->start, mr->end - 1)) {
>  		size = maplen(map, mr);
>  		lgcd = gcd(lgcd, size);
> -		start += size;
>  	}
>  	log_entity_size = ilog2(lgcd);
>  
> -- 
> 2.46.1

