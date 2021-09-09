Return-Path: <SRS0=8M8J=N7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5134DC433F5
	for <virtualization@archiver.kernel.org>; Thu,  9 Sep 2021 09:21:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4FCF610FF
	for <virtualization@archiver.kernel.org>; Thu,  9 Sep 2021 09:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D4FCF610FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E27560AF1;
	Thu,  9 Sep 2021 09:21:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2O0MuG_kE0-c; Thu,  9 Sep 2021 09:21:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4BF4060AF2;
	Thu,  9 Sep 2021 09:21:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25370C0011;
	Thu,  9 Sep 2021 09:21:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B608C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Sep 2021 09:21:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 140D14055E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Sep 2021 09:21:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2b75JdS-duSm
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Sep 2021 09:21:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 428B440564
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Sep 2021 09:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631179266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=04XyEftP8B2cwyDDczs6wy9wXoFSsdoEGB0DdA8URak=;
 b=OsihiTBz08uuro15DIi+Qg7Z8yFYJKU5dNTYsK1ZHyjGR420Rq+wsBINjmnzR77NozREMA
 VjeVNktGvVI6LhE6eE/RLI6huhU4gQNNCaHlvLKNxF41sEw691nTdEwD9/7WdwSFACab4p
 atjBnFwEYHpGwyeLNfSlP6EBN1hWGZ0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-NjRB39l2M_KoH__PszBMCg-1; Thu, 09 Sep 2021 05:21:05 -0400
X-MC-Unique: NjRB39l2M_KoH__PszBMCg-1
Received: by mail-wm1-f71.google.com with SMTP id
 y24-20020a7bcd98000000b002eb50db2b62so472296wmj.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 09 Sep 2021 02:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=04XyEftP8B2cwyDDczs6wy9wXoFSsdoEGB0DdA8URak=;
 b=Vm6/wc9f9bMplYxH5uUUMRu0yEgg0pppDhOln0aSRXYdxL15PkHYVnqTZ1IGDQQXTV
 /GGe22Al1rMh7tVOCWynemnfgUT7x2oSHZZOmDZkz1F3636qYFMe1jcx2u0pr0AGsjxv
 IzFKCp0QxpA7tr3XlsXcp+K7Y8OLJDxu0svigS+zTpeQwGHgPXWx9iInIejWH/2l3V1z
 H6SlfhC/d3hP+/ORl5Z+8LVskTbflL5+fEnD6/nSGRHAfmemE81WMlCvy9G38N0/IWrR
 v+hLZKcBqeEhQxael0xRZuleTIhHfYT84Dz90cBMouztEyb67fph56kUwF75yeRhp8Lt
 ZjUQ==
X-Gm-Message-State: AOAM531qXSnqpxOuqP2OSR2FuP77pvVBnmQ+Uq67Dl7y8wTrpSW159TD
 EAMNNDu/K6JGNEuTJrYWEPcrpcVmRq2LrP2aFLqkzolezK9TQkqpmOr36L50GuRpGeaAF6DJxrw
 K4ORmZeiJbpwXCClBn4H+rt6t3vPP9encF2YXzsSzog==
X-Received: by 2002:a1c:192:: with SMTP id 140mr1853782wmb.101.1631179264534; 
 Thu, 09 Sep 2021 02:21:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzH3E9jPavsm71ebZFBPTANtCVc1EXdmI5W8Sdc21rVamcMC90TidgLKRIzdbEGe5wv156Esw==
X-Received: by 2002:a1c:192:: with SMTP id 140mr1853766wmb.101.1631179264375; 
 Thu, 09 Sep 2021 02:21:04 -0700 (PDT)
Received: from redhat.com ([2a10:8000:cbff::13])
 by smtp.gmail.com with ESMTPSA id v9sm999187wml.46.2021.09.09.02.21.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Sep 2021 02:21:03 -0700 (PDT)
Date: Thu, 9 Sep 2021 05:21:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 0/6] vDPA driver for legacy virtio-pci device
Message-ID: <20210909051936-mutt-send-email-mst@kernel.org>
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <CACGkMEuEwbDQUtYHz=0O4pQcb6ibY0MAT7hLDjN=Okw8c9CZGA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuEwbDQUtYHz=0O4pQcb6ibY0MAT7hLDjN=Okw8c9CZGA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: wei.yang1@linux.alibaba.com, Wu Zongyong <wuzongyong@linux.alibaba.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Thu, Sep 09, 2021 at 11:05:06AM +0800, Jason Wang wrote:
> On Wed, Sep 8, 2021 at 8:22 PM Wu Zongyong <wuzongyong@linux.alibaba.com> wrote:
> >
> > This series implements the vDPA driver for legacy virtio-pci device.
> > Currently we already have the vDPA driver for modern virtio-pci device
> > only, but there are some legacy virtio-pci devices conforming to the
> > virtio-pci specifications of 0.9.x or older versions. For example,
> > ENI(Elastic Network Interface) of Alibaba ECS baremetal instance is a
> > hardware virtio network device which follows the Virtio PCI Card 0.9.5
> > Draft specification. Such legacy virtio-pci devices have some
> > inconsistent behaviour with modern virtio-pci devices, so some common
> > codes are split out and modern device specific codes are moved to a
> > separated file.
> 
> What worries me a little bit are:
> 
> 1) vDPA requires IOMMU_PLATFORM to be supported by the device to work,
> if I understand ENI correctly, it's a legacy device so it can't
> support ACCESS_PLATFORM. Or is it a legacy device that supports
> ACCESS_PLATFORM implicitly.
> 2) vDPA tries to present a 1.0 device, in this case the behavior could
> be ruled by the spec. If we tries to present an 1.0 device on top of
> legacy device we may suffer a lot of issues:
> 
> - endian issue: 1.0 use le but legacy may use native endian
> - queue_enable semantic which is missed in the legacy
> - virtqueue size, as you mentioned below

So this all kind of works when guest and host are
strongly ordered and LE. Case in point x86.
Question is how do we limit this to an x86 guest?
Add a new ioctl declaring that this is the case?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
