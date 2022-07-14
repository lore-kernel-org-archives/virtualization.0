Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA77C43334
	for <virtualization@archiver.kernel.org>; Thu, 14 Jul 2022 02:51:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC99560BBD;
	Thu, 14 Jul 2022 02:51:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CC99560BBD
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EAtsqmhZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id osneDqFVxxoX; Thu, 14 Jul 2022 02:51:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5E01460B65;
	Thu, 14 Jul 2022 02:51:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5E01460B65
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D9FBC0035;
	Thu, 14 Jul 2022 02:51:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 520E7C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 02:51:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 17A9A4251B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 02:51:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 17A9A4251B
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=EAtsqmhZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9BkQOJWV8Hts
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 02:51:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E2E9C42515
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E2E9C42515
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 02:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657767105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=09XFoPLUL2vtKYhbD0RdYNM/yS165RYVSGN8mkoX2x8=;
 b=EAtsqmhZJEeJUo5u74xD586QmNQPebVje7FLbDV+pj+M+h+NUaYFSiCmBdncsT9/eWq5/m
 +MMqwo42Eqi7e/8FhGPq5gahLXyXIEY6z5k6cMCDA06eLMku+HCKTwmNEVPN7w7osCGO87
 5xoLWrumCdD0nu+/Hs0mWkfpJbP796Y=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-418-oo_gBe3YNfyOe-DfN_bn9Q-1; Wed, 13 Jul 2022 22:51:44 -0400
X-MC-Unique: oo_gBe3YNfyOe-DfN_bn9Q-1
Received: by mail-lf1-f71.google.com with SMTP id
 p36-20020a05651213a400b004779d806c13so198444lfa.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jul 2022 19:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=09XFoPLUL2vtKYhbD0RdYNM/yS165RYVSGN8mkoX2x8=;
 b=dqR7kcaW2XPf+gw0Klgf3GGG3w7L8ngHfZdhKEbP55YPVxtH5mgAbpaopt7Y0QTTKk
 ahZFacr8iBW+4umAuadznnU7BPpZm1y1fyj6zibIhEouJPjlGNAjFCRudkaw6VnOxCEy
 iJNFbn/aNocwZRjqPskic4xHpSHRztOpoFAVBaGr8fcP46JHYr1hSnJUWnJty/ky2teP
 NPZTpDiphDqmF5rei+S00tlS5w8/REavAs3P+op2Xjqv9M6kZORWzjMzZmmUARiOXi8Q
 M9Ip7PDQkubGYa1i3CZoBP26gwRCNGE679awsrwPDiy2Z2LaZXsZHyCT6ztJHdCsgEy3
 a30A==
X-Gm-Message-State: AJIora/mh8rAcdEA5CLot1HnRUJoW0j5ouhkeXMLMXNEM/KS+kSuOfaj
 POsSttAn86WpCLRIDkfhQCojMLgf5gb6GxXXjpjO8sIRH+bHgt9RyQThJhcoYa/RiwG2T4pjTCQ
 FKfRnjBZceuLPxD+HCF0zFAJSadJLTzo/g58f4zIoP1XLBUu4KCwZEdfoxQ==
X-Received: by 2002:a05:6512:3f0f:b0:47f:6f89:326 with SMTP id
 y15-20020a0565123f0f00b0047f6f890326mr3748220lfa.124.1657767103008; 
 Wed, 13 Jul 2022 19:51:43 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uwEhwbheOgz6wTlkIvKB70cHBlkA9GqeMpsrUC6VzNc76tluuIIaOQrAc2oNrGC/DghetpRGLu4EmRz6EZAfQ=
X-Received: by 2002:a05:6512:3f0f:b0:47f:6f89:326 with SMTP id
 y15-20020a0565123f0f00b0047f6f890326mr3748215lfa.124.1657767102800; Wed, 13
 Jul 2022 19:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220706050503.171-1-xieyongji@bytedance.com>
 <20220706050503.171-5-xieyongji@bytedance.com>
In-Reply-To: <20220706050503.171-5-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 14 Jul 2022 10:51:31 +0800
Message-ID: <CACGkMEv9s2WP+Ou5wk2GCBXfD+Pc8CDY2Kz41w7sO8bnkVTc7w@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] vduse: Support querying IOLTB information
To: Xie Yongji <xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst <mst@redhat.com>, Liu Xiaodong <xiaodong.liu@intel.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, songmuchun@bytedance.com
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

On Wed, Jul 6, 2022 at 1:06 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> This introduces a new ioctl: VDUSE_IOTLB_GET_INFO to
> support querying IOLTB information such as bounce
> buffer size.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 13 +++++++++++++
>  include/uapi/linux/vduse.h         | 17 +++++++++++++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 3bc27de58f46..c47a5d9765cf 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1089,6 +1089,19 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>                 ret = vduse_dev_queue_irq_work(dev, &dev->vqs[index].inject);
>                 break;
>         }
> +       case VDUSE_IOTLB_GET_INFO: {

As discussed, it's better not to expose the VDUSE internal structure
like "IOTLB" in the name.

We probably need to extend GET_FD or have a new ioctl like GET_FD_INFO.

Thanks

> +               struct vduse_iotlb_info iotlb;
> +
> +               iotlb.bounce_iova = 0;
> +               iotlb.bounce_size = dev->domain->bounce_size;
> +
> +               ret = -EFAULT;
> +               if (copy_to_user(argp, &iotlb, sizeof(iotlb)))
> +                       break;
> +
> +               ret = 0;
> +               break;
> +       }
>         default:
>                 ret = -ENOIOCTLCMD;
>                 break;
> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> index 7cfe1c1280c0..c201b7a77c2c 100644
> --- a/include/uapi/linux/vduse.h
> +++ b/include/uapi/linux/vduse.h
> @@ -210,6 +210,23 @@ struct vduse_vq_eventfd {
>   */
>  #define VDUSE_VQ_INJECT_IRQ    _IOW(VDUSE_BASE, 0x17, __u32)
>
> +/**
> + * struct vduse_iotlb_info - IOTLB information
> + * @bounce_iova: start IOVA of bounce buffer
> + * @bounce_size: bounce buffer size
> + * @reserved: for future use, needs to be initialized to zero
> + *
> + * Structure used by VDUSE_IOTLB_GET_INFO ioctl to get IOTLB information.
> + */
> +struct vduse_iotlb_info {
> +       __u64 bounce_iova;
> +       __u64 bounce_size;
> +       __u64 reserved[2];
> +};
> +
> +/* Get IOTLB information, e.g. bounce buffer size */
> +#define VDUSE_IOTLB_GET_INFO    _IOR(VDUSE_BASE, 0x18, struct vduse_iotlb_info)
> +
>  /* The control messages definition for read(2)/write(2) on /dev/vduse/$NAME */
>
>  /**
> --
> 2.20.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
