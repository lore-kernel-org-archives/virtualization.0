Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793027461;
	b=W4AskmAeGyXltenR7l67Gqcpp9B819xrYG7PTv/U/mjEoIi6bEpZj2MK8MZz2tYOgmLs
	 bt74R8PUpHOxqfHWOpXEgQKXSdhOmR8hFx3aq7C9O9iS53c+fyqPNAFkos6wxKFznBq6X
	 QgGuSBAzOMLGUjVDienAQDps1QipH/OTzgEXx07kILoJQzsyZBy6AYnT3J71Zz8/csWYI
	 mAvkWB+prlx/KysxfcywAGwyAaiWHg4Ydx06md7hcVG9tytD25xEasIzmcFzcj+avdh7q
	 xFsgljJANOwgbObSe5EF7OdqagRJh5v1jUoeI6Gtz2XdS2X0zuHUEbobabROFGcSuQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793027461;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=4f7t4kSuzzBVEK1HrUbPSVuQTcXA7ncMoRgV6e6y21c=;
	b=4FuUwXIzx9OEfsKglye2JgSorpSsIUyU1qrwRtJ/zxOL006urQI36PPMbMKk+20xtvu6
	 lvxYhi5ryVp4AohC1QwbY1Th4JNvCdJ4HhJrzM6TMGaZAn9ldWVrRrzGOcVNhAf2CohiK
	 IFNg01RLdbVJ7DsMkwhuyOhOdnYLx9+9/KLcX1BgmX+2KwxxfjFf/vmjZYT5N9FZmCpBo
	 FyqhLhjMy6qcMJHRaIcBQCucpg+lgAnYPTnduup5Elrmlr8gU6hbTXw2pKNXmZTGefrRV
	 kUgLkWZU2eoe+wSfbbF5G8eMJaPCB16EnoyEN820OxdBJ5Tr82lQw4RHAwpvF3jbbcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fVKdr7OM;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2DB606A31D
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 15:11:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B2DB606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fVKdr7OM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793027460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4f7t4kSuzzBVEK1HrUbPSVuQTcXA7ncMoRgV6e6y21c=;
	b=fVKdr7OMXQFDPLqEeZvmEIQQV7+sJCfQFdphX3dPT46IMAUV5cE2njKapF+sOcW3c19rtx
	8sxtZ1ZvVlI46oq6R01IJcJwOEfiaSiq7IxeM0jD9XLFIq16Hhefdo18ljf6fRIm4x7a5h
	ib6xJ+TevkzPb00/oy1VHXHr0so+cqk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-fJwkzJwFPjmb8glW4jp_uA-1; Mon, 26 Oct 2026 11:10:58 -0400
X-MC-Unique: fJwkzJwFPjmb8glW4jp_uA-1
X-Mimecast-MFC-AGG-ID: fJwkzJwFPjmb8glW4jp_uA_1793027458
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48c430f0f01so2692771f8f.1
        for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 08:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793027458; x=1793632258;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4f7t4kSuzzBVEK1HrUbPSVuQTcXA7ncMoRgV6e6y21c=;
        b=xkdRmfgY0XGi3P5ErUxlyC/txjkn77soLA6CtjsmP5YdugMjaAr0szsbQlDHQxccaA
         k0cspkneHsXPxoh0Ed8kbPSYAVuv+oRvSC1xuDoPCJbN0STj6rXXSmkdfBC8bSMYsnaF
         8TL4bSybi69ktAVAmG1JzCNYC5iIs/WZBWN8j9KKNGiPyY7Dk7cgcZeQ6R95gBWltFk9
         EvUyFkZafMKSC01hZCmjDvR0R42G6c8x1o/LwL1HJ7+EO5SjoDVIqAMK2h/jeto0a2tu
         t0JLATfbeDpeLvsQ6H9brOtm1H2JOs+O0FjXCQmI79ADyPqRUz+T6H8OdOzBmE3tT4aZ
         TRTw==
X-Forwarded-Encrypted: i=1; AKwUvBzwD/ENPkblRibczDaY+DmFvtpcIyySHXUKdaBCgGioFkbTqT8sSZpKzGXbaE9nLCo456CvTPsNeWv4DuAAGQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYIfxpRUYypBBirCgQFAai/rBaTevTpadyvSwpqu5dzor9L+APaj
	dV03aocL9pUZp5PVrtFWkyprHm9oaIGbMG3To/bJMFXAHXinLo3JNHsYLmbD6guXUlq0KsJaTaW
	y7fYyKYhMgxiNS8bXasKZpZX30Q5gZlpeWekx61ROFo5ZJzVGxIBGq59tEGS1GGCNve7p
X-Gm-Gg: AYBFou28Ex/PRqh4MvoRP3WgVLsxYpCyD2AI+JvAGsDjrdcKBmiYaGa7h8/eyqK0ETK
	qwVGeFQrPBu/dstEpKN95uHvNzSjgrjCHplTJuLTnf+Sdj77EFsaKUvhhte3wLEhQ+1RBvazSCR
	nNTypYcA33DIMwRG3s736K7L8rD+u/Czjznq7QMiVcd/OWG1hmu8MyHK+6ZQ5cWfted3ieY4UVr
	rKmjd/S1YnrIFv28hR8nL3O08hdBe9kcs80PUqHsRapjF6xQXgbccSKIvJ3baiiFq6tcHigPWtA
	rCj3Yddge0/IS2udlz42//tb1Lmm5t6NEYpRuDd7id8p0r3Gjo3K1HCzgP4vu7eq0T0=
X-Received: by 2002:a05:600c:6212:b0:4a1:742e:3 with SMTP id 5b1f17b1804b1-4a35acdd912mr123088335e9.27.1793027457409;
        Mon, 26 Oct 2026 08:10:57 -0700 (PDT)
X-Received: by 2002:a05:600c:6212:b0:4a1:742e:3 with SMTP id 5b1f17b1804b1-4a35acdd912mr123087815e9.27.1793027456804;
        Mon, 26 Oct 2026 08:10:56 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb90dsm15531155f8f.22.2026.10.26.08.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 08:10:56 -0700 (PDT)
Date: Mon, 26 Oct 2026 11:10:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ruben Hakobyan <hruben@meta.com>
Cc: David Hildenbrand <david@kernel.org>, Breno Leitao <leitao@debian.org>,
	Atish Patra <atishp@meta.com>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_balloon: batch large descriptor chains for page
 reporting
Message-ID: <20261026111005-mutt-send-email-mst@kernel.org>
References: <20261023081923.164950-1-hruben@meta.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261023081923.164950-1-hruben@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6p7mb_7KUtlb3UFXfMLj4sHM69qAacW7We14LHQ88Gw_1793027458
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 23, 2026 at 01:19:19AM -0700, Ruben Hakobyan wrote:
> The virtio_balloon driver reports a scatter-gather list of free pages
> to the VMM so it may discard unused pages.
> 
> For an arm64 kernel with 64 KiB pages, the default reporting and
> allocation orders allow entries ranging from 2 MiB to 512 MiB. If the
> report contains a sufficient number of large entries, we will end up
> with a descriptor chain that represents over 4 GiB of memory. This
> violates virtio spec section 2.7.5.2, which requires that the total
> buffer length of a descriptor chain be at most 4 GiB [1]. A VMM that
> faithfully follows the spec may stop processing the descriptor chain
> when it exceeds 4 GiB, and discard less memory than it could. For
> example, this is the case for the virtio-queue in Rust-VMM [2].
> 
> Batch the requests into descriptor chains of at most U32_MAX bytes
> (4 GiB - 1 byte). We use U32_MAX here so we can conveniently represent
> the batch length in a u32.
> 
> [1] https://docs.oasis-open.org/virtio/virtio/v1.4/virtio-v1.4.html
> [2]
> https://github.com/rust-vmm/rust-vmm/blob/9f7250b1555ebe022ea4133fda676e6311040738/vm-virtio/virtio-queue/src/chain.rs#L183-L190
> 
> Fixes: b0c504f15471 ("virtio-balloon: add support for providing free page reports to host")
> Signed-off-by: Ruben Hakobyan <hruben@meta.com>
> ---


thanks a lot for the report. I posted a patchset for your
consideration. if you test it, pls let us know the results.
if you see a need for more changes, pls feel free to take
over the work on it.

> The wording in the spec is a bit ambiguous because it uses "chain
> length" for both descriptor counts and the total size of the memory
> ranges referenced by the descriptors. My read is that the byte limit
> applies to the sum of descriptor lengths, which is also what rust-vmm
> checks.
> 
> Another option I considered was to limit reporting capacity based
> on the largest possible block. E.g. for 64 KiB pages, the largest
> block is 512 MiB, so limit the reporting capacity to 7 to stay
> below 4GiB. Although simpler, I found that the time to reclaim
> was quite a bit longer.
> 
> I tested this patch on Cloud Hypervisor (which uses Rust-VMM)
> and QEMU (which doesn't enforce this limit).
> 
>  drivers/virtio/virtio_balloon.c | 47 ++++++++++++++++++++++++---------
>  1 file changed, 35 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index ab3e3d887e00..68ce627c8e04 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -15,6 +15,7 @@
>  #include <linux/slab.h>
>  #include <linux/module.h>
>  #include <linux/balloon.h>
> +#include <linux/limits.h>
>  #include <linux/oom.h>
>  #include <linux/wait.h>
>  #include <linux/mm.h>
> @@ -207,21 +208,43 @@ static int virtballoon_free_page_report(struct page_reporting_dev_info *pr_dev_i
>  	struct virtqueue *vq = vb->reporting_vq;
>  	unsigned int unused, err;
>  
> -	/* We should always be able to add these buffers to an empty queue. */
> -	err = virtqueue_add_inbuf(vq, sg, nents, vb, GFP_NOWAIT);
> +	while (nents) {
> +		bool unmark_end;
> +		struct scatterlist *sg_batch_start = sg;
> +		u32 batch_len = 0;
> +		unsigned int batch_nents = 0;
>  
> -	/*
> -	 * In the extremely unlikely case that something has occurred and we
> -	 * are able to trigger an error we will simply display a warning
> -	 * and exit without actually processing the pages.
> -	 */
> -	if (WARN_ON_ONCE(err))
> -		return err;
> +		/*
> +		 * Virtio spec 2.7.5.2 limits the total buffer length of a
> +		 * descriptor chain to 2^32 bytes (4 GiB), so split larger
> +		 * reports into batches no bigger than that size.
> +		 */
> +		while (batch_nents < nents &&
> +		       sg->length <= U32_MAX - batch_len) {
> +			batch_len += sg->length;
> +			batch_nents += 1;
> +			sg = sg_next(sg);
> +		}
> +		unmark_end = !sg_is_last(&sg_batch_start[batch_nents - 1]);
>  
> -	virtqueue_kick(vq);
> +		if (unmark_end)
> +			sg_mark_end(&sg_batch_start[batch_nents - 1]);
>  
> -	/* When host has read buffer, this completes via balloon_ack */
> -	wait_event(vb->acked, virtqueue_get_buf(vq, &unused));
> +		err = virtqueue_add_inbuf(vq, sg_batch_start, batch_nents, vb,
> +					  GFP_NOWAIT);
> +
> +		if (unmark_end)
> +			sg_unmark_end(&sg_batch_start[batch_nents - 1]);
> +
> +		if (WARN_ON_ONCE(err))
> +			return err;
> +
> +		virtqueue_kick(vq);
> +
> +		/* When host has read buffer, this completes via balloon_ack */
> +		wait_event(vb->acked, virtqueue_get_buf(vq, &unused));
> +		nents -= batch_nents;
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.53.0-Meta

