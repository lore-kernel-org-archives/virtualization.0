Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12342C4332F
	for <virtualization@archiver.kernel.org>; Thu, 10 Nov 2022 03:50:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 886CB81076;
	Thu, 10 Nov 2022 03:50:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 886CB81076
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DyigSyuQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FpsdDft9Yfdv; Thu, 10 Nov 2022 03:50:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0B4E180C3C;
	Thu, 10 Nov 2022 03:50:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0B4E180C3C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C255CC0033;
	Thu, 10 Nov 2022 03:50:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DA05C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 03:50:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 439B74012C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 03:50:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 439B74012C
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DyigSyuQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PTdfs2aLyVnx
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 03:50:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2876940111
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2876940111
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 03:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668052201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=60TErWgB0U0U1ocEUPR6YUn8kraoamkgfQY4MoeZxSA=;
 b=DyigSyuQrIFip8vN+KyTs/6qRA0y6E2P26kGKohol+gFlRtt88KjkGR0Y0jezfXWqZ1Tuw
 1cRB86XMCZGy9H4WnwvJto4cCVwtTd0M6zY6t08b3YW3a+aHoTI0UMuQZm6OcvsLUrAC9f
 rDJdZJyRRpikvOWjH9YISdIn0BMbdmQ=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-648-GTt0kJ35OLWawp2o7qWjYw-1; Wed, 09 Nov 2022 22:50:00 -0500
X-MC-Unique: GTt0kJ35OLWawp2o7qWjYw-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-13b6f7d8bf4so487679fac.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Nov 2022 19:49:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=60TErWgB0U0U1ocEUPR6YUn8kraoamkgfQY4MoeZxSA=;
 b=REW0ku56pajTmrEDiokyOcQcFOGoKCjcmgaUrhXioi3sBq9EW1Iun+EzIT9PNd8Loe
 xTnAufOiKJIx6pp20wu1ai6TPs1E6k2pxTshTcTtJs47Oq7V5ZB0UCSmFYl3dxHHVHzp
 o0qRTuKx2JVFs06xfoIuvlEL5tR/Ahb6CHJuKdhOJSIo9oP7NCnbk0m/dImpL1ukf+dD
 GW2qYu8z1WhptPQBlHS7VL6nf1vfribdQQN/MaP6BTMclW+Y0N6oF6CCPe99APJFy+al
 B2s8y/YDyUVJhHyLI1NnG0S36LDR3jQpTXncqWa+dJaT8JvUwi8Dv03IxWaC05Uc0W80
 ZiUw==
X-Gm-Message-State: ACrzQf3BrY/+6ERdgSKOU5tAd8hEq3ai+n2HF4TUFRIOXeRbamEYROXQ
 hjaZa8pzJkQkIG8O6ko7pv9b1fe2XiPfm1ScKvmNP6WrdwqGPLXQjBlLUqTyonP4JhMVDVmy/57
 ZORYnImhUXwh6bbFH5q3a32THgMv/k+xBngvpyBWqj3aRvY/Sv9h5R9UB5g==
X-Received: by 2002:a05:6871:54e:b0:13b:29b7:e2e8 with SMTP id
 t14-20020a056871054e00b0013b29b7e2e8mr45759490oal.35.1668052199261; 
 Wed, 09 Nov 2022 19:49:59 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6Yn+hSnYW2dtP/B4LNuU0FW2fGT1rkHGvoIuVlS3fet4Oamq0Y/5dGPg9Iq0HjoNmQTXjGOGpClzetCS9bnaE=
X-Received: by 2002:a05:6871:54e:b0:13b:29b7:e2e8 with SMTP id
 t14-20020a056871054e00b0013b29b7e2e8mr45759486oal.35.1668052199063; Wed, 09
 Nov 2022 19:49:59 -0800 (PST)
MIME-Version: 1.0
References: <20221107093345.121648-1-lingshan.zhu@intel.com>
 <CACGkMEs9af1E1pLd2t8E71YBPF=rHkhfN8qO9_3=x6HVaCMAxg@mail.gmail.com>
 <0b15591f-9e49-6383-65eb-6673423f81ec@intel.com>
 <CACGkMEujqOFHv7QATWgYo=SdAKef5jQXi2-YksjgT-hxEgKNDQ@mail.gmail.com>
 <80cdd80a-16fa-ac75-0a89-5729b846efed@intel.com>
In-Reply-To: <80cdd80a-16fa-ac75-0a89-5729b846efed@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 10 Nov 2022 11:49:47 +0800
Message-ID: <CACGkMEu-5TbA3Ky2qgn-ivfhgfJ2b12mDJgq8iNgHce8qu3ApA@mail.gmail.com>
Subject: Re: [PATCH 0/4] ifcvf/vDPA implement features provisioning
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: piotr.uminski@intel.com, hang.yuan@intel.com,
 virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mst@redhat.com
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

On Wed, Nov 9, 2022 at 5:06 PM Zhu, Lingshan <lingshan.zhu@intel.com> wrote:
>
>
>
> On 11/9/2022 4:59 PM, Jason Wang wrote:
> > On Wed, Nov 9, 2022 at 4:14 PM Zhu, Lingshan <lingshan.zhu@intel.com> wrote:
> >>
> >>
> >> On 11/9/2022 2:51 PM, Jason Wang wrote:
> >>> On Mon, Nov 7, 2022 at 5:42 PM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
> >>>> This series implements features provisioning for ifcvf.
> >>>> By applying this series, we allow userspace to create
> >>>> a vDPA device with selected (management device supported)
> >>>> feature bits and mask out others.
> >>> I don't see a direct relationship between the first 3 and the last.
> >>> Maybe you can state the reason why the restructure is a must for the
> >>> feature provisioning. Otherwise, we'd better split the series.
> >> When introducing features provisioning ability to ifcvf, there is a need
> >> to re-create vDPA devices
> >> on a VF with different feature bits.
> > This seems a requirement even without feature provisioning? Device
> > could be deleted from the management device anyhow.
> Yes, we need this to delete and re-create a vDPA device.

I wonder if we need something that works for -stable.

AFAIK, we can move the vdpa_alloc_device() from probe() to dev_add()
and it seems to work?

Thanks

>
> We create vDPA device from a VF, so without features provisioning
> requirements,
> we don't need to re-create the vDPA device. But with features provisioning,
> it is a must now.
>
> Thanks
>
>
> >
> > Thakns
> >
> >> When remove a vDPA device, the container of struct vdpa_device (here is
> >> ifcvf_adapter) is free-ed in
> >> dev_del() interface, so we need to allocate ifcvf_adapter in dev_add()
> >> than in probe(). That's
> >> why I have re-factored the adapter/mgmt_dev code.
> >>
> >> For re-factoring the irq related code and ifcvf_base, let them work on
> >> struct ifcvf_hw, the
> >> reason is that the adapter is allocated in dev_add(), if we want theses
> >> functions to work
> >> before dev_add(), like in probe, we need them work on ifcvf_hw than the
> >> adapter.
> >>
> >> Thanks
> >> Zhu Lingshan
> >>> Thanks
> >>>
> >>>> Please help review
> >>>>
> >>>> Thanks
> >>>>
> >>>> Zhu Lingshan (4):
> >>>>     vDPA/ifcvf: ifcvf base layer interfaces work on struct ifcvf_hw
> >>>>     vDPA/ifcvf: IRQ interfaces work on ifcvf_hw
> >>>>     vDPA/ifcvf: allocate ifcvf_adapter in dev_add()
> >>>>     vDPA/ifcvf: implement features provisioning
> >>>>
> >>>>    drivers/vdpa/ifcvf/ifcvf_base.c |  32 ++-----
> >>>>    drivers/vdpa/ifcvf/ifcvf_base.h |  10 +-
> >>>>    drivers/vdpa/ifcvf/ifcvf_main.c | 156 +++++++++++++++-----------------
> >>>>    3 files changed, 89 insertions(+), 109 deletions(-)
> >>>>
> >>>> --
> >>>> 2.31.1
> >>>>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
