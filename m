Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1351140D716
	for <virtualization@lists.linux.dev>; Thu,  8 Jan 2026 14:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767881519; cv=none; b=ID+w314swcJtyezRGKnkg5ji1ROJ/FaK3W/gym5SvKXhn225DmrLalRbDiEutk0kAQCwQeVRLYhCmRu6B0npjVrhfrQHVMwT6YLaunB1PtDmzuVlfyrei+9I0szQErBrXtFGB4MjY2cqy2dH7xvvGCIvqlJoJHLoA/kz1eM5Z2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767881519; c=relaxed/simple;
	bh=AFb8yUemGFVP+E1zn7JOJ8f6bE4z7sRVkT9bi0zm4eY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=asWiuwFwDpevcAXnb9lrdkcm2r7NzOeefqxNslUAgvL2OLzn+uGl6qIpNDDX96q1mDDhg/Ka3EJfb+ENGw03oyY6ocUCD40QWHVHFLwJpEcZz6OiJ1+wrjqQuzr9TP3LcJP0ILwFUgfXmChS3jfJPPSr9j6YmIJZak+aQcu4edg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZYspJI45; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZYspJI45"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767881517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PajL1D9j4AF6hqkkrLXFCZ4j8C7K2WP8fPkzMuDGb9E=;
	b=ZYspJI45MQXRGPwBNwrGxvfCjkovRKzgFgCIXO04g+MC7fzQ/mRUgXP33W8kcSxODQ03Zc
	WB2RHv3gQjC5gfPZA5S6UL0jbDykQhTo9QlELw/mQbj6iy8JcV9qge1EXlAM8SCPLHQTZG
	buFs+XeR97qOt8QZL5+Gs6q5wP0t790=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-WuB3uGL4MJy1tEnjgS9JoA-1; Thu, 08 Jan 2026 09:11:56 -0500
X-MC-Unique: WuB3uGL4MJy1tEnjgS9JoA-1
X-Mimecast-MFC-AGG-ID: WuB3uGL4MJy1tEnjgS9JoA_1767881515
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-64d251b8c5dso3844316a12.1
        for <virtualization@lists.linux.dev>; Thu, 08 Jan 2026 06:11:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767881515; x=1768486315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PajL1D9j4AF6hqkkrLXFCZ4j8C7K2WP8fPkzMuDGb9E=;
        b=IxgJYcTxjTqoNwV/G1W4dmssQpAwqXJul+vLWzhz0vm0z0jMI954ewdVRpqPikqri3
         8Uc1+sxFPPt9hOUF2e1/dnzZpczF60nwZt18XSmTMQjO0r2P4xiWPwcR0mnSbARV1myj
         8ls1rouKrxNCJv+f1HVb4DBBB9wSHkB8zA8pXCdqU/wXXvTVUndStBtBkHflyWHcTgeq
         eEZdVMwa05Q8E4yWIXMrw0ph0snqKyTyz+3oOm22q7bMIu79/1HrgTAQqRkE9YZGTUdx
         DneCjeL28P87orBTioIqlPk5NZZxXXq1H746fHLnW4Wfg2DFYRXCFWJzVyZhBr9/NVhB
         7sxg==
X-Forwarded-Encrypted: i=1; AJvYcCXH3il0NpQDWr8Sl2USC0//22nvyEJNOJfZ9yLrfj5mKowFt2m2vyHI7NTSkH51GrrAHEOVAuCmfwSFmjRRWg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzSHiwFlX2utRQLrwWl69yrUbhT2l38B5EFRHNT23KCNnK01Pa6
	vz8culem3eIBNozyEFcVGwZ3BLpx2rJfJZSrKb31E32SXoLJBdQR+lGPQlVhLdIj7tT0t9K3qN/
	j/mFllNWobtfaD70NJP2cpTETTUn56KuW0fgtrEf1r+bOVwi1M6/v5NqJWsnReUcY7VfJ
X-Gm-Gg: AY/fxX4kcX8M/B1/Mlyu/wbuS5XhD7aiLX5Yj9RLvXWsguue3ib8A4nHxTKxsafbF2v
	zietbzdVfGh83/p13AR/i2Nb4J0HjQjrpQhZuylUPdH02KI087ouY355wUwkTjiXLOj7gAUMvph
	nB+mHh35Z+swbseifXLnRswKKuNefHo7rj9uIlpSUkdBW4tcnbCnMrmbLFpsUtrjfZG3Ja4Hr2L
	3W8SLvxDsdaiMsAl/8GBF5hYIAhfojRB9CMVMRPxlYHccFKb8QjsU7Yx+KS1bV8rDgfSYB5BC5r
	1uHE1yTr+bhIiorwVmRsQEWfGNlYk7Ds3NCjDKIs1T6WUJ7h4GL6vnike65peBXn6GzA0U7ecAV
	O4QZyljcrNusrYQln
X-Received: by 2002:a05:6402:358c:b0:64d:1bbf:954a with SMTP id 4fb4d7f45d1cf-65097e01237mr6010688a12.15.1767881514755;
        Thu, 08 Jan 2026 06:11:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFH4GSSsuHOuOKzAWjnLjL93ZyftULQdKpADud0o+HUDbYN/JI+jAlKmTdijyyr2Y36a7d4Rw==
X-Received: by 2002:a05:6402:358c:b0:64d:1bbf:954a with SMTP id 4fb4d7f45d1cf-65097e01237mr6010647a12.15.1767881514187;
        Thu, 08 Jan 2026 06:11:54 -0800 (PST)
Received: from sgarzare-redhat ([193.207.223.215])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf65ca0sm7641163a12.24.2026.01.08.06.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 06:11:53 -0800 (PST)
Date: Thu, 8 Jan 2026 15:11:36 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Olivia Mackall <olivia@selenic.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Jason Wang <jasowang@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Petr Tesarik <ptesarik@suse.com>, Leon Romanovsky <leon@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Bartosz Golaszewski <brgl@kernel.org>, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, virtualization@lists.linux.dev, linux-scsi@vger.kernel.org, 
	iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 13/15] vsock/virtio: reorder fields to reduce padding
Message-ID: <aV-6gniRnZlNvkwc@sgarzare-redhat>
References: <cover.1767601130.git.mst@redhat.com>
 <fdc1da263186274b37cdf7660c0d1e8793f8fe40.1767601130.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <fdc1da263186274b37cdf7660c0d1e8793f8fe40.1767601130.git.mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kEhgbDBgRRZEMSt3y1tLivqTpP7OKoVIaFgWY9oIdrc_1767881515
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jan 05, 2026 at 03:23:41AM -0500, Michael S. Tsirkin wrote:
>Reorder struct virtio_vsock fields to place the DMA buffer (event_list)
>last. This eliminates the padding from aligning the struct size on
>ARCH_DMA_MINALIGN.
>
>Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>---
> net/vmw_vsock/virtio_transport.c | 8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index ef983c36cb66..964d25e11858 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -60,9 +60,7 @@ struct virtio_vsock {
> 	 */
> 	struct mutex event_lock;
> 	bool event_run;
>-	__dma_from_device_group_begin();
>-	struct virtio_vsock_event event_list[8];
>-	__dma_from_device_group_end();
>+
> 	u32 guest_cid;
> 	bool seqpacket_allow;
>
>@@ -76,6 +74,10 @@ struct virtio_vsock {
> 	 */
> 	struct scatterlist *out_sgs[MAX_SKB_FRAGS + 1];
> 	struct scatterlist out_bufs[MAX_SKB_FRAGS + 1];
>+

IIUC we would like to have these fields always on the bottom of this 
struct, so would be better to add a comment here to make sure we will 
not add other fields in the future after this?

Maybe we should also add a comment about the `event_lock` requirement we 
have in the section above.

Thanks,
Stefano

>+	__dma_from_device_group_begin();
>+	struct virtio_vsock_event event_list[8];
>+	__dma_from_device_group_end();
> };
>
> static u32 virtio_transport_get_local_cid(void)
>-- 
>MST
>

