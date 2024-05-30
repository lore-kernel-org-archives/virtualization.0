Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91F474076
	for <virtualization@lists.linux.dev>; Thu, 30 May 2024 07:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717055752; cv=none; b=Usu98IvAZuZNIVQPY41CCu+wNReYY39A361jVvnVHJYiEICXGLwPY03wAUk+m6LTqF3IWXD5CiDv03WhSJr+HJuebBZwlpugKrFOSsiXusDS7rst9YF+moz1t66U0JVvSV29H2cabAnQpF6/hG7vz/cxGQ/045cuhOFp9P3D0AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717055752; c=relaxed/simple;
	bh=aTbMjVPTC8GXV/q5t+biiMKXiTweLG8tXz9RUUVAAC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Pcynlr+1LoBrD42wQ9ySZE+90zLVc80e+rSmWFwUfFsy/FbwmsxDquI9TwQ3IO8nZ7O5i4Ae1q8RmcEAcbFjXbSxzhXmNIeGEvnnbflbpspaQ8DVEcN1nXFM+0X06bDX14Gimfu1eBJVPYhVbACvJh8elXiSw5FuDgru9k9qOII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FaBLImCr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FaBLImCr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717055749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OeTb7oEj2cbUagJqckhiCADw6n46hzpmlEhiRtW4rVw=;
	b=FaBLImCro6awb3/f5f08/E5e7/X8LTBLheZ2QOPVgmL0eDGOk+DqtvckhazcwrP9JKbqWd
	PNdCKvw0dwI/TOeTxTcBCyzOTZXRDUb6K7wrPRM8WR7nQpxrwHrwjXoQXXJX9ggYKcbdbM
	2ul8nEgXJuWULgRmjRcvu839ANOk1cI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-wmsqc8-JMw-KHjKh0mV6fw-1; Thu, 30 May 2024 03:55:48 -0400
X-MC-Unique: wmsqc8-JMw-KHjKh0mV6fw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42111272888so5211215e9.2
        for <virtualization@lists.linux.dev>; Thu, 30 May 2024 00:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717055747; x=1717660547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OeTb7oEj2cbUagJqckhiCADw6n46hzpmlEhiRtW4rVw=;
        b=xI5ZbR5lobg+2yD2Rf0UgfnFqRhZI06IPcjNvz020yYStSaNaFuT2kByziDDLMX31A
         k29ODwDQONZwVeJk8nJTRrUSdDWGDoN/2PPX/+yxf1h0gWLy879vTv33hWkolwVxME6Q
         2zurnATy28SRAs1N71diOUnP/Lnue60rLZgwUfLB1Y5kf+RpmA2j2U42/QHR3veBxgzL
         0fmdzneM5sgXoPMgT3Zxa2TceKc+AuTNna2wCxGvAnOZVyUzBEatZwzrX032I3KnIz4l
         rxq1hxQbH2oGNEuytp1Y0m9WuCoAKhbeE8nrAy5w03woy50XXWsfWwg+Cz6L3/yF6omc
         Px4w==
X-Forwarded-Encrypted: i=1; AJvYcCUJ9YXL520Uy3g/fWfohGyMUYmCnbgqLwOkp2oXa2LYMHJ5WCFy5q9o2eHdXPqmg1rnrp550cFJhQcAr0MSyO8JM9KpSMDk+Y2VAMjiqJ0=
X-Gm-Message-State: AOJu0YzOS2jPVnLUOLRUcY+OGtWeMZRudy9ziNYB92olFpbQR06MvLN3
	Xyy5oFC7mTU46lzZlHlTJs7dJIxarSc/XAUJPmNSC5X5onT5c4ecrOq05XNcrbiwlr18jMKkQ2c
	BOvySiU7rOW4qlvAS9qfowE9GKN9NfztEuqe+fe0r27S7NUwtb1rWhX0QtDv+VNf+
X-Received: by 2002:a05:600c:46d1:b0:41c:2313:da92 with SMTP id 5b1f17b1804b1-421278158aemr17009635e9.4.1717055742277;
        Thu, 30 May 2024 00:55:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8HukkuvxeZ/smNud2JY7Qr6ffHwWhMWtkGft9V4+i+ULhflQAWD/DnZ3kmA1eTSQA+wTj8w==
X-Received: by 2002:a05:600c:46d1:b0:41c:2313:da92 with SMTP id 5b1f17b1804b1-421278158aemr17009325e9.4.1717055741647;
        Thu, 30 May 2024 00:55:41 -0700 (PDT)
Received: from redhat.com ([2a02:14f:179:fb20:c957:3427:ac94:f0a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42127084ca2sm16602315e9.41.2024.05.30.00.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 00:55:40 -0700 (PDT)
Date: Thu, 30 May 2024 03:55:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v1 0/7] virtnet_net: prepare for af-xdp
Message-ID: <20240530034921-mutt-send-email-mst@kernel.org>
References: <20240530072649.102437-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240530072649.102437-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 30, 2024 at 03:26:42PM +0800, Xuan Zhuo wrote:
> This patch set prepares for supporting af-xdp zerocopy.
> There is no feature change in this patch set.
> I just want to reduce the patch num of the final patch set,
> so I split the patch set.
> 
> #1-#3 add independent directory for virtio-net
> #4-#7 do some refactor, the sub-functions will be used by the subsequent commits
> 
> Thanks.
> 
> v1:
>     1. resend for the new net-next merge window

What I said at the time is

	I am fine adding xsk in a new file or just adding in same file working on a split later.

Given this was a year ago and all we keep seing is "prepare" patches,
I am inclined to say do it in the reverse order: add
af-xdp first then do the split when it's clear there is not
a lot of code sharing going on.


> 
> Xuan Zhuo (7):
>   virtio_net: independent directory
>   virtio_net: move core structures to virtio_net.h
>   virtio_net: add prefix virtnet to all struct inside virtio_net.h
>   virtio_net: separate virtnet_rx_resize()
>   virtio_net: separate virtnet_tx_resize()
>   virtio_net: separate receive_mergeable
>   virtio_net: separate receive_buf
> 
>  MAINTAINERS                                   |   2 +-
>  drivers/net/Kconfig                           |   9 +-
>  drivers/net/Makefile                          |   2 +-
>  drivers/net/virtio/Kconfig                    |  12 +
>  drivers/net/virtio/Makefile                   |   8 +
>  drivers/net/virtio/virtnet.h                  | 248 ++++++++
>  .../{virtio_net.c => virtio/virtnet_main.c}   | 536 ++++++------------
>  7 files changed, 454 insertions(+), 363 deletions(-)
>  create mode 100644 drivers/net/virtio/Kconfig
>  create mode 100644 drivers/net/virtio/Makefile
>  create mode 100644 drivers/net/virtio/virtnet.h
>  rename drivers/net/{virtio_net.c => virtio/virtnet_main.c} (94%)
> 
> --
> 2.32.0.3.g01195cf9f

