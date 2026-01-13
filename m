Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30B3163
	for <virtualization@lists.linux.dev>; Tue, 13 Jan 2026 22:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768343775; cv=none; b=h5TCTVcYs+FCbr9Dwk9uKnZ4+nGqlBmDAj2zkFGfoWTiir3OyFP+jMtHPXAod1KhTVvD088cZff/D3S0mh9eP9XvFS/4489KX3Wv1J/bZ5TZAmXCEezJU27tR4P8aYDozP0pokNS3pb9k22nVq11rQiBNyfWwR5Efk0JrIaNiag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768343775; c=relaxed/simple;
	bh=h+UznknjOhsgpxn2WvyaKZdy+E01z3xst2FqiSOZMS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9eLPuyr36raoL3mfNSBesySUko7lUvk4YCDLnqoBWgdoNFhQbQheRVVMc3sxG0Rj3e6pcxxvxIoRf2qcEeGrgBsnTRmugGVBQLNwlJMpGC3WXSkmW4e+/p6D7Wtw1ERPCpYOfopF6TcvDHT16RqFExfKYpS8nzvlnti7O/6SGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9hoXWIo; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9hoXWIo"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4f822b2df7aso108369341cf.2
        for <virtualization@lists.linux.dev>; Tue, 13 Jan 2026 14:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768343772; x=1768948572; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QzIlW73SYpRCgsFT6C0OFykRPA/kKAr4bQkErotYYOY=;
        b=F9hoXWIoXZ323vwduUH7FzQIGkiCZwb9/D7pisnFviaYFI7a/qHlo+NJSm0dfahVMZ
         9NkoV+z++y4lLjdqxtOw00T5nPsxzLTrA87EzSC/c/0brU1OLW2VDjbk5Md6w1g1tCbr
         fkYJDuLyLdn7OtveHTawhQOjVXZ8cNYYD/ZNb0o6apXfA8DqY0+rSw4p4i9RbMdHL1/A
         qoJf3Axu2g5CzOO9hcLimcWPDqqN8UpCvFCU8ImpuiCpvei60dkbaSexk/mAKcjfB3P4
         j/iloGNWJH9+BoKD4+Pxp1/UiPKQYQTAdeV+CUwHmDdWupShu5h2CX0zq83geF7JJaCA
         aoNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768343772; x=1768948572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QzIlW73SYpRCgsFT6C0OFykRPA/kKAr4bQkErotYYOY=;
        b=tPwn4V0WVSNtESOViVMWZoW4bWF9jW5YbIUtHVugHad+w3miUVU7XTuqPSNR0tsxHU
         J80gu7CKftq5pXN3l50I707Sro2dg5UfZ5XqrhwjJqLJueRi6GPDWJDN7Us3zekJ1kAw
         pBwE5cFexEx6K/lGCGLA2AFIlkwCwkL027+5xSZPJjWovXZbZGIsocLf8JDBhxO2GYbe
         IjgSUDDFTWczvcPfd6clG7EPvalbi5R09PpMm5UZ9nQ/8DvTd2X6ig4rasOJZg3sY+qx
         ZyvMrGNuQUT8vKALIhjpn0y4uA6OyGzzKURWwHxLhahJIKY3o6FYk+F4aaiT5DDZW/jA
         qezQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/U0vmTolWbn/6iq11IhM4zNAX+nVHsnv6j1ahflc3Z5v6etJ1kncnBdGXr/ZNKcCC/Jay0vQc4XylQDi2VQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5FD73DK2wEY2BM72xlkPo7DVK9BvMUEnL0FNQAVfUW8b226Vx
	dhAllz5N277E6a4XNdCtLvcuoyi5he9NN5UfgFO8jeiM9tEr+CVYBNBjEdRYYQ==
X-Gm-Gg: AY/fxX7WFgUv9BMHBOY/XLTnnb9s0qVNC9oN1chO4bVmYhz/YBWZyKHUiS/kB5TwF93
	tRBoDXzuh1cLOC/lGiKSQ5ArwUD4nmOGU6ms7kbolu7S1qiRl297CFkhhkbiOkkTc3NWkXXAba5
	xHywYOIQllckSoQQWWC39aUlFTbW4g6WCxJFuGOABf3aG181c0a2t7EeqDQkUM4SGPB/ikBVtMW
	fT9QHYrSo9//oIyvXAxNVxZYhKJ0kaqLGomxOaApev1GnJ2Bvty3Fa3AHoedCTlQlfcmRRYkEig
	xWBtz1+iQlbGbIFaRBq28iyg8azLUJpR9ZznzABXuDgoimikj5y7DHIBnTm46vDfEW94/fYIsXP
	PHaSyDscCkJmhGF7eAOtuma9atnRNmGjq1K9RJVMLIo6euVvlESKTytKi1Qse3T4bIuLcAnJAu/
	Qbvl40A97I8dUEuhwXDY2JgN28cg/1j0YTVcFuzLHB6wBxyg==
X-Received: by 2002:a05:690c:c85:b0:78f:f3e2:35e0 with SMTP id 00721157ae682-793a1d4bad1mr1649307b3.42.1768336120080;
        Tue, 13 Jan 2026 12:28:40 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:4a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790b1be88dcsm77661627b3.47.2026.01.13.12.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 12:28:39 -0800 (PST)
Date: Tue, 13 Jan 2026 12:28:38 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org,
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v14 01/12] vsock: add netns to vsock core
Message-ID: <aWaq9vbBJGqg9+DU@devvm11784.nha0.facebook.com>
References: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
 <20260112-vsock-vmtest-v14-1-a5c332db3e2b@meta.com>
 <20260113024503-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113024503-mutt-send-email-mst@kernel.org>

On Tue, Jan 13, 2026 at 02:45:32AM -0500, Michael S. Tsirkin wrote:
> On Mon, Jan 12, 2026 at 07:11:10PM -0800, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Add netns logic to vsock core. Additionally, modify transport hook
> > prototypes to be used by later transport-specific patches (e.g.,
> > *_seqpacket_allow()).
> > 
> > Namespaces are supported primarily by changing socket lookup functions
> > (e.g., vsock_find_connected_socket()) to take into account the socket
> > namespace and the namespace mode before considering a candidate socket a
> > "match".
> > 
> > This patch also introduces the sysctl /proc/sys/net/vsock/ns_mode to
> > report the mode and /proc/sys/net/vsock/child_ns_mode to set the mode
> > for new namespaces.
> > 
> > Add netns functionality (initialization, passing to transports, procfs,
> > etc...) to the af_vsock socket layer. Later patches that add netns
> > support to transports depend on this patch.
> > 
> > dgram_allow(), stream_allow(), and seqpacket_allow() callbacks are
> > modified to take a vsk in order to perform logic on namespace modes. In
> > future patches, the net will also be used for socket
> > lookups in these functions.
> > 
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> > Changes in v14:
> > - include linux/sysctl.h in af_vsock.c
> > - squash patch 'vsock: add per-net vsock NS mode state' into this patch
> >   (prior version can be found here):
> >   https://lore.kernel.org/all/20251223-vsock-vmtest-v13-1-9d6db8e7c80b@meta.com/)
> 
> So, about the static port, are you going to address it in
> the next version then?

Yes, just wanted to get the rebase out to unblock review of the
child_ns_mode changes.

I should have mentioned the static port was a known issue and still
under discussion.

- Bobby
