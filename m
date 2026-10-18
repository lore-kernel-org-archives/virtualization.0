Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF03457E7A
	for <virtualization@lists.linux.dev>; Sun, 18 Oct 2026 21:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792359757; cv=none; b=RMIIjIICnILXf5LJyclIklF7znvLkfEM8g2+k7nKTxLV/99TmLQyB0IEd1Oy+Z09GuyScw2LZgpLpAYAhx7pyN480HIcPvTT9ZUY4bTtqV2WY7lYodZNzyLRnWm+nBQmRzFcLKmh9WzJ3gsfUEeCr/h4SjvBvQ6Xlpgmj/0vNmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792359757; c=relaxed/simple;
	bh=a3AmrwR8v2jihgGq5kU4YfBXbpArfNYrMAioQAluXE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RUk122rZSoKTysf15xqUEAU9Lgd+loXsbLNLl+uQic+M5xbM1htaTu/kRdDwp57VQ8p+D+FmeDqABOZtl4RU5zX7jGeIA4bayRHtZLCnB4WIXj2H2u+bU63rDI817cbq8xFbyWcjTpYLuL63K6lvGpRi16uz7Nq4ktOXNYwwjVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZDvAhuUF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZDvAhuUF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792359755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l5kyv1GQkP0lF5khYckjfpPeq+O6vgVUGzl8O+44HLM=;
	b=ZDvAhuUF3AEuZ0JZXrKiPWXudF/gK1F5MWiEEA8SkwC+sbYOGbWYFd8M4SPyWCqBvhbHu5
	WNA5GhDGvMN3GrnTyD8OvRFRipylQRJay8c+g0cx6aAvhAe4lRlBOhewK1ny7/JsbmbMNM
	qtJwa8KWOVbWBdosU+Xp6O6JAw7o7z4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-fTv3HyrrOW2MJI9P_ikgug-1; Sun, 18 Oct 2026 21:42:34 +0000
X-MC-Unique: fTv3HyrrOW2MJI9P_ikgug-1
X-Mimecast-MFC-AGG-ID: fTv3HyrrOW2MJI9P_ikgug_1792359753
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48e17d30a79so19782f8f.3
        for <virtualization@lists.linux.dev>; Sun, 18 Oct 2026 14:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792359753; x=1792964553;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l5kyv1GQkP0lF5khYckjfpPeq+O6vgVUGzl8O+44HLM=;
        b=DIxtkNkbEQtnPVsnQQl+lrht/q+/7e+4tSiMLJrwDQeIykScAm0k4/dtSxVbpdXs8G
         ZWq19MzEm3zfBDIyNmKfDApA06iIv4XpgOZ2dWSFNxAUHMWDyaScwb4VmP/bZHilft8d
         TXT2WJZCu4F56287KMrELq33fdsb5wS3MCWpG1PO0cbceZ2cumfoVVzSlSqWcXWnMyC5
         fK0KGa+m98Cb+H5hCUjGMZa3yO475rnNdCW/7JGg8kTrKdxIlrTYMyFPNzyDIc3ZXFNt
         JWhSXMEy2F0SK+fWkCCpxL9LE+jV+50FgPclPkw/aNy56gEKGYLxGUWAzKDg5FZYBhko
         e1Ew==
X-Forwarded-Encrypted: i=1; AKwUvBw0ntT8GwE3bWCt2c1NmZrRPFUhtcy4YGbvop/8ahMUohWwjPenuXeQsJ8ei0Qg0TQ24Bd58rHtZqahxrgc5w==@lists.linux.dev
X-Gm-Message-State: AFq9FYJtUzv96TTRevJefWCMfUN3TVfVit65VyeUqoU0coXublWQfD+V
	zsccLW1Z9XT3pryRP1jOV/69PMs0kjUnDbzsMuC5pf+KRtk+qYGkO5tu4yJ2MqNSDqmJAvUXpWh
	lRQLeqv4Ffr9v7sUkLcPUVptEZTxtPLrOppXDEiy/jnmLYsPvGBAIrY/Q3gfci9an9EDq
X-Gm-Gg: AYBFou3d6r33qy28i7O98/47/ixM1E2mRwRBO2i2UzXRgsegnFuZOxVXObYWJVUhsKE
	X6lukrvaz85Ud4kYKbUVVHS8GwqAlFErWGObqlHPT1vYCU6hr8Lyl+pIbGQ6w7bTXbyup8elCBn
	uEsHlILkNc1sUerF2pRVv0A2bJbW+gPtqkdrcoZjzrJMyzZRfFeoj0iaqtR1T0bF6G5REmXbKNH
	UCG6N8QoGmE+NoO84pa8YZta0nnwESb2EOWHuAGAQX+h3rAx87pki6LfCGpWL3zV6WwFs1UOpp4
	urXviOHXLV9cn9h1aryKIzf1mHB/hsr8aG5+goWUAlJOxPh46FZfANm7lN91LYiFNfPXIw==
X-Received: by 2002:a05:600c:6289:b0:4a1:dadf:9876 with SMTP id 5b1f17b1804b1-4a1dadf98d1mr105366555e9.23.1792359752776;
        Sun, 18 Oct 2026 14:42:32 -0700 (PDT)
X-Received: by 2002:a05:600c:6289:b0:4a1:dadf:9876 with SMTP id 5b1f17b1804b1-4a1dadf98d1mr105366305e9.23.1792359752289;
        Sun, 18 Oct 2026 14:42:32 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8ae6d2esm226529615e9.6.2026.10.18.14.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 14:42:30 -0700 (PDT)
Date: Sun, 18 Oct 2026 17:42:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Haoran Wang <haoranwangsec@gmail.com>, jasowangio@gmail.com,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, eperezma@redhat.com,
	linux-kernel@vger.kernel.org, security@kernel.org
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
Message-ID: <20261018174144-mutt-send-email-mst@kernel.org>
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com>
 <20261018152358-mutt-send-email-mst@kernel.org>
 <20261018204838.4080b238@pumpkin>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20261018204838.4080b238@pumpkin>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: M08AIKqLypRXaNPJ0zGEf9mkTi1WS6sfUE9yIuz66dE_1792359753
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 18, 2026 at 08:48:38PM +0100, David Laight wrote:
> On Sun, 18 Oct 2026 15:24:41 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Thu, Oct 15, 2026 at 03:23:45PM +0800, Haoran Wang wrote:
> > > I'd like to report an issue in drivers/vhost/vringh.c:1216 (function
> > > getu16_iotlb), found via static analysis of Linux 7.0.11 and verified
> > > against the 7.2.10 source tree. I have reproduced the leak on an
> > > unmodified 7.2.10 kernel.  
> > 
> > 
> > This should fix it I think? Can you confirm pls?
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  drivers/vhost/vringh.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> > index 9066f9f12ba1..4b097170bd36 100644
> > --- a/drivers/vhost/vringh.c
> > +++ b/drivers/vhost/vringh.c
> > @@ -1213,7 +1213,11 @@ static inline int getu16_iotlb(const struct vringh *vrh,
> >  		return ret;
> >  
> >  	if (vrh->use_va) {
> > -		ret = __get_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
> > +		__virtio16 __user *uaddr = ivec.iov.iovec[0].iov_base;
> > +
> > +		if (!access_ok(uaddr, sizeof(*p)))
> > +			return -EFAULT;
> > +		ret = __get_user(tmp, uaddr);
> 
> Can't that be a normal get_user() call?
> 
> David

Now that you mention it, yes. Thanks!

> >  		if (ret)
> >  			return ret;
> >  	} else {
> > @@ -1251,7 +1255,11 @@ static inline int putu16_iotlb(const struct vringh *vrh,
> >  	tmp = cpu_to_vringh16(vrh, val);
> >  
> >  	if (vrh->use_va) {
> > -		ret = __put_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
> > +		__virtio16 __user *uaddr = ivec.iov.iovec[0].iov_base;
> > +
> > +		if (!access_ok(uaddr, sizeof(*p)))
> > +			return -EFAULT;
> > +		ret = __put_user(tmp, uaddr);
> >  		if (ret)
> >  			return ret;
> >  	} else {
> > 
> > 

