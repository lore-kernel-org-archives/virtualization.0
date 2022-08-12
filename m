Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 072C7C25B0E
	for <virtualization@archiver.kernel.org>; Fri, 12 Aug 2022 11:17:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 864B4610D3;
	Fri, 12 Aug 2022 11:17:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 864B4610D3
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JGGbumq/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uzMrKlDr2wmH; Fri, 12 Aug 2022 11:17:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0CFEC610CA;
	Fri, 12 Aug 2022 11:17:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0CFEC610CA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B51D6C0032;
	Fri, 12 Aug 2022 11:17:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F295C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Aug 2022 11:17:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1A3DE410AD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Aug 2022 11:17:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1A3DE410AD
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JGGbumq/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rxwWTYHzN-nH
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Aug 2022 11:17:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 032EB40951
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 032EB40951
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Aug 2022 11:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660303040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i2uStZHcnGK1w3yJ0+mPheUPjNUdo4CHm8EdAzcVLaM=;
 b=JGGbumq/Ti1Jtf2TWrNqu0UcIbi6SHfOW/BVbBiLv4Q7dyt57+mj64HJASmauGsheKk4yX
 hXUOXDSY/c72WOyFwDepm5YcHNkMt92LPy9X37x/zVc/CB0AWMAC0ujiN8lFocgZX+FCTP
 Xz23TXYeKpYFu9YITQoAcUeW5LLCRnU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-166-61l_ObkzMXCjLgiWiUl9yg-1; Fri, 12 Aug 2022 07:17:19 -0400
X-MC-Unique: 61l_ObkzMXCjLgiWiUl9yg-1
Received: by mail-wm1-f72.google.com with SMTP id
 v130-20020a1cac88000000b003a4f057ed9fso440191wme.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Aug 2022 04:17:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=i2uStZHcnGK1w3yJ0+mPheUPjNUdo4CHm8EdAzcVLaM=;
 b=m2x+MB/ZbI8jxSOjP2ZkSCoVnHMoj+79unj2T/lepESxRusT4yVv/h5eI6sDAgPab4
 NuJ++IWQtff8M4teb42yOCqLKvUBjUjvGlwr/Qq3/HzB3UL0DfaA07ZaBcsBR0NK25bU
 PWxNHXe3L5xarKXJNs+lCI/vj24osabGya/gLyB218pbVXwSoh2+96rSWzYSGJNHMqMH
 fZzDUvJG0B5VsN/E1GSuIYUj2OWzrLXsX28MpzznQXIYAy4sVHcPMASItO+qDr6yBg6B
 lznJYK4+2I+3dKrS77rdLeSgFmfTMI8jbBZRjzi7jKfsFLwt7sQfXTXVOfXHYrzSSlD0
 6MFA==
X-Gm-Message-State: ACgBeo20SOiC6UeQadCQQJ/nqy3yHeoELqT1LBy8eytNl8sIOFSsbAV8
 TQt75HcHP9vWmM38i2/s5CGDi7I2jiXCGjMOVEiVuWdUpu3OgYG0MSTk/l5YR+WsmSM70NvVU8g
 8EcsyWd/bNmRg07Vmck5Qajgr9kH9dT/RWfCn/1T8eQ==
X-Received: by 2002:a1c:5408:0:b0:3a5:5380:1f0c with SMTP id
 i8-20020a1c5408000000b003a553801f0cmr8621431wmb.22.1660303038411; 
 Fri, 12 Aug 2022 04:17:18 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5kRgnRLONY++5noljgBkEKfRWlSfoMEmDvayaO4LHF6zu6hzy09dOq/6tBQNTQSV1JUg1XCQ==
X-Received: by 2002:a1c:5408:0:b0:3a5:5380:1f0c with SMTP id
 i8-20020a1c5408000000b003a553801f0cmr8621412wmb.22.1660303038110; 
 Fri, 12 Aug 2022 04:17:18 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7416:9d00:bb54:f6b1:32e:b9fc])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a5d5552000000b0021e43b4edf0sm1732604wrw.20.2022.08.12.04.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Aug 2022 04:17:17 -0700 (PDT)
Date: Fri, 12 Aug 2022 07:17:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Subject: Re: [PATCH V5 0/6] ifcvf/vDPA: support query device config space
 through netlink
Message-ID: <20220812071638-mutt-send-email-mst@kernel.org>
References: <20220812104500.163625-1-lingshan.zhu@intel.com>
 <20220812071251-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220812071251-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 gautam.dawar@amd.com
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

On Fri, Aug 12, 2022 at 07:14:39AM -0400, Michael S. Tsirkin wrote:
> On Fri, Aug 12, 2022 at 06:44:54PM +0800, Zhu Lingshan wrote:
> > This series allows userspace to query device config space of vDPA
> > devices and the management devices through netlink,
> > to get multi-queue, feature bits and etc.
> > 
> > This series has introduced a new netlink attr
> > VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES, this should be used to query
> > features of vDPA  devices than the management device.
> > 
> > Please help review.
> 
> I can't merge this for this merge window.
> Am I right when I say that the new thing here is patch 5/6 + new
> comments?
> If yes I can queue it out of the window, on top.

So at this point, can you please send patches on top of the vhost
tree? I think these are just patches 3 and 5 but please confirm.


> > Thanks!
> > Zhu Lingshan
> > 
> > Changes rom V4:
> > (1) Read MAC, MTU, MQ conditionally (Michael)
> > (2) If VIRTIO_NET_F_MAC not set, don't report MAC to userspace
> > (3) If VIRTIO_NET_F_MTU not set, report 1500 to userspace
> > (4) Add comments to the new attr
> > VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES(Michael)
> > (5) Add comments for reporting the device status as LE(Michael)
> > 
> > Changes from V3:
> > (1)drop the fixes tags(Parva)
> > (2)better commit log for patch 1/6(Michael)
> > (3)assign num_queues to max_supported_vqs than max_vq_pairs(Jason)
> > (4)initialize virtio pci capabilities in the probe() function.
> > 
> > Changes from V2:
> > Add fixes tags(Parva)
> > 
> > Changes from V1:
> > (1) Use __virito16_to_cpu(true, xxx) for the le16 casting(Jason)
> > (2) Add a comment in ifcvf_get_config_size(), to explain
> > why we should return the minimum value of
> > sizeof(struct virtio_net_config) and the onboard
> > cap size(Jason)
> > (3) Introduced a new attr VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES
> > (4) Show the changes of iproute2 output before and after 5/6 patch(Jason)
> > (5) Fix cast warning in vdpa_fill_stats_rec() 
> > 
> > Zhu Lingshan (6):
> >   vDPA/ifcvf: get_config_size should return a value no greater than dev
> >     implementation
> >   vDPA/ifcvf: support userspace to query features and MQ of a management
> >     device
> >   vDPA: allow userspace to query features of a vDPA device
> >   vDPA: !FEATURES_OK should not block querying device config space
> >   vDPA: Conditionally read fields in virtio-net dev config space
> >   fix 'cast to restricted le16' warnings in vdpa.c
> > 
> >  drivers/vdpa/ifcvf/ifcvf_base.c |  13 ++-
> >  drivers/vdpa/ifcvf/ifcvf_base.h |   2 +
> >  drivers/vdpa/ifcvf/ifcvf_main.c | 142 +++++++++++++++++---------------
> >  drivers/vdpa/vdpa.c             |  82 ++++++++++++------
> >  include/uapi/linux/vdpa.h       |   3 +
> >  5 files changed, 149 insertions(+), 93 deletions(-)
> > 
> > -- 
> > 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
