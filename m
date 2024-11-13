Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A43E22092
	for <virtualization@lists.linux.dev>; Wed, 13 Nov 2024 01:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731462341; cv=none; b=ARkQZsr808S44sBIwkgBb/e2pwuUT9xL8rb7YXXCGmVF+j4RB661C1rm2PRybQ6WgcWoTfnBs1O823eGssfRCbKPz+4Lf8AdT1tuVfS6sA9mWabPSiJBT9wG6BtMy3S9C/ykGC85phtWCS6NXEzP7ncFxmKiwel5Dxf6vPM0jKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731462341; c=relaxed/simple;
	bh=IHqK+x1Y09bwvF/XCMLoniBLajGJIlrCvJ2pbrpso1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MvlKATaNh1wv+iKIV12Pzeb0VAqiBxWvDqK3XwYBA8UeWLF6vy2BxlRQvhTaEduX1RqLqM7X7iSVJSsGKUgP/IC2J1w7NJvydV+WjhgXpSh126WPR1kzJCUCIuHXcEeSm5rgSldE84RCbs1GIY7eSDK0CJ9zI3AULyz20S4Eweo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cIifM1pP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cIifM1pP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731462338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4PfKM7yVBtn6DsluopLq3/TSPiAd2245iTdr55Tku6s=;
	b=cIifM1pPGWYMXd1wUAbEI04mUJS78d2fvmoh7sbSFEfDk4Fa8g+bIU+G2HYcddINGAoZr/
	JqilwqppbKBmv7B338Pn52HXIEl2DOsS+kh90cOQyE93xx6uBBTZ6FTnCs8Wey/G+NQHOO
	k09fKCwYMdYhl5aCpPTN+ajihlOMtJM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-svnE66rNPBGJnX5K6i1UBA-1; Tue, 12 Nov 2024 20:45:37 -0500
X-MC-Unique: svnE66rNPBGJnX5K6i1UBA-1
X-Mimecast-MFC-AGG-ID: svnE66rNPBGJnX5K6i1UBA
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2e2bac0c38aso7501192a91.2
        for <virtualization@lists.linux.dev>; Tue, 12 Nov 2024 17:45:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731462336; x=1732067136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4PfKM7yVBtn6DsluopLq3/TSPiAd2245iTdr55Tku6s=;
        b=Y+O0SEboObNaQ5yMzXVfOC103LdguaEzJgfY+NdftKLNZ++YHNEZVGnPittbS3Az3n
         OhpKmaVEA0Us1idWVkiDL8Hi7V9jVfSojUzVYqEmoi93D4K3HZAzYj6nBcbjMGZ8pi01
         XasSCbfQ+gtxxWbykZf5LnOTVGAGbKh/d5DgbpEtJdali6ipEGi6w4uK4z+r1JtOIx+m
         Pjm3GGiM2FTPfjyRsoBFzwHWHrYAoFt5F+sbmiX9a9nXB2GctNFxfAMfXK3xZnWeeIOY
         G59x7exWNbEvPIuI5HIVKRbvtnsCQ/0fJMvZr1JkVt8mV/syyMP4UT63HTWuWs5d305y
         dDdg==
X-Forwarded-Encrypted: i=1; AJvYcCWHG6Fcbns2ctkUSmZfKlXXloEFvcsDct1y8FkDM+frOW5DUgirBvCBJXpBVtRy8Sx3KVDH5ikTrRheykEc2A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxr8spgypqMHMLsgSSVO95nqWPHLLt1K3MGlhg9GkSsNKbMmY31
	rqGSQo6CNnS56542TwP6nREuvRk+SREMyk/487I9mHsdE3S2spi3oyGSqcK4gDvSk/Jn1ceBDuk
	CSw4LOVWU9X2f7l8L/6NqY3yIUhNqu9kqdRL0t1EnnoFlqNr3LRj/Bt5aOea/L8d01QusHDMm7U
	QZlg6Fvs+a0u3UccbFxFtmxaq528ZuvWKc8vmHWHM=
X-Received: by 2002:a17:90b:2688:b0:2e2:cd80:4d44 with SMTP id 98e67ed59e1d1-2e9f2d5e8e7mr1164939a91.28.1731462336102;
        Tue, 12 Nov 2024 17:45:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpt28y46cAkPewPR7Xrwmv966EDN/L2ttyudwenZUFGZgN49d7cCsAg3yPz/0wpucLUNN5z0msD0DruQuHYlQ=
X-Received: by 2002:a17:90b:2688:b0:2e2:cd80:4d44 with SMTP id
 98e67ed59e1d1-2e9f2d5e8e7mr1164913a91.28.1731462335659; Tue, 12 Nov 2024
 17:45:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241021134040.975221-1-dtatulea@nvidia.com> <8e93cd9e-7237-4863-a5a7-a6561d5ca015@nvidia.com>
In-Reply-To: <8e93cd9e-7237-4863-a5a7-a6561d5ca015@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 13 Nov 2024 09:45:22 +0800
Message-ID: <CACGkMEtALWqmoyOBu8vywnk=SuU=N1zKt7sxwueKkYQi3LB0MQ@mail.gmail.com>
Subject: Re: [PATCH vhost 0/2] vdpa/mlx5: Iova mapping related fixes
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Si-Wei Liu <si-wei.liu@oracle.com>, Eugenio Perez Martin <eperezma@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 793AkgsJhXJSe5wskMx_hNQY_EFbgNmhyGRbPFv8E3o_1731462336
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 4:58=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
>
>
> On 21.10.24 15:40, Dragos Tatulea wrote:
> > Here are 2 fixes from Si-Wei:
> > - The first one is an important fix that has to be applied as far
> >   back as possible (hence CC'ing linux-stable).
> > - The second is more of an improvement. That's why it doesn't have the
> >   Fixes tag.
> >
> > I'd like to thank Si-Wei for the effort of finding and fixing these
> > issues. Especially the first issue which was very well hidden and
> > was there since day 1.
> >
> > Si-Wei Liu (2):
> >   vdpa/mlx5: Fix PA offset with unaligned starting iotlb map
> >   vdpa/mlx5: Fix suboptimal range on iotlb iteration
> >
> >  drivers/vdpa/mlx5/core/mr.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> Gentle nudge for a review. The bug fixed by the first patch is a very
> serious and insidious one.

I think I've acked to those patches, have you received that?

Thanks

>
> Thanks,
> Dragos
>
>

