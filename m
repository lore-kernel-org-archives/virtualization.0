Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 699F4C54EBD
	for <virtualization@archiver.kernel.org>; Fri, 13 Jan 2023 03:41:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D5DCE40227;
	Fri, 13 Jan 2023 03:41:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D5DCE40227
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=an8w9fMc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cMfd3Q2BGoDV; Fri, 13 Jan 2023 03:41:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5B92F4012D;
	Fri, 13 Jan 2023 03:41:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5B92F4012D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1AA31C0033;
	Fri, 13 Jan 2023 03:41:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83AC5C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Jan 2023 03:41:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5634760BB0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Jan 2023 03:41:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5634760BB0
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=an8w9fMc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H20IXk5Cxf2y
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Jan 2023 03:41:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 78BD460B51
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 78BD460B51
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Jan 2023 03:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1673581268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iQ8wi4Br7uO3KhWWeSVPWRGqxXRNQdNc7vx+DzPAcvk=;
 b=an8w9fMcWDDcvviD6PBsl8YEI7bIobYt83J4dLXZM/D5pD6ldn4RnVu0oIVJVz9KT8bMnm
 LPsk98qO7kyt9uFZhl3AX0jO+DJFUEhkEaiubLxfNW7KJxShB0L6ZTNiwfWSXflbH+Fb0N
 zufF0WX6+1nnoNTbVpabLuv9JasMw9o=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-628-PnOllV4nMeCank2pOc56AA-1; Thu, 12 Jan 2023 22:41:06 -0500
X-MC-Unique: PnOllV4nMeCank2pOc56AA-1
Received: by mail-ot1-f70.google.com with SMTP id
 e8-20020a9d63c8000000b006704cedcfe2so10077593otl.19
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Jan 2023 19:41:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iQ8wi4Br7uO3KhWWeSVPWRGqxXRNQdNc7vx+DzPAcvk=;
 b=DZa13Gy4ay5A37HGP7G91a8EFPuuf/9rEmP9mPK8YxE3fhykvx4zGPhiFeecPRD2n+
 CTAmVXCbBsbDY4owdhjkWf4UdLexew9ZNm7sf+a4Wu8ITTOUOmhcjT57DjqH7ts1mRv8
 OpUWR4T69wBPi4ElJHyfJ+/gQpu5/dxUlKszGHnuGwocG501gzBnC4Vnx7mLCmA3qjF3
 xkq+fjYqEcjuhOLLXISmIYkPDlz3DUHvu4Xves7qWmDwKxv38NuckV+MWkjQtLd0FVeD
 83v6tXvb+8Jz03hEuGSI56/RtemVJNKfQsP0/UAHRNBhv8SVmi1AI5KbpuFybRvHBrFW
 UASA==
X-Gm-Message-State: AFqh2kpBNqijM2puQGFlkzcDXAvxUkaiembL15k4QnaBliSuh4/9BoYm
 KFMhdf5bpr5cBjxHzm2ypu9G58kbhsyNP/tQBDnqt3n/MHFqdOmCbxEzjMDEMtaXwDDzDpuUxIS
 Z8hH4uW05/UD8kHxOa9w8QpCDdxBuUm8OoLDxSSQxAc6LXH15GpeyjktrBg==
X-Received: by 2002:a05:6870:4413:b0:144:a97b:1ae2 with SMTP id
 u19-20020a056870441300b00144a97b1ae2mr4410758oah.35.1673581265476; 
 Thu, 12 Jan 2023 19:41:05 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsF+gJUbjz/TTiPs9CWR0x7xWMlld1YGa7Vm9251XsEtRPdbMJjqMpS4KIad2giINIz1682V0KhtLR/ewFMee4=
X-Received: by 2002:a05:6870:4413:b0:144:a97b:1ae2 with SMTP id
 u19-20020a056870441300b00144a97b1ae2mr4410753oah.35.1673581265229; Thu, 12
 Jan 2023 19:41:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1672742878.git.sebastien.boeuf@intel.com>
 <15a4566826033c5dd9a2167e5cfb0ef4d90cea49.1672742878.git.sebastien.boeuf@intel.com>
In-Reply-To: <15a4566826033c5dd9a2167e5cfb0ef4d90cea49.1672742878.git.sebastien.boeuf@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Jan 2023 11:40:54 +0800
Message-ID: <CACGkMEueTbLbxtZCBXC3jyqn40nqU4ODgAfzG=GzOLeMjnNwPg@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] vdpa_sim: Implement resume vdpa op
To: sebastien.boeuf@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: eperezma@redhat.com, mst@redhat.com, linux-kernel@vger.kernel.org,
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

On Tue, Jan 3, 2023 at 6:51 PM <sebastien.boeuf@intel.com> wrote:
>
> From: Sebastien Boeuf <sebastien.boeuf@intel.com>
>
> Implement resume operation for vdpa_sim devices, so vhost-vdpa will
> offer that backend feature and userspace can effectively resume the
> device.
>
> Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 29 +++++++++++++++++++++++++++++
>  drivers/vdpa/vdpa_sim/vdpa_sim.h |  1 +
>  2 files changed, 30 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index b071f0d842fb..756a5db0109c 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -357,6 +357,12 @@ static void vdpasim_kick_vq(struct vdpa_device *vdpa, u16 idx)
>         struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>         struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
>
> +       if (!vdpasim->running &&
> +           (vdpasim->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
> +               vdpasim->pending_kick = true;
> +               return;
> +       }
> +
>         if (vq->ready)
>                 schedule_work(&vdpasim->work);
>  }
> @@ -527,6 +533,27 @@ static int vdpasim_suspend(struct vdpa_device *vdpa)
>         return 0;
>  }
>
> +static int vdpasim_resume(struct vdpa_device *vdpa)
> +{
> +       struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> +       int i;
> +
> +       spin_lock(&vdpasim->lock);
> +       vdpasim->running = true;
> +
> +       if (vdpasim->pending_kick) {
> +               /* Process pending descriptors */
> +               for (i = 0; i < vdpasim->dev_attr.nvqs; ++i)
> +                       vdpasim_kick_vq(vdpa, i);
> +
> +               vdpasim->pending_kick = false;
> +       }
> +
> +       spin_unlock(&vdpasim->lock);
> +
> +       return 0;
> +}
> +
>  static size_t vdpasim_get_config_size(struct vdpa_device *vdpa)
>  {
>         struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> @@ -717,6 +744,7 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
>         .set_status             = vdpasim_set_status,
>         .reset                  = vdpasim_reset,
>         .suspend                = vdpasim_suspend,
> +       .resume                 = vdpasim_resume,
>         .get_config_size        = vdpasim_get_config_size,
>         .get_config             = vdpasim_get_config,
>         .set_config             = vdpasim_set_config,
> @@ -750,6 +778,7 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
>         .set_status             = vdpasim_set_status,
>         .reset                  = vdpasim_reset,
>         .suspend                = vdpasim_suspend,
> +       .resume                 = vdpasim_resume,
>         .get_config_size        = vdpasim_get_config_size,
>         .get_config             = vdpasim_get_config,
>         .set_config             = vdpasim_set_config,
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> index 0e78737dcc16..a745605589e2 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> @@ -67,6 +67,7 @@ struct vdpasim {
>         u64 features;
>         u32 groups;
>         bool running;
> +       bool pending_kick;
>         /* spinlock to synchronize iommu table */
>         spinlock_t iommu_lock;
>  };
> --
> 2.37.2
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
