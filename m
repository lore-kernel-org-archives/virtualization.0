Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414734E56CB
	for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 12:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789562181; cv=none; b=qWbJbd27Kc5qB8E9Z7+TP7A7VpGNPd8rPtwv657VQzbNkIiHy5rMNdT30n3xvcs41wJ86Jkneylk7CeF5wk73hJ+9xHbRN8JiAaU7NQhYLqnWShRKCy162nhoZ+Qf0mhqi71Loeiht43bpDnDw5nY5q/zevmCJW2iCUQANVbs5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789562181; c=relaxed/simple;
	bh=j43LFPCZ7rUBOiUq13DB94/P46Wvh+c5n7GJVgSSa8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RTXDYgDI3Ug2JgWWn3YaKcPbIq8IU7hDqMZM6LJDZS26XG81JSN8qsyAl3g19K098alYp/yl5d86huZD0pOw7PBc7YfIRBMYoMfC+U4kQUKOSLP7vqBohewFaLxGd9G3yQwv6XwlkZ14sYGJoN8OW8TPhIcBZY4Usy8KLBrIm+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EvAfabXl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EvAfabXl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789562178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j43LFPCZ7rUBOiUq13DB94/P46Wvh+c5n7GJVgSSa8E=;
	b=EvAfabXl/qEudjdbqezYT4ZZbT77u0m8hnuQmMLdpNQHaETG7Gf72TtaCJm2oJltK3rW76
	wTmq3vka6ru0GrV5Rj0e+aDxLzYi9cqcyqMRcicg115lk0RklPa6koSK+Yuf614XKOYdh3
	2mzl096OoQ6rKQ5RkAlT9dS6KnSlfUE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-m55Y16AIOrKM91J3bK3gHA-1; Wed, 16 Sep 2026 08:36:16 -0400
X-MC-Unique: m55Y16AIOrKM91J3bK3gHA-1
X-Mimecast-MFC-AGG-ID: m55Y16AIOrKM91J3bK3gHA_1789562176
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4994d67d0e3so45142655e9.2
        for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 05:36:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789562175; x=1790166975;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j43LFPCZ7rUBOiUq13DB94/P46Wvh+c5n7GJVgSSa8E=;
        b=ozHvtSHm6CWGZ1757hQF8BnQmLHdVPqVTigseaajfyFOMiMEKgJS8cJq1lgZqxOMcD
         B8uXSCXaTMhKTIrrPL1jLzsJq4cFY1FAkYEt6kigXNyWXNqQr0j033DK9v8p7TmqKVgK
         Mmrt1shlor4ddnfNdTgnRiEhTAOtQf9noVsbvVI7DQXZJ4G57abTRx08GVtzrF1NVHd1
         +djpa/K/Nxn4jXnQwX5jeKVm9PLW7FsTuVCTi9+IQ5OFXCpZL5n4WeQFes2W22icgsmO
         D6bWOx2JQrsnXirWHu7TAReBY0KpHot7CaYGv26gQhrGaGjytsWub9M/aJXYXU2LjkEq
         B46g==
X-Forwarded-Encrypted: i=1; AKwUvBxoK5A3oVF8xLvxVkX1Ho8LfEbfMq64+l44vhCmcpuXoDmmcZWfsMZalwyucrICLCKM5+arlfhQZm50tADzhg==@lists.linux.dev
X-Gm-Message-State: AFuF++mw3xXF10bpxs9IJZ3zPqh/405gmy+VD9iRN58gBAf0U4m8FTFE
	O9vpADEb8R/g0iV6Gn7c2HLhyq97vjyS7uP+kLbbHL6Q/EQ5MyZXD6xCJG1mjg7DHXASnBEuRMc
	0dz8ouRpoQIUMKJNre1wK0hMYFZEqzbJJlxYvf7ZPvJX2IwguLV2jhbK0GXy7NDobCp0r
X-Gm-Gg: AYBFou2IJ7o9PFaU+i9xAnWa8FEiNfQeL/PE7ctqOhnYkU6XVA/YDE+sk/IALAsgr6q
	xs3D9Tc1m708OD21bZxhj/C9EZLsUSdHCL0Anof/XeaKyQvT+hRpCg9QK7Mfjt3BUq+DoibAouw
	5XSoRnuczjFlTtiwZRR9MZyLYDzafZB9Aj8NPXtOZwc3D5eW72N8auGRxSBRSpqYTVlrjsjOL9a
	9TDkqJkd4MizHKjGMVuQvkNrMy6bxFUZer2/ezWuUQ7QcqXfCRsjrP0GCGTVEm0K86KDfzfdC45
	YT27WFDiHcJfO7/xt58lgyySgRtEBhIOZLXAccio62LAWS4fnxiv9n+mBTJbX5QT3cDMwcRi3vQ
	CBQ/c4aFVAkqIDrkn+Gjzhc0l//e1VS8A4CxGUmvt/8B1vQ==
X-Received: by 2002:a05:600c:698e:b0:49c:dada:f57f with SMTP id 5b1f17b1804b1-49eac4638d8mr29033615e9.7.1789562175615;
        Wed, 16 Sep 2026 05:36:15 -0700 (PDT)
X-Received: by 2002:a05:600c:698e:b0:49c:dada:f57f with SMTP id 5b1f17b1804b1-49eac4638d8mr29033135e9.7.1789562175106;
        Wed, 16 Sep 2026 05:36:15 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e83da071asm93775155e9.8.2026.09.16.05.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 05:36:14 -0700 (PDT)
Date: Wed, 16 Sep 2026 14:36:07 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, sargun@sargun.me, jlinbox@meta.com, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 0/6] vsock: assign the guest vsock device to a
 network namespace
Message-ID: <aqqNEl6Hyk_h9C8r@sgarzare-redhat>
References: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
 <apqGcFDFm9_Wtw4q@sgarzare-redhat>
 <apsANK7ySuRzzK0V@devvm29614.prn0.facebook.com>
 <aqkaTXHDf5nfPL9w@sgarzare-redhat>
 <aqmDuxMuEN5lS/0J@devvm29614.prn0.facebook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aqmDuxMuEN5lS/0J@devvm29614.prn0.facebook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YZ21i_jl1zN2G6E_lsCdW2X5jtMF6essgyECDfkYUV8_1789562176
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Sep 15, 2026 at 10:43:23AM -0700, Bobby Eshleman wrote:
>On Tue, Sep 15, 2026 at 12:16:47PM +0200, Stefano Garzarella wrote:
>> On Fri, Sep 04, 2026 at 10:30:28AM -0700, Bobby Eshleman wrote:
>> > On Fri, Sep 04, 2026 at 10:55:17AM +0200, Stefano Garzarella wrote:
>> > > On Wed, Sep 02, 2026 at 04:00:46PM -0700, Bobby Eshleman wrote:
>> > > > vsock network namespaces let a host put each VM in a namespace of its
>> > > > own. A guest has no equivalent yet. It has a single G2H device that
>> > > > cannot be assigned to a network namespace.
>> > >
>> > > Thanks for this, I'll do a proper review next week, in the mean time some
>> > > comments below:
>> > >
>> > > >
>> > > > This series lets a guest move that device into a network namespace. A
>> > > > new ioctl on /dev/vsock, IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS, assigns the
>> > > > device to the namespace of the calling process. The namespace's existing
>> > >
>> > > Why an ioctl?
>> > >
>> > > I'm asking because I'd like to know if you've already considered any
>> > > alternatives (sysfs, netlink, etc.)
>> > >
>> > > How do you think the ioctl should be used? Should we provide an userspace
>> > > tool, or extending some existing tools?
>> > >
>> > > Thanks,
>> > > Stefano
>> >
>> > Really only because /dev/vsock exists and the prior series used it.
>>
>> Yeah, I vaguely remember that we may have discussed switching to netlink in
>> that thread, but I can't find it.
>>
>> >
>> > Considering netlink, it might be the better option because there is a
>> > lot of prior art solving problems we might have in the future. For
>> > example, I was thinking about when users suddenly lose access to vsock,
>> > with just the current assign ioctl there is no way for apps or users to
>> > figure out why this happened. We can have an ioctl() setter for user,
>> > but in netdev world users can actually get a notification via netlink as
>> > to which namespace the device went to and what its ifindex is there (see
>> > __dev_change_net_namespace() for the RTM_DELLINK and RTM_NEWLINK
>> > messages). There is probably more, but that's the case that comes to
>> > mind.
>>
>> netlink seems like the right way to go, do you think it'll be a real pain to
>> implement?
>
>It is really not bad... it'll include a yaml spec in
>Documentation/netlink/specs/ of call names and perms, a new target for
>generated code in the Makefile, a handler, and then
>tools/net/ynl/ynl-regen.sh generates the plumbing.

Ah, nice! So, do you want to try that direction?

Thanks,
Stefano

