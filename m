Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBB150242
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jan 2024 22:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iGcOdW7D"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0609541E56
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jan 2024 22:24:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0609541E56
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iGcOdW7D
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2CeYA_c-dQOb
	for <virtualization@lists.linux-foundation.org>;
	Wed, 10 Jan 2024 22:24:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 313E541E53
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jan 2024 22:24:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 313E541E53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704925448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fBOWuD+AHY9IJNnA7VqxZgcnrcyqcpD70bfuMsWeGQY=;
	b=iGcOdW7DBDFH5w7yQdgyfuXVb9czFyeraf3JKOYjDDKr3DROmgYwOinXlC1U3I7BkjvKep
	eBFv41vXGYVtMQXSRkoIbMaP9qK7M9Ueeq0tb1G/KldQIWn616Gt3yorjirsnFTqLJi22V
	SJgVS69ewxBWncJuz6NFhFOW/+B58Rw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-1jwvWou-OPG5QWLZAv2usQ-1; Wed, 10 Jan 2024 17:24:07 -0500
X-MC-Unique: 1jwvWou-OPG5QWLZAv2usQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40d62d3ae0cso40206465e9.2
        for <virtualization@lists.linux-foundation.org>; Wed, 10 Jan 2024 14:24:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704925446; x=1705530246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBOWuD+AHY9IJNnA7VqxZgcnrcyqcpD70bfuMsWeGQY=;
        b=MokIBId+sDElkBhnOO4jmPCCfMqlXLccvD12HI1iFbk+CcuRp8iM+ENVkAyXIYvB2a
         lc0dgUX0VUQLr8XWWfb4G41tnagLor5LLPuzKt/FLLdJTAZXbjSDh1onDCxK2agm1MKU
         hU7jmgFQqdbpOZ1MKqJudTIgdgb2HUvqTitJDF9GmPTz8188n008kdiXW7Oi68IszTmY
         idIUeZ0GyumcwElTSNUW8tq3oQpneaAT2FVvf0dA9XLU/wWssOCk5y3h5JrfIQ5YmD/G
         MNGoeh7VFI5gwQbRBacowMV3k/VFB4cxXduYVPU5ysXczh0fp44peac4TaoWF4epPEpt
         Ugaw==
X-Gm-Message-State: AOJu0YxOqbAP3w6zGbLWhg58rtNU/X72pkbv+iTQ1JbWCjoFpAmOcnqH
	QDCnCuNSgpyrspTMy2Rcc1mvejttV+tvPPc/fS8YkudrYKWAwIR+75qwQluQzxouZb9mYW6VHHV
	8R9ffKPn3lt/+cUkH+LYYA1XKc6OHsS6ZAv2BWnUxAA/P/X9KZA==
X-Received: by 2002:a05:600c:4513:b0:40d:72b9:4403 with SMTP id t19-20020a05600c451300b0040d72b94403mr53601wmo.179.1704925446472;
        Wed, 10 Jan 2024 14:24:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiLiNT7yBh6m9iddoQfphuCX3lPnIYZ1lLGnv3FnzjuC2FJxsefP3JW1UmZHgl2mqZVRb2ZQ==
X-Received: by 2002:a05:600c:4513:b0:40d:72b9:4403 with SMTP id t19-20020a05600c451300b0040d72b94403mr53592wmo.179.1704925445992;
        Wed, 10 Jan 2024 14:24:05 -0800 (PST)
Received: from redhat.com ([2a06:c701:73ef:4100:2cf6:9475:f85:181e])
        by smtp.gmail.com with ESMTPSA id s8-20020a05600c45c800b0040e527602c8sm3593896wmo.9.2024.01.10.14.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 14:24:05 -0800 (PST)
Date: Wed, 10 Jan 2024 17:24:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Si-Wei Liu <si-wei.liu@oracle.com>,
	Eugenio Perez Martin <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dragos Tatulea <dtatulea@nvidia.com>, Eli Cohen <elic@nvidia.com>,
	Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [RFC V1 01/13] vhost-vdpa: count pinned memory
Message-ID: <20240110172306-mutt-send-email-mst@kernel.org>
References: <1704919215-91319-1-git-send-email-steven.sistare@oracle.com>
 <1704919215-91319-2-git-send-email-steven.sistare@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1704919215-91319-2-git-send-email-steven.sistare@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 10, 2024 at 12:40:03PM -0800, Steve Sistare wrote:
> Remember the count of pinned memory for the device.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Can we have iommufd support in vdpa so we do not keep extending these hacks?


> ---
>  drivers/vhost/vdpa.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index da7ec77cdaff..10fb95bcca1a 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -59,6 +59,7 @@ struct vhost_vdpa {
>  	int in_batch;
>  	struct vdpa_iova_range range;
>  	u32 batch_asid;
> +	long pinned_vm;
>  };
>  
>  static DEFINE_IDA(vhost_vdpa_ida);
> @@ -893,6 +894,7 @@ static void vhost_vdpa_pa_unmap(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
>  			unpin_user_page(page);
>  		}
>  		atomic64_sub(PFN_DOWN(map->size), &dev->mm->pinned_vm);
> +		v->pinned_vm -= PFN_DOWN(map->size);
>  		vhost_vdpa_general_unmap(v, map, asid);
>  		vhost_iotlb_map_free(iotlb, map);
>  	}
> @@ -975,9 +977,10 @@ static int vhost_vdpa_map(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
>  		return r;
>  	}
>  
> -	if (!vdpa->use_va)
> +	if (!vdpa->use_va) {
>  		atomic64_add(PFN_DOWN(size), &dev->mm->pinned_vm);
> -
> +		v->pinned_vm += PFN_DOWN(size);
> +	}
>  	return 0;
>  }
>  
> -- 
> 2.39.3

