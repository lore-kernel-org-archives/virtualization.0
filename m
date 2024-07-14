Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1247A17C67
	for <virtualization@lists.linux.dev>; Sun, 14 Jul 2024 07:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720943725; cv=none; b=r01gZMaepXqNcksIQMMp5JmHeL94xzTiqzvTYKvu2wFNr4VSg1nJCwPtFPcGnFtGydmzh3lnutRLCrWBuHeML0B8QkS9RasFoXGWFcY4WNVRmx89rmUyGsh1AAzuDl90ZDgjXzry8AiYdzh5WUHTI7UH9oMSatExRoN1CBbc3Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720943725; c=relaxed/simple;
	bh=OMlTr9QaESAJOCHWgMSlPjmHCJT/pbCFMTIIbvFKJPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KbP60ejxVdBBoagSV0Xm/Cr7j7taiLrO534r7UyzsMAr47ZhYZoBtwAiYYry6ih4PqXm8gajF5JovEfLDElBkkQLvdi54kD2QdejaQDH3mGJn2Glltfj4ntGXso7dJgMByGuPK9v/UyDfpaI0MuyFa8YQLd3SHc+xhNYBltE0oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U85ud71P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U85ud71P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720943721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tkDHOeFZqioiHhro0IXzgwYaZQ6z4MyVvkeZ7izLDr8=;
	b=U85ud71PGAE2k3BuvqdL46xIhLptUyYWT9z3W3Ps/L1NPZrVidPeb5g/dYnp5TQuzF/qWX
	6Uk3psy2YNwHnrEZCLFeIOhaAHzI7pTVR4TmPNtqU8vZWVbFjH0GEiHLKwgEuwz/91MgXA
	octVPYxBqI7n3iCJwCsyTgDA2/q0B9k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-M6UcvFxmOTuvflwnijMftA-1; Sun, 14 Jul 2024 03:55:19 -0400
X-MC-Unique: M6UcvFxmOTuvflwnijMftA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-36794ef4815so2079148f8f.1
        for <virtualization@lists.linux.dev>; Sun, 14 Jul 2024 00:55:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720943718; x=1721548518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkDHOeFZqioiHhro0IXzgwYaZQ6z4MyVvkeZ7izLDr8=;
        b=kydM54iZVQHEwNZhShvljPsxrNizkbtmSTzOR+T+R2Vo1AFUqztGE+5H/Vj+s9VPmQ
         Aa6WtVgo6oAHGBftpNNPbIxbPlB37PLg2Mk3gguqYs+1pSXzAVXPvJu+gAxwueNvgxF8
         PUNgePy5rSnoo/BueL5pwV7BYImOsnGJmi+Djm6RYcJ/w5f7/7BLnZCvJrEWqTgtpI1z
         va4Q49OTua6tVuVh64musin1baRlxQpAGU0ZnESSjI+sHge3iZ0jggRIeCZZX9/PNBIo
         UGo6ZFITjjo+HjFjs6unDW8TJGR+mF11C8JG1k8HvsScK2W8bofZIRDuSYWTdz+/4IVc
         U7tg==
X-Gm-Message-State: AOJu0Yzw3WsAfu6rdYtRqhXhudR7CfnrfklEM4FVXw89CATOA34U24/P
	X6MrXwVtH7bHAdBtxDZfphuoSQCIbQpWiQN6ZkuQRut7OctQDfJCjDz8dA9hvLwj02IqLViYNTs
	BkPl9rcitYP+NYzNvfNI628bSn/0wh+UCzPuG+wVIeM7nYIpf7IJAPqwzf+njHxFV
X-Received: by 2002:a5d:424c:0:b0:365:b695:ef76 with SMTP id ffacd0b85a97d-367cea966d1mr11221982f8f.36.1720943718347;
        Sun, 14 Jul 2024 00:55:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGd3fvNWKYjBYdpHUGTp126HupBj+hXZ3j0wCyqVJq52CYNG0UIClymyOf2UhuTZjUmGYQDkw==
X-Received: by 2002:a5d:424c:0:b0:365:b695:ef76 with SMTP id ffacd0b85a97d-367cea966d1mr11221975f8f.36.1720943716768;
        Sun, 14 Jul 2024 00:55:16 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:240:5146:27c:20a3:47d4:904])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dabef8csm3198321f8f.25.2024.07.14.00.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 00:55:16 -0700 (PDT)
Date: Sun, 14 Jul 2024 03:55:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, parav@nvidia.com,
	feliu@nvidia.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH virtio v2 10/13] virtio_pci_modern: create admin queue of
 queried size
Message-ID: <20240714035231-mutt-send-email-mst@kernel.org>
References: <20240710063601.2000149-1-jiri@resnulli.us>
 <20240710063601.2000149-11-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240710063601.2000149-11-jiri@resnulli.us>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 10, 2024 at 08:35:58AM +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Don't limit the admin queue size to VIRTIO_AVQ_SGS_MAX and rather rely
> on the queried queue size.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

I have some doubts about this one. Can't we limit the size to something
sensible? E.g. max number of CPUs? Number of VFs? I don't see why we
should just follow what device did blindly, the device has no idea about
use so would tend to over-provision.

> ---
>  drivers/virtio/virtio_pci_modern.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 5ceb4b2c18df..a649c9dc436d 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -550,8 +550,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>  	if (index >= vp_modern_get_num_queues(mdev) && !is_avq)
>  		return ERR_PTR(-EINVAL);
>  
> -	num = is_avq ?
> -		VIRTIO_AVQ_SGS_MAX : vp_modern_get_queue_size(mdev, index);
> +	num = vp_modern_get_queue_size(mdev, index);
>  	/* Check if queue is either not available or already active. */
>  	if (!num || vp_modern_get_queue_enable(mdev, index))
>  		return ERR_PTR(-ENOENT);
> -- 
> 2.45.2

