Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3FAC4332F
	for <virtualization@archiver.kernel.org>; Wed,  9 Nov 2022 08:59:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A7A2416C9;
	Wed,  9 Nov 2022 08:59:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3A7A2416C9
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d22MTsmP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V14HrpPWFmZ9; Wed,  9 Nov 2022 08:59:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 980FA416CE;
	Wed,  9 Nov 2022 08:59:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 980FA416CE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63569C0033;
	Wed,  9 Nov 2022 08:59:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B213BC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 08:59:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7AD9780B96
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 08:59:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7AD9780B96
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=d22MTsmP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kh3ofx5HWzOR
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 08:59:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6591E80B42
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6591E80B42
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 08:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667984376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6N0lCIAD53nCM8NWFUXR1L2cUAw2KB/QLdCa57mdxSw=;
 b=d22MTsmPSC43ZOlDU1riPqhnormEOsTdtMN+mgigj364f6JJFI3O+vW39FkvbTKfoSZ4NX
 2thYjgpdxL7c/i6tOdvWLwrjZIb2lNSIK0cE50+S55jXgtxy1KgZHkMX0pkWHq5o7Enc2w
 PG9laq7/zg1hgl28o7UEZM9B/Tqli7k=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-615-qu8mdu1fOWmwk1dz_4z2cQ-1; Wed, 09 Nov 2022 03:59:33 -0500
X-MC-Unique: qu8mdu1fOWmwk1dz_4z2cQ-1
Received: by mail-ot1-f70.google.com with SMTP id
 e19-20020a9d0193000000b0066754f1a8efso8038231ote.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Nov 2022 00:59:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6N0lCIAD53nCM8NWFUXR1L2cUAw2KB/QLdCa57mdxSw=;
 b=tNFhu7xfeD6VL1G4ExdEj1/x4VclvjSQDMTi2VzOt391hIPIL98ewpMb5nVhd/TRxM
 JSMAkNEA+O3XIviIr/CXVz7BUxf70vwKoi3Z1X7tqbHqCcQMjK9KIy2rApWuChRGRqIv
 oqmJLrtYHVZdx8SYXAPdG5PZYbNHPUmprC7tXC8dBoH/+ufAuPJvbM4wcSmPH1DhPKzS
 SAJMlKw0nsTjvA3M4xbMmIs8VPAarxIN/n+9c2LPTSSSCScjQ8gKHYiATJ8lmobjnq8Q
 boo3HgT7Xnk9TPgCnIS8hgvkhcYLtfSxwyvO24neqlqmht2fMbDsGx2A1ZBYvEHDapls
 qR+A==
X-Gm-Message-State: ACrzQf1pmAnZq+ynw7eXzLnb5XPBiwxZp757bDRVu7HfDX1TlOsw8DeQ
 u9yhwaZ4jnuirBen22b37m533goOG+0lr8PV0GHsSA6JIgdb8neBLAD80xMmhmI06Py0Y007DcW
 BOmquCrvNcpN+h2EuJPDkP0tBRsccW1uhNRRooe44hBttPTrcKRkKKboJ1A==
X-Received: by 2002:a05:6871:54e:b0:13b:29b7:e2e8 with SMTP id
 t14-20020a056871054e00b0013b29b7e2e8mr43834501oal.35.1667984372354; 
 Wed, 09 Nov 2022 00:59:32 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4N1uceXI6J7DP3npNVfHBKhZGxDCbi8hC/jrrwqBzU5VaqPmYEk9Hbn9lNXK1m3yNFIvSN6C2Qn8RkB1/22Wg=
X-Received: by 2002:a05:6871:54e:b0:13b:29b7:e2e8 with SMTP id
 t14-20020a056871054e00b0013b29b7e2e8mr43834490oal.35.1667984372087; Wed, 09
 Nov 2022 00:59:32 -0800 (PST)
MIME-Version: 1.0
References: <20221107093345.121648-1-lingshan.zhu@intel.com>
 <CACGkMEs9af1E1pLd2t8E71YBPF=rHkhfN8qO9_3=x6HVaCMAxg@mail.gmail.com>
 <0b15591f-9e49-6383-65eb-6673423f81ec@intel.com>
In-Reply-To: <0b15591f-9e49-6383-65eb-6673423f81ec@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 9 Nov 2022 16:59:20 +0800
Message-ID: <CACGkMEujqOFHv7QATWgYo=SdAKef5jQXi2-YksjgT-hxEgKNDQ@mail.gmail.com>
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

On Wed, Nov 9, 2022 at 4:14 PM Zhu, Lingshan <lingshan.zhu@intel.com> wrote:
>
>
>
> On 11/9/2022 2:51 PM, Jason Wang wrote:
> > On Mon, Nov 7, 2022 at 5:42 PM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
> >> This series implements features provisioning for ifcvf.
> >> By applying this series, we allow userspace to create
> >> a vDPA device with selected (management device supported)
> >> feature bits and mask out others.
> > I don't see a direct relationship between the first 3 and the last.
> > Maybe you can state the reason why the restructure is a must for the
> > feature provisioning. Otherwise, we'd better split the series.
> When introducing features provisioning ability to ifcvf, there is a need
> to re-create vDPA devices
> on a VF with different feature bits.

This seems a requirement even without feature provisioning? Device
could be deleted from the management device anyhow.

Thakns

>
> When remove a vDPA device, the container of struct vdpa_device (here is
> ifcvf_adapter) is free-ed in
> dev_del() interface, so we need to allocate ifcvf_adapter in dev_add()
> than in probe(). That's
> why I have re-factored the adapter/mgmt_dev code.
>
> For re-factoring the irq related code and ifcvf_base, let them work on
> struct ifcvf_hw, the
> reason is that the adapter is allocated in dev_add(), if we want theses
> functions to work
> before dev_add(), like in probe, we need them work on ifcvf_hw than the
> adapter.
>
> Thanks
> Zhu Lingshan
> >
> > Thanks
> >
> >> Please help review
> >>
> >> Thanks
> >>
> >> Zhu Lingshan (4):
> >>    vDPA/ifcvf: ifcvf base layer interfaces work on struct ifcvf_hw
> >>    vDPA/ifcvf: IRQ interfaces work on ifcvf_hw
> >>    vDPA/ifcvf: allocate ifcvf_adapter in dev_add()
> >>    vDPA/ifcvf: implement features provisioning
> >>
> >>   drivers/vdpa/ifcvf/ifcvf_base.c |  32 ++-----
> >>   drivers/vdpa/ifcvf/ifcvf_base.h |  10 +-
> >>   drivers/vdpa/ifcvf/ifcvf_main.c | 156 +++++++++++++++-----------------
> >>   3 files changed, 89 insertions(+), 109 deletions(-)
> >>
> >> --
> >> 2.31.1
> >>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
