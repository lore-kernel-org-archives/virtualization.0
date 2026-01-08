Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806231E5201
	for <virtualization@lists.linux.dev>; Thu,  8 Jan 2026 14:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767882754; cv=none; b=rDwwUAmN2XaOT/gqa+zQiLn1jKpv3JOt2jYg1P+DYIGbWu6Wm9nJ7cUr54kI2fXs/2urMElLmQlAybDOVQPeHS7siPNW2dgOCFqrbqg/cDlHy9wNyRSK2BZ7cv2IFL4PGBwuB3kgnSBEmzRzqNIfqvzU8YCL6Ifbycf5YlLG/LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767882754; c=relaxed/simple;
	bh=/ul1MI70WNuWUatNq9QXmWY0n1CnY3rQPVMj9RML37Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZYCWU8UUmTCd8oi/WB1sVYZsxjToGlF3suMFZqijsIrIUQ2nIt5j4UduOJNJfLnGwIBnvzgaOznfjue6i80OcLnh7KLLRK2Y9zRqed4xEnCtDJuNBWz2f/FXwT8V1P7YgYCGMmLTp5XyhvUOMAWZ4Pot6e1taTjYj5qjHTu1iuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bIcUG7v2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bIcUG7v2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767882751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZQ5KldlPLZnW3hZQd/TnLSW7zs03bZTdFv6fpQxf5uk=;
	b=bIcUG7v2nKz9oYVi2iLvIZtWoX845PSheZ69CviFgrx/Ct6iQ8mcdjoyvXTVP/EGFy2uW3
	36CrIHPsFXWZqLoPcbDPuVEBiYstHoHPnfoYDh0GbqN50utWDMdahp/Va3mocrfsg1j4yw
	Kpo5hLdDQpMA1PWCYDcowCMl2HWXmoY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-EbwIucgBPyKgywrWUOUMtw-1; Thu, 08 Jan 2026 09:32:30 -0500
X-MC-Unique: EbwIucgBPyKgywrWUOUMtw-1
X-Mimecast-MFC-AGG-ID: EbwIucgBPyKgywrWUOUMtw_1767882749
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4779d8fd4ecso12848315e9.1
        for <virtualization@lists.linux.dev>; Thu, 08 Jan 2026 06:32:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767882749; x=1768487549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQ5KldlPLZnW3hZQd/TnLSW7zs03bZTdFv6fpQxf5uk=;
        b=rpsDthOZyw7QgfkYhD7YClIU4rurrZvrk2DXtVOeEzUqqdza02qaAcY/QDOVBPejLt
         Kl8X7oYSUAw8Qk0IffZEpPOZ6gKsLAVvYspn9qABnCkm6DPOahHPURnsxYJ2bLYjZLp6
         0s2gR6L2PNafdcNA9LLn7jOpZfxnY8Qaf8xI2eGZqfPltalVe0jSU9qkvmZsiEWjTRNf
         cJN327kexrzU86+q5cwJq99qM8aceRzYdpK2Wdr70HtZueyUrvvxG/FJj9naJdyObSAo
         FlYybbzl8mF495HELX5Y7ZN3lJnRU8GuiW/G9/JPvRxk0MxzJv2z4GTaiAL28aSieZKy
         a2bw==
X-Forwarded-Encrypted: i=1; AJvYcCUteNBzXTmOBBCECIYA/UC+RsXo6YmmqnaUMcemjztTqYmp2Se3QWftnaLycqqIv+kGH1gXfG72OEky2pD2BQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw8OPCNt/kHwe2yGWjDRc9dzWB0jsYxTFW6hofhIOv1ttce+0c7
	0LoTzd8uhCfuAepJxqRMwX4gg+ybFCW/7FAxN3loiore2f2mM/H7aiKXViiWADJ4Oby1ARICl+V
	C25COuRIto5SYAeH5JToGOZrue7gBNZh9UnLsrLRyHywI4UNvNnFX//tsXzChDxJbCLH2
X-Gm-Gg: AY/fxX5yyZnq/eOYR80YYw9dnN9UW6tZ8qfRbC20fzrTfDS5LFPXdP7mq46rydJHB5g
	DD/10XWF3ZaMeZSZcH1C8rwUFbFQTht9HCT1CeXrUN5iWiIXKhVSacvGk6914RSjveXErGFuMhP
	d0Dy+w+DaOxQi+iQBfWq3G2WG1ygAJrRdWLO43ZHbrJ/m2oTkIlClOlVRT9T+cA588d+C0LODg8
	foNRXCKZ32VsnywI8B8Toia3z5CueHMJxErfdZABGwLiCNRBBzD3HFeAzOIm5UYT1f7XeCGFCAI
	QkXn8nMudMcn+5ov1SB0akC2zrvG+SUxFyJTZe83Q26OE6buYt16+Bn+8vBSn92tcp1fQ8+UqAb
	PXJRFvA/Cy8bDelSYszZ28Qu5zPKFqMFD7g==
X-Received: by 2002:a05:600c:6c95:b0:47a:8383:f2b2 with SMTP id 5b1f17b1804b1-47d7f63722dmr100358015e9.17.1767882748605;
        Thu, 08 Jan 2026 06:32:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7Gl8OtqeQkvPJx1M3QhvEhlvzebP4MIt/f4g31duD4E6Ii6eayAMa8grqHGKZjLNtnJFSpw==
X-Received: by 2002:a05:600c:6c95:b0:47a:8383:f2b2 with SMTP id 5b1f17b1804b1-47d7f63722dmr100357545e9.17.1767882748121;
        Thu, 08 Jan 2026 06:32:28 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8717d78fsm38131185e9.9.2026.01.08.06.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 06:32:27 -0800 (PST)
Date: Thu, 8 Jan 2026 09:32:23 -0500
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
Message-ID: <20260108092931-mutt-send-email-mst@kernel.org>
References: <cover.1767601130.git.mst@redhat.com>
 <fdc1da263186274b37cdf7660c0d1e8793f8fe40.1767601130.git.mst@redhat.com>
 <aV-6gniRnZlNvkwc@sgarzare-redhat>
 <20260108091514-mutt-send-email-mst@kernel.org>
 <aV-9F42fMfKGP4Rg@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aV-9F42fMfKGP4Rg@sgarzare-redhat>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ashij08N7G_y3qWrtBTONPc-_vd9FUoN7lkW23oVqmo_1767882749
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 08, 2026 at 03:27:04PM +0100, Stefano Garzarella wrote:
> On Thu, Jan 08, 2026 at 09:17:49AM -0500, Michael S. Tsirkin wrote:
> > On Thu, Jan 08, 2026 at 03:11:36PM +0100, Stefano Garzarella wrote:
> > > On Mon, Jan 05, 2026 at 03:23:41AM -0500, Michael S. Tsirkin wrote:
> > > > Reorder struct virtio_vsock fields to place the DMA buffer (event_list)
> > > > last. This eliminates the padding from aligning the struct size on
> > > > ARCH_DMA_MINALIGN.
> > > >
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > ---
> > > > net/vmw_vsock/virtio_transport.c | 8 +++++---
> > > > 1 file changed, 5 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> > > > index ef983c36cb66..964d25e11858 100644
> > > > --- a/net/vmw_vsock/virtio_transport.c
> > > > +++ b/net/vmw_vsock/virtio_transport.c
> > > > @@ -60,9 +60,7 @@ struct virtio_vsock {
> > > > 	 */
> > > > 	struct mutex event_lock;
> > > > 	bool event_run;
> > > > -	__dma_from_device_group_begin();
> > > > -	struct virtio_vsock_event event_list[8];
> > > > -	__dma_from_device_group_end();
> > > > +
> > > > 	u32 guest_cid;
> > > > 	bool seqpacket_allow;
> > > >
> > > > @@ -76,6 +74,10 @@ struct virtio_vsock {
> > > > 	 */
> > > > 	struct scatterlist *out_sgs[MAX_SKB_FRAGS + 1];
> > > > 	struct scatterlist out_bufs[MAX_SKB_FRAGS + 1];
> > > > +
> > > 
> > > IIUC we would like to have these fields always on the bottom of this struct,
> > > so would be better to add a comment here to make sure we will not add other
> > > fields in the future after this?
> > 
> > not necessarily - you can add fields after, too - it's just that
> > __dma_from_device_group_begin already adds a bunch of padding, so adding
> > fields in this padding is cheaper.
> > 
> 
> Okay, I see.
> 
> > 
> > do we really need to add comments to teach people about the art of
> > struct packing?
> 
> I can do it later if you prefer, I don't want to block this work, but yes,
> I'd prefer to have a comment because otherwise I'll have to ask every time
> to avoid, especially for new contributors xD

On the one hand you are right on the other I don't want it
duplicated each time __dma_from_device_group_begin is invoked.
Pls come up with something you like, and we'll discuss.

> > 
> > > Maybe we should also add a comment about the `ev`nt_lock`
> > > requirement we
> > > have in the section above.
> > > 
> > > Thanks,
> > > Stefano
> > 
> > hmm which requirement do you mean?
> 
> That `event_list` must be accessed with `event_lock`.
> 
> So maybe we can move also `event_lock` and `event_run`, so we can just move
> that comment. I mean something like this:
> 
> 
> @@ -74,6 +67,15 @@ struct virtio_vsock {
>          */
>         struct scatterlist *out_sgs[MAX_SKB_FRAGS + 1];
>         struct scatterlist out_bufs[MAX_SKB_FRAGS + 1];
> +
> +       /* The following fields are protected by event_lock.
> +        * vqs[VSOCK_VQ_EVENT] must be accessed with event_lock held.
> +        */
> +       struct mutex event_lock;
> +       bool event_run;
> +       __dma_from_device_group_begin();
> +       struct virtio_vsock_event event_list[8];
> +       __dma_from_device_group_end();
>  };
> 
>  static u32 virtio_transport_get_local_cid(void)

Yea this makes sense.

> 
> Thanks,
> Stefano

