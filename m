Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1373DEFE2
	for <virtualization@lists.linux.dev>; Fri, 18 Sep 2026 14:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789741680; cv=none; b=tm825G0dZeDuwYV15O+AABQ6O7PWAQN8IhOai/eiima5Vh6pdEW/Rgw5Y5f0Jfb21/RA5YYQeanuDbSigGjR8SB7GvihFw1qPVitZbzfvO8zlMwmTJL03vPy5otwSaoUe5g1a4xQ3DFcSv2pmIW4dnQyRL2iC+9sRaulOhpxHHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789741680; c=relaxed/simple;
	bh=qWPM8mEcQAiZiBe5wIuy4aqUTDeswnrEyUyg1zkQHi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MnXTn8aYXLLX5SocVvIb3k24zBChouhcvhScXgxmcFzbivbRblvc4EDwy+0Z50T5gPtpp/qtBGeW2iR6DMMX/kLnuzs66H++skve659Do8vRP8CGnzqb8DKN6yl9iqXC8HKOAWsuM64L/Z/AkSrUSDZeNH0Hc6DK20w/O9cpo3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YkYrkVSK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YkYrkVSK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789741676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tzy4rg64m2nfrHznucdcUVmAGxkvGHwxFBaPQdjr128=;
	b=YkYrkVSK+1em0CaBrSnAFiTUIwgfaX3bMTKCTXJ5nOl38OrSUaOSEAZQPg1DHtEzFTbno2
	RHcaR1Dg03346Knt8dNZFn5gT3yfwsNcXNzn1OIYcsLyEU6HwIVI26xpf/k3P0K7ek/JPL
	m8tCLbaP8J5nJlxDYWs4JxaLd9iddKM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-RYn2H8OlN_WDzx0HO3ZQtg-1; Fri, 18 Sep 2026 10:27:54 -0400
X-MC-Unique: RYn2H8OlN_WDzx0HO3ZQtg-1
X-Mimecast-MFC-AGG-ID: RYn2H8OlN_WDzx0HO3ZQtg_1789741674
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-486f3c0d896so467438f8f.3
        for <virtualization@lists.linux.dev>; Fri, 18 Sep 2026 07:27:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789741673; x=1790346473;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tzy4rg64m2nfrHznucdcUVmAGxkvGHwxFBaPQdjr128=;
        b=hzgbTLoX/6dQHk0AUaK/XTHMAWgqsTBLmN5Vke7mVOiGJg0EPH7Gutd/cLpxOMP51E
         F2JadjVDXfJ5cflJc8Lc65im0KQiECpTnSYbBtf2czrKVTIuB+Pk2N1HPW7mnkMdtmeS
         KRcO8bvy2wMzFYweMWepNqu6saYsN0V25fqdJ0UwGf18yvF8UMiUv9FCtjFvezJh/rWO
         WkX4ZJiW/Ml6UOfBW30fXmTKIZT0FBbDwvmIGUAMvByFPkoYHzTKbarTePVti+UWTuvb
         jcZ8IFheM4Egd+7LaumwoV5MHgFxt006DeUBo4P+ppG0Cdp9naeMCWPIFrN/o1GOLSzu
         kgpQ==
X-Forwarded-Encrypted: i=1; AKwUvBzezxblSy6G71sd0gPlxxJ1rN0CARDrvY6BfEjpR8ZD2ePwoLw1zcJRqRKcz1jiXyJOMNMGyNlV3xumemnXeA==@lists.linux.dev
X-Gm-Message-State: AFuF++ngghGZ3nstDW5z9K08qPLDnoINY0j+sARF4IMoVLYdze+qGNP5
	b4bATWB6CSiNcTQLOSzAxO94AYs3eGqtyl4bzb2OOpAoYyq9vniHwqR4d7f6MugnluJ6CcZ+QFO
	CeL++L2jEYRVBq6K96dh5FAzFI6v7x2jpr2dUppOi4zDK57u8dgAuAvA00vyDpHn+ly64
X-Gm-Gg: AYBFou2AROHF6U1y8vrD9zHFI5JXZZOB0XFIVJICv9fSXLJ4Jv9iyOS4PrhVKDqeyCD
	/uVT2e0fDj/wK3fRu5V+1tRDCg1NVAWkdVDE2ShEQ9MP1gcw8OTYILasrhdUHAFjs6htJqJ2slO
	jqrdVmlzg/264WGKpeyq22zGcTVAnwh/UrIs0RGDMBzPKqaXSZoVjGbpHdB6dvYclXVzIjCBotw
	lVYvuM6UygqO6bY16azfyWz0plrvN8W5vLW3eZ0mOZ9MbG67WmfZ18+6dwI65DltypgsUjXYJS5
	WpXYx/TECjkt8RB14/xwDFnj7FuaWCpLxQXRSquLaDQ/veg6qJgvJdVsA94tIY+e5VnbvFI6Z/j
	/y6G3SR3S+jWSSn1Bd1cyX53eHDrWRLNW4zJHgK1pNdhAYw==
X-Received: by 2002:a05:600d:4449:10b0:49f:cc2a:f73a with SMTP id 5b1f17b1804b1-49fcc2af743mr10053605e9.25.1789741673564;
        Fri, 18 Sep 2026 07:27:53 -0700 (PDT)
X-Received: by 2002:a05:600d:4449:10b0:49f:cc2a:f73a with SMTP id 5b1f17b1804b1-49fcc2af743mr10053175e9.25.1789741672904;
        Fri, 18 Sep 2026 07:27:52 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48720081426sm4196721f8f.33.2026.09.18.07.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 07:27:52 -0700 (PDT)
Date: Fri, 18 Sep 2026 16:27:46 +0200
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
Subject: Re: [PATCH net-next 2/6] vsock: add IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS
Message-ID: <aq1D1S9p9vRl7eV_@sgarzare-redhat>
References: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
 <20260902-vsock-guest-ns-v1-2-9995383e9a8b@meta.com>
 <aqlTlFvQL34-WViB@sgarzare-redhat>
 <aqmTYoCMmzx1BM1v@devvm29614.prn0.facebook.com>
 <aqqPXr2LNJUM4yMW@sgarzare-redhat>
 <aqsI5BXRB96dkIHm@devvm29614.prn0.facebook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aqsI5BXRB96dkIHm@devvm29614.prn0.facebook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EcSx1-uUhU4X9gatkIom5lKs1qWjYx5kQy7LjYbZWCk_1789741674
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Sep 16, 2026 at 02:23:48PM -0700, Bobby Eshleman wrote:
>On Wed, Sep 16, 2026 at 02:57:43PM +0200, Stefano Garzarella wrote:
>> On Tue, Sep 15, 2026 at 11:50:10AM -0700, Bobby Eshleman wrote:
>> > On Tue, Sep 15, 2026 at 05:28:25PM +0200, Stefano Garzarella wrote:
>> > > On Wed, Sep 02, 2026 at 04:00:48PM -0700, Bobby Eshleman wrote:
>> > > > From: Bobby Eshleman <bobbyeshleman@meta.com>
>> > > >
>> > > > Namespaces let a host isolate a VM's vsock traffic to a specific
>> > > > namespace, but in a guest vsock traffic cannot be isolated to a
>> > > > namespace. The vsock device is hardcoded to global mode and can't be
>> > > > moved into a local-mode namespace.
>> > > >
>> > > > Introduce ioctl IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS on /dev/vsock that
>> > >
>> > > We already discussed about netlink, but I'm not sure how much work can
>> > > take, here just another alternative, what about adding
>> > > /proc/sys/net/vsock/g2h_owner sysctl that can be read/write where:
>> > > 0 - no owner
>> > > 1 - owner
>> > >
>> > > 0 -> 1 transition, move the device in the new nets
>> > > 1 -> 0 transition, reset back to init_ns
>> >
>> > That seems reasonable, but if multi-device support ever lands, this
>> > might be harder to adapt cleanly?
>>
>> I see, but maybe we can have a dev0/ dev1/ subfolders in that case.
>>
>> >
>> > >
>> > > > gives userspace a way to move the device to the calling pid's namespace.
>> > > > The call requires CAP_NET_ADMIN in the root user namespace. A privileged
>> > > > user wishing to "unassign" the device can move it to the init_netns,
>> > > > which is hardcoded to global mode (so no unassign call is necessary).
>> > > >
>> > > > A getter to read the current assignment back was considered, returning
>> > > > either the namespace's net_cookie or its nsfs inode number, but neither
>> > > > seemed useful enough to bake into the uAPI now. It can be added later if
>> > > > a user turns up that needs it.
>> > > >
>> > > > Add a transport hook to indicate support for guest namespacing, so that
>> > > > transports may opt in/out. A transport that opts out keeps the
>> > > > reachability rules it had before this ioctl existed.
>> > > >
>> > > > Sockets are reset when the underlying device moves to a different
>> > > > namespace, so as to prevent reachability from the previous and now
>> > > > disallowed namespace.
>> > > >
>> > > > Following the approach of netdevs, the device returns to init_net when
>> > > > its namespace is removed. Care is taken to not break flows when the
>> > > > device is inside a global namespace that is being torn down and alive
>> > > > sockets are in a different global namespace. In this scenario, the
>> > > > device's netns getter pre-emptively falls back to the init_net (always
>> > > > global) so that these flows are not disrupted. If init_netns ever
>> > > > supports local-mode in the future, this logic will have to be changed.
>> > > >
>> > > > Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>> > > > Link: https://lore.kernel.org/all/20200427142518.uwssa6dtasrp3bfc@steredhat/
>> > > > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>> > > > ---
>> > > > Documentation/admin-guide/sysctl/net.rst |  18 +++
>> > > > include/net/af_vsock.h                   |   7 ++
>> > > > include/uapi/linux/vm_sockets.h          |   6 +
>> > > > net/vmw_vsock/af_vsock.c                 | 198 ++++++++++++++++++++++++++++++-
>> > > > 4 files changed, 228 insertions(+), 1 deletion(-)
>> > > >
>>
>> [...]
>>
>> >
>> > One thing I realized when answering your uAPI questions and looking at
>> > the code is that IOCTL_VM_SOCKETS_GET_LOCAL_CID is not namespace aware,
>> > but I think it probably should be? I remember for host ns we strived for
>> > truly strong isolation.
>>
>> Can you elabore a bit more?
>>
>
>I'm wondering if IOCTL_VM_SOCKETS_GET_LOCAL_CID should not reveal the

Okay, I see now, too many IOCTL_VM_SOCKETS involved and I didn't get you 
were referring to the GET_LOCAL_CID xD

>CID of the g2h device if the device has been moved to an inaccessible
>namespace? In this case, fallback to the results of h2g/local and
>through to returning VMADDR_CID_ANY if neither of those transports are
>loaded.

Yeah, I agree. I'm not 100% sure if it's really an issue if we reveal it 
to any workspace, but I also don't see why we should do that. So, yeah, 
if possible we should reveal it only in the namespace assigned to the 
G2H.

>
>I also considered whether or not /dev/vsock should even be visible from
>within an inaccessible namespace in order to not leak even the mere
>presence of the vsock device, but it seems to me that /dev/vsock's
>presence doesn't leak anything besides the presence of the vsock module.
>

Will this break userspace doing IOCTL_VM_SOCKETS_GET_LOCAL_CID on 
loopback, etc. ?

Thanks,
Stefano

