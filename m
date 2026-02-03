Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AC03446D3
	for <virtualization@lists.linux.dev>; Tue,  3 Feb 2026 12:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770123000; cv=none; b=LS0UujRBXck5p/loMnvJUX5dxuTZUGEzHkgbVOSCxOWKfapFFDsy/7jgoisRuY00Wyee3FzviEUu9t//N5E4EKXPoXJplREQD8CoDSZxH+4lNElyIyKrrCYKyB6l5CFFDox7CqZ5z3svvSiMahUQojM7LvoKQwou18TNuINWwN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770123000; c=relaxed/simple;
	bh=KSD1Z2CStjFRJLyCJ/XVh+aYxA3lCgkBIM4NzbjA+uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dyBNV4OyqRobpZ67St/zpIxKzjR0dzBclpUomIs4VQHIOnkJ6L0Wz8Ogzzwm/f/PXl8jhax+ddB7d5LftZOqfF2RRbI4uXvecyFgc/8ZS8ziUKW996HZcU0DfA0Xb3l6KNoyBOvvfxdl1ZwOpt4ILeQJwxsjSG2qzcLKo2hvThM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f9N4KLRa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f9N4KLRa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770122998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UHM9GVbyan5FSeynMvjHxc9PXAtNbBPfKgyu2M/C1a8=;
	b=f9N4KLRaeltbeiwe/jVti6usJqBM/aiAvez2OkhJMVzOQfNRQVU1sCPHUQYriqAgQyo/cb
	+sTvzTLsAfld1AHuC/v1ZCaTbnTc4p5XnxEHC0c8zCYhCyW70/lefs5ite6i3Znc2PiumT
	j8+t7ohFxZICQwNaZqJ/bNksiEHqiHU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-ttPS3Ze3Nb-y2_Febz9I1A-1; Tue, 03 Feb 2026 07:49:55 -0500
X-MC-Unique: ttPS3Ze3Nb-y2_Febz9I1A-1
X-Mimecast-MFC-AGG-ID: ttPS3Ze3Nb-y2_Febz9I1A_1770122994
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-482d8e6e13aso37114455e9.3
        for <virtualization@lists.linux.dev>; Tue, 03 Feb 2026 04:49:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770122994; x=1770727794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UHM9GVbyan5FSeynMvjHxc9PXAtNbBPfKgyu2M/C1a8=;
        b=xMB2XwVBoNeX48czxyvLpCABp4OIZniBBlnRvbLz1qOtEGbLsIzUSB3qxEu/1uBLRM
         CTwz6TOdWC8dPI4Ds/SK3LQ/Xohk0M+BscqIFBuMlxc0twxgR3SUfL/fdsuWsu73n342
         Y1e/lFiIJe6XuFEEWrKrdw26+Zk0IjH88a/VkAb/3eAeQRSL7xMrhUIz5gVxiSKaxDam
         FNAxHO4qzXRkdK6AK1WvJXJB0dZ342s6ZAlP+MxtIFZDS30eXnYImNvVwEYh5w4blksl
         gnq6FFbeLxk+MsOj1q8qWz/DGOZHfOyxRlcVNmXiTo2CMHlFqT6lvuJV9CN0rb4Ver88
         /jOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWttReqRVXqFw7pIEkQhEmD8yoreFyFd1uXqDjChhix5BvjmvwDp18MbBJpjfI5DWOFxogpyHY/IFb1Z23Nw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyycgGBro+APzBwqoBtpeflmjKWKmV8Dmse4zPmxqjsMtmPSerP
	cr6nKRs1rkH3mCiubLqhYU3/bz57f+k/uE8X+qUnZfkh+gtMkbVkzeek7cQRrvJfoK7doOgnIIY
	DPjbWGYLWUO4P2UyQ+wYpBYS/XLS20we/Av/IGDHZDuk/x1ZRTa2vCxnVu/7Qb/6cLcWr
X-Gm-Gg: AZuq6aLbwPP0pedq8eH6g/1nKvuVmbMmNXtwjDQ3/I1IuGeOTY2m1qTqJrEXonx5TAN
	Ux8HHSu6gCHCEhXqNwaUuMosUoaZO2R7Ru3CQ2BOHO3zIQHcZWl71zMxE36OQjdU9g2SXcqLss7
	pe3w9Qf4/WE4JyT7T4tlrRiOmNcV4dF/Sm4tQ9TnBDEIUQ0xw5tnA4yH6pdb+6Tiy+rcyA9VVOo
	UrdiLjsSP7WKfmF7EMZubcLIFNtMMB+p0yzeiMs0radd0O2ymv9GLGHqqP5cAQucez5XfVfzCEg
	/O9LJnYExHioeDNdblg/6tzO4k0OKfrTVREXaQycDPSCHHPAT+DbIf5MDhH8bO1urY/pReo0EK3
	t8RiWKRwuPUyA5YDy2Ad/19+EzjLqU4+n+w==
X-Received: by 2002:a05:600c:8b61:b0:46e:32dd:1b1a with SMTP id 5b1f17b1804b1-482db4567cbmr216620365e9.7.1770122993936;
        Tue, 03 Feb 2026 04:49:53 -0800 (PST)
X-Received: by 2002:a05:600c:8b61:b0:46e:32dd:1b1a with SMTP id 5b1f17b1804b1-482db4567cbmr216620065e9.7.1770122993437;
        Tue, 03 Feb 2026 04:49:53 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830511cc93sm72291945e9.2.2026.02.03.04.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 04:49:52 -0800 (PST)
Date: Tue, 3 Feb 2026 07:49:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Harald Mommer <harald.mommer@oss.qualcomm.com>,
	Francesco Valla <francesco@valla.it>,
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-can@vger.kernel.org,
	virtualization@lists.linux.dev,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v7] can: virtio: Add virtio CAN driver
Message-ID: <20260203074916-mutt-send-email-mst@kernel.org>
References: <aVwGfOlvRqdv5xj7@fedora>
 <aWE5duyvXCuwsMAn@bywater>
 <eec1a83b-e36f-47bb-9a5b-6888b42e063a@oss.qualcomm.com>
 <20260203070338-mutt-send-email-mst@kernel.org>
 <CAMZ6Rq+M2zS=BbOz3x0GPprO+J+yreAbjOAsr=3bjfi9gRvApQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAMZ6Rq+M2zS=BbOz3x0GPprO+J+yreAbjOAsr=3bjfi9gRvApQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4pUdlrDHuU-0Aq9ZhPQpP6qG5EU6t3BSaU0n1m8KYig_1770122994
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 03, 2026 at 01:32:47PM +0100, Vincent Mailhol wrote:
> On Mar. 3 Feb. 2026 at 13:05, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Tue, Feb 03, 2026 at 12:55:07PM +0100, Harald Mommer wrote:
> > >
> > >
> > > On 1/9/26 18:23, Francesco Valla wrote:
> > > >> +static u8 virtio_can_send_ctrl_msg(struct net_device *ndev, u16 msg_type)
> > > >> +{
> > > >> +  struct scatterlist sg_out, sg_in, *sgs[2] = { &sg_out, &sg_in };
> > > >> +  struct virtio_can_priv *priv = netdev_priv(ndev);
> > > >> +  struct device *dev = &priv->vdev->dev;
> > > >> +  struct virtqueue *vq;
> > > >> +  unsigned int len;
> > > >> +  int err;
> > > >> +
> > > >> +  vq = priv->vqs[VIRTIO_CAN_QUEUE_CONTROL];
> > > > Nit: consider initializing this above, while declaring it.
> > >
> > > All those "Nit" regarding initialization cause problems. There is a reason why it was done the way it is.
> > >
> > > The network people require that the declaration lines are ordered by line length. longest line first. This is called "Reverse Christmas tree". Don't ask me why, this formatting style is what the network people require. Their subsystem, their rules.
> 
> I am fine with the Reverse Christmas Tree in general, except when it
> randomly splits the initialization, as is the case here. As you noted,
> this is a coding rule of the network subsystem, but here we are the
> CAN subsystem. So yes, the CAN is itself a sub-subsystem of network,
> but my point is that we are a different team of maintainers. I would
> like to ask the network maintainers for understanding regarding our
> different preferences on that topic.
> 
> Unless Marc or Oliver have a strong opinion on this, I would prefer
> not to push the Reverse Christmas Tree to its limits and to allow,
> within the CAN subtree, exceptions whenever this would avoid some
> hanging initializations.
> 
> > > To initialize the vq you need now already the priv initialized. If now the vq line becomes longer than the priv line you will violate the special formatting requirements of the network subsystem.
> > >
> > > Solution was: What you see above.
> > >
> > > Regards
> > > Harald
> >
> > So you reorder it then:
> >
> >         struct scatterlist sg_out, sg_in, *sgs[2] = { &sg_out, &sg_in };
> >         struct virtqueue *vq = priv->vqs[VIRTIO_CAN_QUEUE_CONTROL];
> >         struct virtio_can_priv *priv = netdev_priv(ndev);
> >         struct device *dev = &priv->vdev->dev;
> >         unsigned int len;
> >         int err;
> >
> >
> > and where is the problem?
> 
> The problem is that priv is not yet declared. So this:
> 
>   struct scatterlist sg_out, sg_in, *sgs[2] = { &sg_out, &sg_in };
>   struct virtio_can_priv *priv = netdev_priv(ndev);
>   struct virtqueue *vq = priv->vqs[VIRTIO_CAN_QUEUE_CONTROL];
>   struct device *dev = &priv->vdev->dev;
>   unsigned int len;
>   int err;
> 
> is forced,

Ah. Good point.

> which, IMHO, is totally *fine* and way better than
> deporting down the vq initialization.

Indeed.


> > On the flip size, this guarantees we will not forget to initialize.
> 
> Yes!
> 
> 
> Yours sincerely,
> Vincent Mailhol

