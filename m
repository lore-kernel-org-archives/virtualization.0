Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A5130F803
	for <virtualization@lists.linux.dev>; Fri,  4 Sep 2026 08:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788512131; cv=none; b=XTL7WZrKR+ASNEtsbYDMRX+KVo28qgnWaftz+63uYlDsLA0B8fMapcCgU2Pxsd8lmg/UelKTxG3fAyeaYQSHVpGLCpMJUbiTrbrNRttga0fF2Ltz7T1f/aJh6S9EuU/65LusmNaDVdp45v/f/iOowyGqrSduzb18YJAh4vqOmvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788512131; c=relaxed/simple;
	bh=4IIv9yG4m7qxm3IqrT9DQAomNx8kM3TWRYVx0cDnJRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=PV8ckZQr0fo3eIJ9xJhZiLvKmyHb+KJfAAwmOiV0dtnSgZGiqxUlAze+V+7DdPcvgp8eyz1apMGSMmZnO3hNZFEmUjyVAtbjkZf/HH5jns72c9mlVTonGd8+2qqfDol0KTXZReSu8ziFJU34mkrwO7TIHE2gBXMnIJOg9PJebh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RRRuLrBP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RRRuLrBP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788512129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JKkhm4P3owmRu88ixnc//OXNGkRZebTXD50nAJpfW/8=;
	b=RRRuLrBPhKu7UPeBHcLMujz2UbQ8EEKnYBz8Dx7mxA3N4SXNvFO/3bOnmYxvWfkLEIo/bd
	JDL1j3rvpOjKCk/oOu56m/M5l3Bjlsic5O6gAQEC1wjaD+ZUxLQyW/ljqFAtU0x4/bdchy
	dRGRhkoJdFfWgMasxT5QDH6RUSaLm7I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-njGR2_3ZOlKt0Tn_rzFchA-1; Fri, 04 Sep 2026 04:55:25 -0400
X-MC-Unique: njGR2_3ZOlKt0Tn_rzFchA-1
X-Mimecast-MFC-AGG-ID: njGR2_3ZOlKt0Tn_rzFchA_1788512125
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49ccfad90f1so4928855e9.0
        for <virtualization@lists.linux.dev>; Fri, 04 Sep 2026 01:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788512124; x=1789116924;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JKkhm4P3owmRu88ixnc//OXNGkRZebTXD50nAJpfW/8=;
        b=aKJWwTbRI8PrvzdKNFxdrKpeGXh7Vye3Sjdchw8Y+z9bhaVRTh6oRbwdiN9iL92d5q
         MNsamV2bqW6f6mNCV5UPqwsZxlE8e/esbm1YiCTO+n86JPWSBBlSCYm5cyPXOaM6G0Hf
         oDj1rRQ0raxdNcWl/U8SenD2OAp1/Z0YiS4ZnpNKy68hnDCoyrqYGJQfedxXz07H2UvP
         EiEkIjtxkKNFkU3fCJTd7vIcTajbRjZ42D2t4pM+zRVvOEk8wZozh+TuXx3VFZoBWgGI
         92wGQ5DCKz7zBJhe1t5Tuu7C3/1yNNM4CId0LqlVEK1ZQzdX/l4wDWsRcuuu5EB9r/SP
         Jcbg==
X-Forwarded-Encrypted: i=1; AKwUvBwal89V3StxgirUOfsp9S6N785mPzSCdwZjLaZHTLvZgbPOPNiauifjFFCVNumAIL2+2oyhflOWKrOGWbiKeQ==@lists.linux.dev
X-Gm-Message-State: AFuF++mNUiJs0PfkDJsTrbpdHOcWVvR3yn00Ta/ih1SLWnTjbI46M5He
	m0dx7k3ozhyS2Zk9z0equVGuafzwEz/l023sBsy1z2bZagJTEJ4WI5qZqlLFHIAv1o93BYLeU+k
	tm4rz5HyaXs25k4HN8xKNv1k4W7+nNm9yTXHe+yzq66UWx37bI+8aJnCrp6lDm6iOYjbS
X-Gm-Gg: AYBFou0C9EU0Qcyyr/u/MWjUrkgCfdj7dLUUh8YtwX+1M+Ll8NlMkLQgE+tBg/ykDto
	yfz2NyT05e3SVXQnTDZk9tGNexq0LDq5DfIltqakSS+9Qje4wjakCSqZJkqGcR30EXpKqhfw8mu
	Qxm+Nf34QCK5YY6GdPUDIKiTHYcgEkRWGyuzeNN/Cxn+Du2TXz4J/YlW4Ib54mvo2QiEMmKQGg8
	zsRBiEmzsdK7h5efYKRvFyXbvccgeuwBnUVNEOMzIvdhmhighHnFQVgMq9G30HxepYd1zb3ugn7
	PEwcqgu9FTLhZINwN2P+jEJDM6JAR3C2iCY6IENY0GWZHgMsZ38147JqccpSGVVnfz8vpQuyyh3
	LXgMIovOXvcRiBy5ee+8icTFug4ISiFjMXzK+LaAUIXCCnQ==
X-Received: by 2002:a05:600c:1c29:b0:49c:fc6c:be03 with SMTP id 5b1f17b1804b1-49cfc6cc06cmr18966975e9.26.1788512124657;
        Fri, 04 Sep 2026 01:55:24 -0700 (PDT)
X-Received: by 2002:a05:600c:1c29:b0:49c:fc6c:be03 with SMTP id 5b1f17b1804b1-49cfc6cc06cmr18966125e9.26.1788512123997;
        Fri, 04 Sep 2026 01:55:23 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce46696e8sm128248985e9.0.2026.09.04.01.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:55:23 -0700 (PDT)
Date: Fri, 4 Sep 2026 10:55:17 +0200
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
Message-ID: <apqGcFDFm9_Wtw4q@sgarzare-redhat>
References: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7IAQ_ZpFeykbcT6BmMDS5OPw7mgz4_icICbcJC-Gqd0_1788512125
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Sep 02, 2026 at 04:00:46PM -0700, Bobby Eshleman wrote:
>vsock network namespaces let a host put each VM in a namespace of its
>own. A guest has no equivalent yet. It has a single G2H device that
>cannot be assigned to a network namespace.

Thanks for this, I'll do a proper review next week, in the mean time 
some comments below:

>
>This series lets a guest move that device into a network namespace. A
>new ioctl on /dev/vsock, IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS, assigns the
>device to the namespace of the calling process. The namespace's existing

Why an ioctl?

I'm asking because I'd like to know if you've already considered any 
alternatives (sysfs, netlink, etc.)

How do you think the ioctl should be used? Should we provide an 
userspace tool, or extending some existing tools?

Thanks,
Stefano

>ns_mode then decides who may use it: a "global" namespace shares the
>device with every other global namespace, and a "local" namespace keeps
>the host connection to itself. The device starts out in the initial
>namespace, so until the ioctl is issued nothing has moved and no mode
>has changed. There is no explicit unassign as assigning the device back
>to the initial namespace is equivalent.
>
>The ioctl requires CAP_NET_ADMIN in the initial user namespace.
>
>Connections that can no longer reach the device after a move are reset,
>so that a namespace which has lost access cannot keep using a socket it
>opened while it still had access. Following netdevs, the device returns
>to the initial namespace when the namespace it was moved to is deleted.
>
>Transports opt in through a new netns_assign_allow callback. Only
>virtio-vsock implements it here.

Why? (Not asking to support all the others, asking to explain the reason 
or ask helps from others to extend it)

Thanks,
Stefano

>
>Patch 1 is just a const cleanup that patch 2 needs. The remaining
>patches are actual implementation and tests.
>
>Based off of Stefano's original series:
>https://lore.kernel.org/all/20200116172428.311437-1-sgarzare@redhat.com/
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Link: https://lore.kernel.org/all/20200427142518.uwssa6dtasrp3bfc@steredhat/
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Bobby Eshleman (6):
>      vsock: constify the transport in vsock_for_each_connected_socket()
>      vsock: add IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS
>      vsock/virtio: support guest device network namespace
>      selftests/vsock: add a helper to assign the g2h device to a netns
>      selftests/vsock: test the guest vsock device network namespace
>      selftests/vsock: test the assign ioctl privilege checks
>
> Documentation/admin-guide/sysctl/net.rst           |  18 +
> include/linux/virtio_vsock.h                       |   2 +
> include/net/af_vsock.h                             |   9 +-
> include/uapi/linux/vm_sockets.h                    |   6 +
> net/vmw_vsock/af_vsock.c                           | 200 ++++++++-
> net/vmw_vsock/virtio_transport.c                   |  28 +-
> net/vmw_vsock/virtio_transport_common.c            |  28 +-
> tools/testing/selftests/vsock/.gitignore           |   1 +
> tools/testing/selftests/vsock/Makefile             |   3 +-
> tools/testing/selftests/vsock/config               |   1 +
> tools/testing/selftests/vsock/vmtest.sh            | 461 ++++++++++++++++++++-
> .../selftests/vsock/vsock_assign_g2h_netns.c       |  45 ++
> 12 files changed, 774 insertions(+), 28 deletions(-)
>---
>base-commit: d0ec95a8a4e79f2fd6063fc8932415db8c227689
>change-id: 20260831-vsock-guest-ns-d06af451da67
>
>Best regards,
>-- 
>Bobby Eshleman <bobbyeshleman@meta.com>
>

