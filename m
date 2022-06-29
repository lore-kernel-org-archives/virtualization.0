Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3079C433EF
	for <virtualization@archiver.kernel.org>; Wed, 29 Jun 2022 09:23:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C4DB82F32;
	Wed, 29 Jun 2022 09:23:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4C4DB82F32
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RdIDpeCN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pLtnjkelbmkX; Wed, 29 Jun 2022 09:22:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BECDE82B1B;
	Wed, 29 Jun 2022 09:22:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BECDE82B1B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A304BC0039;
	Wed, 29 Jun 2022 09:22:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B605C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 09:22:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4F16140227
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 09:22:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4F16140227
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RdIDpeCN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NJ3fXWGGK9U8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 09:22:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5421F409A2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5421F409A2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 09:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656494574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3T3KoZe6xrSR0yQtVMqOrhBkODeV64PTbOu8+iOAQkg=;
 b=RdIDpeCN+4q4OqoiR8Sjx0FZU8DRIq//nSnFFoUqM7Qnq4ZesdEDFheeZlWKgK0yZf4Tn2
 FIhTse3O3hs7P6Vjycns1MWOXksoPaQdKlyq0oaGfJbMlysg2d2QKKODPsK8IXAAA2pbQL
 cdCRwqlVe9GWxjaYqeJUPFupE0ZPAUo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-326-hBncr2bQN46eQIbCpbX79A-1; Wed, 29 Jun 2022 05:22:53 -0400
X-MC-Unique: hBncr2bQN46eQIbCpbX79A-1
Received: by mail-wm1-f69.google.com with SMTP id
 h125-20020a1c2183000000b003a0374f1eb8so9150442wmh.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 02:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3T3KoZe6xrSR0yQtVMqOrhBkODeV64PTbOu8+iOAQkg=;
 b=VTt83VQPWNM/GuCWU6940Rq/t2VQYBIMjPXWZBbYU9Utxg+uyYcy2PYao9DhpXqDAj
 JHV/dYXW8ahcgkAaOUyTbCzxxx5fUfYXQOxjHHeS5ZRSaDvgexxcEF3M5sPxO61IBjGO
 HVTXPv2K1dDCgDNw5BeI85XEMPKdKYy019yLMxfhh5JTDu3DU9/N3Yndo+tTSdb4tlbJ
 RHHnZjn5jDYR/zriAN7sBciHxilV8bKbzSqjDzD7vqXbZvaTw486f93zejNeTPVG6o+l
 BKf+/RbcVMF1UHYx0M20npS96r1R4p68Ypnvkl6MSEcKvHXXNsjHirYAq6DQTzzAQK1C
 AWWg==
X-Gm-Message-State: AJIora8AllN3xMGHtVxKHVN+t9TOoZQa4O7VeqVbyxVibrxXlgqXfO53
 9VOzqNhry/2rbqTruTpzH/PAJxqF3kIfPH0Erc3e7KON0eM+BXMCxKEnGueqtmcqDCPxMAga+po
 CEC7cENCGCEx90JISIOOL1ju4pUvIEKDfdp9bwMai4g==
X-Received: by 2002:a05:600c:4fc9:b0:3a0:4d54:b315 with SMTP id
 o9-20020a05600c4fc900b003a04d54b315mr2464372wmq.62.1656494572271; 
 Wed, 29 Jun 2022 02:22:52 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uxC/Xv2PCl30ysM0HmldDOVWW/6SECfAu75JVsX0/hX7re1RKv0XaHkkLAz5M55BrTVL72bw==
X-Received: by 2002:a05:600c:4fc9:b0:3a0:4d54:b315 with SMTP id
 o9-20020a05600c4fc900b003a04d54b315mr2464356wmq.62.1656494572066; 
 Wed, 29 Jun 2022 02:22:52 -0700 (PDT)
Received: from redhat.com ([2.52.23.204]) by smtp.gmail.com with ESMTPSA id
 x2-20020a7bc202000000b0039c18d3fe27sm2433190wmi.19.2022.06.29.02.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jun 2022 02:22:51 -0700 (PDT)
Date: Wed, 29 Jun 2022 05:22:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH 6/6] vduse: Update api version to 1
Message-ID: <20220629052130-mutt-send-email-mst@kernel.org>
References: <20220629082541.118-1-xieyongji@bytedance.com>
 <20220629082541.118-7-xieyongji@bytedance.com>
 <20220629042856-mutt-send-email-mst@kernel.org>
 <CACycT3sZXwunA_UOCriSv=f2VARMnPb1mNU2GAUd9BLCU-Hg8w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACycT3sZXwunA_UOCriSv=f2VARMnPb1mNU2GAUd9BLCU-Hg8w@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Liu Xiaodong <xiaodong.liu@intel.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
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

On Wed, Jun 29, 2022 at 05:02:40PM +0800, Yongji Xie wrote:
> On Wed, Jun 29, 2022 at 4:33 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Jun 29, 2022 at 04:25:41PM +0800, Xie Yongji wrote:
> > > Let's update api version to 1 since we introduced
> > > some new ioctls to support registering userspace
> > > memory for IOTLB.
> > >
> > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> >
> >
> > Adding new ioctls does not justify things like this.
> >
> 
> What I want to do here is make userspace know whether this feature is
> supported or not in the kernel. So do you think we need to add
> something like CHECK_EXTENSION ioctl here?

Why bother? unsupported ioctls just return an error code.

> > Besides, adding UAPI then changing it is not nice
> > since it makes git bisect behave incorrectly.
> >
> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 12 ++++++++++++
> > >  include/uapi/linux/vduse.h         |  8 +++++++-
> > >  2 files changed, 19 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > index 7b2ea7612da9..2795785ca6a2 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -1206,6 +1206,10 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
> > >       case VDUSE_IOTLB_GET_INFO: {
> > >               struct vduse_iotlb_info iotlb;
> > >
> > > +             ret = -EPERM;
> >
> >
> > Almost for sure a wrong error code.
> >
> > > +             if (dev->api_version < 1)
> > > +                     break;
> > > +
> > >               iotlb.bounce_iova = 0;
> > >               iotlb.bounce_size = dev->domain->bounce_size;
> > >
> >
> >
> > Wait a second. so you are intentionally breaking any userspace
> > that called VDUSE_SET_API_VERSION with version 0?
> >
> > Please don't.
> >
> 
> Yes, I'd like to let userspace know we don't support this feature.
> 
> Thanks.
> Yongji


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
