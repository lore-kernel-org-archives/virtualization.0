Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C875B39E19C
	for <virtualization@lists.linux.dev>; Mon, 13 Apr 2026 07:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776066329; cv=none; b=oGDy/4iz/dBG/9p2zWMkQINCJV015oumpeFpW8sGQniNBIF2iSyy6RIMFrSiGc7i9HczXwnbPaVi7n45vudqXbkT9xEjRdunB65qsDbcjPCK84IXWbN+CKxVsHhRxDq8OCbkzsxJJGgyAB9G2xpXENT8H60TuGmIrfrki9fgFJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776066329; c=relaxed/simple;
	bh=H53P5p+OtZnMsl2NEM/Tmrec0LxsCCr0R6/dwJEzMBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=J7s837Gs16JkvROGOOJwC4nDl07Zyi3Hqq9Kw10t8l6m+FOVc6VhkSj4cxY615McKIHVXC7puyT2XBcVo2SOXWXADKXn6zhXSjiwwJkJp/dA6ckoCkHEPnSbx/dL8XnI8bt2fU/Yya0Gk9DVXBCKSsf5i3LEdpHKu0CWF5hGrMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XIXMj2Or; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XIXMj2Or"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776066326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ym38mK7swp0+roV86qgOMSC1TWOUqeERTYCRgrFKlvM=;
	b=XIXMj2OrGtHelAcSLE/06SPu90xHoJS7TlSNI5eqjOrz3SySr08f83CBzIz0peYTQ74ML9
	oicj4PqnfQReqFEk7NUKWVHqSNOrnhY+HwUXdWdWqZInFVNVNTRix9aluP86JSyzQkVmoG
	nSOTR7cvlu5pvKg2XojiChNOV8EgwOg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-I7f4X60lNe6A8lSUQ3yIXQ-1; Mon, 13 Apr 2026 03:45:25 -0400
X-MC-Unique: I7f4X60lNe6A8lSUQ3yIXQ-1
X-Mimecast-MFC-AGG-ID: I7f4X60lNe6A8lSUQ3yIXQ_1776066324
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d775bcb14so804761f8f.0
        for <virtualization@lists.linux.dev>; Mon, 13 Apr 2026 00:45:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776066324; x=1776671124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ym38mK7swp0+roV86qgOMSC1TWOUqeERTYCRgrFKlvM=;
        b=CPL5c9I6n33aaNLbP//rA0PMbyWK8aK5GWiYlT8FtkCkdaGNcbDXaRikwdsXjAaYdy
         JaewQePh3fSwxRyEr1fZw3stMJE5Pe5Us/bP8w6aL5TRJBYwrLCWXsWbp62GEnlan0HR
         LxtAuiI16MubpsBMxS7XJqvDNxz9jdyfYWBPj6xxbAB2ij6OMCOZqBFGwJXoKi2lWBcj
         CsIfNxFw4ee9TSjHOEWO8HQ/L9mfKWO7FxB0fCGBcIkfjHDfQAAWar+SFsd8mVALmipx
         lALp+h8DkMH+F4lxAblima7P8Zx94YVRWWd0QOoe7HkxZdGwoBQIOq0WBxvTz2n+fgjT
         Y+NQ==
X-Forwarded-Encrypted: i=1; AFNElJ/iswOnSWCjHv7S4qxKLDqWBrd1PIeWkHI46vjErjIlR4tuXEqQisSIyjJxggof1uNAjpr9kjqQMsqlaIxxyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwsnVJ9qFejIey4Ct/CuxcN6O/MKmH1+l1U8WDD12nmzcXitfLp
	s0ve5/wzsGNGCy0AtFx1oTLQlqSu74hcaoVdwubwoOm1f5fc5ycd3B47x2rlnWBSNa41J0iRYgF
	ljDBHwCOzer/cwrgZ/UHpRHjbQ9dt2kXT7Qv2dkAyitbAXs/MKlFIFsCbo4QF0hzDotWy
X-Gm-Gg: AeBDiev9Q2NAxe2WTl4GFzwP2W+kuazbVkNU2+6B0hYfwKEynq1yNcNxKKvIyBZSDxf
	i/RRxl1uK/DOpRVGoQfG44dRJF0DQ+ZYBrk9EVM7evcGjFlYWVzQMIVFnKmUD8mDolXocMwDK3d
	mgdqfF0y3bFMqghlwVnB5S/lTXnkNwO7ZWXkUk3mQKpcC+R9dxE7WuzJxYktJ1Lz0MsY4m6g4+K
	UlDy3zQRr48j1qRzuDh/7a+v4G0WUw7ep7G4qjgOLiEK7JisHna2KQzUPhX+hsmfhUGb+Zp2bBF
	3crnsb7HGz0NfEJy4oluKKIWIs/96w6eaxxthL0EFalE1qK5u4AR/p2hV2KneEsSprHyo4NzH4W
	q3o6vxGOeLqAxUxdojwH+WEIukbdoWfDZaDX+nfd4Q18=
X-Received: by 2002:a05:600c:8b27:b0:488:b1c7:b432 with SMTP id 5b1f17b1804b1-488d6881e82mr154803775e9.24.1776066324234;
        Mon, 13 Apr 2026 00:45:24 -0700 (PDT)
X-Received: by 2002:a05:600c:8b27:b0:488:b1c7:b432 with SMTP id 5b1f17b1804b1-488d6881e82mr154803455e9.24.1776066323683;
        Mon, 13 Apr 2026 00:45:23 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c981sm32030537f8f.33.2026.04.13.00.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 00:45:23 -0700 (PDT)
Date: Mon, 13 Apr 2026 03:45:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jinhui Guo <guojinhui.liam@bytedance.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] virtio_pci_modern: Use GFP_ATOMIC with spin_lock_irqsave
 held in virtqueue_exec_admin_cmd()
Message-ID: <20260413034046-mutt-send-email-mst@kernel.org>
References: <20260413072249.30433-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260413072249.30433-1-guojinhui.liam@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ejwD3YDNb02XivxEBpqeyW7NSbd3FFIy5_jkh-JOkTo_1776066324
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 13, 2026 at 03:22:49PM +0800, Jinhui Guo wrote:
> virtqueue_exec_admin_cmd() holds admin_vq->lock with spin_lock_irqsave(),
> which disables interrupts.  Using GFP_KERNEL inside this critical section
> is unsafe because kmalloc() may sleep, leading to potential deadlocks or
> scheduling violations.
> 
> Switch to GFP_ATOMIC to ensure the allocation is non-blocking.
> 
> Fixes: 4c3b54af907e ("virtio_pci_modern: use completion instead of busy loop to wait on admin cmd result")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
> ---
>  drivers/virtio/virtio_pci_modern.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 6d8ae2a6a8ca..db8e4f88b749 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -101,7 +101,7 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
>  		return -EIO;
>  
>  	spin_lock_irqsave(&admin_vq->lock, flags);
> -	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
> +	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_ATOMIC);
>  	if (ret < 0) {
>  		if (ret == -ENOSPC) {
>  			spin_unlock_irqrestore(&admin_vq->lock, flags);


GFP_ATOMIC allocations can and will fail. If using them, one must
retry, not just propagate failures.
Or just switch admin_vq->lock to a mutex?


> -- 
> 2.20.1

