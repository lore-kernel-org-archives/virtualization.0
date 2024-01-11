Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593173AC10
	for <virtualization@lists.linux.dev>; Thu, 11 Jan 2024 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ngn+ppKP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704990095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JvPBzU48g+Kj3geUcBzFQYW5BOe891w+ulXTpHSpKEc=;
	b=Ngn+ppKPAM5kkdvFXJIb4UDGzYogfO1jp2TFb2MlqFzzIpkuMqlTU+GGp1E7kF8Y16sODM
	SV9KJXknguUN5k9mBZYJxmwF1jNEKcvSxQAZlM91m2/wsvjKd6ebwEvGs5hMBS3JOxBxt6
	RC3CjCMB4aIAcoTMBSTFk2fW1S6KbqE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-BrIP8VEiOUGymk1MOLF9XA-1; Thu, 11 Jan 2024 11:21:33 -0500
X-MC-Unique: BrIP8VEiOUGymk1MOLF9XA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3374e909bf0so3822454f8f.0
        for <virtualization@lists.linux.dev>; Thu, 11 Jan 2024 08:21:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704990091; x=1705594891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvPBzU48g+Kj3geUcBzFQYW5BOe891w+ulXTpHSpKEc=;
        b=KGd/MIHhmK2D183jPOQDp7teyU21+9pi8tTHT4Uqpbxe+8J0zMn7bZO0iEZ7hra+nW
         9X54eGTbwAhHvrkXr4beTDL2xCnBDkz3aRstBLvwxQWf98ILZHgkCdOSxN0jMgztf5l6
         DOtQPKWJ0HPdGLeSW4Wsv//BfrYqj0WuZXCKXOSS3a9XGYi1F2UPHBIiwworrecyEEmg
         2uEL3DTGzjk+aKvkE3ssGipawbTbzjl+zec4JOh1oxp8Chmc6GwS1ndJ8sRgCRH+uU/H
         qxb6nc7GrR2rcXOG3cDb1z4L61BlYxKRLuKoBRewggy5hdWOUg4u/6H9BU6jAe5w+bRA
         aw9A==
X-Gm-Message-State: AOJu0YwZLqL31YUfcQG6E5gr3JCMiLUxyLat45T6VE439ip+UVMQgBCx
	HSzmY0EDQgl5V31WbwV7uVtWQwkbuugZ7c7cibXhl1vexkjNXFiUTIH3u+i/yGImYqGWdcwAQXk
	82oX1AKazJA30Htcd2Y9SYPiBGtQRczpT8/I=
X-Received: by 2002:a1c:7c0f:0:b0:40e:5200:c52d with SMTP id x15-20020a1c7c0f000000b0040e5200c52dmr30943wmc.155.1704990091563;
        Thu, 11 Jan 2024 08:21:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEaeC2uKfo8BW+esW4GHrk7FGjIhWC2rNiHELMXpy41s14emHFCK6X00UyolTG9D7JDAjG/hg==
X-Received: by 2002:a1c:7c0f:0:b0:40e:5200:c52d with SMTP id x15-20020a1c7c0f000000b0040e5200c52dmr30939wmc.155.1704990091232;
        Thu, 11 Jan 2024 08:21:31 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f7:a7f5:1896:f0bf:bfb0:71ac])
        by smtp.gmail.com with ESMTPSA id g16-20020a05600c4ed000b0040d91912f2csm2522333wmq.1.2024.01.11.08.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 08:21:30 -0800 (PST)
Date: Thu, 11 Jan 2024 11:21:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Li,Rongqing" <lirongqing@baidu.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"parav@nvidia.com" <parav@nvidia.com>,
	songyang23 <songyang23@baidu.com>, liubokai <liubokai@baidu.com>,
	"Song,Zhan" <songzhan@baidu.com>
Subject: Re: [RFC] Revert "virtio_pci: Support surprise removal of virtio pci
Message-ID: <20240111111921-mutt-send-email-mst@kernel.org>
References: <c45dd68698cd47238c55fb73ca9b4741@baidu.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <c45dd68698cd47238c55fb73ca9b4741@baidu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 11, 2024 at 09:14:37AM +0000, Li,Rongqing wrote:
> Revert "virtio_pci: Support surprise removal of virtio pci device"
> 
> This reverts commit 43bb40c5b92659966bdf4bfe584fde0a3575a049.
> 
> Marking the device as broken will cause the uncompleted IO request on
> virtio-blk since virtblk_done will not continue when it find the broken virtqueu
> at last it will cause the failure of removal of virtio-blk device because of
> uncompleted IO request
> 
> The correct fix for the issue that commit 43bb40c5b9 ("virtio_pci:
> Support surprise removal of virtio pci device") tried to fix
> is that virtio backend always complete the IO request as soon as possible
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/virtio/virtio_pci_common.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index 7a55939..d60fe99 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -584,13 +584,6 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
>         struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
>         struct device *dev = get_device(&vp_dev->vdev.dev);
> 
> -       /*
> -        * Device is marked broken on surprise removal so that virtio upper
> -        * layers can abort any ongoing operation.
> -        */
> -       if (!pci_device_is_present(pci_dev))
> -               virtio_break_device(&vp_dev->vdev);
> -
>         pci_disable_sriov(pci_dev);


Maybe break device is not the right thing to do. Indeed, request buffers which
have been already used are not completed by driver.
Just removing this is not good since you can then get more requests
and the device is gone.

>         unregister_virtio_device(&vp_dev->vdev);
> --
> 2.9.4

