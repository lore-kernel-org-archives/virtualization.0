Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795681370;
	b=thSxNj+eoIsqhGwfAldAIeQTKqBIhsLDlJJEfk8ExgTEA7tL9hG9sCX//Kr5gG7/2VT+
	 IilDvYqmTQIxerKN5u0vyzlBuKzmJVPXaQrmK8rFWRyrCWfW3X5Y53wIliLVLe/iULAgL
	 47RdxUMZm1aw+WwBxMqJgnzNLMrLpRhjDHUl1/sw899IHgG3rFy0esLUYh+yprFaXWwq5
	 r4qkkZdb0W717SLQytmT97NDRdFB+2abDv+t7RNd/f8xT5uMwm6V56MRr3L2hGO13vteX
	 dnjGDqAvAaDgsjZGWAQlD54PLA0/qxOSnRIvIBHRFaQszkQ5ZS7JPjA0C7mdSR24eFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795681370;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=UuzcaLyN6RLUXtVT1o8la7JSr9QEiYhwf5LDlCY+ywE=;
	b=Q71K30eq60I+89hjAPqiIlgi2m1XTLG8ypJDLdnBs+j32qgVL/jAjGH6wvNs7/dNVCBA
	 xN7BmT/oAH38CmRaw7SmDqAWWDJts2KEI2YdGXLEYrvaha7FphZgI5xW8diwmXU3lKGU2
	 2m3x3G00JYwNdPAePZIukCjTDT6RqCHUVG1pnyod4sqtiy+nF1LO0k8Z1/TOJVD3T6/I6
	 2GoGlyxlqOCKQPSswWQ++Srs8ue9EW4qDTbzto+sbpedX7h58o6TgfKFp5VmIFF4NJh53
	 f35vQfPFFCrcAOyNhjAHJb1USK/zQp6rWXImk1sSiNm1IgsVnShucvSS+rUIffA107Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iHApDl1n;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4EB606A33C
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 08:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A4EB606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iHApDl1n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795681368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UuzcaLyN6RLUXtVT1o8la7JSr9QEiYhwf5LDlCY+ywE=;
	b=iHApDl1n0VMUblsxzNNSz4OjypRcNKOLOz1HoMWN50JNaBQ8JVg/60oVA7Aqb6lAMF96WS
	JmFtpFhzW6AY7cByA8MT1OUQHNekSvqUp5LAJ2ishkk0k5X8ByVk+RD/hVlCZ/58xilN6w
	UXw78b2dWXKNTKalWGxvHJ3IGbbupSU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-b7xMTwrXP3O0PGsTbcj1OA-1; Thu, 26 Nov 2026 08:22:47 +0000
X-MC-Unique: b7xMTwrXP3O0PGsTbcj1OA-1
X-Mimecast-MFC-AGG-ID: b7xMTwrXP3O0PGsTbcj1OA_1795681366
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a359c7f47bso55744165e9.2
        for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 00:22:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795681366; x=1796286166;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UuzcaLyN6RLUXtVT1o8la7JSr9QEiYhwf5LDlCY+ywE=;
        b=eModWYWJ1VTfRxQDwPTcLyD2GFYtknzzDCMHPBlrQchr5FqwxYf78N3CH8JR/S9Y9f
         dCU80qRaIR7/jIqxd4EdVaaqOcrd4Hsw9hNdgIk4HKzVz0GwN+mKKQqHMDf/6hvGff7f
         Ka/ZbZSI9U2+KdpaHGHKXxUJtguDHwi1xx66ZjxkqBUWLxkM5sRo0mRmmlEUTI1X1uCW
         XWPgay/wvKGR5FX+NHSDNwOghiMXooTPpJKE53rxAVl9+Qc9gCmHGFSVp+AqJ50tELr1
         E4BYcKTAYWXGAWlV+zQFMokBZFilQEAQIFRMIrroGQatrjBSy5R3MQmfOik+BZZU6VkD
         StdA==
X-Forwarded-Encrypted: i=1; AL+hErG6kb1kZEUjiL98Ua7IVhghaJTGwLysG9vrqQnUhjrOhTNIbbuDxXt3BEl3BqDVAnyHGqV8mJvk2tGtGvLnwA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+lDrnZz2x7SG4EVmg6rMVHwIjtaUXQ4Ox6E6JqOweVncU52E9k
	t05L2LiEqtUofdUL4a9PWXCLuB+lr0PwBPqtbQBJrtpXCJy09L3UNTbsHiEbURqJxG3GJLPGF8j
	s6akEjEwKYcMJb8Uwl10P6AT1FZCrUJnh3XWpFCCbGkO1tcy59msk4zMJdDiLnH10rO0Z
X-Gm-Gg: AZFdTZe0ex87e7hp+ri/IsxxZEnZ4SiEsnB38N3onFDIo4h9F25CMYZKhoO5ldgKv0d
	3ytyX4R+BM6C+3a+m+BU5MNvqgs2WrQ9Zv1F46+ihr2kI3+PmRu818/+Duom950Ii/0iTki+QbX
	w9xiL5XaUC9MTLpGZ/1qejpPzOs8vPILJ0C2Q/iY6VltsBzhhpGzjKHQ3g3Li8DF/pAswNK+WXi
	6Hq6u2UhueP0ER6zxF+vduo8hFl7kBJsT6K7HTezOjUVNUrLErhQ3KgXpyVS1bEHEFvZp9H4PAY
	GXOpdYZyVq1Uaf1YMnQNX58qPsdMcWwgll6YRZUeemXPVZJeCFcyMz0jZptcNw47RukIyXitU/K
	5/V3ZQPHOlJ83HjnTSPqcGX324TZvK0F82Z9YS+aKDAM=
X-Received: by 2002:a05:600c:3b1a:b0:4bb:875b:3d91 with SMTP id 5b1f17b1804b1-4bb88820bfamr433156755e9.30.1795681365583;
        Thu, 26 Nov 2026 00:22:45 -0800 (PST)
X-Received: by 2002:a05:600c:3b1a:b0:4bb:875b:3d91 with SMTP id 5b1f17b1804b1-4bb88820bfamr433155995e9.30.1795681365011;
        Thu, 26 Nov 2026 00:22:45 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1529:2e00:86ec:bef7:c309:ba1f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b2437sm822038555e9.13.2026.11.26.00.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 00:22:44 -0800 (PST)
Date: Thu, 26 Nov 2026 03:22:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Seojin An <love09010224@uos.ac.kr>
Cc: Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev, security@kernel.org
Subject: Re: [PATCH] virtio_ring: reject unrepresentable split indirect tables
Message-ID: <20261126031810-mutt-send-email-mst@kernel.org>
References: <20261126080209.2898344-1-love09010224@uos.ac.kr>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261126080209.2898344-1-love09010224@uos.ac.kr>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pR6IeaNKg_sHV92Kzo7koNVu1U1YI8K8o_j-G1c1UKM_1795681366
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 26, 2026 at 05:02:09PM +0900, Seojin An wrote:
> Split descriptors store the next index as u16. alloc_indirect_split() can
> allocate a larger table, but virtqueue_add_split() feeds the truncated next
> value back into its construction index. With more than 65,536 SG entries,
> the index wraps and later entries replace descriptors at the start of the
> table. The device then consumes a chain different from the caller's SG
> sequence.
> 
> Reject split indirect tables whose entry count exceeds the representable
> index range. Keep the existing compatibility policy that permits
> representable indirect chains longer than Queue Size, and leave packed
> indirect descriptors unchanged.
> 
> A virtio-gpu render client can reach this condition with a vmalloc-backed
> EXECBUFFER. In a no-vIOMMU QEMU/virgl guest, the resulting command
> substitution provided guest physical read/write and initial-namespace
> uid/euid 0. The virtio-gpu producer needs its own Queue-Size check because
> its current queue error path warns about an add failure but advances
> pending state and reports success.
> 
> AI tools assisted the source audit, reproducer construction and patch
> drafting.
> 
> Fixes: 9fa29b9df32b ("virtio: indirect ring entries (VIRTIO_RING_F_INDIRECT_DESC)")
> Reported-by: Hyeonjun Hong <hyeonjunhong330@gmail.com>
> Reported-by: GEONWOO HAN <gunwoo9643@uos.ac.kr>
> Cc: stable@vger.kernel.org
> Signed-off-by: Seojin An <love09010224@uos.ac.kr>


Sorry I don't get what all this is doing and how does it have to do
anything with security?  Drivers mustn't submit requests with more s/gs
than the vq size. Fix it there pls.

> ---
>  drivers/virtio/virtio_ring.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index f683a2d6a2002..ad9e52584fb52 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -686,9 +686,19 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
>  
>  	head = vq->free_head;
>  
> -	if (virtqueue_use_indirect(vq, total_sg))
> +	if (virtqueue_use_indirect(vq, total_sg)) {
> +		/*
> +		 * The core historically permits an indirect chain to exceed the
> +		 * queue size.  Preserve that policy, but do not let its 16-bit
> +		 * split descriptor links wrap within the allocated table.
> +		 */
> +		if (unlikely(total_sg > (1U << 16))) {
> +			END_USE(vq);
> +			return -E2BIG;
> +		}
> +
>  		desc = alloc_indirect_split(vq, total_sg, gfp);
> -	else {
> +	} else {
>  		desc = NULL;
>  		WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indirect);
>  	}
> 
> base-commit: 40212b29a6f718d4e7fb3275cede181cb8e137cf
> -- 
> 2.43.0
