Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2092458CBF
	for <virtualization@lists.linux.dev>; Thu,  8 Jan 2026 14:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767881879; cv=none; b=ipYnMQatDRuI8biIGdzIt0e0NkgUKNmt3Kae792BA6NFWYS/tjhNL+ZsfdrS+JzvwSaaQqUjsAAfwd9xosV4g6VW4EONDdvlukyVp4CJPHPL6RRBOogi6uf+OSqYFourl4l4VY68Ko4aiHA8hWxcL5RyaL5UpnCf5vCqC7bzduw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767881879; c=relaxed/simple;
	bh=OyIQ4x46NnhuAF46QiC0P1xvTdYkXW0VaN1yOEbVEDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rPgFkObpM619B9+HRv8fHgjRMEqOQR9ERjPNxKgEyDWgmm2765bQzfqFt6a5dSCLfLvSxUSR+tRMdvNAqJtcrBusl/icHNuAVUNij8lD5jT6CqdroUMrvEObQAPRDsCqo7BVJT9bj6PrHHURhYzgX1w2etaWD6r/5fUbYYaIB1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jw1QAQ6G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jw1QAQ6G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767881876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fJ1lT1EolLhB5JifwSURg3jL1WOY3ilSvQ0LTyMqODM=;
	b=Jw1QAQ6GdokClvSBkC77ehwPMGh/nD2DGOlwFOTi2LJ7mn4zroGSKPQxV7L4dbgJyFCjMY
	6Rx8XTk5YF1TBxwb84NDT1HqbCPF7LVQyT7rlN+caWAbf51yzqAV4fCiKZSgG3/yNLuDe0
	2ZsqM6HzoT7n8W4vOtYywUN8T/KuicM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-3eDv3fxQOg2ZwuJCyVxVNA-1; Thu, 08 Jan 2026 09:17:55 -0500
X-MC-Unique: 3eDv3fxQOg2ZwuJCyVxVNA-1
X-Mimecast-MFC-AGG-ID: 3eDv3fxQOg2ZwuJCyVxVNA_1767881875
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-430fc83f58dso1811074f8f.2
        for <virtualization@lists.linux.dev>; Thu, 08 Jan 2026 06:17:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767881874; x=1768486674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJ1lT1EolLhB5JifwSURg3jL1WOY3ilSvQ0LTyMqODM=;
        b=BkrmZrh1axOeHYtFIjT6dWmvkZoCJ7bNNIw4ig56lIXCDxU/HlaXZ3BLddbO4YdSo5
         VNGYFx+pCD5Q5dVVb4mVAxVv9lvX1GY/6Hw71BpMDyHmOsVVLiE3uM9XnrSV4qBF8h2s
         nd+YeZQy13t+7FdogptytfyHOl9zv2UK8PHeONwC70L0lpABMHgR7BZ0a33X7k9XABR9
         ZxXUfanKpydxuhpBd6DPgohXG6SSwwokjPK0y+n7IadBUqhH59qwZ/AVhgEoZbGgwRiE
         eSx7xGlmy2AGXTPcUQsNkVsBsVbFdwA3aPNwCR6ZujYyR3H+M350d5cgHVd0u3jdYFmj
         aPYw==
X-Forwarded-Encrypted: i=1; AJvYcCXFluDeHfb55hN1N/Z6YBVSnQmeu0CIOfNNftXu9gkO3fpyTOGYLLF9UVPwZ613SqwnmNlV0DvEtNMHMgHP0g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyF4Q6WY/RCgsOarazjyGU/ao7qwN2fREkLppaVJqHcL71PJPaa
	KvBN5RKpI8DUS4P2mq0ogzdBLWhnrR2NwYULue8Yd29NY9SuvykYmI7lS+sYqABIT5JN0N2flGA
	maA6g7rYDYKx+DfatWUaZ9ORpNlSTcRcKdxHe5YrplG8Va/qwzr+BTYniELNLCHYGxNoS
X-Gm-Gg: AY/fxX5R+VWO2R9ZgZoiIlwvWs4nOnwk6/OGxDYlLexnPXRQB4BqTXDWTRAJf8GoUPC
	xVznES9rgDqCRj7PstueoAck8RwomOniztafTGoTmgJpdD8lvO+stAP6UbptN7I2Ek1FX3RlTSM
	CEC+5hralHb3W6nDHipy2YMQZAUvb31cXJdOsPbyq2ZRChl5flVyf8o4u6TsLaCWGyy/mXgcW2U
	1af0UVSH7y+snq/4uwINcMIDk1nctH+9gUpBP3FmWsuvgCrk6yCynO9EmTa5ODs+vC4nO3df9ia
	1/FF65Ze66SZewT3yj+bzp5kznPERBwaVNamElHIVK92JxMf+ZPV05Xb47Ln+ut4hl2XEjan6mU
	lFGTeeavGWSuZWduN80Z1nggRtKhP7ScHBA==
X-Received: by 2002:a05:6000:2483:b0:42f:b0ab:7b48 with SMTP id ffacd0b85a97d-432c3627fbamr7468082f8f.1.1767881874433;
        Thu, 08 Jan 2026 06:17:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlUVHuOj7/HPTlOMU0+NpCVpFuCnGhMJ1KC00yBihfngclSciPQ4cpm1QXhZzj17NQ1UZXYA==
X-Received: by 2002:a05:6000:2483:b0:42f:b0ab:7b48 with SMTP id ffacd0b85a97d-432c3627fbamr7468022f8f.1.1767881873896;
        Thu, 08 Jan 2026 06:17:53 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee5eesm16735262f8f.34.2026.01.08.06.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 06:17:53 -0800 (PST)
Date: Thu, 8 Jan 2026 09:17:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Petr Tesarik <ptesarik@suse.com>,
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 13/15] vsock/virtio: reorder fields to reduce padding
Message-ID: <20260108091514-mutt-send-email-mst@kernel.org>
References: <cover.1767601130.git.mst@redhat.com>
 <fdc1da263186274b37cdf7660c0d1e8793f8fe40.1767601130.git.mst@redhat.com>
 <aV-6gniRnZlNvkwc@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aV-6gniRnZlNvkwc@sgarzare-redhat>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: T6ddClHzcP2s8bmqO8VPMEs_Si5jcdbP2wIsqA7vN7Q_1767881875
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 08, 2026 at 03:11:36PM +0100, Stefano Garzarella wrote:
> On Mon, Jan 05, 2026 at 03:23:41AM -0500, Michael S. Tsirkin wrote:
> > Reorder struct virtio_vsock fields to place the DMA buffer (event_list)
> > last. This eliminates the padding from aligning the struct size on
> > ARCH_DMA_MINALIGN.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > net/vmw_vsock/virtio_transport.c | 8 +++++---
> > 1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> > index ef983c36cb66..964d25e11858 100644
> > --- a/net/vmw_vsock/virtio_transport.c
> > +++ b/net/vmw_vsock/virtio_transport.c
> > @@ -60,9 +60,7 @@ struct virtio_vsock {
> > 	 */
> > 	struct mutex event_lock;
> > 	bool event_run;
> > -	__dma_from_device_group_begin();
> > -	struct virtio_vsock_event event_list[8];
> > -	__dma_from_device_group_end();
> > +
> > 	u32 guest_cid;
> > 	bool seqpacket_allow;
> > 
> > @@ -76,6 +74,10 @@ struct virtio_vsock {
> > 	 */
> > 	struct scatterlist *out_sgs[MAX_SKB_FRAGS + 1];
> > 	struct scatterlist out_bufs[MAX_SKB_FRAGS + 1];
> > +
> 
> IIUC we would like to have these fields always on the bottom of this struct,
> so would be better to add a comment here to make sure we will not add other
> fields in the future after this?

not necessarily - you can add fields after, too - it's just that
__dma_from_device_group_begin already adds a bunch of padding, so adding
fields in this padding is cheaper.


do we really need to add comments to teach people about the art of
struct packing?

> Maybe we should also add a comment about the `event_lock` requirement we
> have in the section above.
> 
> Thanks,
> Stefano

hmm which requirement do you mean?

> 
> > +	__dma_from_device_group_begin();
> > +	struct virtio_vsock_event event_list[8];
> > +	__dma_from_device_group_end();
> > };
> > 
> > static u32 virtio_transport_get_local_cid(void)
> > -- 
> > MST
> > 

