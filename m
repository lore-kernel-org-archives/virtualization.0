Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328DA23CF06
	for <virtualization@lists.linux.dev>; Tue,  8 Apr 2025 20:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744143339; cv=none; b=GhfZvlnp/gcT6KNEk1R49hj0QQz42tDmWG11C5N0Q1yttXfxvm06xzoQ7ICnSE9A5QKtMMnLks/AFAxfzD0DDnnvrm4sKbEahUnvT+nx1oN0ATt0Hn+c+63kcgp6VoCUe7sjMYfg4fMklmVHvlPml1ZiC339plz9VEn1GpN0X2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744143339; c=relaxed/simple;
	bh=/imu4dVQOa3vOU/oVHNu/tR40CNkT/+dS2ZPqcyshRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HAY+apzTzu7KD8MbQ7h7UPrNltACvlfsATcKRkt7KddOv4hXBeFI/aI+A4q9gZB+oir+YYff6dy28k05U9UictjtclRrgoIUFAM4uoDkFFL3bhpF+nWEwZ16KYSoxSpBQd0gPy1K8M9+GpmM1uG1NPq3R9wJTdQEe/qjdhP8OTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LJ/KnK8n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LJ/KnK8n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744143337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o8QjZveAu/2K/LGH7KGBQ5Sa2cguSA7xg7NHX/ZDvXI=;
	b=LJ/KnK8nEPf98eBUDBgWH3Xv1v90sCC14z/qdoLXkFiWsH/YUANJJI1BXTNFLdezsTxjsj
	xQzTqM0wyUmkBLCI3uG/CE1P78OCmpB5boBxxPaiJ2CeQ4sAXrhlpBLXapZ8Q8Urf6VWt3
	MGn/5urEeotyBIDzWdQcV1ySM3DNLRs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-iJASEl_SPOKJzm8Qtjy5Dw-1; Tue, 08 Apr 2025 16:15:32 -0400
X-MC-Unique: iJASEl_SPOKJzm8Qtjy5Dw-1
X-Mimecast-MFC-AGG-ID: iJASEl_SPOKJzm8Qtjy5Dw_1744143331
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cec217977so38547995e9.0
        for <virtualization@lists.linux.dev>; Tue, 08 Apr 2025 13:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744143331; x=1744748131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8QjZveAu/2K/LGH7KGBQ5Sa2cguSA7xg7NHX/ZDvXI=;
        b=v8fBb1Ko+MOIFMbIBsLyo++nJy9tEDhqp/4Yor0ZMUykaKUUBfqrAJyiBjuHIXUye6
         inioyWecaUtrGiDoR08kdmAiMdPBUXpGfUiGLMDpoLIGGVhh2P2CvWMmbagFqh8Lg2hq
         LOnbXiTujll6INZoA1HhsEIYhzh9FLsdonEuS/gcvUTyJzuFljoXH8P2kuFKfwYb+1cJ
         Cp40pL1WXTY/rkfbDhJ6O+xnSlN52tCPq7/xPmeOLtSDmLxVbQg2nCMyWBThE0Hzw/Be
         KsrDZbEUTJuutM6dapZKVmTrhASfcDg+iImpelxaSmP0bqwL5wAgDWf9awnxNhIJ5u+F
         2F5Q==
X-Gm-Message-State: AOJu0YzcQpdivoTu7GdMt3tDPfQtDpBcdzRV9F54/DuaXx6Vzn9IPy2O
	yshR8qzljlY1NFdBtDtacqCPXEao0JDZPbXBKuPhhdT+miaI2l1iKs6JkScHnBGVnJYFiLVg9/f
	lJYpkfEUMDn5OUkm/+blLiqp3lFPrjzxWdhqv7crfAgwtunerMfrLxLqfEECvOXCr
X-Gm-Gg: ASbGncsZK5YQ2dKQkeb7DbTmkD+HceRxWPJhpIn49rc0yxVWh7ruehoeJ/s8J8rbk7n
	xfAIZMrxXJx0Rwtlyp4EfuqNUuyrEaRjn/6QOhjDo8K0tq2NTVYeKNf/ai8Llz5d2X3pNZAGy/d
	JjhSAX3YtR259JdL6pbz++ZAAGHrRdVNP2pq3raZlJjRaYpOCzzaBZvF92vLVY6s/54mKTr5g7+
	PcUxoRtI/b+bJ7G1RcleSHM5UK3vPm/8++QL8mbaRuTcmQUbVBkgp14bzMAvWcnkJCKKlHMaDVy
	Zj+o3IDeSg==
X-Received: by 2002:a05:600c:3b99:b0:43c:fe15:41dd with SMTP id 5b1f17b1804b1-43f1fdc3c3fmr471285e9.6.1744143330921;
        Tue, 08 Apr 2025 13:15:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn8z1doH7wp9+dHhoArMr/BsEh7IuVXOUKUcc5oWzI+ZgXkEyl+vRRrYAEmbGXMQXzSRRp2g==
X-Received: by 2002:a05:600c:3b99:b0:43c:fe15:41dd with SMTP id 5b1f17b1804b1-43f1fdc3c3fmr471095e9.6.1744143330562;
        Tue, 08 Apr 2025 13:15:30 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34be2ffsm170017585e9.22.2025.04.08.13.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 13:15:29 -0700 (PDT)
Date: Tue, 8 Apr 2025 16:15:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	stefanha@redhat.com, pbonzini@redhat.com,
	xuanzhuo@linux.alibaba.com, stable@vger.kernel.org,
	lirongqing@baidu.com, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
Message-ID: <20250408155057-mutt-send-email-mst@kernel.org>
References: <20250408145908.51811-1-parav@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250408145908.51811-1-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iFAY1WXhYH75ivcasn9tHjvqne4w2y76UzzKetJmUbw_1744143331
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 08, 2025 at 05:59:08PM +0300, Parav Pandit wrote:
> This reverts commit 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio pci device").
> 
> The cited commit introduced a fix that marks the device as broken
> during surprise removal. However, this approach causes uncompleted
> I/O requests on virtio-blk device. The presence of uncompleted I/O
> requests prevents the successful removal of virtio-blk devices.
> 
> This fix allows devices that simulate a surprise removal but actually
> remove gracefully to continue working as before.
> 
> For surprise removals, a better solution will be preferred in the future.

Sorry I'm not breaking one thing to fix another.
Device is gone so no new requests will be completed. Why not complete all
unfinished requests, for example?

Come up with a proper fix pls.

> 
> Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio pci device")
> Cc: stable@vger.kernel.org
> Reported-by: lirongqing@baidu.com
> Closes: https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9b4741@baidu.com/
> Reviewed-by: Max Gurtovoy<mgurtovoy@nvidia.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>


> ---
>  drivers/virtio/virtio_pci_common.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index d6d79af44569..dba5eb2eaff9 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -747,13 +747,6 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
>  	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
>  	struct device *dev = get_device(&vp_dev->vdev.dev);
>  
> -	/*
> -	 * Device is marked broken on surprise removal so that virtio upper
> -	 * layers can abort any ongoing operation.
> -	 */
> -	if (!pci_device_is_present(pci_dev))
> -		virtio_break_device(&vp_dev->vdev);
> -
>  	pci_disable_sriov(pci_dev);
>  
>  	unregister_virtio_device(&vp_dev->vdev);
> -- 
> 2.26.2

