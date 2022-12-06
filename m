Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E06EC3A5A7
	for <virtualization@archiver.kernel.org>; Tue,  6 Dec 2022 08:25:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A7C5540441;
	Tue,  6 Dec 2022 08:25:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A7C5540441
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gqD5ee0m
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6lFqu830O64u; Tue,  6 Dec 2022 08:25:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 21675402A8;
	Tue,  6 Dec 2022 08:25:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 21675402A8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBDCFC0033;
	Tue,  6 Dec 2022 08:25:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5CF4C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 08:25:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7CCDD40441
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 08:25:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7CCDD40441
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dhA9Q5LeuIxf
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 08:25:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ED9CB402A8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ED9CB402A8
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 08:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670315131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zZAq/PtnFU0rbP7eP7C+jdgThKNnH+Mi6t7KTAN4IpE=;
 b=gqD5ee0mkbeDQZ+rDbN/hy5krK9c9f8Jsd4Rl3IHTzWkRFnio4Xgayn1CCH7cVnk7VnRef
 VBkqx6o1desSHB5Jdz3gBG+IKSnMAL0UOYhBjsGF9zdOY+Imj8xsXCqILDbESSbfWisy/N
 cIs7RHod/Vr0lbJnVbd6LHo0g64pgXE=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-372-ReAJ5kKgMJ-g8CoRjD66bA-1; Tue, 06 Dec 2022 03:25:30 -0500
X-MC-Unique: ReAJ5kKgMJ-g8CoRjD66bA-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-144870e8fe8so2962820fac.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 06 Dec 2022 00:25:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zZAq/PtnFU0rbP7eP7C+jdgThKNnH+Mi6t7KTAN4IpE=;
 b=FKSbrQdzgHK3a3Ii6Eww7H3ETvfD3iWbaJgxGljlOOMoR7XvZBUfAgygAIwOuh1sOz
 FQxGQkw7FhVKSRNTPA9ikSqxtJDsmyd2yHBqMg1O5rKiQccloJb2MgFGsY9NIfT58Y5s
 GQyHw3gdGmVKU2l8Rj8+i8qJhvE6aSK3zTGzrI5SaI/ezbVcIdVO2nbCM2rmJ1ldp45h
 vGTzlvjs8LbagjifTFjCrZQHFrp9zGe8yeF0FvMokfIKBpKEYiFXcWEFa2Ze33Q/sgx8
 eU+OKepldY6cLkAmTMJv4QG4zb2oypgS3VVYaatMcFai7L8v7l4hISeyPwkARJx8yTIk
 y0qA==
X-Gm-Message-State: ANoB5pmrJqyv80edJQMal9VvjBwPr+iQXvbJj98/OmT3mEXmGOJgHOas
 zLMC4Lwdf9GqlwliwyTKbQ2JhCrEQq9wptDHNy+E/MSMqAMxO05v0begDFV6a41Cb4IzT3/pgSF
 YMMza9Ty4kK9DFquvQY257zQy2KNse0Ssm0TcthOOCV7eRXy4sgOYDwa2zA==
X-Received: by 2002:a9d:832:0:b0:670:5283:dd3e with SMTP id
 47-20020a9d0832000000b006705283dd3emr2305382oty.201.1670315129784; 
 Tue, 06 Dec 2022 00:25:29 -0800 (PST)
X-Google-Smtp-Source: AA0mqf63/YSWSVfAKhDkxJJhg5tVQ6edTZ8+z5593ZO8OwAtsLg+gnP7Sk7CJg2MlOyZ4umJty76Hd1HiuYim0ssmgc=
X-Received: by 2002:a9d:832:0:b0:670:5283:dd3e with SMTP id
 47-20020a9d0832000000b006705283dd3emr2305371oty.201.1670315129501; Tue, 06
 Dec 2022 00:25:29 -0800 (PST)
MIME-Version: 1.0
References: <20221125145724.1129962-1-lingshan.zhu@intel.com>
In-Reply-To: <20221125145724.1129962-1-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 6 Dec 2022 16:25:17 +0800
Message-ID: <CACGkMEvEwutEZT4UyosOZmTcKjvhhS6covy6FgyMWm4nmtKn8w@mail.gmail.com>
Subject: Re: [PATCH V2 00/12] ifcvf/vDPA implement features provisioning
To: Zhu Lingshan <lingshan.zhu@intel.com>
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

On Fri, Nov 25, 2022 at 11:06 PM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
>
> This series implements features provisioning for ifcvf.
> By applying this series, we allow userspace to create
> a vDPA device with selected (management device supported)
> feature bits and mask out others.
>
> Examples:
> a)The management device supported features:
> $ vdpa mgmtdev show pci/0000:01:00.5
> pci/0000:01:00.5:
>   supported_classes net
>   max_supported_vqs 9
>   dev_features MTU MAC MRG_RXBUF CTRL_VQ MQ ANY_LAYOUT VERSION_1 ACCESS_PLATFORM
>
> b)Provision a vDPA device with all supported features:
> $ vdpa dev add name vdpa0 mgmtdev pci/0000:01:00.5
> $ vdpa/vdpa dev config show vdpa0
> vdpa0: mac 00:e8:ca:11:be:05 link up link_announce false max_vq_pairs 4 mtu 1500
>   negotiated_features MRG_RXBUF CTRL_VQ MQ VERSION_1 ACCESS_PLATFORM
>
> c)Provision a vDPA device with a subset of the supported features:
> $ vdpa dev add name vdpa0 mgmtdev pci/0000:01:00.5 device_features 0x300020020
> $ vdpa dev config show vdpa0
> mac 00:e8:ca:11:be:05 link up link_announce false
>   negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM
>
> Please help review
>
> Thanks
>
> Changes from V1:
> split original patch 1 ~ patch 3 to small patches that are less
> than 100 lines,

True but.

>so they can be applied to stalbe kernel(Jason)
>

It requires each patch fixes a real issue so I think those can not go
to -stable.

Btw, looking at git history what you want to decouple is basically
functional equivalent to a partial revert of this commit:

commit 378b2e956820ff5c082d05f42828badcfbabb614
Author: Zhu Lingshan <lingshan.zhu@intel.com>
Date:   Fri Jul 22 19:53:05 2022 +0800

    vDPA/ifcvf: support userspace to query features and MQ of a
management device

    Adapting to current netlink interfaces, this commit allows userspace
    to query feature bits and MQ capability of a management device.

    Currently both the vDPA device and the management device are the VF itself,
    thus this ifcvf should initialize the virtio capabilities in probe() before
    setting up the struct vdpa_mgmt_dev.

    Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
    Message-Id: <20220722115309.82746-3-lingshan.zhu@intel.com>
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Before this commit. adapter was allocated/freed in device_add/del
which should be fine.

Can we go back to doing things that way?

Thanks

> Zhu Lingshan (12):
>   vDPA/ifcvf: decouple hw features manipulators from the adapter
>   vDPA/ifcvf: decouple config space ops from the adapter
>   vDPA/ifcvf: alloc the mgmt_dev before the adapter
>   vDPA/ifcvf: decouple vq IRQ releasers from the adapter
>   vDPA/ifcvf: decouple config IRQ releaser from the adapter
>   vDPA/ifcvf: decouple vq irq requester from the adapter
>   vDPA/ifcvf: decouple config/dev IRQ requester and vectors allocator
>     from the adapter
>   vDPA/ifcvf: ifcvf_request_irq works on ifcvf_hw
>   vDPA/ifcvf: manage ifcvf_hw in the mgmt_dev
>   vDPA/ifcvf: allocate the adapter in dev_add()
>   vDPA/ifcvf: retire ifcvf_private_to_vf
>   vDPA/ifcvf: implement features provisioning
>
>  drivers/vdpa/ifcvf/ifcvf_base.c |  32 ++-----
>  drivers/vdpa/ifcvf/ifcvf_base.h |  10 +-
>  drivers/vdpa/ifcvf/ifcvf_main.c | 162 +++++++++++++++-----------------
>  3 files changed, 91 insertions(+), 113 deletions(-)
>
> --
> 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
