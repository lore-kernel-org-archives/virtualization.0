Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0273718C91D
	for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722430020; cv=none; b=reVqRt9G2VTYbVlgLN0MS0vJ0tVdN7iW7B4WJN3iVhU7EBzshyHO9EOp9hCHgmOBCzrV7E/sNytTvrq0b5DSpLU+O7qgMH8e3Q98N0TDUHDhoBEuQhPk8ue5X/PZa747MMk3wdnpOiqZDpcsGytMSpUn1Ppie3R0tJMez/OtZp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722430020; c=relaxed/simple;
	bh=9UPvDjZj7omKIq+R/WkcdYc4X8qFyrkL1Uld0g/QkDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uijc7hoQL+B4qwyrcEkHbPOqSVgopej9Gz19Vzz6enDyP2azAh4F0qe+wYbbcrCVpWVpcV7A9rZBb37xJ40sHgkXuJ6wlDVgLmyL3ue/87/NruoEPTiw1qwSQrWkbXl1+LTIrmCD8ABMWBbZyecS6p54xfurVEXJIZnu5rBMQyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ej3Qpdtv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ej3Qpdtv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722430018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NWAg3XJ7lRmViz7eWm0AuiImDEV7Paz7qFAo+DxnEWw=;
	b=Ej3QpdtvjrdPG9U0PEKfqcUt5cqO2pinUcTA/vAE+ZuwDcBs+x8zc9ijhDVQMzJiIBzsWb
	eWWmD7OlExlPKlb9DqP/i0izyNTjhifq41+SqzRSJfpmN4lLIJSGY8jQvLyDrJ34+QrcIp
	66MEtORW7GD1/KHxZNMDXdtvOC7bCuY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-AE8_N_cUM-eBbZmoFcej-g-1; Wed, 31 Jul 2024 08:46:54 -0400
X-MC-Unique: AE8_N_cUM-eBbZmoFcej-g-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a7aa7e86b5eso518253266b.2
        for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 05:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722430013; x=1723034813;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NWAg3XJ7lRmViz7eWm0AuiImDEV7Paz7qFAo+DxnEWw=;
        b=QaMh+MX42qzgIEw7KD/VKyCFfqSzyxtnOyMyS+vQ5p/zH1t70tY8pFgEktDz2bHi+P
         xFBU8HeqGpurRWGlyR10BOI+bNvW09mvGeRDuHnFRslAWmpXzodnsx+y1vgxdiGSFCbq
         I4hG7+oX2gICW8fypz+7wZ/027JiEQc6MgaS+TlofnA2Tz9KLmnIkpnzbZI095IHue8N
         mdIr2gkB8b6yIhat9rPv0/F0uOyqgV0qzM4emPt/FWdoHiFwIHv/BaCWfUG/RUVe7FfO
         rORlvqKIzOZSTm8GJA2z4jQxAYYAQSHOm+75OUkn4VehwzZDMMaMC5s2BzdMpEFh/K54
         BIzw==
X-Forwarded-Encrypted: i=1; AJvYcCVFCpKNANdGQ9LTg5ni/UJnVB0obvxA//8WNa5L3blhWhVu0OqX9o+1Z3PshiNLthhrX0ocAqSWRrXzI+zePg5K4ZG6nkL0UUWPRouf2UU=
X-Gm-Message-State: AOJu0Yy0sI7QDNtY3niGSctcBS+GFcJFC6kn6hZdqR5OjY3ERoltRU5y
	uBRPBV/26hqTXt4DyQXT44pGm1ezvnQZXc8BpdpylxJXxOzz2K0sj5cHlP7p1jx7+GA0mf2CyW4
	edfYjoNZWWv0HP9TYcX/6nRBu1sAmj2iEF42feG1NMmi6XRxHfX9qgvo0SzQ9fA2B
X-Received: by 2002:a17:907:801:b0:a77:e55a:9e87 with SMTP id a640c23a62f3a-a7d40116a40mr909915766b.48.1722430013097;
        Wed, 31 Jul 2024 05:46:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGViNLur3vjF6ZbGgoVg8yVsxu213V+7vQF63GW+BvUWRfICnkA4QVWqssZQovjshHinyRmyg==
X-Received: by 2002:a17:907:801:b0:a77:e55a:9e87 with SMTP id a640c23a62f3a-a7d40116a40mr909913466b.48.1722430012291;
        Wed, 31 Jul 2024 05:46:52 -0700 (PDT)
Received: from redhat.com ([2.55.14.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab580b4sm761021266b.58.2024.07.31.05.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 05:46:50 -0700 (PDT)
Date: Wed, 31 Jul 2024 08:46:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	=?iso-8859-1?Q?EugenioP=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH net v2] virtio-net: unbreak vq resizing when coalescing
 is not negotiated
Message-ID: <20240731084632-mutt-send-email-mst@kernel.org>
References: <20240731120717.49955-1-hengqi@linux.alibaba.com>
 <20240731081409-mutt-send-email-mst@kernel.org>
 <1722428723.505313-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1722428723.505313-1-hengqi@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jul 31, 2024 at 08:25:23PM +0800, Heng Qi wrote:
> On Wed, 31 Jul 2024 08:14:43 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Wed, Jul 31, 2024 at 08:07:17PM +0800, Heng Qi wrote:
> > > >From the virtio spec:
> > > 
> > > 	The driver MUST have negotiated the VIRTIO_NET_F_VQ_NOTF_COAL
> > > 	feature when issuing commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET
> > > 	and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET.
> > > 
> > > The driver must not send vq notification coalescing commands if
> > > VIRTIO_NET_F_VQ_NOTF_COAL is not negotiated. This limitation of course
> > > applies to vq resize.
> > > 
> > > Fixes: f61fe5f081cf ("virtio-net: fix the vq coalescing setting for vq resize")
> > > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Acked-by: Eugenio Pé rez <eperezma@redhat.com>
> > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > > v1->v2:
> > >  - Rephrase the subject.
> > >  - Put the feature check inside the virtnet_send_{r,t}x_ctrl_coal_vq_cmd().
> > > 
> > >  drivers/net/virtio_net.c | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 0383a3e136d6..2b566d893ea3 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -3658,6 +3658,9 @@ static int virtnet_send_rx_ctrl_coal_vq_cmd(struct virtnet_info *vi,
> > >  {
> > >  	int err;
> > >  
> > > +	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
> > > +		return -EOPNOTSUPP;
> > > +
> > >  	err = virtnet_send_ctrl_coal_vq_cmd(vi, rxq2vq(queue),
> > >  					    max_usecs, max_packets);
> > >  	if (err)
> > > @@ -3675,6 +3678,9 @@ static int virtnet_send_tx_ctrl_coal_vq_cmd(struct virtnet_info *vi,
> > >  {
> > >  	int err;
> > >  
> > > +	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
> > > +		return -EOPNOTSUPP;
> > > +
> > >  	err = virtnet_send_ctrl_coal_vq_cmd(vi, txq2vq(queue),
> > >  					    max_usecs, max_packets);
> > >  	if (err)
> > > @@ -3743,7 +3749,7 @@ static int virtnet_set_ringparam(struct net_device *dev,
> > >  			err = virtnet_send_tx_ctrl_coal_vq_cmd(vi, i,
> > >  							       vi->intr_coal_tx.max_usecs,
> > >  							       vi->intr_coal_tx.max_packets);
> > > -			if (err)
> > > +			if (err && err != -EOPNOTSUPP)
> > >  				return err;
> > >  		}
> > >
> > 
> > 
> > So far so good.
> >   
> > > @@ -3758,7 +3764,7 @@ static int virtnet_set_ringparam(struct net_device *dev,
> > >  							       vi->intr_coal_rx.max_usecs,
> > >  							       vi->intr_coal_rx.max_packets);
> > >  			mutex_unlock(&vi->rq[i].dim_lock);
> > > -			if (err)
> > > +			if (err && err != -EOPNOTSUPP)
> > >  				return err;
> > >  		}
> > >  	}
> > 
> > I don't get this one. If resize is not supported,
> 
> Here means that the *dim feature* is not supported, not the *resize* feature.
> 
> > we pretend it was successful? Why?
> 
> During a resize, if the dim feature is not supported, the driver does not
> need to try to recover any coalescing values, since the device does not have
> these parameters.
> Therefore, the resize should continue without interruption.
> 
> Thanks.


you mean it's a separate bugfix?

> > 
> > > -- 
> > > 2.32.0.3.g01195cf9f
> > 

