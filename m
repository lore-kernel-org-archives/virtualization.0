Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EE1166F0C
	for <virtualization@lists.linux-foundation.org>; Sat, 26 Jul 2025 05:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753509231; cv=none; b=Xkn+Im3EzJCQJt57zgGrT52c8pMBSysXJNTwC79MRevVnJIVLr2yLxWLAYuuCoyFufm1abTqJsO5QrREhfFvWfNpJKX8s9uKT7vEctGpyI3ca6yKECf1pIa3oPuXzdnU/hMNyq7IwTHA6DKR8fm6eB2ZfnNlGyyLPVmw5rK/MXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753509231; c=relaxed/simple;
	bh=qjAtuM6bjE5YOicSXvKnHeXz95Ueb3CFX9BTvqHz/ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kx9mln1umbpBKf1sHLRgoe4nvAkLY/zKYa4gK12AEJ2AIa9nqu6twFncCrAA1m++A+Q7OQlxolF/v3Mg3OElnAiC0reo59QS6vxBdxMAJOmAx2xbtYEuXojghCjM03IHpoLF6lyQsREfIsU8ntwRmQQlSdOfiVDvqnDkKTN+zSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCxAg9LI; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCxAg9LI"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 087D441783
	for <virtualization@lists.linux-foundation.org>; Sat, 26 Jul 2025 05:53:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0gT1mfoBVZOe for <virtualization@lists.linux-foundation.org>;
 Sat, 26 Jul 2025 05:53:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1129; helo=mail-yw1-x1129.google.com; envelope-from=ameryhung@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org DFCCB4177F
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DFCCB4177F
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=UCxAg9LI
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DFCCB4177F
	for <virtualization@lists.linux-foundation.org>; Sat, 26 Jul 2025 05:53:48 +0000 (UTC)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-712be7e034cso28515727b3.0
        for <virtualization@lists.linux-foundation.org>; Fri, 25 Jul 2025 22:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753509227; x=1754114027; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWn+ulxpcv7HdNLVJ+yLthV3Vv9Iaz7WMBgkwYUe3vQ=;
        b=UCxAg9LIGea4jWOKW95eqELvM/QMh0cKutaYYy+4uRuiyATFHOx6Qgh2KGzy4AfxGH
         wLtnd7vEDU/Td+Jf+usFynWpQhJsrYZ8VmDLeDkF0T67t1/VxBxPEIRkzPv2pvkfTZ47
         vFjyx4t9RA6gZcajimORW1qsGkk50nlLNljS0dOf5BEuw6TGbEqK88J4kjSdVoABQ7Ka
         b/ShBPeF4gGD+a4795w/4nf+VhinpdFSgWBJC1rC8Kwu7Z+qOERPrj4XLAq4Zwcoi9cB
         qUbqZdkfuXP1cAy/A693a2ziDDSLca93NGnTYyK8UnQZmbEjNsVi9KZSjdG8TGxvIloD
         DByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753509227; x=1754114027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWn+ulxpcv7HdNLVJ+yLthV3Vv9Iaz7WMBgkwYUe3vQ=;
        b=Ks+onb0VJKGxWI/yHZqHd5SgRYItWXBwkMYNP/ijfPWA8KTZIkWXJkyjzB84xf3F86
         /J3W4pk5BrNWDjQHUGrJejDUcZm4p3hF1ZGbFWvbMfkizJ1+5xeFQxk9SsXw1OGy11bR
         dBe8kjTa+QmW1CQ3psnDO8/7KvzsPaxXiD0kR2xrVDWSA6cCT80ihNhmOE922+oGmVxF
         Fwo2yOCHfatZFH00SllPtLG0k+WcjyvvQ7LeY3I4CoOrdAdCyGjNWKuS4n53cnC91Kl3
         7pCNt6fKgTkDCjmZAtKTz3fceCuJDZ4KPA0WrgNctgrN9NIINmePF6gf8o9HVJXFKAHV
         /h/w==
X-Forwarded-Encrypted: i=1; AJvYcCWXtm00SPoWgm1fz/4GY37UA6GoGNnisrsUNMtnbrL0hCsjvN4qElSatgG6fAblT37b+I1e0Mq2eaS0GeSoXg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxujPZdOBWlNK1fjrvcU3zecfF94HZLmAzHaSUUelb1+fosKV15
	cmLYfvrQ0geHCZYQiqQIwDNB95orbOMQs2dt98SNdGpYDDykzQzf0rbP+aDeKAIp00s23luk7Un
	8757yRJnQiyjeozYvWi4CT85M4KSRACY=
X-Gm-Gg: ASbGnctxUxpEMIBgvMGxh2ibflvdAPYlorZMAytv07o35SUqASaAVTrpmCRpRSWHZMW
	bQz6b0EqF6TlfsK+1euCkcEv0ZvkPr5LlzZKtzjwGPmTOV8QFGBmtzmTyjBwF0+43EBiCv+plw9
	ruUcvm2LqIdmeYuzWgTle+cZ5pCLG60QI49Ij3PbfTUB1Ehca1EAgQeaZ3f/zpIZilaKULJ2C2Q
	n8XFJmL7ACU9OEQdA==
X-Google-Smtp-Source: AGHT+IE0Lg8OC1qQflbm42pTUDEXQn5wEtvjZAGDRpEYT9WPYGJBWJxfXrPWc1WTljH0ya6XcqQMq2gpMQ7Ymg2lRdk=
X-Received: by 2002:a05:690c:e0a:b0:6ef:6d61:c254 with SMTP id
 00721157ae682-719e348e675mr51700067b3.38.1753509227288; Fri, 25 Jul 2025
 22:53:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240710212555.1617795-1-amery.hung@bytedance.com> <dsamf7k2byoflztkwya3smj7jyczyq7aludvd36lufdrboxdqk@u73iwrcyb5am>
In-Reply-To: <dsamf7k2byoflztkwya3smj7jyczyq7aludvd36lufdrboxdqk@u73iwrcyb5am>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 25 Jul 2025 22:53:35 -0700
X-Gm-Features: Ac12FXyMvpkfh1BVRP1lxRseahm_ttdL_F4ac_DTON4U9vvl5wd6WOkrVb-fPTk
Message-ID: <CAMB2axNKxW4gnd6qiSNYdm2zPxJkbbLgZz9P-Kh7SS0Sb1Yw=Q@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v6 00/14] virtio/vsock: support datagrams
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, kys@microsoft.com, haiyangz@microsoft.com, 
	wei.liu@kernel.org, decui@microsoft.com, bryantan@vmware.com, 
	vdasa@vmware.com, pv-drivers@vmware.com, dan.carpenter@linaro.org, 
	simon.horman@corigine.com, oxffffaa@gmail.com, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	bpf@vger.kernel.org, bobby.eshleman@bytedance.com, jiang.wang@bytedance.com, 
	amery.hung@bytedance.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 7:35=E2=80=AFAM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> Hi Amery,
>
> On Wed, Jul 10, 2024 at 09:25:41PM +0000, Amery Hung wrote:
> >Hey all!
> >
> >This series introduces support for datagrams to virtio/vsock.
>
> any update on v7 of this series?
>

Hi Stefano,

Sorry that I don't have personal time to work on v7. Since I don't
think people involved in this set are still working on it, I am
posting my v7 WIP here to see if anyone is interested in finishing it.
Would greatly appreciate any help.

Link: https://github.com/ameryhung/linux/tree/vsock-dgram-v7

Here are the things that I haven't address in the WIP:

01/14
- Arseniy suggested doing skb_put(dg->payload_size) and memcpy(dg->payload_=
size)

07/14
- Remove the double transport lookup in the send path by passing
transport to dgram_enqueue
- Address Arseniy's comment about updating vsock_virtio_transport_common.h

14/14
- Split test/vsock into smaller patches

Finally the spec change discussion also needs to happen.



> Thanks,
> Stefano
>
> >
> >It is a spin-off (and smaller version) of this series from the summer:
> >  https://lore.kernel.org/all/cover.1660362668.git.bobby.eshleman@byteda=
nce.com/
> >
> >Please note that this is an RFC and should not be merged until
> >associated changes are made to the virtio specification, which will
> >follow after discussion from this series.
> >
> >Another aside, the v4 of the series has only been mildly tested with a
> >run of tools/testing/vsock/vsock_test. Some code likely needs cleaning
> >up, but I'm hoping to get some of the design choices agreed upon before
> >spending too much time making it pretty.
> >
> >This series first supports datagrams in a basic form for virtio, and
> >then optimizes the sendpath for all datagram transports.
> >
> >The result is a very fast datagram communication protocol that
> >outperforms even UDP on multi-queue virtio-net w/ vhost on a variety
> >of multi-threaded workload samples.
> >
> >For those that are curious, some summary data comparing UDP and VSOCK
> >DGRAM (N=3D5):
> >
> >       vCPUS: 16
> >       virtio-net queues: 16
> >       payload size: 4KB
> >       Setup: bare metal + vm (non-nested)
> >
> >       UDP: 287.59 MB/s
> >       VSOCK DGRAM: 509.2 MB/s
> >
> >Some notes about the implementation...
> >
> >This datagram implementation forces datagrams to self-throttle according
> >to the threshold set by sk_sndbuf. It behaves similar to the credits
> >used by streams in its effect on throughput and memory consumption, but
> >it is not influenced by the receiving socket as credits are.
> >
> >The device drops packets silently.
> >
> >As discussed previously, this series introduces datagrams and defers
> >fairness to future work. See discussion in v2 for more context around
> >datagrams, fairness, and this implementation.
> >
> >Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
> >Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> >---
> >Changes in v6:
> >- allow empty transport in datagram vsock
> >- add empty transport checks in various paths
> >- transport layer now saves source cid and port to control buffer of skb
> >  to remove the dependency of transport in recvmsg()
> >- fix virtio dgram_enqueue() by looking up the transport to be used when
> >  using sendto(2)
> >- fix skb memory leaks in two places
> >- add dgram auto-bind test
> >- Link to v5: https://lore.kernel.org/r/20230413-b4-vsock-dgram-v5-0-581=
bd37fdb26@bytedance.com
> >
> >Changes in v5:
> >- teach vhost to drop dgram when a datagram exceeds the receive buffer
> >  - now uses MSG_ERRQUEUE and depends on Arseniy's zerocopy patch:
> >       "vsock: read from socket's error queue"
> >- replace multiple ->dgram_* callbacks with single ->dgram_addr_init()
> >  callback
> >- refactor virtio dgram skb allocator to reduce conflicts w/ zerocopy se=
ries
> >- add _fallback/_FALLBACK suffix to dgram transport variables/macros
> >- add WARN_ONCE() for table_size / VSOCK_HASH issue
> >- add static to vsock_find_bound_socket_common
> >- dedupe code in vsock_dgram_sendmsg() using module_got var
> >- drop concurrent sendmsg() for dgram and defer to future series
> >- Add more tests
> >  - test EHOSTUNREACH in errqueue
> >  - test stream + dgram address collision
> >- improve clarity of dgram msg bounds test code
> >- Link to v4: https://lore.kernel.org/r/20230413-b4-vsock-dgram-v4-0-0ce=
bbb2ae899@bytedance.com
> >
> >Changes in v4:
> >- style changes
> >  - vsock: use sk_vsock(vsk) in vsock_dgram_recvmsg instead of
> >    &sk->vsk
> >  - vsock: fix xmas tree declaration
> >  - vsock: fix spacing issues
> >  - virtio/vsock: virtio_transport_recv_dgram returns void because err
> >    unused
> >- sparse analysis warnings/errors
> >  - virtio/vsock: fix unitialized skerr on destroy
> >  - virtio/vsock: fix uninitialized err var on goto out
> >  - vsock: fix declarations that need static
> >  - vsock: fix __rcu annotation order
> >- bugs
> >  - vsock: fix null ptr in remote_info code
> >  - vsock/dgram: make transport_dgram a fallback instead of first
> >    priority
> >  - vsock: remove redundant rcu read lock acquire in getname()
> >- tests
> >  - add more tests (message bounds and more)
> >  - add vsock_dgram_bind() helper
> >  - add vsock_dgram_connect() helper
> >
> >Changes in v3:
> >- Support multi-transport dgram, changing logic in connect/bind
> >  to support VMCI case
> >- Support per-pkt transport lookup for sendto() case
> >- Fix dgram_allow() implementation
> >- Fix dgram feature bit number (now it is 3)
> >- Fix binding so dgram and connectible (cid,port) spaces are
> >  non-overlapping
> >- RCU protect transport ptr so connect() calls never leave
> >  a lockless read of the transport and remote_addr are always
> >  in sync
> >- Link to v2: https://lore.kernel.org/r/20230413-b4-vsock-dgram-v2-0-079=
cc7cee62e@bytedance.com
> >
> >
> >Bobby Eshleman (14):
> >  af_vsock: generalize vsock_dgram_recvmsg() to all transports
> >  af_vsock: refactor transport lookup code
> >  af_vsock: support multi-transport datagrams
> >  af_vsock: generalize bind table functions
> >  af_vsock: use a separate dgram bind table
> >  virtio/vsock: add VIRTIO_VSOCK_TYPE_DGRAM
> >  virtio/vsock: add common datagram send path
> >  af_vsock: add vsock_find_bound_dgram_socket()
> >  virtio/vsock: add common datagram recv path
> >  virtio/vsock: add VIRTIO_VSOCK_F_DGRAM feature bit
> >  vhost/vsock: implement datagram support
> >  vsock/loopback: implement datagram support
> >  virtio/vsock: implement datagram support
> >  test/vsock: add vsock dgram tests
> >
> > drivers/vhost/vsock.c                   |   62 +-
> > include/linux/virtio_vsock.h            |    9 +-
> > include/net/af_vsock.h                  |   24 +-
> > include/uapi/linux/virtio_vsock.h       |    2 +
> > net/vmw_vsock/af_vsock.c                |  343 ++++++--
> > net/vmw_vsock/hyperv_transport.c        |   13 -
> > net/vmw_vsock/virtio_transport.c        |   24 +-
> > net/vmw_vsock/virtio_transport_common.c |  188 ++++-
> > net/vmw_vsock/vmci_transport.c          |   61 +-
> > net/vmw_vsock/vsock_loopback.c          |    9 +-
> > tools/testing/vsock/util.c              |  177 +++-
> > tools/testing/vsock/util.h              |   10 +
> > tools/testing/vsock/vsock_test.c        | 1032 ++++++++++++++++++++---
> > 13 files changed, 1638 insertions(+), 316 deletions(-)
> >
> >--
> >2.20.1
> >
>
