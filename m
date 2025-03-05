Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D06208D0
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 00:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741135148; cv=none; b=oDHXXwm7iwU565ifS836ZbdTqdFO6cANfo5Nu2ghCa2xZpTl3nGHuhfkZBoJvj/2FO9g4QErZOCkO3NYpRIi9XAAuiGkdhFHdQUIyDlXcFVeGCXkb2vpPhtipkD2vrnNr2rocsvyPlpS43z7hH68F5huoQiOJ6ZlG8hlS6PfioQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741135148; c=relaxed/simple;
	bh=GffaeRHQ+IZsy69KXO82DY5gWnWpz0RqxgHkgUms0Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDlA5lU3an+RSyrVMAkIHfPXRHlRho55Fst+qyqGdujVCab+e6trwCt+nxuYQrJmY5U0wk3/BeLxF9GpeZvPBwcxf148MbUptLTv5cvOvJQpcfosbwQpdcMDoCFTy0YuTYqCQo9RAGfdADWGS8lRWeA3pPPea0oIta3rTFPOqxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvszArKR; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvszArKR"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D095B82C21
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 00:39:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zTII8J3ST_l7 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Mar 2025 00:39:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=bobbyeshleman@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2F0AB82C75
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2F0AB82C75
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dvszArKR
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2F0AB82C75
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 00:39:05 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2237cf6a45dso62315145ad.2
        for <virtualization@lists.linux-foundation.org>; Tue, 04 Mar 2025 16:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741135145; x=1741739945; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UprHo0WfBiVLbk323XZc3dMbOaIjPzElNygx0f4wgwc=;
        b=dvszArKRgiThtdRlc109yY+2NLfeZUiYRoR0gqRTBOIoUDgBk4VEEgw59vak+js2DX
         cl6R9TMXJjQ1AQvnFRXnvNuT/OCDdm5MqUpl/hmf1GpuC7pWRWRtBj2SqbwnVpTgk5uZ
         OVvxjmwCz7eFgCSFR4aEV3l3gvdgl808T3W2Fjo3GU+6lNfGSAlm4weiC+dMIzgtPD0b
         71SPFrvk7DjIqPrZWNHHXzFQ67P/0PknmPWEoAgeuRZV9TFBHBEaJKrbfxRdS/xTAnn+
         8Z383kJu1EzPRgrU9WRYwkYelGKprJoy6oX8PZhjWqg2YQpPZnbZNZVtvJX7lCexH2XA
         06eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741135145; x=1741739945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UprHo0WfBiVLbk323XZc3dMbOaIjPzElNygx0f4wgwc=;
        b=Q+EpYHl/oybyuaAB/EeRCSLUNuMXXnV+uT7d9whsjsuSqMCTTH/EsUk9a5eqslHeu0
         vQvJgVlBIJIsmYfQPjB7F1H9Zx/TaRA6MWhFrnKttBNgjWFZWzibAlWIgfxBaK8V+sTs
         4zMOhWi6FmV5MCPTMC78fjJrhIOzL61lK24PgBQ3D4iz1+mwc5QxEkzEwYG/vfaVE1AE
         T8A5fZ/bnz/2RsR26IbuCzs8xXPRMeOKX31q2yOs9Riq+b5UDiuiCvoNH3tr8V7yQJDL
         Tmoc87YWR7g2v3/365ycvUTN082YSSRqpFSplq6Y4NEZ2pz0GRmlxX965Nco047GuE4E
         yYEg==
X-Forwarded-Encrypted: i=1; AJvYcCW9oTov/F9jI2IqC+k6JkH4lxNMdS/R2tCyGS5TSBwHRjblhmcOC0CRIJZ8unh3D+QV5mS4tC4y0vEhpmmA5A==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzNGkKbys6MtJUXFt8u1eImarILcfPWAhdMIEk4YCierEgQ8RSB
	/XnQ5XIDrKgv7+NAEwHobL3td7Exrk3zApJdHO7Mij94XA8h0twc
X-Gm-Gg: ASbGncsuq/Cf0QIQ7RIzpnKA1DgZu+XnDtPi5Y+jwSFx25PTYyofvw37hUy+KMviOC0
	wXs+vB7m9cH6ORQe2s15gOooiulUdm+0H9V5m59DqHIzNc60upkoxsu+TYISbZSRQs526phgx8t
	Z3th2YX+t0F+SFgnZIVg4g4Pgw69VI6+1ZXN8bQ9Ijxvb3ujX96QJ880Bq2iMmBQjWmJMYTrePh
	qhmKwpq6KSklSwZeapgWpyAxZTveGakamEyfaG4TYwg7FX5hPepLJiuZK2iexv5wZWE/8OREVkp
	0GOBqR+NnQFuBvUtDbTrUBLoml311WQjMjt7tNiCYyroYeQeXxU5uJ5a88MdyAdTBQ==
X-Google-Smtp-Source: AGHT+IECiYjFVxf6raN09EdNcRoqe9t6RTi4k2HhtgndswCUxU53XDMOZQ0P2qwRcfTEsZetXhEh+g==
X-Received: by 2002:a17:902:d50f:b0:223:5e76:637a with SMTP id d9443c01a7336-223f1c97445mr13662535ad.23.1741135145249;
        Tue, 04 Mar 2025 16:39:05 -0800 (PST)
Received: from devvm6277.cco0.facebook.com ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d28desm102409635ad.16.2025.03.04.16.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 16:39:04 -0800 (PST)
Date: Tue, 4 Mar 2025 16:39:02 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, davem@davemloft.net,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
	Jorgen Hansen <jhansen@vmware.com>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-hyperv@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next 0/3] vsock: support network namespace
Message-ID: <Z8edJjqAqAaV3Vkt@devvm6277.cco0.facebook.com>
References: <20200116172428.311437-1-sgarzare@redhat.com>
 <20200427142518.uwssa6dtasrp3bfc@steredhat>
 <224cdc10-1532-7ddc-f113-676d43d8f322@redhat.com>
 <20200428160052.o3ihui4262xogyg4@steredhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428160052.o3ihui4262xogyg4@steredhat>

On Tue, Apr 28, 2020 at 06:00:52PM +0200, Stefano Garzarella wrote:
> On Tue, Apr 28, 2020 at 04:13:22PM +0800, Jason Wang wrote:
> > 
> > 
> > As we've discussed, it should be a netdev probably in either guest or host
> > side. And it would be much simpler if we want do implement namespace then.
> > No new API is needed.
> > 
> 
> Thanks Jason!
> 
> It would be cool, but I don't have much experience on netdev.
> Do you see any particular obstacles?
> 
> I'll take a look to understand how to do it, surely in the guest would
> be very useful to have the vsock device as a netdev and maybe also in the host.
> 

WRT netdev, do we foresee big gains beyond just leveraging the netdev's
namespace?

IIUC, the idea is that we could follow the tcp/ip model and introduce
vsock-supported netdevs. This would allow us to have a netdev associated
with the virtio-vsock device and create virtual netdev pairs (i.e.,
veth) that can bridge namespaces. Then, allocate CIDs or configure port
mappings for those namespaces?

I think it might be a lot of complexity to bring into the picture from
netdev, and I'm not sure there is a big win since the vsock device could
also have a vsock->net itself? I think the complexity will come from the
address translation, which I don't think netdev buys us because there
would still be all of the work work to support vsock in netfilter?

Some other thoughts I had: netdev's flow control features would all have
to be ignored or disabled somehow (I think dev_direct_xmit()?), because
queueing introduces packet loss and the vsock protocol is unable to
survive packet loss. Netfilter's ability to drop packets would have to
be disabled too.

Best,
Bobby
