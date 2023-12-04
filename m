Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D6D22EE0
	for <virtualization@lists.linux-foundation.org>; Mon,  4 Dec 2023 11:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="if5pbhE3"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B9C760F68
	for <virtualization@lists.linux-foundation.org>; Mon,  4 Dec 2023 11:05:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2B9C760F68
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=if5pbhE3
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id etF-Vg0Xvzn5
	for <virtualization@lists.linux-foundation.org>;
	Mon,  4 Dec 2023 11:05:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 85E2E60F79
	for <virtualization@lists.linux-foundation.org>; Mon,  4 Dec 2023 11:05:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 85E2E60F79
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701687905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aT/At2upGCT9VPho4S8jj9YWkQ5O4LoKTBPlC60T3Pg=;
	b=if5pbhE3MjYnVJhwyy3S//mYKc9DaG5QobVupK00wMLkC+eEulmRSn40EXfhuNZg8A9yY7
	cH8m8QN6Wm9iz19pt0tpdKPni2OoE49hVGl0FhoT4F7SeX4FkUiIgzghFgHdfjJa8YAvV+
	6cdZOhcj4/OgyjYpWVS5KQOK8a2iP5A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-2EEv9MMHPKGls3-AqH2W5w-1; Mon, 04 Dec 2023 06:04:52 -0500
X-MC-Unique: 2EEv9MMHPKGls3-AqH2W5w-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33344663fbcso993342f8f.2
        for <virtualization@lists.linux-foundation.org>; Mon, 04 Dec 2023 03:04:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701687887; x=1702292687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aT/At2upGCT9VPho4S8jj9YWkQ5O4LoKTBPlC60T3Pg=;
        b=kVPBfTcz9EuM7COkoz7LTeIG3zMbHeLii0N9wCkyDeBRYmsHIUYqXR3+Fw3+VzjIdd
         GBFYrj9+/UEmGK5imRG9/HvYiUhz5b7DNvZtnxBF2mC33uYwG+l59u1xJHx1q9BL4mW3
         mW0+KnBopwbLvithFPsW9ikT9yaaOhbQQPPGRR5+tyXW9MvP4EkzBm13eP91hYs47rcw
         nnQlM6lfyuZBzNBpP8m9gEc1VIzCQb1Vh3yCcNThUs4zRiQh00i5LpR3tC7Pcr+pIbkT
         pd/yZBRI7DU11/pPighT18eu4EPctUnpmvbg4k0KCWu0FDMMspZJ6QTcg3lPYEFbuvnm
         nEnA==
X-Gm-Message-State: AOJu0YzEHN3tMPpQvW9ia1k4nsHbYANy33GzrbKXdBfCC7pMW4fXyxxi
	tHDnh1cMDUMRW5YMvBaeDA9hMPn7iHJIGYxc14JGSJrzIufNCGSXkKbq2P+zRsqFiBchcF9WEn9
	j73dQzGV8eR/6pC72p7q/rDq460xUhMNJ3tGkTg+Zsw==
X-Received: by 2002:a7b:ce8d:0:b0:40c:b81:d31e with SMTP id q13-20020a7bce8d000000b0040c0b81d31emr342749wmj.148.1701687887346;
        Mon, 04 Dec 2023 03:04:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFihxBxPdB2ys3q394rHHxaK//1lPggGSVUB+ncquBCZ170Lw3mhpOTy808C1BWlo7xnT0FBw==
X-Received: by 2002:a7b:ce8d:0:b0:40c:b81:d31e with SMTP id q13-20020a7bce8d000000b0040c0b81d31emr342733wmj.148.1701687886974;
        Mon, 04 Dec 2023 03:04:46 -0800 (PST)
Received: from redhat.com ([2.55.57.48])
        by smtp.gmail.com with ESMTPSA id f17-20020a05600c155100b004083729fc14sm18256693wmg.20.2023.12.04.03.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 03:04:46 -0800 (PST)
Date: Mon, 4 Dec 2023 06:04:42 -0500
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
Message-ID: <20231204060300-mutt-send-email-mst@kernel.org>
References: <20231201104857.665737-1-dtatulea@nvidia.com>
 <20231202152523-mutt-send-email-mst@kernel.org>
 <aff0361edcb0fd0c384bf297e71d25fb77570e15.camel@nvidia.com>
 <20231203112324-mutt-send-email-mst@kernel.org>
 <e088b2ac7a197352429d2f5382848907f98c1129.camel@nvidia.com>
 <20231204035443-mutt-send-email-mst@kernel.org>
 <b9f5c48788daa3ac335b589b2ad23ea8366c08ba.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <b9f5c48788daa3ac335b589b2ad23ea8366c08ba.camel@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 04, 2023 at 09:16:07AM +0000, Dragos Tatulea wrote:
> On Mon, 2023-12-04 at 03:55 -0500, Michael S. Tsirkin wrote:
> > On Mon, Dec 04, 2023 at 08:53:26AM +0000, Dragos Tatulea wrote:
> > > On Sun, 2023-12-03 at 11:23 -0500, Michael S. Tsirkin wrote:
> > > > On Sun, Dec 03, 2023 at 03:21:01PM +0000, Dragos Tatulea wrote:
> > > > > On Sat, 2023-12-02 at 15:26 -0500, Michael S. Tsirkin wrote:
> > > > > > On Fri, Dec 01, 2023 at 12:48:50PM +0200, Dragos Tatulea wrote:
> > > > > > > Add support for resumable vqs in the driver. This is a firmware feature
> > > > > > > that can be used for the following benefits:
> > > > > > > - Full device .suspend/.resume.
> > > > > > > - .set_map doesn't need to destroy and create new vqs anymore just to
> > > > > > >   update the map. When resumable vqs are supported it is enough to
> > > > > > >   suspend the vqs, set the new maps, and then resume the vqs.
> > > > > > > 
> > > > > > > The first patch exposes the relevant bits in mlx5_ifc.h. That means it
> > > > > > > needs to be applied to the mlx5-vhost tree [0] first.
> > > > > > 
> > > > > > I didn't get this. Why does this need to go through that tree?
> > > > > > Is there a dependency on some other commit from that tree?
> > > > > > 
> > > > > To avoid merge issues in Linus's tree in mlx5_ifc.h. The idea is the same as for
> > > > > the "vq descriptor mappings" patchset [1].
> > > > > 
> > > > > Thanks,
> > > > > Dragos
> > > > 
> > > > Are there other changes in that area that will cause non-trivial merge
> > > > conflicts?
> > > > 
> > > There are pending changes in mlx5_ifc.h for net-next. I haven't seen any changes
> > > around the touched structure but I would prefer not to take any risk.
> > > 
> > > Thanks,
> > > Dragos
> > 
> > This is exactly what linux-next is for.
> > 
> Not sure what the suggestion is here. Is it:
> 
> 1) To post patch 1/7 to net-next? Then we'd have to wait for a few weeks to make
> sure that it gets into the next tree.
> 
> or 
> 
> 2) To apply it into the vhost tree directly? Then we run the risk of having
> merge issues.
> 
> The "pull from branch" approach for cross subsystem changes was suggested by
> Linus this merge issue.
> 
> [0]
> https://lore.kernel.org/all/CA+55aFxxoO=i7neGBRGW_afHsSZ7K-x6fMO8v-8po3Ls_Ew0Rg@mail.gmail.com/
> 
> Thanks,
> Dragos

I will park this in my tree for now so it can get testing in linux next.
When it's available in some other tree as well, let me know and
I'll figure it out.

-- 
MST

