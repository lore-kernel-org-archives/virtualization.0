Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C87C433EF
	for <virtualization@archiver.kernel.org>; Tue,  4 Jan 2022 03:44:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A9A2D404C1;
	Tue,  4 Jan 2022 03:44:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id skuTiiirvltu; Tue,  4 Jan 2022 03:44:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0E4D6400BA;
	Tue,  4 Jan 2022 03:44:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3127C0030;
	Tue,  4 Jan 2022 03:44:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8DD94C001E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 03:44:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6131640912
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 03:44:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j5zIniuG7-2m
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 03:44:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 66F0740911
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 03:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641267871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U3bRp9PDw2PtdlQN7RsHKxoF/g+6HtYTrwOQVxpYpkg=;
 b=ZwxUHKKb2F6pgBQ3ZEvi6AO71Jt+QbELs1000fg/nLYDuIxfF0JDh7MttuDvQz5iTR/t3A
 hIlFIME+tz6MpE+My5vZ3rSI8dzNGhERzY3jCHbGScFZCBwVUG38TxP8LKxGMrskI6VCJz
 d5NEc0bsbNKDntgz3+/8jzN53okTi3E=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-465-l7IkmwsAPHOkG2_Xb18EMA-1; Mon, 03 Jan 2022 22:44:22 -0500
X-MC-Unique: l7IkmwsAPHOkG2_Xb18EMA-1
Received: by mail-lj1-f200.google.com with SMTP id
 b20-20020a2e9894000000b0022dc5a5f841so8537477ljj.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Jan 2022 19:44:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=U3bRp9PDw2PtdlQN7RsHKxoF/g+6HtYTrwOQVxpYpkg=;
 b=g/TwMZk9OWjYqOaotsreelnqAgC8FzlS4nBMwbAYAl5IbQp++oA2EQaPoqcbYWJjlQ
 NUR8JryRwbEIrdBL7EugtYpxQWSPWIIy34eJv1v4yYS6BEw8FXC14hvtuRpLFNe3J2VD
 H/Cl1sY1sPsi27OIXyIN/aD8BSk8Rzx07ItYGIBwBjYuh2+p0DZIL1eq5fIUKr0zRJSa
 UqVsp1lffsXnCNlKGq4ARwudUSehu7LardmM40sl+3ObWTuPqcSEPVwMUIrfTWqPk84Y
 OIGZjMy700CtkZyOTbM+dKl0M14Difyeq62wJBDlMrz7yeMx5TzQ+q58nKmySNJLZsNm
 a5Sg==
X-Gm-Message-State: AOAM530b0aH1LD8fNMg2qROVOXAR2r1M4Ae175JOXgRVxUUAhIOy6ntp
 VHAtKF5Zqk5lkrBmbDzGaQm+PYwoWgrLc9qbGEQE+Bx6IifopFGIcgBKBcKQ4OiUDDJoaftPOoE
 BVFfS+vKuL53jhBlyrnRc9ILmw08NGIbgALnAZoTDqnYATF5FDtn++mirEA==
X-Received: by 2002:a05:6512:22d6:: with SMTP id
 g22mr42525575lfu.199.1641267861278; 
 Mon, 03 Jan 2022 19:44:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwPfKa8UYDWk8yXRh/Tynib8SG3CWPXUC55CynDHAaf3IrbQwAAOOMAqfKLA5ICJGqVqiZgR88MAce8maqcssc=
X-Received: by 2002:a05:6512:22d6:: with SMTP id
 g22mr42525557lfu.199.1641267861109; 
 Mon, 03 Jan 2022 19:44:21 -0800 (PST)
MIME-Version: 1.0
References: <20211224070404.54840-1-wang.yi59@zte.com.cn>
In-Reply-To: <20211224070404.54840-1-wang.yi59@zte.com.cn>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 4 Jan 2022 11:44:10 +0800
Message-ID: <CACGkMEvdKATVvLVQtfPfSeev83Ajskg4gFoHDhWT7wrWEQ3FEA@mail.gmail.com>
Subject: Re: [PATCH v2] vdpa: regist vhost-vdpa dev class
To: Yi Wang <wang.yi59@zte.com.cn>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Zhang Min <zhang.min9@zte.com.cn>, wang.liang82@zte.com.cn,
 kvm <kvm@vger.kernel.org>, mst <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Dec 24, 2021 at 3:13 PM Yi Wang <wang.yi59@zte.com.cn> wrote:
>
> From: Zhang Min <zhang.min9@zte.com.cn>
>
> Some applications like kata-containers need to acquire MAJOR/MINOR/DEVNAME
> for devInfo [1], so regist vhost-vdpa dev class to expose uevent.

Hi:

I think we need to be more verbose here e.g:

1) why can't we get major/minor with the current interface
2) what kind of the uevent is required and not supported currently

Thanks

>
> 1. https://github.com/kata-containers/kata-containers/blob/main/src/runtime/virtcontainers/device/config/config.go
>
> Signed-off-by: Zhang Min <zhang.min9@zte.com.cn>
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> ---
> v2: remove redundant vhost_vdpa_class reset and pr_warn, adjust location
>     of *vhost_vdpa_class impl and class_destroy.
>
>  drivers/vhost/vdpa.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index e3c4f059b21a..55e966c508c8 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -53,6 +53,7 @@ struct vhost_vdpa {
>  static DEFINE_IDA(vhost_vdpa_ida);
>
>  static dev_t vhost_vdpa_major;
> +static struct class *vhost_vdpa_class;
>
>  static void handle_vq_kick(struct vhost_work *work)
>  {
> @@ -1140,6 +1141,7 @@ static int vhost_vdpa_probe(struct vdpa_device *vdpa)
>         v->dev.release = vhost_vdpa_release_dev;
>         v->dev.parent = &vdpa->dev;
>         v->dev.devt = MKDEV(MAJOR(vhost_vdpa_major), minor);
> +       v->dev.class = vhost_vdpa_class;
>         v->vqs = kmalloc_array(v->nvqs, sizeof(struct vhost_virtqueue),
>                                GFP_KERNEL);
>         if (!v->vqs) {
> @@ -1197,6 +1199,10 @@ static int __init vhost_vdpa_init(void)
>  {
>         int r;
>
> +       vhost_vdpa_class = class_create(THIS_MODULE, "vhost-vdpa");
> +       if (IS_ERR(vhost_vdpa_class))
> +               return PTR_ERR(vhost_vdpa_class);
> +
>         r = alloc_chrdev_region(&vhost_vdpa_major, 0, VHOST_VDPA_DEV_MAX,
>                                 "vhost-vdpa");
>         if (r)
> @@ -1211,6 +1217,7 @@ static int __init vhost_vdpa_init(void)
>  err_vdpa_register_driver:
>         unregister_chrdev_region(vhost_vdpa_major, VHOST_VDPA_DEV_MAX);
>  err_alloc_chrdev:
> +       class_destroy(vhost_vdpa_class);
>         return r;
>  }
>  module_init(vhost_vdpa_init);
> @@ -1219,6 +1226,7 @@ static void __exit vhost_vdpa_exit(void)
>  {
>         vdpa_unregister_driver(&vhost_vdpa_driver);
>         unregister_chrdev_region(vhost_vdpa_major, VHOST_VDPA_DEV_MAX);
> +       class_destroy(vhost_vdpa_class);
>  }
>  module_exit(vhost_vdpa_exit);
>
> --
> 2.27.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
