Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C5933F5A3
	for <virtualization@lists.linux.dev>; Mon,  3 Aug 2026 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785772761; cv=none; b=h5Ia3D1O/KtcYb2YxDEEwAe3V/Er+MPZSDL7oYx0xnnf1/Aj/Q8CpxPOrdXJX9uB+819NE+1qm4ZwwLVzG9Gs/MJYwoeGXnXnDJR2T2a1UjpPPObOMkBcQcpPCkxZwXMseIO8oC1v55AvX8Mdbp3hHKVhWt+kFSH3mKGGG/8uVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785772761; c=relaxed/simple;
	bh=HKQ49Q+y0fHa0axoY1Gzw3algxTgziFVoosMR2RzR94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XnhKfzhNU9cLgNEGSGrPhgSTi1ECUdm/LjD68Y4c9QLNY11u0ffVGr82pz4dGPjBWFodMKhOEXH/QB27hFmYXCEBsp28TCpsQvN07tCIxDH7dEoLIslrXaOpdApR6xotlg4YhkCLtNBhXX9mADUUwvUjxKYlbAfwtShuacGXGOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=avBiExNp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="avBiExNp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785772759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qcr8lbIWdqcfVMMmUoW0rBUoTTmgc4FAMwlbi4adWtY=;
	b=avBiExNpv6LtKL9ag5swvPMsMZ/UpCwzyLaNFyqkm5WBL6/9+BjFsqv3bA4Ig8D4Y+yJ+v
	8hLJohmXmcU/EYHaNWO9G0KLDNExezzVDhllXyLvSPVyrotruSgcocUa5261biuo31h0IN
	JUC3toICGlhh355juCSnfIOhxQ/kbHo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-711-UI2vkSfqN3GuvpahILW5kg-1; Mon, 03 Aug 2026 11:59:18 -0400
X-MC-Unique: UI2vkSfqN3GuvpahILW5kg-1
X-Mimecast-MFC-AGG-ID: UI2vkSfqN3GuvpahILW5kg_1785772757
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f810c8aebso2188527f8f.2
        for <virtualization@lists.linux.dev>; Mon, 03 Aug 2026 08:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785772757; x=1786377557;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qcr8lbIWdqcfVMMmUoW0rBUoTTmgc4FAMwlbi4adWtY=;
        b=G7MRQu+6dXlp+tMJqGdDwdr+3GW3Uc0y1tjl7KqtMBtxTSol7tKz4CuqtsPGzqKZ9Q
         0D0Did1VVjYy45JlTL9FvBXBs+ss0XyxKgCLXKLTwwFI/mSNkFL1tt1i3xigGyqbWG8U
         j6IaMg+WAjheYH8cB1qvGkRE243hRbizNWNAR3Y3S/t7znKdfMLRsrlF5CvdmQNDQdxL
         VDA5KdV1QxutwwAlbpCW0PwA3q5q8Qoc6Gmywpqr3aBEuX7bA3d1xREHvYhETqmPcoUy
         SUFIUO+HO2iU/JAgqwO5YbX7r7nd98PyX/YYH2pECPvYgUsFYwa1RxWZkTP4zqgyChI9
         VB4Q==
X-Forwarded-Encrypted: i=1; AHgh+RpgarQ9yF8+KZa+iRCDHmpZz71qUWOgh2/5ytO2EDHM7PWDAR5rUtgffnAyY6UHFlqwlhpqGvjAZcBjANgkmA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwgT/2/NDXptTAI/b7u/qI/Imb4M2Pz58+0LFlJLp3MRqbku9CP
	15fjX2mU191/e1vFJ7nYqidUv3e+0ov8HrHOYq2jJ6op3YJHPK9yPXWoF4JEF7C8BkEwqv5tjAa
	l9d0XedWcv2MSksflb90LVY8WyOMChVqLCEauLYHV6KkbJryPzzStmBti9VPvXewR74ni
X-Gm-Gg: AR+sD13gVNFy0UIdF/ZNnkAiQV3tGQfoYwnCQ9AuBQiaNWgg3nQBMBzPHFxVFIEX9tF
	+HZdap12f5Ka3OzBwGUSWlLHW8MvUd0L61ZerQA7bSe5k2ZECmeTnNLIaGobhCGR586hBex5T1o
	83Tu0HQaynhmHubXNpPl51/4M7srPZL9uYPXpROntn7FxMLUknVAMZRxWkeWB8te517y7KpfCw7
	l80Ehgla2sDS8Hv1jBnSbvmia+kBHxS4zO3cMYeSmj3Zt6QqJm7efj2lbJs2gVNNIZT8dU6A8AS
	/BOkTN5NnUn+sUj+/zxcYxMJGD0QJsaE+zYzQbCia0nBGMRRt3+MWoxtolVDDEFnAWO1U/mHh9Q
	NT/WDLNlfuPmrafBJ68cunQ==
X-Received: by 2002:a05:6000:4615:b0:47f:918b:fa07 with SMTP id ffacd0b85a97d-47fd72d4500mr29228313f8f.22.1785772756843;
        Mon, 03 Aug 2026 08:59:16 -0700 (PDT)
X-Received: by 2002:a05:6000:4615:b0:47f:918b:fa07 with SMTP id ffacd0b85a97d-47fd72d4500mr29228215f8f.22.1785772756323;
        Mon, 03 Aug 2026 08:59:16 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41d0064sm33017363f8f.5.2026.08.03.08.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 08:59:15 -0700 (PDT)
Date: Mon, 3 Aug 2026 11:59:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shahar Shitrit <shshitrit@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com, yohadt@nvidia.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgg@ziepe.ca,
	kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
	edumazet@google.com, danielj@nvidia.com
Subject: Re: [PATCH net-next v21 01/13] virtio_pci: Remove supported_cap size
 build assert
Message-ID: <20260803115219-mutt-send-email-mst@kernel.org>
References: <20260803140721.1871678-1-shshitrit@nvidia.com>
 <20260803140721.1871678-2-shshitrit@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260803140721.1871678-2-shshitrit@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HP1gkfacY8oLfOzRdUiP-2NfNzBydD08TDmfFCTYD3E_1785772757
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

patch is ok. commit log isnt:


supported_cap is not a thing.

better subj:

 remove supported_caps cache and build assert


On Mon, Aug 03, 2026 at 05:07:09PM +0300, Shahar Shitrit wrote:
> From: Daniel Jurgens <danielj@nvidia.com>
> 
> The cap ID list can be more than 64 bits.

what does "can be" mean? I think what u mean
following patches make ....

> Remove the build assert.


> Also
> remove caching of the supported caps, it wasn't used.

it's not "also". in fact we remove supported_caps and then
the rest of the code handles data->supported_caps of any
size, transparently.


> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
> ---
>  drivers/virtio/virtio_pci_common.h |  1 -
>  drivers/virtio/virtio_pci_modern.c | 10 +++-------
>  2 files changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> index 8cd01de27baf..fc26e035e7a6 100644
> --- a/drivers/virtio/virtio_pci_common.h
> +++ b/drivers/virtio/virtio_pci_common.h
> @@ -48,7 +48,6 @@ struct virtio_pci_admin_vq {
>  	/* Protects virtqueue access. */
>  	spinlock_t lock;
>  	u64 supported_cmds;
> -	u64 supported_caps;
>  	u8 max_dev_parts_objects;
>  	struct ida dev_parts_ida;
>  	/* Name of the admin queue: avq.$vq_index. */
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 6d8ae2a6a8ca..ef4a64eb9982 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -304,10 +304,10 @@ virtio_pci_admin_cmd_dev_parts_objects_enable(struct virtio_device *virtio_dev)
>  
>  static void virtio_pci_admin_cmd_cap_init(struct virtio_device *virtio_dev)
>  {
> -	struct virtio_pci_device *vp_dev = to_vp_device(virtio_dev);
>  	struct virtio_admin_cmd_query_cap_id_result *data;
>  	struct virtio_admin_cmd cmd = {};
>  	struct scatterlist result_sg;
> +	u64 caps;
>  	int ret;
>  
>  	data = kzalloc_obj(*data);
> @@ -323,12 +323,8 @@ static void virtio_pci_admin_cmd_cap_init(struct virtio_device *virtio_dev)
>  	if (ret)
>  		goto end;
>  
> -	/* Max number of caps fits into a single u64 */
> -	BUILD_BUG_ON(sizeof(data->supported_caps) > sizeof(u64));
> -
> -	vp_dev->admin_vq.supported_caps = le64_to_cpu(data->supported_caps[0]);
> -
> -	if (!(vp_dev->admin_vq.supported_caps & (1 << VIRTIO_DEV_PARTS_CAP)))
> +	caps = le64_to_cpu(data->supported_caps[0]);
> +	if (!(caps & BIT_ULL(VIRTIO_DEV_PARTS_CAP)))
>  		goto end;
>  
>  	virtio_pci_admin_cmd_dev_parts_objects_enable(virtio_dev);
> -- 
> 2.49.0

