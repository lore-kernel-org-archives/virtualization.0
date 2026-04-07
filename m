Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2133370EB
	for <virtualization@lists.linux.dev>; Tue,  7 Apr 2026 16:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775579194; cv=none; b=gy8Sq28zC1BipXgtwi+2Oyxdo3fjorLlYQaDSq9e/5p4NDGj1TEc3FB7QFUEoOSjKiBInvA3XCLwtXqxAzVIF41WGBD6dvT7Xkf8EzKeMhAKn+uWWuzZb5rDTLICuInLMLe59cqKrsThfMBbKZVoyiY2jKihfRQrh0xTZ8P7K08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775579194; c=relaxed/simple;
	bh=fbOEu+jZ5gWQtEbMOTlKsi0GzHP5GWVKI3Abr8sfzKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=n9twlr2FsXmfF2NEUHX65e4tt5T0cRqLQRg3MPk5AIzbzvgA4vUWsGyLOZxmILSmmF6phw8Yr66JOAwUrI0NXTl75FtXjkP4MSK8YP9qPrL3+JHV+HzN/WhOvy3H3NfA7XW2knaUqLE1wrgD8MgRI8fA5gF8Sgp9er//uenQCwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PvLi6Wx8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PvLi6Wx8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775579191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8npqhpaBA5MRtqt/4GYV1vIKXt2vPo1F//ZDD/W6Pz4=;
	b=PvLi6Wx8u8nEmsQdzqr3Cbhc9QrKCaFTT7POcS7wqUP6mq8L/2jxF47LjdKRxDAb/rmQNL
	V+lXV+8BHckVtqtRfmrpMnL/9Oeb369qJbUXrNoH+PhPeFts4OmNjMeJ+dJes02tzOqgRT
	DZNpXJVqd5P/9a2qJ33QxwEeLyukNkY=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-fI8P0g9aP7-AIPrNa48oNQ-1; Tue, 07 Apr 2026 12:26:30 -0400
X-MC-Unique: fI8P0g9aP7-AIPrNa48oNQ-1
X-Mimecast-MFC-AGG-ID: fI8P0g9aP7-AIPrNa48oNQ_1775579190
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7d9d60f8e3aso9948750a34.3
        for <virtualization@lists.linux.dev>; Tue, 07 Apr 2026 09:26:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775579190; x=1776183990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8npqhpaBA5MRtqt/4GYV1vIKXt2vPo1F//ZDD/W6Pz4=;
        b=rQ6spxhxHXXfJ9cYn7QE3jmcbzYueVjJfDvSsx8VWrs8fPYKTyBdEX62VovLhJLkrv
         cEHeB+iWRU4pu/C7zTU64grxSjCVAveP4Vs5WmowVI7jFPYG4VywYcAFO+8MRC/1BR3R
         XwyO9/IyVKnNwInNwDyPqI1hgtt2S6zxh/TVIFkKN8kKEjkYyqYkJrY6h+P7CwB5mJ04
         5KlLHU1h+cRrPX/klDTIzrwgOFRQS5GqX9lRVQrSttjshRDcuGYUEGk3faHvgLqHDhCY
         v9iLrzsOCAyT+fsBs/mbWN+I16g8MB1SFBHcNOA4xJEMxxfRW3lpZQ76lYqfN0UmzZui
         r9rQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFzlvnte/LPOEvIE1RR4JuDbAUlx3U9IEMGOs5Q8moH8BWnrkZM+KxL9P1Ud4F8NblrJLev8h8zUdteZb79A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx12zBRLmxdIzLGnpWbnW/DTCrAoHaWJR8iiUH11/2MoNouiVll
	V0dlY682sFQUYwPeY0LaZLh+OOYpvqLjN4MexlTpTGWMuzQ4gJJGKNIw+edMuLVVhoMEDKa8l2Z
	hjKP430y5mNJrIKDCHXUCU1rGLs5b9ryYCy/qvk7QBxEnIF3rEjl4SWzNiTzLaLYg2XxK
X-Gm-Gg: AeBDietSCWEtoM9BOXAVapgdY8EyYk86l/binFlbdzW0z/voHQjtHvLlzXaWjnOJxVU
	tQx3OBBrG9OiEMySEvGeWXccET5SKfspVi2O4epyqX/JaE4azwMb3I+PMfEahhFr1GZu8vfcxw3
	pF44jgU0WhjmvYEsmWEyeoDsqWs0JlAe2ewdhcAMYZHed1RxdY74qSX1TBN7XgW8G4jSPOEdl0w
	XQZg5t6TF7kmFwF9gl2IGJwzLGDY+IN42wJpw7yndFa6MjOnQv+9ztX0NFWR8PC1zHhp6+kdItA
	scWR10+9UyIge2oTkXU82ljJAyfdEOXz2vf+WQW1/0ewXfsies12nh0gi6zfx9ZrH2JdZncjtYx
	K+qpPDRVpN3ph
X-Received: by 2002:a05:6830:2aa5:b0:7db:a8b7:c565 with SMTP id 46e09a7af769-7dbb7111006mr12385879a34.20.1775579189734;
        Tue, 07 Apr 2026 09:26:29 -0700 (PDT)
X-Received: by 2002:a05:6830:2aa5:b0:7db:a8b7:c565 with SMTP id 46e09a7af769-7dbb7111006mr12385849a34.20.1775579189094;
        Tue, 07 Apr 2026 09:26:29 -0700 (PDT)
Received: from redhat.com ([37.19.196.202])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dbfc1cb79esm1139886a34.15.2026.04.07.09.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 09:26:28 -0700 (PDT)
Date: Tue, 7 Apr 2026 12:26:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Stellman <astellman@stellman-greene.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH 2/4] virtio-pci: use avq->vq_index for admin VQ in INTx
 path
Message-ID: <20260407122608-mutt-send-email-mst@kernel.org>
References: <20260407123904.6390-1-astellman@stellman-greene.com>
 <20260407123904.6390-3-astellman@stellman-greene.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260407123904.6390-3-astellman@stellman-greene.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _Dh1ZoWT8r9UvoKuzmf1FIvC82MjLwsDOo_2WtQSSyU_1775579190
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 07, 2026 at 08:39:02AM -0400, Andrew Stellman wrote:
> vp_find_vqs_intx() sets up the admin virtqueue using queue_idx++
> (a sequential counter) instead of avq->vq_index (the actual transport
> queue index). The MSI-X path in vp_find_vqs_msix() correctly uses
> avq->vq_index. When the admin VQ index does not equal the next
> sequential queue_idx value, the INTx path binds the admin VQ to the
> wrong transport queue.
> 
> Use avq->vq_index to match the MSI-X path.
> 
> Signed-off-by: Andrew Stellman <astellman@stellman-greene.com>


Cc Jiri. fixes tag?

> ---
>  drivers/virtio/virtio_pci_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index da97b6a..0b9d66b 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -497,7 +497,7 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
>  	if (!avq_num)
>  		return 0;
>  	sprintf(avq->name, "avq.%u", avq->vq_index);
> -	vq = vp_setup_vq(vdev, queue_idx++, vp_modern_avq_done, avq->name,
> +	vq = vp_setup_vq(vdev, avq->vq_index, vp_modern_avq_done, avq->name,
>  			 false, VIRTIO_MSI_NO_VECTOR,
>  			 &vp_dev->admin_vq.info);
>  	if (IS_ERR(vq)) {
> -- 
> 2.34.1

