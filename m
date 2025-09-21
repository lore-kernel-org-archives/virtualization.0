Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A169449620
	for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 21:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758490924; cv=none; b=GGnTbQayVGV/HRiXun7+9IZUjhvyH6Jw6H88B7MZoX9qJB0F0MCq21xroymUojpQVfRHDzSkjwcxJfXB5BCLA3jyIEltXr82FDgN58jkjSAZaL14D+HqaC4wwz04oetc0kBlNv7kY9uRlATiR51TvmYOWd5MYuIkI93Sa1XcfzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758490924; c=relaxed/simple;
	bh=NsJb4st6T99WMlBu/ChJ8MnGDssz57Eubv5GG90Wdek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=NVzF5tEYAzoDCui2VtDIltrYla/dO3FmjpKxBQ+S3OlkwaeazCzngTMpHLIJpedEZxodE/Bu28t3sl8TBvvUzaR4zLlytkn4aysWCYMiHvqtEy6ctUEFQvBVLROE+B3mA0uDkRWt1xIddI+KWFUQP1jDl6HJmSBWaWTE3e7b708=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g45t1F1H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g45t1F1H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758490921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IXbaHpfhyIqU48t3D/0byoBr9VRqYAJB99Dj7IEd2W0=;
	b=g45t1F1Hqzff4Uog3m4lp1wmBbDbH7l3nLA0+YsYW+YbeDc+es3Y2L7ugmv3fPuio6XRor
	dZzBBXtgMy9QIdPm+tdGDbYT30YBp8kKZw1mI76rHpktF572f2gSwrw3QclCPz7zZUDFcP
	MGWmxb43Qcxt1mvhkNhfv01LT4ZfLsw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-Ra5L1NBwMWSE7NnW2yD2KA-1; Sun, 21 Sep 2025 17:42:00 -0400
X-MC-Unique: Ra5L1NBwMWSE7NnW2yD2KA-1
X-Mimecast-MFC-AGG-ID: Ra5L1NBwMWSE7NnW2yD2KA_1758490919
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46c84b3b27bso5052225e9.2
        for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 14:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758490919; x=1759095719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXbaHpfhyIqU48t3D/0byoBr9VRqYAJB99Dj7IEd2W0=;
        b=BOS1zSi2dge/Frg/m2XSO/PlPjdbLIwsbvpeG5ulCWyVpTzZR6+LEtTmvSCOGVShqh
         2MGL7aVGNvJzUyTRY6R46N5c7cARpREdn06U2jU7w4vRVMXpi1V4x42NwNkRzt3tuCS2
         f/MyX/gxYvdIPJS+V5C4sWYl+PNUI2rm6ng3uwkL7QAchMp1D0t5fFLHRlIli6dgFq43
         ZXeMiiG4Qunm635KXfcGBfoodngFtE2DdKwfiId/DYkHJcVMvXuawB9ii5XwPG1KxkYy
         hfmln5uGOBZLvAzAu891nlGx7bSs7WJYTz/IY/YO9/VS0QFOJ3RplUjEHKmhuBSqXwVo
         zBLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi/glMxnAAI5EUGdxmhKCemru6ck2uk+DQPrjB2MMPiDmHQpgqCSrCzqx/TKJxJiCHw3INC8jdDJV7l7vrtA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzxim5D1ntraEygVG3ql7rpnf+otdXh1ZLv4tK1BCunRpe0/Yiz
	6dadIIyR4sTZ2Vsg51huQoTMOBvoxTwWqFuAjHb10LoJMd381dUSXWCEgIxkQK6XkGaH6D73dSs
	pfjWM45xhD+zpt5WCmRNERsdHRbg+WBt8fqWyT0CHildOmiEGSDTzNkolkwgNVo84MLaa
X-Gm-Gg: ASbGnct5Y2HWTy7s3XMa2r2Eu0tnK/6WCFHrcxD0aNPWmjOZ/WwC9fP8QVkrmtoqrnE
	ws/NwCz7lfe0b0ZND6IEdI+VcHF+rrHAnBPADTxb7CDYWhb1dLShexw+QU0ykaumC0aQal9ewda
	TXwDZyg4Y0IxsUf5i4rp9SViv8Xlkzj692JNRLpOP1Ba6kJ6Bll9BP/XjsxgsirEnkE6fkWMPxH
	G1cC12OFWZid9esPip9QI3pl7/eL/qIt0Bx8x76hGEh8sSCKCQm5VTaEjPQaKHr9fQGPyNTuFIZ
	TwUTe8750U3EEoFwxxL8XSTqJZl430OoQuI=
X-Received: by 2002:a05:600c:3593:b0:45d:dc85:c009 with SMTP id 5b1f17b1804b1-467eed8f53amr130731655e9.10.1758490918679;
        Sun, 21 Sep 2025 14:41:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFP8mWhdXShjZD0e5Xi7FTGL9vfgfRfQHQVeAIFxmMdoNRpcK/uKJpXqqR5BGPpb4ADjBQBLA==
X-Received: by 2002:a05:600c:3593:b0:45d:dc85:c009 with SMTP id 5b1f17b1804b1-467eed8f53amr130731455e9.10.1758490918213;
        Sun, 21 Sep 2025 14:41:58 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07412111sm16881566f8f.28.2025.09.21.14.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 14:41:57 -0700 (PDT)
Date: Sun, 21 Sep 2025 17:41:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	hch@infradead.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V5 5/9] virtio_ring: rename dma_handle to map_handle
Message-ID: <20250921174143-mutt-send-email-mst@kernel.org>
References: <20250813054831.25865-1-jasowang@redhat.com>
 <20250813054831.25865-6-jasowang@redhat.com>
 <20250921165408-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250921165408-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Z0LPdFSa5eBJ2zfilVshQSgovZMRG5jatYvNKrEn6kQ_1758490919
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 21, 2025 at 04:54:19PM -0400, Michael S. Tsirkin wrote:
> On Wed, Aug 13, 2025 at 01:48:27PM +0800, Jason Wang wrote:
> > Following patch will introduce virtio map opreations which means the
> 
> operations

note that i fixed it for now

> > address is not necessarily used for DMA. Let's rename the dma_handle
> > to map_handle first.
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index fb1d407d5f1b..94b2a8f3acc2 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -305,18 +305,18 @@ size_t virtio_max_dma_size(const struct virtio_device *vdev)
> >  EXPORT_SYMBOL_GPL(virtio_max_dma_size);
> >  
> >  static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
> > -			       dma_addr_t *dma_handle, gfp_t flag,
> > +			       dma_addr_t *map_handle, gfp_t flag,
> >  			       union vring_mapping_token *mapping_token)
> >  {
> >  	if (vring_use_map_api(vdev)) {
> >  		return dma_alloc_coherent(mapping_token->dma_dev, size,
> > -					  dma_handle, flag);
> > +					  map_handle, flag);
> >  	} else {
> >  		void *queue = alloc_pages_exact(PAGE_ALIGN(size), flag);
> >  
> >  		if (queue) {
> >  			phys_addr_t phys_addr = virt_to_phys(queue);
> > -			*dma_handle = (dma_addr_t)phys_addr;
> > +			*map_handle = (dma_addr_t)phys_addr;
> >  
> >  			/*
> >  			 * Sanity check: make sure we dind't truncate
> > @@ -329,7 +329,7 @@ static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
> >  			 * warning and abort if we end up with an
> >  			 * unrepresentable address.
> >  			 */
> > -			if (WARN_ON_ONCE(*dma_handle != phys_addr)) {
> > +			if (WARN_ON_ONCE(*map_handle != phys_addr)) {
> >  				free_pages_exact(queue, PAGE_ALIGN(size));
> >  				return NULL;
> >  			}
> > @@ -339,11 +339,11 @@ static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
> >  }
> >  
> >  static void vring_free_queue(struct virtio_device *vdev, size_t size,
> > -			     void *queue, dma_addr_t dma_handle,
> > +			     void *queue, dma_addr_t map_handle,
> >  			     union vring_mapping_token *mapping_token)
> >  {
> >  	if (vring_use_map_api(vdev))
> > -		dma_free_coherent(mapping_token->dma_dev, size, queue, dma_handle);
> > +		dma_free_coherent(mapping_token->dma_dev, size, queue, map_handle);
> >  	else
> >  		free_pages_exact(queue, PAGE_ALIGN(size));
> >  }
> > -- 
> > 2.31.1

