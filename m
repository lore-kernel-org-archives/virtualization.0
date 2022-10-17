Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64BAC433FE
	for <virtualization@archiver.kernel.org>; Mon, 17 Oct 2022 07:22:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5C96A409F3;
	Mon, 17 Oct 2022 07:22:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5C96A409F3
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NMKjuwVS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XRgk2qwIc3oO; Mon, 17 Oct 2022 07:22:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D5C70404B7;
	Mon, 17 Oct 2022 07:22:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D5C70404B7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A197DC0032;
	Mon, 17 Oct 2022 07:22:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00ECBC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 07:22:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B4B7B4053F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 07:22:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B4B7B4053F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OtnKZ1xZm-MV
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 07:22:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 05487404B7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 05487404B7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 07:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665991363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VuJAeXtgJ0rr0/gCFboiPJbtGT2UQbfo9wNiNDuF4a4=;
 b=NMKjuwVSAxx+4AIvNqLffirtBATyjTBi1Vw7OTXtgcfPL7wEDtld1KP4+V/iFM4vQD/cNz
 jXQZSFlFe5oFEpsrDiI3yt1hBT+Q3XDt0pynb74+sQHmdqknUCpunV7pET5YtfUSa5jqMe
 vbVaf41ZtjtInqMbZN4mg9lOv/bEpgM=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-605-YMPtc-kBOImh7bO7qumAHg-1; Mon, 17 Oct 2022 03:22:41 -0400
X-MC-Unique: YMPtc-kBOImh7bO7qumAHg-1
Received: by mail-ot1-f71.google.com with SMTP id
 a22-20020a0568300b9600b0065c0cef3662so4688227otv.14
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 00:22:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VuJAeXtgJ0rr0/gCFboiPJbtGT2UQbfo9wNiNDuF4a4=;
 b=Tp98heRG+P1MMMF/rk+bT72F2ZzYmMQEUHrcWy1RemFObBUpZaw+ATfxt+Fi/FPVSh
 ld/ottlPggID0Nay4ZBbp4mTfTCzLautGJgFIl809nFYRq9JPl12CaSCQmU9y97h3NJV
 wh91l6AkoAalPPBlIayxpB3PYCvPjEqFVzOTq4siaJWqOfuwRTWpvJrR0aPzJ0fM8zdX
 W24X/iCJ3XiVOp8Fg4E+Xw87EbX+7HGWFY3lf9v6AstqF5FjnSG19prq1Q6gaH8bJR6w
 k+Uh2ySHNmpgzu+3+o8Je8yZbe568GtWJ2EpWY+lR3ZeKsmXjP7TgpzdI4nJCQNDYzPD
 7sgA==
X-Gm-Message-State: ACrzQf1jylQplRHoYl8mO1zzbKKaCeR1NdWrjhZk+JMCi35aLVxCGjMZ
 rtf/wyDi0xZbe6SoZVPvA6xzDp7Nb5ay6Ys2nJr0Rm/kE0WLbgwnMbrZ5nHEwIUYd1ehSZIH7fS
 8Hq9e/rS2WGdLkP3gYOdnmKcMekINgsoAd4vjP+ZVB5Yp0sadawPM6Ns2Rw==
X-Received: by 2002:a05:6870:c1d3:b0:136:c4f6:53af with SMTP id
 i19-20020a056870c1d300b00136c4f653afmr14263569oad.35.1665991361277; 
 Mon, 17 Oct 2022 00:22:41 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6PyOLxQAjEg6vnJIyyw9uNqXV1z/MBF8z/VUuDoQcaX6mkGohhFTfnAAWcn21cmwQfHg1SDWZEGF+SiXLtzrM=
X-Received: by 2002:a05:6870:c1d3:b0:136:c4f6:53af with SMTP id
 i19-20020a056870c1d300b00136c4f653afmr14263561oad.35.1665991361078; Mon, 17
 Oct 2022 00:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1665745877.git.sebastien.boeuf@intel.com>
 <d23b16abdc15f5e2aa1430cf48101dd256638809.1665745877.git.sebastien.boeuf@intel.com>
In-Reply-To: <d23b16abdc15f5e2aa1430cf48101dd256638809.1665745877.git.sebastien.boeuf@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Oct 2022 15:22:29 +0800
Message-ID: <CACGkMEv48juaqvNx04wfuc0JeKp31rUaHVCEspBq7HvFXSZBLg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] vhost-vdpa: uAPI to resume the device
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
> This new ioctl adds support for resuming the device from userspace.
>
> This is required when trying to restore the device in a functioning
> state after it's been suspended. It is already possible to reset a
> suspended device,

Nit: And should we allow resume a non suspended device? Do we need to
document this requirement somewhere?

> but that means the device must be reconfigured and
> all the IOMMU/IOTLB mappings must be recreated. This new operation
> allows the device to be resumed without going through a full reset.
>
> This is particularly useful when trying to perform offline migration of
> a virtual machine (also known as snapshot/restore) as it allows the VMM
> to resume the virtual machine back to a running state after the snapshot
> is performed.
>
> Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vhost/vdpa.c       | 18 ++++++++++++++++++
>  include/uapi/linux/vhost.h |  8 ++++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 833617d00ef6..1db7bd39fb63 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -502,6 +502,21 @@ static long vhost_vdpa_suspend(struct vhost_vdpa *v)
>         return ops->suspend(vdpa);
>  }
>
> +/* After a successful return of this ioctl the device resumes processing
> + * virtqueue descriptors. The device becomes fully operational the same way it
> + * was before it was suspended.
> + */
> +static long vhost_vdpa_resume(struct vhost_vdpa *v)
> +{
> +       struct vdpa_device *vdpa = v->vdpa;
> +       const struct vdpa_config_ops *ops = vdpa->config;
> +
> +       if (!ops->resume)
> +               return -EOPNOTSUPP;
> +
> +       return ops->resume(vdpa);
> +}
> +
>  static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
>                                    void __user *argp)
>  {
> @@ -687,6 +702,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
>         case VHOST_VDPA_SUSPEND:
>                 r = vhost_vdpa_suspend(v);
>                 break;
> +       case VHOST_VDPA_RESUME:
> +               r = vhost_vdpa_resume(v);
> +               break;
>         default:
>                 r = vhost_dev_ioctl(&v->vdev, cmd, argp);
>                 if (r == -ENOIOCTLCMD)
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index f9f115a7c75b..92e1b700b51c 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -180,4 +180,12 @@
>   */
>  #define VHOST_VDPA_SUSPEND             _IO(VHOST_VIRTIO, 0x7D)
>
> +/* Resume a device so it can resume processing virtqueue requests
> + *
> + * After the return of this ioctl the device will have restored all the
> + * necessary states and it is fully operational to continue processing the
> + * virtqueue descriptors.
> + */
> +#define VHOST_VDPA_RESUME              _IO(VHOST_VIRTIO, 0x7E)
> +
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
