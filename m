Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B8DC433FE
	for <virtualization@archiver.kernel.org>; Mon, 17 Oct 2022 07:20:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD76160BF3;
	Mon, 17 Oct 2022 07:20:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CD76160BF3
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WW7PCHWu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QIm6PdIcioTa; Mon, 17 Oct 2022 07:20:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5173260B0D;
	Mon, 17 Oct 2022 07:20:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5173260B0D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24C0DC0032;
	Mon, 17 Oct 2022 07:20:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75747C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 07:20:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 42C4B4053F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 07:20:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 42C4B4053F
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WW7PCHWu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rbQdaGkgX8mZ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 07:20:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7B25A404B7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7B25A404B7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 07:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665991242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hsGcrP50TYPO3b2/AKgfaqv4Nux/KOvfLKE2zsadfi8=;
 b=WW7PCHWufit5BqLefQNGmiztMiZFKXpAekn9NKCB2pM+s1RPBONzqI9xIOBs2QkvCS9Gzn
 6AZrF3YwS8oqX0ZfJ7MQJD+wBFMYIYxjaSJ6XvrewAEUvbXpDeh2oaxkqH+CcnmTDJXK+j
 Mwgqlk82v41EukxmO3Reh/trYiyy1dg=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-528-K31nlzKLNVWwyQgoVvySTg-1; Mon, 17 Oct 2022 03:20:41 -0400
X-MC-Unique: K31nlzKLNVWwyQgoVvySTg-1
Received: by mail-ot1-f72.google.com with SMTP id
 t3-20020a9d66c3000000b0066198cb63e6so4661955otm.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 00:20:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hsGcrP50TYPO3b2/AKgfaqv4Nux/KOvfLKE2zsadfi8=;
 b=kkFhGbPifrl4FQyYLprFSy6/XwLvUk8X0AsIRUNVMJpqRTxVkPTx4RzvfgAe1ML+fp
 cVpdO4OcoKRI5IRJYQ3TgSwa2h0vYLi1Le5R1ZQWjYYt8y939fUxJYNvvF5Ji777EuSn
 Fqbr4l3GY6QKYIPUSpWnaIKFa3aRYvjPUiPyu4FzoCYqq8v/WaYND8LL7vIscFXDeFZR
 UTPRuInJORhBATd4Zvf4AR80HiN8oTP0VJjJActHMPhcS7g2gWS/ygL885Fsi0mA/ivy
 yRGS7JTdkdzdCI2pwzxqNCJ2RCyd6KaqXq9eXEXIs4EXnN1LYR+kyTbt//GOBTYOnjVt
 1xPw==
X-Gm-Message-State: ACrzQf1zyNFm7rbg7D+REqyRvW/F5zQnEPUeHrfiyISYnEVJr7/mRo6b
 z9k+Ax2vpc6azmQOjTl15qdNsouDn1VnEFqFi34L5pirg+2f8v1GE3Qxfc7IwNbhKk7Vo8mIh8b
 U2upl3Fdf/Xuys9/qK/WeC6n5xzYc+fEwBYpngTcefgrwNV2C/Y1KlmyGtQ==
X-Received: by 2002:a05:6808:1483:b0:354:a36e:5b with SMTP id
 e3-20020a056808148300b00354a36e005bmr12284325oiw.35.1665991240473; 
 Mon, 17 Oct 2022 00:20:40 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM58mRvu7KgyI4qNuUJwTjzwfY5UtfYRHDAsJEw77bEOpllMcKvncV9ryXI0Z3tkYgl0chP5DimScyvb/8+GUkE=
X-Received: by 2002:a05:6808:1483:b0:354:a36e:5b with SMTP id
 e3-20020a056808148300b00354a36e005bmr12284318oiw.35.1665991240292; Mon, 17
 Oct 2022 00:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1665745877.git.sebastien.boeuf@intel.com>
 <df57ddc44ed8950dc79c63597e3091b1da551959.1665745877.git.sebastien.boeuf@intel.com>
In-Reply-To: <df57ddc44ed8950dc79c63597e3091b1da551959.1665745877.git.sebastien.boeuf@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Oct 2022 15:20:29 +0800
Message-ID: <CACGkMEuAjORDftAYG_N1B7a3rzosw7u2h9L+S1-YvQCWb6ayuw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] vhost-vdpa: Introduce RESUME backend feature bit
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

On Fri, Oct 14, 2022 at 7:15 PM <sebastien.boeuf@intel.com> wrote:
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

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vhost/vdpa.c             | 16 +++++++++++++++-
>  include/uapi/linux/vhost_types.h |  2 ++
>  2 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 166044642fd5..833617d00ef6 100644
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
> @@ -602,11 +610,15 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
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
>                 vhost_set_backend_features(&v->vdev, features);
>                 return 0;
>         }
> @@ -658,6 +670,8 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
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
