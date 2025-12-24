Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6641F0994
	for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 02:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766542485; cv=none; b=AgjkXhyJzDHMTgYX/qTXSh0GiWyMCqq7g8XwaMYh6AZ694sHynNR8GXOUojapfpvTx+Ex215Aryl4v+6HM3tOcpOf9eQq4aTVN6r5xGOxzN12F6U+WBFICU8/Lk2liAMfesp0gmbJfr5HLewJ/l5sOXgY2Owl3xlVDIsflVGH9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766542485; c=relaxed/simple;
	bh=fag3FxlJG3ZXO56Q4uis4IXo7o2vEhpJMwuQCgBCfc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJazSySuW3iXpPDtP09huKrgQS7Rm6t3PBUSVpJvkNOG7BgEPGO0pmiWZWb3+xL7FbQOqloxBt8sxVxDoS4E//bbMZnGNp9agV4qH23LP4qLJxrKPD3aJi9LZSAini0F3+zQxPOFauV80c1GtnLgZGSq2IcNYZluNFlHsRDKY20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcdPidSQ; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcdPidSQ"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-65cf597a717so2208220eaf.2
        for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 18:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766542482; x=1767147282; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mn5gdOJNVLCgqxTAZaOj5KghlS4vIZEHYcNf0bwJm28=;
        b=XcdPidSQOcWF6wr6lRS2iDI0JqW0S0tsaCnOQBwYWnwk30QZB3LRZ4rQ8PIr5JprCX
         rdIl4qkZiRUXzgteH1Nmd9PX+6f5JR/MUEZCdzLkaD72AoKEFZT0P5kjBVPFU9S8HIOL
         Gta3quclCFnAC514v9LDhEw/B9tk8Xwjg6f8PzL7PwDihPZ5Ewms/ipmY7yIfDab2cz3
         fHJOrgw2vrOgokrOqrjo+zOOB/aMJPpQjP7KCtuEsHvzSA3L3ClrIMBitDfWxP9Tp8fh
         RlcC/IYjcM5rO+mxC3WHLGhDKrjFBOVcCwKit1ayKiAhNZdRWb8JyJzUpLNKYRFI0Kqu
         0TOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766542482; x=1767147282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mn5gdOJNVLCgqxTAZaOj5KghlS4vIZEHYcNf0bwJm28=;
        b=VEJZCUNoLSsHKiojHa4APPUgd7+okbEd0yjSNXXRDfqrs5274mjZaOWUeaFzRMpQ22
         f25+BEWFyDYeFTFdPvcJQq+nhlcUmymwR8hwNQV1HpAkfGS3AUz0yGGOkx147+njC+iJ
         /ShkYBxc+34SKkMnqpq+n1ouMydtnYOphvV6FISUC4rbwhNyUONx7TmLW3K3QfP9I4ea
         Aw9MwgNhXzMEiuQ4Uh2jjGYLp0p5fLZYjKiDtM/aSq21xrFWvKG60byP6hpxIB7gAtAM
         tfAq6WfLbN0Kcq8XiHwCiRz4HBykNMPsgbf8iVWb0Ucm+m3UadLL1IquntRhEbklLFNG
         3GkA==
X-Forwarded-Encrypted: i=1; AJvYcCVBxaozoDb6Qgte3K7NNWEWk1tyZtmXuSpVDJR4IYE0btPnNmBqnrhhnmvoGUUQZ2BllrshmSpSvS7dji3i5A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxnMUDbO+d3+7QnP246oHJbOaSN2epM+rM+KKjNefpxS5bmMSGi
	rmdgUvOsW7WzF1QQKs0YJf3AGEM/WwdiTLgZorzfSKlA/DU57b/g5ZEwkkegUQ==
X-Gm-Gg: AY/fxX7UDWg9KJGZpzlICH7MG1kXpZTyauMZqFkpdrd7WbA2cnBe/dXCdMVNgdnCcbB
	HCWCSfS7fFSxScVka9aF3+N+Yj28zK0w+ZFgv+thA3iM3kvqOZ2RIcdSrSO2+fD+A2Ba2hKo67/
	QgGn7QIbm8qf6Anc+EVRpb4yTPy+VYZBtZl2A94by1Tg6hXXnlNeoBOPE3bW0lKTsgle+L6PAST
	fX71TH/I87ks0Fjlpe63XpiQkGNVIIdlUjtIsqLMFSmcdSwNAO1tsuDXAxAWhaVnYnSFSS0cYAw
	OSjzDo+FYmu/XZi8Jxu3prAz4x1XW3jfRCZS+0ghJkg1j9JpsnRpY/KF3WTapu5tHmerTa6G7Ik
	mbamK0YpJnVVMaDPu3NOfgiJ675x9rLjDyU3R9pqJxuC0C9lFREjc0FXxyIIFd6TK7bRsDboq2W
	HH8NCfIt28z+z3rqVwh52HE/fVPvk36hr0swVdPKpImX3AWwI=
X-Google-Smtp-Source: AGHT+IGl4lY3C5uaIhAdAeU51l9QnKvRP/mJp5bbTNMXCgmCDrIGHmPARt/rlh3H/cQnB4TIEc9mUg==
X-Received: by 2002:a05:690c:d96:b0:78f:aa6d:48cd with SMTP id 00721157ae682-78fb3d52b45mr134838347b3.0.1766536355576;
        Tue, 23 Dec 2025 16:32:35 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:5f::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb4378372sm59887097b3.12.2025.12.23.16.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 16:32:35 -0800 (PST)
Date: Tue, 23 Dec 2025 16:32:30 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>,
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
Message-ID: <aUs0no+ni8/R8/1N@devvm11784.nha0.facebook.com>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
 <20251126-vsock-vmtest-v12-4-257ee21cd5de@meta.com>
 <6cef5a68-375a-4bb6-84f8-fccc00cf7162@redhat.com>
 <aS8oMqafpJxkRKW5@devvm11784.nha0.facebook.com>
 <06b7cfea-d366-44f7-943e-087ead2f25c2@redhat.com>
 <aS9hoOKb7yA5Qgod@devvm11784.nha0.facebook.com>
 <aTw0F6lufR/nT7OY@devvm11784.nha0.facebook.com>
 <uidarlot7opjsuozylevyrlgdpjd32tsi7mwll2lsvce226v24@75sq4jdo5tgv>
 <aUC0Op2trtt3z405@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUC0Op2trtt3z405@devvm11784.nha0.facebook.com>

On Mon, Dec 15, 2025 at 05:22:02PM -0800, Bobby Eshleman wrote:
> On Mon, Dec 15, 2025 at 03:11:22PM +0100, Stefano Garzarella wrote:
> > On Fri, Dec 12, 2025 at 07:26:15AM -0800, Bobby Eshleman wrote:
> > > On Tue, Dec 02, 2025 at 02:01:04PM -0800, Bobby Eshleman wrote:
> > > > On Tue, Dec 02, 2025 at 09:47:19PM +0100, Paolo Abeni wrote:
> > > > > On 12/2/25 6:56 PM, Bobby Eshleman wrote:
> > > > > > On Tue, Dec 02, 2025 at 11:18:14AM +0100, Paolo Abeni wrote:
> > > > > >> On 11/27/25 8:47 AM, Bobby Eshleman wrote:
> > > > > >>> @@ -674,6 +689,17 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
> > > > > >>>  		goto out;
> > > > > >>>  	}
> > > > > >>>
> > > > > >>> +	net = current->nsproxy->net_ns;
> > > > > >>> +	vsock->net = get_net_track(net, &vsock->ns_tracker, GFP_KERNEL);
> > > > > >>> +
> > > > > >>> +	/* Store the mode of the namespace at the time of creation. If this
> > > > > >>> +	 * namespace later changes from "global" to "local", we want this vsock
> > > > > >>> +	 * to continue operating normally and not suddenly break. For that
> > > > > >>> +	 * reason, we save the mode here and later use it when performing
> > > > > >>> +	 * socket lookups with vsock_net_check_mode() (see vhost_vsock_get()).
> > > > > >>> +	 */
> > > > > >>> +	vsock->net_mode = vsock_net_mode(net);
> > > > > >>
> > > > > >> I'm sorry for the very late feedback. I think that at very least the
> > > > > >> user-space needs a way to query if the given transport is in local or
> > > > > >> global mode, as AFAICS there is no way to tell that when socket creation
> > > > > >> races with mode change.
> > > > > >
> > > > > > Are you thinking something along the lines of sockopt?
> > > > >
> > > > > I'd like to see a way for the user-space to query the socket 'namespace
> > > > > mode'.
> > > > >
> > > > > sockopt could be an option; a possibly better one could be sock_diag. Or
> > > > > you could do both using dumping the info with a shared helper invoked by
> > > > > both code paths, alike what TCP is doing.
> > > > > >> Also I'm a bit uneasy with the model implemented here, as 'local' socket
> > > > > >> may cross netns boundaris and connect to 'local' socket in other netns
> > > > > >> (if I read correctly patch 2/12). That in turns AFAICS break the netns
> > > > > >> isolation.
> > > > > >
> > > > > > Local mode sockets are unable to communicate with local mode (and global
> > > > > > mode too) sockets that are in other namespaces. The key piece of code
> > > > > > for that is vsock_net_check_mode(), where if either modes is local the
> > > > > > namespaces must be the same.
> > > > >
> > > > > Sorry, I likely misread the large comment in patch 2:
> > > > >
> > > > > https://lore.kernel.org/netdev/20251126-vsock-vmtest-v12-2-257ee21cd5de@meta.com/
> > > > >
> > > > > >> Have you considered instead a slightly different model, where the
> > > > > >> local/global model is set in stone at netns creation time - alike what
> > > > > >> /proc/sys/net/ipv4/tcp_child_ehash_entries is doing[1] - and
> > > > > >> inter-netns connectivity is explicitly granted by the admin (I guess
> > > > > >> you will need new transport operations for that)?
> > > > > >>
> > > > > >> /P
> > > > > >>
> > > > > >> [1] tcp allows using per-netns established socket lookup tables - as
> > > > > >> opposed to the default global lookup table (even if match always takes
> > > > > >> in account the netns obviously). The mentioned sysctl specify such
> > > > > >> configuration for the children namespaces, if any.
> > > > > >
> > > > > > I'll save this discussion if the above doesn't resolve your concerns.
> > > > > I still have some concern WRT the dynamic mode change after netns
> > > > > creation. I fear some 'unsolvable' (or very hard to solve) race I can't
> > > > > see now. A tcp_child_ehash_entries-like model will avoid completely the
> > > > > issue, but I understand it would be a significant change over the
> > > > > current status.
> > > > >
> > > > > "Luckily" the merge window is on us and we have some time to discuss. Do
> > > > > you have a specific use-case for the ability to change the netns >
> > > > mode
> > > > > after creation?
> > > > >
> > > > > /P
> > > > 
> > > > I don't think there is a hard requirement that the mode be change-able
> > > > after creation. Though I'd love to avoid such a big change... or at
> > > > least leave unchanged as much of what we've already reviewed as
> > > > possible.
> > > > 
> > > > In the scheme of defining the mode at creation and following the
> > > > tcp_child_ehash_entries-ish model, what I'm imagining is:
> > > > - /proc/sys/net/vsock/child_ns_mode can be set to "local" or "global"
> > > > - /proc/sys/net/vsock/child_ns_mode is not immutable, can change any
> > > >   number of times
> > > > 
> > > > - when a netns is created, the new netns mode is inherited from
> > > >   child_ns_mode, being assigned using something like:
> > > > 
> > > > 	  net->vsock.ns_mode =
> > > > 		get_net_ns_by_pid(current->pid)->child_ns_mode
> > > > 
> > > > - /proc/sys/net/vsock/ns_mode queries the current mode, returning
> > > >   "local" or "global", returning value of net->vsock.ns_mode
> > > > - /proc/sys/net/vsock/ns_mode and net->vsock.ns_mode are immutable and
> > > >   reject writes
> > > > 
> > > > Does that align with what you have in mind?
> > > 
> > > Hey Paolo, I just wanted to sync up on this one. Does the above align
> > > with what you envision?
> > 
> > Hi Bobby, AFAIK Paolo was at LPC, so there could be some delay.
> > 
> > FYI I'll be off from Dec 25 to Jan 6, so if we want to do an RFC in the
> > middle, I'll do my best to take a look before my time off.
> > 
> > Thanks,
> > Stefano

Just sent this out, though I acknowledge its pretty last minute WRT
your time off.

If I don't hear from you before then, have a good holiday!

Best,
Bobby
