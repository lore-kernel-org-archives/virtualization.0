Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFA8225414
	for <virtualization@lists.linux.dev>; Mon, 10 Mar 2025 10:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741600895; cv=none; b=EE2MjB/NicyHzGLu97az6sHwhNQbQbgLhhKaW9+4i39kCE6e+6ukHAbWXox7YE1H86KTXm8BFdeznnIKzHUrU7WMmie4z3HrI69zTmjb098PlFSDCZ83tCmXKhzwEmHNkW1JkXVGmU/GazfCSfW1uxNphjtDOwmrN6STASuOzio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741600895; c=relaxed/simple;
	bh=kCptOO7WTS4D4pVelx8hJMiU7UV1dMk6cw8JtDE8HWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U6Vgai0ryUWXFXcrG8rDw83HD/0pTU2mI/qNvKQdABA3QfuII1eRUZH7pStSmQMIzGzZFIV3qhd/D6QlVtHlKIT3bxfc9U7nIjetD1FxsN2B65zKEbYsNTchGHnAR8suw1shURvX/8l1dAe6flt2xgXFZccyJ5QwwU/qoTynh5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LDwPMxQS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LDwPMxQS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741600891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xr9w71kjsM5Luuk2otd03enGGnFQEqtLlHU+jI22Q3c=;
	b=LDwPMxQS0zhE7kHPIjaIHW0FtbYNgb/fT5sXZLYCuvKZ2An1Qn1iAxlDf7LURSz0pNmYyl
	9Q1wp1ozKrH5nroi2Aya4A59Yf3dGgFvDrpq4CFcxaHHGnEOW8npJHSgBITBgpFnQp1tJ/
	rh3hep9vHwHSXD+hOwjBrhDutImsdqY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-SJaIbhwTN_Clh0Uso1dN-Q-1; Mon, 10 Mar 2025 06:01:29 -0400
X-MC-Unique: SJaIbhwTN_Clh0Uso1dN-Q-1
X-Mimecast-MFC-AGG-ID: SJaIbhwTN_Clh0Uso1dN-Q_1741600889
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac24c6d360aso341124166b.3
        for <virtualization@lists.linux.dev>; Mon, 10 Mar 2025 03:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741600888; x=1742205688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xr9w71kjsM5Luuk2otd03enGGnFQEqtLlHU+jI22Q3c=;
        b=P7ueM23f9xF7vQZfeUegAAFmjU8Ks8h/X/koRrJuyFVyO0K/DdUwPaXJ5EYgQg3LdD
         OCdHhIOgwgA+KUFtBdGP+vj7cceZt8m+w6grkTA/ZPd6DVtD9YQVaLtlqLs6HRNBwsfG
         61n2SKNlSQKR4/SxJJQzZChT4MRDQvWgTtWYL88RBmOriFEt8DD+FfY8twEyfPvE9zXN
         hQdj6NaoxrG8EgK/yMdNWOMiHkDbeif4flSsMrlAf66UE9z/oXYg2Vbg1cZnhMtO65/s
         87WGUKxUpxfnWaU/8TZpfLb9l37S0fF/a0dGfQAyBQePjgoza/Rz7KfFA+z9KI4AewJi
         W2Tw==
X-Forwarded-Encrypted: i=1; AJvYcCWiZ3aoRFg8MHJbczCqmL8ggDodWFUKsR3ogv/EkATO3HIUJCsFx8dhQgb0FHVgTHWEge+1LW9wAqForS2BKQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzT640CmHIiezrwbgu6x4WNevgl+fOEp3JvMznII3lrkacUh5EB
	Qv+PDDpBwW9G7d9qrzRBP0aOeIJvl+HXqASlfTbRPD4W0OTRdQmHY2o5A92Hu2sQhRy8MdSQiz3
	EYvHhwBPaDkvdmfHYRtBNpKnkh6WikxV0xzp9m0aDwrrwyA6+5VFsdxzNgLp6hYEFQ/dVxwQgYl
	eUjaQuAxR9tqclVx/95BYdd9Pg7FA3+MGQ/E5H3hQ=
X-Gm-Gg: ASbGncse2oRioHWa7moJUB1M4jgwRbqUTrf7tBBY7d56ks4rTvenreG127D9itCSIKb
	A5w2BthuHKPSVaTY7F9IY1EoK93EeXfy3DwJjjnzlRtWsXsswcp4Jj8M2yn5wzqzGTQExf3DVZg
	==
X-Received: by 2002:a17:907:a181:b0:ac2:7a3b:31ef with SMTP id a640c23a62f3a-ac27a3b4268mr710421466b.41.1741600888473;
        Mon, 10 Mar 2025 03:01:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuFnN7zPHPASajv3LwDLTFnpfckkATF6JYZEpa9/avX3UmTJtekiKHKEC/uww5oRaTbOZUYx11vHikxYga8mM=
X-Received: by 2002:a17:907:a181:b0:ac2:7a3b:31ef with SMTP id
 a640c23a62f3a-ac27a3b4268mr710417566b.41.1741600887976; Mon, 10 Mar 2025
 03:01:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250308214045.1160445-1-almasrymina@google.com>
In-Reply-To: <20250308214045.1160445-1-almasrymina@google.com>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 10 Mar 2025 18:00:51 +0800
X-Gm-Features: AQ5f1Jrkwm3AKULNqsZpquHRLDhQkbFM4PkLqf-j-uACY2HaSQ5keeelX2KkkPY
Message-ID: <CAPpAL=yPwCXONQfO4cZYt_j1CEt1=Yq6jDzqnc6udCTStM8exQ@mail.gmail.com>
Subject: Re: [PATCH net-next v7 0/9] Device memory TCP TX
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jeroen de Borst <jeroendb@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Mw6VyFIsTCSNtbGuwDJW3wkBFGYg9TFGStfVueCcfDw_1741600889
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

QE tested this series with virtio-net regression tests, everything works fi=
ne.

Tested-by: Lei Yang <leiyang@redhat.com>

On Sun, Mar 9, 2025 at 5:41=E2=80=AFAM Mina Almasry <almasrymina@google.com=
> wrote:
>
> v7: https://lore.kernel.org/netdev/20250227041209.2031104-1-almasrymina@g=
oogle.com/
> =3D=3D=3D
>
> Changelog:
> - Check the dmabuf net_iov binding belongs to the device the TX is going
>   out on. (Jakub)
> - Provide detailed inspection of callsites of
>   __skb_frag_ref/skb_page_unref in patch 2's changelog (Jakub)
>
> v6: https://lore.kernel.org/netdev/20250222191517.743530-1-almasrymina@go=
ogle.com/
> =3D=3D=3D
>
> v6 has no major changes. Addressed a few issues from Paolo and David,
> and collected Acks from Stan. Thank you everyone for the review!
>
> Changes:
> - retain behavior to process MSG_FASTOPEN even if the provided cmsg is
>   invalid (Paolo).
> - Rework the freeing of tx_vec slightly (it now has its own err label).
>   (Paolo).
> - Squash the commit that makes dmabuf unbinding scheduled work into the
>   same one which implements the TX path so we don't run into future
>   errors on bisecting (Paolo).
> - Fix/add comments to explain how dmabuf binding refcounting works
>   (David).
>
> v5: https://lore.kernel.org/netdev/20250220020914.895431-1-almasrymina@go=
ogle.com/
> =3D=3D=3D
>
> v5 has no major changes; it clears up the relatively minor issues
> pointed out to in v4, and rebases the series on top of net-next to
> resolve the conflict with a patch that raced to the tree. It also
> collects the review tags from v4.
>
> Changes:
> - Rebase to net-next
> - Fix issues in selftest (Stan).
> - Address comments in the devmem and netmem driver docs (Stan and Bagas)
> - Fix zerocopy_fill_skb_from_devmem return error code (Stan).
>
> v4: https://lore.kernel.org/netdev/20250203223916.1064540-1-almasrymina@g=
oogle.com/
> =3D=3D=3D
>
> v4 mainly addresses the critical driver support issue surfaced in v3 by
> Paolo and Stan. Drivers aiming to support netmem_tx should make sure not
> to pass the netmem dma-addrs to the dma-mapping APIs, as these dma-addrs
> may come from dma-bufs.
>
> Additionally other feedback from v3 is addressed.
>
> Major changes:
> - Add helpers to handle netmem dma-addrs. Add GVE support for
>   netmem_tx.
> - Fix binding->tx_vec not being freed on error paths during the
>   tx binding.
> - Add a minimal devmem_tx test to devmem.py.
> - Clean up everything obsolete from the cover letter (Paolo).
>
> v3: https://patchwork.kernel.org/project/netdevbpf/list/?series=3D929401&=
state=3D*
> =3D=3D=3D
>
> Address minor comments from RFCv2 and fix a few build warnings and
> ynl-regen issues. No major changes.
>
> RFC v2: https://patchwork.kernel.org/project/netdevbpf/list/?series=3D920=
056&state=3D*
> =3D=3D=3D=3D=3D=3D=3D
>
> RFC v2 addresses much of the feedback from RFC v1. I plan on sending
> something close to this as net-next  reopens, sending it slightly early
> to get feedback if any.
>
> Major changes:
> --------------
>
> - much improved UAPI as suggested by Stan. We now interpret the iov_base
>   of the passed in iov from userspace as the offset into the dmabuf to
>   send from. This removes the need to set iov.iov_base =3D NULL which may
>   be confusing to users, and enables us to send multiple iovs in the
>   same sendmsg() call. ncdevmem and the docs show a sample use of that.
>
> - Removed the duplicate dmabuf iov_iter in binding->iov_iter. I think
>   this is good improvment as it was confusing to keep track of
>   2 iterators for the same sendmsg, and mistracking both iterators
>   caused a couple of bugs reported in the last iteration that are now
>   resolved with this streamlining.
>
> - Improved test coverage in ncdevmem. Now multiple sendmsg() are tested,
>   and sending multiple iovs in the same sendmsg() is tested.
>
> - Fixed issue where dmabuf unmapping was happening in invalid context
>   (Stan).
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The TX path had been dropped from the Device Memory TCP patch series
> post RFCv1 [1], to make that series slightly easier to review. This
> series rebases the implementation of the TX path on top of the
> net_iov/netmem framework agreed upon and merged. The motivation for
> the feature is thoroughly described in the docs & cover letter of the
> original proposal, so I don't repeat the lengthy descriptions here, but
> they are available in [1].
>
> Full outline on usage of the TX path is detailed in the documentation
> included with this series.
>
> Test example is available via the kselftest included in the series as wel=
l.
>
> The series is relatively small, as the TX path for this feature largely
> piggybacks on the existing MSG_ZEROCOPY implementation.
>
> Patch Overview:
> ---------------
>
> 1. Documentation & tests to give high level overview of the feature
>    being added.
>
> 1. Add netmem refcounting needed for the TX path.
>
> 2. Devmem TX netlink API.
>
> 3. Devmem TX net stack implementation.
>
> 4. Make dma-buf unbinding scheduled work to handle TX cases where it gets
>    freed from contexts where we can't sleep.
>
> 5. Add devmem TX documentation.
>
> 6. Add scaffolding enabling driver support for netmem_tx. Add helpers, dr=
iver
> feature flag, and docs to enable drivers to declare netmem_tx support.
>
> 7. Guard netmem_tx against being enabled against drivers that don't
>    support it.
>
> 8. Add devmem_tx selftests. Add TX path to ncdevmem and add a test to
>    devmem.py.
>
> Testing:
> --------
>
> Testing is very similar to devmem TCP RX path. The ncdevmem test used
> for the RX path is now augemented with client functionality to test TX
> path.
>
> * Test Setup:
>
> Kernel: net-next with this RFC and memory provider API cherry-picked
> locally.
>
> Hardware: Google Cloud A3 VMs.
>
> NIC: GVE with header split & RSS & flow steering support.
>
> Performance results are not included with this version, unfortunately.
> I'm having issues running the dma-buf exporter driver against the
> upstream kernel on my test setup. The issues are specific to that
> dma-buf exporter and do not affect this patch series. I plan to follow
> up this series with perf fixes if the tests point to issues once they're
> up and running.
>
> Special thanks to Stan who took a stab at rebasing the TX implementation
> on top of the netmem/net_iov framework merged. Parts of his proposal [2]
> that are reused as-is are forked off into their own patches to give full
> credit.
>
> [1] https://lore.kernel.org/netdev/20240909054318.1809580-1-almasrymina@g=
oogle.com/
> [2] https://lore.kernel.org/netdev/20240913150913.1280238-2-sdf@fomichev.=
me/T/#m066dd407fbed108828e2c40ae50e3f4376ef57fd
>
> Cc: sdf@fomichev.me
> Cc: asml.silence@gmail.com
> Cc: dw@davidwei.uk
> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> Cc: Victor Nogueira <victor@mojatatu.com>
> Cc: Pedro Tammela <pctammela@mojatatu.com>
> Cc: Samiullah Khawaja <skhawaja@google.com>
>
>
> Mina Almasry (8):
>   netmem: add niov->type attribute to distinguish different net_iov
>     types
>   net: add get_netmem/put_netmem support
>   net: devmem: Implement TX path
>   net: add devmem TCP TX documentation
>   net: enable driver support for netmem TX
>   gve: add netmem TX support to GVE DQO-RDA mode
>   net: check for driver support in netmem TX
>   selftests: ncdevmem: Implement devmem TCP TX
>
> Stanislav Fomichev (1):
>   net: devmem: TCP tx netlink api
>
>  Documentation/netlink/specs/netdev.yaml       |  12 +
>  Documentation/networking/devmem.rst           | 150 ++++++++-
>  .../networking/net_cachelines/net_device.rst  |   1 +
>  Documentation/networking/netdev-features.rst  |   5 +
>  Documentation/networking/netmem.rst           |  23 +-
>  drivers/net/ethernet/google/gve/gve_main.c    |   4 +
>  drivers/net/ethernet/google/gve/gve_tx_dqo.c  |   8 +-
>  include/linux/netdevice.h                     |   2 +
>  include/linux/skbuff.h                        |  17 +-
>  include/linux/skbuff_ref.h                    |   4 +-
>  include/net/netmem.h                          |  38 ++-
>  include/net/sock.h                            |   1 +
>  include/uapi/linux/netdev.h                   |   1 +
>  net/core/datagram.c                           |  48 ++-
>  net/core/dev.c                                |  33 ++
>  net/core/devmem.c                             | 118 ++++++-
>  net/core/devmem.h                             |  83 ++++-
>  net/core/netdev-genl-gen.c                    |  13 +
>  net/core/netdev-genl-gen.h                    |   1 +
>  net/core/netdev-genl.c                        |  73 ++++-
>  net/core/skbuff.c                             |  48 ++-
>  net/core/sock.c                               |   6 +
>  net/ipv4/ip_output.c                          |   3 +-
>  net/ipv4/tcp.c                                |  50 ++-
>  net/ipv6/ip6_output.c                         |   3 +-
>  net/vmw_vsock/virtio_transport_common.c       |   5 +-
>  tools/include/uapi/linux/netdev.h             |   1 +
>  .../selftests/drivers/net/hw/devmem.py        |  26 +-
>  .../selftests/drivers/net/hw/ncdevmem.c       | 300 +++++++++++++++++-
>  29 files changed, 1002 insertions(+), 75 deletions(-)
>
>
> base-commit: 8ef890df4031121a94407c84659125cbccd3fdbe
> --
> 2.49.0.rc0.332.g42c0ae87b1-goog
>
>

