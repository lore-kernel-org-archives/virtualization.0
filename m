Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AC41E9917
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Feb 2025 21:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740433308; cv=none; b=P8BJA+EyPhUpXpPSpRrtGsqwcbd0z1aon2607HmyytWXgp+mcRzRMcHgDa+yBaii/YzR6tQC5TEuu8oxw8NWBPNeovc1/7WSx8EOCvSzArgJS6PbEtIuJU6RftNN7yNR0upKkrHhEF5VVW99nGz5OX6+1LV6LbtWVPKi1fUSK9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740433308; c=relaxed/simple;
	bh=61F3yXXy+T55QgXGolvQLQ63nKYT11qrytRHapc3erE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rZMSOw8oI5agu27h0Px4awI9X0c1el5OJyXoFdRtlLa5YkNVPcUnKFuy9mPXZfoX2WLZHgFZC4FhNVHMphELXpCtouWKWvs6jOBKF1Hue4w5TcGomrIexyT6tdEyStm3bMAw2cIyahUr27t7sW30A9bBU0SO5B+fcTusZW5jztY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KIWfffkL; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KIWfffkL"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B68B740550
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Feb 2025 21:41:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DpdScwAeECyL for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Feb 2025 21:41:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3180940438
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3180940438
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KIWfffkL
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3180940438
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Feb 2025 21:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740433303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L6HqPHsnfVa2C7Dq998EVFw1DlYFaKT132e9r5oyBLs=;
	b=KIWfffkLRlX3cSkYMqjY+kuf0m9bIw+s0A41OdqnKPIk3cDA03k5kPJuEpPDNF93LpGO7H
	60jxYggy9+MYk5pniwnQVb0lALJKmBV2cLB8lRposfL+ZbJCm5VTPS/CUUVtKbEV/tIs4z
	R6y/CgshHhI07nUK7SCthrIvIY6ni/U=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-1H1CX6G2Op6L36keEBGbsw-1; Mon, 24 Feb 2025 16:41:38 -0500
X-MC-Unique: 1H1CX6G2Op6L36keEBGbsw-1
X-Mimecast-MFC-AGG-ID: 1H1CX6G2Op6L36keEBGbsw_1740433298
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-abbaac605c3so475686366b.0
        for <virtualization@lists.linux-foundation.org>; Mon, 24 Feb 2025 13:41:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740433297; x=1741038097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6HqPHsnfVa2C7Dq998EVFw1DlYFaKT132e9r5oyBLs=;
        b=KvylV1U3Pzfu0hPLbtwzKkivdNJ/jkJZlAMAzKxnH5Ig/mkBvMzmeBwwJ5JieltLgI
         b/g2zfPmIkdmNCQtePWbj9VlXgNXQKKqNCBJuvXWH93Ipq+LAlqHZenw2jT70bIe/r2x
         2VoPU8uI4z73lVUZy/kmHkuZeuvbxW9FUblBThntIpEw5pRcSFgS78hVVRRGPyB9ILfr
         ErNHB0PN2xBqddr7/Oa8psBFktrcaa594iE39XYkU/cZCgklfHUOLsyOTU8zsvekOXJZ
         aE2ArjnoJBZ/5DYv/SdREG3/KqEBoMsSfyURgLpK2FLxw/nOOl1pUJCV+6Ya7VaEyQt6
         FVZA==
X-Forwarded-Encrypted: i=1; AJvYcCVuwqgieMv7oEfdIrGivYacuebe/FdBzAq59IGQt67l6isXqNV2tHvik8BlmpzHMtacH718pQQQyeEtEl9Xng==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yyel6RQq4AXizJUHBB2YygDqPmc3EsLSzmWEm7PuzpTUgeRXn8n
	vecYdOO2qKhbZeGy0nioJg6jC28aJ5tTP47GK61/arYLKcJGSrwnLpoAG2DU5VQX4Z5VCavzwEr
	RMx5dLPU/b38kC6fdHMKeDQcC1dBSaXMYeLIZeW/6AIWYFxR99/RRlffOk9g9HrXxGKcGEgx3Rk
	pASqk=
X-Gm-Gg: ASbGncv6XzKs7lYefxzh7yEb0Es0hk/5IG/DcIh+V6wIG293QbkJTho+84K7IgI/5P5
	vQykSuVYRnLS3RuX44cn4/taiqi3LacayWZVYj8jRks4YtFhoZV+lwSFDmmvhI/Ku4uBb+WiUh0
	xCLiUd8RVNaId7mnsY38pPgQCnm3hXoqT4wV9PW0NrAnitZLY0k7nv9PhHM5l1g/drZIzpfo+/k
	mYp6nO9Kkb2/QgA84Ak1QD442sJfLNrJ01D0OUm9gvB2xVLK3r05QxVsjImblRxxPlvLM/ii4rA
	lgQEPN/5iQ==
X-Received: by 2002:a17:907:7e93:b0:abb:6b1a:7b22 with SMTP id a640c23a62f3a-abc0da3b46fmr1564833666b.29.1740433297517;
        Mon, 24 Feb 2025 13:41:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFi78TPozmZYZWNhXigwkXxbfsfc+pSqjPGxh0riHc6R17GvlYa9/Usr+cmEeQtdzW8YiMJ5g==
X-Received: by 2002:a17:907:7e93:b0:abb:6b1a:7b22 with SMTP id a640c23a62f3a-abc0da3b46fmr1564830266b.29.1740433297089;
        Mon, 24 Feb 2025 13:41:37 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:441:1929:22c5:4595:d9bc:489e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed20b8194sm25573066b.176.2025.02.24.13.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 13:41:36 -0800 (PST)
Date: Mon, 24 Feb 2025 16:41:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v6 5/6] vhost: Add new UAPI to support change to task mode
Message-ID: <20250224164027-mutt-send-email-mst@kernel.org>
References: <20250223154042.556001-1-lulu@redhat.com>
 <20250223154042.556001-6-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250223154042.556001-6-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fSwtRhInrw5BfGWIH0qabiuosHcDUCmRSfYRXrVuV5Y_1740433298
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 23, 2025 at 11:36:20PM +0800, Cindy Lu wrote:
> Add a new UAPI to enable setting the vhost device to task mode.
> The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
> to configure the mode if necessary.
> This setting must be applied before VHOST_SET_OWNER, as the worker
> will be created in the VHOST_SET_OWNER function
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>


Thanks Cindy,

can we add a KConfig knob to disable legacy app support?

It can be handy for security.

Pls make it a patch on top.

> ---
>  drivers/vhost/vhost.c      | 24 ++++++++++++++++++++++--
>  include/uapi/linux/vhost.h | 18 ++++++++++++++++++
>  2 files changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index d8c0ea118bb1..45d8f5c5bca9 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1133,7 +1133,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_iotlb *umem)
>  	int i;
>  
>  	vhost_dev_cleanup(dev);
> -
> +	dev->inherit_owner = true;
>  	dev->umem = umem;
>  	/* We don't need VQ locks below since vhost_dev_cleanup makes sure
>  	 * VQs aren't running.
> @@ -2278,15 +2278,35 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
>  {
>  	struct eventfd_ctx *ctx;
>  	u64 p;
> -	long r;
> +	long r = 0;
>  	int i, fd;
> +	u8 inherit_owner;
>  
>  	/* If you are not the owner, you can become one */
>  	if (ioctl == VHOST_SET_OWNER) {
>  		r = vhost_dev_set_owner(d);
>  		goto done;
>  	}
> +	if (ioctl == VHOST_FORK_FROM_OWNER) {
> +		/*inherit_owner can only be modified before owner is set*/
> +		if (vhost_dev_has_owner(d)) {
> +			r = -EBUSY;
> +			goto done;
> +		}
> +		if (copy_from_user(&inherit_owner, argp, sizeof(u8))) {
> +			r = -EFAULT;
> +			goto done;
> +		}
> +		/* Validate the inherit_owner value, ensuring it is either 0 or 1 */
> +		if (inherit_owner > 1) {
> +			r = -EINVAL;
> +			goto done;
> +		}
> +
> +		d->inherit_owner = (bool)inherit_owner;
>  
> +		goto done;
> +	}
>  	/* You must be the owner to do anything else */
>  	r = vhost_dev_check_owner(d);
>  	if (r)
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index b95dd84eef2d..8f558b433536 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -235,4 +235,22 @@
>   */
>  #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
>  					      struct vhost_vring_state)
> +
> +/**
> + * VHOST_FORK_FROM_OWNER - Set the inherit_owner flag for the vhost device
> + *
> + * @param inherit_owner: An 8-bit value that determines the vhost thread mode
> + *
> + * When inherit_owner is set to 1:
> + *   - The VHOST worker threads inherit its values/checks from
> + *     the thread that owns the VHOST device, The vhost threads will
> + *     be counted in the nproc rlimits.
> + *
> + * When inherit_owner is set to 0:
> + *   - The VHOST worker threads will use the traditional kernel thread (kthread)
> + *     implementation, which may be preferred by older userspace applications that
> + *     do not utilize the newer vhost_task concept.
> + */
> +#define VHOST_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
> +
>  #endif
> -- 
> 2.45.0

