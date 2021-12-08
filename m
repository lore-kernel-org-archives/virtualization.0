Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35681C433F5
	for <virtualization@archiver.kernel.org>; Wed,  8 Dec 2021 03:37:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A45A60EFF;
	Wed,  8 Dec 2021 03:37:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xXRADzOIc98F; Wed,  8 Dec 2021 03:37:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 43F4E60EE5;
	Wed,  8 Dec 2021 03:37:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 188FDC001E;
	Wed,  8 Dec 2021 03:37:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B310CC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 03:37:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 81BBF41D97
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 03:37:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1XrQrK4f5Leq
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 03:37:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AC27B41D94
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 03:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638934660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YoWCBDATnCTqCRKDv0jegkvjLSP1FmG7gIBbLloAqMw=;
 b=OBaq6pa5KP0QplCxKWC1C7rDcORh65MEzgbUKigL89Y2GyPQq3r7xedTuu/YFx4jO+FhXy
 cpfDqTcQV5ORK9BwOqSIGQ8Q8ednNMs05XO0yUQeFr3NC4X8maOhpNefRS1/4kLPUNc7dF
 94wfpaxte2QOj4BWq/JRgQopxiYb7es=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-536-IeuPdhTNNKiC__j0HEcq1Q-1; Tue, 07 Dec 2021 22:37:39 -0500
X-MC-Unique: IeuPdhTNNKiC__j0HEcq1Q-1
Received: by mail-lf1-f69.google.com with SMTP id
 u20-20020a056512129400b0040373ffc60bso485229lfs.15
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Dec 2021 19:37:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YoWCBDATnCTqCRKDv0jegkvjLSP1FmG7gIBbLloAqMw=;
 b=IpKAUng53WRZqeQ+EuRKP8F1WVRMMGSVhapmY6S0KgmS8HMq0v04riRzmvzUgadgO0
 ZW7N5ojZdk1/tYXxGdH73cxX/R+4VMRfYSjMH8D86L1ROdbkCSJRQf94NumVtoxgdmfM
 fztLWgIdDqzATyeF83jKccdfIsshfdxGJHlCQHGaFEkcfQZbs5IDN01/FE1Y0q7pduUM
 XcHJzoiDKqerHFxMKAu1/CSWmKNk9mgY21UA3kVMzsO2yCC3aQ8t2EoEDJYl9ZcZAdc+
 KFMqtNNmd7XIQvkpFQRmVZFrs8hSRllJNTPSq1sAMctzawmDWr5gvhZGyP0KHqZzj6Oi
 rlVw==
X-Gm-Message-State: AOAM5321rfyc/gpHiaYWQU4satHae16AUALi6c37nRh0wchbs6TsFxvT
 kRnqKBmroGdMFxnZ8qD3BVR2gp1vJ1Kik3/kzElW8EM5Or+7sLSkK1iIBmC+i9pW7tqEwJdcfvR
 obJRGCiLvMJaz8j1MY4LBOJhFn2ye5exCkMvqmcgsincQjPOz8DJiDSXNaQ==
X-Received: by 2002:a2e:3012:: with SMTP id w18mr44874192ljw.217.1638934657819; 
 Tue, 07 Dec 2021 19:37:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxK3AMU73RgafnBq0DfPV3Zj0KlTTUA4HXXX7DBC8jmIm9wvrhyNCZRWXFsBd8QQHihhPOV7qcPksgNfrZSSe8=
X-Received: by 2002:a2e:3012:: with SMTP id w18mr44874174ljw.217.1638934657576; 
 Tue, 07 Dec 2021 19:37:37 -0800 (PST)
MIME-Version: 1.0
References: <20211207130333.GA27606@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20211207130333.GA27606@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 8 Dec 2021 11:37:26 +0800
Message-ID: <CACGkMEsjGF1dv9=__CjXPfeQNjbUwbqu9iY+pm_oCs0ksk23Hw@mail.gmail.com>
Subject: Re: [PATCH] vdpa: Provide means to read configured features
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization <virtualization@lists.linux-foundation.org>
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

On Tue, Dec 7, 2021 at 9:03 PM Eli Cohen <elic@nvidia.com> wrote:
>
> Hi Jason,
>
> I noticed the lack of interface to get the currently configured
> features.
>
> Does the below patch make sense to you? If so I can post it along with
> a patch that implements the function for all current vdpa drivers.

Yes.

>
>
>
> Current code relys on features published by the uplink driver to build
> configuration information. These features are not necessarily the
> configured features.
>
> Introduce a callback to provide the configured features.
>
> Fixes: ad69dd0bf26b ("vdpa: Introduce query of device config layout")
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>  drivers/vdpa/vdpa.c  | 4 +++-
>  include/linux/vdpa.h | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 7332a74a4b00..41486c6bce2f 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -733,8 +733,10 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
>         if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, val_u16))
>                 return -EMSGSIZE;
>
> -       features = vdev->config->get_features(vdev);
> +       if (!vdev->config->get_cur_features)
> +               return -EOPNOTSUPP;
>
> +       features = vdev->config->get_cur_features(vdev);

To be aligned with the virito spec, I think we need name it as

get_driver_features(), and while at it, rename

1) set_features() to set_driver_features()
and
2) get_features() to get_device_features()

Thanks

>         return vdpa_dev_net_mq_config_fill(vdev, msg, features, &config);
>  }
>
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index c3011ccda430..daf22aed1006 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -278,6 +278,7 @@ struct vdpa_config_ops {
>         u32 (*get_vq_align)(struct vdpa_device *vdev);
>         u64 (*get_features)(struct vdpa_device *vdev);
>         int (*set_features)(struct vdpa_device *vdev, u64 features);
> +       u64 (*get_cur_features)(struct vdpa_device *vdev);
>         void (*set_config_cb)(struct vdpa_device *vdev,
>                               struct vdpa_callback *cb);
>         u16 (*get_vq_num_max)(struct vdpa_device *vdev);
> --
> 2.32.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
