Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B00345CA1
	for <virtualization@lists.linux.dev>; Mon,  3 Aug 2026 16:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773268; cv=none; b=HPuyO1geyc0T1OfLbmO4l1XaVID3ERmG+ZHAl6AQ6pJTKjWRD9Rbv2ws1gP3OmXEFCcDU+LhrIBPoJz/x4RiT/VkxwFuWiisHKziTq5Ld9E9VDjM389ffEry/W02dhgr46tcecs6jgYio9AZCffUWLtCgh6vvWJweOMX0I2pYks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773268; c=relaxed/simple;
	bh=ZseRgTJAwo05O2DD2YkpqFiqUIpZMU7SmGFGHXFSi3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LZrr5Sdz7QcZ9LnfwSHd5Krufs3dK3k3stnKxNmLMeZFjCLyi7bJ+5uIROLBnn4EUHEfiSxFMxzkeUCChz6L8rBS+02ShqTuGV2K7976oJv+X5RPCBBCwSXXujt7qRD24dtS+wh+OdDuBG2OjRbbUnQOlRVwgvPPa+g1jgD/Yg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mdoj+P6X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mdoj+P6X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785773266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KF1qmdEimkgXxg6otcgk7H45mi45bXhYYW4FiUYh4Uc=;
	b=Mdoj+P6X+mGOFw5AlOxLvhb95ZwUj/ZHD3QYuJZXkV8FtmB11t+Gayb05GdWc5zG+awKNd
	DaoF831UrPu+E6ZqJroA3YVvDf5RR8sMN1/KqQQ+DM2Oh+/LmiZYGIZL7m8BRrgEEScVBi
	NJAO5rPqUALHjfr4y2YCPmp2sYaP3so=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-ax8TydobNpqr_WHtS3BO0A-1; Mon, 03 Aug 2026 12:07:44 -0400
X-MC-Unique: ax8TydobNpqr_WHtS3BO0A-1
X-Mimecast-MFC-AGG-ID: ax8TydobNpqr_WHtS3BO0A_1785773264
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-474170b59dfso2124230f8f.3
        for <virtualization@lists.linux.dev>; Mon, 03 Aug 2026 09:07:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785773263; x=1786378063;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KF1qmdEimkgXxg6otcgk7H45mi45bXhYYW4FiUYh4Uc=;
        b=Qe28qkvRju8YMe3NXtd2LI1ojAB54BlOjDtDpIfoZlagn93ai/YKjOAC3zwhDoC8aI
         rxWNlb/wkA/yvoUfsRzYu1hhKQ0Hmu0e53BbYpwe6CKNDjMWu7zmH26GnC0l68SWAoga
         wmemsJZhWwsmdpbXou7o26M7/D4zBmkM3MEBmmIQh/OXyplp7gdK60kVNIVdrElbmG4B
         2NzkS6crgc7fQqG/tDJIIebLSDqENJ8tZv/fPRa0P8CUqxnEdCHHnv00uOpL9AUkK/Ug
         lXhnccd6Pacsl0LqLNzamSQycmgoWdd1KxWm58FcyXCEoyFYrg8LBl4xsBhD2PL4K79z
         bkHw==
X-Forwarded-Encrypted: i=1; AHgh+RqN3dZD923q0R3Ilg4JNjbBF7KLnC1i+Yr/NCpkWXs/tUVQOUFxIW5aOeHPyTzoo/kaNnaq86Wt+JnYhbO/Iw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywt7fhBGjl1JJzXBD9ZFyxO19hdkuoUVx5UVB2tpue3XNn8dJVf
	WZKHUYU5WTDfztkHEacoXvPoPAvVs4Fpp6phzdRYlE0zmuPySgcIS8s4YuyAWbvEfnHFweB3AYo
	XpjwsCt/FM+DC+/ABVVp1H83I2qJlgyjQRnCtNYDYRAZjJ56YzILeyV3TX6CbfZGnABbc
X-Gm-Gg: AR+sD12XwcvWQZye7WFQDxxDXkl0mNoznTSYLpnu76o1ZPneMNaw/HNFO0NVvr8EjTQ
	2yuDQUDxTh2fuBAi6IxPo2D7c0DSWQx33vBwgvWl1SchnCiUZYSt3ew+EAzUGpj2aGMgtDR3rAV
	ITAm9WegDawxrdZzj5OalISqXFfrHwUBZf34yTl8DRo7rA3gfU/n8uSvPkUXXvDPHlJB9u1zPG0
	tsxa4QH4na6LRqMBU+BnBEvUUhivG0xyacb11BNPLEf8Hro3tAjp/aOTvAk+dVsywkEjqpbt8dd
	ACzsUVfHjIeTzv740kuKwtoNQtGJzyNLZU7hZ8LvlyXyAym3uHSzTx1bhWgWPAR2mmCME0lu2uy
	PmS9qf5Trk9Fw0XQUIhimUg==
X-Received: by 2002:adf:fd10:0:b0:46e:c978:7ddc with SMTP id ffacd0b85a97d-47fd72bf1ddmr20522217f8f.24.1785773263388;
        Mon, 03 Aug 2026 09:07:43 -0700 (PDT)
X-Received: by 2002:adf:fd10:0:b0:46e:c978:7ddc with SMTP id ffacd0b85a97d-47fd72bf1ddmr20522117f8f.24.1785773262795;
        Mon, 03 Aug 2026 09:07:42 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd458bb4esm33075414f8f.30.2026.08.03.09.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 09:07:42 -0700 (PDT)
Date: Mon, 3 Aug 2026 12:07:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shahar Shitrit <shshitrit@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com, yohadt@nvidia.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgg@ziepe.ca,
	kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
	edumazet@google.com, danielj@nvidia.com
Subject: Re: [PATCH net-next v21 02/13] virtio: Add config_op for admin
 commands
Message-ID: <20260803120238-mutt-send-email-mst@kernel.org>
References: <20260803140721.1871678-1-shshitrit@nvidia.com>
 <20260803140721.1871678-3-shshitrit@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260803140721.1871678-3-shshitrit@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: K--0DoInoH6MCBWTYY_mu1-F01n8VDFjKB6G_Xe4xrI_1785773264
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 03, 2026 at 05:07:10PM +0300, Shahar Shitrit wrote:
> From: Daniel Jurgens <danielj@nvidia.com>
> 
> This will allow device drivers to issue administration commands.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
> ---
>  drivers/virtio/virtio_pci_modern.c | 2 ++
>  include/linux/virtio_config.h      | 6 ++++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index ef4a64eb9982..a18683761aa5 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -1238,6 +1238,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
>  	.get_shm_region  = vp_get_shm_region,
>  	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
>  	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
> +	.admin_cmd_exec = vp_modern_admin_cmd_exec,
>  };
>  
>  static const struct virtio_config_ops virtio_pci_config_ops = {
> @@ -1258,6 +1259,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
>  	.get_shm_region  = vp_get_shm_region,
>  	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
>  	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
> +	.admin_cmd_exec = vp_modern_admin_cmd_exec,
>  };
>  
>  /* the PCI probing function */


So the issue here is that vp_modern_admin_cmd_exec has been
broken for a while:


        spin_lock_irqsave(&admin_vq->lock, flags);
        ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);



which is pre-existing but now that this is going to be triggered by userspace,
we need to fix this.

I guess admin vq lock must be a mutex and complete through a wq?

> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 69f84ea85d71..e36a32e0a20c 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -108,6 +108,10 @@ struct virtqueue_info {
>   *	Returns 0 on success or error status
>   *	If disable_vq_and_reset is set, then enable_vq_after_reset must also be
>   *	set.
> + * @admin_cmd_exec: Execute an admin VQ command (optional).
> + *	vdev: the virtio_device
> + *	cmd: the command to execute
> + *	Returns 0 on success or error status
>   */
>  struct virtio_config_ops {
>  	void (*get)(struct virtio_device *vdev, unsigned offset,
> @@ -137,6 +141,8 @@ struct virtio_config_ops {
>  			       struct virtio_shm_region *region, u8 id);
>  	int (*disable_vq_and_reset)(struct virtqueue *vq);
>  	int (*enable_vq_after_reset)(struct virtqueue *vq);
> +	int (*admin_cmd_exec)(struct virtio_device *vdev,
> +			      struct virtio_admin_cmd *cmd);
>  };
>  
>  /**
> -- 
> 2.49.0

