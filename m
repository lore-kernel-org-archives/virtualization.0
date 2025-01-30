Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB57E1AF0BA
	for <virtualization@lists.linux.dev>; Thu, 30 Jan 2025 21:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738271745; cv=none; b=tinWMRVIxE4R56t0Ebt5RhFzhTpGEWfxj2RCohDGiCMfW/Mg18WCMufG5g0Zz3yJPFxUb2H6R2uYzM2avgeEDUXwqtTtluUnvekPKDRvDshHyAf4o2IEbRYjqg8I9kIng6dtzJumniH9R6LxNdEQogFsMheFH2xxlddxx4rGhlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738271745; c=relaxed/simple;
	bh=AwWVGnUjXx8Wyr2wSxIpvnGC23tQdD0TlruChO0nSDk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NvjsgnpH3u9QDEakVo2sIXOgk2Fzss4rmneRUrI91iMq1wRaSfrvqkaf2wqwmg8nRmoWunYv9Apk/KzJY+utzCi1LpxS8O1mm5r2pJRX6aPRczVOsbSHJPtdULLGd9Nvkmykt9cqCymnKWqgHD76CseFTJT7nw7kSnontMbnD1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ojDD5Rys; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ojDD5Rys"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ee5668e09bso2482158a91.3
        for <virtualization@lists.linux.dev>; Thu, 30 Jan 2025 13:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738271743; x=1738876543; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w3LtRCOsgVaxwk2lW35j8j9VT58hbvzzlSooRGwM3eU=;
        b=ojDD5Rys3mAq1R3h53dhjhW68FJBZs1XZDyaOf7TvZKG+yxpuzi83Uslkzkl8ReEbR
         K82OHOBReafDyPGRRP2FU9SxXHyXSZggAoYAV0/ZvbNPGWyL/mOfD0N+Mur64t0lKm7s
         GMiJXn3wOrl5PuGHqpJyQIDBz12amQ8LJwE8JBYscCdmEZn/GQcdDEYVHPWJ5NLBipLH
         68yvCPyJgl4LpWTCYAyea2E/UYkDb0CFBgva7k//FUGN66pW7RDC6c26MJTlT5pmRImu
         3X6hPJbvqQMzz0x35YMEomfN3pVTYl6SkCselXYAv5+6OrkC5NVfDDV5bJ7yJEdMPqQ8
         R1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738271743; x=1738876543;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w3LtRCOsgVaxwk2lW35j8j9VT58hbvzzlSooRGwM3eU=;
        b=C2CKxfjC0Gm3ux0OJd1+hIikVynqiv32j9BVb4Tz5uQvNay6r9EERLpAeyfuWY++CN
         gu4qhJLj1LqrkGcil9sgXpMDQ7XqUzQ3tFGzsj4r9tJd+c36E7MJfP3Q+UsyFwADxqrU
         BQJwueGzDWkN1yXkSbWQAuZG73146VFhJa+DZsTSb4sXWCweM9GYDGaQwH7UmQlUiGQP
         qWkVGBcjXGcIwTL7LHCbWEvLFRujsUdl/mHAkvLlTsOJJCEiNQB9Lk39fmrG+8wzAdV5
         xCHpZRgsAGqi0j1gP5e9bYJnwb+EyHostARh8HzR6aoHH9sXacDaCQepBv/ABklVz4/B
         xdng==
X-Forwarded-Encrypted: i=1; AJvYcCW6k1OA5pOjkyuJoznQL6YWqulzCg40B+Y+WsSz/1s70KSOXO0AWuEcCUOV0Grxf9wYhzmhDDtbhm1V24MsUA==@lists.linux.dev
X-Gm-Message-State: AOJu0YznnBnreodJod+uS9BVlW7Kw+Odo/WcVtLOXVQGu295TZoIr2k7
	dLl0922xAqknnXQj5X+GUoJMjNvENSrKBSHIjHpadr6pzUpDdJEhoZUYzFBvpzTjzuiLwSF5JjW
	ES7SJ7FLpaH8jxDuoUrjTQw==
X-Google-Smtp-Source: AGHT+IFAUh3HgDFWfU9BpZZUgm7IQWEJxQLoEO7cPRsnwHf1sSQTIU5zqMQeWoi0D5sqPeyPGJf1oVuUeqG24fSw6A==
X-Received: from pjbpx16.prod.google.com ([2002:a17:90b:2710:b0:2ea:3a1b:f493])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5387:b0:2ee:5111:a54b with SMTP id 98e67ed59e1d1-2f83ac8ad6emr11624480a91.31.1738271742907;
 Thu, 30 Jan 2025 13:15:42 -0800 (PST)
Date: Thu, 30 Jan 2025 21:15:33 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250130211539.428952-1-almasrymina@google.com>
Subject: [PATCH RFC net-next v2 0/6] Device memory TCP TX
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	asml.silence@gmail.com, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"

RFC v2: https://patchwork.kernel.org/project/netdevbpf/list/?series=920056&state=*
=======

RFC v2 addresses much of the feedback from RFC v1. I plan on sending
something close to this as net-next  reopens, sending it slightly early
to get feedback if any.

Major changes:
--------------

- much improved UAPI as suggested by Stan. We now interpret the iov_base
  of the passed in iov from userspace as the offset into the dmabuf to
  send from. This removes the need to set iov.iov_base = NULL which may
  be confusing to users, and enables us to send multiple iovs in the
  same sendmsg() call. ncdevmem and the docs show a sample use of that.

- Removed the duplicate dmabuf iov_iter in binding->iov_iter. I think
  this is good improvment as it was confusing to keep track of
  2 iterators for the same sendmsg, and mistracking both iterators
  caused a couple of bugs reported in the last iteration that are now
  resolved with this streamlining.

- Improved test coverage in ncdevmem. Now muliple sendmsg() are tested,
  and sending multiple iovs in the same sendmsg() is tested.

- Fixed issue where dmabuf unmapping was happening in invalid context
  (Stan).

====================================================================

The TX path had been dropped from the Device Memory TCP patch series
post RFCv1 [1], to make that series slightly easier to review. This
series rebases the implementation of the TX path on top of the
net_iov/netmem framework agreed upon and merged. The motivation for
the feature is thoroughly described in the docs & cover letter of the
original proposal, so I don't repeat the lengthy descriptions here, but
they are available in [1].

Sending this series as RFC as the winder closure is immenient. I plan on
reposting as non-RFC once the tree re-opens, addressing any feedback
I receive in the meantime.

Full outline on usage of the TX path is detailed in the documentation
added in the first patch.

Test example is available via the kselftest included in the series as well.

The series is relatively small, as the TX path for this feature largely
piggybacks on the existing MSG_ZEROCOPY implementation.

Patch Overview:
---------------

1. Documentation & tests to give high level overview of the feature
   being added.

2. Add netmem refcounting needed for the TX path.

3. Devmem TX netlink API.

4. Devmem TX net stack implementation.

Testing:
--------

Testing is very similar to devmem TCP RX path. The ncdevmem test used
for the RX path is now augemented with client functionality to test TX
path.

* Test Setup:

Kernel: net-next with this RFC and memory provider API cherry-picked
locally.

Hardware: Google Cloud A3 VMs.

NIC: GVE with header split & RSS & flow steering support.

Performance results are not included with this version, unfortunately.
I'm having issues running the dma-buf exporter driver against the
upstream kernel on my test setup. The issues are specific to that
dma-buf exporter and do not affect this patch series. I plan to follow
up this series with perf fixes if the tests point to issues once they're
up and running.

Special thanks to Stan who took a stab at rebasing the TX implementation
on top of the netmem/net_iov framework merged. Parts of his proposal [2]
that are reused as-is are forked off into their own patches to give full
credit.

[1] https://lore.kernel.org/netdev/20240909054318.1809580-1-almasrymina@google.com/
[2] https://lore.kernel.org/netdev/20240913150913.1280238-2-sdf@fomichev.me/T/#m066dd407fbed108828e2c40ae50e3f4376ef57fd

Cc: sdf@fomichev.me
Cc: asml.silence@gmail.com
Cc: dw@davidwei.uk
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Victor Nogueira <victor@mojatatu.com>
Cc: Pedro Tammela <pctammela@mojatatu.com>


Mina Almasry (5):
  net: add devmem TCP TX documentation
  selftests: ncdevmem: Implement devmem TCP TX
  net: add get_netmem/put_netmem support
  net: devmem: Implement TX path
  net: devmem: make dmabuf unbinding scheduled work

Stanislav Fomichev (1):
  net: devmem: TCP tx netlink api

 Documentation/netlink/specs/netdev.yaml       |  12 +
 Documentation/networking/devmem.rst           | 144 ++++++++-
 include/linux/skbuff.h                        |  15 +-
 include/linux/skbuff_ref.h                    |   4 +-
 include/net/netmem.h                          |   3 +
 include/net/sock.h                            |   1 +
 include/uapi/linux/netdev.h                   |   1 +
 include/uapi/linux/uio.h                      |   6 +-
 net/core/datagram.c                           |  41 ++-
 net/core/devmem.c                             | 110 ++++++-
 net/core/devmem.h                             |  70 ++++-
 net/core/netdev-genl-gen.c                    |  13 +
 net/core/netdev-genl-gen.h                    |   1 +
 net/core/netdev-genl.c                        |  67 ++++-
 net/core/skbuff.c                             |  36 ++-
 net/core/sock.c                               |   8 +
 net/ipv4/tcp.c                                |  36 ++-
 net/vmw_vsock/virtio_transport_common.c       |   3 +-
 tools/include/uapi/linux/netdev.h             |   1 +
 .../selftests/drivers/net/hw/ncdevmem.c       | 276 +++++++++++++++++-
 20 files changed, 802 insertions(+), 46 deletions(-)

-- 
2.48.1.362.g079036d154-goog

