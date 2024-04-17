Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADB6136E16
	for <virtualization@lists.linux-foundation.org>; Wed, 17 Apr 2024 09:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346192; cv=none; b=LAJcAmsyyWhwAQ8s81WBnsNn8KghOAERWyJZudU136jnkSOMxAqAZbJ/2RYSR40J/ElHpCfHJHSoFkvRgSGEgDeTuwzh1cT+pniOTuo5jEkoyX0YiZZvACFpTgVFFzea/SZvXasQfFmvidY5Trt2UJOZCv81ed2mxSley57CUb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346192; c=relaxed/simple;
	bh=Z6a2clvySatSre/JWaMGilT9UiZWLgBF9gzq2yif97A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UMC7UUHIUIaGS2IzJNjxVsmvGLhvzBx+h51Wj43Q0X/KxpBpKmMfTL5Lrhyv1sGa+GI2FvqR6DGkhNcRs58lQBvQTTcvooIDdVReM39sFPbVSe/bXzcLAye4LUvZ4FBMoEWMfW3dNC2IUdrXDbvRbZnBYQtNcwiKFpwm2z21Pws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RrRWvZJT; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RrRWvZJT"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A793D60AED
	for <virtualization@lists.linux-foundation.org>; Wed, 17 Apr 2024 09:29:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DtncJWXxIYW6 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Apr 2024 09:29:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8F56660AD1
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8F56660AD1
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RrRWvZJT
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8F56660AD1
	for <virtualization@lists.linux-foundation.org>; Wed, 17 Apr 2024 09:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713346186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wnkR6+X++mIRsBRTPfNHWnFS6/+Rlqu2C6vcj0wKpTk=;
	b=RrRWvZJTGHy5KI2mQrKVHQT/weAUDRwRvb7xywXMAhnlo5OcS/xALcKeJheY2jnI8RRwDC
	i09T4EAmyDNx5Zq11K4dBHGjltgYqdKIG33kfb9/oaxBK/67M5rb0wAv/sRwkzworojeKA
	ub6MigMSLqTSUTvX0HRajgHpaPn8HUA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-10Zn2zw_OWemoyGi9emH7g-1; Wed, 17 Apr 2024 05:29:44 -0400
X-MC-Unique: 10Zn2zw_OWemoyGi9emH7g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-343f5059c5fso3352842f8f.2
        for <virtualization@lists.linux-foundation.org>; Wed, 17 Apr 2024 02:29:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713346184; x=1713950984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnkR6+X++mIRsBRTPfNHWnFS6/+Rlqu2C6vcj0wKpTk=;
        b=DYdvhc7kXvuG3MDa5kOLOV86VRiXk7JSmL4MTEveBX3woNPKT9DYZa/S7nQ3fL7/jr
         yYQuposWjwcgTGE7F4DrLvOQkd3onSu1mAQm/VwaQ2+e+o7wUXFCTSXTBpMTMXXKe5mm
         LSVRTwYu9D5sLjrFl6ZJ5jk0TYz6p1Dacu+avJSw2VZdCqKJy8oD53ciYic++y/JxgUu
         AKPdz0RaKVEJq83g9DeXffyR1Enr9ZVmBNmlUDz1VvDLemxBDt7Rgn9mDOeTYdfJZp1r
         lj2/SW1PMda00kb11GLxQEqBo89Blht953WDPl3+4VHjyvzzXE3okyGTRIhB9bCMJXXu
         9MTg==
X-Forwarded-Encrypted: i=1; AJvYcCXBQVtIda6P76/BfBTLO8O0gMRVmliHosGPK9TbZND1FLBv0iYjBChmd30UNVlbXNzFmpbFB0WcmmC9DmapvZr3cx41W1bzFAHtwD9OO2OB9uiNEGgXc2y3EQ==
X-Gm-Message-State: AOJu0Ywkj8KX7YadO/e3hmTIIuU0kN04D3puTZ+R7wqrLeHVKhYc76Fw
	h/vlVoEnzXYJ0L8xm7gbhHwB2ierFtPy7CnsxC1oA0wWJ1To5TjwNKw2oWckm0vgujamSy+WAAh
	I3XYivuuBgJjEPRSj/4yfOJjHXmR0K09XmLg9FoT/NOtsp6Z0M+zmyOc12QyhKCE6dN5lj315xd
	xFvdw=
X-Received: by 2002:adf:eb49:0:b0:346:4307:dd2b with SMTP id u9-20020adfeb49000000b003464307dd2bmr10290213wrn.46.1713346183614;
        Wed, 17 Apr 2024 02:29:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF02GRQhjx9pu5ih6EDC9BEkFgvPWyPa0fKgwGMnMjvoVvyawFthVWcHSGEIVbi6dxJppaSpw==
X-Received: by 2002:adf:eb49:0:b0:346:4307:dd2b with SMTP id u9-20020adfeb49000000b003464307dd2bmr10290193wrn.46.1713346182968;
        Wed, 17 Apr 2024 02:29:42 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17e:a69f:1202:8a1b:788c:6fa1])
        by smtp.gmail.com with ESMTPSA id l3-20020a05600012c300b003434c764f01sm16960454wrx.107.2024.04.17.02.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 02:29:42 -0700 (PDT)
Date: Wed, 17 Apr 2024 05:29:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v5 3/5] vduse: Add function to get/free the pages for
 reconnection
Message-ID: <20240417052723-mutt-send-email-mst@kernel.org>
References: <20240412133017.483407-1-lulu@redhat.com>
 <20240412133017.483407-4-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240412133017.483407-4-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 12, 2024 at 09:28:23PM +0800, Cindy Lu wrote:
> Add the function vduse_alloc_reconnnect_info_mem
> and vduse_alloc_reconnnect_info_mem
> These functions allow vduse to allocate and free memory for reconnection
> information. The amount of memory allocated is vq_num pages.
> Each VQS will map its own page where the reconnection information will be saved
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 40 ++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index ef3c9681941e..2da659d5f4a8 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -65,6 +65,7 @@ struct vduse_virtqueue {
>  	int irq_effective_cpu;
>  	struct cpumask irq_affinity;
>  	struct kobject kobj;
> +	unsigned long vdpa_reconnect_vaddr;
>  };
>  
>  struct vduse_dev;
> @@ -1105,6 +1106,38 @@ static void vduse_vq_update_effective_cpu(struct vduse_virtqueue *vq)
>  
>  	vq->irq_effective_cpu = curr_cpu;
>  }
> +static int vduse_alloc_reconnnect_info_mem(struct vduse_dev *dev)
> +{
> +	unsigned long vaddr = 0;
> +	struct vduse_virtqueue *vq;
> +
> +	for (int i = 0; i < dev->vq_num; i++) {
> +		/*page 0~ vq_num save the reconnect info for vq*/
> +		vq = dev->vqs[i];
> +		vaddr = get_zeroed_page(GFP_KERNEL);


I don't get why you insist on stealing kernel memory for something
that is just used by userspace to store data for its own use.
Userspace does not lack ways to persist data, for example,
create a regular file anywhere in the filesystem.



> +		if (vaddr == 0)
> +			return -ENOMEM;
> +
> +		vq->vdpa_reconnect_vaddr = vaddr;
> +	}
> +
> +	return 0;
> +}
> +
> +static int vduse_free_reconnnect_info_mem(struct vduse_dev *dev)
> +{
> +	struct vduse_virtqueue *vq;
> +
> +	for (int i = 0; i < dev->vq_num; i++) {
> +		vq = dev->vqs[i];
> +
> +		if (vq->vdpa_reconnect_vaddr)
> +			free_page(vq->vdpa_reconnect_vaddr);
> +		vq->vdpa_reconnect_vaddr = 0;
> +	}
> +
> +	return 0;
> +}
>  
>  static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>  			    unsigned long arg)
> @@ -1672,6 +1705,8 @@ static int vduse_destroy_dev(char *name)
>  		mutex_unlock(&dev->lock);
>  		return -EBUSY;
>  	}
> +	vduse_free_reconnnect_info_mem(dev);
> +
>  	dev->connected = true;
>  	mutex_unlock(&dev->lock);
>  
> @@ -1855,12 +1890,17 @@ static int vduse_create_dev(struct vduse_dev_config *config,
>  	ret = vduse_dev_init_vqs(dev, config->vq_align, config->vq_num);
>  	if (ret)
>  		goto err_vqs;
> +	ret = vduse_alloc_reconnnect_info_mem(dev);
> +	if (ret < 0)
> +		goto err_mem;
>  
>  	__module_get(THIS_MODULE);
>  
>  	return 0;
>  err_vqs:
>  	device_destroy(&vduse_class, MKDEV(MAJOR(vduse_major), dev->minor));
> +err_mem:
> +	vduse_free_reconnnect_info_mem(dev);
>  err_dev:
>  	idr_remove(&vduse_idr, dev->minor);
>  err_idr:
> -- 
> 2.43.0

