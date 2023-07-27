Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F72C001DC
	for <virtualization@archiver.kernel.org>; Thu, 27 Jul 2023 07:51:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F2BFC83B12;
	Thu, 27 Jul 2023 07:51:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F2BFC83B12
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OB4ayp5m
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M3RF_Sq7pEp6; Thu, 27 Jul 2023 07:51:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 60F1783381;
	Thu, 27 Jul 2023 07:51:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 60F1783381
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 166C3C0072;
	Thu, 27 Jul 2023 07:51:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25598C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 07:51:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DEDD060DA5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 07:51:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DEDD060DA5
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OB4ayp5m
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jqKW3_aeuywf
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 07:51:54 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7473E60BCE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 07:51:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7473E60BCE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690444313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XGdpEGuVFC1LjQhQ41rFzUdSqbCmVBU7DHNo6fBlyec=;
 b=OB4ayp5mCsFkg9fNCQ+nEy4mrN7XRqHnUXJKNBj2M9JD0x5KNGXcS3Y08YvPODDdzT/oLw
 F1QmrdVjWr0MCTM0171VoJYDVbdvABDle9zgG+ELsxG9qIHYEk4fgZ+6SSg4QxYfgVA3mw
 gDioM5Me4dZRUqRuK15IGUznHGQlS2U=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-3uJOOseTPTajtst-3gE7Uw-1; Thu, 27 Jul 2023 03:51:49 -0400
X-MC-Unique: 3uJOOseTPTajtst-3gE7Uw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-52231d5eecdso381524a12.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 00:51:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690444308; x=1691049108;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XGdpEGuVFC1LjQhQ41rFzUdSqbCmVBU7DHNo6fBlyec=;
 b=Q1+WNLmEV6MVL7SRrqYMs6aX7PMsjOZBSwNR7GS8eYr5OjR92asUFu3PhhReXST2IE
 lHn/b9NwKRvGgIxE7vOnUo4/FKaAAUkzcnZE6MsCqdi8ye2+d4PBsbVcZVvzfbp7xjhs
 MyT9S/dHBDokEfqWrse1NmYPEPS+1w9nQqcWfUn4zEZ6jBnRecV5cHzJgnJuM2si/p0s
 eSfwf0WK0UDRY3XhISs9j5UCwZ9y4II2d5g9ze8EIXw+A1CxgoEf/dgZbOHHQgXbLVAl
 IPs6icP5OfmkCMUPNzS68zuIS7h6/ZMmmE8aOv3j15p42jsFigOqfoINeo4IQdpPUP4U
 tJLA==
X-Gm-Message-State: ABy/qLYj3Tp2lekiX8bv9gxfWrSIhlgJVw4wAmkQ1HPFTQJD4Hj74LID
 CR93heWHxa59Z3kSB1BEJX7gaT1InNAyAtiellhAxAlmrIwTwEFuda0JH/5NqmnSZmBRcVWdVD6
 ySe6jCl24/kpWWP85NVL+lJKzqgNUMaPMxpAGu6aeaQ==
X-Received: by 2002:aa7:c24c:0:b0:51e:1c18:dd99 with SMTP id
 y12-20020aa7c24c000000b0051e1c18dd99mr1107603edo.38.1690444308769; 
 Thu, 27 Jul 2023 00:51:48 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGKXV0ynY8e7V/b42V/35k2Q/0im3idioITFwhBKCnXqViZp+dS2Co3Ki/5u7d7K9vB+MC7cQ==
X-Received: by 2002:aa7:c24c:0:b0:51e:1c18:dd99 with SMTP id
 y12-20020aa7c24c000000b0051e1c18dd99mr1107573edo.38.1690444308402; 
 Thu, 27 Jul 2023 00:51:48 -0700 (PDT)
Received: from redhat.com ([2.52.14.22]) by smtp.gmail.com with ESMTPSA id
 l5-20020aa7d945000000b005223e54d1edsm336234eds.20.2023.07.27.00.51.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 00:51:47 -0700 (PDT)
Date: Thu, 27 Jul 2023 03:51:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: Re: [PATCH RFC net-next v5 00/14] virtio/vsock: support datagrams
Message-ID: <20230727035004-mutt-send-email-mst@kernel.org>
References: <20230413-b4-vsock-dgram-v5-0-581bd37fdb26@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20230413-b4-vsock-dgram-v5-0-581bd37fdb26@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-hyperv@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 kvm@vger.kernel.org, VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Simon Horman <simon.horman@corigine.com>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryantan@vmware.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Krasnov Arseniy <oxffffaa@gmail.com>,
 Vishnu Dasa <vdasa@vmware.com>, Jiang Wang <jiang.wang@bytedance.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
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

On Wed, Jul 19, 2023 at 12:50:04AM +0000, Bobby Eshleman wrote:
> Hey all!
> 
> This series introduces support for datagrams to virtio/vsock.
> 
> It is a spin-off (and smaller version) of this series from the summer:
>   https://lore.kernel.org/all/cover.1660362668.git.bobby.eshleman@bytedance.com/
> 
> Please note that this is an RFC and should not be merged until
> associated changes are made to the virtio specification, which will
> follow after discussion from this series.
> 
> Another aside, the v4 of the series has only been mildly tested with a
> run of tools/testing/vsock/vsock_test. Some code likely needs cleaning
> up, but I'm hoping to get some of the design choices agreed upon before
> spending too much time making it pretty.
> 
> This series first supports datagrams in a basic form for virtio, and
> then optimizes the sendpath for all datagram transports.
> 
> The result is a very fast datagram communication protocol that
> outperforms even UDP on multi-queue virtio-net w/ vhost on a variety
> of multi-threaded workload samples.
> 
> For those that are curious, some summary data comparing UDP and VSOCK
> DGRAM (N=5):
> 
> 	vCPUS: 16
> 	virtio-net queues: 16
> 	payload size: 4KB
> 	Setup: bare metal + vm (non-nested)
> 
> 	UDP: 287.59 MB/s
> 	VSOCK DGRAM: 509.2 MB/s
> 
> Some notes about the implementation...
> 
> This datagram implementation forces datagrams to self-throttle according
> to the threshold set by sk_sndbuf. It behaves similar to the credits
> used by streams in its effect on throughput and memory consumption, but
> it is not influenced by the receiving socket as credits are.
> 
> The device drops packets silently.
> 
> As discussed previously, this series introduces datagrams and defers
> fairness to future work. See discussion in v2 for more context around
> datagrams, fairness, and this implementation.

it's a big thread - can't you summarize here?


> Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>


could you give a bit more motivation? which applications do
you have in mind? for example, on localhost loopback datagrams
are actually reliable and a bunch of apps came to depend
on that even if they shouldn't.



> ---
> Changes in v5:
> - teach vhost to drop dgram when a datagram exceeds the receive buffer
>   - now uses MSG_ERRQUEUE and depends on Arseniy's zerocopy patch:
> 	"vsock: read from socket's error queue"
> - replace multiple ->dgram_* callbacks with single ->dgram_addr_init()
>   callback
> - refactor virtio dgram skb allocator to reduce conflicts w/ zerocopy series
> - add _fallback/_FALLBACK suffix to dgram transport variables/macros
> - add WARN_ONCE() for table_size / VSOCK_HASH issue
> - add static to vsock_find_bound_socket_common
> - dedupe code in vsock_dgram_sendmsg() using module_got var
> - drop concurrent sendmsg() for dgram and defer to future series
> - Add more tests
>   - test EHOSTUNREACH in errqueue
>   - test stream + dgram address collision
> - improve clarity of dgram msg bounds test code
> - Link to v4: https://lore.kernel.org/r/20230413-b4-vsock-dgram-v4-0-0cebbb2ae899@bytedance.com
> 
> Changes in v4:
> - style changes
>   - vsock: use sk_vsock(vsk) in vsock_dgram_recvmsg instead of
>     &sk->vsk
>   - vsock: fix xmas tree declaration
>   - vsock: fix spacing issues
>   - virtio/vsock: virtio_transport_recv_dgram returns void because err
>     unused
> - sparse analysis warnings/errors
>   - virtio/vsock: fix unitialized skerr on destroy
>   - virtio/vsock: fix uninitialized err var on goto out
>   - vsock: fix declarations that need static
>   - vsock: fix __rcu annotation order
> - bugs
>   - vsock: fix null ptr in remote_info code
>   - vsock/dgram: make transport_dgram a fallback instead of first
>     priority
>   - vsock: remove redundant rcu read lock acquire in getname()
> - tests
>   - add more tests (message bounds and more)
>   - add vsock_dgram_bind() helper
>   - add vsock_dgram_connect() helper
> 
> Changes in v3:
> - Support multi-transport dgram, changing logic in connect/bind
>   to support VMCI case
> - Support per-pkt transport lookup for sendto() case
> - Fix dgram_allow() implementation
> - Fix dgram feature bit number (now it is 3)
> - Fix binding so dgram and connectible (cid,port) spaces are
>   non-overlapping
> - RCU protect transport ptr so connect() calls never leave
>   a lockless read of the transport and remote_addr are always
>   in sync
> - Link to v2: https://lore.kernel.org/r/20230413-b4-vsock-dgram-v2-0-079cc7cee62e@bytedance.com
> 
> ---
> Bobby Eshleman (13):
>       af_vsock: generalize vsock_dgram_recvmsg() to all transports
>       af_vsock: refactor transport lookup code
>       af_vsock: support multi-transport datagrams
>       af_vsock: generalize bind table functions
>       af_vsock: use a separate dgram bind table
>       virtio/vsock: add VIRTIO_VSOCK_TYPE_DGRAM
>       virtio/vsock: add common datagram send path
>       af_vsock: add vsock_find_bound_dgram_socket()
>       virtio/vsock: add common datagram recv path
>       virtio/vsock: add VIRTIO_VSOCK_F_DGRAM feature bit
>       vhost/vsock: implement datagram support
>       vsock/loopback: implement datagram support
>       virtio/vsock: implement datagram support
> 
> Jiang Wang (1):
>       test/vsock: add vsock dgram tests
> 
>  drivers/vhost/vsock.c                   |  64 ++-
>  include/linux/virtio_vsock.h            |  10 +-
>  include/net/af_vsock.h                  |  14 +-
>  include/uapi/linux/virtio_vsock.h       |   2 +
>  net/vmw_vsock/af_vsock.c                | 281 ++++++++++---
>  net/vmw_vsock/hyperv_transport.c        |  13 -
>  net/vmw_vsock/virtio_transport.c        |  26 +-
>  net/vmw_vsock/virtio_transport_common.c | 190 +++++++--
>  net/vmw_vsock/vmci_transport.c          |  60 +--
>  net/vmw_vsock/vsock_loopback.c          |  10 +-
>  tools/testing/vsock/util.c              | 141 ++++++-
>  tools/testing/vsock/util.h              |   6 +
>  tools/testing/vsock/vsock_test.c        | 680 ++++++++++++++++++++++++++++++++
>  13 files changed, 1320 insertions(+), 177 deletions(-)
> ---
> base-commit: 37cadc266ebdc7e3531111c2b3304fa01b2131e8
> change-id: 20230413-b4-vsock-dgram-3b6eba6a64e5
> 
> Best regards,
> -- 
> Bobby Eshleman <bobby.eshleman@bytedance.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
