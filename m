Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B2A13790B
	for <virtualization@lists.linux-foundation.org>; Sun,  1 Jun 2025 10:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748774961; cv=none; b=dHgkALyejcj485VJime3P1iJkKtNPcX6Y4cJDrzhpJM9jMMvKNPlwAkeQ8fnbdnNBNdrQznLcjVlReMVuMm0r5DDNxvbv5tPgQRq5J7OXcqKQ1M9+D1PdfHOeGQQzhidFSW9Rm2xSiVLfciH1NOdt1X5u/2eKKikPmynn9Gfklc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748774961; c=relaxed/simple;
	bh=kBLKF1AdFh/RK7a1OTYX+QEN6rDtO9n4uA58wanc4Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=V69OmIxMlnl4jNxslQanKNmB1QGWz3RI9NkwEaiHh+xMsYoj2J97i5IMUrfG4X60euK5Z6rSjpwhP0EFsoSUrfTfA/IlXwbNqjh4KtFzMyszXpABlZRoMTMAzeCx42Ky70Bwuf9kxO53c8ILoTn8rVK1dauDP7B9PHmXxJFgiIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ItrkDrDY; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ItrkDrDY"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ABE0481E40
	for <virtualization@lists.linux-foundation.org>; Sun,  1 Jun 2025 10:49:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n9v8Y6aD_gEu for <virtualization@lists.linux-foundation.org>;
 Sun,  1 Jun 2025 10:49:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E31DC81E3E
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E31DC81E3E
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ItrkDrDY
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E31DC81E3E
	for <virtualization@lists.linux-foundation.org>; Sun,  1 Jun 2025 10:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748774956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BfBKjlttcg3nh+GmuVdjWfmJaLtSoWbkOCvRrt0qU0s=;
	b=ItrkDrDYDmR1lUcju1T0ZoEwDHC0JsiPPlHo1Pk1MHcoif2uwY3xHWhbgXdgmEG+NJRp59
	0j9KKcRamqkwFNATUJE1e3UhHKagwr7h+u5W/nH1tBEoPDbr78Uo+iPwwfaBgAe0jAi+J1
	d+SyASu5M5vtEZeY4orJmym1ZQKqzUU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-iS_rJzzxMbmfuWRleHhc3g-1; Sun, 01 Jun 2025 06:49:15 -0400
X-MC-Unique: iS_rJzzxMbmfuWRleHhc3g-1
X-Mimecast-MFC-AGG-ID: iS_rJzzxMbmfuWRleHhc3g_1748774955
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4f65a705dso2140880f8f.2
        for <virtualization@lists.linux-foundation.org>; Sun, 01 Jun 2025 03:49:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748774954; x=1749379754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfBKjlttcg3nh+GmuVdjWfmJaLtSoWbkOCvRrt0qU0s=;
        b=MaboLC86mK2lZpiyTN9+E71GAX9subrHrdcAr+hAW1ez7yqT+xFXcpaTSnNQCE05I3
         penwUqWJkZetZr5ka4GDELV8K6SmjH1hFTmFEP1qdW7EsHha9DQFu5sz6IOkdcqhyqTO
         LGawDp3j1CGMljt58kGsULc2rW6DuM5w5YA8v2ab7/Z0ovkveC9AYV/yoDxbYUa8u4S8
         8fQ0AL3DmqrQ33/SIFqhnRnWx+5d08EhdDIVHcc8utPrUlQMguoc26HvGsJlPoDXERAq
         PUdpSeygqFuxYFOW5e+CZAJh+/Uwfcy+Te5woK3Wu3WU+vXmIoWBA6d9tSSVsZNhzyb1
         IL3A==
X-Forwarded-Encrypted: i=1; AJvYcCWl/fWF0FuXjfHsZ507gCFsqmf3kijof+tTrFT5rWxmCHQmcuWwMLCrTRVm/7qKi0WEgKwGvK62/+iLLTqf0g==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yx+yy0GHHmZTiNL1+Pvp0Rs4GIPnTC76l1TW52QePWBW3lU/fjX
	grblr03+nLEp+GHWXk7dDQtkggbzGXcNDTeWj2F24xL+ApXHv04UF8EtpRLdn9Wzff9dbJkyjGZ
	4Fybt/ZNg3oMLZF7u+hIJaJBw2KT/PAJBkAxqi5VU1BHSiB97ubP2qjDo5viPB2YWbM3SNNvzZw
	wIdslmLzs=
X-Gm-Gg: ASbGncufl7PN4W3OtCBbAfQdYMby+K8XgRNpn4FwOKelvi6bCMzZ64+sfn2d88D0ZqT
	ekwyysuukghUuhJzbATsfRAx6tfN+xGU6Rut59moPnREB/yjCgJWa30XYyDySymOF50IjH+qa1O
	aAPbQC3HPsT1MrDydZHWhtfkzZ80tKRweMGzTG13GOFIPH/s5fbXqqeN32jxxiqu0oNsw/H6HqP
	7VgHOvcIvEADla05ML6f+iqmRs3d4R2mvVdNxVps2MFT98lEROQkMpBbWpzv3/W8B5BU6kTbpLd
	XhMF5TjP5afuaE1a
X-Received: by 2002:a05:600c:620a:b0:450:d37c:9fc8 with SMTP id 5b1f17b1804b1-4511ecc3cecmr34788975e9.13.1748774954541;
        Sun, 01 Jun 2025 03:49:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs/RMZHHq7bLSa1yD1M5+XQCeStRNeaN+YhhV20HUyM/fKkQFejJBYYJGV/3MZkgRfuJE0bA==
X-Received: by 2002:a05:600c:620a:b0:450:d37c:9fc8 with SMTP id 5b1f17b1804b1-4511ecc3cecmr34788845e9.13.1748774954061;
        Sun, 01 Jun 2025 03:49:14 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fc24d7sm82044335e9.36.2025.06.01.03.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 03:49:13 -0700 (PDT)
Date: Sun, 1 Jun 2025 06:49:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH RESEND v10 3/3] vhost: Add new UAPI to select kthread
 mode and KConfig to enable this IOCTL
Message-ID: <20250601064429-mutt-send-email-mst@kernel.org>
References: <20250531095800.160043-1-lulu@redhat.com>
 <20250531095800.160043-4-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250531095800.160043-4-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qQ9O1Qv1EJBrznF9cHJSE9LZQCHmVKu2nNbOVrxRZNc_1748774955
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 31, 2025 at 05:57:28PM +0800, Cindy Lu wrote:
> This patch introduces a new UAPI that allows the vhost device to select
> in kthread mode. Userspace applications can utilize IOCTL
> VHOST_FORK_FROM_OWNER to select between task and kthread modes, which
> must be invoked before IOCTL VHOST_SET_OWNER, as the worker will be
> created during that call.
> 
> The VHOST_NEW_WORKER requires the inherit_owner setting to be true, and
> a check has been added to ensure proper configuration.
> 
> Additionally, a new KConfig option, CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL,
> is introduced to control the availability of the IOCTL
> VHOST_FORK_FROM_OWNER. When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set
> to n, the IOCTL is disabled, and any attempt to use it will result in a
> failure.
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>

I propose renaming
CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
to
CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL
and it should also control the presence of the module parameter
and a get ioctl (more on which below).

Otherwise we can get a situation where task mode is disabled and
there is no way for userspace to override or check.



> ---
>  drivers/vhost/Kconfig      | 13 +++++++++++++
>  drivers/vhost/vhost.c      | 30 +++++++++++++++++++++++++++++-
>  include/uapi/linux/vhost.h | 16 ++++++++++++++++
>  3 files changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> index 020d4fbb947c..300e474b60fd 100644
> --- a/drivers/vhost/Kconfig
> +++ b/drivers/vhost/Kconfig
> @@ -96,3 +96,16 @@ config VHOST_CROSS_ENDIAN_LEGACY
>  	  If unsure, say "N".
>  
>  endif
> +
> +config VHOST_ENABLE_FORK_OWNER_IOCTL
> +	bool "Enable IOCTL VHOST_FORK_FROM_OWNER"
> +	default n
> +	help
> +	  This option enables the IOCTL VHOST_FORK_FROM_OWNER, allowing
> +	  userspace applications to modify the thread mode for vhost devices.
> +
> +	  By default, `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL` is set to `n`,
> +	  which disables the IOCTL. When enabled (y), the IOCTL allows
> +	  users to set the mode as needed.
> +
> +	  If unsure, say "N".
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 2d2909be1bb2..cfa60dc438f9 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1022,6 +1022,13 @@ long vhost_worker_ioctl(struct vhost_dev *dev, unsigned int ioctl,
>  	switch (ioctl) {
>  	/* dev worker ioctls */
>  	case VHOST_NEW_WORKER:
> +		/*
> +		 * vhost_tasks will account for worker threads under the parent's
> +		 * NPROC value but kthreads do not. To avoid userspace overflowing
> +		 * the system with worker threads inherit_owner must be true.
> +		 */
> +		if (!dev->inherit_owner)
> +			return -EFAULT;
>  		ret = vhost_new_worker(dev, &state);
>  		if (!ret && copy_to_user(argp, &state, sizeof(state)))
>  			ret = -EFAULT;
> @@ -1138,7 +1145,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_iotlb *umem)
>  	int i;
>  
>  	vhost_dev_cleanup(dev);
> -
> +	dev->inherit_owner = inherit_owner_default;
>  	dev->umem = umem;
>  	/* We don't need VQ locks below since vhost_dev_cleanup makes sure
>  	 * VQs aren't running.
> @@ -2292,6 +2299,27 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
>  		goto done;
>  	}
>  
> +#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
> +	if (ioctl == VHOST_FORK_FROM_OWNER) {
> +		u8 inherit_owner;
> +		/*inherit_owner can only be modified before owner is set*/
> +		if (vhost_dev_has_owner(d)) {
> +			r = -EBUSY;
> +			goto done;
> +		}
> +		if (copy_from_user(&inherit_owner, argp, sizeof(u8))) {
> +			r = -EFAULT;
> +			goto done;
> +		}
> +		if (inherit_owner > 1) {
> +			r = -EINVAL;
> +			goto done;
> +		}
> +		d->inherit_owner = (bool)inherit_owner;
> +		r = 0;
> +		goto done;
> +	}
> +#endif
>  	/* You must be the owner to do anything else */
>  	r = vhost_dev_check_owner(d);
>  	if (r)
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index d4b3e2ae1314..d2692c7ef450 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -235,4 +235,20 @@
>   */
>  #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
>  					      struct vhost_vring_state)
> +
> +/**
> + * VHOST_FORK_FROM_OWNER - Set the inherit_owner flag for the vhost device,
> + * This ioctl must called before VHOST_SET_OWNER.
> + *
> + * @param inherit_owner: An 8-bit value that determines the vhost thread mode
> + *
> + * When inherit_owner is set to 1(default value):
> + *   - Vhost will create tasks similar to processes forked from the owner,
> + *     inheriting all of the owner's attributes.
> + *
> + * When inherit_owner is set to 0:
> + *   - Vhost will create tasks as kernel thread.
> + */
> +#define VHOST_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)



Given default now depends on the module parameter, we should
have both GET and SET ioctls. All controlled by the kconfig knob.

> +
>  #endif
> -- 
> 2.45.0

