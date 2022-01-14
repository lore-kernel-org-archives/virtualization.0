Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94A2C433F5
	for <virtualization@archiver.kernel.org>; Fri, 14 Jan 2022 23:50:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 508BB82974;
	Fri, 14 Jan 2022 23:50:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gc5EPSaCKdSi; Fri, 14 Jan 2022 23:50:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ED5ED8291D;
	Fri, 14 Jan 2022 23:50:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5C39C002F;
	Fri, 14 Jan 2022 23:50:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7F14C001E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 23:50:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 86C21410AB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 23:50:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vYV7ZK71QV-A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 23:50:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D636D4098D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 23:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642204218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wQKAQp3punPuo3jodbvvWKcFENKeN8QBsPxGUfPzlv8=;
 b=D/jW+5ljzLLD4BBWt1d9r3Mz8OP1cjx0I62Ox4vp1axorkzI3lL4F60xdvMbxgJAd57R5L
 UzTwPa1d6Ht3tShx+tWEQ8KkfZFk75PLdr/E9eVCoqOElcGgNnmFcLIdVqZlxSnI1F2SwC
 Wj9Gz8mt3pvQjUYobz9IoxK8yJuSiv4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-416-dMWbb16iO9yXoq8QH_5H2A-1; Fri, 14 Jan 2022 18:50:17 -0500
X-MC-Unique: dMWbb16iO9yXoq8QH_5H2A-1
Received: by mail-wm1-f72.google.com with SMTP id
 a3-20020a05600c348300b0034a0dfc86aaso6314591wmq.6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 15:50:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wQKAQp3punPuo3jodbvvWKcFENKeN8QBsPxGUfPzlv8=;
 b=ax2tAxCSzs1fYVJAcW3Z2zh9LMoo5dO2TdUy+hgDb5zKmBzrBT+bOErAHISYkxzhgt
 GSmxMDA6VXGN8ImqFTlnojn/nkRukADLMttFizx0/ghTyaydOjH5QqLK2snRuhDxJ9qj
 rlSTRiSydIEjlB49icah/tEvtvs7m1g+4rNBzbKs0JD+yc+Uexoai3G7slVWKOlR44ez
 yZFjrePVazOByUYlt0jDLWNsE79FMqv0fDsEjE6ohhDjzVdiUWpd/kGEi/U7O9qe0VPx
 V8dr334vVYpUJuWzTc49YEkpAffXxdpy2LRvIbVt63DPuPzzLimh8WOAtsg7rpbsIrOX
 1ZMQ==
X-Gm-Message-State: AOAM531RoYugo61mIJ2G/ArU3UpipBww8g5IH58EAV/qMKRCEFUnJ+N0
 HtYkM0GSSepuI7dPNhsq6HSu8amrnkye2jPG1/nQInMyoYXZcR8kuDxkym+DfMmaLU5ELaS9YX5
 i4lBzSXcpIcDPVoQDBmQGa8O9VkeJ0j3rhya/fvybbA==
X-Received: by 2002:a05:6000:2c8:: with SMTP id
 o8mr420814wry.366.1642204216489; 
 Fri, 14 Jan 2022 15:50:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJypJ87tcfmR3bXkhkalO7yqmUU3OIYhufRb3IdZu48YZ8Mj2eS/XA9CKPzuAUCrrnMJrp7WRw==
X-Received: by 2002:a05:6000:2c8:: with SMTP id
 o8mr420775wry.366.1642204216253; 
 Fri, 14 Jan 2022 15:50:16 -0800 (PST)
Received: from redhat.com ([2.55.154.210])
 by smtp.gmail.com with ESMTPSA id r7sm15078419wmq.18.2022.01.14.15.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jan 2022 15:50:15 -0800 (PST)
Date: Fri, 14 Jan 2022 18:50:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [GIT PULL] virtio,vdpa,qemu_fw_cfg: features, cleanups, fixes
Message-ID: <20220114184916-mutt-send-email-mst@kernel.org>
References: <20220114153515-mutt-send-email-mst@kernel.org>
 <YeHjbqjY8Dd+3o1E@larix>
MIME-Version: 1.0
In-Reply-To: <YeHjbqjY8Dd+3o1E@larix>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: yun.wang@linux.alibaba.com, kvm@vger.kernel.org, trix@redhat.com,
 flyingpeng@tencent.com, virtualization@lists.linux-foundation.org,
 elic@nvidia.com, guanjun@linux.alibaba.com, lkp@intel.com,
 xianting.tian@linux.alibaba.com, pasic@linux.ibm.com, eperezma@redhat.com,
 luolikang@nsfocus.com, wu000273@umn.edu, lvivier@redhat.com,
 keescook@chromium.org, somlo@cmu.edu, jiasheng@iscas.ac.cn, johan@kernel.org,
 christophe.jaillet@wanadoo.fr, flyingpenghao@gmail.com, dapeng1.mi@intel.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, labbott@kernel.org,
 gregkh@linuxfoundation.org, lingshan.zhu@intel.com,
 Linus Torvalds <torvalds@linux-foundation.org>
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

On Fri, Jan 14, 2022 at 08:56:14PM +0000, Jean-Philippe Brucker wrote:
> Hi,
> 
> On Fri, Jan 14, 2022 at 03:35:15PM -0500, Michael S. Tsirkin wrote:
> > Jean-Philippe Brucker (5):
> >       iommu/virtio: Add definitions for VIRTIO_IOMMU_F_BYPASS_CONFIG
> >       iommu/virtio: Support bypass domains
> >       iommu/virtio: Sort reserved regions
> >       iommu/virtio: Pass end address to viommu_add_mapping()
> >       iommu/virtio: Support identity-mapped domains
> 
> Please could you drop these patches, they are from an old version of the
> series. The newer version was already in Joerg's pull request and was
> merged, so this will conflict.
> 
> Thanks,
> Jean

It's weird that this wasn't detected, these have been in linux-next
for a long time now. I'l drop, though it's unfortunate as
hashes will not match with what was tested in linux-next.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
