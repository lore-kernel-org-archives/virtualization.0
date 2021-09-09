Return-Path: <SRS0=8M8J=N7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE493C433EF
	for <virtualization@archiver.kernel.org>; Thu,  9 Sep 2021 09:31:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A226C60E0B
	for <virtualization@archiver.kernel.org>; Thu,  9 Sep 2021 09:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A226C60E0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6610440565;
	Thu,  9 Sep 2021 09:31:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nD8CAxA2ymXq; Thu,  9 Sep 2021 09:31:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A2C8E40185;
	Thu,  9 Sep 2021 09:31:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8354FC0011;
	Thu,  9 Sep 2021 09:31:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2CDB2C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Sep 2021 09:31:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 14FB0402C3
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Sep 2021 09:31:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kv85rpfeKdBd
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Sep 2021 09:31:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 53A064028A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Sep 2021 09:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631179897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oyk/5xbj6JBnipmhdcExzScdKjpjWsEFPTKPgPPwe0U=;
 b=YBl/gCbGJS+/Frcz0DURoZyWvbHlLCOT4mCtA+Sp/RGXFaJtcKRIllP8WZVWOlOWBS2gYF
 nuvJo+YF1ZhM9qvfY097qr8xHt/Fuu23mvKyMWJEVqEvFar0J3R7GY38PjXwSzrJk+t2rY
 bBupyCD+mzMP9hrPvNQAiG0/vx3sIrE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-qwnOF98_PUS4XJLHZEC6xw-1; Thu, 09 Sep 2021 05:31:36 -0400
X-MC-Unique: qwnOF98_PUS4XJLHZEC6xw-1
Received: by mail-lf1-f72.google.com with SMTP id
 x33-20020a0565121321b02903ac51262781so508492lfu.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 09 Sep 2021 02:31:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oyk/5xbj6JBnipmhdcExzScdKjpjWsEFPTKPgPPwe0U=;
 b=cariZfuNFWYc3QCcBx/A+bJnMg5UnjvA6XoDnK04gVh6ZD7iTB8r5O8ge5whO42uCW
 P0pWI+08BFgGJMHo/99ggrMv5qSpzfesQaPqgNJ3AT9UiRy5etb6i0USc+QSApMVIxpb
 xyx8Dhfz73wXqzEuoCr9CZjkOPvrFpqUZP3hPpPNsyZVIloZ854zh9aOoMF41BkGSo1G
 hCn2kvoAHTvVv/04RP0OnHGLgvyP4tU8TxP3xpU0yEycxtzflk6AIaClQdzm+01WRAAp
 1Rb5rFEwk+nhlYXHvd7T3oC29yFk9bmN5rfTYQXrNO5L3IlVsKZj4IGI8i9IKsMw8K0u
 glyA==
X-Gm-Message-State: AOAM531XIeMJmKPp+rdiXb8+Hsg4cjEtiY9wKn18b8Dfp3TfICnmU6Zw
 aj0hKFMr2kS44Mwf3APkrXItR5HktIoNlqByov5i8fR0rmvZ/Dcs+O989Yezho+A3AI9SA3Ho7w
 rFNuwVSebrRVOT8emRjtNLM7IDelfHC/CisSbS4UAG0ETmOYjfLGU8yEBIQ==
X-Received: by 2002:ac2:5fc5:: with SMTP id q5mr1579264lfg.629.1631179894479; 
 Thu, 09 Sep 2021 02:31:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoCrurk4RtgIW8ahoORtM+vXj+ouEemSvE6SvpTvr8/YNjYdY8lb0LhbVcW+5BwC5jNXDL7KpsEazZVqPsEz4=
X-Received: by 2002:ac2:5fc5:: with SMTP id q5mr1579255lfg.629.1631179894307; 
 Thu, 09 Sep 2021 02:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <CACGkMEuEwbDQUtYHz=0O4pQcb6ibY0MAT7hLDjN=Okw8c9CZGA@mail.gmail.com>
 <20210909051936-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210909051936-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 9 Sep 2021 17:31:23 +0800
Message-ID: <CACGkMEvt5G-f4U=ReXNdmBcbywzsAhV1eYL2bP2Wp4RA_pKrYQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] vDPA driver for legacy virtio-pci device
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

On Thu, Sep 9, 2021 at 5:21 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Sep 09, 2021 at 11:05:06AM +0800, Jason Wang wrote:
> > On Wed, Sep 8, 2021 at 8:22 PM Wu Zongyong <wuzongyong@linux.alibaba.com> wrote:
> > >
> > > This series implements the vDPA driver for legacy virtio-pci device.
> > > Currently we already have the vDPA driver for modern virtio-pci device
> > > only, but there are some legacy virtio-pci devices conforming to the
> > > virtio-pci specifications of 0.9.x or older versions. For example,
> > > ENI(Elastic Network Interface) of Alibaba ECS baremetal instance is a
> > > hardware virtio network device which follows the Virtio PCI Card 0.9.5
> > > Draft specification. Such legacy virtio-pci devices have some
> > > inconsistent behaviour with modern virtio-pci devices, so some common
> > > codes are split out and modern device specific codes are moved to a
> > > separated file.
> >
> > What worries me a little bit are:
> >
> > 1) vDPA requires IOMMU_PLATFORM to be supported by the device to work,
> > if I understand ENI correctly, it's a legacy device so it can't
> > support ACCESS_PLATFORM. Or is it a legacy device that supports
> > ACCESS_PLATFORM implicitly.
> > 2) vDPA tries to present a 1.0 device, in this case the behavior could
> > be ruled by the spec. If we tries to present an 1.0 device on top of
> > legacy device we may suffer a lot of issues:
> >
> > - endian issue: 1.0 use le but legacy may use native endian
> > - queue_enable semantic which is missed in the legacy
> > - virtqueue size, as you mentioned below
>
> So this all kind of works when guest and host are
> strongly ordered and LE. Case in point x86.
> Question is how do we limit this to an x86 guest?
> Add a new ioctl declaring that this is the case?

I think the most simple way is to disable the driver on non LE host
(assuming it tries to use native endian which is kind of impossible).

Thanks

>
> --
> MST
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
