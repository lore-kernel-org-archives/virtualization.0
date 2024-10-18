Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25DA1EE020
	for <virtualization@lists.linux.dev>; Fri, 18 Oct 2024 14:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729262393; cv=none; b=DHC2ZIzHL6jmsbYong9w3Ly5CMqrGju8fKjdr6dnatytIRGMQm2nmeZw0wFzGb9Bh3BuxGBJU+5ChhkqZjpF1/Ql8slI6mEi8jnqxK5EDwJ8GC/C+REx0E0zpdtOUG1tcdgM5937llEiUrvi0hul2vYZahe4gNXFu8n2KiLPAKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729262393; c=relaxed/simple;
	bh=tr8jRKAqh09ouuyihQan5X+g0ShJthMmUZ6d8PXsqVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HwYZIaZQE3IxMi2NSFASGyQQV8FgfHwJZGqoHj47AjPphoAsijVjwJSZxGPV0IX05lI+Settpvih2JM1itUluUY0wiCtEsl71XWw1M35Guz/5mRTraoQVZIz52k0RFLmvJJgyjtfjvqssiKJyRA5MrForSmg+yzRwxWZ3B+pGvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C2Zdztnc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C2Zdztnc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729262390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q1kdgqSpUkHaDdHlWc2ZMvh2f7J4lCZH1eEq8CMsWKE=;
	b=C2ZdztnclnUwcoZngtsNEH0Ju7G6NUFhjXhUOArCugU4unweLJ4nHXjh5p+T41wRqATeBJ
	XFS6MpggafdKy//Nrn8IN+7XvSmDW5Z9oko9/3cD0Q51b6i8J7x+9nelNRz/r8oiviJKIT
	RIvjkLHm3sfwLysk2rn3i6UrULY3otI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-FxfY5KvGO9m7HPx_jWXXyQ-1; Fri, 18 Oct 2024 10:39:49 -0400
X-MC-Unique: FxfY5KvGO9m7HPx_jWXXyQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6cbec7fbf1cso28610426d6.1
        for <virtualization@lists.linux.dev>; Fri, 18 Oct 2024 07:39:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729262389; x=1729867189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1kdgqSpUkHaDdHlWc2ZMvh2f7J4lCZH1eEq8CMsWKE=;
        b=ArdEi8E71ApJjvkMArAzX6vM8ctRSrmRpg74hYwMT1nv+Bn7sTQQSYV/kobyTQnw3D
         vA6okezw/OC1ZJ83t2olw4zvyXi4HdHMu8KsZYiITlGzcbqX9G1pymE6J+ikBV+u9kXV
         H4VC5+mkKE6VR8gen0hFKH7Ei/A3qSF0kDlUm8d78kJSJnxTVupvNUItHI9VXt0tBPyl
         JyzWm1gwwNeHY3naZcQ3Zhmq/pTLKgEC4ZHHMvqYjMcii+DPnDjgm9MstqlcdIH9qW6/
         dWKKnZy6rSzsAJiP0a5D7ZmW8fClMtF9kkHcB3eu9UbtVzdL5JMtOjJnq8sQs6twT4kT
         ofwA==
X-Forwarded-Encrypted: i=1; AJvYcCUEiObiGyRfxAREQer88XR2Mw7uSW62PylTL0aOGXS0Pq9tbqAvQc5LWWdYXO5yD/4HXhK0XXk6mJk6GPsN2w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxak59DKidDEf0tQoxDzCUjdIzDvMP5kQ0zQvGTItROr/yOaF8J
	ZvKocwUG2Nhgg86YQ7X9AjYMNab6BfDTns6bia8mboNu1tdU63jKyCiv/PQ2iM6ynZhSy4ksrlx
	xOXTfgxM+LRVGKb/Jlag7Ln9wTpq9jUrivAwhGOeSN/mHkRfXR1wsCYpDGJv2YJ2o
X-Received: by 2002:a05:6214:5541:b0:6cb:20b6:f398 with SMTP id 6a1803df08f44-6cde150dd18mr34710856d6.21.1729262389301;
        Fri, 18 Oct 2024 07:39:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsprW5VkpYV0rcxGwN4Pw/bcWrNG/R/XuTyrPHGf/vzAwEznM75iAODlOWI+en0Ua/metoMA==
X-Received: by 2002:a05:6214:5541:b0:6cb:20b6:f398 with SMTP id 6a1803df08f44-6cde150dd18mr34710536d6.21.1729262388975;
        Fri, 18 Oct 2024 07:39:48 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cde115577csm7560936d6.55.2024.10.18.07.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 07:39:48 -0700 (PDT)
Date: Fri, 18 Oct 2024 16:39:41 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, 
	"Colin King (gmail)" <colin.i.king@gmail.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org
Subject: Re: [PATCH] virtio_net: fix integer overflow in stats
Message-ID: <riu6774ovfsubpe3zzuehfmzr2lz4slv6wmcsenoewl47nukf6@ba2tode64wby>
References: <53e2bd6728136d5916e384a7840e5dc7eebff832.1729099611.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <53e2bd6728136d5916e384a7840e5dc7eebff832.1729099611.git.mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Oct 16, 2024 at 01:27:07PM -0400, Michael S. Tsirkin wrote:
>Static analysis on linux-next has detected the following issue
>in function virtnet_stats_ctx_init, in drivers/net/virtio_net.c :
>
>        if (vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_CVQ) {
>                queue_type = VIRTNET_Q_TYPE_CQ;
>                ctx->bitmap[queue_type]   |= VIRTIO_NET_STATS_TYPE_CVQ;
>                ctx->desc_num[queue_type] += ARRAY_SIZE(virtnet_stats_cvq_desc);
>                ctx->size[queue_type]     += sizeof(struct virtio_net_stats_cvq);
>        }
>
>ctx->bitmap is declared as a u32 however it is being bit-wise or'd with
>VIRTIO_NET_STATS_TYPE_CVQ and this is defined as 1 << 32:
>
>include/uapi/linux/virtio_net.h:#define VIRTIO_NET_STATS_TYPE_CVQ (1ULL << 32)
>
>..and hence the bit-wise or operation won't set any bits in ctx->bitmap
>because 1ULL < 32 is too wide for a u32.
>
>In fact, the field is read into a u64:
>
>       u64 offset, bitmap;
>....
>       bitmap = ctx->bitmap[queue_type];
>
>so to fix, it is enough to make bitmap an array of u64.
>
>Fixes: 941168f8b40e5 ("virtio_net: support device stats")

Release with v6.10, so should we cc stable?

>Reported-by: "Colin King (gmail)" <colin.i.king@gmail.com>
>Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>---
> drivers/net/virtio_net.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

>
>diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>index c6af18948092..b950d24b1ffa 100644
>--- a/drivers/net/virtio_net.c
>+++ b/drivers/net/virtio_net.c
>@@ -4112,7 +4112,7 @@ struct virtnet_stats_ctx {
> 	u32 desc_num[3];
>
> 	/* The actual supported stat types. */
>-	u32 bitmap[3];
>+	u64 bitmap[3];
>
> 	/* Used to calculate the reply buffer size. */
> 	u32 size[3];
>-- 
>MST
>
>

