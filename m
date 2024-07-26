Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED4817C200
	for <virtualization@lists.linux-foundation.org>; Fri, 26 Jul 2024 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722000080; cv=none; b=NsEKKnlRGLd8JzM12VaKk5HB6fQyTfg1RSWkKAN1ce/SQeg7pc5EnITrxj/qgBXT8pf9+fpbikCozQRdFemZQWcMdrJf2rM+WCFU+FlxFf01muddzYrLsFlU0coyNR+K3T5Id9GgaVh5lYBcWUkxZCiGrAYmVcQpSebFSIkIsYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722000080; c=relaxed/simple;
	bh=K65IvizrkiF4Iqqucr2Z1Xdr6ozHH4a8FmSnlkgup3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Ci/hznonT28LYVng+Ptc49YayUe1Vb260ayVD7oU1gH+24J2Qf7O5BGqMG/7iR/ZQPpiUl4yERgLgsr3djLWmKMYKHfmkXwZM9wVPsIyvjxZF4GHjFu+XMuoApkfTLVmL1yzO1wDtMoD4wcjBJZl+cal5+PJRVPk1JFTIMOr2qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KQt4Sj7b; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KQt4Sj7b"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 188C360634
	for <virtualization@lists.linux-foundation.org>; Fri, 26 Jul 2024 13:21:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J6np19z0RsCM for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Jul 2024 13:21:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 49BD26061E
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 49BD26061E
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KQt4Sj7b
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 49BD26061E
	for <virtualization@lists.linux-foundation.org>; Fri, 26 Jul 2024 13:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722000076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xfF8kA8g/5K/XYp2vCMWS52kuH2/f1toD92MP8xAumA=;
	b=KQt4Sj7bQJp8J/SYQd3W6iFnJKZMFr9vacwtJTeapsLMcj6MB/xsdWxShXw8keQUTSQBz+
	GmsS58UorXelCA5WDQXZ8lVzUaUAAbIagm/bdJArhL/heAG72QbSWpkyRRt356viVdES8g
	/Uk4UdVndRICyG01XrXYLjgJ1J8qJ1A=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-JqCZmT1aNBqT0JJ4SFmn5g-1; Fri, 26 Jul 2024 09:21:15 -0400
X-MC-Unique: JqCZmT1aNBqT0JJ4SFmn5g-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5a4c36f66c3so1632080a12.3
        for <virtualization@lists.linux-foundation.org>; Fri, 26 Jul 2024 06:21:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722000074; x=1722604874;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xfF8kA8g/5K/XYp2vCMWS52kuH2/f1toD92MP8xAumA=;
        b=V3zmqEsk70CwRvgXoRbpZ68mtWKHV+V0xslZ5VL+WmoHtb9GZn4oErPR7s3Nf0CMZB
         mQORiQg/cWaxf6q7UOENns64hlI2tYTLIu23wF3mmo++I/szePxh39vKnUJTs0O73wny
         siwOIN2aLa8mE3xFEa5PSxcCvEecc/6DprpwciZwL60tH+lSzcE7ukKqbQL3F+a5uhBJ
         eaVN6CKh3wQQRIjZCIbIZzFA87XU7BXVwE1ArmrCmwRyhhtmNbYyycDwIqxhYNQkGZQG
         14qZYeoiZFNmTV2UcCYqFwqWymuY/EiQ+j/z7k6xEqp2maOHnh6Nai/XRk17l6CI9Lqm
         DO9w==
X-Forwarded-Encrypted: i=1; AJvYcCWWJo6SZBni9yv++xCMQujIPMeVD6dimWeLIuntgOwjZ/jzZ+cGvfJpkO8golaLybwdnh1nxWfjE5X/AwYNZ2dJO6iqLZB3qn9a1LZE9NC293ytXlOBsLWXGA==
X-Gm-Message-State: AOJu0Yx9Dz1jw0A7AsqC/HbR7Lzg2ZC1Skb3PpRji+QDfpP0RaPcfPti
	5AUc84s7a9nh3Esl6u/B2OtE5/MCyYW6sGOBGSoA61uy2HCXhFg4tjOxck6ndxusrk9dioQbjdD
	Bi3ak7JgQKYJP20xGDK485u+G4RdD3ycXs0uXQv/76Z1qoY4xpvyGdNRwktwLZn4OKOtdf02r2w
	0NqpOwpQ7r974A/IIZaiufM3E4Fa//HnDKCb4S7LsR6HgNwTtEkZidKg==
X-Received: by 2002:a50:c04d:0:b0:5a3:b45:3970 with SMTP id 4fb4d7f45d1cf-5ac27750881mr3155020a12.0.1722000074164;
        Fri, 26 Jul 2024 06:21:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWDnNKpy4OxfBSVuSmYdRoaFihsPhdouxRuwt/96M7BlYl2KRazN2ZOfpWIg1WDgG3Um4QtyroVHGsGBXWCXw=
X-Received: by 2002:a50:c04d:0:b0:5a3:b45:3970 with SMTP id
 4fb4d7f45d1cf-5ac27750881mr3154998a12.0.1722000073790; Fri, 26 Jul 2024
 06:21:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240725013217.1124704-1-lulu@redhat.com> <20240725013217.1124704-4-lulu@redhat.com>
 <ZqKMEoDIZx8XFhlq@LQ3V64L9R2>
In-Reply-To: <ZqKMEoDIZx8XFhlq@LQ3V64L9R2>
From: Cindy Lu <lulu@redhat.com>
Date: Fri, 26 Jul 2024 21:20:36 +0800
Message-ID: <CACLfguX7_Nvfy2wZ8WTNPOnBZxi43VKRLdhm-axUdE=m3ZsTVw@mail.gmail.com>
Subject: Re: [PATH v6 3/3] vdpa/mlx5: Add the support of set mac address
To: Joe Damato <jdamato@fastly.com>, Cindy Lu <lulu@redhat.com>, dtatulea@nvidia.com, 
	mst@redhat.com, jasowang@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jul 2024 at 01:32, Joe Damato <jdamato@fastly.com> wrote:
>
> On Thu, Jul 25, 2024 at 09:31:04AM +0800, Cindy Lu wrote:
> > Add the function to support setting the MAC address.
> > For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
> > to set the mac address
> >
> > Tested in ConnectX-6 Dx device
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index ecfc16151d61..d7e5e30e9ef4 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -3785,10 +3785,38 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
> >       destroy_workqueue(wq);
> >       mgtdev->ndev = NULL;
> >  }
>
> Nit: Other code in this file separates functions with newlines,
> perhaps one is needed here?
>
> > +static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev,
> > +                           struct vdpa_device *dev,
> > +                           const struct vdpa_dev_set_config *add_config)
>
> Nit: it appears that the alignment is off on these parameters. Did
> checkpatch.pl --strict pass on this?
>
sure, will check  this
thanks
> > +{
> > +     struct virtio_net_config *config;
> > +     struct mlx5_core_dev *pfmdev;
> > +     struct mlx5_vdpa_dev *mvdev;
> > +     struct mlx5_vdpa_net *ndev;
>
> [...]
>

