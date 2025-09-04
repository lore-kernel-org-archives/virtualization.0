Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5776B2C1590
	for <virtualization@lists.linux.dev>; Thu,  4 Sep 2025 21:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757021920; cv=none; b=nADjlDJQb3S7HFQIsfSdu1AdJbugIPdwghq8ANZof4SqJfvB2Srr3093TMl3X5eZKt92QW5/+pWOBBD2QI9oNL37C2VLUZsMQyGT0zAdBpJjrhVys0Cv/cdWWOsk6cyazFXjg8bd0a4zGskvY5HT2tV0ZyOh6ih6o/wwDZaL3v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757021920; c=relaxed/simple;
	bh=+ZrUvtnLM9xSVjfFb/jug+Mxt/vh9q4WYgIFgX9cQDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qgBDXH/gxFwj605DY4q5xKYdPU78GSv4CGOixUsYysDx4JWNGn8VX+ce4vAjES1lh9UrK3oPrW27Hu2PZESGL870FaaxeQTWPXheSORIvzm+3yvBYO/sWh5JvqVRlS+K9pXIGoDb/hktbzYGSqXLCZIciwGA3tiK8Ue2C7EY8jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YonimIRa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YonimIRa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757021916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9rHD7plJVEZkv8PkFJEx5BeBVBt5QFBtzvV5bLJfU1s=;
	b=YonimIRaQfmjZmONKBCfD6uIUf72F7UeUjgj3gOSg/Y+tQDZew2Of2aKrFfKjJoUwkVtGU
	CtwQrj0Yg6Fccrt15AocknIp7VJ4OTOA2l+CAiOi9/Fnik8vGSLbmhjPHG3rtZgsCCMaq+
	KMWT7TwKChngPxKZFUtIPehdExsTFmk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-QWLlf-CrPLKkvidU6EHCXA-1; Thu, 04 Sep 2025 17:38:34 -0400
X-MC-Unique: QWLlf-CrPLKkvidU6EHCXA-1
X-Mimecast-MFC-AGG-ID: QWLlf-CrPLKkvidU6EHCXA_1757021913
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b99c18484so6128165e9.1
        for <virtualization@lists.linux.dev>; Thu, 04 Sep 2025 14:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757021913; x=1757626713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rHD7plJVEZkv8PkFJEx5BeBVBt5QFBtzvV5bLJfU1s=;
        b=nOz4lxchqFaG3ZPG2DNwDDhwc7yXZI2SInqKUbxYCIMeN6CutwL2SVrFye8PVSUKin
         RaPzVzYVcpcjY4Ur6bfHVvmOeObrIIKYJH1xB0Br65NWQ7z5Id57GyKwpTu+98j/+CJM
         w3IkjfZf6nEDohRdE9U2hHM1haPNMwjuifO0pPmvEmiPmtUXAP0w+Dy021BiQjqX4E10
         jQUczJpDFlZRKZFxVPq8hfS+CzNsghOdeGf+aHH7kEUE13UZRI2aGOYsoBxxq6F1Mzyn
         dJ4opZc2I/5hW0ri80+9b0bcBx3uyT5awcmWqfbjkAyxTzoTWZkFB4IISiEPnkc9AecV
         wyiw==
X-Forwarded-Encrypted: i=1; AJvYcCXWr9ApbwXrBTsgrj2QE202UhlvoWtDL2jKpmsZ0BI5w4LwBSMJRjXshDdedRVlk5xAGYuMhGQlWIxi7UFHBA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwYTx1ynu6eJZMh8zJAz056q28SC16ia73B3vkDDeJS9gbhn+Kh
	MK/Y5GqWeomMS8uDn4Y2OOVF8R46uGSou/yk7oD8V28qOd06Ngc70OS0K/UXkGYBoPbUGlDXFhY
	N+4NLSukcrAXJWtADywmKBDhwX2tZ3JvkcH51vdj9j9TTgwy0IborcskUHOfygoJGhCpS
X-Gm-Gg: ASbGncvtFDWPCjb5CLPKgQGFuB3aWW3lMIWYd6BwqHLPS2XEhys4DoPNs20ZLvdvemF
	lmzx8KTVL3GjWWJHDo3mHV6jIEDenT5uXsZoY7GnTOynwqoYlcUq1ZkMl/n3JT3+B06rigiouz7
	3ZRkMWg4DDoPk0T/XQgVt27I3TueSYUB3lpsLJYYFq7n4slGAx7G22FTYabc+7U5rr791m6PjfC
	velDs2y8bp3PU4+2nJ2XVTEGr92b3fht4NN+OPryGFrGOb47QGkG5Olz41U0k8qxdV7IZ9qXD8m
	5cL+DqMPstvn54ge0clQU+VKs+bdG05xZfZJskgCab5ucZFwdjT5k6Veovl4b7azuw==
X-Received: by 2002:a05:600c:1d10:b0:45b:891f:afcf with SMTP id 5b1f17b1804b1-45b891fb24dmr144597835e9.27.1757021913367;
        Thu, 04 Sep 2025 14:38:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWbBDlkpyRRxeIt/+qH4VagktWDBCJazVbSXDHRMhx/diXSZUFSBaQ6M24PtRDNYL0yu7m/g==
X-Received: by 2002:a05:600c:1d10:b0:45b:891f:afcf with SMTP id 5b1f17b1804b1-45b891fb24dmr144597725e9.27.1757021912965;
        Thu, 04 Sep 2025 14:38:32 -0700 (PDT)
Received: from redhat.com (93-51-222-138.ip268.fastwebnet.it. [93.51.222.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf3458a67fsm1872200f8f.62.2025.09.04.14.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 14:38:32 -0700 (PDT)
Date: Thu, 4 Sep 2025 17:38:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-efi@vger.kernel.org, virtualization@lists.linux.dev,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 7/7] virtio_balloon: Stop calling page_address() in
 free_pages()
Message-ID: <20250904173824-mutt-send-email-mst@kernel.org>
References: <20250903185921.1785167-1-vishal.moola@gmail.com>
 <20250903185921.1785167-8-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250903185921.1785167-8-vishal.moola@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0Iq8lh5jUSklhl04tWBxZomGfSVfJGH-P3Nu_r_LG_8_1757021913
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 03, 2025 at 11:59:21AM -0700, Vishal Moola (Oracle) wrote:
> free_pages() should be used when we only have a virtual address. We
> should call __free_pages() directly on our page instead.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/virtio/virtio_balloon.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index eae65136cdfb..7f3fd72678eb 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -488,8 +488,7 @@ static unsigned long return_free_pages_to_mm(struct virtio_balloon *vb,
>  		page = balloon_page_pop(&vb->free_page_list);
>  		if (!page)
>  			break;
> -		free_pages((unsigned long)page_address(page),
> -			   VIRTIO_BALLOON_HINT_BLOCK_ORDER);
> +		__free_pages(page, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
>  	}
>  	vb->num_free_page_blocks -= num_returned;
>  	spin_unlock_irq(&vb->free_page_list_lock);
> @@ -719,8 +718,7 @@ static int get_free_page_and_send(struct virtio_balloon *vb)
>  	if (vq->num_free > 1) {
>  		err = virtqueue_add_inbuf(vq, &sg, 1, p, GFP_KERNEL);
>  		if (unlikely(err)) {
> -			free_pages((unsigned long)p,
> -				   VIRTIO_BALLOON_HINT_BLOCK_ORDER);
> +			__free_pages(page, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
>  			return err;
>  		}
>  		virtqueue_kick(vq);
> @@ -733,7 +731,7 @@ static int get_free_page_and_send(struct virtio_balloon *vb)
>  		 * The vq has no available entry to add this page block, so
>  		 * just free it.
>  		 */
> -		free_pages((unsigned long)p, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
> +		__free_pages(page, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
>  	}
>  
>  	return 0;
> -- 
> 2.51.0

