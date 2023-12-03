Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0592B15AE2
	for <virtualization@lists.linux-foundation.org>; Sun,  3 Dec 2023 16:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KVrxEqa6"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 853E781B70
	for <virtualization@lists.linux-foundation.org>; Sun,  3 Dec 2023 16:24:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 853E781B70
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KVrxEqa6
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kjrSJEXmWE1c
	for <virtualization@lists.linux-foundation.org>;
	Sun,  3 Dec 2023 16:24:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 754BB81AF5
	for <virtualization@lists.linux-foundation.org>; Sun,  3 Dec 2023 16:24:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 754BB81AF5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701620640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lnZvOG5O1XML8m5bdEgP0BLaNE6m6L+TFl+VYXFF/Gc=;
	b=KVrxEqa6e8Wi2KaLwjJhDYWBv3KGd6Epv25VDyJCqMPRq2wkMAVMWXBqherD6IVwRlBru3
	xlTDi4aJE3hd+/3EA3Q86/hByvTjQHp1y3RtJCYC3SdeduIgD3USWX7Elbb4QYYjTGOh7G
	BdTECb1aJhaPZv4qWD9rItax7kSkrt0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-Ze3S3-mmOLa1AL57DltTDg-1; Sun, 03 Dec 2023 11:23:57 -0500
X-MC-Unique: Ze3S3-mmOLa1AL57DltTDg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40b3487fa9eso31421775e9.2
        for <virtualization@lists.linux-foundation.org>; Sun, 03 Dec 2023 08:23:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701620636; x=1702225436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnZvOG5O1XML8m5bdEgP0BLaNE6m6L+TFl+VYXFF/Gc=;
        b=WdqihrX5s96XQdbXZL8npq+sFc/9mpQ8a7Q8VTu2Y/nkeJ+3l7yH398GyrCtX8SOr8
         Jd58O2SLIyDhJYWsGx0GBx5t4qhmsF0o3/kP7tG+6vbR+BpH9kjgBp8kPRY1jtvtJ2Ra
         5V7z3VbvElq55K2mXUVnVeem6z6lSydcaC8IKQQ2WwmIj6gd7rsZc8I/KV84KZt0mXCr
         17u/C7uMcW6u+RS5i6aaxjSUuesFPUov+SqP7LTis7nqCxU8C62zr/Yriinezy74a+Ms
         u32gmifpTKMpl/LkLusWlK/5UzPEhrQ5MskVqB4A9Xk7IoVCwJIGzvRej8s+Cb+l/p0h
         o8Ww==
X-Gm-Message-State: AOJu0YyXqI/pvL4wnSX7Jeyxp/d9TL/d7uLHYR4jDZwqeek/Mdo+wWKL
	pbYi4+GtBzvzJjpEvM6oGJs5VqwqwK9mt1Zgo4sl51l2teZ7VCLpZKBLE/YC1hPdpilO2A7e1C6
	5aqobLIq2W6LHmd8z9oaUDXKlozBtZY6UhAGD/mB9yA==
X-Received: by 2002:a05:600c:705:b0:40b:5e21:dd4f with SMTP id i5-20020a05600c070500b0040b5e21dd4fmr1874532wmn.125.1701620635910;
        Sun, 03 Dec 2023 08:23:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKP9eXqXIJINqxrVU9tyc8Z3UHQwADTnS0+oYOUt7wpJ1p/7gUBKwhI0K0i3D0cbqq7yqUBw==
X-Received: by 2002:a05:600c:705:b0:40b:5e21:dd4f with SMTP id i5-20020a05600c070500b0040b5e21dd4fmr1874523wmn.125.1701620635528;
        Sun, 03 Dec 2023 08:23:55 -0800 (PST)
Received: from redhat.com ([2.55.11.133])
        by smtp.gmail.com with ESMTPSA id jg23-20020a05600ca01700b0040b30be6244sm12148007wmb.24.2023.12.03.08.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 08:23:54 -0800 (PST)
Date: Sun, 3 Dec 2023 11:23:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	Parav Pandit <parav@nvidia.com>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"si-wei.liu@oracle.com" <si-wei.liu@oracle.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"galp@nvidia.com" <galp@nvidia.com>,
	"leon@kernel.org" <leon@kernel.org>
Subject: Re: [PATCH vhost 0/7] vdpa/mlx5: Add support for resumable vqs
Message-ID: <20231203112324-mutt-send-email-mst@kernel.org>
References: <20231201104857.665737-1-dtatulea@nvidia.com>
 <20231202152523-mutt-send-email-mst@kernel.org>
 <aff0361edcb0fd0c384bf297e71d25fb77570e15.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aff0361edcb0fd0c384bf297e71d25fb77570e15.camel@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 03, 2023 at 03:21:01PM +0000, Dragos Tatulea wrote:
> On Sat, 2023-12-02 at 15:26 -0500, Michael S. Tsirkin wrote:
> > On Fri, Dec 01, 2023 at 12:48:50PM +0200, Dragos Tatulea wrote:
> > > Add support for resumable vqs in the driver. This is a firmware feature
> > > that can be used for the following benefits:
> > > - Full device .suspend/.resume.
> > > - .set_map doesn't need to destroy and create new vqs anymore just to
> > >   update the map. When resumable vqs are supported it is enough to
> > >   suspend the vqs, set the new maps, and then resume the vqs.
> > > 
> > > The first patch exposes the relevant bits in mlx5_ifc.h. That means it
> > > needs to be applied to the mlx5-vhost tree [0] first.
> > 
> > I didn't get this. Why does this need to go through that tree?
> > Is there a dependency on some other commit from that tree?
> > 
> To avoid merge issues in Linus's tree in mlx5_ifc.h. The idea is the same as for
> the "vq descriptor mappings" patchset [1].
> 
> Thanks,
> Dragos

Are there other changes in that area that will cause non-trivial merge
conflicts?

> > > Once applied
> > > there, the change has to be pulled from mlx5-vhost into the vhost tree
> > > and only then the remaining patches can be applied. Same flow as the vq
> > > descriptor mappings patchset [1].
> > > 
> > > To be able to use resumable vqs properly, support for selectively modifying
> > > vq parameters was needed. This is what the middle part of the series
> > > consists of.
> > > 
> > > [0] https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/log/?h=mlx5-vhost
> > > [1] https://lore.kernel.org/virtualization/20231018171456.1624030-2-dtatulea@nvidia.com/
> > > 
> > > Dragos Tatulea (7):
> > >   vdpa/mlx5: Expose resumable vq capability
> > >   vdpa/mlx5: Split function into locked and unlocked variants
> > >   vdpa/mlx5: Allow modifying multiple vq fields in one modify command
> > >   vdpa/mlx5: Introduce per vq and device resume
> > >   vdpa/mlx5: Mark vq addrs for modification in hw vq
> > >   vdpa/mlx5: Mark vq state for modification in hw vq
> > >   vdpa/mlx5: Use vq suspend/resume during .set_map
> > > 
> > >  drivers/vdpa/mlx5/core/mr.c        |  31 +++---
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 172 +++++++++++++++++++++++++----
> > >  include/linux/mlx5/mlx5_ifc.h      |   3 +-
> > >  include/linux/mlx5/mlx5_ifc_vdpa.h |   4 +
> > >  4 files changed, 174 insertions(+), 36 deletions(-)
> > > 
> > > -- 
> > > 2.42.0
> > 
> 

