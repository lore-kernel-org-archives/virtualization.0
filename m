Received: from mail-oo2-f40.google.com (mail-oo2-f40.google.com [74.125.231.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA4E4BD344
	for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 17:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789578051; cv=none; b=neQvESeyfWiUXV2+Qr77/elPn4qbZY47Q9jNrC5CRX1YwOhWMIvlbXXG9DmFcCjgkzI0TdBfIqLO95XFB4BXVfNNTLXkJcLjjvxpDYNGGIt826/l7PatWdTzP5Xs1Z4K/RtSiE6UM2OGrU8x/kFqPMhgvsD2Lmf/WhtKj6XSQqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789578051; c=relaxed/simple;
	bh=Ky6tqUlPctwf9kmSA68nL3wRxEYqHtONMZuz2rSl+Vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvcUHu1JtIPT7d/lDcIYKsvl89Pk/56tyru5tuw4NnnB1Ei11dYme+TAk706L2X6S0WomlJXse8TdYvL5Mx1y55Tf+oLPBl7crh8CvhY7ouqBxJWNXbbNN9MX0WLPzkM6XLC3BEpEOTt+5pWEoEHJ8g8AWlV5oR6oiU+1qc6k1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3AwPn4S; arc=none smtp.client-ip=74.125.231.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3AwPn4S"
Received: by mail-oo2-f40.google.com with SMTP id 46e09a7af769-805440319deso874021a34.2
        for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 10:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789578026; x=1790182826; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kV5xMCFq0mEVtZsKF5EmMvJNOJj0hLOiv+MHAekOLlU=;
        b=i3AwPn4SZNKO/OSJwnt0Ew5CZXs2TOdIj9UFQ/EpAkUKFt7EG/6zVCjIN8FOTBo6D6
         GaBc/Ty1IWgayG1wp9MljMHLNokOIhgp1qrpD2JxGnOcNEO3GIsQ1Xr76ipeujQoHb9R
         e7vmO174TiC1bHz0FKaDRzFSZUZ1rWv+CFGoAds0IHCxMEHZtpcixgtd2aDYl2UzY3x7
         Am/nkdiWTj1T3MPhNT+Rga7LPQDa1Xau/ZUQ17rpSw9AXk3aCuO63hGeZwCPmRXGR1cP
         gW3Lo5ND00U9b0jUs72i2sgIhCzbb92rk+qC0beM3Vm5UuKj/pOQIBqziaqDUB49Qtks
         5r4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789578026; x=1790182826;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kV5xMCFq0mEVtZsKF5EmMvJNOJj0hLOiv+MHAekOLlU=;
        b=gCuQ3gb4omXU68D2W8jNTROKs32AOmGcjf5EGANEwuB/exXLyYvWEEDfnBJl0FvCFh
         rOwf6/xuMBSg5Urxsa3ea0e1Se2pz5a2ekQuNf1EuwLAAYD9n2m3JkcEq9CwihA4Bd1i
         XkxL9rL2ebFlPCyVzSJBurbaa04Pqli7tuHDeJEhKlBUEhWqldob5Ohu4AA8+g3w0VEP
         bd1fQ64tTcYnLZ6Ayi0NvlyBlQ1LLdB8+SnCZeAuZbqdSLNO0wuZBOtuIOSt7HxgPMY1
         kScm0/134x8l3s5j4B8KFR4Ec6gX5i8j+NC0rxXDtp5ZbF4YyaOKzMCnaje1t82O3czS
         dKTg==
X-Forwarded-Encrypted: i=1; AKwUvBy9b10sPSDUf0gnaXFNvpLMwx7+olVBqWs4gqFYVMg844YEUilKF7hpCEOW5w3OqJePrkCL3xdbjXSfGH0SXA==@lists.linux.dev
X-Gm-Message-State: AFuF++nDY8G74bb/DlDYkS+zCFYAtQfeCbOAp7sQBrPy2789KMQE5e4/
	ie/6Uis1oaigzydmhhnMzp1G3eFpvmTRMx/1zfbT7Ff9sJkwlJ8h8Uwi
X-Gm-Gg: AYBFou22D1gnTcpKaRoYvOmalZzYlaM2PgBtxYIHASXN8G9lPO5qbInBNqZH25FJ25L
	A0St7zKsEHKOtUbfrgS/RarnMP8L4fFQWUxNBY0JOwF2Ppg0zurDE9veYB6BUuS2P5fjqfWzvD1
	tbk2O7c47UdNPJYO3+CLwwn/rOgVRQ1f44ultxfUKgWY8PTwCx9ZtiO+cqk4sCITkhgnz0KK3UK
	rRKEmDM/MfWyPk/suZr5jV8/gmLLpKoz570EyZX9jAGxYmJ667JHHNvHci2n6r/CI0pofQj6SEc
	rklE2KrrBj7b/ee1FBth5x904CjSl66PGb+3zDr5EKR3+0SYDpZa75pganKa8R8YKIBIDs92iQl
	NaP7XZYZO+5N9JlXlSHV549znzEZy3a15qImAxfFFwm9+kDZSGAtY98OVYDdTdg8xUY7DfV10ZN
	yHSYdzjEmobBP3ecZt8EAejm5QbY8zNCEQt7Ra+BYjsidjs9xECU11iMIjwn1a64loCL2mfvPEj
	3mCkoTLVqDWLDM4wsrp
X-Received: by 2002:a05:6830:67d5:b0:7f6:96ad:36a8 with SMTP id 46e09a7af769-80b2d416a86mr4148110a34.8.1789578025959;
        Wed, 16 Sep 2026 10:00:25 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:54::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-80c4619a868sm391941a34.8.2026.09.16.10.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 10:00:24 -0700 (PDT)
Date: Wed, 16 Sep 2026 10:00:21 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	sargun@sargun.me, jlinbox@meta.com,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 0/6] vsock: assign the guest vsock device to a
 network namespace
Message-ID: <aqrLJWnHJ8DxK8cF@devvm29614.prn0.facebook.com>
References: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
 <apqGcFDFm9_Wtw4q@sgarzare-redhat>
 <apsANK7ySuRzzK0V@devvm29614.prn0.facebook.com>
 <aqkaTXHDf5nfPL9w@sgarzare-redhat>
 <aqmDuxMuEN5lS/0J@devvm29614.prn0.facebook.com>
 <aqqNEl6Hyk_h9C8r@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqqNEl6Hyk_h9C8r@sgarzare-redhat>

On Wed, Sep 16, 2026 at 02:36:07PM +0200, Stefano Garzarella wrote:
> On Tue, Sep 15, 2026 at 10:43:23AM -0700, Bobby Eshleman wrote:
> > On Tue, Sep 15, 2026 at 12:16:47PM +0200, Stefano Garzarella wrote:
> > > On Fri, Sep 04, 2026 at 10:30:28AM -0700, Bobby Eshleman wrote:
> > > > On Fri, Sep 04, 2026 at 10:55:17AM +0200, Stefano Garzarella wrote:
> > > > > On Wed, Sep 02, 2026 at 04:00:46PM -0700, Bobby Eshleman wrote:
> > > > > > vsock network namespaces let a host put each VM in a namespace of its
> > > > > > own. A guest has no equivalent yet. It has a single G2H device that
> > > > > > cannot be assigned to a network namespace.
> > > > >
> > > > > Thanks for this, I'll do a proper review next week, in the mean time some
> > > > > comments below:
> > > > >
> > > > > >
> > > > > > This series lets a guest move that device into a network namespace. A
> > > > > > new ioctl on /dev/vsock, IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS, assigns the
> > > > > > device to the namespace of the calling process. The namespace's existing
> > > > >
> > > > > Why an ioctl?
> > > > >
> > > > > I'm asking because I'd like to know if you've already considered any
> > > > > alternatives (sysfs, netlink, etc.)
> > > > >
> > > > > How do you think the ioctl should be used? Should we provide an userspace
> > > > > tool, or extending some existing tools?
> > > > >
> > > > > Thanks,
> > > > > Stefano
> > > >
> > > > Really only because /dev/vsock exists and the prior series used it.
> > > 
> > > Yeah, I vaguely remember that we may have discussed switching to netlink in
> > > that thread, but I can't find it.
> > > 
> > > >
> > > > Considering netlink, it might be the better option because there is a
> > > > lot of prior art solving problems we might have in the future. For
> > > > example, I was thinking about when users suddenly lose access to vsock,
> > > > with just the current assign ioctl there is no way for apps or users to
> > > > figure out why this happened. We can have an ioctl() setter for user,
> > > > but in netdev world users can actually get a notification via netlink as
> > > > to which namespace the device went to and what its ifindex is there (see
> > > > __dev_change_net_namespace() for the RTM_DELLINK and RTM_NEWLINK
> > > > messages). There is probably more, but that's the case that comes to
> > > > mind.
> > > 
> > > netlink seems like the right way to go, do you think it'll be a real pain to
> > > implement?
> > 
> > It is really not bad... it'll include a yaml spec in
> > Documentation/netlink/specs/ of call names and perms, a new target for
> > generated code in the Makefile, a handler, and then
> > tools/net/ynl/ynl-regen.sh generates the plumbing.
> 
> Ah, nice! So, do you want to try that direction?
> 
> Thanks,
> Stefano
> 

Let's give it a go. I have a draft of it for v2 and looks reasonable to
me.

Best,
Bobby
