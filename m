Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7E52DC76B
	for <virtualization@lists.linux.dev>; Fri,  7 Nov 2025 14:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762526019; cv=none; b=rS6/BIflZSa0lUm94iVtEpCpvivAhDJfU3H3aBZ71zO81FaCrI/kPDm4n4eAWYXS8ctspjiLnuv8A2TVymYckh0qTOo2A+N2C92S/zi2O0qkm2nPmLzDUAtRs/J0icFB2D7HK2dMv8228XviKeoMIrMDkFghJ6oOsDHd2JCfucw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762526019; c=relaxed/simple;
	bh=VYv4VbKIBTMGATkaXkrYMjm0YUGRwfUgEtijjdf3tVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKcSpnd6rCbqFW8q6Ey0ho96meFDNaKiENudjWbQ5b9i896N7K3UXTeHBvfyjSgiSHY5aaokFgnF8QLwzfVgw411seiYkL1b0jj9LN7v9lhhh46ZIr4CEwPzYCU4uRIOBndAMa2A6K3iddSziKbkv7V7J4x96+UXsgBKqYZ7HK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npwG1iOD; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npwG1iOD"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-63fbed0f71aso688382d50.0
        for <virtualization@lists.linux.dev>; Fri, 07 Nov 2025 06:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762526015; x=1763130815; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BVuiPgxoIdFU9eK0ffLkE96ijOOEBPKS5XMimJNBPpY=;
        b=npwG1iOD5Jq9z7khT8+loQk/Ef1xx8Kqqk/rMzW5QEjV6bAN6TzPpnQgZU2izafpqP
         eNU7wo0GOKqf8iSued8yvHK8R15j7uYdZhCDs6G9ZilD/00/CrS+aQgDAPOW2p57LBDi
         6yqmg0C1Af2TR7oK/ZmNfk/DqUwCCMO5WYvt8R2yfK3kSEjA0+y1cX1Jo6baYDPNYqoe
         4em3tSQS0k/neorDdUXVGZFA4Lv8RoMAvFyckPYxVCRh3X6aE2JEyHffj+plpyPpswY0
         7/X88IlEks4fVk32p+JFgnusYvHeF0FalCfEEnBZtMSMeR7Z3CY1L6950xl9BY2Kqg1n
         2cSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762526015; x=1763130815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVuiPgxoIdFU9eK0ffLkE96ijOOEBPKS5XMimJNBPpY=;
        b=ZxKy56Bwdww3oDWHcwfCO0H2qYd050soS2+NSGMTtXDobDGjcCz049by+O7x68oAS8
         z/Qs9yHPEXFukfo2ulvMSSJEULfnYavflpsBdmcdDLWT8Fc1f038iumXshZ2pkXkDWF3
         +Kbc0T9dUhFvuUThjnwI9wyL0N/9x/1B/xnulxMg6QARoC/IxQerDxFIwmDY82KKHzrP
         OlxQNNrYHBpQS5Asq2i5LuoKoIStNC8dENAGv/h+xDP9qWZDv6IIifTuigtLg+npuEXu
         JqejnlzCyU9qgQm8i7w7v+0cyQSuY6cy73U1SgImREK0I5kgLIknPZxaLkhKMworRRwr
         WZ6w==
X-Forwarded-Encrypted: i=1; AJvYcCWrUgawuOhqjQQvdC2whDjinEsziL13YDYITKlDjDyDXjDO8MBVcC2cCG3bskvdlaEgevu3jTgl2PE/EXt/Tg==@lists.linux.dev
X-Gm-Message-State: AOJu0YycfRMEPBz8+wJTzJ1VSNzeFWXTWMS2TUViQBUVG0wkR1klSJOy
	X518hgiB98ZZHtCTdpVrJoHVkJbeGqQDNTo1//I8b4E+0ug0otDz4aym
X-Gm-Gg: ASbGnct1NK7fq81+dqQB+/zh5RXlorV02hpplKuf9HtHPWwOjFbWOLcQfKFMoeXPv+M
	EoiJZcyI+T3RLThRwGuVAyf9QQMAtEJDSEPge1V+o0hcMBvP59Ej1zdtIMJPWDujOvzK4n3Rfta
	fFxUzNCqNWyNx/UuzqzVPBaC9ak02s9TZHglBccq7tKdH/tOj7nTxQzZJTfcvw3uSCLQfAfT3+L
	J1+XBn1izit1rt3LJsIQegZRIkgdhuVT7+ab/du0mdYWFqdzUFEDQZtMSNUhezFqbJdVrsMv3kQ
	f/kxeFNv1cJKATSN2JomQESs4ErSN4AXTWooEghXnRaujyUinxWdpvdLjDE2eHajXPp/IQXeuo8
	HK44iClmoOYhfMvQ9DgBSug6CKVBYssn6rFbH8CPckofCncuHB4LNJGFDPb+Xypmoo9WddyPUcp
	3t3uz4gxMeZazhy9ZODbmfYC3IfR986XiE
X-Google-Smtp-Source: AGHT+IFGSfosbX24aGud2tUIAN0TjKPBi0xBs/kxp0rskWuLz9Gqspfd/w8KLNX31uQmkNqo82qJIQ==
X-Received: by 2002:a05:690e:4183:b0:63f:5785:a201 with SMTP id 956f58d0204a3-640c4170b06mr2559782d50.15.1762526015073;
        Fri, 07 Nov 2025 06:33:35 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-640c72fa3aasm605605d50.6.2025.11.07.06.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:33:34 -0800 (PST)
Date: Fri, 7 Nov 2025 06:33:33 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v8 06/14] vsock/virtio: add netns to virtio
 transport common
Message-ID: <aQ4DPSgu3xJhLkZ4@devvm11784.nha0.facebook.com>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
 <20251023-vsock-vmtest-v8-6-dea984d02bb0@meta.com>
 <hkwlp6wpiik35zesxqfe6uw7m6uayd4tcbvrg55qhhej3ox33q@lah2dwed477g>
 <aQ1e3/DZbgnYw4Ja@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ1e3/DZbgnYw4Ja@devvm11784.nha0.facebook.com>

> > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > > index dcc8a1d5851e..b8e52c71920a 100644
> > > --- a/net/vmw_vsock/virtio_transport_common.c
> > > +++ b/net/vmw_vsock/virtio_transport_common.c
> > > @@ -316,6 +316,15 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
> > > 					 info->flags,
> > > 					 zcopy);
> > > 
> > > +	/*
> > > +	 * If there is no corresponding socket, then we don't have a
> > > +	 * corresponding namespace. This only happens For VIRTIO_VSOCK_OP_RST.
> > > +	 */
> > 
> > So, in virtio_transport_recv_pkt() should we check that `net` is not set?
> > 
> > Should we set it to NULL here?
> > 
> 
> Sounds good to me.
> 
> > > +	if (vsk) {
> > > +		virtio_vsock_skb_set_net(skb, info->net);
> > 
> > Ditto here about the net refcnt, can the net disappear?
> > Should we use get_net() in some way, or the socket will prevent that?
> > 
> 
> As long as the socket has an outstanding skb it can't be destroyed and
> so will have a reference to the net, that is after skb_set_owner_w() and
> freeing... so I think this is okay.
> 
> But, maybe we could simplify the implied relationship between skb, sk,
> and net by removing the VIRTIO_VSOCK_SKB_CB(skb)->net entirely, and only
> ever referring to sock_net(skb->sk)? I remember originally having a
> reason for adding it to the cb, but my hunch is it that it was probably
> some confusion over the !vsk case.
> 
> WDYT?
> 

... now I remember the reason, because I didn't want two different
places for storing the net for RX and TX.

Best,
Bobby
