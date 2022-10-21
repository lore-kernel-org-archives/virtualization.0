Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A143C433FE
	for <virtualization@archiver.kernel.org>; Fri, 21 Oct 2022 02:51:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D817041DCB;
	Fri, 21 Oct 2022 02:51:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D817041DCB
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hUrkB/n2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lW-LH1lWNaZl; Fri, 21 Oct 2022 02:51:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C0C6341D8A;
	Fri, 21 Oct 2022 02:51:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C0C6341D8A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93BB2C0032;
	Fri, 21 Oct 2022 02:51:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F350CC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Oct 2022 02:51:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CE0E18415F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Oct 2022 02:51:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CE0E18415F
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hUrkB/n2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mRH7HdjNRfMa
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Oct 2022 02:51:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0184D83F8F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0184D83F8F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Oct 2022 02:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666320685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f8nJsDIhGjL0WmXtL/oaf6x1BSko8WuXhvBUkczAonU=;
 b=hUrkB/n2B7wN4sFoWm5txoxzFXAmA6FiJqjUG71qbEmxztpuTES4JAtaJ5+t1MFMiG1i5M
 jnTTU6TwpKO/IJMOBkcWaOzIg9IJvvVX15MrinJW0jvfdrOptY613UOjAr2pDoQ5qrfsvS
 JH9WAIgKPLbk9QvDsLG5+WixQfm0xWU=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-561-DpAH2GbsMIq7LhHxLCUiJQ-1; Thu, 20 Oct 2022 22:51:24 -0400
X-MC-Unique: DpAH2GbsMIq7LhHxLCUiJQ-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-13aeef5b55aso905736fac.22
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Oct 2022 19:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f8nJsDIhGjL0WmXtL/oaf6x1BSko8WuXhvBUkczAonU=;
 b=NXYXp9rh6DkcOqObyWCcCHoAPzFui5ruGriQYJVddR1Zd2N7bM5HzSZeHD3oVBMASp
 3yyskXOCLw5I8AVQ5Xe2cQkkcmJXRPiJ47brjGRS4B2W8ebOu6k3kjyKLbiweDSDPDkA
 j/MZpnK8i56T8HKyayJS6Ayj6i3KEOsd/hccpV8TJRuBZ7jhQCLY0s8sp4PFyEuaoJ99
 4y7WDJcqVZbie5CCFN6AbiGwjEh4QZupbpt0F+INEHMgUreVoC87lcFHcmZKjrMBZLlR
 YCWt2csH24KAejJr6LF8pDWFm01EDJ00NW7uVqy/qG57+4bsS5xi7D7y3STfoxgMkTrp
 h6wA==
X-Gm-Message-State: ACrzQf1uL54UAp/w2rZOMyT1fYpWpKIINHuI0qHsb9sGoHtuRCWAvbj4
 2/nUQlc4SvvzCOXqICPIKw/in12A29/fg6d4lRl/79rTQW2PhUKXt15WkYg/dla6L8SurdsugUa
 5QuOlcf/w3Npsz92Qd2L+RD7x4aNoq+Lwe4E+i8e5Y2JMje7xkn0CY+TGPA==
X-Received: by 2002:a05:6808:1483:b0:354:a36e:5b with SMTP id
 e3-20020a056808148300b00354a36e005bmr22695041oiw.35.1666320683355; 
 Thu, 20 Oct 2022 19:51:23 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6jXx55f2XoCzq7zsnbn1o7BGBzsS+7s+2DhVS/SZHXKqbXS+XjLnpm/P3QxGseqXrw+RPvZ5VhyW6y7unxjaw=
X-Received: by 2002:a05:6808:1483:b0:354:a36e:5b with SMTP id
 e3-20020a056808148300b00354a36e005bmr22695032oiw.35.1666320683101; Thu, 20
 Oct 2022 19:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <1666137032-28192-1-git-send-email-si-wei.liu@oracle.com>
 <1666137032-28192-3-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEuT7O1xLrB9=eYHAtuHYdwbNXxqtC+Mh4qkWSkLM+QTjg@mail.gmail.com>
 <68312622-0206-f456-146e-e242e36be04d@oracle.com>
In-Reply-To: <68312622-0206-f456-146e-e242e36be04d@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 21 Oct 2022 10:51:11 +0800
Message-ID: <CACGkMEtjseNBZ53x7=k79X8q3wogtksFPPC7NG2Uofj0HSEq+Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] vdpa: pass initial config to
 _vdpa_register_device()
To: Si-Wei Liu <si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization@lists.linux-foundation.org,
 Wu Zongyong <wuzongyong@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 mst@redhat.com
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

On Fri, Oct 21, 2022 at 2:45 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
>
>
> On 10/19/2022 10:20 PM, Jason Wang wrote:
> > On Wed, Oct 19, 2022 at 8:56 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
> >> Just as _vdpa_register_device taking @nvqs as the number of queues
> > I wonder if it's better to embed nvqs in the config structure.
> Hmmm, the config structure is mostly for containing the configurables
> specified in the 'vdpa dev add' command, while each field is
> conditionally set and guarded by a corresponding mask bit. If @nvqs
> needs to be folded into a structure, I feel it might be better to use
> another struct for holding the informational fields (i.e. those are
> read-only and always exist). But doing this would make @nvqs a weird
> solo member in that struct with no extra benefit, and all the other
> informational fields shown in the 'vdpa dev show' command would be
> gotten from the device through config_ops directly. Maybe do this until
> another read-only field comes around?

That's fine.

>
> >
> >> to feed userspace inquery via vdpa_dev_fill(), we can follow the
> >> same to stash config attributes in struct vdpa_device at the time
> >> of vdpa registration.
> >>
> >> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> >> ---
> >>   drivers/vdpa/ifcvf/ifcvf_main.c      |  2 +-
> >>   drivers/vdpa/mlx5/net/mlx5_vnet.c    |  2 +-
> >>   drivers/vdpa/vdpa.c                  | 15 +++++++++++----
> >>   drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  2 +-
> >>   drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  2 +-
> >>   drivers/vdpa/vdpa_user/vduse_dev.c   |  2 +-
> >>   drivers/vdpa/virtio_pci/vp_vdpa.c    |  3 ++-
> >>   include/linux/vdpa.h                 |  3 ++-
> >>   8 files changed, 20 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> >> index f9c0044..c54ab2c 100644
> >> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> >> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> >> @@ -771,7 +771,7 @@ static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
> >>          else
> >>                  ret = dev_set_name(&vdpa_dev->dev, "vdpa%u", vdpa_dev->index);
> >>
> >> -       ret = _vdpa_register_device(&adapter->vdpa, vf->nr_vring);
> >> +       ret = _vdpa_register_device(&adapter->vdpa, vf->nr_vring, config);
> >>          if (ret) {
> >>                  put_device(&adapter->vdpa.dev);
> >>                  IFCVF_ERR(pdev, "Failed to register to vDPA bus");
> >> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >> index 9091336..376082e 100644
> >> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >> @@ -3206,7 +3206,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
> >>          mlx5_notifier_register(mdev, &ndev->nb);
> >>          ndev->nb_registered = true;
> >>          mvdev->vdev.mdev = &mgtdev->mgtdev;
> >> -       err = _vdpa_register_device(&mvdev->vdev, max_vqs + 1);
> >> +       err = _vdpa_register_device(&mvdev->vdev, max_vqs + 1, add_config);
> >>          if (err)
> >>                  goto err_reg;
> >>
> >> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> >> index febdc99..566c1c6 100644
> >> --- a/drivers/vdpa/vdpa.c
> >> +++ b/drivers/vdpa/vdpa.c
> >> @@ -215,11 +215,16 @@ static int vdpa_name_match(struct device *dev, const void *data)
> >>          return (strcmp(dev_name(&vdev->dev), data) == 0);
> >>   }
> >>
> >> -static int __vdpa_register_device(struct vdpa_device *vdev, u32 nvqs)
> >> +static int __vdpa_register_device(struct vdpa_device *vdev, u32 nvqs,
> >> +                                 const struct vdpa_dev_set_config *cfg)
> >>   {
> >>          struct device *dev;
> >>
> >>          vdev->nvqs = nvqs;
> >> +       if (cfg)
> >> +               vdev->vdev_cfg = *cfg;
> >> +       else
> >> +               vdev->vdev_cfg.mask = 0ULL;
> > I think it would be nice if we can convert eni to use netlink then we
> > don't need any workaround like this.
> Yes, Alibaba ENI is the only consumer of the old vdpa_register_device()
> API without being ported to the netlink API. Not sure what is needed but
> it seems another work to make netlink API committed to support a legacy
> compatible model?

It's only about the provisioning (which is kind of out of the spec).
So if I was not wrong, it should be something similar like the work
that Cindy has done, (per VF mgmtdev):

commit ffbda8e9df10d1784d5427ec199e7d8308e3763f
Author: Cindy Lu <lulu@redhat.com>
Date:   Fri Apr 29 17:10:30 2022 +0800

    vdpa/vp_vdpa : add vdpa tool support in vp_vdpa

Thanks

>
> -Siwei
>
> >
> > Thanks
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
