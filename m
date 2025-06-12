Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC131F1313
	for <virtualization@lists.linux-foundation.org>; Thu, 12 Jun 2025 06:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749709882; cv=none; b=i2Uui3uAdE7+BX7cnT8EFZu8vZeZoFfx408sHbfH0f4+MgeQ6xmP6/aH5wBsS8q38peGVRwItYy7rba1853XjQGtiRpIXqTx6b+oSpTteLHwtP0y1Oi/Hb1LnHtT6/ZerAQAoHbnAQLdQMehfsldFmxuwZ9EASTZTbUQN03lQZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749709882; c=relaxed/simple;
	bh=uVP9puXoIew/Ys15nmcdCzBtIRCr9QIJfdWgIpcR6wI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ar/Jq+8sHchKzBChbZNBh5Jb3cu7hvuWVn7Eq076ryv1LTLFyvTWtvkHK/06ifMh7M2Ysh/k6HN8i7QBcHT6ja+nHPS8nhPEn5pI7PNjl0lcMoS3Rg6O+6dkChENdkRcY5KmRaxgpf2Vy2aO1WyaF1Ab8n/MoxpiddTcmM8ImLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fa7GCkTq; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fa7GCkTq"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5F59981E8B
	for <virtualization@lists.linux-foundation.org>; Thu, 12 Jun 2025 06:31:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NdfqzrmOPQ2k for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Jun 2025 06:31:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8E63381E89
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8E63381E89
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fa7GCkTq
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8E63381E89
	for <virtualization@lists.linux-foundation.org>; Thu, 12 Jun 2025 06:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749709877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u3UuqHSkhoCWjsmKvKZgvB4q0ePA6YJ5VWAJGZfkLJg=;
	b=fa7GCkTqzz8xiKYqNnksN4S+Jj/t3tCmb7XGKGUmtNa1319wGPq4pmhLPLKNbG/5X3or3y
	03/zwvw/x19pm/ANFfX8HSMsieWRRGT4X4RptQLmQg552ugnjG4j9hj2B0Hp1KRYulpJ+x
	F/pQNPJdSWkDt6XEQSPO4YteEYfc96U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-Y9R92Ml0MIubJgTDxoJPJQ-1; Thu, 12 Jun 2025 02:31:16 -0400
X-MC-Unique: Y9R92Ml0MIubJgTDxoJPJQ-1
X-Mimecast-MFC-AGG-ID: Y9R92Ml0MIubJgTDxoJPJQ_1749709875
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4532514dee8so4167095e9.0
        for <virtualization@lists.linux-foundation.org>; Wed, 11 Jun 2025 23:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749709875; x=1750314675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3UuqHSkhoCWjsmKvKZgvB4q0ePA6YJ5VWAJGZfkLJg=;
        b=CM+EMap/Ja6QDb/XlMcj9O/3IOFnjRF2NXVTh2+RFPSdVzGgdfLuRjC9834hjlOQUN
         cirbRw0XNaIrDB9FNK85ecHzBpp+xV0jdnYvs26x15AS9N3FWuuww+SDGgbSPkIgTMJz
         d7eUWnaxlB4QbboPBVbu+IE1WEgsgSCgzngJisU0SJ/HSF2zZCGY2DelVv4Rb638/IFV
         bwe12Ytv+4N4VoqdszrxGFsI9kuu9sdh3jvqQaK6QMlnUDkPar4Wp95/td+eUutiOTEq
         3mS9/NR6QSiS61dAkprvbrmBNYZoavBJ+eRdubcjkmMuLb1/9SJZTF1XUq7j7rnbSCoU
         L5Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUEdPlKQj8BPdhwIBwcSvBSL4flgUux3jE7pxlTXIXfPH5OlfiDmUJp8ilIwiB41L/z62cSsNQKLIYK7OhG+A==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwiOdtvQ9QV8xhSmVaTq6Ic2SbJNQs0SqJkpKEIgaoj6SjOTup1
	61niRPOpNQmC6W8cD5PnBgCac7A9V1RQ3ay5SrcIOyZ9d+Ky8p3zsEJh0SbcjDmYm4Kgb9qFkAW
	uX9r/iQsvt940JbIRxIs6oxM+LH87nCUzNmEo+FF1buQoAR8xMa3cXkRBHnS0tLBLNMGm7ha7eZ
	HC0EIJNVI=
X-Gm-Gg: ASbGncvrKjfP2HZPlU54bUF4XV37vZhp2/RgzjcXeHKUoyYgl/HtjII6ion8AxvzFDR
	8VjqNsnkRlUZgVuPHSkssfaf5H3H5viYjMkmTD7iLv4r19ozOq6X08+MJocmpubLQzNPzulFs5o
	Z4x3NkUep+uHK+pL2pFdtYY+CzLXW7DkSne6FIllPS71XZnZCxi0yURA4Qei1PM6O7FGcFTz+fW
	K6ONg8i8dmCEI68gzxgU7jjRJ2bzEDAqp1l0OpyMVISLc4ZYeAseOF+X7Hhv3mGyXj/uAPKlbGm
	p6U1ZJbMjDJgvK1y
X-Received: by 2002:a05:600c:4f06:b0:453:608:a18b with SMTP id 5b1f17b1804b1-4532b28d858mr24218475e9.9.1749709875306;
        Wed, 11 Jun 2025 23:31:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG42kNG+HqM89NPvBcNZFAzJ3Vn7GxaF9vIvrfn2F0Rh/ycFiYHni3pyzMMLUuiDLbmUb5Kuw==
X-Received: by 2002:a05:600c:4f06:b0:453:608:a18b with SMTP id 5b1f17b1804b1-4532b28d858mr24218175e9.9.1749709874848;
        Wed, 11 Jun 2025 23:31:14 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e24155bsm10020445e9.17.2025.06.11.23.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 23:31:14 -0700 (PDT)
Date: Thu, 12 Jun 2025 02:31:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v11 3/3] vhost: Add configuration controls for vhost
 worker's mode
Message-ID: <20250612022053-mutt-send-email-mst@kernel.org>
References: <20250609073430.442159-1-lulu@redhat.com>
 <20250609073430.442159-4-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250609073430.442159-4-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RD3eeDXsUoNSRZ0umYfZ6P-0zw3GQbqeKfBlqqSBnyI_1749709875
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 09, 2025 at 03:33:09PM +0800, Cindy Lu wrote:
> This patch introduces functionality to control the vhost worker mode:
> 
> - Add two new IOCTLs:
>   * VHOST_SET_FORK_FROM_OWNER: Allows userspace to select between
>     task mode (fork_owner=1) and kthread mode (fork_owner=0)
>   * VHOST_GET_FORK_FROM_OWNER: Retrieves the current thread mode
>     setting
> 
> - Expose module parameter 'fork_from_owner_default' to allow system
>   administrators to configure the default mode for vhost workers
> 
> - Add KConfig option CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL to
>   control the availability of these IOCTLs and parameter, allowing
>   distributions to disable them if not needed
> 
> - The VHOST_NEW_WORKER functionality requires fork_owner to be set
>   to true, with validation added to ensure proper configuration
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>


getting there. yet something to improve.

> ---
>  drivers/vhost/Kconfig      | 17 +++++++++++++++
>  drivers/vhost/vhost.c      | 44 ++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/vhost.h | 25 ++++++++++++++++++++++
>  3 files changed, 86 insertions(+)
> 
> diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> index 020d4fbb947c..49e1d9dc92b7 100644
> --- a/drivers/vhost/Kconfig
> +++ b/drivers/vhost/Kconfig
> @@ -96,3 +96,20 @@ config VHOST_CROSS_ENDIAN_LEGACY
>  	  If unsure, say "N".
>  
>  endif
> +
> +config CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL
> +	bool "Enable CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL"
> +	default n
> +	help
> +	  This option enables two IOCTLs: VHOST_SET_FORK_FROM_OWNER and
> +	  VHOST_GET_FORK_FROM_OWNER. These allow userspace applications
> +	  to modify the vhost worker mode for vhost devices.
> +
> +	  Also expose module parameter 'fork_from_owner_default' to allow users
> +	  to configure the default mode for vhost workers.
> +
> +	  By default, `CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL` is set to `n`,
> +	  which disables the IOCTLs and parameter.
> +	  When enabled (y), users can change the worker thread mode as needed.
> +
> +	  If unsure, say "N".
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 37d3ed8be822..903d9c3f6784 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -43,6 +43,11 @@ module_param(max_iotlb_entries, int, 0444);
>  MODULE_PARM_DESC(max_iotlb_entries,
>  	"Maximum number of iotlb entries. (default: 2048)");
>  static bool fork_from_owner_default = true;

Add empty lines around ifdef to make it clear what code do they
delimit.


> +#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL
> +module_param(fork_from_owner_default, bool, 0444);
> +MODULE_PARM_DESC(fork_from_owner_default,
> +		 "Set task mode as the default(default: Y)");
> +#endif
>  
>  enum {
>  	VHOST_MEMORY_F_LOG = 0x1,
> @@ -1019,6 +1024,13 @@ long vhost_worker_ioctl(struct vhost_dev *dev, unsigned int ioctl,
>  	switch (ioctl) {
>  	/* dev worker ioctls */
>  	case VHOST_NEW_WORKER:
> +		/*
> +		 * vhost_tasks will account for worker threads under the parent's
> +		 * NPROC value but kthreads do not. To avoid userspace overflowing
> +		 * the system with worker threads fork_owner must be true.
> +		 */
> +		if (!dev->fork_owner)
> +			return -EFAULT;

An empty line here would make the code clearer.

>  		ret = vhost_new_worker(dev, &state);
>  		if (!ret && copy_to_user(argp, &state, sizeof(state)))
>  			ret = -EFAULT;
> @@ -1136,6 +1148,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_iotlb *umem)
>  
>  	vhost_dev_cleanup(dev);
>  
> +	dev->fork_owner = fork_from_owner_default;
>  	dev->umem = umem;
>  	/* We don't need VQ locks below since vhost_dev_cleanup makes sure
>  	 * VQs aren't running.
> @@ -2289,6 +2302,37 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
>  		goto done;
>  	}
>  
> +#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL
> +	u8 fork_owner;

Do not declare variables in the middle of a scope please.
This one is not needed in this scope, so just move it down
to within if (yes you will repeat the declaration twice then).



> +
> +	if (ioctl == VHOST_SET_FORK_FROM_OWNER) {
> +		/*fork_owner can only be modified before owner is set*/

bad comment style.

> +		if (vhost_dev_has_owner(d)) {
> +			r = -EBUSY;
> +			goto done;
> +		}
> +		if (copy_from_user(&fork_owner, argp, sizeof(u8))) {

get_user is a better fit for this. In particular, typesafe.


> +			r = -EFAULT;
> +			goto done;
> +		}
> +		if (fork_owner > 1) {

so 0 and 1 are the only legal values?
maybe add an enum or defines in the header then.


> +			r = -EINVAL;
> +			goto done;
> +		}
> +		d->fork_owner = (bool)fork_owner;

		!!fork_owner is shorter and idiomatic.

> +		r = 0;
> +		goto done;
> +	}
> +	if (ioctl == VHOST_GET_FORK_FROM_OWNER) {
> +		fork_owner = d->fork_owner;
> +		if (copy_to_user(argp, &fork_owner, sizeof(u8))) {

put_user

> +			r = -EFAULT;
> +			goto done;
> +		}
> +		r = 0;
> +		goto done;
> +	}
> +#endif
>  	/* You must be the owner to do anything else */
>  	r = vhost_dev_check_owner(d);
>  	if (r)
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index d4b3e2ae1314..e51d6a347607 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -235,4 +235,29 @@
>   */
>  #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
>  					      struct vhost_vring_state)
> +
> +/**
> + * VHOST_SET_FORK_FROM_OWNER - Set the fork_owner flag for the vhost device,
> + * This ioctl must called before VHOST_SET_OWNER.
> + * Only available when CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL=y
> + *
> + * @param fork_owner: An 8-bit value that determines the vhost thread mode
> + *
> + * When fork_owner is set to 1(default value):
> + *   - Vhost will create vhost worker as tasks forked from the owner,
> + *     inheriting all of the owner's attributes.
> + *
> + * When fork_owner is set to 0:
> + *   - Vhost will create vhost workers as kernel threads.
> + */
> +#define VHOST_SET_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
> +
> +/**
> + * VHOST_GET_FORK_OWNER - Get the current fork_owner flag for the vhost device.
> + * Only available when CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL=y
> + *
> + * @return: An 8-bit value indicating the current thread mode.
> + */
> +#define VHOST_GET_FORK_FROM_OWNER _IOR(VHOST_VIRTIO, 0x84, __u8)
> +
>  #endif
> -- 
> 2.45.0

