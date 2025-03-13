Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5875B23B0
	for <virtualization@lists.linux.dev>; Thu, 13 Mar 2025 02:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741832918; cv=none; b=mJU5jsHwZ/4+wtoJAZWvZcQq83dzQKv5iBajtuQDqIHiX+wSvjWFXo/V3N6QXcHAVhTDzuu1nFv5QFTh/a/u3pcKr3WgrRIP5V+XZ/eGmfT4fP0ECvSjNnPwN3ByW0Nd9gnA4bVUfutDZ6WDxeM5MK+qD9fbeEjX9X7GYwfmEbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741832918; c=relaxed/simple;
	bh=VovwtesJv9Sb1xbTUhCBIIiCY95KkpZxe6VkXX0igs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNiX7rY5pcjTD0L7zcrwyFZGWBlUEjc5LKw+bn95LxCBtCbl14FkZqvcfOWVFP5V+d+yFfw+6p0bUsEr41zeCXzxhT05cRh9AqT90L0tF9TEItnAL0kMY6xgvctVRj2O9bxTTz6wXNGh0E0hc1GQ5TbWC/s+a8q9XZg4GsqwSi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKegWNxs; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKegWNxs"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2232aead377so9757575ad.0
        for <virtualization@lists.linux.dev>; Wed, 12 Mar 2025 19:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741832916; x=1742437716; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KoDUTDm8Gdk20+Tf3509gImhzxirBKWUcOSksBRe5Oc=;
        b=ZKegWNxs1ngZjj1yge37zLv/f+n41shm6eV2nZXhoWaV/Y5H8HrrI90egkUfKgyy/p
         izZ+DjQT+h4Sd+cpPqisFG1WwocLSaXJiRZ4ATGsL8sPGTB4/x5ZINJypg8Bi+XMudnz
         9P5/1yw+dn4stFBa97KUii7AwqqmwOF1ykl4JJdAFUQElMlC7odWmITVxVEHOEHAIzTP
         KDYMDoXTSl2plp9u6FUt9ghF4fxS0R1Xlv0dtgNnByxsFYfmQxgmNmnELqh1Oql5Vs1u
         CELnbV6xxDjzp7wmF3F2tMPX7ld1c1yoDSBUfhxaHRo+7kHCVZklX5Q5ALpDGuwLU3Ts
         mzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741832916; x=1742437716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KoDUTDm8Gdk20+Tf3509gImhzxirBKWUcOSksBRe5Oc=;
        b=V59vP7zRJRVuqkngKqKXH4vn1Px36jiJspI/x+phky4U85JJ3rrheZT128CjUuFxi7
         ZVXv4gSKopOJcj+ff8K/B34dPoAq3PoxNabfWPoC5Gf/qUWwoOlfhKln0FGAjGPBy0yA
         9Viirt/IqQGnMfwH78RGxQHzfPpm23ezb+tdJ/RF0IbOS+R30jl92d6WbXs6LZrpFmvt
         J2cGFmQHpqsNVjNLpSFu3aL9qJL7YYlBv6tbfzcvioQ4cM8gOUrFZno5UEKfBk8YylJD
         s8/KQigMde69UvbGppgz8wzOzFQZVWb6yfmyVa5eVEPef9ZfTHuZbo+c717QvKhCj7IX
         Q9jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrX5lNshdQM1+YvC3ZgVio1H5F9Pu4B9dzId6uPKfpeNXIiSqxKK6G6pVWpZIYKdECbEMmdWwGC/gC6FuHVg==@lists.linux.dev
X-Gm-Message-State: AOJu0YziQGBuFRueoEbfkGxp/VUsD7wlQ3wdjaYUZm/lXVV3QXiTKwhi
	iagoy4fX4xPV+3e/z72MbHzB/cckt/+74IOCwWjiF58sjBEXuDHT
X-Gm-Gg: ASbGncszafUSg0Urg1u7KCBew8QgJ/bA0eb7otY8NBQEMJdY8WDBz0k2xGv3XTGNzo1
	4RTOIptW91+/gpniDEBHDkmeT5AUhODhl3GKeXes20SW7x1jjw8Or1BihXn5ABUj1+YqPjgq2ZI
	Xfk2Dkl7b4EioyY4mS7I7JcnyM4F6xxqX25mrvQRHrYSGzHMnCbGxZ3nDyYC9u8lIp1q73m6JEZ
	dWWMPSfSHXSIaFESGvzerFPqFZ6URLZOG5D9QbF2rIb8Zpz32KZ68sOpMdnRgIS8j2034pbGVFQ
	RsLzYkkaDGSKGfCPsI7Bq+vInK/U0e8qTQ2bQa08u2HyUkvZeWkzk0pIAH4ljtMmy9IboLRUcsi
	tCA==
X-Google-Smtp-Source: AGHT+IElXCWU2ZTEBcj7ESTCH4hLQqV9BYJSYITdjZw2xjnf7NpJNUxUzR1Spw/U1Dc6tCNyB628Iw==
X-Received: by 2002:a17:903:2405:b0:21f:6bda:e492 with SMTP id d9443c01a7336-22428bdee0emr427968615ad.35.1741832916397;
        Wed, 12 Mar 2025 19:28:36 -0700 (PDT)
Received: from devvm6277.cco0.facebook.com ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68884ccsm2791885ad.27.2025.03.12.19.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 19:28:35 -0700 (PDT)
Date: Wed, 12 Mar 2025 19:28:33 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: "David S. Miller" <davem@davemloft.net>, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 0/3] vsock: add namespace support to vhost-vsock
Message-ID: <Z9JC0VoMwAHKjqEX@devvm6277.cco0.facebook.com>
References: <20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com>

Hey all,

Apologies for forgetting the 'net-next' prefix on this one. Should I
resend or no?

Best,
Bobby

On Wed, Mar 12, 2025 at 01:59:34PM -0700, Bobby Eshleman wrote:
> Picking up Stefano's v1 [1], this series adds netns support to
> vhost-vsock. Unlike v1, this series does not address guest-to-host (g2h)
> namespaces, defering that for future implementation and discussion.
> 
> Any vsock created with /dev/vhost-vsock is a global vsock, accessible
> from any namespace. Any vsock created with /dev/vhost-vsock-netns is a
> "scoped" vsock, accessible only to sockets in its namespace. If a global
> vsock or scoped vsock share the same CID, the scoped vsock takes
> precedence.
> 
> If a socket in a namespace connects with a global vsock, the CID becomes
> unavailable to any VMM in that namespace when creating new vsocks. If
> disconnected, the CID becomes available again.
> 
> Testing
> 
> QEMU with /dev/vhost-vsock-netns support:
> 	https://github.com/beshleman/qemu/tree/vsock-netns
> 
> Test: Scoped vsocks isolated by namespace
> 
>   host# ip netns add ns1
>   host# ip netns add ns2
>   host# ip netns exec ns1 \
> 				  qemu-system-x86_64 \
> 					  -m 8G -smp 4 -cpu host -enable-kvm \
> 					  -serial mon:stdio \
> 					  -drive if=virtio,file=${IMAGE1} \
> 					  -device vhost-vsock-pci,netns=on,guest-cid=15
>   host# ip netns exec ns2 \
> 				  qemu-system-x86_64 \
> 					  -m 8G -smp 4 -cpu host -enable-kvm \
> 					  -serial mon:stdio \
> 					  -drive if=virtio,file=${IMAGE2} \
> 					  -device vhost-vsock-pci,netns=on,guest-cid=15
> 
>   host# socat - VSOCK-CONNECT:15:1234
>   2025/03/10 17:09:40 socat[255741] E connect(5, AF=40 cid:15 port:1234, 16): No such device
> 
>   host# echo foobar1 | sudo ip netns exec ns1 socat - VSOCK-CONNECT:15:1234
>   host# echo foobar2 | sudo ip netns exec ns2 socat - VSOCK-CONNECT:15:1234
> 
>   vm1# socat - VSOCK-LISTEN:1234
>   foobar1
>   vm2# socat - VSOCK-LISTEN:1234
>   foobar2
> 
> Test: Global vsocks accessible to any namespace
> 
>   host# qemu-system-x86_64 \
> 	  -m 8G -smp 4 -cpu host -enable-kvm \
> 	  -serial mon:stdio \
> 	  -drive if=virtio,file=${IMAGE2} \
> 	  -device vhost-vsock-pci,guest-cid=15,netns=off
> 
>   host# echo foobar | sudo ip netns exec ns1 socat - VSOCK-CONNECT:15:1234
> 
>   vm# socat - VSOCK-LISTEN:1234
>   foobar
> 
> Test: Connecting to global vsock makes CID unavailble to namespace
> 
>   host# qemu-system-x86_64 \
> 	  -m 8G -smp 4 -cpu host -enable-kvm \
> 	  -serial mon:stdio \
> 	  -drive if=virtio,file=${IMAGE2} \
> 	  -device vhost-vsock-pci,guest-cid=15,netns=off
> 
>   vm# socat - VSOCK-LISTEN:1234
> 
>   host# sudo ip netns exec ns1 socat - VSOCK-CONNECT:15:1234
>   host# ip netns exec ns1 \
> 				  qemu-system-x86_64 \
> 					  -m 8G -smp 4 -cpu host -enable-kvm \
> 					  -serial mon:stdio \
> 					  -drive if=virtio,file=${IMAGE1} \
> 					  -device vhost-vsock-pci,netns=on,guest-cid=15
> 
>   qemu-system-x86_64: -device vhost-vsock-pci,netns=on,guest-cid=15: vhost-vsock: unable to set guest cid: Address already in use
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@gmail.com>
> ---
> Changes in v2:
> - only support vhost-vsock namespaces
> - all g2h namespaces retain old behavior, only common API changes
>   impacted by vhost-vsock changes
> - add /dev/vhost-vsock-netns for "opt-in"
> - leave /dev/vhost-vsock to old behavior
> - removed netns module param
> - Link to v1: https://lore.kernel.org/r/20200116172428.311437-1-sgarzare@redhat.com
> 
> Changes in v1:
> - added 'netns' module param to vsock.ko to enable the
>   network namespace support (disabled by default)
> - added 'vsock_net_eq()' to check the "net" assigned to a socket
>   only when 'netns' support is enabled
> - Link to RFC: https://patchwork.ozlabs.org/cover/1202235/
> 
> ---
> Stefano Garzarella (3):
>       vsock: add network namespace support
>       vsock/virtio_transport_common: handle netns of received packets
>       vhost/vsock: use netns of process that opens the vhost-vsock-netns device
> 
>  drivers/vhost/vsock.c                   | 96 +++++++++++++++++++++++++++------
>  include/linux/miscdevice.h              |  1 +
>  include/linux/virtio_vsock.h            |  2 +
>  include/net/af_vsock.h                  | 10 ++--
>  net/vmw_vsock/af_vsock.c                | 85 +++++++++++++++++++++++------
>  net/vmw_vsock/hyperv_transport.c        |  2 +-
>  net/vmw_vsock/virtio_transport.c        |  5 +-
>  net/vmw_vsock/virtio_transport_common.c | 14 ++++-
>  net/vmw_vsock/vmci_transport.c          |  4 +-
>  net/vmw_vsock/vsock_loopback.c          |  4 +-
>  10 files changed, 180 insertions(+), 43 deletions(-)
> ---
> base-commit: 0ea09cbf8350b70ad44d67a1dcb379008a356034
> change-id: 20250312-vsock-netns-45da9424f726
> 
> Best regards,
> -- 
> Bobby Eshleman <bobbyeshleman@gmail.com>
> 
