Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ED31F4177
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Feb 2025 21:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740433580; cv=none; b=G/XK6SvRCju4JAaLTVlS9axvCEUaJvHm99BeApXbAo9wbplphTwN9NZFcA0WTcSYKovOz5pA63S9ZAiKXh6BkaBY3a6hWYPIwNRnj51xH/PGHx4huI0zCrSEtXXa99Jl0ZOkPDcH6bM7aWkR2MBFbFxJiH19egCIG/qPQ9Di2ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740433580; c=relaxed/simple;
	bh=e+kYByMXNeDUALN2Jm62hIYRxASWL87Qinb3VWV2j40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qsu0X/bjUAASzWbIIj/bJ//FqcUIoZT2Hzzc+MCRbpJdJwdsK/EQRy2PJxC9rEkoakyEaqke+QOkN5GjBSSQp2/4FS1VE1pbyfTNvlwf03jWu/MwRBS6hjbtGWHXuqKs47cUYQDyPWbaIrzys65aGRqlF3988v5q4sNCc9zMcNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aqYDb6MN; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aqYDb6MN"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2B33740550
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Feb 2025 21:46:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RG9pzowQJ0Nj for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Feb 2025 21:46:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 17E1240438
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 17E1240438
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aqYDb6MN
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 17E1240438
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Feb 2025 21:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740433576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/djJ+PtX4FDl6jsu51ShmCbl9JrXbgv9LkcxGG2wMj8=;
	b=aqYDb6MNHv3S4ftXyk6oZq+MAy59cfTlndB+MKuR/LUExJeXWBdo/1ub4R2oN7VJB84uzJ
	geN8SWpRLY4/+UZr2B9gCwCAVwOTYkZxx2rEXZ0NLTYKufXup88UaKOJP8qms7OoEauPXU
	so1MhW/dl17SdX6yeSndXf9VCwzBWKU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-GXCwEc_SOcG8rV7JyC8AVw-1; Mon, 24 Feb 2025 16:46:14 -0500
X-MC-Unique: GXCwEc_SOcG8rV7JyC8AVw-1
X-Mimecast-MFC-AGG-ID: GXCwEc_SOcG8rV7JyC8AVw_1740433573
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-abb7e837a7aso385032766b.3
        for <virtualization@lists.linux-foundation.org>; Mon, 24 Feb 2025 13:46:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740433573; x=1741038373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/djJ+PtX4FDl6jsu51ShmCbl9JrXbgv9LkcxGG2wMj8=;
        b=Db5FCqNM1FNXOJ9oouilAbx+JEDwFhgL5qPnj5A3glP9lP+Sku5QOQ5+nDewjUh2E1
         uI+CBOO8/C0FutiJPykd/qVk90dpMIRcTvWa/ji5U5M357D6i8S9WJmhAcYJM2TryWHq
         ROITXOVzdoINKnDoQPiU8mmzLVLM+YPEkVKR7iQRXxmzAf5AH+NPRgQX1+++CdH16txB
         kjjkIKBgq4vuQwJCz5GVvhaB7bcOsVbWJHxjgepr7V9tpwq4evSQd92al6CMhVrGvyoS
         XjS5AMtycCpik8prMKb9hceIyp9VnChDkKQjTfKlpxJyBjE59RE+e9m+oc+ZxB3hkccC
         JdnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyk1ZRKhOSdBgD5vwZlpbYe1rRGK1iGInpRl2Nwp6dhLrpezZDhYiXh77Ri/vdi/RgwE+Twmxu1+OvpZ5D1g==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxgDW6GZu937+y1TJD273mcueTEXUovtcmVdM67IZM6H+N57w75
	fmC3YbdcOOeqJVm72PIUZunkgYLYxfjUZHbG9AD5NrAmT30PUBQk90U+R/GFJQbxEHaQDo5oxRQ
	bTdJFopJR/DdNRo6teyzhILo3Z6v6E4tUNfzaQh4vbrUlMvq7xSlIl9HI2+eKjust26ACsA7ps6
	CVCN8ZyGTWT9c=
X-Gm-Gg: ASbGnct6SExrgwwFFg6JQaFL2oubNcu/wuGKybfTlVitYFuEGkL5ehwv8bG857F6QHq
	k1cIcFOEzwu7J4pfnHdVa793S4vZFVry6/tJvtJcl0lhZoYhlgx2nRKSgjweXEXxgCbqRfy2513
	OFom7jHgSspJxrJlaD9aV4Sg3jLULfJNGm1qt9U+PvRSrp9zcJDJ87ErBO+OHQJJPol4gev9fHl
	jzkhdAX8qmryuuEwHEntVJxj+tbyMrtD9x0cgArzg2/75fPiD4NJ0YZqSAJVRB/fY3NUkSEwVdb
	R6nEoB7TBg==
X-Received: by 2002:a17:906:399b:b0:abe:cb87:9599 with SMTP id a640c23a62f3a-abecb8796b2mr187044066b.44.1740433572897;
        Mon, 24 Feb 2025 13:46:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7OyvLnm+e7goejV5zHakF8+COjfdjxx8Ny74h+t1TgYk1yctpE21hRJ1pnICAkf/LM9wawg==
X-Received: by 2002:a17:906:399b:b0:abe:cb87:9599 with SMTP id a640c23a62f3a-abecb8796b2mr187042466b.44.1740433572546;
        Mon, 24 Feb 2025 13:46:12 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:441:1929:22c5:4595:d9bc:489e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1cd4c23sm28274366b.11.2025.02.24.13.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 13:46:11 -0800 (PST)
Date: Mon, 24 Feb 2025 16:46:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v6 5/6] vhost: Add new UAPI to support change to task mode
Message-ID: <20250224164312-mutt-send-email-mst@kernel.org>
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
X-Mimecast-MFC-PROC-ID: 1iaElc9OiWZF-e88G-L2KmazvZt4CMMnhrcmDoevRDE_1740433573
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

better subject:

vhost: uapi to control task mode (owner vs kthread)


On Sun, Feb 23, 2025 at 11:36:20PM +0800, Cindy Lu wrote:
> Add a new UAPI to enable setting the vhost device to task mode.

better:

Add a new UAPI to configure the vhost device to use the kthread mode


> The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
> to configure the mode

... to either owner or kthread.


> if necessary.
> This setting must be applied before VHOST_SET_OWNER, as the worker
> will be created in the VHOST_SET_OWNER function
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
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

