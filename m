Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575142;
	b=k3JDaKmxls6Ert88wPQxodMWnNu7NhNJB2toWYCMuyGra2Y/BYcifaQIZ6djykJD9Osq
	 69Jk8IMUfaAVB2CIvrlfbAWyzKwRb69xatxaHHcGW49cA9sOngXFjj/gzByIYDg3PoVy1
	 wDFCVhtOsqbo1ozp9PaRHh6/leHt5nnP/w49Cfjw06V550nWdmfUhUOk5jkiLdf6dbfLi
	 9cZRwSAx8j1xlBSqC7qEre5H4UGnShzbl6OPGR2ngEbuI3WkCuZ4ItJiK+7q4d8UXsiBk
	 3n8MBFW3kfhRSk5k9xBii1MK344XwzzhhWDz3l/LEfemY7IdJqn5H6M+XWWgGhWMPuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575142;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=v4TApKQ2t0hyQZxEXCOTGwfQDcbqzJhHn9ZrRsucxAk=;
	b=OGGuVbI0XnSk9K6DACjC9cCP9lJ6OA8kGIDv8B9GkrydCsy1b9DyDr3+GZWWfPym6Qlw
	 7SgnoWXgr2BUHibHcNqUxuBhbMLro8eTLzaNinTbKKVZbIKAKJ7FM4o0z/pv9HKYQrewT
	 OUONayZYvoI18x27PqvdNKfYS0zDiR9kA2VojQ/E9sMrO6fnGWsOgVI5IHvinNKzVfdUp
	 JHxbKL9fSGOa41402YAFquGVX+Uyyew0BV9ameT5xNNTk2FZiQgzsA+qsnligeiMt5YGS
	 hSIUEF7mCoFJhTgmmj04qrLQYvkkgoMT0Zt++OndChf8cIsok8LzsjJ1l/qvLULBTsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KAOaoeLM;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F88606A89D
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 13:05:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79F88606A89D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KAOaoeLM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794575140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v4TApKQ2t0hyQZxEXCOTGwfQDcbqzJhHn9ZrRsucxAk=;
	b=KAOaoeLMnVhC/CtgA6ZtRA23B1/xquuuEakQ0kMJlNFvA0L+nntEoIgfXb0aolyhkq7iro
	PM5rkjbx2wJZUwA7PyA0skf2+uAo6xoo6qj9NhQc1BgsIABP+AbHS8KtbGKaW5c99ZUQxR
	SqKGbCg6Pym4WT4CFOp8qgie6GlKmSQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-CId8kniKNIixTTni6cuAIw-1; Fri, 13 Nov 2026 08:05:39 -0500
X-MC-Unique: CId8kniKNIixTTni6cuAIw-1
X-Mimecast-MFC-AGG-ID: CId8kniKNIixTTni6cuAIw_1794575138
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a359b714f8so4966165e9.2
        for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 05:05:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794575138; x=1795179938;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v4TApKQ2t0hyQZxEXCOTGwfQDcbqzJhHn9ZrRsucxAk=;
        b=jAOJyYDSsqSfByPHZqKBM7QuIpWGLsbcNpxDzHFQEsXVqUafUpZsM75wjxqPMbgSJR
         F2nzVNXgaH6GHNgNrbRNKiCuTl7G8kZgU6NcozD6WiqdadcYJEQKx3pE7Q2ALiybM68h
         PRyLyl6zUSat0B9c832t1u1i58mJDULmR2+1Pg40ZNSjZaaNW8IHFbAf0JOgMRyGzwYJ
         /6kNWFVdvrRFVwYuaqbP3An2rmWgFF1IxAvmnLdTdA+MZyEhT3ZK87MJs28bYgL9SdnR
         mkevrEO2rRhuqPkTs4ZcZIF/9xGzmFafUuriVvVcYbXuNaIHOQoSJpiPceBdKGpoqBTB
         ZLjg==
X-Forwarded-Encrypted: i=1; AL+hErEhMOGIu22ZP9/hZ8KoCno7RHOMPBbInzoqqNQXvzFga5Kgcwa5sIZQu9hv6DKoICLg4exGVHlr6Ajnp4IZ4A==@lists.linux.dev
X-Gm-Message-State: APuU4Z8N6DbuoFkJphPhqoCPJ7PkMIOhweFahc8VN5nD46mHmPJNV2GA
	2icM6ruH77cQhi0AsKqeglgMKv/30eP7ICw932KIf/kDK2MIWTZ723xWqoVhRVhZj8WK6fK8itw
	xwpswg26XskRNvCXR8symPFDO3vXXh+lzIMDGOJk8l5FxYMxk1X0g0CVFzCVkaN9aFkHB
X-Gm-Gg: AYBFou1deMLywKI9tU/Cn75q9xCY4g2b8e43E+OsWY7V9meDbjl/bHg/X/AkzUTBst8
	nAc9Bd3xiC3ccZIf+7n0laDtfmBap/HgcfZhZBs2yGlLe6QRxPvNjNgMP87B78XM4V8r/TloUQu
	0mRz+7/YYIGf5DmALfsLxmR/fn3CHsrPbcNnwCokVIkuqyZgBAsx5qRE7N/DjvBnYsVmwhlU846
	CAAZTh+wbLGWZ9rE0UViwWwm90AhDTe61jABMiqbA8r3rS1LTh0vynwTE+m+yCiN4wow/ZlhQxl
	zdURaWAPc0rHMfOL4jDHR8GLrwk9pxDBQDAFZyUpxsjXwTDn6pW5pdt8Sy2J9hUTPWhCbSE51Y5
	Us2H+IHhE7HyHzVcnPgImnTwty3JiYb9f968OgHefig==
X-Received: by 2002:a05:600c:3487:b0:4a2:526b:d410 with SMTP id 5b1f17b1804b1-4bb55a4f1b4mr53874625e9.13.1794575137630;
        Fri, 13 Nov 2026 05:05:37 -0800 (PST)
X-Received: by 2002:a05:600c:3487:b0:4a2:526b:d410 with SMTP id 5b1f17b1804b1-4bb55a4f1b4mr53873365e9.13.1794575136910;
        Fri, 13 Nov 2026 05:05:36 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1511:2900:ff37:b35c:a97:952d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb56680ea9sm39056695e9.0.2026.11.13.05.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 05:05:35 -0800 (PST)
Date: Fri, 13 Nov 2026 08:05:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Alexei Starovoitov <ast@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	bpf@vger.kernel.org, linux-hyperv@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC v2 0/8] vsock: add datagram support to virtio and
 vhost
Message-ID: <20261113080506-mutt-send-email-mst@kernel.org>
References: <20261113-vsock-dgram-support-v2-0-bacfc85b71ce@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261113-vsock-dgram-support-v2-0-bacfc85b71ce@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eD5U-lT5DPR5SG31t89LSDARNjR4L3d_Y6CFbd4_xRo_1794575138
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 13, 2026 at 01:47:33PM +0100, Sergio Lopez wrote:
> This RFC adds SOCK_DGRAM support to virtio-vsock and vhost-vsock through
> the existing AF_VSOCK API. It is intended for guest and host services
> that exchange independent requests, responses, or events and need message
> boundaries and sender addresses without a stream connection or application
> framing.
> 
> VIRTIO_VSOCK_F_DGRAM gates virtio traffic in both directions. Each virtio
> send carries zero to 64 KiB of payload in one VIRTIO_VSOCK_TYPE_DGRAM
> packet. On the RX virtqueue, the device may split a datagram across
> page-sized guest buffers.
> START and EOM delimit the message; the guest reassembles at most 64
> fragments and 64 KiB before delivering it to a socket.

where do these limits come from? how does peer know not to send more?

Thanks!

> Invalid or
> incomplete messages are discarded. Datagram delivery is best effort:
> there are no peer credits, acknowledgements, or retransmissions. Send
> admission uses the socket send-memory limit, and SIOCOUTQ reports charged
> send memory.
> 
> Datagram sockets have a separate port space from stream and seqpacket
> sockets. The latter two continue to share their port space. Datagram
> routes are chosen per destination among guest-to-host, host-to-guest, and
> loopback transports, with VMCI as a fallback. VMCI still owns its socket
> handle when it is present; loopback works without a directional transport.
> Hyper-V continues to reject datagram sockets.
> 
> Bobby Eshleman and Amery Hung explored this feature in their v6 series
> and v7 work-in-progress branch. This series is a fresh implementation
> against the current vsock code. It follows the separate datagram port
> space, per-destination routing, and VMCI fallback requirements discussed
> there. For guest receive buffers, it uses bounded fragmentation and
> reassembly rather than full-message buffers or the earlier drop/error
> queue approach:
> 
> https://lore.kernel.org/r/20240710212555.1617795-1-amery.hung@bytedance.com
> https://github.com/ameryhung/linux/tree/vsock-dgram-v7
> 
> A corresponding virtio specification update has been drafted separately.
> The wire format and feature negotiation still need specification review
> before this series can be considered for merging.
> 
> The first patches expose the core port allocator and add datagram queue
> reporting, then implement the common data path, guest and host feature
> negotiation, routing, and RX fragmentation. The last patch extends
> vsock_test with local and peer tests for message boundaries, routing,
> connected peers, port sharing, queue accounting, and delayed reads.
> 
> Testing used QEMU with the F_DGRAM property patch below, an x86-64
> KASAN/lockdep kernel, paired guest tests, and a nested Linux vhost-vsock
> backend. The tested paths include 64 KiB messages, delayed-read bursts,
> feature-disabled ingress, stream and seqpacket controls, and header-only
> guest RX buffers. A temporary userspace backend still fails stream test
> 21 on both the series base and tip; that case passes with Linux vhost.
> Real VMCI and Hyper-V hardware were not exercised.
> 
> https://lists.gnu.org/archive/html/qemu-devel/2026-10/msg08074.html
> 
> Code was written and reviewed both manually and assisted by Codex
> (GPT-6.1-Sol) and Claude (Opus 4.6).
> 
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
> Changes in v2:
> - Keep guest RX buffers page-sized; add START/EOM framing and bounded
>   datagram reassembly (thanks to Alexei Starovoitov and Bobby Eshleman).
> - Preserve stream and seqpacket data when an RX buffer has no payload
>   room.
> - Separate datagram and connection-oriented port spaces, and share
>   receive metadata and queueing (thanks to Alexei Starovoitov).
> - Check negotiated support and destination CID on ingress, and require
>   an exact connected peer CID and port (thanks to Sashiko AI bot).
> - Select a capable route for each destination, retain VMCI as fallback,
>   and support loopback-only sockets (thanks to Alexei Starovoitov).
> - Preserve the connected peer address across temporary parent fallback
>   (thanks to Sashiko AI bot).
> - Use socket write-memory accounting for datagram SIOCOUTQ instead of
>   separate transport counters (thanks to Alexei Starovoitov).
> - Extend selftests for fragmentation, delayed reads, port sharing,
>   connected peers, and capability-based skips; fix the test build and
>   README entries (thanks to Alexei Starovoitov, Bobby Eshleman,
>   and Sashiko AI bot).
> - Link to v1: https://lore.kernel.org/r/20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org
> 
> ---
> Sergio Lopez (8):
>       vsock: expose the core port allocator to transports
>       vsock: report datagram receive and send queue state
>       vsock/virtio: implement the datagram data path
>       vsock/virtio: negotiate datagram support on the guest
>       vhost/vsock: negotiate datagram support with guests
>       vsock: allow datagrams to use directional transports
>       vsock: fragment datagrams across receive buffers
>       vsock: add datagram tests to vsock_test
> 
>  Documentation/admin-guide/sysctl/net.rst |    8 +-
>  drivers/vhost/vsock.c                    |   51 +-
>  include/linux/virtio_vsock.h             |    9 +-
>  include/net/af_vsock.h                   |   30 +-
>  include/uapi/linux/virtio_vsock.h        |   10 +
>  net/vmw_vsock/af_vsock.c                 |  459 +++++++++++---
>  net/vmw_vsock/hyperv_transport.c         |   11 +-
>  net/vmw_vsock/virtio_transport.c         |  167 ++++-
>  net/vmw_vsock/virtio_transport_common.c  |  164 ++++-
>  net/vmw_vsock/vmci_transport.c           |  115 ++--
>  net/vmw_vsock/vsock_bpf.c                |    3 +-
>  net/vmw_vsock/vsock_loopback.c           |    2 +-
>  tools/testing/vsock/Makefile             |    3 +-
>  tools/testing/vsock/README               |   31 +-
>  tools/testing/vsock/util.c               |   62 +-
>  tools/testing/vsock/util.h               |   10 +
>  tools/testing/vsock/vsock_test.c         |  175 +++++-
>  tools/testing/vsock/vsock_test_dgram.c   | 1000 ++++++++++++++++++++++++++++++
>  tools/testing/vsock/vsock_test_dgram.h   |   29 +
>  19 files changed, 2066 insertions(+), 273 deletions(-)
> ---
> base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d
> change-id: 20261027-vsock-dgram-support-683a4e0aebe7
> 
> Best regards,
> -- 
> Sergio Lopez <slp@redhat.com>

