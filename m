Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAAFC00140
	for <virtualization@archiver.kernel.org>; Fri, 12 Aug 2022 11:14:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DA185400D1;
	Fri, 12 Aug 2022 11:14:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DA185400D1
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G/K2SXyJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HvUZWd70_Qcv; Fri, 12 Aug 2022 11:14:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4F91340121;
	Fri, 12 Aug 2022 11:14:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4F91340121
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 286E2C0032;
	Fri, 12 Aug 2022 11:14:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DEB5DC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Aug 2022 11:14:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B3D0C831A0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Aug 2022 11:14:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B3D0C831A0
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=G/K2SXyJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6MTghhDIwpuC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Aug 2022 11:14:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5AFD083183
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5AFD083183
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Aug 2022 11:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660302886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vjey9K3TeQYDdy1zlBcGzUENTBb/IIn2zN2Vn3gMAeY=;
 b=G/K2SXyJvFYGNTo3SyaRHtqBrP+8ZSLt58QOOtpKaMyhPMnrOLTWvbK4poVQaG3bEk7ps9
 BFexmT7R/q4xXVlgEYzZTriT/PGGAbY3Tz9i/J4KEWMhbsZPAAbYxHE3lp06LiV+svYx50
 KzqhRtm7t8e2+10NRiufJ5bIRJSBYjo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-640-pq9D9a-DMmWoM4fB48YEIg-1; Fri, 12 Aug 2022 07:14:45 -0400
X-MC-Unique: pq9D9a-DMmWoM4fB48YEIg-1
Received: by mail-wr1-f70.google.com with SMTP id
 e21-20020adf9bd5000000b002207a51b7feso64457wrc.10
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Aug 2022 04:14:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=Vjey9K3TeQYDdy1zlBcGzUENTBb/IIn2zN2Vn3gMAeY=;
 b=MR+nBZDUMbv8dER8sJ4+xMifQB5e0skdd0WyH35LZ6arVnLx5Z9WUGvsTjQJkYecAr
 6FNY6dOay9T3j1NYU2aKA1w+vIf9tT7TIF6J4efxyVb7px5GmmLcZtuCEt04yuFP0Mbj
 SR+kWIAp6inpf5BEm4MnNzmVPAyvhknSO9QDg6VYE0CWOpBASZ5qDuaNBcUJV+TciOEc
 rnS0UxwyZU6cejj52KeL7JokIkN0NiYmpT9qKdjmzWbgd6vooavbzOXdpi2Qs41Mj7uE
 /vOKVG/9qqZGxdSSG8F+BudSaRzzYbugVeGIZYPYXNcYbTG7Jnaymkk8cpCacknUQDRr
 LYAw==
X-Gm-Message-State: ACgBeo2qYWmvo1wnDbd47Eb00WBV173tmHPKchtK9rZhwjPir90XL6v3
 hXFoafSnJOTn/nWpRZsflQksGmGHOB3bfD7MSpxiyNyF5IUWqhjL4/bW4l2D9BWdCEL+vE4cA7A
 eJtNNsr8WmGjgXVQLFR8IwE2EjnshlA6UUX84oNUShw==
X-Received: by 2002:a05:600c:3c94:b0:3a5:373d:df0d with SMTP id
 bg20-20020a05600c3c9400b003a5373ddf0dmr2325151wmb.132.1660302884512; 
 Fri, 12 Aug 2022 04:14:44 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7J/dxXbbJOk5zZn+Sq4GfdrE6hekhKR5t2In0Rczaj/tO5ISPT0p2ZgrfSLLHtzOt4qDcffg==
X-Received: by 2002:a05:600c:3c94:b0:3a5:373d:df0d with SMTP id
 bg20-20020a05600c3c9400b003a5373ddf0dmr2324893wmb.132.1660302879372; 
 Fri, 12 Aug 2022 04:14:39 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7416:9d00:bb54:f6b1:32e:b9fc])
 by smtp.gmail.com with ESMTPSA id
 m8-20020a5d4a08000000b0021edb2d07bbsm1685611wrq.33.2022.08.12.04.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Aug 2022 04:14:38 -0700 (PDT)
Date: Fri, 12 Aug 2022 07:14:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Subject: Re: [PATCH V5 0/6] ifcvf/vDPA: support query device config space
 through netlink
Message-ID: <20220812071251-mutt-send-email-mst@kernel.org>
References: <20220812104500.163625-1-lingshan.zhu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20220812104500.163625-1-lingshan.zhu@intel.com>
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

On Fri, Aug 12, 2022 at 06:44:54PM +0800, Zhu Lingshan wrote:
> This series allows userspace to query device config space of vDPA
> devices and the management devices through netlink,
> to get multi-queue, feature bits and etc.
> 
> This series has introduced a new netlink attr
> VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES, this should be used to query
> features of vDPA  devices than the management device.
> 
> Please help review.

I can't merge this for this merge window.
Am I right when I say that the new thing here is patch 5/6 + new
comments?
If yes I can queue it out of the window, on top.

> Thanks!
> Zhu Lingshan
> 
> Changes rom V4:
> (1) Read MAC, MTU, MQ conditionally (Michael)
> (2) If VIRTIO_NET_F_MAC not set, don't report MAC to userspace
> (3) If VIRTIO_NET_F_MTU not set, report 1500 to userspace
> (4) Add comments to the new attr
> VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES(Michael)
> (5) Add comments for reporting the device status as LE(Michael)
> 
> Changes from V3:
> (1)drop the fixes tags(Parva)
> (2)better commit log for patch 1/6(Michael)
> (3)assign num_queues to max_supported_vqs than max_vq_pairs(Jason)
> (4)initialize virtio pci capabilities in the probe() function.
> 
> Changes from V2:
> Add fixes tags(Parva)
> 
> Changes from V1:
> (1) Use __virito16_to_cpu(true, xxx) for the le16 casting(Jason)
> (2) Add a comment in ifcvf_get_config_size(), to explain
> why we should return the minimum value of
> sizeof(struct virtio_net_config) and the onboard
> cap size(Jason)
> (3) Introduced a new attr VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES
> (4) Show the changes of iproute2 output before and after 5/6 patch(Jason)
> (5) Fix cast warning in vdpa_fill_stats_rec() 
> 
> Zhu Lingshan (6):
>   vDPA/ifcvf: get_config_size should return a value no greater than dev
>     implementation
>   vDPA/ifcvf: support userspace to query features and MQ of a management
>     device
>   vDPA: allow userspace to query features of a vDPA device
>   vDPA: !FEATURES_OK should not block querying device config space
>   vDPA: Conditionally read fields in virtio-net dev config space
>   fix 'cast to restricted le16' warnings in vdpa.c
> 
>  drivers/vdpa/ifcvf/ifcvf_base.c |  13 ++-
>  drivers/vdpa/ifcvf/ifcvf_base.h |   2 +
>  drivers/vdpa/ifcvf/ifcvf_main.c | 142 +++++++++++++++++---------------
>  drivers/vdpa/vdpa.c             |  82 ++++++++++++------
>  include/uapi/linux/vdpa.h       |   3 +
>  5 files changed, 149 insertions(+), 93 deletions(-)
> 
> -- 
> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
