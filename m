Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2620C433EF
	for <virtualization@archiver.kernel.org>; Thu, 23 Dec 2021 11:00:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 644F440630;
	Thu, 23 Dec 2021 11:00:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8pzrlEiYNHJx; Thu, 23 Dec 2021 11:00:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8A95F40145;
	Thu, 23 Dec 2021 11:00:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43248C001E;
	Thu, 23 Dec 2021 11:00:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3BAFBC0012
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 11:00:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 217244055E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 11:00:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7Ep1MDG0Bitb
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 11:00:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 049EE40145
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 10:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1640257198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gi7g+IDEb6WGbto01CYp8T3QI7qHrL20V9bktHYFsUE=;
 b=JmsGLKRIRLON4DB0ucwf+N144AASUEDJm755MUSwcTIMutrn32Fdmgl+P3RSDnWrTTQ1JJ
 MGhy9RShpEjLsr+wxGPONOane1hO2/PCUVv3XOrB6qR/QFnOBhi3Rf7pY8V11TGD2GZ12x
 /8+fTrtGJoJA5Gc6FmGnR3gA1qTW1TQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-6f-KlSe4N36Lg6EbJ-26hw-1; Thu, 23 Dec 2021 05:59:55 -0500
X-MC-Unique: 6f-KlSe4N36Lg6EbJ-26hw-1
Received: by mail-wm1-f70.google.com with SMTP id
 a203-20020a1c7fd4000000b0034574187420so4476466wmd.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 02:59:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Gi7g+IDEb6WGbto01CYp8T3QI7qHrL20V9bktHYFsUE=;
 b=sYdHv2HIPx9oOcdauWO6zcMqSDN7wIvcsFMJhB1haozm9xdZScbGGVqjbWfHlYPO0q
 /HWJiutHjxrWrhzH7NBf1lUUPs//jiARZ1rNIC/BHd8L4MuXARtI5dVFBFdlzKNePdIf
 OZRTtue5zsVtSE83yOkcPIvpxGPhqrCtU5Ix722OKHWYi7b/WbwQsChxILZWDLCrGKFw
 h/QAS6HbdEyIYc/w4kkaKJYaBgzcUcPbdp1ua4Uu0ppGQM/Kbd+Geu/DvVd/4Jgb1WnV
 EJ8rc669sRVFCUQcUsapJ1EdDTEvFi3XB2wTv+UMimFhpJTQI94i/UJ/virzBxUWxCNf
 mmcA==
X-Gm-Message-State: AOAM532wOJPzlBS8O8oAeKgurK+gCSfRfMl2AsowrTgN8+WpCmvooJKY
 1f71nmERFLO8luUJ4D4Lerw0gymGU+3sfS+JH+Zxb/wteJZf2NAl2VE4DG65eqNwei6R99mI8bD
 agly91oljbDp09+GCKB6uieqKNwZqn+MUW5J1tGPUIQ==
X-Received: by 2002:a5d:6944:: with SMTP id r4mr1338208wrw.515.1640257194567; 
 Thu, 23 Dec 2021 02:59:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyiSPvRCS4tIgVXtQ5WPcUTF+53o6QxFaMhWGw4m+5+v/5BVnqxslIxZT8JsIX8wZYXvoGfdw==
X-Received: by 2002:a5d:6944:: with SMTP id r4mr1338194wrw.515.1640257194380; 
 Thu, 23 Dec 2021 02:59:54 -0800 (PST)
Received: from steredhat (host-79-51-11-180.retail.telecomitalia.it.
 [79.51.11.180])
 by smtp.gmail.com with ESMTPSA id p11sm4952547wru.99.2021.12.23.02.59.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Dec 2021 02:59:53 -0800 (PST)
Date: Thu, 23 Dec 2021 11:59:50 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Yi Wang <wang.yi59@zte.com.cn>
Subject: Re: [PATCH] vdpa: regist vhost-vdpa dev class
Message-ID: <20211223105950.ovywoj6v3aooh2v5@steredhat>
References: <20211223073145.35363-1-wang.yi59@zte.com.cn>
MIME-Version: 1.0
In-Reply-To: <20211223073145.35363-1-wang.yi59@zte.com.cn>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Zhang Min <zhang.min9@zte.com.cn>, wang.liang82@zte.com.cn,
 kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 xue.zhihong@zte.com.cn
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Dec 23, 2021 at 03:31:45PM +0800, Yi Wang wrote:
>From: Zhang Min <zhang.min9@zte.com.cn>
>
>Some applications like kata-containers need to acquire MAJOR/MINOR/DEVNAME
>for devInfo [1], so regist vhost-vdpa dev class to expose uevent.
>
>1. https://github.com/kata-containers/kata-containers/blob/main/src/runtime/virtcontainers/device/config/config.go
>
>Signed-off-by: Zhang Min <zhang.min9@zte.com.cn>
>Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
>---
> drivers/vhost/vdpa.c | 12 ++++++++++++
> 1 file changed, 12 insertions(+)
>
>diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>index fb41db3da611..90fbad93e7a2 100644
>--- a/drivers/vhost/vdpa.c
>+++ b/drivers/vhost/vdpa.c
>@@ -1012,6 +1012,7 @@ static void vhost_vdpa_release_dev(struct device *device)
> 	kfree(v);
> }
>
>+static struct class *vhost_vdpa_class;
   ^
Maybe is better to move this declaration on top, near `static dev_t 
vhost_vdpa_major;`

> static int vhost_vdpa_probe(struct vdpa_device *vdpa)
> {
> 	const struct vdpa_config_ops *ops = vdpa->config;
>@@ -1040,6 +1041,7 @@ static int vhost_vdpa_probe(struct vdpa_device *vdpa)
> 	v->dev.release = vhost_vdpa_release_dev;
> 	v->dev.parent = &vdpa->dev;
> 	v->dev.devt = MKDEV(MAJOR(vhost_vdpa_major), minor);
>+	v->dev.class = vhost_vdpa_class;
> 	v->vqs = kmalloc_array(v->nvqs, sizeof(struct vhost_virtqueue),
> 			       GFP_KERNEL);
> 	if (!v->vqs) {
>@@ -1097,6 +1099,14 @@ static int __init vhost_vdpa_init(void)
> {
> 	int r;
>
>+	vhost_vdpa_class = class_create(THIS_MODULE, "vhost-vdpa");
>+	if (IS_ERR(vhost_vdpa_class)) {
>+		r = PTR_ERR(vhost_vdpa_class);
>+		pr_warn("vhost vdpa class create error %d,  maybe mod reinserted\n", r);
                                                           ^
double space.

I'm not a native speaker, but I would rephrase the second part to "maybe 
the module is already loaded"

>+		vhost_vdpa_class = NULL;
>+		return r;
>+	}
>+
> 	r = alloc_chrdev_region(&vhost_vdpa_major, 0, VHOST_VDPA_DEV_MAX,
> 				"vhost-vdpa");
> 	if (r)
>@@ -1111,6 +1121,7 @@ static int __init vhost_vdpa_init(void)
> err_vdpa_register_driver:
> 	unregister_chrdev_region(vhost_vdpa_major, VHOST_VDPA_DEV_MAX);
> err_alloc_chrdev:
>+	class_destroy(vhost_vdpa_class);

Should we set `vhost_vdpa_class` to NULL here?

If yes, maybe better to add a new label, and a goto in the 
`class_create` error handling.

> 	return r;
> }
> module_init(vhost_vdpa_init);
>@@ -1118,6 +1129,7 @@ module_init(vhost_vdpa_init);
> static void __exit vhost_vdpa_exit(void)
> {
> 	vdpa_unregister_driver(&vhost_vdpa_driver);
>+	class_destroy(vhost_vdpa_class);

I would move it after unregister_chrdev_region() to have the reverse 
order of initialization (as we already rightly do in the error path of 
vhost_vdpa_init()).

Thanks,
Stefano

> 	unregister_chrdev_region(vhost_vdpa_major, VHOST_VDPA_DEV_MAX);
> }
> module_exit(vhost_vdpa_exit);
>-- 
>2.27.0
>_______________________________________________
>Virtualization mailing list
>Virtualization@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
