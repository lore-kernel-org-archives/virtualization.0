Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C826E6EB5D
	for <virtualization@lists.linux.dev>; Tue,  9 Apr 2024 06:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712643583; cv=none; b=WNKfCqgwKKO3uUS5PWKjlS9WXT65so7LWpSbNgkIS4Yl0IGAY+b7NSyBFNJGO5jdZzuW6BbAFOOhy5BL50sY8a8hwDAi+TjppygNuDWL58NKI/9GsJ3azD/KxAIJuzJhMlkyJjwhirGwB/gqKoECelTOWdQiNfgm2OOP8tLuklo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712643583; c=relaxed/simple;
	bh=fkhIHTNgQsjJ+75AHWtWhK3dV9fPw50Z6dlrmwK15EA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JutPxzqBwgprKDBJJd9guCBdFO55IP87/hptQV2jarB2hNBGahLMeqTGvciKZ86+BCpXGhB0tl4Z/Pq3Bab59T6muGeZh1giLTixb4H2Wxl1ti02nXADlS3MhvzJPspjBO9og7gGV92jyg7ciFXDTdeK1/FohZEzFb+sfy2CUjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QJa+EfVX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QJa+EfVX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712643579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1cvkP8+VQryWRgcJ5dN75UnPlwOjiMz8ZDJuBxlHfU=;
	b=QJa+EfVXIezTghNDHp9pcJJnab21l9eNEIDqTlKYzog+wFba37dnPsVUA4GznrlvQJHYzw
	HeNXbVmH5MKrUJ6NKnXHEZqCtM3Iv+CvNLUKjULlcBEJICGhe/H54tONN8WC9YGtZfbosd
	++iQJ0f9cXvL8gG7+AUgP3V996PKxQc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-4obsjBjhPDu4YpbJc3lrYQ-1; Tue, 09 Apr 2024 02:19:38 -0400
X-MC-Unique: 4obsjBjhPDu4YpbJc3lrYQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5685d83ec51so2363959a12.3
        for <virtualization@lists.linux.dev>; Mon, 08 Apr 2024 23:19:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712643577; x=1713248377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1cvkP8+VQryWRgcJ5dN75UnPlwOjiMz8ZDJuBxlHfU=;
        b=l+jgRXe8s3dzxz/QybGEzIiX8q3K4zT5mad002mJJb9yucu20IogHUeWjd6AOlBXiD
         IMStAr9yIKsw0ezcoJYoWXd8Xp4BjaLg27d42Lm1hVt1GNP4hTu+HCBE26tQsMMB+iry
         yGWwrEy3HpiUP7mPrmM+oOAiV7Y4POYEih+JAGXNY5w0lgq7CoimWfrJzAQPF8AGbaii
         cRdTyk/8EYAwEFuvrqDpHcaDaHatD2hDWAfnbomva9AsT4g1n7WTI/uCljwCKP5beUsT
         y/29Ov+MNBOdZMgi5cWUAtuYsijeyHFQ5MjIPteYXr3gq4BGwWWKABKbEWAQ66aoKv6U
         4Y9A==
X-Forwarded-Encrypted: i=1; AJvYcCVA/RNCoRaRJhL7KXOYnOzjt5CIJSE/cWVmGxwS7I+oMfq2sfVrolFJBOz9kd4x94p+xf3qGF1xowowS4d+/ZaXLil7x5Ek0zpqg16Ru9Y=
X-Gm-Message-State: AOJu0YyMdf74YEmDE8UGRhnPpeoDbEFUTZ0wrx+cTa2qacOmrebVogxt
	VbDshKdf/e5qRC1mSLq7kNWlO1HY3tysTB7ZTdGGkmw3ow/a5xahLph+eTMMZ+4CakHgMnLf/S1
	nwdNqhh/R7/I6gQIPwKWXwZnBR3FTGK+W3FfO70F7huXLy2OAxLdNKYq/sZrloVZv
X-Received: by 2002:a50:9f6b:0:b0:56e:dc5:e99 with SMTP id b98-20020a509f6b000000b0056e0dc50e99mr7728902edf.24.1712643577208;
        Mon, 08 Apr 2024 23:19:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAIf7qjab0t3qaKYhj5BbpIPDCgMO0B5IeFA+M2gmA0bxyH/eBzWzin0nhgUp3McDyUeprAg==
X-Received: by 2002:a50:9f6b:0:b0:56e:dc5:e99 with SMTP id b98-20020a509f6b000000b0056e0dc50e99mr7728885edf.24.1712643576691;
        Mon, 08 Apr 2024 23:19:36 -0700 (PDT)
Received: from redhat.com ([2.52.134.26])
        by smtp.gmail.com with ESMTPSA id i33-20020a0564020f2100b0056e6e9a367fsm671421eda.19.2024.04.08.23.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 23:19:36 -0700 (PDT)
Date: Tue, 9 Apr 2024 02:19:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "ni.liqiang" <ni_liqiang@126.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"jin . qi" <jin.qi@zte.com.cn>,
	"ni . liqiang" <ni.liqiang@zte.com.cn>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/virtio: delayed configuration descriptor flags
Message-ID: <20240409015712-mutt-send-email-mst@kernel.org>
References: <20240408170252.13566-1-ni_liqiang@126.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240408170252.13566-1-ni_liqiang@126.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 09, 2024 at 01:02:52AM +0800, ni.liqiang wrote:
> In our testing of the virtio hardware accelerator, we found that
> configuring the flags of the descriptor after addr and len,
> as implemented in DPDK, seems to be more friendly to the hardware.
> 
> In our Virtio hardware implementation tests, using the default
> open-source code, the hardware's bulk reads ensure performance
> but correctness is compromised. If we refer to the implementation code
> of DPDK, placing the flags configuration of the descriptor
> after addr and len, virtio backend can function properly based on
> our hardware accelerator.
> 
> I am somewhat puzzled by this. From a software process perspective,
> it seems that there should be no difference whether
> the flags configuration of the descriptor is before or after addr and len.
> However, this is not the case according to experimental test results.


You should be aware of the following, from the PCI Express spec.
Note especially the second paragraph, and the last paragraph:

2.4.2.
25
30
Update Ordering and Granularity Observed by a
Read Transaction
If a Requester using a single transaction reads a block of data from a Completer, and the
Completer's data buffer is concurrently being updated, the ordering of multiple updates and
granularity of each update reflected in the data returned by the read is outside the scope of this
specification. This applies both to updates performed by PCI Express write transactions and
updates performed by other mechanisms such as host CPUs updating host memory.
If a Requester using a single transaction reads a block of data from a Completer, and the
Completer's data buffer is concurrently being updated by one or more entities not on the PCI
Express fabric, the ordering of multiple updates and granularity of each update reflected in the data
returned by the read is outside the scope of this specification.




As an example of update ordering, assume that the block of data is in host memory, and a host CPU
writes first to location A and then to a different location B. A Requester reading that data block
with a single read transaction is not guaranteed to observe those updates in order. In other words,
the Requester may observe an updated value in location B and an old value in location A, regardless
of the placement of locations A and B within the data block. Unless a Completer makes its own
guarantees (outside this specification) with respect to update ordering, a Requester that relies on
update ordering must observe the update to location B via one read transaction before initiating a
subsequent read to location A to return its updated value.




As an example of update granularity, if a host CPU writes a QWORD to host memory, a Requester
reading that QWORD from host memory may observe a portion of the QWORD updated and
another portion of it containing the old value.
While not required by this specification, it is strongly recommended that host platforms guarantee
that when a host CPU writes aligned DWORDs or aligned QWORDs to host memory, the update
granularity observed by a PCI Express read will not be smaller than a DWORD.


IMPLEMENTATION NOTE
No Ordering Required Between Cachelines
15
A Root Complex serving as a Completer to a single Memory Read that requests multiple cachelines
from host memory is permitted to fetch multiple cachelines concurrently, to help facilitate multi-
cacheline completions, subject to Max_Payload_Size. No ordering relationship between these
cacheline fetches is required.





Now I suspect that what is going on is that your Root complex
reads descriptors out of order, so the second descriptor is invalid
but the 1st one is valid.




> We would like to know if such a change in the configuration order
> is reasonable and acceptable?

We need to understand the root cause and how robust the fix is
before answering this.


> Thanks.
> 
> Signed-off-by: ni.liqiang <ni_liqiang@126.com>
> Reviewed-by: jin.qi <jin.qi@zte.com.cn>
> Tested-by: jin.qi <jin.qi@zte.com.cn>
> Cc: ni.liqiang <ni.liqiang@zte.com.cn>
> ---
>  drivers/virtio/virtio_ring.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 6f7e5010a673..bea2c2fb084e 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1472,15 +1472,16 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  			flags = cpu_to_le16(vq->packed.avail_used_flags |
>  				    (++c == total_sg ? 0 : VRING_DESC_F_NEXT) |
>  				    (n < out_sgs ? 0 : VRING_DESC_F_WRITE));
> -			if (i == head)
> -				head_flags = flags;
> -			else
> -				desc[i].flags = flags;
>  
>  			desc[i].addr = cpu_to_le64(addr);
>  			desc[i].len = cpu_to_le32(sg->length);
>  			desc[i].id = cpu_to_le16(id);
>  
> +			if (i == head)
> +				head_flags = flags;
> +			else
> +				desc[i].flags = flags;
> +
>  			if (unlikely(vq->use_dma_api)) {
>  				vq->packed.desc_extra[curr].addr = addr;
>  				vq->packed.desc_extra[curr].len = sg->length;
> -- 
> 2.34.1

