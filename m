Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E5DB64A
	for <virtualization@lists.linux.dev>; Mon, 27 Jan 2025 22:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738017126; cv=none; b=hkqJ7J9KLnuag70siB208kjVNyr7UpkjAf/AjvfM+vfdqdGSmbTJd2Ld3AlYlAzH+MtsUkjm1y3iDpOSU0EmDAAqzzu+vv2MXdfrUtRs3fehlqv+kLEjv6c0YFm1LYyuN1mh8WbHbyDROLLbbmDEHtpYIST9IyKu5LFkRhYv0rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738017126; c=relaxed/simple;
	bh=18DsTnkG4dmQIgO4BZ+ZSqpV9RzfKM8cduBtIxYkLcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PG/T5pSmlyEKOCopfuDpd1c9YKSgavi22ffwk7pXj/NNQHAtvulxlt6HT27b8O+3Pfkr4D+CO1OW1oN/cOeCHM6ULVWwpvTPgpejcbJd3h/oH7seRvnD0Dah8nZkjIogCR+c3k20/opC3dqbntnQirb1IDJOa6Rg8V9mrxK+fCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=RvRqkjJy; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="RvRqkjJy"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7be3d681e74so450272085a.0
        for <virtualization@lists.linux.dev>; Mon, 27 Jan 2025 14:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738017124; x=1738621924; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZjsGD1HTZWvnB4scix9ien1anGPvw1aSZgElOGgUWqg=;
        b=RvRqkjJyaiWJgqxDr+iO500cpQvbjc0S1pcW3OCQGLziUZ/RczPoCqZczk0G0V31tH
         yJbQvf33kcJ9JD22S1TogYXc6CkfvAbyIGRzvHVmULLkaZEpYt5bptaV0M40VrMlShip
         B74FdJXUVcvUPK+e/6G1v1lsSx173kZGgOS9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738017124; x=1738621924;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjsGD1HTZWvnB4scix9ien1anGPvw1aSZgElOGgUWqg=;
        b=PN7kUU5PAMgac/dXX5jCpxkIHMZAHi80u6ZUxKsGWb+ZTx8yAWlobNw4R1UB41947P
         au5OdoQQwjc9aVEaymfsYshXe5O3D+5NVtf35AfvzjnZGnQcNgWy1ZzAZKzV3fpnJZaO
         8NEVxGKEB8mXXzHB1EP8C6WTTUt5vKsdNgSaExg8Uqkm/0Woa2WaKOHalhpfiwjY9cjM
         PVSqs/KQixVzGw1MUMYrOEqETKU0vnPSoDKn8rI8+9ByGdL6B+FI7fOvnDOtQK/S0C9M
         mZW8D7hEn1im1Wuw4juAEijHbe7j5Vlj1mas9Jz5fmkCnAVQ/JdGMjUTjTArA5OX2Cjo
         +HKg==
X-Forwarded-Encrypted: i=1; AJvYcCU3XsY0hpU/gVYCQl1YUm+Xwa9AINq01OaEZ6XoaJ1CLERuAAaNHWXXvcvrBGf3fptwXRVLs9OXyvJ5Tavsdg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyMuuMVGtyGsMEnGzGtE8i6ZV6xhe6Sv2spvEPXoekP5p0t3gVT
	06KjUOjh4/WW8rSMZF+mu+1uH/k3cS4PWAYQIxI4bakM1/qPG28GYBAbIL/HWv8=
X-Gm-Gg: ASbGncukn10mE9D1ogF6nvUSkw1WlhYlGSBEEdzlyNP3bGSxPZPpZUn3FycNb8NnBlw
	3iGKDCbThMTSby1IAnaMEfJPKqZHxWJqTH3zHwdsKZZrsuK4wsJD198Bf0WeNQQuTrHRqgHiIkC
	Es92UH1f+cc9qbt9PnTHMevvP0lhJGpQMDdCWz/FMHy7EhOFX1bxSvGnR39DTrOvQJglo3kc9t1
	M2YYuHA1u0WVYLpu+ndQdn6dHAguz9uStnvSRrPoxywMzc1GmJNV926Anmq5cBzPt+i5VbtEIa7
	ioiY4ck7dUfGyV9OijQdpgZj8G5EbLGBzBg6DzOZeEw=
X-Google-Smtp-Source: AGHT+IHdGKX0HVzNGGfdBDdxemuHmtZKvg7K5PVnECIhdt+MxpRUfGTD31xYKTRhW3YYIyuHcN82LQ==
X-Received: by 2002:a05:620a:44ce:b0:7b7:2de:6fcb with SMTP id af79cd13be357-7be6320f420mr6624365285a.5.1738017123791;
        Mon, 27 Jan 2025 14:32:03 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9ae7ece0sm439931185a.8.2025.01.27.14.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 14:32:02 -0800 (PST)
Date: Mon, 27 Jan 2025 17:32:00 -0500
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	gerhard@engleder-embedded.com, leiyang@redhat.com,
	xuanzhuo@linux.alibaba.com, mkarsten@uwaterloo.ca,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v3 2/4] virtio_net: Prepare for NAPI to queue
 mapping
Message-ID: <Z5gJYOAUVZH8-4Pt@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>,
	netdev@vger.kernel.org, gerhard@engleder-embedded.com,
	leiyang@redhat.com, xuanzhuo@linux.alibaba.com,
	mkarsten@uwaterloo.ca, "Michael S. Tsirkin" <mst@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
References: <CACGkMEu6XHx-1ST9GNYs8UnAZpSJhvkSYqa+AE8FKiwKO1=zXQ@mail.gmail.com>
 <Z5Gtve0NoZwPNP4A@LQ3V64L9R2>
 <CACGkMEvHVxZcp2efz5EEW96szHBeU0yAfkLy7qSQnVZmxm4GLQ@mail.gmail.com>
 <Z5P10c-gbVmXZne2@LQ3V64L9R2>
 <CACGkMEv4bamNB0KGeZqzuJRazTtwHOEvH2rHamqRr1s90FQ2Vg@mail.gmail.com>
 <Z5fHxutzfsNMoLxS@LQ3V64L9R2>
 <Z5ffCVsbasJKnW6Q@LQ3V64L9R2>
 <20250127133304.7898e4c2@kernel.org>
 <Z5gDut3Tuzd1npPe@LQ3V64L9R2>
 <20250127142400.24eca319@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127142400.24eca319@kernel.org>

On Mon, Jan 27, 2025 at 02:24:00PM -0800, Jakub Kicinski wrote:
> On Mon, 27 Jan 2025 17:07:54 -0500 Joe Damato wrote:
> > > Tx NAPIs are one aspect, whether they have ID or not we may want direct
> > > access to the struct somewhere in the core, via txq, at some point, and
> > > then people may forget the linking has an unintended effect of also
> > > changing the netlink attrs. The other aspect is that driver may link
> > > queue to a Rx NAPI instance before napi_enable(), so before ID is
> > > assigned. Again, we don't want to report ID of 0 in that case.  
> > 
> > I'm sorry I'm not sure I'm following what you are saying here; I
> > think there might be separate threads concurrently and I'm probably
> > just confused :)
> > 
> > I think you are saying that netdev_nl_napi_fill_one should not
> > report 0, which I think is fine but probably a separate patch?
> > 
> > I think, but am not sure, that Jason was asking for guidance on
> > TX-only NAPIs and linking them with calls to netif_queue_set_napi.
> > It seems that Jason may be suggesting that the driver shouldn't have
> > to know that TX-only NAPIs have a NAPI ID of 0 and thus should call
> > netif_queue_set_napi for all NAPIs and not have to deal think about
> > TX-only NAPIs at all.
> > 
> > From you've written, Jakub, I think you are suggesting you agree
> > with that, but with the caveat that netdev_nl_napi_fill_one should
> > not report 0.
> 
> Right up to this point.
> 
> > Then, one day in the future, if TX-only NAPIs get an ID they will
> > magically start to show up.
> > 
> > Is that right?
> 
> Sort of. I was trying to point out corner cases which would also
> benefit from netdev_nl_queue_fill_one() being more careful about 
> the NAPI IDs it reports. But the conclusion is the same.
> 
> > If so, I'll re-spin the RFC to call netif_queue_set_napi for all
> > NAPIs in virtio_net, including TX-only NAPIs and see about including
> > a patch to tweak netdev_nl_napi_fill_one, if necessary.
> 
> netdev_nl_queue_fill_one(), not netdev_nl_napi_fill_one()

Right, sorry for the typo/added confusion.
 
> Otherwise SG.
> 
> After net-next reopens I think the patch to netdev_nl_queue_fill_one()
> could be posted separately. There may be drivers out there which already
> link Tx NAPIs, we shouldn't delay making the reporting more careful.

OK, I'll start with that when net-next reopens while waiting on the
locking changes to come later and do the actual linking.
