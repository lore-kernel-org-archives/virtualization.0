Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A314235354
	for <virtualization@lists.linux.dev>; Thu,  4 Sep 2025 16:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757005078; cv=none; b=cO9FiGM6Nmbn27L5YMp/F66D37+3saNDNB7q+uERLOu9CO5QPHb6MEg3mCDRUfUSJydQwyOlwgXytF27z11//GcaDZ/0QeKAofrAgkUQG8rnh0LgD+ROcs4p3dbdMGn599mOnMCq/az/4/m2uDl3zQKXbw802Yb+7nZXOOXYw6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757005078; c=relaxed/simple;
	bh=ouXa+buHgPojnDxUmIhZfwT7/tCXbaUJ9leCQVUxMrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c88DuJf+218spyX5SfHnWv0VZbldPCkmQMioTmV4xN6Mi774Uo3CYZu3hLVEefMtypFjyuIrQGPGAmJgSRjYY1/qh2nKm3Epyu35snIOS2qu5+/+tM1wP19fuBg64wAzZGswYI9/vrBbJWa92W4nUIBbccO6oEZOCgSDzs4A+M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbsEUuAf; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbsEUuAf"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e96e5535fcdso2400048276.1
        for <virtualization@lists.linux.dev>; Thu, 04 Sep 2025 09:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757005076; x=1757609876; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=irrrx3eJCz7Erx4j7m6TJA4T3jMD95DmIwByWZVQujs=;
        b=mbsEUuAfiW+pZWgP28LMzanzLK08tfScHlLmbK/vNax9Ia8B8HaC4b/kimrjAzkae3
         S7n9+9SukB1J9n1JW73TOYaDXrcopCxn+dK749H78iLPzCxcB3X0Ui+VavaI2tbLCKI0
         BRW+3/XUTwo9Wam8IHPeFhD+cdSbtOpJ/mI3XeyKCrZiHIaD96/2GQOyEwUx0vfVVJgQ
         Dw33bZ4aMH3ql01xrZr7eQpJpRHeP7Uo8+7D4n3/ulM3PTkcldt4pqSzAecfqPLiQHxV
         k/etCflS2Mik4rDP2210a7vuW8mChTO3KPy4xTw4qa5mYuZnYKTk3GicwXXKJVtfMWZO
         Ltdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757005076; x=1757609876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irrrx3eJCz7Erx4j7m6TJA4T3jMD95DmIwByWZVQujs=;
        b=utVY1hrFKc5sE//VDBa2LloYLCvoRf4gABJFkQJqH9+RLKnL5wUyToHENFImTVa5Yo
         iXU+APpyZu4qazg23rXBgKfHYE4RVSBobDWg5PBqpO0gs5KRg0fzSxpDQbYjZUWqtRfh
         Wn1iZkzFRRRjEXK28DDjm5d2MoEqSEPeGIjEHPAbTdo/nET86t8QruWfi6TPvUci08Pa
         M1VQgy2/IlkEyaE0KPP2JAdQboq5hen7T1V2iYeVmUmdbDeLwiOLommKpIaFQAdpwHyT
         klwtUgBG+ysWSvyuupZYr6HimOig29u68zuu63wRRgDrP9jFPwW4jw6D9PZ5jG941jBp
         HAqA==
X-Forwarded-Encrypted: i=1; AJvYcCWuyE8GQDICIWTFHWQEWUO1bvmYAxkmjFd8/0H8rwH6fAYUoTiKKHYsB2+gmp26C7+1AATCgjsSmJH8xF1XDg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxXLRJPnV8+cVEMsym2GIiRgdymDMLJ8iy2EY6husXLJfiXGd3X
	fqBHavDT3xNjChyEtSaXT2kT0RV1+Zym4h9yXsy/6xach110kLG2QQev
X-Gm-Gg: ASbGncughfDK6iHIidBW4Srz0ENLrfcP7xO67TSdqSstfUbWqRZuLO74dy2jOsgsdSL
	UT1egpptPn8eyWbCp5P9jjhyS36yvVHQ5oGVpoEWPu3HlDTBAZUUc+GNaG4Lk//Bljz0QPN0LcZ
	HoLWSbQcbxJqZo9pSWN+yiGbGYo1amXFRoZccOrbeNPEYuSoP8ixgf8bc7b0UmZvr7hkFNvTpp9
	RmkXNM15zFiK8ieAamJeno/StrdbS5VBifgMUPe763xKSGdaMXygKH8dlLqqiR+SQFoAcVAyMkW
	JHN36P3+cmjkRkcefx9soyv3MI3dbzoGVHwEsvlIUr2lb+falCATTRtiSAPca/uYZMU6NVqPNJx
	enrolArKnQ98fxE4paWUGVkrhgetRj33KRgdRIWPmZnFva+Y=
X-Google-Smtp-Source: AGHT+IH84tU1qbIF/86A4dwkWsNLS9E7ptPPrXXDoSkNZ0JGyACTTGW1vQFLOTahp7MDXGWvzB7z0w==
X-Received: by 2002:a53:bac6:0:b0:5f3:317e:40c9 with SMTP id 956f58d0204a3-60b699833femr293555d50.17.1757005075778;
        Thu, 04 Sep 2025 09:57:55 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:73::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a8503294sm22857357b3.42.2025.09.04.09.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 09:57:54 -0700 (PDT)
Date: Thu, 4 Sep 2025 09:57:53 -0700
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
Subject: Re: [PATCH net-next v5 4/9] vsock/loopback: add netns support
Message-ID: <aLnFESZSETzh/jMh@devvm11784.nha0.facebook.com>
References: <20250827-vsock-vmtest-v5-0-0ba580bede5b@meta.com>
 <20250827-vsock-vmtest-v5-4-0ba580bede5b@meta.com>
 <mhjgn7fdztfqi6ku3gesgd42jj5atn4sqnvpyncw2jds23dpc3@iiupljayjxs4>
 <aLcy4Kk0joVPbxkd@devvm6216.cco0.facebook.com>
 <yuumxtgizcrkn4uspczro76p6u2dqvra5otqkrb57bi2se2lpx@zg4f4rtix7hb>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yuumxtgizcrkn4uspczro76p6u2dqvra5otqkrb57bi2se2lpx@zg4f4rtix7hb>

On Wed, Sep 03, 2025 at 05:10:31PM +0200, Stefano Garzarella wrote:
> On Tue, Sep 02, 2025 at 11:09:36AM -0700, Bobby Eshleman wrote:
> > On Tue, Sep 02, 2025 at 05:39:33PM +0200, Stefano Garzarella wrote:
> > > On Wed, Aug 27, 2025 at 05:31:32PM -0700, Bobby Eshleman wrote:
> > > > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > > >
> > > 

[...]

> > 
> > I could be wrong here, but I think net->vsock.loopback being set before
> > vsock_core_register() prevents racing with net->vsock.loopback reads. We
> > could add a lock to make sure and to make the protection explicit
> > though.
> 
> I see, talkink about vsock_core_register(), I was thinking about,
> extending it, maybe passing a struct with all parameters (e.g. transport
> type, net callbacks, etc.). In this way we can easily check if the type
> of transport is allowed to register net callbacks or not.
> 
> Also because currently we don't do any check in
> __vsock_register_net_callbacks() about transport type or even about
> overriding calls.
> 

That makes a lot of sense. I'll make that change if pernet_operations
doesn't solve the probelem.

Best,
Bobby
