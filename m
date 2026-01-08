Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C1033D510
	for <virtualization@lists.linux.dev>; Thu,  8 Jan 2026 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767882450; cv=none; b=rRmhp2Ljruwkw+OGdt+Eq7CCiVesUf4IegBG/JzaPCSBiGctOxUZDmr2DcPzz1YEovqtN3ViPK8gH5ZrMDfevE2fEaD920v2FFlxWPo6gymLLya6MuAvFh34cM2I5kEpMdS/QO/WPg4/h6NWOkFi3u5irl5Jglah+GlqgOF8rVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767882450; c=relaxed/simple;
	bh=9NRW4Rdf/VUGYmBYvief2R2tb60IwahWPnIEBIYe7so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=OFn+zX46IlbGwBNt/7eEVMT60l2XZQ6CZ2cZCrGP6eFOE5Os0SQDkvyG7k99m2vLyEkKpf6HurVXZCD7g7Jl4gJ6IVHw2AeTIH2IN8p4ZTq8DgrwEuS9vYJ5FlIz3oJGs2ka/IqW2rkuGMcKTR+d02Mh31yTIW1cK5/Lsk6Gs7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=fail smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KYeaAZxG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KYeaAZxG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767882446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MYUfQokxCybKNz25/1oiXAmTT63P9X7nVn3prJ03xRo=;
	b=KYeaAZxGWHR4laUKmOpFYc6ltRFo7EdMJSnGatv2CvFolSz6P3yPSiAlRX7CKLkSxLAJH2
	hqLq6SPfHFyQ21/+6tnk/cA9BkCyIH2rwftYqMHk4ytveKUAO/90dFnhGrhnPiDRehAaOe
	yMZ41WbQF53CObGbIbkLKEMOiqW6ipk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-TqrSWUQuOAaGt628xLxBsg-1; Thu, 08 Jan 2026 09:27:23 -0500
X-MC-Unique: TqrSWUQuOAaGt628xLxBsg-1
X-Mimecast-MFC-AGG-ID: TqrSWUQuOAaGt628xLxBsg_1767882442
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b831e10ba03so501829466b.1
        for <virtualization@lists.linux.dev>; Thu, 08 Jan 2026 06:27:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767882442; x=1768487242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MYUfQokxCybKNz25/1oiXAmTT63P9X7nVn3prJ03xRo=;
        b=PgUpUpoqoJ1KOeJglAQp58mlQ3+jHzOmKK+j9AJoMxdBLz8q4ZM6W40Dr+wt7Emm1S
         NyN9hAMHbj2+ytUN8SX8yNQdlpfHqik8Zn3M7mvizfzrgyFFz3X5SImtZ5EaXZr/FoGE
         YqjARwfXYxiABThCYmFDZjPzTpO2/8ep34pZiiVVtEEQvhIQ+nYQDpdxcRtl1eTe9yXn
         JLZfFTkBvGF03Dw8SwOvn4ugQIsJD8sFxnG/gFedQNvlv41Z1/ASBnj6FwXMx+77v1lc
         SSnKvhzIRkKVtN3dFEG0ZlJjvtK4aUd0Y7NzW0VOzIbK90iwzEtT06oQePXfobkEk82B
         vjSg==
X-Forwarded-Encrypted: i=1; AJvYcCWHx6yW+HfcdPlSLMZ5L+QqoF5WrnGKpMZJMUbs9u70C7m/GHKHWJ0f5PqSlIVHLFrFkwnUvo1005WAENDQZw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyEi93cjcvwFJQfeQxMGNrKgjZY+dPRIebueHyhH+Po+EQY4yGq
	/lBodIYElTNGMjojaomBXCSqsKGS8ruytTyAHG6tJaNZxwh3xCW9J9uHi9FhLh64A78vyCOcp1V
	1umOMxFjVQW01zZt2wHm+SZSP0EqMkTKZgn3aYI72+Tui+UkCNUmEEW4yQrhF5GJleAWQ
X-Gm-Gg: AY/fxX75Opg4EagRfYLV4ndWkiN2LQQgZB1lGCQLQofnH+faqj6FeaT9JZuSPbgcUQb
	CHyvM7+QcF2uYXua9EP0pAD1OYhDvpwoAXjEHYnuivTOzX/I2gSYHxtja4rGKlo2w2XY0h2kQ+W
	R+2Fs0Bh/O/SQZAM/NtAv6KIN++ga1a1PfO0op6YebJ40ToJ/jzzVJX9rL7vgtQTBz7IlT2EDrC
	fP1w4UeDez4RFl2xmmgvyxjAcOu9l4kI8hgXQ3PbLuIRdNrlAL+27W3whkhvS4DWuARJlexrBYs
	Y+JpLZi7StHTnwCh8qgZODVinpK3HO/BmiXa048vDd3chu9QlQu1SDxzAEdYI/b2MDChLhzfldf
	Z3BAMQZypmgubIj6j
X-Received: by 2002:a17:907:1c09:b0:b79:eaf6:8f44 with SMTP id a640c23a62f3a-b8444f4f056mr726211666b.40.1767882441997;
        Thu, 08 Jan 2026 06:27:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJ6L4DqIanAXgw2ktUhRyngdJSX+H/rkKSIqtNQ9+qAgBUByhlaCVegL7JEtxsi+D3mXwYrw==
X-Received: by 2002:a17:907:1c09:b0:b79:eaf6:8f44 with SMTP id a640c23a62f3a-b8444f4f056mr726205266b.40.1767882441415;
        Thu, 08 Jan 2026 06:27:21 -0800 (PST)
Received: from sgarzare-redhat ([193.207.223.215])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a4cfd97sm787982066b.36.2026.01.08.06.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 06:27:20 -0800 (PST)
Date: Thu, 8 Jan 2026 15:27:04 +0100
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
Message-ID: <aV-9F42fMfKGP4Rg@sgarzare-redhat>
References: <cover.1767601130.git.mst@redhat.com>
 <fdc1da263186274b37cdf7660c0d1e8793f8fe40.1767601130.git.mst@redhat.com>
 <aV-6gniRnZlNvkwc@sgarzare-redhat>
 <20260108091514-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260108091514-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CPQTz9FYO93mfGoT18uur1I9DhJjVLS4LJig-EZlfCg_1767882442
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Jan 08, 2026 at 09:17:49AM -0500, Michael S. Tsirkin wrote:
>On Thu, Jan 08, 2026 at 03:11:36PM +0100, Stefano Garzarella wrote:
>> On Mon, Jan 05, 2026 at 03:23:41AM -0500, Michael S. Tsirkin wrote:
>> > Reorder struct virtio_vsock fields to place the DMA buffer (event_list)
>> > last. This eliminates the padding from aligning the struct size on
>> > ARCH_DMA_MINALIGN.
>> >
>> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> > ---
>> > net/vmw_vsock/virtio_transport.c | 8 +++++---
>> > 1 file changed, 5 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>> > index ef983c36cb66..964d25e11858 100644
>> > --- a/net/vmw_vsock/virtio_transport.c
>> > +++ b/net/vmw_vsock/virtio_transport.c
>> > @@ -60,9 +60,7 @@ struct virtio_vsock {
>> > 	 */
>> > 	struct mutex event_lock;
>> > 	bool event_run;
>> > -	__dma_from_device_group_begin();
>> > -	struct virtio_vsock_event event_list[8];
>> > -	__dma_from_device_group_end();
>> > +
>> > 	u32 guest_cid;
>> > 	bool seqpacket_allow;
>> >
>> > @@ -76,6 +74,10 @@ struct virtio_vsock {
>> > 	 */
>> > 	struct scatterlist *out_sgs[MAX_SKB_FRAGS + 1];
>> > 	struct scatterlist out_bufs[MAX_SKB_FRAGS + 1];
>> > +
>>
>> IIUC we would like to have these fields always on the bottom of this struct,
>> so would be better to add a comment here to make sure we will not add other
>> fields in the future after this?
>
>not necessarily - you can add fields after, too - it's just that
>__dma_from_device_group_begin already adds a bunch of padding, so adding
>fields in this padding is cheaper.
>

Okay, I see.

>
>do we really need to add comments to teach people about the art of
>struct packing?

I can do it later if you prefer, I don't want to block this work, but 
yes, I'd prefer to have a comment because otherwise I'll have to ask 
every time to avoid, especially for new contributors xD

>
>> Maybe we should also add a comment about the `ev`nt_lock` requirement 
>> we
>> have in the section above.
>>
>> Thanks,
>> Stefano
>
>hmm which requirement do you mean?

That `event_list` must be accessed with `event_lock`.

So maybe we can move also `event_lock` and `event_run`, so we can just 
move that comment. I mean something like this:


@@ -74,6 +67,15 @@ struct virtio_vsock {
          */
         struct scatterlist *out_sgs[MAX_SKB_FRAGS + 1];
         struct scatterlist out_bufs[MAX_SKB_FRAGS + 1];
+
+       /* The following fields are protected by event_lock.
+        * vqs[VSOCK_VQ_EVENT] must be accessed with event_lock held.
+        */
+       struct mutex event_lock;
+       bool event_run;
+       __dma_from_device_group_begin();
+       struct virtio_vsock_event event_list[8];
+       __dma_from_device_group_end();
  };

  static u32 virtio_transport_get_local_cid(void)


Thanks,
Stefano

