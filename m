Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F32B4BD79E
	for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 17:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494215; cv=none; b=a5lndQzgLCLRz6ZdevOxLstTz1Fjx7j2/0HsguYu1ecW+GFPwxMXMZuHmdqPsO6KIqJ6qd65rCtvUyHI+oBYeZHzn2GYxP31bIZHtuK+XqPADdesXr91FLC4IZvByftytKQvl65qVRVCJsdlyFiwf8EYBollsyU8uPlxeTcUw2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494215; c=relaxed/simple;
	bh=2Qb0/zNGbWdfLqIl2/hEdN2XdIGVrGsupUwvjhaalpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKZnvZopXuVL8nykTcIO/NnOs1kvLh4B5a5X8ALdEys3OXunxRYyuIpadwPI7Ivhyv9/9C8kAHLjDgUKx1II6L+xRb2UOxxJODjdXm886GM2b/z9Dn5JU55x5XeREXzZ8AOrysxddcKLLEdoch9I9hUSghrRW/stifowuiuQLGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTADjcoP; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTADjcoP"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7f4df360cc9so1060724a34.1
        for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 10:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789494208; x=1790099008; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UT4ouAJLFU2Y0pobOZCiwGU7eYX5lu0wzqAZh/2lqXU=;
        b=FTADjcoPKpAbnJmSI48oASkX4jbmoDyKVJgibfc2Xm+bw1Mfc2dlAVMMWEPau4t8zG
         TLjT5fW+hoLNMz+tlmdObiJ6fJZq3QthDxXCZ2TIvSqgUfkXVD2yp7WuzeB7SmYZ5grP
         HJ+Gdbhm5bO2qYpoceVAy6fDsIc6Eo9y/0hckAGibwwJFTWp6esMW5A4eh9/wdS2B5RB
         eSyJYN9N9aRLZjmxHGu25TqPZJdDd3EbpvPa+KMQAqX4uJyometkZBT1Qvn/DJw0MVJl
         OV1PE2PM9ovbviDdANLBOTPZj08ewhL4Eg3pVg9IhsPF5C2KR32KZc08oDDwc+FBDXEV
         LtlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789494208; x=1790099008;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UT4ouAJLFU2Y0pobOZCiwGU7eYX5lu0wzqAZh/2lqXU=;
        b=xUfNs2A+wa+VjC1MwktJe5aLemq9HKWBNEl0ttpeKHWFrnEZjoQP3qvFPejBN8VDKq
         xYJPkzPCdSqB9RsSqqVliZV/XbmzaBzg9LoYSlvZu5DFYj1siqJH+yl2MHRxNwCFKU3e
         c2Wix88KoBxl70b7HfpR068z3+h10kC78UPmTQHdl14ScHIww818d0cTNmgO6jd4G3am
         gdMJH/ULjt4F3Nlri5JpPVlt4wynxfn1LNcyoTAgF83wCAwbJ7nipKDUeYeLKu6CL32f
         Vly9xQhFV2yTnH+oIYImc12zJZzC7hnXo3jZpZmVpT02Msa4XB5M1ULPtjSJUa/ITUGK
         2Krw==
X-Forwarded-Encrypted: i=1; AKwUvBzhH9/PdMfHmYLGjFr4vibpTrEKZFX5iP+wimLB3g9IJlWth5aIOBoOsdiRaEHyTnz2im9JK7vLH1orl9jSgA==@lists.linux.dev
X-Gm-Message-State: AFuF++nsHLy+E60+UtvHS6Z5fg0vTZ6mp0EOOZNvILeoAbwLw1Wllz9B
	k+00cMbBfE3gUbOVpVDZtGr+nZb2EkLskPWIoLzhenfgo53JoT6tzlrs
X-Gm-Gg: AYBFou0U0q95GM14q7eMYrWMwmAmyNLDYiWwEQ7uGeg35IG0D6mitEF0yj/xx1SdOIf
	Lv6mbSyQ3hj68ZspiGJEJ1y9K0Ol0pU36gIGYEJgQiQTRvYX9JMKeT+RR1VsK0d8CxlDEd3c+Xp
	w0a6ERGwmJFdNb27gYVsVVaZnWWcyq95N1ko1DPaX9pfasp22aBYIB97kzvu0befln1sCMxI7h1
	jI77026t+3lgAGrLz0OXHAXJpg/d4Vh7DiQG133kc7RPWYKWkQyO/q6X/DFE9WkDmFSNVDysH+G
	aC0Uf+7mO2ETtELxkdo7p8iuTTjGSaLuo/1hn8E8TJvFNtZq9aZnTWmtTbBlmsUsWB3VAw5tTRL
	v4fjccGCRaR8RUJsDY4HaR5mCHQTG2HjSetJgXHdVGS0TSyxfN/CB+D4QRyDRUSCnqFJ0JwXXfL
	8ggezwiAkKgKQOc5bmmRCSy/1wLuJ2O5sRIQRltQsPCIGweHfKRLyXqlhG7L4Pwq9b747u7t66T
	wbEiLLb67bE4WljOI6j
X-Received: by 2002:a9d:7d8d:0:b0:804:36ec:d875 with SMTP id 46e09a7af769-809823dcba1mr2371764a34.4.1789494207629;
        Tue, 15 Sep 2026 10:43:27 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:50::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-80505548bbfsm12975740a34.18.2026.09.15.10.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 10:43:27 -0700 (PDT)
Date: Tue, 15 Sep 2026 10:43:23 -0700
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
Message-ID: <aqmDuxMuEN5lS/0J@devvm29614.prn0.facebook.com>
References: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
 <apqGcFDFm9_Wtw4q@sgarzare-redhat>
 <apsANK7ySuRzzK0V@devvm29614.prn0.facebook.com>
 <aqkaTXHDf5nfPL9w@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqkaTXHDf5nfPL9w@sgarzare-redhat>

On Tue, Sep 15, 2026 at 12:16:47PM +0200, Stefano Garzarella wrote:
> On Fri, Sep 04, 2026 at 10:30:28AM -0700, Bobby Eshleman wrote:
> > On Fri, Sep 04, 2026 at 10:55:17AM +0200, Stefano Garzarella wrote:
> > > On Wed, Sep 02, 2026 at 04:00:46PM -0700, Bobby Eshleman wrote:
> > > > vsock network namespaces let a host put each VM in a namespace of its
> > > > own. A guest has no equivalent yet. It has a single G2H device that
> > > > cannot be assigned to a network namespace.
> > > 
> > > Thanks for this, I'll do a proper review next week, in the mean time some
> > > comments below:
> > > 
> > > >
> > > > This series lets a guest move that device into a network namespace. A
> > > > new ioctl on /dev/vsock, IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS, assigns the
> > > > device to the namespace of the calling process. The namespace's existing
> > > 
> > > Why an ioctl?
> > > 
> > > I'm asking because I'd like to know if you've already considered any
> > > alternatives (sysfs, netlink, etc.)
> > > 
> > > How do you think the ioctl should be used? Should we provide an userspace
> > > tool, or extending some existing tools?
> > > 
> > > Thanks,
> > > Stefano
> > 
> > Really only because /dev/vsock exists and the prior series used it.
> 
> Yeah, I vaguely remember that we may have discussed switching to netlink in
> that thread, but I can't find it.
> 
> > 
> > Considering netlink, it might be the better option because there is a
> > lot of prior art solving problems we might have in the future. For
> > example, I was thinking about when users suddenly lose access to vsock,
> > with just the current assign ioctl there is no way for apps or users to
> > figure out why this happened. We can have an ioctl() setter for user,
> > but in netdev world users can actually get a notification via netlink as
> > to which namespace the device went to and what its ifindex is there (see
> > __dev_change_net_namespace() for the RTM_DELLINK and RTM_NEWLINK
> > messages). There is probably more, but that's the case that comes to
> > mind.
> 
> netlink seems like the right way to go, do you think it'll be a real pain to
> implement?

It is really not bad... it'll include a yaml spec in
Documentation/netlink/specs/ of call names and perms, a new target for
generated code in the Makefile, a handler, and then
tools/net/ynl/ynl-regen.sh generates the plumbing.

> 
> > 
> > > 
> > > > ns_mode then decides who may use it: a "global" namespace shares the
> > > > device with every other global namespace, and a "local" namespace keeps
> > > > the host connection to itself. The device starts out in the initial
> > > > namespace, so until the ioctl is issued nothing has moved and no mode
> > > > has changed. There is no explicit unassign as assigning the device back
> > > > to the initial namespace is equivalent.
> > > >
> > > > The ioctl requires CAP_NET_ADMIN in the initial user namespace.
> > > >
> > > > Connections that can no longer reach the device after a move are reset,
> > > > so that a namespace which has lost access cannot keep using a socket it
> > > > opened while it still had access. Following netdevs, the device returns
> > > > to the initial namespace when the namespace it was moved to is deleted.
> > > >
> > > > Transports opt in through a new netns_assign_allow callback. Only
> > > > virtio-vsock implements it here.
> > > 
> > > Why? (Not asking to support all the others, asking to explain the reason or
> > > ask helps from others to extend it)
> > > 
> > > Thanks,
> > > Stefano
> > 
> > Sure, can add a note here about extending it. I just didn't want to
> > implement code without having an environment allowing me to test it.
> 
> It's fine, I'm not asking you to do it ;-)
> 
> Sorry again for the delay, I hope to review this series today/tomorrow.
> 
> Thanks,
> Stefano
> 

No rush!

Thanks,
Bobby
