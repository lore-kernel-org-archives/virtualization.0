Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51141E95A67
	for <virtualization@archiver.kernel.org>; Sun,  8 Oct 2023 06:21:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B2A26610AA;
	Sun,  8 Oct 2023 06:21:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B2A26610AA
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gQdgWzdg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lv_P-9rPoFss; Sun,  8 Oct 2023 06:21:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B5FFD61013;
	Sun,  8 Oct 2023 06:21:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B5FFD61013
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B349C0039;
	Sun,  8 Oct 2023 06:21:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9EDF9C0032
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 06:21:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6675881EAD
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 06:21:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6675881EAD
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gQdgWzdg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LsruOUWiNSPH
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 06:21:03 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1E57681AC4
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 06:21:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1E57681AC4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696746061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZKDLVNxVS0wQgCZnWdWwS5zdRpPBL6HalxkdKXdcEh4=;
 b=gQdgWzdgbIFGyPVFY49ma7Ed7LI9qUVL4ryu0tFkJ+YxAfNmkWBgSDazF9VHdBYVYIIR1s
 OG5Bwy49uOARBg3HFYWykILIiL3G7wfDCXofn56YoY73OVXLXFMbWMSdQEpTKk59X2b/sN
 bnCCNrj4ldx57qTXYkBpkCi33OXUoGo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-4SYgWshhOUyDFYzlh0O_WQ-1; Sun, 08 Oct 2023 02:21:00 -0400
X-MC-Unique: 4SYgWshhOUyDFYzlh0O_WQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9b98d8f6bafso291371466b.1
 for <virtualization@lists.linux-foundation.org>;
 Sat, 07 Oct 2023 23:20:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696746059; x=1697350859;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZKDLVNxVS0wQgCZnWdWwS5zdRpPBL6HalxkdKXdcEh4=;
 b=n4msXV9SOfsAdZMf4sPzb38j5/Iq9CtBg8iC5QxLOaYBaKpZ6SlLX1PMe/ImONM+ry
 35omwyO6LWUCnwSQtYW5hzh0IUDU4rraK++jSg0xknp+OjbBYILMu9QUZtqLTA3WaG5w
 lIQ/lihOjuf8sx4Ehu5dmGTmqxOq6Ab5vkjlbZ+BFpurcB2kkig8PQUWCoFNMyl+SOOi
 HGtuhr8GdP6ifUOxkmHSLH3/oe5iPWclVuazBBFAAvwVFYRokoDvCor66+Mg7UgLgta5
 RkDXOPI+AHTssLwwWpZ4BWYmdPTfjMOuTvvGV69lwdWQIqY7RZdSYvPBqFNp+kBtXvhH
 LbnQ==
X-Gm-Message-State: AOJu0Yz/1tmvT1+Clldafu1qF5gDS9sdbPww2YFh2/ujTwY46rdVPN4B
 RrgDSi6wq2vOq0s27Bm2Y6Nrm26ZfdceXFtK9Wd0xpU4LE+woNSS67FIyI6PXAgoH1dMnhhrf7B
 q/flTxh6B1F45+KsKK/R2FwF6FdD+pRY8KMr0qEsS0Q==
X-Received: by 2002:a17:906:30cc:b0:9a1:c447:3c62 with SMTP id
 b12-20020a17090630cc00b009a1c4473c62mr10678225ejb.49.1696746059021; 
 Sat, 07 Oct 2023 23:20:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpvMnKszWWkkwnrbOuBpbfloweqFCsNJDHdJxFmnTAiCFUad0nFa5rNSeZrN5P/IlhovO8GA==
X-Received: by 2002:a17:906:30cc:b0:9a1:c447:3c62 with SMTP id
 b12-20020a17090630cc00b009a1c4473c62mr10678213ejb.49.1696746058722; 
 Sat, 07 Oct 2023 23:20:58 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:d74e:e6b1:da81:860a:5e9e])
 by smtp.gmail.com with ESMTPSA id
 s10-20020a170906354a00b00997cce73cc7sm5122922eja.29.2023.10.07.23.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 23:20:58 -0700 (PDT)
Date: Sun, 8 Oct 2023 02:20:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] vduse: make vduse_class constant
Message-ID: <20231008022022-mutt-send-email-mst@kernel.org>
References: <2023100643-tricolor-citizen-6c2d@gregkh>
MIME-Version: 1.0
In-Reply-To: <2023100643-tricolor-citizen-6c2d@gregkh>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Xie Yongji <xieyongji@bytedance.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Fri, Oct 06, 2023 at 04:30:44PM +0200, Greg Kroah-Hartman wrote:
> Now that the driver core allows for struct class to be in read-only
> memory, we should make all 'class' structures declared at build time
> placing them into read-only memory, instead of having to be dynamically
> allocated at runtime.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Cc: Xie Yongji <xieyongji@bytedance.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Greg should I merge it or do you intend to merge all these patches?

> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 40 ++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index df7869537ef1..0ddd4b8abecb 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -134,7 +134,6 @@ static DEFINE_MUTEX(vduse_lock);
>  static DEFINE_IDR(vduse_idr);
>  
>  static dev_t vduse_major;
> -static struct class *vduse_class;
>  static struct cdev vduse_ctrl_cdev;
>  static struct cdev vduse_cdev;
>  static struct workqueue_struct *vduse_irq_wq;
> @@ -1528,6 +1527,16 @@ static const struct kobj_type vq_type = {
>  	.default_groups	= vq_groups,
>  };
>  
> +static char *vduse_devnode(const struct device *dev, umode_t *mode)
> +{
> +	return kasprintf(GFP_KERNEL, "vduse/%s", dev_name(dev));
> +}
> +
> +static const struct class vduse_class = {
> +	.name = "vduse",
> +	.devnode = vduse_devnode,
> +};
> +
>  static void vduse_dev_deinit_vqs(struct vduse_dev *dev)
>  {
>  	int i;
> @@ -1638,7 +1647,7 @@ static int vduse_destroy_dev(char *name)
>  	mutex_unlock(&dev->lock);
>  
>  	vduse_dev_reset(dev);
> -	device_destroy(vduse_class, MKDEV(MAJOR(vduse_major), dev->minor));
> +	device_destroy(&vduse_class, MKDEV(MAJOR(vduse_major), dev->minor));
>  	idr_remove(&vduse_idr, dev->minor);
>  	kvfree(dev->config);
>  	vduse_dev_deinit_vqs(dev);
> @@ -1805,7 +1814,7 @@ static int vduse_create_dev(struct vduse_dev_config *config,
>  
>  	dev->minor = ret;
>  	dev->msg_timeout = VDUSE_MSG_DEFAULT_TIMEOUT;
> -	dev->dev = device_create_with_groups(vduse_class, NULL,
> +	dev->dev = device_create_with_groups(&vduse_class, NULL,
>  				MKDEV(MAJOR(vduse_major), dev->minor),
>  				dev, vduse_dev_groups, "%s", config->name);
>  	if (IS_ERR(dev->dev)) {
> @@ -1821,7 +1830,7 @@ static int vduse_create_dev(struct vduse_dev_config *config,
>  
>  	return 0;
>  err_vqs:
> -	device_destroy(vduse_class, MKDEV(MAJOR(vduse_major), dev->minor));
> +	device_destroy(&vduse_class, MKDEV(MAJOR(vduse_major), dev->minor));
>  err_dev:
>  	idr_remove(&vduse_idr, dev->minor);
>  err_idr:
> @@ -1934,11 +1943,6 @@ static const struct file_operations vduse_ctrl_fops = {
>  	.llseek		= noop_llseek,
>  };
>  
> -static char *vduse_devnode(const struct device *dev, umode_t *mode)
> -{
> -	return kasprintf(GFP_KERNEL, "vduse/%s", dev_name(dev));
> -}
> -
>  struct vduse_mgmt_dev {
>  	struct vdpa_mgmt_dev mgmt_dev;
>  	struct device dev;
> @@ -2082,11 +2086,9 @@ static int vduse_init(void)
>  	int ret;
>  	struct device *dev;
>  
> -	vduse_class = class_create("vduse");
> -	if (IS_ERR(vduse_class))
> -		return PTR_ERR(vduse_class);
> -
> -	vduse_class->devnode = vduse_devnode;
> +	ret = class_register(&vduse_class);
> +	if (ret)
> +		return ret;
>  
>  	ret = alloc_chrdev_region(&vduse_major, 0, VDUSE_DEV_MAX, "vduse");
>  	if (ret)
> @@ -2099,7 +2101,7 @@ static int vduse_init(void)
>  	if (ret)
>  		goto err_ctrl_cdev;
>  
> -	dev = device_create(vduse_class, NULL, vduse_major, NULL, "control");
> +	dev = device_create(&vduse_class, NULL, vduse_major, NULL, "control");
>  	if (IS_ERR(dev)) {
>  		ret = PTR_ERR(dev);
>  		goto err_device;
> @@ -2141,13 +2143,13 @@ static int vduse_init(void)
>  err_wq:
>  	cdev_del(&vduse_cdev);
>  err_cdev:
> -	device_destroy(vduse_class, vduse_major);
> +	device_destroy(&vduse_class, vduse_major);
>  err_device:
>  	cdev_del(&vduse_ctrl_cdev);
>  err_ctrl_cdev:
>  	unregister_chrdev_region(vduse_major, VDUSE_DEV_MAX);
>  err_chardev_region:
> -	class_destroy(vduse_class);
> +	class_unregister(&vduse_class);
>  	return ret;
>  }
>  module_init(vduse_init);
> @@ -2159,10 +2161,10 @@ static void vduse_exit(void)
>  	destroy_workqueue(vduse_irq_bound_wq);
>  	destroy_workqueue(vduse_irq_wq);
>  	cdev_del(&vduse_cdev);
> -	device_destroy(vduse_class, vduse_major);
> +	device_destroy(&vduse_class, vduse_major);
>  	cdev_del(&vduse_ctrl_cdev);
>  	unregister_chrdev_region(vduse_major, VDUSE_DEV_MAX);
> -	class_destroy(vduse_class);
> +	class_unregister(&vduse_class);
>  }
>  module_exit(vduse_exit);
>  
> -- 
> 2.42.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
