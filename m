Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707A22F0C7B
	for <virtualization@lists.linux.dev>; Tue,  2 Dec 2025 20:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764705639; cv=none; b=esAvOu1y2LWoqWUPu+C3lULSfp8KvUtwnX2ERJGQaQ4yDy00WMYhOtdGc7eDitHeGzB/+BO+296mTTern5XROBKH3AZIMmcfErYNkRv3UCmNE7kIEZcwLUDC6RaGI2bwJfDHr8AhOrMv29ZVbX5DbbnhnTm+ID2XDLugb6EkQvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764705639; c=relaxed/simple;
	bh=te4N56NzYz6/dMTrZam+d7syXgjYPyZteJDV4l74esI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnojgBCFF/XgW1IyZgXzehhhZJXBUx9lNvziUVlUL00/WZq7sRB+c6ZoEWdoudfmsrEUuDiRaRSzfQ7yDdIFX6E33aIzeicWaoPej25tFIUu8QxSs3mdw7gTZ+LZfEJVTBu36wBDqVcfIJSoTvmnGSqwEPNdlWQ9jj75wHVChgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZCfxpk2s; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCfxpk2s"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-789524e6719so3570137b3.1
        for <virtualization@lists.linux.dev>; Tue, 02 Dec 2025 12:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764705635; x=1765310435; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XOvq7zGQWlXv7Qg5p/lBCK450NxRsWzSuFDUvE6KnLY=;
        b=ZCfxpk2sDiMdlI/9nLPx74W05dtA1ZRlfJeCg/h2CWAyMu3Pp8cSXnkfwhiLN9tKEx
         g6YY5iItlhvbvGIKsriDmyrDq70gbC0ZXZkOIG1XFo3CzRmgExNirEIad6s2wOiUplM4
         nEsBuAtRJRIgq2sGWIPS7+smLlhtnG0Eor4IxSBQdtDFKzIYS9V2jyEXEC/XaEUoIRUB
         UDKuZFr+jhhqkXgEPmOLQepxk6fPdf4lyUEMHWm5BheylApJ0P9MehoqZ0LisQEVff4b
         iD3CcO8r2jQQZmGGJexARb56YVAyJbQVLhwX2XJXCCpsNenftav/hnkxx0Jhrx08ao2n
         FgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764705635; x=1765310435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOvq7zGQWlXv7Qg5p/lBCK450NxRsWzSuFDUvE6KnLY=;
        b=xG5w09NMgd5+N73b5QWwJsdsCofGgXuwZz8qFpOKYvfhxibZYtefiKFLYqs2NxKf6d
         XDowN/SeqKwj8Z7LT6tsjoH7hj5MLKgrkkZEP4n3m92y1pPiBVTD0cSDf1u1xWz3OS0W
         c7a+TuF5+owCN8PoQsAOFeTMacngxqrtDTj4rLzZwyZkK2qlvAlmZSn7kdgjsDXOQsdA
         RotJ3YMaNdWnshbyEuWTgBBYxcf7p4a21bGt8PXgoD/FJbXIbx2dwtXdV7DE5bzixZ4h
         G+rjDrlB4bh6MvMHwqQk40KL318qt0FZOo8w7uRZw56eOpyEGvk07U8waGGVd0jF72d0
         jZ7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXE7Lpo2GOs+1AzMWTWg1FPscV+Ij5/vvrvkwq1iQSITLQ9H9MBBamFwzo6z06PnPuKJjDficJM1BDH/jhXEg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzyiqk1446I6Wrax3dGoK3w1u7klaBVtDKSUtJSDoMTmzAvPN0F
	kbvuuVtEufvzoeFPnB9ClwOEjLHeXF3JxZray+YJRv/2SrOoNLUmaRin
X-Gm-Gg: ASbGncuGHzN+Z/Hoiqf1BCB/B6zyvme/r/k30/J7xhlpdvu7V0vrfLpIy0dxiFrnU1G
	GA3c6DmNSXxNhg+fAmfu6OHojaZRr/CqSEh13CQL2MNqsg7LS24VmGIS3e/fEawaafknuN6yX1u
	2HEHQAiSWfdFNNEDmjHReNmZ1YCH7ddHR1PA7vy8pjiWo7vZoP1sOQdTOD/H8yxJaVRtrnWLJLd
	Q7i3dz/N4HpEDaz3XAlontSrql+ff3TXBcel+QGO0YXwiw2aVSflYNoNlu3hj+VsOGheqV7CKm/
	EdtN5NUDXQIQwUwmCWkhxoUOQHiBgxuqe5M0nBGA5vHf2Oi8HUXUUM9k3ZMZttCakBY32Oxhmjr
	ewGOQW6CrRk7VYzTK2aFuIChVlfRbhgDpWifc1EyTps+KMVSVDp23G7AaDxj3NSlfmvtdE4q+XP
	OrsXi6K9fJ/B0DMpyUcZxzeRFHhKF7qnSGGWmQuP++h3bjmw==
X-Google-Smtp-Source: AGHT+IE4Lw0nvXL8yqBtDuOK7QrlnTetNDoVmfVcyfoTP8VgYdTEu+GudPd/2RaoWo8nWv4q3HA7Cw==
X-Received: by 2002:a53:b10b:0:b0:63f:a6e9:4048 with SMTP id 956f58d0204a3-6442f16a1a9mr2475593d50.26.1764705635271;
        Tue, 02 Dec 2025 12:00:35 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad0d5f4c5sm65824697b3.13.2025.12.02.12.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 12:00:34 -0800 (PST)
Date: Tue, 2 Dec 2025 12:00:33 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, g@nha0.facebook.com
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
Message-ID: <aS9FYWd3SDYu6U1v@devvm11784.nha0.facebook.com>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
 <20251126-vsock-vmtest-v12-4-257ee21cd5de@meta.com>
 <6cef5a68-375a-4bb6-84f8-fccc00cf7162@redhat.com>
 <aS8oMqafpJxkRKW5@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS8oMqafpJxkRKW5@devvm11784.nha0.facebook.com>

On Tue, Dec 02, 2025 at 09:56:02AM -0800, Bobby Eshleman wrote:
> On Tue, Dec 02, 2025 at 11:18:14AM +0100, Paolo Abeni wrote:
> > On 11/27/25 8:47 AM, Bobby Eshleman wrote:
> > > @@ -674,6 +689,17 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
> > >  		goto out;
> > >  	}
> > >  
> > > +	net = current->nsproxy->net_ns;
> > > +	vsock->net = get_net_track(net, &vsock->ns_tracker, GFP_KERNEL);
> > > +
> > > +	/* Store the mode of the namespace at the time of creation. If this
> > > +	 * namespace later changes from "global" to "local", we want this vsock
> > > +	 * to continue operating normally and not suddenly break. For that
> > > +	 * reason, we save the mode here and later use it when performing
> > > +	 * socket lookups with vsock_net_check_mode() (see vhost_vsock_get()).
> > > +	 */
> > > +	vsock->net_mode = vsock_net_mode(net);
> > 
> > I'm sorry for the very late feedback. I think that at very least the
> > user-space needs a way to query if the given transport is in local or
> > global mode, as AFAICS there is no way to tell that when socket creation
> > races with mode change.
> 
> Are you thinking something along the lines of sockopt?
> 

To clarify... do we want the user to be able to query the socket for
which namespace mode it is in (so the results of the race can be
queried), or are you looking for a way for the user to query if the
transport supports local mode (maybe via /dev/vsock ioctl).

I'm not sure we can attach a namespace to a transport per-se, as
different namespaces in different modes can use the same transport.

Best,
Bobby

> > 
> > Also I'm a bit uneasy with the model implemented here, as 'local' socket
> > may cross netns boundaris and connect to 'local' socket in other netns
> > (if I read correctly patch 2/12). That in turns AFAICS break the netns
> > isolation.
> 
> Local mode sockets are unable to communicate with local mode (and global
> mode too) sockets that are in other namespaces. The key piece of code
> for that is vsock_net_check_mode(), where if either modes is local the
> namespaces must be the same.
> 
> > 
> > Have you considered instead a slightly different model, where the
> > local/global model is set in stone at netns creation time - alike what
> > /proc/sys/net/ipv4/tcp_child_ehash_entries is doing[1] - and
> > inter-netns connectivity is explicitly granted by the admin (I guess
> > you will need new transport operations for that)?
> > 
> > /P
> > 
> > [1] tcp allows using per-netns established socket lookup tables - as
> > opposed to the default global lookup table (even if match always takes
> > in account the netns obviously). The mentioned sysctl specify such
> > configuration for the children namespaces, if any.
> > 
> 
> I'll save this discussion if the above doesn't resolve your concerns.
> 
> Best,
> Bobby
