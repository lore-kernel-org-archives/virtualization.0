Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C7020FAAC
	for <virtualization@lists.linux.dev>; Mon,  3 Feb 2025 22:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738622360; cv=none; b=GrhIgTGeJMc893c7ntqotCEQPUr6i5U+vDJ8CO3WsmPo4S2x66MPWbyPmO1oWxbQG2PtyV7Ryy094NytdWiKOYDLzm6Glt8ubuurUBfZYpfMWQwVdSHVNFDsFfqGcOmavVfGKxXfFiWkC79zza7sE8eOieqv4UO4wVKL31nYdvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738622360; c=relaxed/simple;
	bh=8FA02/VlhFsavq77cgzUsZDA7wvbkIrTAbtsEWgl9+0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rEmSXgPJe+egBDUilASzivYE8JGKnuY6ug63vMrFP/gNKYUF37aMzx19cU8QbUkrWt9RVWRpbGQZJmIv0L1rTSPYGDCsusyvbxLjM0fNgjwO7kOr9rhtZayegfCNttpQVSBh34wIB58DUTnbZUnK3aHLFvspwdd0Ge5tQwr0EuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hOX0nGjH; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hOX0nGjH"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2163dc0f689so69926835ad.1
        for <virtualization@lists.linux.dev>; Mon, 03 Feb 2025 14:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738622358; x=1739227158; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DpVz/r6M+4jdUlj/0dtddbtyJ6bs+xAbBw0llf++aSI=;
        b=hOX0nGjHIACub5aI8m157gLqkF4SKjtS40ngC4uHIWA5KVbXuaZvJ1sIo4KnZ+IUr4
         kt0Gif5ZwGkNeDK0qv8SlqBWxNOlWUUlXIOjKNwu3Vzzuk3cQa+lJ67KPhYGVod/bQl6
         IbgrbQSsFUwNHidbyKkUKnbZqeqx/rk/cFJfCtGRV0XzRwATkRkSFDENrelNgsJI4EOp
         PZJlG1sZNr4azKtKposW/vYX+wuexryEMwLZv7O2DjdqR4WUSdpyGdzkJz1Xt2X/cEdq
         kFnNbVUWiXUlG2D4SrH19HakOpmwo8QYUhV73czyjLvl8JAQ/SwKU+O7vUv6r/UbFpB9
         UcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738622358; x=1739227158;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DpVz/r6M+4jdUlj/0dtddbtyJ6bs+xAbBw0llf++aSI=;
        b=JosahnY9q6nZdax1zhxbopeq0LCNvRUt5BfSvsysP1JESgK3wHmSm0yXyJF+JCpkS3
         TjFhYNlVfBi0j3+oxtHUFKO7vzl7lhktEF09UBxDnr1ISVRk2627P9n7mGN9AhWbvHEU
         /KVbkyb7m+L447nkeWcvVtI5Jzh6i+NYslFT4ldcosb1epIEz8fOTNY7evScjOXT9xVc
         B89HgSnkPl2UYahWB3jSHyO+KQo0OTLAyslIqNN9byokHhxJAja3sIsAk/tS41xwrRw9
         cylKerIDdQ7zKidhT0BKbje2rZTg+ImiZFUZbBw4ZAkx/XFLQck1xr1EoTz5NyB5aSQ2
         f+3A==
X-Forwarded-Encrypted: i=1; AJvYcCUsSZ4PBP0Bz+IF74p2ADFdgNKNmE3Y2Y3Vu1Iu8H6xO2xa7r423kpxB3NcucpvM5T4hKVGS6WflC5sJOZIhA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4S2BzUzuMk+QFGo+iKjWyv06FWJipfmnjxeW6YHeDmoi9yRqz
	VZjbXG6dcG98KZyRdjc3cEG7Ch3LGD5wZM0F7uICAro6lGqgpWdM0PXK/+OgbLg/ijCpjAvIrKU
	7epr93XXteOy06p3QBK939w==
X-Google-Smtp-Source: AGHT+IF97h5eMc5w+O4ZHZ7ijNLoTSeU5pPjnzCFRaJOKi+O14JUCiTrYoh8NH3BVvd4oKzPH0pY0w2f/PAfDZ65XA==
X-Received: from plbjz6.prod.google.com ([2002:a17:903:4306:b0:21d:de18:6ea9])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:fc4b:b0:215:72aa:693f with SMTP id d9443c01a7336-21dd7c44298mr388279915ad.9.1738622357760;
 Mon, 03 Feb 2025 14:39:17 -0800 (PST)
Date: Mon,  3 Feb 2025 22:39:10 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250203223916.1064540-1-almasrymina@google.com>
Subject: [PATCH net-next v3 0/6] Device memory TCP TX
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	asml.silence@gmail.com, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"

v3: https://patchwork.kernel.org/project/netdevbpf/list/?series=929401&state=*
===

Address minor comments from RFCv2 and fix a few build warnings and
ynl-regen issues. No major changes.

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
Cc: Samiullah Khawaja <skhawaja@google.com>


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
 net/core/devmem.c                             | 111 ++++++-
 net/core/devmem.h                             |  70 +++-
 net/core/netdev-genl-gen.c                    |  13 +
 net/core/netdev-genl-gen.h                    |   1 +
 net/core/netdev-genl.c                        |  66 +++-
 net/core/skbuff.c                             |  36 ++-
 net/core/sock.c                               |   8 +
 net/ipv4/tcp.c                                |  36 ++-
 net/vmw_vsock/virtio_transport_common.c       |   3 +-
 tools/include/uapi/linux/netdev.h             |   1 +
 .../selftests/drivers/net/hw/ncdevmem.c       | 300 +++++++++++++++++-
 20 files changed, 819 insertions(+), 53 deletions(-)

-- 
2.48.1.362.g079036d154-goog

