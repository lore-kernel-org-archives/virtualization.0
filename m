Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB1A27932E
	for <virtualization@lists.linux.dev>; Tue,  4 Mar 2025 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100942; cv=none; b=N7AFHUzrYXyh4NLv+WZXu4n7Az9ayvXM3IchRvEfd0CFX48KxLG3puS33SEfsmteshmxlLS3eqjHxaznobK+AFSsOZnAX1iIkeTzVMtMaSyGhqDRdvSNvB4hfJLckjwVYFiYgVxErwNNhpjPx03zoL4rjzpLBEF4f0GNVrTN6fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100942; c=relaxed/simple;
	bh=8PdHR+go0LZyaSvswv9QdAwopu5SDegpWFTZMMMm+JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGc6AikkzgEIoYBfAv1Xbh4D/0A6EDGogfp/ARKGlzHabayfL7VM4fJq86JFB99+TXIiqFbUCm4znh6M012d5yfpGOw/pUaX89Cch4k+gD1GUVeS2unUbsvDYo2bzuAQGLUjC/9qum8vxtg1FPwHjfnzLqsEXbxk3QqVMV/vIrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=qwkI7scy; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="qwkI7scy"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-474bc1aaf52so49339021cf.1
        for <virtualization@lists.linux.dev>; Tue, 04 Mar 2025 07:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1741100939; x=1741705739; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BAJF5oZvK4kDimU1hi8HyGe8Ni5obiEempBFfdSb2no=;
        b=qwkI7scyyPIIdUV4/SO9/cR0ucwUqe9JgNTQP+TQOsszQ8bB+mPMytFQcQosD3vr/V
         zIkfxGVPI8BBsT36drxfMsjvbnYBllqsXay0+EzM5zSYwqXSd97LDdYq+X44TFzVdO1c
         Y9kzNjdKKIS1/WlvP8dMI/z1l5BjxeB+mzVSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741100939; x=1741705739;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BAJF5oZvK4kDimU1hi8HyGe8Ni5obiEempBFfdSb2no=;
        b=oSZiz3oA/yO5ElahCfvfCf+VZ/2QdXwdvRiITiffWwjKnQf0KHRCkLEkUeq4q5USrI
         Rp+QG41rxit9S/zH5yqDsd/FProURq1Tcy2+atKi80K4bK54EmPyp9FTF9ChnvBzjtpl
         58aWeD7SE89oQ9NXk95n36olSqcKTt3Cq0Rl1vitgEOpLF4ddxzTAMClAKA/WpnWKOcm
         Pz2/6VRBLm092JZUBZSXL7mqm6fDanh/gxxt71kyq9+pVywMDyIeormMySkjNDN7u8PI
         4aRBWmSKWKR9TVNSEOq7VQ9kqw/RLz59zOkluqGTkBQpIPdlPxxpckyW+JqM2mTiR54V
         GI5Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3wzWlFh6PvE05zHYMZCvs3wE0YwOU4w3PtDoIDgF9X+QG66cSOIN0hi2q3BT1AfbHkmnjJklaIDBs28a4Pw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyj6A4z0daWmsTtxSxK2kMzNwAVMvJf1M5cmNVjy0wiaNlusj3a
	BAWrD1JbRYdZGjQxkEZF6Yq3nJVWqNVvgPKC0Ks3QYr5mvCQ0dWrFqnwLbWZIpc=
X-Gm-Gg: ASbGnctwJJEKLoVkUoPXcYlbiWHt/NMyB6CrSHWFL4xAwxNb9e0DenDRYD6KlfvME0O
	M7WS025+EJ6ZLDDrgfQ967DoWQqWAQBlumfuyE1L3qktJnE/8THFHI6PBNVqOTFLEpxOlU2x3Bx
	04qMxjnFTduPjqxMg1aZOKgYCASR6Nhm+QCs2bXLpQkfIK74Mvjcx0sTvJMnREMp4gcNRk3fQAV
	vRW5RhFdWp19rYGjbaDXpZLCrstMz39oN8g2eLsPcJFUnPPg1u5T8dnBzQqogArgdWnz00x4mTt
	5naLbI8fRQmCsSO1UHY8wDkIS3eX54zsOWwy1AUl0+WwVWw46FXVhMLPZRlN4HP2mwydOgSb+XF
	tJaF4/wg=
X-Google-Smtp-Source: AGHT+IFN7StRwj2Ft1J/Us75lrKPTPd2o+N24d4I6qj5+wKxsZNxpj1S/cF2hLsjZ4/ip/QBD/Wuaw==
X-Received: by 2002:ac8:5a49:0:b0:471:bcb7:7897 with SMTP id d75a77b69052e-474bc066ee2mr231531011cf.1.1741100938725;
        Tue, 04 Mar 2025 07:08:58 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474721bf582sm74153761cf.37.2025.03.04.07.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:08:58 -0800 (PST)
Date: Tue, 4 Mar 2025 10:08:55 -0500
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca,
	gerhard@engleder-embedded.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, mst@redhat.com, leiyang@redhat.com,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 3/4] virtio-net: Map NAPIs to queues
Message-ID: <Z8cXh43GJq2lolxE@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, gerhard@engleder-embedded.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, mst@redhat.com,
	leiyang@redhat.com,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
References: <20250227185017.206785-1-jdamato@fastly.com>
 <20250227185017.206785-4-jdamato@fastly.com>
 <20250228182759.74de5bec@kernel.org>
 <Z8Xc0muOV8jtHBkX@LQ3V64L9R2>
 <Z8XgGrToAD7Bak-I@LQ3V64L9R2>
 <Z8X15hxz8t-vXpPU@LQ3V64L9R2>
 <20250303160355.5f8d82d8@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303160355.5f8d82d8@kernel.org>

On Mon, Mar 03, 2025 at 04:03:55PM -0800, Jakub Kicinski wrote:
> On Mon, 3 Mar 2025 13:33:10 -0500 Joe Damato wrote:
> > > > @@ -2880,6 +2880,13 @@ static void refill_work(struct work_struct *work)
> > > >         bool still_empty;
> > > >         int i;
> > > > 
> > > > +       spin_lock(&vi->refill_lock);
> > > > +       if (!vi->refill_enabled) {
> > > > +               spin_unlock(&vi->refill_lock);
> > > > +               return;
> > > > +       }
> > > > +       spin_unlock(&vi->refill_lock);
> > > > +
> > > >         for (i = 0; i < vi->curr_queue_pairs; i++) {
> > > >                 struct receive_queue *rq = &vi->rq[i];
> > > >  
> > > 
> > > Err, I suppose this also doesn't work because:
> > > 
> > > CPU0                       CPU1
> > > rtnl_lock                  (before CPU0 calls disable_delayed_refill) 
> > >   virtnet_close            refill_work
> > >                              rtnl_lock()
> > >   cancel_sync <= deadlock
> > > 
> > > Need to give this a bit more thought.  
> > 
> > How about we don't use the API at all from refill_work?
> > 
> > Patch 4 adds consistent NAPI config state and refill_work isn't a
> > queue resize maybe we don't need to call the netif_queue_set_napi at
> > all since the NAPI IDs are persisted in the NAPI config state and
> > refill_work shouldn't change that?
> > 
> > In which case, we could go back to what refill_work was doing
> > before and avoid the problem entirely.
> > 
> > What do you think ?
> 
> Should work, I think. Tho, I suspect someone will want to add queue API
> support to virtio sooner or later, and they will run into the same
> problem with the netdev instance lock, as all of ndo_close() will then
> be covered with netdev->lock.
> 
> More thorough and idiomatic way to solve the problem would be to cancel
> the work non-sync in ndo_close, add cancel with _sync after netdev is
> unregistered (in virtnet_remove()) when the lock is no longer held, then
> wrap the entire work with a relevant lock and check if netif_running()
> to return early in case of a race.

Thanks for the guidance. I am happy to make an attempt at
implementing this in a future, separate series that follows this
one (probably after netdev conf in a few weeks :).

> Middle ground would be to do what you suggested above and just leave 
> a well worded comment somewhere that will show up in diffs adding queue
> API support?

Jason, Michael, et. al.:  what do you think ? I don't want to spin
up a v6 if you are opposed to proceeding this way. Please let me
know.
