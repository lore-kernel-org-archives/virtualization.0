Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD17C4477F5;
	Wed,  2 Sep 2026 23:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788392177; cv=none; b=UV/lUaBTXkac9R1GdmEFjZHDqkxko/EfxMeDBehVjk7UA4xAI3nHAKuT32gYZN8/BT5v6XItowUCX3TcSlQdwSF4YoYaEFwvHiDABFeOTOKkEAsLHm0n3IawT6+9o4Q6MsMivd8VlqlMiNDMMcx/tljUtBqlv1fWj6PcbX29dvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788392177; c=relaxed/simple;
	bh=BaZz5hdXuAoThKYTRSZgti1KLF+u5As8vU0EB18bPqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gGWoEgZJhc4OFwIdypVdevTysgoFhCc4ICKThX9BKhL4O4sGiRlYIVcdhlX7Hc/tB5gE/l/oumscTms/qLbbGqURZbXov5b2gSBeQrTTRiclWu3lNmLtVeH+6IA0l7KXg9cKweFOf1bK7mJnfb0c8JyDoIOi/i1Pa6NRFep3dlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qCmtn0LC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qCmtn0LC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=HJL/Se97F9udEecTr0MjR195TiakGwMCC7WkQttGCQs=; b=qCmtn0LCRCh9vuOFvGncoedwl7
	tQtfYZ1gxRYFLtiq68PA4aI4dtPmaYDqfnZhfyCD15jLydsppcUG2Nt6wrwygTOGsg6wR3Ntzw0fv
	UyXbxk+nP+R0dmR7Y/dMS1TV0oEwXrePRTistJZ/rBXc0SMmOc+fiKDqeMfCJRcYMzshJw0h8i5RU
	/ngJI06dO/qMyRLW66/9tr2xpgdvq5NTWIEwCm/YpriV4+wpA23h4sw4Vq9Zw6233SxKmc+o7m2U/
	TzEbRlnL/QGJEK/G29nspabNIqrmaY2zmArjSpDSBP2IzKsKze30xwjPyNQk9ciMwnEA5KMvqYVkR
	o4QD0Vrw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1uUq-0000000G61X-2KVM;
	Wed, 02 Sep 2026 23:36:00 +0000
Message-ID: <3a581439-6664-4339-8627-f1704db35bb0@infradead.org>
Date: Wed, 2 Sep 2026 16:35:59 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/6] vsock: add IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS
To: Bobby Eshleman <bobbyeshleman@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Stefan Hajnoczi
 <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, sargun@sargun.me,
 jlinbox@meta.com, Bobby Eshleman <bobbyeshleman@meta.com>
References: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
 <20260902-vsock-guest-ns-v1-2-9995383e9a8b@meta.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260902-vsock-guest-ns-v1-2-9995383e9a8b@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/2/26 4:00 PM, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Namespaces let a host isolate a VM's vsock traffic to a specific
> namespace, but in a guest vsock traffic cannot be isolated to a
> namespace. The vsock device is hardcoded to global mode and can't be
> moved into a local-mode namespace.
> 
> Introduce ioctl IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS on /dev/vsock that
> gives userspace a way to move the device to the calling pid's namespace.
> The call requires CAP_NET_ADMIN in the root user namespace. A privileged
> user wishing to "unassign" the device can move it to the init_netns,
> which is hardcoded to global mode (so no unassign call is necessary).
> 
> A getter to read the current assignment back was considered, returning
> either the namespace's net_cookie or its nsfs inode number, but neither
> seemed useful enough to bake into the uAPI now. It can be added later if
> a user turns up that needs it.
> 
> Add a transport hook to indicate support for guest namespacing, so that
> transports may opt in/out. A transport that opts out keeps the
> reachability rules it had before this ioctl existed.
> 
> Sockets are reset when the underlying device moves to a different
> namespace, so as to prevent reachability from the previous and now
> disallowed namespace.
> 
> Following the approach of netdevs, the device returns to init_net when

I'm confused by the use of "init_net" several times and "init_netns" at
least 2 times. "init_net" is the initial, boot-time net namespace.

And is one of these what is referred to in the Documentation/ file below
as "initial namespace"?

> its namespace is removed. Care is taken to not break flows when the
> device is inside a global namespace that is being torn down and alive
> sockets are in a different global namespace. In this scenario, the
> device's netns getter pre-emptively falls back to the init_net (always
> global) so that these flows are not disrupted. If init_netns ever

                                           maybe    init_netns()
if you are referring to a function...

> supports local-mode in the future, this logic will have to be changed.
> 
> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> Link: https://lore.kernel.org/all/20200427142518.uwssa6dtasrp3bfc@steredhat/
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> ---
>  Documentation/admin-guide/sysctl/net.rst |  18 +++
>  include/net/af_vsock.h                   |   7 ++
>  include/uapi/linux/vm_sockets.h          |   6 +
>  net/vmw_vsock/af_vsock.c                 | 198 ++++++++++++++++++++++++++++++-
>  4 files changed, 228 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
> index e586e17fc7a5..1e9c0d2be7b8 100644
> --- a/Documentation/admin-guide/sysctl/net.rst
> +++ b/Documentation/admin-guide/sysctl/net.rst
> @@ -515,6 +515,24 @@ their hosts. The behavior of VSOCK sockets in a network namespace is determined
>  by the namespace's mode (``global`` or ``local``), which controls how CIDs
>  (Context IDs) are allocated and how sockets interact across namespaces.
>  
> +In a guest, the vsock device owned by the guest-to-host (G2H) transport belongs
> +to one network namespace at a time. The ``IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS``
> +ioctl on ``/dev/vsock`` moves it to the namespace of the calling process, which
> +requires ``CAP_NET_ADMIN`` in the initial user namespace. The namespace's mode

                              Is this the caller's namespace?

> +decides who may then use the device:
> +
> +- ``global`` - every ``global`` mode namespace may use it.
> +- ``local`` - only that namespace may use it, which reserves the connection to
> +  the host for it alone.
> +
> +The device starts out in the initial namespace, so until the ioctl is issued
> +nothing has moved and no mode has changed.
> +
> +Connections made before the move, from a namespace that can no longer reach the
> +device, are reset. The device returns to the initial namespace when the
> +namespace it was moved to is deleted, so assigning it to the initial namespace
> +is how an assignment is undone.
> +
>  ns_mode
>  -------
>  
thanks.
-- 
~Randy

