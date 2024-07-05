Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD3F142E76
	for <virtualization@lists.linux.dev>; Fri,  5 Jul 2024 11:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720179063; cv=none; b=jQP6nKzhDSozF38EX0TKan76sGKOBuN+XZsvvHfvTQOG0Ti/ZmF9UzT6rmw+Q/7/BqTOhhGEcoqB+B7mWuq/v3WIevfpPSLLdnbaiDuOvRds+TZaESfc2O+mKdrLVzviQeZIF4BVqVXaJAlD62+PtBWZZw8Ix1HVxHC0ptoPR1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720179063; c=relaxed/simple;
	bh=onBN9KO+lIzsFEQ/fDXx61eO24M3dMCZ/svot/VNlGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Wizsu9YSCgiZNtzrtq6yH7QrJoxkVr8fh3zasrGUcJVhkxRJV/U2AwJ1zjO/n/U7FxFjJuozgGdj35yuOpPRS6ima4k4X+bGQEBilPu9g/ll6hKrfH9N+B9Bs/ahcRKsBQTaosoj1S/fNoHf0mcMypwxmCWgkyhFJNHTQOAfh9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hr8g2iY7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hr8g2iY7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720179059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wSxPxNWjmfmCaCrv5YXNN9JRGPE4XS8LqrwWBh6MCYo=;
	b=hr8g2iY7+cifeqqGqf5cBceQJ3HE4Le8CxI6pBuwfJwVc4qHWCvWSL/QbBkUCJrLXFdOJG
	wn+D39kLDeU68sx/wL9wJ6Nc/lp4c6/5Fbr0PFcpsLyx+H491LAi07JAJjjwcNYTwQFdob
	C1yw3JL+nC13yPofEfGdSucXXUNN6ms=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-v05Ge49uMwCmgWYyKLlIUQ-1; Fri, 05 Jul 2024 07:30:58 -0400
X-MC-Unique: v05Ge49uMwCmgWYyKLlIUQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4257f95fe85so12066745e9.1
        for <virtualization@lists.linux.dev>; Fri, 05 Jul 2024 04:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720179057; x=1720783857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSxPxNWjmfmCaCrv5YXNN9JRGPE4XS8LqrwWBh6MCYo=;
        b=j2aP4XVt2EJdS+bXYzIsv0TGmLuNy6pDwYk0aVqL13t2l18KoswzbBlVi2wmUbTWx4
         fa0ir6g00ishIswNEk7a5mCjtCHVzWJXjAG5T1wxMk/g1bU10gNooa1JlH4qj9lSMF1c
         wjQH51W92IwZmydy08wURBgRIyIvgEb18/tTp/GRpGgU9nlpZAv3fXyb/9lJOUo2sUa8
         WuFwpW19+8ZLJ25VQEAYhbRZg1EMNW/r4dofPJf0OMHJuVWAFT4Lxr/k6dtCzo//072e
         CbthM7OzWiF3+VpKHUsWhW+D4Gbk7BnTGn8LH3saq9md8x0JV0a8S+Id+ds2/SXiDriV
         h6HA==
X-Gm-Message-State: AOJu0YyUJ5/fzMykjhVysLaYxIovtTY0Jt0zcHwhC4voxhP6PuJfz/Wh
	LwIfYvADWXZyKb8dxb9isC3FXgG2MmO5nfDalbATLq/BqB5n6mBMu+RSFCX4LeUCBbv4QBExlmh
	PQqSzbTaQgVWBVmeTg022SDSAKpW3x931Rz2A3lYPqV3xh1M9PkmLjM/k1jdx2dLo
X-Received: by 2002:adf:a1cf:0:b0:367:97fd:1d75 with SMTP id ffacd0b85a97d-3679dd441e5mr3036739f8f.27.1720179056798;
        Fri, 05 Jul 2024 04:30:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYIskuxCgnnQ5o9Ei3vPbmfJwvs58n/dENLo/BzbYNqk6AfWrjE+2qFmWCJOxsQfv7sAPixA==
X-Received: by 2002:adf:a1cf:0:b0:367:97fd:1d75 with SMTP id ffacd0b85a97d-3679dd441e5mr3036708f8f.27.1720179056067;
        Fri, 05 Jul 2024 04:30:56 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:1b5b:ac5c:b82e:a18c:2c6e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36788e37b53sm9113952f8f.45.2024.07.05.04.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 04:30:55 -0700 (PDT)
Date: Fri, 5 Jul 2024 07:30:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH] vdpa_sim_blk: add `capacity` module parameter
Message-ID: <20240705073017-mutt-send-email-mst@kernel.org>
References: <20240705112821.144819-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240705112821.144819-1-sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 05, 2024 at 01:28:21PM +0200, Stefano Garzarella wrote:
> The vDPA block simulator always allocated a 128 MiB ram-disk, but some
> filesystems (e.g. XFS) may require larger minimum sizes (see
> https://issues.redhat.com/browse/RHEL-45951).
> 
> So to allow us to test these filesystems, let's add a module parameter
> to control the size of the simulated virtio-blk devices.
> The value is mapped directly to the `capacity` field of the virtio-blk
> configuration space, so it must be expressed in sector numbers of 512
> bytes.
> 
> The default value (0x40000) is the same as the previous value, so the
> behavior without setting `capacity` remains unchanged.
> 
> Before this patch or with this patch without setting `capacity`:
>   $ modprobe vdpa-sim-blk
>   $ vdpa dev add mgmtdev vdpasim_blk name blk0
>   virtio_blk virtio6: 1/0/0 default/read/poll queues
>   virtio_blk virtio6: [vdb] 262144 512-byte logical blocks (134 MB/128 MiB)
> 
> After this patch:
>   $ modprobe vdpa-sim-blk capacity=614400
>   $ vdpa dev add mgmtdev vdpasim_blk name blk0
>   virtio_blk virtio6: 1/0/0 default/read/poll queues
>   virtio_blk virtio6: [vdb] 614400 512-byte logical blocks (315 MB/300 MiB)
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

What a hack. Cindy was working on adding control over config
space, why can't that be used?

> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> index b137f3679343..18f390149836 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> @@ -33,7 +33,6 @@
>  				 (1ULL << VIRTIO_BLK_F_DISCARD)  | \
>  				 (1ULL << VIRTIO_BLK_F_WRITE_ZEROES))
>  
> -#define VDPASIM_BLK_CAPACITY	0x40000
>  #define VDPASIM_BLK_SIZE_MAX	0x1000
>  #define VDPASIM_BLK_SEG_MAX	32
>  #define VDPASIM_BLK_DWZ_MAX_SECTORS UINT_MAX
> @@ -43,6 +42,10 @@
>  #define VDPASIM_BLK_AS_NUM	1
>  #define VDPASIM_BLK_GROUP_NUM	1
>  
> +static unsigned long capacity = 0x40000;
> +module_param(capacity, ulong, 0444);
> +MODULE_PARM_DESC(capacity, "virtio-blk device capacity (in 512-byte sectors)");
> +
>  struct vdpasim_blk {
>  	struct vdpasim vdpasim;
>  	void *buffer;
> @@ -79,10 +82,10 @@ static void vdpasim_blk_buffer_unlock(struct vdpasim_blk *blk)
>  static bool vdpasim_blk_check_range(struct vdpasim *vdpasim, u64 start_sector,
>  				    u64 num_sectors, u64 max_sectors)
>  {
> -	if (start_sector > VDPASIM_BLK_CAPACITY) {
> +	if (start_sector > capacity) {
>  		dev_dbg(&vdpasim->vdpa.dev,
> -			"starting sector exceeds the capacity - start: 0x%llx capacity: 0x%x\n",
> -			start_sector, VDPASIM_BLK_CAPACITY);
> +			"starting sector exceeds the capacity - start: 0x%llx capacity: 0x%lx\n",
> +			start_sector, capacity);
>  	}
>  
>  	if (num_sectors > max_sectors) {
> @@ -92,10 +95,10 @@ static bool vdpasim_blk_check_range(struct vdpasim *vdpasim, u64 start_sector,
>  		return false;
>  	}
>  
> -	if (num_sectors > VDPASIM_BLK_CAPACITY - start_sector) {
> +	if (num_sectors > capacity - start_sector) {
>  		dev_dbg(&vdpasim->vdpa.dev,
> -			"request exceeds the capacity - start: 0x%llx num: 0x%llx capacity: 0x%x\n",
> -			start_sector, num_sectors, VDPASIM_BLK_CAPACITY);
> +			"request exceeds the capacity - start: 0x%llx num: 0x%llx capacity: 0x%lx\n",
> +			start_sector, num_sectors, capacity);
>  		return false;
>  	}
>  
> @@ -369,7 +372,7 @@ static void vdpasim_blk_get_config(struct vdpasim *vdpasim, void *config)
>  
>  	memset(config, 0, sizeof(struct virtio_blk_config));
>  
> -	blk_config->capacity = cpu_to_vdpasim64(vdpasim, VDPASIM_BLK_CAPACITY);
> +	blk_config->capacity = cpu_to_vdpasim64(vdpasim, capacity);
>  	blk_config->size_max = cpu_to_vdpasim32(vdpasim, VDPASIM_BLK_SIZE_MAX);
>  	blk_config->seg_max = cpu_to_vdpasim32(vdpasim, VDPASIM_BLK_SEG_MAX);
>  	blk_config->num_queues = cpu_to_vdpasim16(vdpasim, VDPASIM_BLK_VQ_NUM);
> @@ -437,8 +440,7 @@ static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>  	if (blk->shared_backend) {
>  		blk->buffer = shared_buffer;
>  	} else {
> -		blk->buffer = kvzalloc(VDPASIM_BLK_CAPACITY << SECTOR_SHIFT,
> -				       GFP_KERNEL);
> +		blk->buffer = kvzalloc(capacity << SECTOR_SHIFT, GFP_KERNEL);
>  		if (!blk->buffer) {
>  			ret = -ENOMEM;
>  			goto put_dev;
> @@ -495,8 +497,7 @@ static int __init vdpasim_blk_init(void)
>  		goto parent_err;
>  
>  	if (shared_backend) {
> -		shared_buffer = kvzalloc(VDPASIM_BLK_CAPACITY << SECTOR_SHIFT,
> -					 GFP_KERNEL);
> +		shared_buffer = kvzalloc(capacity << SECTOR_SHIFT, GFP_KERNEL);
>  		if (!shared_buffer) {
>  			ret = -ENOMEM;
>  			goto mgmt_dev_err;
> -- 
> 2.45.2

