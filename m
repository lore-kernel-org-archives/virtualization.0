Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2023367297
	for <virtualization@lists.linux.dev>; Thu,  2 Jul 2026 20:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783022967; cv=none; b=f4/lhbXvMsXCydvtCXokbY9fBVc78/UJ/a45nOXJ1r9sCSTztpFd2C5Gs8OdGtAslwTPzvrZXbzAFKQZoo7AfpoYH0kd+4wBU2FbDw//B1X3uFTtXbkPlxXjqTUdjaAuZEd8ohSrfxwIzbsDDYxdSn49VuzVEsp+LLp9KEVTEck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783022967; c=relaxed/simple;
	bh=13oD+YiL/3o0MEN6K6Y/bx7CKvJzT37nBrfnC/MzHFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rpvrl3Ga3uPsD9q/v37Ccbc/W9rG2VOas1EW+p3/ydrXc3UlnIqef5lbI1pw204YkU+F/DfJeDZgexbMvdL5IsN3m9tL+WB5CZpebtlp3wTunYpaZMzL4KR8CH84IHTomAJnnQPNFrEi09UmxF2pqFwz9R5pydCxXwtkzytHD7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEIjOaMB; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEIjOaMB"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e9ecb1e13bso968010a34.2
        for <virtualization@lists.linux.dev>; Thu, 02 Jul 2026 13:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783022965; x=1783627765; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WjQFRK3eyEfNEKRH/kJEfHrxEWDAZH2cdSABwq7lLiA=;
        b=YEIjOaMBukjdSkBvoQvR/aUjLmqDKPuK6ddyeZd3J3iUT5K8SUBVYVCT73sIelSw7f
         xwjaRPsMaWxxarcy/a75L2GRTBrc5Nu3M5eYmhrUBYKTyrosuJ2X2kGMiodDPIt2Dw9G
         aKxSYIPPVZn5twr0ZGce9GSLICw02/xHjlE0IBULKtMhtZvUkVqbFXPPZhRrsro9+zjc
         IXZdmfwISM2CSBgleWpJs2WvL04kDQKOHsG9K0io/cFs58gcCeNSTwAPzYYRVCJlmSgK
         8+0dy3YCBsKBRwi95vRXij/hxsuEB8aBJ2orvxQG3+XFHAnG6q2auXmZtq3jCFiRysoA
         jAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783022965; x=1783627765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WjQFRK3eyEfNEKRH/kJEfHrxEWDAZH2cdSABwq7lLiA=;
        b=gC/pCLlEkPgYwdZlNEuFaS9az93NW0UFCI8ATnU1bnDrysXvvViHYCiixhXCptdv4Q
         jnQeVHok95D0vM6Qjrmo2leNnO2slIB5OM1QZzsY76fBi6i/QA3z7JQ3N8RKl2ik35Qf
         ky93zp7OKEYBCu+k6xjmo27dz7uMRNkZjLc8hycGpMIpXCI6L+ziRvak2x5V0hcuV6aq
         511C7cYkqX0D9Ms5D81rkaQf80PJoosyqzvByPAUeLiKEwIQkumDP6jJwbUo6RbTGt4T
         71U+lt4W/DgPnMiKZjCKKkUAGpy80XNX2z4GfWSRBd9NonWS+KB2JKOvj9qQtM3phDt9
         scuw==
X-Forwarded-Encrypted: i=1; AFNElJ+MwYnsQKrinIInGIeXokwhFCz+Lfjp/bIBk7WIFWj0NCGb5FPBn+v7jD4zRwgjY1KLCDm0VU2Z5xbMEE6OEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/lwdLRkt0AgMc6+bgHt9FoAhs5mmV4e8+60AOFKfLbyiE6dcK
	Nm5DNb0/RWTP6x/tMIcORsryLEZafP/43t09ptut8FeiqxysXFXot+5B
X-Gm-Gg: AfdE7cnduyi6XkjlMlFYxr4g2QpwxwCV2Au41jHr1yqBuUMa87Se/ejl4hb+psP0ugz
	zy74voW54L2Y9wU2Zc8TkyMyoJPvhDtvyrWDGon9gvuJklZdT6dNUl8M6qL+GPREAcvgbcOG7zW
	t8GzFouffe0lFYKdQIg8QYHicXT2S8+FDOlngvkj2ddQSgwhKDDYYgNKFzEShhC28BnHFP9+Rt5
	xpUX/TQSSuoCTzcDhQWatGWVVyVWkt6DlA6GHuXiVmVsPrbSgVfm5OwLEOKpJ0WxBSCLsutm+LO
	+0e2O93JthHg8BpVwv780mTP2Co3YrgKUgGNNCJjhhITal74+zeEDwFn6/oDGctL1z/akufS0w9
	EWCZKjHJMgG60tC0CTBiPAPAaKoEY3/NgP9Dnfla4u5vNhm0I9frEr+u1Lvf8dAmquRQxAlnx89
	beC+flb5rqZ4Pkpl1+SvoOyBr4Fqg9xbkLuA==
X-Received: by 2002:a05:6820:4cc3:b0:6a2:739a:ce95 with SMTP id 006d021491bc7-6a309929b99mr4607337eaf.4.1783022964709;
        Thu, 02 Jul 2026 13:09:24 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:43::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cbec93702sm3662142fac.12.2026.07.02.13.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 13:09:23 -0700 (PDT)
Date: Thu, 2 Jul 2026 13:09:20 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	stable@vger.kernel.org, Brien Oberstein <brienpub@gmail.com>
Subject: Re: [PATCH net 1/2] vsock/virtio: collapse receive queue under
 memory pressure
Message-ID: <akbFcMHenseQW7mJ@devvm29614.prn0.facebook.com>
References: <20260626134823.206676-1-sgarzare@redhat.com>
 <20260626134823.206676-2-sgarzare@redhat.com>
 <akVBmydgSd0Eb46/@devvm29614.prn0.facebook.com>
 <akYl38_9Y4ydXuqE@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akYl38_9Y4ydXuqE@sgarzare-redhat>

On Thu, Jul 02, 2026 at 10:56:04AM +0200, Stefano Garzarella wrote:
> On Wed, Jul 01, 2026 at 09:34:35AM -0700, Bobby Eshleman wrote:
> > On Fri, Jun 26, 2026 at 03:48:22PM +0200, Stefano Garzarella wrote:
> 
> [...]
> 
> > > +out:
> > > +	if (new_skb)
> > > +		__skb_queue_tail(&new_queue, new_skb);
> > > +
> > > +	skb_queue_splice(&new_queue, &vvs->rx_queue);
> > 
> > I think the new skbs will also need skb_set_owner_sk_safe(skb, sk)
> > when adding to rx_queue?
> 
> IIRC we added it in the rx path, mainily for loopback to pass the ownership
> from the tx socket to the rx socket, but here we are already in the rx path,
> so the skb will never leave this socket.
> 

Ah that's right, I stand corrected. There is no sender to leak in this
case.

> Maybe it's necessary for the eBPF path?

Looking through sockmap, I don't think it depends on skb->sk being
non-null either (it reassigns owner to the redirect socket anyway using
skb_set_owner_r()).

Sorry for the false alarm. LGTM.

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
