Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D12FBF0
	for <virtualization@lists.linux-foundation.org>; Mon,  4 Dec 2023 08:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hKttobFF"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B1FA60B3C
	for <virtualization@lists.linux-foundation.org>; Mon,  4 Dec 2023 08:55:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4B1FA60B3C
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hKttobFF
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JJ1O5j4cPhez
	for <virtualization@lists.linux-foundation.org>;
	Mon,  4 Dec 2023 08:55:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2263260757
	for <virtualization@lists.linux-foundation.org>; Mon,  4 Dec 2023 08:55:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2263260757
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701680114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0AN6JCFDsnCGduiL8fNvKVYamhB7M2dQghKbiuZenRQ=;
	b=hKttobFFBexPdGcwBKlWGWQijl4smwvSFj/zv1+j1plYUDtWT50gsRLwitqfemyXgK/44o
	G2a6QDzfR9Nfj+HI0LZeRfAk+cMX4jdRyCp0fPPpjQFqwnwnFnAMu7sog9ZnEvREmpCtxW
	hiXRaqeOv9maH4a1Bkm/Zhe3WMq6CO4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-2DNIWppPOhSoh2h8CKaQ3A-1; Mon, 04 Dec 2023 03:55:13 -0500
X-MC-Unique: 2DNIWppPOhSoh2h8CKaQ3A-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-332ee20a3f0so4033063f8f.0
        for <virtualization@lists.linux-foundation.org>; Mon, 04 Dec 2023 00:55:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701680112; x=1702284912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AN6JCFDsnCGduiL8fNvKVYamhB7M2dQghKbiuZenRQ=;
        b=GmjAwV1eANdGNdlYtwM7HQ8EgEWbHt3n7mty5o+oWneovBMm2r0u3x3Ib44TnsAZmV
         aB77Ci2R9oNNTQgeaHlqkp7iLjU0OrZgieJnyRTA6MywxQ7m+99Y5g/o7y7QN/eM8alE
         8WwSvbzH+7tapgfEZuccyWFXCA2e2oBFS/+dKM0bPk4wFjypYoD0i9gXz/TbOA+qo0sF
         d3D7GG3/IB9wngk1mQaHmrmN+3L9sZ1kEnCsH4XXU+skrRB034FJMGi2izfjoY3AqQg2
         hTv78vQlL4MRKiHylFLq/7/k1nL5RsTCvy4G+GXMQU5AIaVxr20ysCwOpFRgSQmqHRxr
         Lorw==
X-Gm-Message-State: AOJu0YyvtgkIoWNIBVZwi429jGVT/ZIf9oWiH/buuo758LlgcVHnYMfI
	/r/lps5TL2Wl2VljSQPq84RQUTLkbB4nVz2NbVDpPGTHsNE9cOmLGGOCauNDW3EqN1R2eLLDaxj
	0W95pxGtcw08aGGtjDalGhnrjfqkvMi3AZPPZLLCrSg==
X-Received: by 2002:adf:fe03:0:b0:333:2fd2:765e with SMTP id n3-20020adffe03000000b003332fd2765emr1292011wrr.79.1701680112061;
        Mon, 04 Dec 2023 00:55:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6o767vIbm8ZsJXOcZvJBzFh+btgTQgB0JYi5+5AiuODwwmWvCd5ESmGDV8zXhTYkKs+bnzA==
X-Received: by 2002:adf:fe03:0:b0:333:2fd2:765e with SMTP id n3-20020adffe03000000b003332fd2765emr1292008wrr.79.1701680111648;
        Mon, 04 Dec 2023 00:55:11 -0800 (PST)
Received: from redhat.com ([2.55.57.48])
        by smtp.gmail.com with ESMTPSA id b12-20020a05600010cc00b0033340aa3de2sm4299066wrx.14.2023.12.04.00.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 00:55:11 -0800 (PST)
Date: Mon, 4 Dec 2023 03:55:07 -0500
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
Message-ID: <20231204035443-mutt-send-email-mst@kernel.org>
References: <20231201104857.665737-1-dtatulea@nvidia.com>
 <20231202152523-mutt-send-email-mst@kernel.org>
 <aff0361edcb0fd0c384bf297e71d25fb77570e15.camel@nvidia.com>
 <20231203112324-mutt-send-email-mst@kernel.org>
 <e088b2ac7a197352429d2f5382848907f98c1129.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <e088b2ac7a197352429d2f5382848907f98c1129.camel@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 04, 2023 at 08:53:26AM +0000, Dragos Tatulea wrote:
> On Sun, 2023-12-03 at 11:23 -0500, Michael S. Tsirkin wrote:
> > On Sun, Dec 03, 2023 at 03:21:01PM +0000, Dragos Tatulea wrote:
> > > On Sat, 2023-12-02 at 15:26 -0500, Michael S. Tsirkin wrote:
> > > > On Fri, Dec 01, 2023 at 12:48:50PM +0200, Dragos Tatulea wrote:
> > > > > Add support for resumable vqs in the driver. This is a firmware feature
> > > > > that can be used for the following benefits:
> > > > > - Full device .suspend/.resume.
> > > > > - .set_map doesn't need to destroy and create new vqs anymore just to
> > > > >   update the map. When resumable vqs are supported it is enough to
> > > > >   suspend the vqs, set the new maps, and then resume the vqs.
> > > > > 
> > > > > The first patch exposes the relevant bits in mlx5_ifc.h. That means it
> > > > > needs to be applied to the mlx5-vhost tree [0] first.
> > > > 
> > > > I didn't get this. Why does this need to go through that tree?
> > > > Is there a dependency on some other commit from that tree?
> > > > 
> > > To avoid merge issues in Linus's tree in mlx5_ifc.h. The idea is the same as for
> > > the "vq descriptor mappings" patchset [1].
> > > 
> > > Thanks,
> > > Dragos
> > 
> > Are there other changes in that area that will cause non-trivial merge
> > conflicts?
> > 
> There are pending changes in mlx5_ifc.h for net-next. I haven't seen any changes
> around the touched structure but I would prefer not to take any risk.
> 
> Thanks,
> Dragos

This is exactly what linux-next is for.


> > > > > Once applied
> > > > > there, the change has to be pulled from mlx5-vhost into the vhost tree
> > > > > and only then the remaining patches can be applied. Same flow as the vq
> > > > > descriptor mappings patchset [1].
> > > > > 
> > > > > To be able to use resumable vqs properly, support for selectively modifying
> > > > > vq parameters was needed. This is what the middle part of the series
> > > > > consists of.
> > > > > 
> > > > > [0] https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/log/?h=mlx5-vhost
> > > > > [1] https://lore.kernel.org/virtualization/20231018171456.1624030-2-dtatulea@nvidia.com/
> > > > > 
> > > > > Dragos Tatulea (7):
> > > > >   vdpa/mlx5: Expose resumable vq capability
> > > > >   vdpa/mlx5: Split function into locked and unlocked variants
> > > > >   vdpa/mlx5: Allow modifying multiple vq fields in one modify command
> > > > >   vdpa/mlx5: Introduce per vq and device resume
> > > > >   vdpa/mlx5: Mark vq addrs for modification in hw vq
> > > > >   vdpa/mlx5: Mark vq state for modification in hw vq
> > > > >   vdpa/mlx5: Use vq suspend/resume during .set_map
> > > > > 
> > > > >  drivers/vdpa/mlx5/core/mr.c        |  31 +++---
> > > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 172 +++++++++++++++++++++++++----
> > > > >  include/linux/mlx5/mlx5_ifc.h      |   3 +-
> > > > >  include/linux/mlx5/mlx5_ifc_vdpa.h |   4 +
> > > > >  4 files changed, 174 insertions(+), 36 deletions(-)
> > > > > 
> > > > > -- 
> > > > > 2.42.0
> > > > 
> > > 
> > 
> 

