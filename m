Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA002D193F
	for <virtualization@lists.linux.dev>; Tue,  2 Dec 2025 17:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764698167; cv=none; b=c+GaWlky5Jc3had1DblrKxAjO8r0T6vAt6vGv8lZyw3gfPrQXbltDdhSHFhQGeKBdxuhhVAO4TM9Rr8fpDGbpKRFU6Sg/kUZA5/TYXi/qzjtLyWSottvhoHEaQ6sD+zofeyvpsRgZ+UW8yiIa6p3IYW6PJcDbDv62NwlraqcI1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764698167; c=relaxed/simple;
	bh=NNJZa3lYs1HsOUBIuFpcTtIqAcyjGiny7NhOTTEAIgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfC/EWdQ9VyerAoe3+h3qoK/N046ByEIsFfTduC9V5NH+xeaS8k5neVAsjh4CzdiC5s+6R0Kf7xZC3LqxW5OsldQHQAUCCMPAb27lTUlClZPAlflTc1xerDjJqAH37+7M9tdjbkEbj2cQnbTi/Xql82TI7RrxQO9wHbMyvuefH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CW4Z/px5; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CW4Z/px5"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-786d1658793so48244937b3.1
        for <virtualization@lists.linux.dev>; Tue, 02 Dec 2025 09:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764698165; x=1765302965; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b7vZxiysLlSxuLZX46Kvfy9pEAECDucG1jVAjFchGcE=;
        b=CW4Z/px5K8iJzLbhu5q2ebltdFZGD3s7sWKvrtJznrjcWp3VCB/c9DkbMVz3MzGgpI
         V5Mfhc3gNTZMYcBVogwr2gSwBPRgJQtZDvQBNSHzdXT95tGEO7/k1jYYd67a1vLv3CKS
         C9WOXBrnXEAXPeL37lXo3ocj4ZPed2dvvnG6wjE7mAYc4j7GUcRzIsQ08wBE4UTSx8fE
         0e2pDW/iE1nFf9sbz2/Jxj/uplt5fuH5kR7U8Phrg7kN3nkNhRC1jn2wysmqjHGu2wZm
         x8Vt/RApHNLMimVok0RkZMk/sU3IWRfGQ/ISpAhN/kgZXx5BJViPV6fFDNw8wFMabOl7
         BdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764698165; x=1765302965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7vZxiysLlSxuLZX46Kvfy9pEAECDucG1jVAjFchGcE=;
        b=YkUskj8mIFKsql8BcZfhGzFRBIo9IhvZ4H2FJsZ4quGzBlFh2RvdR0RiIm/RuCV1jF
         zfczl4APTZQyCfKjcqMcTp5xIujvmqR77o/0XgFk7tTuuZIgFfIwnpcONKPnCI4dWG7T
         XqGyglYCkShUys2d/pikhNjH0gmdStGRJRY1lHmhIZxrHIvYPrj/uLAkKcivstJpXZ3y
         z7WVuEPyANEXs9bwiB3v+YLo9SpjC/4JRGfcANWlbMXHsC0xcyETCvxgnYnoAyUROFX0
         jqNGKwz2uqG+XAMtsOyqscNJnUNr1BrNqcv1HSnLJE+/72NX7LFE4ByTQhxqRL2r40A6
         7oiA==
X-Forwarded-Encrypted: i=1; AJvYcCVY7/23FxzgcX/9qqd1OJFpCoyOnWRHB72/Z6q71qWYtCWcdGCc53brmIHWVuuI0d+uJQY/FmpawOIcj+dQWA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyqwkZYodsyke1cA3PkqOGP/V/iv2qo2YUqpOXehPNu1lv8Ui7H
	hyUZkk0aSB9O/DPodKO8wjJzA6VcAsZNYYefAqWq2DKfnrUtHyFmZJ2a
X-Gm-Gg: ASbGncvKCLj6X4BAIuo6ntTw9ioZ9pZiCwLZ04CVe64YF6yQ18kpw+RMb0QyVJy0PlE
	aVdihHmjS0ROrMkHI2V/DiNyZ+QgTYxZflFNIvw6UgQLrwhpBlbx0fccadCgJBodOn+eb8oEc9b
	vyB5e4eAUq9anqoHuaVuCxeDogsbudj+27G5T3I2KUYOUCJZ7Ey4NpdWKDQDsgiQNu4bzacYc8v
	SGm1+BM9lQn1+k4mm9G24O4gC5ZPejjTqxrvZXhhO1e7LY5MTlCtKIxCV7g7DC3h7T624uB5MVj
	r+pvls/LuJjfPl7BGmwHMPgCl08zcbemV53APO5HlhMBD8u4m6SVr4x63YHxtQXAaVTSvzt1I6y
	q8BbsRt5uItY+IhRgyo/LjMaP1ffE5b9fto4UZD2HHK8qVIzR6TA3qO3YqzG/uZbgwQHsDq0SGY
	EvGezHrfpGW4MhV2eF2kBIrWl/u7stU8RVlynJeGxsSjoZ8J0=
X-Google-Smtp-Source: AGHT+IEnSlAlHDUf120qJOiOHTcx8J+isqzg/5s1dw3tbZ5v6cDlgU/zp4/SXX2g9a81U9jTgGEZ/A==
X-Received: by 2002:a05:690c:3601:b0:78a:6a6b:cced with SMTP id 00721157ae682-78ab6fb335fmr452183477b3.64.1764698164723;
        Tue, 02 Dec 2025 09:56:04 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:41::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad0d3f5a1sm65198027b3.12.2025.12.02.09.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 09:56:04 -0800 (PST)
Date: Tue, 2 Dec 2025 09:56:02 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kselftest@vger.kernel.org, berrange@redhat.com,
	Sargun Dhillon <sargun@sargun.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v12 04/12] vsock: add netns support to virtio
 transports
Message-ID: <aS8oMqafpJxkRKW5@devvm11784.nha0.facebook.com>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
 <20251126-vsock-vmtest-v12-4-257ee21cd5de@meta.com>
 <6cef5a68-375a-4bb6-84f8-fccc00cf7162@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cef5a68-375a-4bb6-84f8-fccc00cf7162@redhat.com>

On Tue, Dec 02, 2025 at 11:18:14AM +0100, Paolo Abeni wrote:
> On 11/27/25 8:47 AM, Bobby Eshleman wrote:
> > @@ -674,6 +689,17 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
> >  		goto out;
> >  	}
> >  
> > +	net = current->nsproxy->net_ns;
> > +	vsock->net = get_net_track(net, &vsock->ns_tracker, GFP_KERNEL);
> > +
> > +	/* Store the mode of the namespace at the time of creation. If this
> > +	 * namespace later changes from "global" to "local", we want this vsock
> > +	 * to continue operating normally and not suddenly break. For that
> > +	 * reason, we save the mode here and later use it when performing
> > +	 * socket lookups with vsock_net_check_mode() (see vhost_vsock_get()).
> > +	 */
> > +	vsock->net_mode = vsock_net_mode(net);
> 
> I'm sorry for the very late feedback. I think that at very least the
> user-space needs a way to query if the given transport is in local or
> global mode, as AFAICS there is no way to tell that when socket creation
> races with mode change.

Are you thinking something along the lines of sockopt?

> 
> Also I'm a bit uneasy with the model implemented here, as 'local' socket
> may cross netns boundaris and connect to 'local' socket in other netns
> (if I read correctly patch 2/12). That in turns AFAICS break the netns
> isolation.

Local mode sockets are unable to communicate with local mode (and global
mode too) sockets that are in other namespaces. The key piece of code
for that is vsock_net_check_mode(), where if either modes is local the
namespaces must be the same.

> 
> Have you considered instead a slightly different model, where the
> local/global model is set in stone at netns creation time - alike what
> /proc/sys/net/ipv4/tcp_child_ehash_entries is doing[1] - and
> inter-netns connectivity is explicitly granted by the admin (I guess
> you will need new transport operations for that)?
> 
> /P
> 
> [1] tcp allows using per-netns established socket lookup tables - as
> opposed to the default global lookup table (even if match always takes
> in account the netns obviously). The mentioned sysctl specify such
> configuration for the children namespaces, if any.
> 

I'll save this discussion if the above doesn't resolve your concerns.

Best,
Bobby
