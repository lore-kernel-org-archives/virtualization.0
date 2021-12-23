Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20FCDC433F5
	for <virtualization@archiver.kernel.org>; Thu, 23 Dec 2021 13:58:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9F9DA41625;
	Thu, 23 Dec 2021 13:58:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eSj9gTlE1bUE; Thu, 23 Dec 2021 13:58:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 50706415D9;
	Thu, 23 Dec 2021 13:58:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3285BC002F;
	Thu, 23 Dec 2021 13:58:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 329EDC0012
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 13:58:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1A6F1828DF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 13:58:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6TsmIIjHGr2k
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 13:58:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D65AB828AA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 13:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1640267915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CpQJOwyNtlX1Mdolftn4RcdaD2Hy2yaictkseWrq6SQ=;
 b=h/cBAqnZnHzuXKRJUGofZzVPxdYxZ7o5K4UtIiLt7LcNt3gvybSS7JTZcO5wnrmY52bUPZ
 1gvDKSTTVWDkwSZLxftjeNkyKvhA3vmw6Xf8oaVVQGehAvIBciBtK68IHujbIEqbuoVrpC
 gqO+0E19uqeAwYbORgAAYRwKTz/NlfQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-134-buNEq-ZeN66VwGy6I_8f6g-1; Thu, 23 Dec 2021 08:58:32 -0500
X-MC-Unique: buNEq-ZeN66VwGy6I_8f6g-1
Received: by mail-wm1-f71.google.com with SMTP id
 r2-20020a05600c35c200b00345c3b82b22so2844085wmq.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 05:58:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CpQJOwyNtlX1Mdolftn4RcdaD2Hy2yaictkseWrq6SQ=;
 b=BXKMvO/0KVJviDPBwexPW656AKp9PVKKj5cco6Qg1dJrGu2A/yMGcZtNVutzYz6HkF
 fhHuOhblrmtIqGyeUl+n4EY5ayn3mMkpimCK9NGlOHvHCCw3qSZsh/hwFlAVegqt/IZ3
 YAbdfF/3ADc6X4PKkpUMlsatNorCzE5aXOnm3J9m/gfUNF+l8/o9noqKYrYKjXRUxFhh
 GsUiCztCS3DsmMzeI1GepVTjjxPB+8KoyRyLAo33XMggvDt4oJ7L+9zIfKwqHmosCpUY
 xxqz5QhRUUZaAPNvuMTx2MrWCDbCbn0+A8ZboSDeFBvOvnrnmdWeWSz/s/eVlcQx5kX+
 MRWQ==
X-Gm-Message-State: AOAM5321lS7mWSbta4xhhAXcl9GjZl5Ztb4lkosae0gXpMAVkC+/5RkY
 FBSN1yPmLdL0Ea+PEf3gmxvmXOafX17MuzTz1jFS5IHrIDPf+MYI4GgKQWhCbUXa2wAXt5YrENW
 CgMousX1gtNOgZgHJJrfju8YHRrbCFvFB0e6yph6Wzg==
X-Received: by 2002:a05:600c:1f0f:: with SMTP id
 bd15mr1897611wmb.2.1640267911069; 
 Thu, 23 Dec 2021 05:58:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxdZ+swrtLCADcHVBsqJwj8tIlyAIce/Bk5kJZdXg7yhPIcNXyeP1RJ9MxfrD4FnxzIoU/LvQ==
X-Received: by 2002:a05:600c:1f0f:: with SMTP id
 bd15mr1897604wmb.2.1640267910875; 
 Thu, 23 Dec 2021 05:58:30 -0800 (PST)
Received: from redhat.com ([2.55.1.37])
 by smtp.gmail.com with ESMTPSA id r8sm5096452wru.107.2021.12.23.05.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Dec 2021 05:58:30 -0800 (PST)
Date: Thu, 23 Dec 2021 08:58:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yi Wang <wang.yi59@zte.com.cn>
Subject: Re: [PATCH] vdpa: regist vhost-vdpa dev class
Message-ID: <20211223085634-mutt-send-email-mst@kernel.org>
References: <20211223073145.35363-1-wang.yi59@zte.com.cn>
MIME-Version: 1.0
In-Reply-To: <20211223073145.35363-1-wang.yi59@zte.com.cn>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Zhang Min <zhang.min9@zte.com.cn>, wang.liang82@zte.com.cn,
 kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xue.zhihong@zte.com.cn
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

typo in subject

On Thu, Dec 23, 2021 at 03:31:45PM +0800, Yi Wang wrote:
> From: Zhang Min <zhang.min9@zte.com.cn>
> 
> Some applications like kata-containers need to acquire MAJOR/MINOR/DEVNAME
> for devInfo [1], so regist vhost-vdpa dev class to expose uevent.
> 
> 1. https://github.com/kata-containers/kata-containers/blob/main/src/runtime/virtcontainers/device/config/config.go
> 
> Signed-off-by: Zhang Min <zhang.min9@zte.com.cn>
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> ---
>  drivers/vhost/vdpa.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index fb41db3da611..90fbad93e7a2 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1012,6 +1012,7 @@ static void vhost_vdpa_release_dev(struct device *device)
>  	kfree(v);
>  }
>  
> +static struct class *vhost_vdpa_class;
>  static int vhost_vdpa_probe(struct vdpa_device *vdpa)
>  {
>  	const struct vdpa_config_ops *ops = vdpa->config;
> @@ -1040,6 +1041,7 @@ static int vhost_vdpa_probe(struct vdpa_device *vdpa)
>  	v->dev.release = vhost_vdpa_release_dev;
>  	v->dev.parent = &vdpa->dev;
>  	v->dev.devt = MKDEV(MAJOR(vhost_vdpa_major), minor);
> +	v->dev.class = vhost_vdpa_class;
>  	v->vqs = kmalloc_array(v->nvqs, sizeof(struct vhost_virtqueue),
>  			       GFP_KERNEL);
>  	if (!v->vqs) {
> @@ -1097,6 +1099,14 @@ static int __init vhost_vdpa_init(void)
>  {
>  	int r;
>  
> +	vhost_vdpa_class = class_create(THIS_MODULE, "vhost-vdpa");
> +	if (IS_ERR(vhost_vdpa_class)) {
> +		r = PTR_ERR(vhost_vdpa_class);
> +		pr_warn("vhost vdpa class create error %d,  maybe mod reinserted\n", r);

what's mod reinserted? why warn not error?

> +		vhost_vdpa_class = NULL;
> +		return r;
> +	}
> +
>  	r = alloc_chrdev_region(&vhost_vdpa_major, 0, VHOST_VDPA_DEV_MAX,
>  				"vhost-vdpa");
>  	if (r)
> @@ -1111,6 +1121,7 @@ static int __init vhost_vdpa_init(void)
>  err_vdpa_register_driver:
>  	unregister_chrdev_region(vhost_vdpa_major, VHOST_VDPA_DEV_MAX);
>  err_alloc_chrdev:
> +	class_destroy(vhost_vdpa_class);
>  	return r;
>  }
>  module_init(vhost_vdpa_init);
> @@ -1118,6 +1129,7 @@ module_init(vhost_vdpa_init);
>  static void __exit vhost_vdpa_exit(void)
>  {
>  	vdpa_unregister_driver(&vhost_vdpa_driver);
> +	class_destroy(vhost_vdpa_class);
>  	unregister_chrdev_region(vhost_vdpa_major, VHOST_VDPA_DEV_MAX);
>  }
>  module_exit(vhost_vdpa_exit);
> -- 
> 2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
