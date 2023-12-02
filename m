Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91931CABD
	for <virtualization@lists.linux-foundation.org>; Sat,  2 Dec 2023 20:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjohETuy"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 29CC3822FE
	for <virtualization@lists.linux-foundation.org>; Sat,  2 Dec 2023 20:26:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 29CC3822FE
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WjohETuy
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TkWZn4ZRBlYP
	for <virtualization@lists.linux-foundation.org>;
	Sat,  2 Dec 2023 20:26:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 347AA822FC
	for <virtualization@lists.linux-foundation.org>; Sat,  2 Dec 2023 20:26:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 347AA822FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701548773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iZJKmBTJ+Rbbpx8uaCWzSm8u5JZ8h0qLae0DxmI9+YE=;
	b=WjohETuyYMZohx9UabLQRTp7bYywPzrBF8RvrjA3jXGDJf+elacBtY/gIwQ/XR+ptjyW9j
	SU229D01Ma89V2oVgFcg1XW/aUI5XWYMJELLxmc/lYQFVIwofvW6/l+jEjyiV3IXNYTBnh
	b/jXZlNMZsQEpVet18Iyu+kjHieTxq8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-iIhh2PX1Mu-z-m7AhmuWfA-1; Sat, 02 Dec 2023 15:26:11 -0500
X-MC-Unique: iIhh2PX1Mu-z-m7AhmuWfA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-333405020f3so199322f8f.1
        for <virtualization@lists.linux-foundation.org>; Sat, 02 Dec 2023 12:26:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701548770; x=1702153570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZJKmBTJ+Rbbpx8uaCWzSm8u5JZ8h0qLae0DxmI9+YE=;
        b=GLdu+aJmH4TLYq1h4M6JRu2wjfUyFLnfZHn+Y1Qt5vnhDD9xdXeIJWjiIj66WF0g8R
         6VbvB9m768nHoPEXdYuJz5+fFsYt3gNqQ4+0ye0Sft+RzQFPUmfvEuK5DHyX5gmotf8T
         GaOQFc2tRTfXd9+jlQPhDfjSV+BFVrnTV/1inUqYBTPHd8AEW3CCH16HaMOrOd+tdEm9
         6MaklrWbPaHBPXesRei6pdsZqGTyvi9aDGNRVAKR7i7SOyv077TDAqZa0ZGWaRJfgIzR
         P4pCpbbE7A+rX7qIFFIxncbyp5fao2A213bdenHPE8Aqn9rxQeJralnjD7TGI9v68+0K
         nC6Q==
X-Gm-Message-State: AOJu0YzPQluESKJvV84L0ZBogNewBrF3gUNKgtRLG9X04lodVm1QTwPb
	LfgqgJSl7/8aIF+nTbD0AtP9oGR5UajkiAXEyPDjwAijuk3W9HtjqPjeApvzCYDcp2HHQREu5Dj
	nplo6Fwan7oAGTaQP/AVtQvHfwQAs3GEhNCmtZScD/Q==
X-Received: by 2002:a5d:5485:0:b0:332:d11d:527c with SMTP id h5-20020a5d5485000000b00332d11d527cmr1940789wrv.8.1701548770112;
        Sat, 02 Dec 2023 12:26:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWSenljZ8Gq1p+cvw45tJ66/qyTEFm/51Rm7X9PzXUkLubJG54yM5edqJ1p/+3klDKGwcuJA==
X-Received: by 2002:a5d:5485:0:b0:332:d11d:527c with SMTP id h5-20020a5d5485000000b00332d11d527cmr1940784wrv.8.1701548769779;
        Sat, 02 Dec 2023 12:26:09 -0800 (PST)
Received: from redhat.com ([2.55.57.48])
        by smtp.gmail.com with ESMTPSA id e5-20020a5d4e85000000b0033333bee379sm4281524wru.107.2023.12.02.12.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 12:26:08 -0800 (PST)
Date: Sat, 2 Dec 2023 15:26:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Eugenio Perez Martin <eperezma@redhat.com>,
	Si-Wei Liu <si-wei.liu@oracle.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <galp@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 0/7] vdpa/mlx5: Add support for resumable vqs
Message-ID: <20231202152523-mutt-send-email-mst@kernel.org>
References: <20231201104857.665737-1-dtatulea@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20231201104857.665737-1-dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 01, 2023 at 12:48:50PM +0200, Dragos Tatulea wrote:
> Add support for resumable vqs in the driver. This is a firmware feature
> that can be used for the following benefits:
> - Full device .suspend/.resume.
> - .set_map doesn't need to destroy and create new vqs anymore just to
>   update the map. When resumable vqs are supported it is enough to
>   suspend the vqs, set the new maps, and then resume the vqs.
> 
> The first patch exposes the relevant bits in mlx5_ifc.h. That means it
> needs to be applied to the mlx5-vhost tree [0] first.

I didn't get this. Why does this need to go through that tree?
Is there a dependency on some other commit from that tree?

> Once applied
> there, the change has to be pulled from mlx5-vhost into the vhost tree
> and only then the remaining patches can be applied. Same flow as the vq
> descriptor mappings patchset [1].
> 
> To be able to use resumable vqs properly, support for selectively modifying
> vq parameters was needed. This is what the middle part of the series
> consists of.
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/log/?h=mlx5-vhost
> [1] https://lore.kernel.org/virtualization/20231018171456.1624030-2-dtatulea@nvidia.com/
> 
> Dragos Tatulea (7):
>   vdpa/mlx5: Expose resumable vq capability
>   vdpa/mlx5: Split function into locked and unlocked variants
>   vdpa/mlx5: Allow modifying multiple vq fields in one modify command
>   vdpa/mlx5: Introduce per vq and device resume
>   vdpa/mlx5: Mark vq addrs for modification in hw vq
>   vdpa/mlx5: Mark vq state for modification in hw vq
>   vdpa/mlx5: Use vq suspend/resume during .set_map
> 
>  drivers/vdpa/mlx5/core/mr.c        |  31 +++---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 172 +++++++++++++++++++++++++----
>  include/linux/mlx5/mlx5_ifc.h      |   3 +-
>  include/linux/mlx5/mlx5_ifc_vdpa.h |   4 +
>  4 files changed, 174 insertions(+), 36 deletions(-)
> 
> -- 
> 2.42.0

