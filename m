Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10051CCB22
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Nov 2024 07:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730878384; cv=none; b=qUBkV0DqVQ4xszO8qS+EasnALI9dAwt/ApFqWeqMkTekMeAGdGTGjUdBj6ggFhJH1SSLUz74Ts0/FegiVdsIBC3vxKnl3nTWcdqLsYfNGJ1vf1i9hEJRnhWizUYFLJ19UDUUZn5XLFAadA5+Wm7Eg57dMbwydpKRF6Gr8UtWwhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730878384; c=relaxed/simple;
	bh=1TK5jWQmYm5lF5a0elC3Jq/CHvGV6cfz4sc++/qpT/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Phxvzt7qgBLPVNeQia6+3CNiptIPzyGFiG0Snegbk01h/eicfmOlqFv3zm8CjHC8M6p8/9Ul0K1Vv7FnzCmLTbV8T/GTM8pYtogtfBPgOsHqextIElXrtp/M1R+zEc0IGkpIb/NgeSWvfKyO+qxgF30t2mD/aizROTlp98gSnik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b5k0dBli; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5k0dBli"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6534F60904
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Nov 2024 07:33:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LSgNOGq62itY for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Nov 2024 07:33:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 90BA7608F4
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 90BA7608F4
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b5k0dBli
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 90BA7608F4
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Nov 2024 07:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730878378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I0Nl77wHyDTDBUHU8VfL2oqjen/EEFJo/J8tC1+irrs=;
	b=b5k0dBlig2vuFj1Jqi/4N3tqWNBqFumFZl8zc5t9+r2bl2/8T/yXJVe816TeYAt7ZbeFPC
	dit1dCwTWseWIzNE5JFw4Sf8mw6ZACn1tbtK17W1+iB/IzBnHkE2IgFezJSJWOylvHmeXT
	LR8XB1kH7dJqCXXh+j0NhslSFjQDI2M=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-gczJ18q6PUS_ZkyrEUbm-A-1; Wed, 06 Nov 2024 02:32:56 -0500
X-MC-Unique: gczJ18q6PUS_ZkyrEUbm-A-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-539ec1a590fso4358824e87.0
        for <virtualization@lists.linux-foundation.org>; Tue, 05 Nov 2024 23:32:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730878375; x=1731483175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0Nl77wHyDTDBUHU8VfL2oqjen/EEFJo/J8tC1+irrs=;
        b=BHC99WTDbz5ZVUK2w7PoNmG84onP0PoOD3hNlPwBjhFYY9tOYSeCFDylKJFCfwE2Hb
         dxHH49+U1aE6RUMY0a5vH6TcekVwXyB5QQk7lLxf+y0DbmJKn1biwb/n8JOr2kTcYZYz
         IUeuWZcOlHckcIBUTPgEQL2koN8dKlQ5bwWv8zWw/QOKMzNJVCoSRwpOriZAL0/usXks
         2zlkf1TlQB7yqbQr12cPpMBijvdlnFUKBjgskLWLbsfMCEVjqQhockYGwNt+zaPGAOiV
         J40iN6ZG1nCCzvetv+WRztEJ5i8sOsCHqBWMUOLrhKg4wu7fSgJhL2SkCqViMqOcQsuV
         7aKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOOpoOLbAC7Zs38BsEUSh2HZHJnYjsRzax7z3Y9d2mLe5lYYr8BFpedLUgK3SyOdBgGEDy6+FcEYvkZnzuQQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwstMzgdIj8ufTTEh9ZO+IqRAiwkyXsEw55S+JD03M/RTb+aa10
	CFfVC7wFcLHXnDQ+LCjFoXNPZdu54iEpKnbP71PKCe/DRgucc9rtjzu1yF/XSQrJXSdC5UTX67Q
	uc3QU4QzIPHKrsMjLOrDz/EU9wwU7O7yYdxjUUBalHMY4H+LjbxiRxpYUDyE2QtW8JTR4AluiAa
	NKVkw=
X-Received: by 2002:a05:6512:3a8c:b0:539:ed5e:e226 with SMTP id 2adb3069b0e04-53b3490f0demr19783065e87.26.1730878375090;
        Tue, 05 Nov 2024 23:32:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjB2BJOsn+j3Y41tPwiKFVeRVoGZVa9+cut0MOvJu0SDjEm2Wp6FGY8emxABWpEuw8y0y3Bg==
X-Received: by 2002:a05:6512:3a8c:b0:539:ed5e:e226 with SMTP id 2adb3069b0e04-53b3490f0demr19783047e87.26.1730878374648;
        Tue, 05 Nov 2024 23:32:54 -0800 (PST)
Received: from redhat.com ([2a02:14f:178:e74:5fcf:8a69:659d:f2b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa7397e4sm11883915e9.40.2024.11.05.23.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 23:32:53 -0800 (PST)
Date: Wed, 6 Nov 2024 02:31:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 7/9] vhost: Add new UAPI to support change to task mode
Message-ID: <20241106022630-mutt-send-email-mst@kernel.org>
References: <20241105072642.898710-1-lulu@redhat.com>
 <20241105072642.898710-8-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241105072642.898710-8-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 05, 2024 at 03:25:26PM +0800, Cindy Lu wrote:
> Add a new UAPI to enable setting the vhost device to task mode.
> The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
> to configure the mode if necessary.
> This setting must be applied before VHOST_SET_OWNER, as the worker
> will be created in the VHOST_SET_OWNER function
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/vhost.c      | 15 ++++++++++++++-
>  include/uapi/linux/vhost.h |  2 ++
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index c17dc01febcc..70c793b63905 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2274,8 +2274,9 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
>  {
>  	struct eventfd_ctx *ctx;
>  	u64 p;
> -	long r;
> +	long r = 0;
>  	int i, fd;
> +	bool inherit_owner;
>  
>  	/* If you are not the owner, you can become one */
>  	if (ioctl == VHOST_SET_OWNER) {
> @@ -2332,6 +2333,18 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
>  		if (ctx)
>  			eventfd_ctx_put(ctx);
>  		break;
> +	case VHOST_SET_INHERIT_FROM_OWNER:
> +		/*inherit_owner can only be modified before owner is set*/

bad coding style

> +		if (vhost_dev_has_owner(d))
> +			break;

is this silently failing? should return EBUSY or something like this.

> +
> +		if (copy_from_user(&inherit_owner, argp,
> +				   sizeof(inherit_owner))) {

not good, 


> +			r = -EFAULT;
> +			break;
> +		}
> +		d->inherit_owner = inherit_owner;




> +		break;
>  	default:
>  		r = -ENOIOCTLCMD;
>  		break;



This means any task can break out of jail
and steal root group system time by setting inherit_owner to 0
even if system is configured to inherit by default.

we need a modparam to block this.


> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index b95dd84eef2d..1e192038633d 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -235,4 +235,6 @@
>   */
>  #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
>  					      struct vhost_vring_state)
> +
> +#define VHOST_SET_INHERIT_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, bool)

do not put bool in interfaces. something like u8 and validate it is 0 or
1.

>  #endif
> -- 
> 2.45.0

