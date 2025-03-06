Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C5C1865E3
	for <virtualization@lists.linux.dev>; Thu,  6 Mar 2025 01:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741225362; cv=none; b=ZeGgLMSZ+Q5QDSUQwgCEYNaeNJd2PeSgOo+RKX7Y2COyyofno/G9I55RKF++kp8XJnCsl0mmSUJ2S/R9bpoOKWfCrgfNzqUVw2NYCkii9YswskOWQnyLxYvDlW7xVNR7Nr/KDqIg+X3SIGfcJ++cRJSEw+HuJTmfti8v8CMWVnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741225362; c=relaxed/simple;
	bh=XHvW3ycQBFWggaOSJ8vyOSVd00mPwcXwlVmZWzFWPGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CymVsB0U1Ancn34ktWqwBT0rqulmC3/7bdGwL+eR2UPmAXBSiLk2fUxWnqOx8j9Iz4h0rq0dSIfhR/Zmdqlaro+fNTPNnFtjXaKSGLtdcVgBK+o0ce9/GiPgCxQXIeiHMOWgl0skkHv744AyAcU5k0HANicjYZzIxeCiygZIaX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=NlLNlobK; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="NlLNlobK"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2240b4de12bso2221205ad.2
        for <virtualization@lists.linux.dev>; Wed, 05 Mar 2025 17:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1741225359; x=1741830159; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJKWxmub+lotgzSWC/amTp/chHjkeAB/SDtxMJaHbJI=;
        b=NlLNlobKjElLgNCtc8jzrVY+Xa3bHKIINjA5ZZvKtah9SKRW6gRlVen7H2SXSlzcjo
         +8/AVALKCJmvc4y1gbuR/6gEAdECb/HvSPiwRgi9TGu57HEzCZoAQxa/Qhz/vO5cL+Zi
         lhhe4jAdvVasPZ1kIT5Xbtf4CtRUniMgz2gj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741225359; x=1741830159;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IJKWxmub+lotgzSWC/amTp/chHjkeAB/SDtxMJaHbJI=;
        b=rT2khdcVTlZ26y8g0p3wvkLScCfa6hgbr8QHxefoKCDpwWO0OX92w0wF17lX6IKwxe
         2n/BoPIJ+ZkDLU9q+hyEicPyYKhYCkehoj/qqiwg+BqmgNQoF1rJRqT4iVle8Oi5aOgZ
         outVqwxxJAEZFcNNyNQSckKMpthWM5Tsor6Fm28Hv1LPzJ8hzgz3f2P2oh+wJnNqjZMA
         2CkBGWbMG+2SqQO3//0WaJLplpek7kaO0Us/JQYDAx8gNho2K7q88G1I5ZhdGRtbrRjy
         Kv6LRdFlNdtpxx2nyzBEbglveWl/gUjrMXr6E2DT3r2OA0XrwQcaxXe0wPHUFg0mCT5n
         dNWA==
X-Forwarded-Encrypted: i=1; AJvYcCW0CzDOfNYbPv7hBrqytOkhwhR/iwh3hh9RygzwLmmrGIjAGh+Ou9ybpZ61A5LyeWTn9OENwlEm0ocDoXQ9+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzd2wAnd8DiEg7YeNB5vkxw8yRAchJrS99I743K/jgsYHBsQmy0
	QAxxAWdWH0+yxWml8lFS5eKpcfjbpZF6ObVF8qog0PS+HTMjTD1cZlVWBdQLqUk=
X-Gm-Gg: ASbGnctTuOHCmX5KpCNf+yRBxnl14ElsScwiJ9HEPHjh9unkBEiad82C/M/5mqztVCa
	CivqXytbGCL+8ZPbvV/5lZisXGcwoaVdqC8CxWCdqxnZxSk7om6Uk5du1g/kkSvVfAON1/m4DJ0
	DGBMhKKSjSmyU8NFWN7CRAslFLXR46QL18WahrOAnZwmhTDa9EMPqAl97d/doY9GPcC/u6U6f73
	H15h76RAmr75EqR3fYDPlAgxjexNPx/y4XR46eJZvuNYYyuZtWnTDsKiMh4jv8m2GKfovCJeDvQ
	u+7+9gFe272iBc6TSRLyD0/vjWoy1M5I+rljpWud5galg9Qdx4m0YkbSBaHIN8LGJszKU2wu8NF
	e73mPCIXOusQ=
X-Google-Smtp-Source: AGHT+IHimzEWYok/7eEF2qEOfWup3jke8xbE2s20bz5FMsbXG9wqEzxeTrKe9ompiWcW/VmgcjtyoQ==
X-Received: by 2002:a05:6a00:2e17:b0:736:3ed1:e83a with SMTP id d2e1a72fcca58-73682be572bmr8332195b3a.12.1741225359121;
        Wed, 05 Mar 2025 17:42:39 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73698514eb7sm110830b3a.122.2025.03.05.17.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 17:42:38 -0800 (PST)
Date: Wed, 5 Mar 2025 17:42:35 -0800
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
Message-ID: <Z8j9i-bW3P-GOpbw@LQ3V64L9R2>
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
> 
> Middle ground would be to do what you suggested above and just leave 
> a well worded comment somewhere that will show up in diffs adding queue
> API support?

Seems like Jason agrees that leaving refill_work unmodified will
work [1].

I think leaving a comment is a good idea and am happy to do so. Not
sure where would be a good spot for it.

Two spots that come to mind are:
 - in virtnet_probe where all the other netdev ops are plumbed
   through, or
 - above virtnet_disable_queue_pair which I assume a future queue
   API implementor would need to call for ndo_queue_stop

I get the feeling you have a much better suggestion in mind though
:)

[1]: https://lore.kernel.org/netdev/CACGkMEvWuRjBbc3PvOUpDFkjcby5QNLw5hA_FpNSPyWjkEXD_Q@mail.gmail.com/
