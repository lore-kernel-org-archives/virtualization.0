Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792749884;
	b=kmJpGFtwRdkgy2Kmp0hXQ6oeZW5hKnBAZaOi64Va6+OGeiKlJp7Tl/3kMe1OwYXKk5a+
	 uAv813oknebCPEtYaVRDY+50DfcNX5nuvry732kiq85J9xMe7FkokAYcUblDoYQcW+t6d
	 CJQ2wpVCQXbWhpyS8JZ9H9IBu/KT5/ks45GGebC5foT120Oq6rtfqO2cmxaP3sUhI887E
	 7aucUiodq8Rb6TaoPAnbg4q49NJV6/FrIIBSGd6hAIMARdHOgBUGxw1M1fcHaaqcxJCoE
	 XutrWwIHK+IiUfScqrFsjNS9cRjBXwJQlDIaM8fzTnZ8pySNLHHwmE/Vom5Fka1yyHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792749884;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=hYkBoQ6y82oxG++SCIxFzQ7YeSOVHLZCi1q8tJnSOY8=;
	b=JlNqjSIEKgqjXqOlyEKWXTdAsKz1+bu9a8mJSBfdyz9dxaAyLztcctBO9bcOc/sGMa+B
	 py4DIxoXWTKippR4H6PsSfXPR3hvNf8XEY9ScqIiyQx+JgJeLkgnzWKoG0evrsNw3Ijxx
	 Ez8q+LQzmT5Wt/bN0ZRTRJqBcTyg5pv36nTZOiqk3pNuVqLiDSl1k/K6bNHzuenKhDmbE
	 4tvpXDjok4d97APTDWvUjdcYd/5ijVgeVA5PzuWwHNEpbiv3MvpncKuW/4FEf8CQjN5X5
	 WNdHlSQLAP3KBqO6uV4o1AqKNRLzDCsbqGLW+oN85BioviglR5lpdvT40K7e5jty/Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bA8K2cPz;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD8D606A323
	for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 10:04:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FD8D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bA8K2cPz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792749882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hYkBoQ6y82oxG++SCIxFzQ7YeSOVHLZCi1q8tJnSOY8=;
	b=bA8K2cPzJqAeRfM4uNhNlbOlrKzvqeJn27HqAwl5T1qBl3nz4FeBuDsRuGhyk0fQay/XHB
	JjE9bkl2kkvjT5XFymPVBDEzfdhvF0leoMqDXkvO5AMNZVElng0gXMhUingT0pFk8AT9Kl
	5l+UHAouoyOhsRB3uB9cgRxI969a6KQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-2X2F9xJ-OUqyI2-Lm5PdYg-1; Fri, 23 Oct 2026 06:04:41 -0400
X-MC-Unique: 2X2F9xJ-OUqyI2-Lm5PdYg-1
X-Mimecast-MFC-AGG-ID: 2X2F9xJ-OUqyI2-Lm5PdYg_1792749880
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e1d839ddaso431244f8f.3
        for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 03:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792749880; x=1793354680;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hYkBoQ6y82oxG++SCIxFzQ7YeSOVHLZCi1q8tJnSOY8=;
        b=XlgASG+vtGf/zDzxGO3hkCeAHX2tb1N7kZXxG4mRmoA5mCaEp13pZbsAD0uNhSThzL
         I3edetsxpdP5UjByaPvXhCMUBaCwbic2tocE/S0vMt9oy48zTnNHchpdAE+A3GUgGyjn
         ymCi+QBGRv3Y50+i7IXkqtVs87EhN87W2l4k4vugH8GJD/A+ROr92VOye7IfqIV2o6ly
         jbNs3AaVs/VejCFKsXcpB6JISEv3sPIc9Ia/ljYJRhAZ5G9/b/saoOYNqtnojXhV9rop
         49uyj+YnhlmwgeMZJ12vKNwuv0A6GrgmDTyPuPjT6LverkupwjWoOl14EhaejnlSX2u1
         uGSg==
X-Forwarded-Encrypted: i=1; AKwUvBxCYeuCIlh+pJWRBltQKJVd0hLX6LlBaSFrA8B7WyCJ1k9ATKF6gMZkNPi9YYCqaHLcuC6+j9C7v9Zs1olYTQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLStaHlT9+PxQjWIgLhSQKAFB9qoHZFkTqbC+gAjuMvOvVeAPGA
	qI1qB0bSsqQVo9s0b2kQy04TKVNQcXLnAVT3SPLoEqH4MytAfPZr2Bfft9S54pd30U8NMfpay2p
	DZhYuuYZGaT/UXHPv07JqlggH4v/xZkPS6CuLGhtUxSvXWSDfmJbKtfdPWyL6K2Zm9/7a
X-Gm-Gg: AYBFou3BdCTIWk2lbPOyPoKSvSIy6eyI2H4VMuEO/lmdWPPGtoUILUD524qfW+JE5YG
	2ws14RQEAfq9DZ9BXHhAu4vTRUDtVuaoEqVG29CHWrQi3JyFubMl2v6XxfN7eHIC/8GrGwTzo/S
	e/WXVv+Glxbv0qm6DYTAT+Nia07El5NCcUQaC3hypviKckNwUqRMk04iyCozOkDbcNTtTswRIOy
	DDHtUoIfjz1mf2ReaP2CAxhLARmNvOWbD1jbZoDevk+0b0xsRk29CdV9BqNG9Vpmpia0Plh2kup
	xRcwVoMUXzofNP75VwEpDeprT8x0fHwic1e2Rp2D5hZt0YCTQSu13hL+yFU4h2kc6NDbQOE=
X-Received: by 2002:a05:6000:2610:b0:48d:f14a:917f with SMTP id ffacd0b85a97d-48e38594e07mr2598907f8f.2.1792749878646;
        Fri, 23 Oct 2026 03:04:38 -0700 (PDT)
X-Received: by 2002:a05:6000:2610:b0:48d:f14a:917f with SMTP id ffacd0b85a97d-48e38594e07mr2598849f8f.2.1792749877952;
        Fri, 23 Oct 2026 03:04:37 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73f6:2400:30a8:9e33:7d82:c035])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e37edd26dsm4700642f8f.2.2026.10.23.03.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 03:04:37 -0700 (PDT)
Date: Fri, 23 Oct 2026 06:04:33 -0400
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
Message-ID: <20261023042737-mutt-send-email-mst@kernel.org>
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
X-Mimecast-MFC-PROC-ID: o_SV2diPVE8cm9z0cXqcSIHnmbC0Ni3E18VYiCQ5-as_1792749880
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Great patch, thanks!

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

It's not just a question of convenient, is it?
Rust is buggy wrt to spec as it allows only U32_MAX.
So it is also to make it work.
So should we maybe fix Rust to be spec compliant and allow 2^32 too?

I think we should definitely recommend U32_MAX in the spec
because otherwise it can not fit in the used length.


> 
> [1] https://docs.oasis-open.org/virtio/virtio/v1.4/virtio-v1.4.html
> [2]
> https://github.com/rust-vmm/rust-vmm/blob/9f7250b1555ebe022ea4133fda676e6311040738/vm-virtio/virtio-queue/src/chain.rs#L183-L190
> 
> Fixes: b0c504f15471 ("virtio-balloon: add support for providing free page reports to host")
> Signed-off-by: Ruben Hakobyan <hruben@meta.com>
> ---
> The wording in the spec is a bit ambiguous because it uses "chain
> length" for both descriptor counts and the total size of the memory
> ranges referenced by the descriptors. My read is that the byte limit
> applies to the sum of descriptor lengths, which is also what rust-vmm
> checks.


quote what you are referring to please, also in the commit log
not after ---.

I would also CC virtio-comment@lists.linux.dev - spec should recommend
U32_MAX.

> 
> Another option I considered was to limit reporting capacity based
> on the largest possible block. E.g. for 64 KiB pages, the largest
> block is 512 MiB, so limit the reporting capacity to 7 to stay
> below 4GiB. Although simpler, I found that the time to reclaim
> was quite a bit longer.



So I was going to apply this actually:

https://lore.kernel.org/all/b541ff170218bd5d45b551b5132e7cf2c490d761.1780906288.git.mst@redhat.com/

which makes the question completely moot.

Does this have any effect on performance?

Thanks!


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
> +		 * Virtio spec 2.7.5.2

Please add spec version and chapter title, and quote the
spec text in question verbatim.

> limits the total buffer length of a
> +		 * descriptor chain to 2^32 bytes (4 GiB), so split larger
> +		 * reports into batches no bigger than that size.
> +		 */
> +		while (batch_nents < nents &&
> +		       sg->length <= U32_MAX - batch_len) {

here you actually limit to U32_MAX which is 2^32 - 1 as commit log says.

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

