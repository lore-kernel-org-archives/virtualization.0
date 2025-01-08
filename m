Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627A91F942E
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Jan 2025 12:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736338548; cv=none; b=louRNnEZGfun6YESfX+emFV7UONaiRKgczrz983Cyl9AOwKGZfXohP7x5bSrYcni3hFelM5+mGar4YBeu7+3QqjWhVqIYBdWthZD5G0HtRYuWiKYB0TCZs2VNlqv9mqtB7RiS7nvryZD7s38pGxRPUBvACcTpAufGpTBHwcQKrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736338548; c=relaxed/simple;
	bh=OqojvAOQdZS0yj4ZVZFm47SzmmZRZEQKJGSfgoE2f+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tnKod3qWXrs+4w2h5xffZShPfuv63IdQDZFzDCeskAqYHDVvoO5mFffm7dkWzGo5dMlV6cXgSrePv7KSgtinvpIiKSCpA2KToRLb2wqrfFVm7oqb8zTh8sDob/vtH43QJoQPtXWS7B9JfOUgKq/kgiSa38G6KSi+fGzpJAxwRZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ha0Wc5JH; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ha0Wc5JH"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE6B4402DA
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Jan 2025 12:15:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YUNLLfZPjXHF for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jan 2025 12:15:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B04C140170
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B04C140170
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ha0Wc5JH
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B04C140170
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Jan 2025 12:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736338544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LFFT/vNzip1RPoosirB5rZ8ksM/hte4x/jhW8SUMpHI=;
	b=ha0Wc5JHzN83B6sCVc4QfoA/hlg0KZaMXsp8rxzFgUAkypJPI7DIqhkRQviGbuAvTY1zer
	KrCGfre/X9IyxxBx8ZsaV9zX1a7hX2Cv8vAXDKpGimRwkXOJz65XzodGn2NRpbgyUCMpHm
	jz6Lt9sy085or/da6xh+jkAHvA8CSck=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-naUC9vbwMNCfM86zIXlXDA-1; Wed, 08 Jan 2025 07:15:43 -0500
X-MC-Unique: naUC9vbwMNCfM86zIXlXDA-1
X-Mimecast-MFC-AGG-ID: naUC9vbwMNCfM86zIXlXDA
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385e03f54d0so7547901f8f.3
        for <virtualization@lists.linux-foundation.org>; Wed, 08 Jan 2025 04:15:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736338542; x=1736943342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFFT/vNzip1RPoosirB5rZ8ksM/hte4x/jhW8SUMpHI=;
        b=VQk5hXhgpFC8JJJxgM5kQlCjDebz/pUfYfrkZ8gfbHi3eCvrpD8IbsTzVDQfTG7XS8
         wPysNbuFd0XL8SB2ApG0RmkBZM5Huihc8hv4tR1Zd/C6fh4FBaoA71O5bL/SozbrtEm8
         MMFH9j8bP2HW5STDPD5suc5vt4rpitPk3K7G650uvyiYyWba+hO8sQLX3i0haNzZurEM
         Vi9eR8HdlppZBVT4xklunmUXe8gJJ6i/hIT8OtUNMBc5a+WqIIlJtAn0xmJx6d2r5Wz3
         suP5Slb00px/hIXmTRYI5uS0Jfz6gyQ8jiEplpGgwOxR7tdyTakQ5pdVaVlHlXqdpHBj
         rIEw==
X-Forwarded-Encrypted: i=1; AJvYcCUtQe2laoIIt9FpliaKRpvfgw4PMVB7iXaE4sCM2p1TFfuNJTpY8XS2AOdddV7bvZ1ya3q8d0LcF0RzFgpxww==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yym5mquaWzowezrgoHq/YypMnFiyP9b6HSnI4skJ+pp8VDJ6jH3
	dCtg8gCxmu2qN9ktq+A0WSNxZMFHHiwwAxRSiSDDMvSdluWLLTrkfqh0BNi0dCevjvsDaMOOrPf
	1Xr99wk22GZSzeBIH5BVlfMTC3mn9GSf/DM/leu7PHUwbQwCfaWMVe5l+WVYFT+GYpgjcHlTF0A
	8yK/M=
X-Gm-Gg: ASbGnctSZ09Xxq+57T0RIeDFETnbHEmiLZRJCQAPokRfTwn5a/qgGTvPJGOnMrLGM5V
	JfhdBVXTB5m0NrxQ9fDOeQU9v23LGSfcGR8+cBo+AasBxtfbeEJXIhLUGvEmQwIlfluSg1ZnyTp
	hCMMdfGjrkpY9E/3z4DAdDK9WHVPLb1rLDiLqKZGXUEekdyheX7WBL76VihaLbjv8HXr82PtKUW
	nMFZYX8rH9grJ1C3+p1PARz86ainMQW4De8Vclv5lDfp913veI=
X-Received: by 2002:a05:6000:1f88:b0:385:fc97:9c63 with SMTP id ffacd0b85a97d-38a872f6915mr2066554f8f.9.1736338542107;
        Wed, 08 Jan 2025 04:15:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+hsGgqCsiIWeOXVWHmgrZwnMiJD4OWipciIeE4FGEZqdLeDGimlpEKTMbbuIjZpmwpZibCg==
X-Received: by 2002:a05:6000:1f88:b0:385:fc97:9c63 with SMTP id ffacd0b85a97d-38a872f6915mr2066535f8f.9.1736338541761;
        Wed, 08 Jan 2025 04:15:41 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:d62d:93ef:d7e2:e7da:ed72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e03210sm19211155e9.34.2025.01.08.04.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 04:15:41 -0800 (PST)
Date: Wed, 8 Jan 2025 07:15:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v5 5/6] vhost: Add new UAPI to support change to task mode
Message-ID: <20250108071456-mutt-send-email-mst@kernel.org>
References: <20241230124445.1850997-1-lulu@redhat.com>
 <20241230124445.1850997-6-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241230124445.1850997-6-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kndGHE-4x7VNqM2t8mR-2_PW4zzWBXX9QOEeVxWUbGI_1736338542
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 30, 2024 at 08:43:52PM +0800, Cindy Lu wrote:
> Add a new UAPI to enable setting the vhost device to task mode.
> The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
> to configure the mode if necessary.
> This setting must be applied before VHOST_SET_OWNER, as the worker
> will be created in the VHOST_SET_OWNER function
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>

I'd like a Kconfig option to control enabling/blocking this
ioctl. Make it a patch on top pls.


> ---
>  drivers/vhost/vhost.c      | 22 +++++++++++++++++++++-
>  include/uapi/linux/vhost.h | 19 +++++++++++++++++++
>  2 files changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index ff17c42e2d1a..47c1329360ac 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2250,15 +2250,35 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
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
> +	if (ioctl == VHOST_SET_INHERIT_FROM_OWNER) {
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
> index b95dd84eef2d..f5fcf0b25736 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -235,4 +235,23 @@
>   */
>  #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
>  					      struct vhost_vring_state)
> +
> +/**
> + * VHOST_SET_INHERIT_FROM_OWNER - Set the inherit_owner flag for the vhost device
> + *
> + * @param inherit_owner: An 8-bit value that determines the vhost thread mode
> + *
> + * When inherit_owner is set to 1 (default behavior):
> + *   - The VHOST worker threads inherit their values/checks from
> + *     the thread that owns the VHOST device. The vhost threads will
> + *     be counted in the nproc rlimits.
> + *
> + * When inherit_owner is set to 0:
> + *   - The VHOST worker threads will use the traditional kernel thread (kthread)
> + *     implementation, which may be preferred by older userspace applications that
> + *     do not utilize the newer vhost_task concept.
> + */
> +
> +#define VHOST_SET_INHERIT_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
> +
>  #endif
> -- 
> 2.45.0

