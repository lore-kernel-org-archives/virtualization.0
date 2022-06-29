Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841DCC43334
	for <virtualization@archiver.kernel.org>; Wed, 29 Jun 2022 08:33:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 17A6140CD2;
	Wed, 29 Jun 2022 08:33:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 17A6140CD2
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cItQxl70
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8W6WK72hEC7U; Wed, 29 Jun 2022 08:33:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 83162400A6;
	Wed, 29 Jun 2022 08:33:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 83162400A6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66C89C0032;
	Wed, 29 Jun 2022 08:33:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64606C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 08:33:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3F67E81911
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 08:33:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3F67E81911
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cItQxl70
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nZXpbtgzZjov
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 08:33:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5E1BF818E6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5E1BF818E6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 08:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656491623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V2JQfeor2cSluhLc8gxrGHJypvB/NOwVYQaX5GcymEw=;
 b=cItQxl70+UzYrKLDyJQz8vZMvVKoR5dFYS8WOAAPu5cJYVTl0TF5dN4233ocn5I1XIGN5b
 p8nE2ysqyqFwpCHpiqPGAhL+p+XvX3qhODaSW/wFLrxh2UVDHuajZqfnRG5IO1F5uWl8d0
 II7ANhwJtVNSqmU+IgdaaT85e08vBrk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-knW7ofWKOBSV6Yf32eXevA-1; Wed, 29 Jun 2022 04:33:41 -0400
X-MC-Unique: knW7ofWKOBSV6Yf32eXevA-1
Received: by mail-wm1-f72.google.com with SMTP id
 i184-20020a1c3bc1000000b003a026f48333so6303571wma.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 01:33:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=V2JQfeor2cSluhLc8gxrGHJypvB/NOwVYQaX5GcymEw=;
 b=YihQYmZ7sURq6S4evkTPW17g5UXBr4mitxJLJa9Ifxc1/5OyHEOs2a8zlyrhP7WWlJ
 W56RYtk49i931ngnNWUP5B/M3gwO4HPIEJ+zhnc+77+x3QfLtda0Hdeguo8opcpvIwFX
 CfjH6TLuVfsA6plaBV54cAl481xwdKNNDk4ybFQ9x70eYUZDu933euOjo3nRxC5nyXQT
 jnfpQquRyhBJsXLSRRjPlJBCuccWhfJDPgSqxVRrcGW+AmkL87yMdWuV2Wx5VDHPT37E
 6w9uAFFHzPrZ7RJYtshmkC/uxCaF3Adr0xoPt85DrTljDRQCXsNC9oa1YjxpQ9p0zwMA
 EBHg==
X-Gm-Message-State: AJIora9Pti5Vt++0pdaWMzYz/QaF4yxsPHLJBQ6uGc55dMdqTfyve8Pz
 ZAWPfWEyf0MhnRZE7Op1OxYncLqMjveJwrLs4RFJ4nong+1bTPBiSJBUcWCoTSTyiDa0iQFn3Wf
 Q7wHww9SU1df72OgTUzOeNiZlHYQgZmTO1xYUrVahaA==
X-Received: by 2002:adf:de02:0:b0:21b:953f:27da with SMTP id
 b2-20020adfde02000000b0021b953f27damr2001609wrm.376.1656491620636; 
 Wed, 29 Jun 2022 01:33:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v+PLxQJll7TtXInzKQuybrNIaNivTqMnP9VYX0DKTWMU6o2bHq58tFNp54PMJxN/DCg4HUhQ==
X-Received: by 2002:adf:de02:0:b0:21b:953f:27da with SMTP id
 b2-20020adfde02000000b0021b953f27damr2001587wrm.376.1656491620402; 
 Wed, 29 Jun 2022 01:33:40 -0700 (PDT)
Received: from redhat.com ([2.52.23.204]) by smtp.gmail.com with ESMTPSA id
 j13-20020a05600c190d00b003973ea7e725sm3420476wmq.0.2022.06.29.01.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jun 2022 01:33:39 -0700 (PDT)
Date: Wed, 29 Jun 2022 04:33:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH 6/6] vduse: Update api version to 1
Message-ID: <20220629042856-mutt-send-email-mst@kernel.org>
References: <20220629082541.118-1-xieyongji@bytedance.com>
 <20220629082541.118-7-xieyongji@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20220629082541.118-7-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xiaodong.liu@intel.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, maxime.coquelin@redhat.com,
 stefanha@redhat.com
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Jun 29, 2022 at 04:25:41PM +0800, Xie Yongji wrote:
> Let's update api version to 1 since we introduced
> some new ioctls to support registering userspace
> memory for IOTLB.
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>


Adding new ioctls does not justify things like this.

Besides, adding UAPI then changing it is not nice
since it makes git bisect behave incorrectly.

> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 12 ++++++++++++
>  include/uapi/linux/vduse.h         |  8 +++++++-
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 7b2ea7612da9..2795785ca6a2 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1206,6 +1206,10 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>  	case VDUSE_IOTLB_GET_INFO: {
>  		struct vduse_iotlb_info iotlb;
>  
> +		ret = -EPERM;


Almost for sure a wrong error code.

> +		if (dev->api_version < 1)
> +			break;
> +
>  		iotlb.bounce_iova = 0;
>  		iotlb.bounce_size = dev->domain->bounce_size;
>  


Wait a second. so you are intentionally breaking any userspace
that called VDUSE_SET_API_VERSION with version 0?

Please don't.


> @@ -1219,6 +1223,10 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>  	case VDUSE_IOTLB_REG_UMEM: {
>  		struct vduse_iotlb_umem umem;
>  
> +		ret = -EPERM;
> +		if (dev->api_version < 1)
> +			break;
> +
>  		ret = -EFAULT;
>  		if (copy_from_user(&umem, argp, sizeof(umem)))
>  			break;
> @@ -1230,6 +1238,10 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>  	case VDUSE_IOTLB_DEREG_UMEM: {
>  		struct vduse_iotlb_umem umem;
>  
> +		ret = -EPERM;
> +		if (dev->api_version < 1)
> +			break;
> +
>  		ret = -EFAULT;
>  		if (copy_from_user(&umem, argp, sizeof(umem)))
>  			break;
> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> index 1b17391e228f..902ea19cd9e0 100644
> --- a/include/uapi/linux/vduse.h
> +++ b/include/uapi/linux/vduse.h
> @@ -8,7 +8,13 @@
>  
>  /* The ioctls for control device (/dev/vduse/control) */
>  
> -#define VDUSE_API_VERSION	0
> +/*
> + * v0 -> v1:
> + *  - Introduce VDUSE_IOTLB_GET_INFO ioctl
> + *  - Introduce VDUSE_VDUSE_IOTLB_REG_UMEM ioctl
> + *  - Introduce VDUSE_IOTLB_DEREG_UMEM ioctl
> + */
> +#define VDUSE_API_VERSION	1
>  
>  /*
>   * Get the version of VDUSE API that kernel supported (VDUSE_API_VERSION).
> -- 
> 2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
