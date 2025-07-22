Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A26A2EAB6A
	for <virtualization@lists.linux-foundation.org>; Tue, 22 Jul 2025 14:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753194949; cv=none; b=D1PU7KmE6RsAWz/1bbRdVsWmobW+ZC8RE/pvingwfbkjUJURVgjf2haPHNjIHm1ahsRXqmw2uHJXOdjcACv5X91UeDixfBx0u/laWiNDS3BLbafGpCFtY0FuInnbCfVkAi4YRNm8/a2vGOWY++VNQ4lVNRRNWY9QrOKn07qixGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753194949; c=relaxed/simple;
	bh=FtMcpts9tF0PQFNX2Xy1OLTiS5qBzXfp3waJCk/dUso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=NGqM5kygUVe7fiftgiktIiadBJsafNTPheqAUVpkq9vGMnQGwR8vHHsbzNUrLGwNUyy+Sh9rjCghK4nD3LxR/5IoMvwMjzr5YNfR2/jHuHXDUuReSF81VZWt/TmGEaaPgkMXFQnVO7487LS13YbV9fJ5TR6ZPfg/N0WQPx6SQjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CQhe4s58; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQhe4s58"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F282A611F4
	for <virtualization@lists.linux-foundation.org>; Tue, 22 Jul 2025 14:35:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w23z0dm3kGcr for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Jul 2025 14:35:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E3ED360E5A
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E3ED360E5A
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CQhe4s58
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E3ED360E5A
	for <virtualization@lists.linux-foundation.org>; Tue, 22 Jul 2025 14:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753194944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fzB7P1BusfnapG0uVAVGElcUdQoH/V3AcX2/zWIOBVg=;
	b=CQhe4s58x3OrdWIaGeUPYxARs9lxw+HkDnH/FSY6+/yiSIl9evtvgoLWNwyRV1FrIrQKxr
	4j+h5neymW7ntf1Oyki0O9fJYygeUJFFHUyxPF/g1JwRliRHT9hciztjYBdD4iOgI6CxZ8
	9ZqsIscRzUsxOxX3hsxM3+6XIuKsKu4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-BdXi8dbxPMOzy93kZiFd4g-1; Tue, 22 Jul 2025 10:35:42 -0400
X-MC-Unique: BdXi8dbxPMOzy93kZiFd4g-1
X-Mimecast-MFC-AGG-ID: BdXi8dbxPMOzy93kZiFd4g_1753194941
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ae3c8477f1fso478306966b.3
        for <virtualization@lists.linux-foundation.org>; Tue, 22 Jul 2025 07:35:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753194941; x=1753799741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzB7P1BusfnapG0uVAVGElcUdQoH/V3AcX2/zWIOBVg=;
        b=vezbOAyvUNhn9n7tV4sHKZJULVZ9k9bXdBNCMt5W9mmuBcV4UG8ONbf5VGowpw4yzj
         7aQHm14et/7zdAwOFD0ov5JHjzPSXDcQ5NIaZ0T7DCb1oQHlyZ58j0VnTzI/ZVoVPiyT
         oPEjPDDRwEUkTDsKmnUepAqxmIBXIc3PayWrEfafaJfrQge3EvIUEn3wVw6aepkoexj4
         Ej6FQtsZJOoIvebq1GZdeQlQG6u+En/R646RGP0DAevwS+XtfAEOm2V3GVQv4mP0+MkR
         isQJhSlSCHxN7tMvidZLIXdWKRe+ixNiyuz/HA+trp65bAJHPRulMQ1ZPEGaXJBfEHPg
         uKdg==
X-Forwarded-Encrypted: i=1; AJvYcCUL74l13yMu6EE6QzCGRTZ60cYB4K0q2I0OhJkHQIxvaIBFgy4RYub8R5LAUoZEW0pjWpXX5KGvWtykaxEOCA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzkX2TpIdNp9fXgFT+rqdPdhHVx3SkM5WuTKWX8Zj2Wz0hQQsng
	+hSy87zIO7cJWPN0BQ1i1To9T8x15DvnQZH78mht25p9Mou+GQuPt9MqBTyID8bgg2nSoagZVKr
	pOp4c9DxJZvFZ5V0GnPP3vEdpO9RxsryyAinH4ytObZf6wvweHDuMcpZeuneOQk4IgW+yP1HAZ0
	mnLc1RSC4=
X-Gm-Gg: ASbGncv5cntMm8TpEYCy/RjGbrIk5fWhnf5t8PEX9Mc9jrkaV+Ea5DKzIn90eO6ccJK
	w6stxV0Q6P6Mq8A2R1bmFSXaSmxIvttEE2idCYMgNpHkIpRunFVoqv/2LzYEglJNf70A4BrfsnW
	oA6lhJAw+S1R+vpxpQ+ZhUXohsjvDLGyFG4Eemyq0+Ai3Gl1rU/85Sh+9CZB/6MCZFDarGaaeEX
	NbSK0OMxr8SveCnCnzQw8Mw6phWRLtfDw2K7bC5B8V4FNnQZb/wFp6IlJqHVud4eDGRDnt7OFMb
	o5Xb+hmOUWJc3Hir6mCZBW8vOFN10DBI/wgSlf+nLlnpjqY7SpmGEIp9J4j+zoYuQcPTAJPYSCZ
	HPWnH980LwPneF5E=
X-Received: by 2002:a17:906:7946:b0:ae9:8dcb:4dac with SMTP id a640c23a62f3a-ae9c99bac5fmr2438078666b.14.1753194941141;
        Tue, 22 Jul 2025 07:35:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/TeWm8DeewR5crPsEXii/8MlhRmlF6n2C6fHO5dz/5iDDWZFbxMXiWYmWah7yJm8iOWS6rw==
X-Received: by 2002:a17:906:7946:b0:ae9:8dcb:4dac with SMTP id a640c23a62f3a-ae9c99bac5fmr2438071766b.14.1753194940260;
        Tue, 22 Jul 2025 07:35:40 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-118.retail.telecomitalia.it. [79.45.205.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d9941sm879107266b.56.2025.07.22.07.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 07:35:39 -0700 (PDT)
Date: Tue, 22 Jul 2025 16:35:25 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, bryantan@vmware.com, vdasa@vmware.com, pv-drivers@vmware.com, 
	dan.carpenter@linaro.org, simon.horman@corigine.com, oxffffaa@gmail.com, 
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	bpf@vger.kernel.org, bobby.eshleman@bytedance.com, jiang.wang@bytedance.com, 
	amery.hung@bytedance.com, xiyou.wangcong@gmail.com
Subject: Re: [RFC PATCH net-next v6 00/14] virtio/vsock: support datagrams
Message-ID: <dsamf7k2byoflztkwya3smj7jyczyq7aludvd36lufdrboxdqk@u73iwrcyb5am>
References: <20240710212555.1617795-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240710212555.1617795-1-amery.hung@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6U3ILapIpIC_UG9W3SCHPxltHIGL00W_sxYW2hrTWdY_1753194941
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Hi Amery,

On Wed, Jul 10, 2024 at 09:25:41PM +0000, Amery Hung wrote:
>Hey all!
>
>This series introduces support for datagrams to virtio/vsock.

any update on v7 of this series?

Thanks,
Stefano

>
>It is a spin-off (and smaller version) of this series from the summer:
>  https://lore.kernel.org/all/cover.1660362668.git.bobby.eshleman@bytedance.com/
>
>Please note that this is an RFC and should not be merged until
>associated changes are made to the virtio specification, which will
>follow after discussion from this series.
>
>Another aside, the v4 of the series has only been mildly tested with a
>run of tools/testing/vsock/vsock_test. Some code likely needs cleaning
>up, but I'm hoping to get some of the design choices agreed upon before
>spending too much time making it pretty.
>
>This series first supports datagrams in a basic form for virtio, and
>then optimizes the sendpath for all datagram transports.
>
>The result is a very fast datagram communication protocol that
>outperforms even UDP on multi-queue virtio-net w/ vhost on a variety
>of multi-threaded workload samples.
>
>For those that are curious, some summary data comparing UDP and VSOCK
>DGRAM (N=5):
>
>	vCPUS: 16
>	virtio-net queues: 16
>	payload size: 4KB
>	Setup: bare metal + vm (non-nested)
>
>	UDP: 287.59 MB/s
>	VSOCK DGRAM: 509.2 MB/s
>
>Some notes about the implementation...
>
>This datagram implementation forces datagrams to self-throttle according
>to the threshold set by sk_sndbuf. It behaves similar to the credits
>used by streams in its effect on throughput and memory consumption, but
>it is not influenced by the receiving socket as credits are.
>
>The device drops packets silently.
>
>As discussed previously, this series introduces datagrams and defers
>fairness to future work. See discussion in v2 for more context around
>datagrams, fairness, and this implementation.
>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>Signed-off-by: Amery Hung <amery.hung@bytedance.com>
>---
>Changes in v6:
>- allow empty transport in datagram vsock
>- add empty transport checks in various paths
>- transport layer now saves source cid and port to control buffer of skb
>  to remove the dependency of transport in recvmsg()
>- fix virtio dgram_enqueue() by looking up the transport to be used when
>  using sendto(2)
>- fix skb memory leaks in two places
>- add dgram auto-bind test
>- Link to v5: https://lore.kernel.org/r/20230413-b4-vsock-dgram-v5-0-581bd37fdb26@bytedance.com
>
>Changes in v5:
>- teach vhost to drop dgram when a datagram exceeds the receive buffer
>  - now uses MSG_ERRQUEUE and depends on Arseniy's zerocopy patch:
>	"vsock: read from socket's error queue"
>- replace multiple ->dgram_* callbacks with single ->dgram_addr_init()
>  callback
>- refactor virtio dgram skb allocator to reduce conflicts w/ zerocopy series
>- add _fallback/_FALLBACK suffix to dgram transport variables/macros
>- add WARN_ONCE() for table_size / VSOCK_HASH issue
>- add static to vsock_find_bound_socket_common
>- dedupe code in vsock_dgram_sendmsg() using module_got var
>- drop concurrent sendmsg() for dgram and defer to future series
>- Add more tests
>  - test EHOSTUNREACH in errqueue
>  - test stream + dgram address collision
>- improve clarity of dgram msg bounds test code
>- Link to v4: https://lore.kernel.org/r/20230413-b4-vsock-dgram-v4-0-0cebbb2ae899@bytedance.com
>
>Changes in v4:
>- style changes
>  - vsock: use sk_vsock(vsk) in vsock_dgram_recvmsg instead of
>    &sk->vsk
>  - vsock: fix xmas tree declaration
>  - vsock: fix spacing issues
>  - virtio/vsock: virtio_transport_recv_dgram returns void because err
>    unused
>- sparse analysis warnings/errors
>  - virtio/vsock: fix unitialized skerr on destroy
>  - virtio/vsock: fix uninitialized err var on goto out
>  - vsock: fix declarations that need static
>  - vsock: fix __rcu annotation order
>- bugs
>  - vsock: fix null ptr in remote_info code
>  - vsock/dgram: make transport_dgram a fallback instead of first
>    priority
>  - vsock: remove redundant rcu read lock acquire in getname()
>- tests
>  - add more tests (message bounds and more)
>  - add vsock_dgram_bind() helper
>  - add vsock_dgram_connect() helper
>
>Changes in v3:
>- Support multi-transport dgram, changing logic in connect/bind
>  to support VMCI case
>- Support per-pkt transport lookup for sendto() case
>- Fix dgram_allow() implementation
>- Fix dgram feature bit number (now it is 3)
>- Fix binding so dgram and connectible (cid,port) spaces are
>  non-overlapping
>- RCU protect transport ptr so connect() calls never leave
>  a lockless read of the transport and remote_addr are always
>  in sync
>- Link to v2: https://lore.kernel.org/r/20230413-b4-vsock-dgram-v2-0-079cc7cee62e@bytedance.com
>
>
>Bobby Eshleman (14):
>  af_vsock: generalize vsock_dgram_recvmsg() to all transports
>  af_vsock: refactor transport lookup code
>  af_vsock: support multi-transport datagrams
>  af_vsock: generalize bind table functions
>  af_vsock: use a separate dgram bind table
>  virtio/vsock: add VIRTIO_VSOCK_TYPE_DGRAM
>  virtio/vsock: add common datagram send path
>  af_vsock: add vsock_find_bound_dgram_socket()
>  virtio/vsock: add common datagram recv path
>  virtio/vsock: add VIRTIO_VSOCK_F_DGRAM feature bit
>  vhost/vsock: implement datagram support
>  vsock/loopback: implement datagram support
>  virtio/vsock: implement datagram support
>  test/vsock: add vsock dgram tests
>
> drivers/vhost/vsock.c                   |   62 +-
> include/linux/virtio_vsock.h            |    9 +-
> include/net/af_vsock.h                  |   24 +-
> include/uapi/linux/virtio_vsock.h       |    2 +
> net/vmw_vsock/af_vsock.c                |  343 ++++++--
> net/vmw_vsock/hyperv_transport.c        |   13 -
> net/vmw_vsock/virtio_transport.c        |   24 +-
> net/vmw_vsock/virtio_transport_common.c |  188 ++++-
> net/vmw_vsock/vmci_transport.c          |   61 +-
> net/vmw_vsock/vsock_loopback.c          |    9 +-
> tools/testing/vsock/util.c              |  177 +++-
> tools/testing/vsock/util.h              |   10 +
> tools/testing/vsock/vsock_test.c        | 1032 ++++++++++++++++++++---
> 13 files changed, 1638 insertions(+), 316 deletions(-)
>
>-- 
>2.20.1
>

