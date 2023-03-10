Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD7F8C64EC4
	for <virtualization@archiver.kernel.org>; Fri, 10 Mar 2023 08:53:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5271B821A0;
	Fri, 10 Mar 2023 08:53:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5271B821A0
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SKVQuvQ8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RxQlbysH8Ev4; Fri, 10 Mar 2023 08:53:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AEF958218F;
	Fri, 10 Mar 2023 08:53:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AEF958218F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81A27C0071;
	Fri, 10 Mar 2023 08:53:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7753BC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 08:53:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5128E4180F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 08:53:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5128E4180F
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SKVQuvQ8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9Er6ZncXRZ9g
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 08:53:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 27BCF41800
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 27BCF41800
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 08:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678438427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nyujGqY6hbL21R7JvgsLqfIPq6KmX0JyLo05ppN+aX0=;
 b=SKVQuvQ8NgsqHx47PJ5botKhooWmTguShV+6YJPFAjEf9NjuLAu4Pq3D7oc21oWKme/Qeq
 TXlBCLgJFYMm3l2mdLz/oUfg4BzUHx5iObAn6WVYqWKOLh1mpT641s0+VQ2Fcmo+Je8EPQ
 wRjLGv0W9dzIrxPNFU2fWfFr8EE3fHA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-KgBHwRSNNyShI-Hs2GUNXA-1; Fri, 10 Mar 2023 03:53:45 -0500
X-MC-Unique: KgBHwRSNNyShI-Hs2GUNXA-1
Received: by mail-wm1-f71.google.com with SMTP id
 c7-20020a7bc847000000b003e00be23a70so3573861wml.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 00:53:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678438424;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nyujGqY6hbL21R7JvgsLqfIPq6KmX0JyLo05ppN+aX0=;
 b=Q3bsUrh74bRE/w0lSSuORItKhEV+slRtTslOJ3QFCnMz70NWBmwDMSfFrHAYLqgW1V
 L6Xi3c5Hjl1j4x6gbe8/q80FE7YtV7pabAepjxQuAIDnW7sHNAFi763L1+IZQizS+DZs
 /j7tln7nDpV8Wbmm27ezLTkLebsiGazKScwPX6CTYd1KNWCYKanjf0qUlN2dC8bpWoUi
 Xz+qKwlsUe++iTi3+uOljYnPOzIGnXKeMBG8epouFowq9dY4ipjUyx38KcB2qgkmOrmv
 tWTWnjQdNKYpg5j/Jb8STHu9zYmpMag/W20sHs5FLzJxE+LmYOiLXuqflYfzitbuZeH9
 VZ8A==
X-Gm-Message-State: AO0yUKXtW14ajsB6dU0esT0owjxBPaAQa4durfRDsNM5K7fHb6/XDZ2t
 mY3Ht1hf3ynhLNGbUOsyvNVTupDc7zTVD9fUtf5g89UsSL5btNuN9bRbN/v/p00M1kkmFHk5FIR
 9Ap9qDxF0YGjzoO8AmLiXuiScsfe6I43/KpyU/F6VSg==
X-Received: by 2002:a05:600c:1c17:b0:3dc:557f:6123 with SMTP id
 j23-20020a05600c1c1700b003dc557f6123mr1946402wms.1.1678438424827; 
 Fri, 10 Mar 2023 00:53:44 -0800 (PST)
X-Google-Smtp-Source: AK7set82MkObAZdWQPCWwT+eXdPJoKLSsejspunYV9KZmp0T6Zmmx7jMIADOEHFaY00hmbmSF3ENFw==
X-Received: by 2002:a05:600c:1c17:b0:3dc:557f:6123 with SMTP id
 j23-20020a05600c1c1700b003dc557f6123mr1946371wms.1.1678438424470; 
 Fri, 10 Mar 2023 00:53:44 -0800 (PST)
Received: from redhat.com ([2.52.9.88]) by smtp.gmail.com with ESMTPSA id
 y6-20020a5d6146000000b002c54fb024b2sm1553272wrt.61.2023.03.10.00.53.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Mar 2023 00:53:43 -0800 (PST)
Date: Fri, 10 Mar 2023 03:53:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: Re: [PATCH net-next v3 0/3] vsock: add support for sockmap
Message-ID: <20230310035307-mutt-send-email-mst@kernel.org>
References: <20230227-vsock-sockmap-upstream-v3-0-7e7f4ce623ee@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20230227-vsock-sockmap-upstream-v3-0-7e7f4ce623ee@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Cong Wang <cong.wang@bytedance.com>, kvm@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Song Liu <song@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Stanislav Fomichev <sdf@google.com>, linux-kselftest@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Yonghong Song <yhs@fb.com>, Paolo Abeni <pabeni@redhat.com>,
 KP Singh <kpsingh@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Hao Luo <haoluo@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 Martin KaFai Lau <martin.lau@linux.dev>,
 "David S. Miller" <davem@davemloft.net>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Feb 28, 2023 at 07:04:33PM +0000, Bobby Eshleman wrote:
> Add support for sockmap to vsock.
> 
> We're testing usage of vsock as a way to redirect guest-local UDS
> requests to the host and this patch series greatly improves the
> performance of such a setup.
> 
> Compared to copying packets via userspace, this improves throughput by
> 121% in basic testing.


besides the small comment, looks ok. Feel free to include my ack
in v4:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Tested as follows.
> 
> Setup: guest unix dgram sender -> guest vsock redirector -> host vsock
>        server
> Threads: 1
> Payload: 64k
> No sockmap:
> - 76.3 MB/s
> - The guest vsock redirector was
>   "socat VSOCK-CONNECT:2:1234 UNIX-RECV:/path/to/sock"
> Using sockmap (this patch):
> - 168.8 MB/s (+121%)
> - The guest redirector was a simple sockmap echo server,
>   redirecting unix ingress to vsock 2:1234 egress.
> - Same sender and server programs
> 
> *Note: these numbers are from RFC v1
> 
> Only the virtio transport has been tested. The loopback transport was
> used in writing bpf/selftests, but not thoroughly tested otherwise.
> 
> This series requires the skb patch.
> 
> Changes in v3:
> - vsock/bpf: Refactor wait logic in vsock_bpf_recvmsg() to avoid
>   backwards goto
> - vsock/bpf: Check psock before acquiring slock
> - vsock/bpf: Return bool instead of int of 0 or 1
> - vsock/bpf: Wrap macro args __sk/__psock in parens
> - vsock/bpf: Place comment trailer */ on separate line
> 
> Changes in v2:
> - vsock/bpf: rename vsock_dgram_* -> vsock_*
> - vsock/bpf: change sk_psock_{get,put} and {lock,release}_sock() order
>   to minimize slock hold time
> - vsock/bpf: use "new style" wait
> - vsock/bpf: fix bug in wait log
> - vsock/bpf: add check that recvmsg sk_type is one dgram, seqpacket, or
>   stream.  Return error if not one of the three.
> - virtio/vsock: comment __skb_recv_datagram() usage
> - virtio/vsock: do not init copied in read_skb()
> - vsock/bpf: add ifdef guard around struct proto in dgram_recvmsg()
> - selftests/bpf: add vsock loopback config for aarch64
> - selftests/bpf: add vsock loopback config for s390x
> - selftests/bpf: remove vsock device from vmtest.sh qemu machine
> - selftests/bpf: remove CONFIG_VIRTIO_VSOCKETS=y from config.x86_64
> - vsock/bpf: move transport-related (e.g., if (!vsk->transport)) checks
>   out of fast path
> 
> Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
> ---
> Bobby Eshleman (3):
>       vsock: support sockmap
>       selftests/bpf: add vsock to vmtest.sh
>       selftests/bpf: Add a test case for vsock sockmap
> 
>  drivers/vhost/vsock.c                              |   1 +
>  include/linux/virtio_vsock.h                       |   1 +
>  include/net/af_vsock.h                             |  17 ++
>  net/vmw_vsock/Makefile                             |   1 +
>  net/vmw_vsock/af_vsock.c                           |  55 ++++++-
>  net/vmw_vsock/virtio_transport.c                   |   2 +
>  net/vmw_vsock/virtio_transport_common.c            |  24 +++
>  net/vmw_vsock/vsock_bpf.c                          | 175 +++++++++++++++++++++
>  net/vmw_vsock/vsock_loopback.c                     |   2 +
>  tools/testing/selftests/bpf/config.aarch64         |   2 +
>  tools/testing/selftests/bpf/config.s390x           |   3 +
>  tools/testing/selftests/bpf/config.x86_64          |   3 +
>  .../selftests/bpf/prog_tests/sockmap_listen.c      | 163 +++++++++++++++++++
>  13 files changed, 443 insertions(+), 6 deletions(-)
> ---
> base-commit: d83115ce337a632f996e44c9f9e18cadfcf5a094
> change-id: 20230118-support-vsock-sockmap-connectible-2e1297d2111a
> 
> Best regards,
> --
> Bobby Eshleman <bobby.eshleman@bytedance.com>
> 
> ---
> Bobby Eshleman (3):
>       vsock: support sockmap
>       selftests/bpf: add vsock to vmtest.sh
>       selftests/bpf: add a test case for vsock sockmap
> 
>  drivers/vhost/vsock.c                              |   1 +
>  include/linux/virtio_vsock.h                       |   1 +
>  include/net/af_vsock.h                             |  17 ++
>  net/vmw_vsock/Makefile                             |   1 +
>  net/vmw_vsock/af_vsock.c                           |  55 ++++++-
>  net/vmw_vsock/virtio_transport.c                   |   2 +
>  net/vmw_vsock/virtio_transport_common.c            |  25 +++
>  net/vmw_vsock/vsock_bpf.c                          | 174 +++++++++++++++++++++
>  net/vmw_vsock/vsock_loopback.c                     |   2 +
>  tools/testing/selftests/bpf/config.aarch64         |   2 +
>  tools/testing/selftests/bpf/config.s390x           |   3 +
>  tools/testing/selftests/bpf/config.x86_64          |   3 +
>  .../selftests/bpf/prog_tests/sockmap_listen.c      | 163 +++++++++++++++++++
>  13 files changed, 443 insertions(+), 6 deletions(-)
> ---
> base-commit: c2ea552065e43d05bce240f53c3185fd3a066204
> change-id: 20230227-vsock-sockmap-upstream-9d65c84174a2
> 
> Best regards,
> -- 
> Bobby Eshleman <bobby.eshleman@bytedance.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
