Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D2BC4332F
	for <virtualization@archiver.kernel.org>; Fri, 14 Oct 2022 05:59:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0E22761215;
	Fri, 14 Oct 2022 05:59:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0E22761215
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Dc3YGMCL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sFT3PMscGe4i; Fri, 14 Oct 2022 05:58:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8EB4160C17;
	Fri, 14 Oct 2022 05:58:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8EB4160C17
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 618DFC0033;
	Fri, 14 Oct 2022 05:58:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38B18C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 05:58:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0D00C813C6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 05:58:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0D00C813C6
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Dc3YGMCL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3ClBgyieRVoh
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 05:58:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C57EE813C3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C57EE813C3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 05:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665727133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ylfU3tJ7g6lm2LcJK5dWt/8W0yJFSvk4zoMYdiaTJqo=;
 b=Dc3YGMCLfNVUVjdeqN/SCqGf2QIwbTYv+oz5As0UpVYTzxyJ4C9m0raS0LVp7ubJTp72Q/
 bALVEOho7AV7AM/XsmrarWYjaOCpSOu6t/OJ7ilTyWoWJJozgb08UboivwdDOmK0Nui96q
 2x1HJFQtyE3Igqpfl5OlDgIK664mS4c=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-16-1S1IIxLENRuqfpEeYsdJKg-1; Fri, 14 Oct 2022 01:58:50 -0400
X-MC-Unique: 1S1IIxLENRuqfpEeYsdJKg-1
Received: by mail-oi1-f199.google.com with SMTP id
 f16-20020a05680814d000b003506268b99fso1725632oiw.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Oct 2022 22:58:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ylfU3tJ7g6lm2LcJK5dWt/8W0yJFSvk4zoMYdiaTJqo=;
 b=CYmhHXAAFzGap3GR3v52xXQcsIXYO39j1etq1tUc1I0K7X/ATXt57bGFAaF6diI/i7
 2+YCIqEskUx9eQO8bGIVfhHoXQ+k8NaxOIfg/HifLF2LnfRoQqMryORZd+49O3i7xFoR
 DXztaUgamIqo7Vq3hE2caLcRRLEKDEtZw+JMDf4poOHK+WzDEZK8nvFUrJgDq9PYAL0g
 y75HcsjfKl7mz5XznmPrV+RF6ytaXaJAmksXUdZOHoMkNxJVDi/rn6lzvalnjyzOzyht
 GnVuwRbNFgE+U6zBbyflIn6BxYlQHTc+wuYh0rKdABBNuB0H4APL4y+ouj7BWAekXh/n
 1HTw==
X-Gm-Message-State: ACrzQf3DqmB1YFtDRLnruiQuWV4A4cjZ0zpH7WWB7vyX0A+8+a1A9g/m
 DTjVTS7TUr5WlatA4Y4YYFLUcCEH0dd9gjYDBstPkNMegN8d4zJ6hh5BOID7f+ShVIu84XzQRsP
 VJAl0+Lcww65NFgvOWaY9FN6vH8UKpZ7crS0FV6FVzGHY+aWCP8ljDwudJQ==
X-Received: by 2002:a05:6870:c1d3:b0:136:c4f6:53af with SMTP id
 i19-20020a056870c1d300b00136c4f653afmr7317038oad.35.1665727129318; 
 Thu, 13 Oct 2022 22:58:49 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6TkAhee2iH/lhhBwFpYMDyXWyeYY1SCFcdjMzExUw6GG6gc4ddyGU6b4vlo2oOGHJVvN9HeoQrU0v7biSS2rI=
X-Received: by 2002:a05:6870:c1d3:b0:136:c4f6:53af with SMTP id
 i19-20020a056870c1d300b00136c4f653afmr7317032oad.35.1665727129063; Thu, 13
 Oct 2022 22:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1665674878.git.sebastien.boeuf@intel.com>
 <72bdc9ae91ca4ed8a2c9ea2aab53f8e04d4512f6.1665674878.git.sebastien.boeuf@intel.com>
In-Reply-To: <72bdc9ae91ca4ed8a2c9ea2aab53f8e04d4512f6.1665674878.git.sebastien.boeuf@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 14 Oct 2022 13:58:38 +0800
Message-ID: <CACGkMEt7cEocQp70MgtwWjb0yNv_08qq-aKp8ZTbFbTkW6hxbw@mail.gmail.com>
Subject: Re: [PATCH 2/4] vhost-vdpa: Introduce RESUME backend feature bit
To: sebastien.boeuf@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: eperezma@redhat.com, mst@redhat.com,
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

On Thu, Oct 13, 2022 at 11:35 PM <sebastien.boeuf@intel.com> wrote:
>
> From: Sebastien Boeuf <sebastien.boeuf@intel.com>
>
> Userspace knows if the device can be resumed or not by checking this
> feature bit.
>
> It's only exposed if the vdpa driver backend implements the resume()
> operation callback. Userspace trying to negotiate this feature when it
> hasn't been exposed will result in an error.
>
> Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> ---
>  drivers/vhost/vdpa.c             | 19 ++++++++++++++++++-
>  include/uapi/linux/vhost_types.h |  2 ++
>  2 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 166044642fd5..161727e1a9a5 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -355,6 +355,14 @@ static bool vhost_vdpa_can_suspend(const struct vhost_vdpa *v)
>         return ops->suspend;
>  }
>
> +static bool vhost_vdpa_can_resume(const struct vhost_vdpa *v)
> +{
> +       struct vdpa_device *vdpa = v->vdpa;
> +       const struct vdpa_config_ops *ops = vdpa->config;
> +
> +       return ops->resume;
> +}
> +
>  static long vhost_vdpa_get_features(struct vhost_vdpa *v, u64 __user *featurep)
>  {
>         struct vdpa_device *vdpa = v->vdpa;
> @@ -602,11 +610,18 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
>                 if (copy_from_user(&features, featurep, sizeof(features)))
>                         return -EFAULT;
>                 if (features & ~(VHOST_VDPA_BACKEND_FEATURES |
> -                                BIT_ULL(VHOST_BACKEND_F_SUSPEND)))
> +                                BIT_ULL(VHOST_BACKEND_F_SUSPEND) |
> +                                BIT_ULL(VHOST_BACKEND_F_RESUME)))
>                         return -EOPNOTSUPP;
>                 if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
>                      !vhost_vdpa_can_suspend(v))
>                         return -EOPNOTSUPP;
> +               if ((features & BIT_ULL(VHOST_BACKEND_F_RESUME)) &&
> +                    !vhost_vdpa_can_resume(v))
> +                       return -EOPNOTSUPP;
> +               if (!(features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
> +                    (features & BIT_ULL(VHOST_BACKEND_F_RESUME)))
> +                       return -EINVAL;

Is it better to do the check during the probe? It should be a bug that
we're having a parent that can only do resume but not suspend.

Thanks

>                 vhost_set_backend_features(&v->vdev, features);
>                 return 0;
>         }
> @@ -658,6 +673,8 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
>                 features = VHOST_VDPA_BACKEND_FEATURES;
>                 if (vhost_vdpa_can_suspend(v))
>                         features |= BIT_ULL(VHOST_BACKEND_F_SUSPEND);
> +               if (vhost_vdpa_can_resume(v))
> +                       features |= BIT_ULL(VHOST_BACKEND_F_RESUME);
>                 if (copy_to_user(featurep, &features, sizeof(features)))
>                         r = -EFAULT;
>                 break;
> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
> index 53601ce2c20a..c5690a8992d8 100644
> --- a/include/uapi/linux/vhost_types.h
> +++ b/include/uapi/linux/vhost_types.h
> @@ -163,5 +163,7 @@ struct vhost_vdpa_iova_range {
>  #define VHOST_BACKEND_F_IOTLB_ASID  0x3
>  /* Device can be suspended */
>  #define VHOST_BACKEND_F_SUSPEND  0x4
> +/* Device can be resumed */
> +#define VHOST_BACKEND_F_RESUME  0x5
>
>  #endif
> --
> 2.34.1
>
> ---------------------------------------------------------------------
> Intel Corporation SAS (French simplified joint stock company)
> Registered headquarters: "Les Montalets"- 2, rue de Paris,
> 92196 Meudon Cedex, France
> Registration Number:  302 456 199 R.C.S. NANTERRE
> Capital: 5 208 026.16 Euros
>
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
