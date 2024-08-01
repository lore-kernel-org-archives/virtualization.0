Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082B8157E91
	for <virtualization@lists.linux.dev>; Thu,  1 Aug 2024 06:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722494399; cv=none; b=ROUkiz8BvavLlU990e1o8RzC6i5QDx44gc0fFPtfU+FxNGS7D7plpZIM10q1KCi6hPZ3fCzSqjY/sWdv1YSuQdwr1X5o5n0KAQMF3FPWYToWHbcqU8VKIYMKXjkq3nWXFBS4nuxqsjKCBqc3BHgtHlyYHYCFgiDALMufu2wbGww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722494399; c=relaxed/simple;
	bh=MIkzmT0B6N/JUks0v7q4Co0amtR6DS8jN6AGVw7mpts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lpPplS+VSKw3nnhydwG1bzV1d6TFLU5sxLGvL+db0H5wEmuiM7dD57ma3CI8KCjotz4vlYktAJ8EAqeDsZx5HFK8wnPMntjKQ/xLb/l8AdrWBucQSfovPHHW+XWP75gC8pL++X00D4uM7s6UHnsGFR80xq+B0lg2uBZkhLPm9S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IiEmhf/W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IiEmhf/W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722494397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yq5EurKQ9dkFyWq2vXbjFmrLWzUsKJD5wRCzk1mhzco=;
	b=IiEmhf/WLVo8rXeQ+SpxiIKkJtXjUceESDSaWh6d0zWAQmD910aq5SHvNiBg+WWrGeQ7gw
	KSxKG2G3Hi9wDCkpe+DoNQJrtuLwwTu5Q9IXsYDQFKnuGB6c9f3F5pXuIn/5mQ2JN0KGmA
	SLE1arTSGCBSd7RjK9o4FuD+uhHDzRo=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-bdZvlrnONe6ebTr7mJkLrQ-1; Thu, 01 Aug 2024 02:39:53 -0400
X-MC-Unique: bdZvlrnONe6ebTr7mJkLrQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ef2e57fb7cso63698231fa.1
        for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 23:39:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722494392; x=1723099192;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yq5EurKQ9dkFyWq2vXbjFmrLWzUsKJD5wRCzk1mhzco=;
        b=GmtqjD8Hfoxrj+IXEgLDcrtdsruSB/nUQGFSI1zvBTyOu2OBWoPB06hAN/TTgGZTlR
         LpqsIj7/dKW3kum1TCiiupjiORpfBdO4Idc4/lGleQFeRdrUdjh9lVH//7va2Dsx3ZJB
         cTs0aO/XIW6duKq1EFcJ5iiRCCoqMVsRHgKveazDWpJce4QKPxRhIsJN6IQ5KmK9rqEN
         lqjwbu+1BuMaBl1DGbMi8L8lN8nE0O7S2iXetYTrBhmOciNGqu8XyHT1FKNf2wMCTNEw
         Bc5Xj0sm7mi+mX44xvvcxNIK0+6JgBAA6iASuV3xceQG+i06OWOYD3LfDhspck5TxaAW
         DnvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwhb59Y7v695YMOVtm0XFRF4ZBbQ2e62FnjWDb8VKEfSt6XzdOZDa3nSK9e8SLRkgVj7XJ+2U/S9kuOyTEZuXdKQZIXGsafSRkXFF37fg=
X-Gm-Message-State: AOJu0YxgioyJ31qEG8xSG9rg0evETG/jng2hSBDXr8c3A5pUAmW2Yk5f
	f/PV/tl/heYRs6PnWxQTwHpUdw6f+D+4+j8qjQMmLJlqixe0XzkFcMusig6DPqNX4YwWWg+J5Tp
	IndmL6Q/Qz7RN/zItncrJa+oxfqJ0VBzknzWgQUjdBzHi2Eg37KKZ7fw9Jqb2r7vK
X-Received: by 2002:a19:6454:0:b0:52f:6f49:3593 with SMTP id 2adb3069b0e04-530b61b8b85mr618127e87.34.1722494391982;
        Wed, 31 Jul 2024 23:39:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtTZmhDej7qpKommz5X1HfdiMkUv1JV/TjGkcQDXZidi7Gs3IMwM++A5Mx1g5YLF4QS8xxMw==
X-Received: by 2002:a19:6454:0:b0:52f:6f49:3593 with SMTP id 2adb3069b0e04-530b61b8b85mr618112e87.34.1722494391134;
        Wed, 31 Jul 2024 23:39:51 -0700 (PDT)
Received: from redhat.com ([2.55.14.19])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b2d0b878b2sm5143274a12.85.2024.07.31.23.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 23:39:50 -0700 (PDT)
Date: Thu, 1 Aug 2024 02:39:45 -0400
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
Message-ID: <20240801023927-mutt-send-email-mst@kernel.org>
References: <20240731120717.49955-1-hengqi@linux.alibaba.com>
 <20240731081409-mutt-send-email-mst@kernel.org>
 <1722428723.505313-1-hengqi@linux.alibaba.com>
 <20240731084632-mutt-send-email-mst@kernel.org>
 <1722492463.6573224-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1722492463.6573224-1-hengqi@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Aug 01, 2024 at 02:07:43PM +0800, Heng Qi wrote:
> On Wed, 31 Jul 2024 08:46:42 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Wed, Jul 31, 2024 at 08:25:23PM +0800, Heng Qi wrote:
> > > On Wed, 31 Jul 2024 08:14:43 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On Wed, Jul 31, 2024 at 08:07:17PM +0800, Heng Qi wrote:
> > > > > >From the virtio spec:
> > > > > 
> > > > > 	The driver MUST have negotiated the VIRTIO_NET_F_VQ_NOTF_COAL
> > > > > 	feature when issuing commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET
> > > > > 	and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET.
> > > > > 
> > > > > The driver must not send vq notification coalescing commands if
> > > > > VIRTIO_NET_F_VQ_NOTF_COAL is not negotiated. This limitation of course
> > > > > applies to vq resize.
> > > > > 
> > > > > Fixes: f61fe5f081cf ("virtio-net: fix the vq coalescing setting for vq resize")
> > > > > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > Acked-by: Eugenio Pé rez <eperezma@redhat.com>
> > > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > > ---
> > > > > v1->v2:
> > > > >  - Rephrase the subject.
> > > > >  - Put the feature check inside the virtnet_send_{r,t}x_ctrl_coal_vq_cmd().
> > > > > 
> > > > >  drivers/net/virtio_net.c | 10 ++++++++--
> > > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index 0383a3e136d6..2b566d893ea3 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -3658,6 +3658,9 @@ static int virtnet_send_rx_ctrl_coal_vq_cmd(struct virtnet_info *vi,
> > > > >  {
> > > > >  	int err;
> > > > >  
> > > > > +	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
> > > > > +		return -EOPNOTSUPP;
> > > > > +
> > > > >  	err = virtnet_send_ctrl_coal_vq_cmd(vi, rxq2vq(queue),
> > > > >  					    max_usecs, max_packets);
> > > > >  	if (err)
> > > > > @@ -3675,6 +3678,9 @@ static int virtnet_send_tx_ctrl_coal_vq_cmd(struct virtnet_info *vi,
> > > > >  {
> > > > >  	int err;
> > > > >  
> > > > > +	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
> > > > > +		return -EOPNOTSUPP;
> > > > > +
> > > > >  	err = virtnet_send_ctrl_coal_vq_cmd(vi, txq2vq(queue),
> > > > >  					    max_usecs, max_packets);
> > > > >  	if (err)
> > > > > @@ -3743,7 +3749,7 @@ static int virtnet_set_ringparam(struct net_device *dev,
> > > > >  			err = virtnet_send_tx_ctrl_coal_vq_cmd(vi, i,
> > > > >  							       vi->intr_coal_tx.max_usecs,
> > > > >  							       vi->intr_coal_tx.max_packets);
> > > > > -			if (err)
> > > > > +			if (err && err != -EOPNOTSUPP)
> > > > >  				return err;
> > > > >  		}
> > > > >
> > > > 
> > > > 
> > > > So far so good.
> > > >   
> > > > > @@ -3758,7 +3764,7 @@ static int virtnet_set_ringparam(struct net_device *dev,
> > > > >  							       vi->intr_coal_rx.max_usecs,
> > > > >  							       vi->intr_coal_rx.max_packets);
> > > > >  			mutex_unlock(&vi->rq[i].dim_lock);
> > > > > -			if (err)
> > > > > +			if (err && err != -EOPNOTSUPP)
> > > > >  				return err;
> > > > >  		}
> > > > >  	}
> > > > 
> > > > I don't get this one. If resize is not supported,
> > > 
> > > Here means that the *dim feature* is not supported, not the *resize* feature.
> > > 
> > > > we pretend it was successful? Why?
> > > 
> > > During a resize, if the dim feature is not supported, the driver does not
> > > need to try to recover any coalescing values, since the device does not have
> > > these parameters.
> > > Therefore, the resize should continue without interruption.
> > > 
> > > Thanks.
> > 
> > 
> > you mean it's a separate bugfix?
> 
> Right.
> 
> Don't break resize when coalescing is not negotiated.
> 
> Thanks.

Let's make this a separate patch then, please.

> > 
> > > > 
> > > > > -- 
> > > > > 2.32.0.3.g01195cf9f
> > > > 
> > 

