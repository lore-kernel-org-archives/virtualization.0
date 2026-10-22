Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792666088;
	b=GHlQAnTKOa5dN4moPwGtDfO3X3ODCs0VIyE0KPU91UDmBz+Rm+iKPC4BS0RE10Ap2QTC
	 TvQw6WXKufU1hno1yDwTRAUSX8+XkW1+5Vi1SD0gz/ijolbQV9oy8O0BDhVmQ/boUrJv6
	 JKUdK92IL9Bepb7O5Ee9FbtJVn7G1I98RHsW9z/ftIMyzIkpN2/Xv7heba1X5SQ6HFzmA
	 C3OBxezKJpG7S7UPNKK6+1bZXhAtHGY4c33xR3OlF0UUiFteh+UvZGZ2s/ZVKmdEC6fCl
	 BpHeuthBswWCE5Dx9A9ML+/Ot2VqwlcTJvnC5yw52amA+rsnZ2cDGQLGVE6dqcz3DYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792666088;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=pnQo4cYMZecwc7nbbDFejkNEidgj4FnFzcf+A96pm5M=;
	b=HAbZBCswNjsn1lQUzUBt27Va/l+ZFhOPCrQY748xQ7+3yFmcdRhJ1mj9FdZLRtLiHHrx
	 BU2fu5n0mPbF8gAenRYR9gUC9+G4mPWzd6Nd8mSb+VCHyHhlnaM39BRWqip9GdKUVCJGM
	 AiDbGXbxxDAFZBJeO1fId3SU6zqfKvLGl5MzqOJZZG8IniqYa/5NlvIicQYUCHBiOeFyN
	 ZSsP5WJydt+Ikk0xP1LVaf7vsuTCUfmqBSYj9ZuvTMYfKPJKc9CqEd29hnsnuRh3O4iZE
	 7BdUlpLDusOKFxSnLSY5iFmL8zqanbRtQtKt5VcVsJj47CdTPHoHpfvbq1NxePAajrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SvRrxam3;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108D0606A31A
	for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 10:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 108D0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SvRrxam3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792666085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pnQo4cYMZecwc7nbbDFejkNEidgj4FnFzcf+A96pm5M=;
	b=SvRrxam3o7kHNOTT5MbJNiJbFFGC/6aw8Yj0dH86PrXXfGk8r3Z7uOHLZneW4YfEbZkfOI
	CQclXhQUK/k4kuOIgqlMYyMt4ogsOsJRo3FVd/eWZOYDOUjqxR/fNqBhfdq+ajSoj4mGb9
	cVOfco71LSEg2eBVJ+Fcj//Aj4Fx/eQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-3C2hoFQwNmubbEmgaQ-d4A-1; Thu, 22 Oct 2026 06:48:04 -0400
X-MC-Unique: 3C2hoFQwNmubbEmgaQ-d4A-1
X-Mimecast-MFC-AGG-ID: 3C2hoFQwNmubbEmgaQ-d4A_1792666083
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48afcecb035so284041f8f.0
        for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 03:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792666083; x=1793270883;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pnQo4cYMZecwc7nbbDFejkNEidgj4FnFzcf+A96pm5M=;
        b=g7K6H7WlyP0OalUnZqjz5uEKyYEEdWNXEcYO2SvElYrdg1ZsuVo5iE4XNTEsWluNHo
         TcOo+v3NuSBO9/FGrvHAQh86IrrDaby2VrhbekVP9WQyuOQMIDpGxHT5NMEGXiR+jzs3
         LipxEfx5zFN2dndmodbGssCrake+lD+W8hKbtC+q2bokRsWBejJ/OB869LRak7OBaXoM
         RToW4jw+W7UCTDQmfkj3VxolpafRSTr8XvXrIcs/snD06t12u+9rp0dKXV1oxbctSoEg
         wL1Z7077+hYOz7aw/zlswAPVhimda7KEO7/ANz3EJS5b4ZICvNb/jPIPmBw5XiExusmK
         rjpw==
X-Forwarded-Encrypted: i=1; AKwUvBw/LhqkwNQINTtWGAs51OiwKr6yuqi/YUX28gBN0bQ8DK/hLslAfyU4Jq3f3qXU/dDs27WHgkY15leUYOWvuw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKrb+L6oGrLMopRFLSLBGG7mX8vgwIOo0Wdu7MhqpRhPxaLRLXy
	w5N8s4UzEnc9HfAjSohDI/KWYpxxjmb8t7Vjp65E1JK7ASU29vGHPPydD+ya9i2o3J/f9wdXrSY
	h2rL93DMgxBTu/wWB4OClSE89sUkZ7WdH3P8ZSHxYDb7jCL00JOJYISe33bepDfDk1HKk
X-Gm-Gg: AYBFou0whFv0LWfRSoy0flT+cc94R0TiWpjemWR3zrgtVXFPy5ZnJrjFC0cqsr2NEM3
	V57KZ6nhb6FJoS3ZqwhRQgcceI1sHIsY9wrM3dWsf1HEdZzZzN99uuDzzoIUVtngn26yNJuNJzC
	K+03mn1HIefmYSWqwPLhjleH/x9MIrDnTTdTHammMv2jMF1WPBLrN8k6PHANITvmMz/BMg4nMaX
	JG4sMISQopf1cz2aNKs8gluU4Q1ZGlRZt8Wf1wq+eKzdd1F1z4QsD8zMa880XyjWSE4v5L6onTp
	XWOiAgQQcFmflQPUXWEKT6hPuy0uXkHMRl5oZtmc2mCQAHWsOw7F4lzTK1lTyd5ftewSI+DOEL0
	qc7nNuw==
X-Received: by 2002:a05:6000:4211:b0:48e:d7c:4bc3 with SMTP id ffacd0b85a97d-48e2d269fe6mr4318239f8f.21.1792666082071;
        Thu, 22 Oct 2026 03:48:02 -0700 (PDT)
X-Received: by 2002:a05:6000:4211:b0:48e:d7c:4bc3 with SMTP id ffacd0b85a97d-48e2d269fe6mr4318146f8f.21.1792666081114;
        Thu, 22 Oct 2026 03:48:01 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.181.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25835404sm12988077f8f.42.2026.10.22.03.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 03:48:00 -0700 (PDT)
Date: Thu, 22 Oct 2026 12:47:54 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@kernel.org>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, sargun@sargun.me, jlinbox@meta.com
Subject: Re: [PATCH net-next v4 4/7] vsock: add a netlink command to assign
 the g2h device to a netns
Message-ID: <atnjOZjKUBagRVWq@sgarzare-redhat>
References: <20261020-vsock-guest-ns-v4-0-047527cfccfc@meta.com>
 <20261020-vsock-guest-ns-v4-4-047527cfccfc@meta.com>
 <atjZZP2ebhXKzMxL@sgarzare-redhat>
 <atld3+5LKmGxJ8+s@devvm29614.prn0.facebook.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <atld3+5LKmGxJ8+s@devvm29614.prn0.facebook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6rIJVSWqu9zCrxwYZCcI90FTYG_f5Qxls-3RUVzAE_E_1792666083
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Oct 21, 2026 at 05:50:39PM -0700, Bobby Eshleman wrote:
>On Wed, Oct 21, 2026 at 06:55:43PM +0200, Stefano Garzarella wrote:
>> On Tue, Oct 20, 2026 at 06:15:07PM -0700, Bobby Eshleman wrote:
>> > Namespaces let a host isolate a VM's vsock traffic to a specific
>> > namespace, but in a guest vsock traffic cannot be isolated to a
>> > namespace. The vsock device is hardcoded to global mode and can't be
>> > moved into a local-mode namespace.
>> >
>> > Introduce a vsock generic netlink family with VSOCK_CMD_DEV_NETNS_SET,
>> > which moves the device to the namespace the request was sent from.
>> >
>> > VSOCK_CMD_DEV_NETNS_GET reads the assignment back, reporting the
>> > namespace as an nsid relative to the caller. VSOCK_CMD_DEV_NETNS_SET
>> > replies with the same message.
>> >
>> > The command requires CAP_NET_ADMIN in the initial user namespace. A
>> > privileged user wishing to "unassign" the device can move it to the
>> > init_net, which is hardcoded to global mode (so no unassign call is
>> > necessary).
>> >
>> > Connected sockets are closed with ECONNRESET when the underlying device
>> > moves to a different namespace, so as to prevent reachability from the
>> > previous and now disallowed namespace.
>> >
>> > Device netns assignment is rejected when it would cause a CID collision
>>
>> I think it's pre-existing, and maybe we this change we are doing something
>> better to avoid collisions, but what happen after a live migration?
>>
>> virtio-vsock driver will receive VIRTIO_VSOCK_EVENT_TRANSPORT_RESET and
>> update it's own CID. This can collide with a nested VM, right?
>
>I'm not super familiar with how migrations handle vsock... do vmms
>sometimes change the CID during migration?

Yep, at least vitio-vsock supports it and define it into the spec.
After a migration the VMM should send VIRTIO_VSOCK_EVENT_TRANSPORT_RESET 
message in the event virtqueue and the driver should check if the CID is 
changed, and reset all the connections.

If you look at virtio_vsock_event_handle() in virtio_transport.c, the 
first step is to update the CID assigned to the guest.

>
>If so, then yes definitely can collide and I'm not sure about a good
>solution... we could add to the device a register to request the vmm
>pick another CID? or we could force the L2 VM to take another CID.

Me either, but it's pre-existing...

About request the vmm to pick another CID, we should update the spec I 
guess. The second option is interesting, but I think it will require 
some kind of live migration, right?

>Though any living socket would need to probably carry some sort of
>"vsk->forced_cid" or something so we could redirect those flows there
>instead... I don't know, not a fan of either. Any thoughts?
>
>We could also just tell the host which CIDs are in-use, but again,
>requires device or protocol changes.

Yeah, right.

In any case, this is pre-existing, so we should fix in another series.
Maybe we should stop to support CID assigned to the local host in 
loopback, but IIRC that was done to keep a pre-existing behavior.

>
>>
>>
>> > (e.g., moving a g2h device with CID 10 into a namespace with a nested
>> > H2G VM with CID 10). On namespace destruction, the netdev approach
>> > cannot be emulated. A netdev's IP addresses are removed before it
>> > returns to init_net, which makes an address collision impossible, but
>> > the vsock device keeps its CID. Instead, namespace destruction is
>> > deferred until the device has moved. Again, CAP_NET_ADMIN in the init
>> > user namespace is required for the assignment.
>> >
>> > Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>> > Link: https://lore.kernel.org/all/20200427142518.uwssa6dtasrp3bfc@steredhat/
>> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>> > ---
>> > Changes in v4:
>> > - Treat an unreachable g2h device as absent in vsock_use_local_transport(),
>> >  so a local ns can connect to the CID it reports as local (Sashiko)
>> > - Reset swept sockets under lock_sock() (Sashiko), and serialize assigns
>> >  with vsock_g2h_assign_mutex now that the sweep runs outside
>> >  vsock_register_mutex
>> >
>> > Changes in v3:
>> > - Try to use net_tracker when taking net references
>> > - Take a reference on the net when assigning a device to it. This keeps
>> >  the net alive even after deletion. Drop the concept of moving the
>> >  device back to init_net on net destruction. This avoids the problem
>> >  of the device CID colliding with a nested h2g CID.
>> > - Refuse the assign with -EADDRINUSE when a guest in the target netns
>> >  already answers to the device's CID, via the h2g transport's
>> >  ->has_remote_cid()
>> > - Hold vsock_register_mutex across the CID check and commit in
>> >  vhost_vsock_set_cid(), so it cannot race an assign. We also add a
>> >  lockdep assertion into vsock_find_cid() because it is a requirement to
>> >  avoid racing between netns assignment of a g2h device and setting a
>> >  nested h2g CID (I know, not ideal looking)
>> > - Unlink swept sockets from vsock_connected_table, so a retried
>> >  connect() cannot insert the same node twice
>> > - Drop the RST to the peer from the sweep, along with the ->reset op and
>> >  the pending_reset list (Sashiko)
>> > - Reply to VSOCK_CMD_DEV_NETNS_SET with the netns-id instead a plain ACK
>> >  (Sashiko)
>> >
>> > Changes in v2:
>> > - New patch, replaces the ioctl with a genl family and
>> >  VSOCK_CMD_DEV_NETNS_SET (Stefano)
>> > - Make netns_assign_allow a bool, not a callback (Stefano)
>> > - One vsock_netns_assignable(t) helper for both call sites (Stefano)
>> > - Make vsock_g2h_reachable_sk() static, drop the export (Stefano)
>> > - RST the peer when socket loses access to the device's net (Stefano)
>> > - Move the netns reset out of the sysctl exit hook, into the renamed
>> >  vsock_pernet_ops (Stefano).
>> > - Remove the synchronize_rcu() from the pernet exit path. The
>> >  net_namespace documentation states that synchronize_rcu() should be
>> >  avoided in the pernet exit path.
>> > - Run the socket reset in the pernet pre_exit() hook, as the
>> >  net_namespace management code (and documentation) guarantees
>> >  synchronize_rcu() between pre_exit() and exit()
>> > - Drop the conditional synchronize_rcu() in vsock_core_unregister()
>> >  (Stefano)
>> > - Specifically state "G2H transport" in the netns_assign_allow comment (Stefano)
>> > - Avoid leaking the g2h CID to a namespace that cannot reach it;
>> >  GET_LOCAL_CID, bind() and loopback transport selection all read it
>> >  through vsock_registered_transport_cid(), which now takes a netns
>> > - Add VSOCK_CMD_DEV_NETNS_GET
>> > ---
>> > Documentation/admin-guide/sysctl/net.rst |  42 +++
>> > Documentation/netlink/specs/vsock.yaml   |  75 +++++
>> > MAINTAINERS                              |   2 +
>> > drivers/vhost/vsock.c                    |  19 +-
>> > include/net/af_vsock.h                   |  13 +-
>> > include/uapi/linux/vsock.h               |  28 ++
>> > net/vmw_vsock/Makefile                   |   2 +-
>> > net/vmw_vsock/af_vsock.c                 | 479 +++++++++++++++++++++++++++++--
>> > net/vmw_vsock/vsock_nl_gen.c             |  36 +++
>> > net/vmw_vsock/vsock_nl_gen.h             |  20 ++
>> > tools/net/ynl/Makefile.deps              |   1 +
>> > 11 files changed, 693 insertions(+), 24 deletions(-)
>> >
>> > diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
>> > index fe43e8595958..eb60903e4eb2 100644
>> > --- a/Documentation/admin-guide/sysctl/net.rst
>> > +++ b/Documentation/admin-guide/sysctl/net.rst
>> > @@ -529,6 +529,48 @@ their hosts. The behavior of VSOCK sockets in a network namespace is determined
>> > by the namespace's mode (``global`` or ``local``), which controls how CIDs
>> > (Context IDs) are allocated and how sockets interact across namespaces.
>> >
>> > +In a guest, the vsock device owned by the guest-to-host (G2H) transport belongs
>> > +to one network namespace at a time. The ``VSOCK_CMD_DEV_NETNS_SET`` command of
>> > +the ``vsock`` netlink family, described in
>> > +Documentation/netlink/specs/vsock.yaml, moves it to the namespace the request
>> > +was sent from, which requires ``CAP_NET_ADMIN`` in the initial user namespace.
>> > +The namespace's mode decides who may then use the device:
>> > +
>> > +- ``global`` - every ``global`` mode namespace may use it.
>> > +- ``local`` - only that namespace may use it, which reserves the connection to
>> > +  the host for it alone.
>> > +
>> > +The device starts out in init_net, so until the command is issued nothing has
>> > +moved and no mode has changed.
>> > +
>> > +Support is transport dependent. A G2H transport that does not implement the
>> > +move refuses the command with ``EOPNOTSUPP``. Of the in-tree guest transports,
>> > +only virtio-vsock implements it.
>> > +
>> > +A namespace that cannot reach the device sees the vsock addresses it would see
>> > +if no G2H transport were loaded: the device's CID is not one of its local CIDs,
>> > +and with ``vsock_loopback`` loaded, ``VMADDR_CID_HOST`` (2) is served by
>> > +loopback.
>> > +
>> > +Connections established before the move, from a namespace that can no longer
>> > +reach the device, are closed with ``ECONNRESET``. Nothing is sent to the peer,
>> > +which is what already happens when the device is removed altogether: the peer
>> > +finds out on its next send, which no longer matches a socket and so is answered
>> > +with a reset. A peer that only receives waits for its own timeout. A connection
>> > +still being set up when the device moves is refused with a reset once the peer
>> > +answers it.
>> > +
>> > +An assignment keeps the namespace alive, the same way an open socket does, so
>> > +deleting that namespace does not move the device. Assigning the device to
>> > +another namespace, such as init_net, is the only way to undo an assignment, and
>> > +releases the reference the assignment held on the previous namespace.
>> > +
>> > +The move is refused with ``EADDRINUSE`` if a guest registered in the target
>> > +namespace already answers to the device's CID, since the CID would otherwise
>> > +name two different peers there. If a loaded H2G transport cannot check that,
>> > +the move is refused with ``EOPNOTSUPP``. Of the in-tree host transports, only
>> > +vhost-vsock can.
>> > +
>> > ns_mode
>> > -------
>> >
>> > diff --git a/Documentation/netlink/specs/vsock.yaml b/Documentation/netlink/specs/vsock.yaml
>> > new file mode 100644
>> > index 000000000000..74cf2472bf91
>> > --- /dev/null
>> > +++ b/Documentation/netlink/specs/vsock.yaml
>> > @@ -0,0 +1,75 @@
>> > +# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
>> > +#
>> > +# Copyright (c) 2026 Meta Platforms, Inc. and affiliates
>> > +#
>> > +---
>> > +name: vsock
>> > +
>> > +doc: |
>> > +  Control interface for the vsock (AF_VSOCK) core.
>> > +
>> > +protocol: genetlink
>> > +
>> > +uapi-header: linux/vsock.h
>> > +
>> > +attribute-sets:
>> > +  -
>> > +    name: vsock
>> > +    attributes:
>> > +      -
>> > +        name: netns-id
>> > +        type: s32
>> > +        doc: |
>> > +          Network namespace the guest's vsock device is assigned to, as an
>> > +          nsid relative to the caller.
>> > +
>> > +          Absent when the device is in the caller's own namespace, and
>> > +          NETNSA_NSID_NOT_ASSIGNED when the g2h transport supports netns
>> > +          assignment and the caller's namespace cannot reach the device under
>> > +          the mode rules, or when no nsid could be allocated for it.
>> > +
>> > +operations:
>> > +  list:
>> > +    -
>> > +      name: dev-netns-set
>> > +      doc: |
>> > +        Set the network namespace of the guest's vsock device.
>> > +
>> > +        The device is moved to the namespace the request was sent from. It
>> > +        starts out in init_net, and moving it back there is how an
>> > +        assignment is undone.
>> > +
>> > +        A g2h transport that does not support netns assignment returns
>> > +        EOPNOTSUPP. If the netns assignment would cause a CID collision, it
>> > +        is rejected with EADDRINUSE.
>> > +
>> > +        The namespace's mode decides who may then use the device: a global
>> > +        mode namespace shares it with every other global mode namespace,
>> > +        while a local mode namespace reserves it for itself.
>> > +
>> > +        Movement to an unreachable local namespace results in sockets being
>> > +        closed with ECONNRESET. Peers are not guaranteed to be notified via
>> > +        an RST.
>> > +
>> > +        The assignment holds a reference on the namespace.
>> > +      attribute-set: vsock
>> > +      flags: [admin-perm]
>> > +      do:
>> > +        reply:
>> > +          attributes:
>> > +            - netns-id
>> > +    -
>> > +      name: dev-netns-get
>> > +      doc: |
>> > +        Get the network namespace the guest's vsock device is assigned to.
>> > +
>> > +        The namespace is reported as an nsid relative to the caller, so the
>> > +        attribute is absent when the device is already in the caller's own
>> > +        namespace. If the g2h transport supports netns assignment, a caller
>> > +        whose namespace cannot reach the device is told
>> > +        NETNSA_NSID_NOT_ASSIGNED rather than where the device went.
>> > +      attribute-set: vsock
>> > +      do:
>> > +        reply:
>> > +          attributes:
>> > +            - netns-id
>>
>> Do you plan to extend some tools to support these new messages?
>
>In-tree ynl cli.py gets it for free, but planning to extend to `ip
>netns` (iproute2). I forgot to send and RFC to them, but will do
>alongside the next rev.

Great, thanks!

>
>>
>> > diff --git a/MAINTAINERS b/MAINTAINERS
>> > index 7636ab50d44f..6bca71c935cd 100644
>> > --- a/MAINTAINERS
>> > +++ b/MAINTAINERS
>> > @@ -29169,10 +29169,12 @@ M:	Stefano Garzarella <sgarzare@redhat.com>
>> > L:	virtualization@lists.linux.dev
>> > L:	netdev@vger.kernel.org
>> > S:	Maintained
>> > +F:	Documentation/netlink/specs/vsock.yaml
>> > F:	drivers/net/vsockmon.c
>> > F:	include/net/af_vsock.h
>> > F:	include/uapi/linux/vm_sockets.h
>> > F:	include/uapi/linux/vm_sockets_diag.h
>> > +F:	include/uapi/linux/vsock.h
>> > F:	include/uapi/linux/vsockmon.h
>> > F:	net/vmw_vsock/
>> > F:	tools/testing/selftests/vsock/
>> > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>> > index 01f8930ca51f..11893f1943c6 100644
>> > --- a/drivers/vhost/vsock.c
>> > +++ b/drivers/vhost/vsock.c
>> > @@ -815,6 +815,7 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
>> > static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
>> > {
>> > 	struct vhost_vsock *other;
>> > +	int ret;
>> >
>> > 	/* Refuse reserved CIDs */
>> > 	if (guest_cid <= VMADDR_CID_HOST ||
>> > @@ -828,15 +829,20 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
>> > 	/* Refuse if CID is assigned to the guest->host transport (i.e. nested
>> > 	 * VM), to make the loopback work.
>> > 	 */
>> > -	if (vsock_find_cid(guest_cid))
>> > -		return -EADDRINUSE;
>> > +	mutex_lock(&vsock_register_mutex);
>> > +
>> > +	if (__vsock_find_cid(vsock->net, guest_cid)) {
>>
>> So, IIUC now an L1 can assign the same CID assigned to itself to an L2, if
>> the G2H device is in another namespace, right?
>>
>> Would this make our life harder to handle move between namespaces of the
>> device?
>>
>> Can we just reserve it, so we can allow the device to be moved wherever?
>>
>> Maybe I'm missing some use case.
>
>That would make our lives easier for sure. My only concern is that a
>separate namespace that does not have g2h access could snoop the g2h CID
>by spamming vhost allocations until it finds the reserved one. I'd hate
>for that to show up as one of the sequence of steps an attacker used to
>exploit something... though I can't really identify the concrete risk.

Yeah, I don't see a real risk too.
If we want to simplify the code for now, we can do that, and support it 
later if we really have an use case.

If it does not simplify too much, maybe we can keep that. Up to you, was 
just an idea.

>
>>
>> > +		ret = -EADDRINUSE;
>> > +		goto unlock;
>> > +	}
>> >
>> > 	/* Refuse if CID is already in use */
>> > 	mutex_lock(&vhost_vsock_mutex);
>> > 	other = vhost_vsock_get(guest_cid, vsock->net);
>> > 	if (other && other != vsock) {
>> > 		mutex_unlock(&vhost_vsock_mutex);
>> > -		return -EADDRINUSE;
>> > +		ret = -EADDRINUSE;
>> > +		goto unlock;
>> > 	}
>> >
>> > 	if (vsock->guest_cid)
>> > @@ -846,7 +852,12 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
>> > 	hash_add_rcu(vhost_vsock_hash, &vsock->hash, vsock->guest_cid);
>> > 	mutex_unlock(&vhost_vsock_mutex);
>> >
>> > -	return 0;
>> > +	ret = 0;
>> > +
>> > +unlock:
>> > +	mutex_unlock(&vsock_register_mutex);
>> > +
>> > +	return ret;
>> > }
>> >
>> > static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
>> > diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>> > index 1c38a27fadf2..883a98dab36d 100644
>> > --- a/include/net/af_vsock.h
>> > +++ b/include/net/af_vsock.h
>> > @@ -9,6 +9,7 @@
>> > #define __AF_VSOCK_H__
>> >
>> > #include <linux/kernel.h>
>> > +#include <linux/mutex.h>
>> > #include <linux/workqueue.h>
>> > #include <net/netns/vsock.h>
>> > #include <net/sock.h>
>> > @@ -22,6 +23,7 @@
>> > extern struct list_head vsock_bind_table[VSOCK_HASH_SIZE + 1];
>> > extern struct list_head vsock_connected_table[VSOCK_HASH_SIZE];
>> > extern spinlock_t vsock_table_lock;
>> > +extern struct mutex vsock_register_mutex;
>> >
>> > #define vsock_sk(__sk)    ((struct vsock_sock *)__sk)
>> > #define sk_vsock(__vsk)   (&(__vsk)->sk)
>> > @@ -190,6 +192,9 @@ struct vsock_transport {
>> >
>> > 	/* Zero-copy. */
>> > 	bool (*msgzerocopy_allow)(void);
>> > +
>> > +	/* True if the G2H transport honours VSOCK_CMD_DEV_NETNS_SET. */
>> > +	bool netns_assign_allow;
>> > };
>> >
>> > /**** CORE ****/
>> > @@ -236,8 +241,14 @@ void vsock_remove_sock(struct vsock_sock *vsk);
>> > void vsock_for_each_connected_socket(const struct vsock_transport *transport,
>> > 				     void (*fn)(struct sock *sk));
>> > int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk);
>> > -bool vsock_find_cid(unsigned int cid);
>> > +bool vsock_find_cid(struct net *net, unsigned int cid);
>> > +/* Caller must hold vsock_register_mutex. */
>> > +bool __vsock_find_cid(struct net *net, unsigned int cid);
>> > void vsock_linger(struct sock *sk);
>> > +struct net *vsock_g2h_net_get(netns_tracker *tracker);
>> > +bool vsock_g2h_net_eq(const struct net *net);
>> > +bool vsock_g2h_net_reachable(struct net *net);
>> > +bool vsock_maybe_set_connected(struct vsock_sock *vsk);
>> >
>> > /**** TAP ****/
>> >
>> > diff --git a/include/uapi/linux/vsock.h b/include/uapi/linux/vsock.h
>> > new file mode 100644
>> > index 000000000000..803b9aa1f0b3
>> > --- /dev/null
>> > +++ b/include/uapi/linux/vsock.h
>>
>> Do we have options on file name, or is there a convention?
>>
>> I'm worried about linux/vsock.h is a bit too generic, maybe vsock_netlink.h
>> would be better or something like that.
>
>Yes no problem, vsock_netlink.h sounds good.

Good!

>
>>
>> > @@ -0,0 +1,28 @@
>> > +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
>> > +/* Do not edit directly, auto-generated from: */
>> > +/*	Documentation/netlink/specs/vsock.yaml */
>> > +/* YNL-GEN uapi header */
>> > +/* To regenerate run: tools/net/ynl/ynl-regen.sh */
>> > +
>> > +#ifndef _UAPI_LINUX_VSOCK_H
>> > +#define _UAPI_LINUX_VSOCK_H
>> > +
>> > +#define VSOCK_FAMILY_NAME	"vsock"
>> > +#define VSOCK_FAMILY_VERSION	1
>> > +
>> > +enum {
>> > +	VSOCK_A_NETNS_ID = 1,
>> > +
>> > +	__VSOCK_A_MAX,
>> > +	VSOCK_A_MAX = (__VSOCK_A_MAX - 1)
>> > +};
>> > +
>> > +enum {
>> > +	VSOCK_CMD_DEV_NETNS_SET = 1,
>> > +	VSOCK_CMD_DEV_NETNS_GET,
>> > +
>> > +	__VSOCK_CMD_MAX,
>> > +	VSOCK_CMD_MAX = (__VSOCK_CMD_MAX - 1)
>> > +};
>> > +
>> > +#endif /* _UAPI_LINUX_VSOCK_H */
>> > diff --git a/net/vmw_vsock/Makefile b/net/vmw_vsock/Makefile
>> > index 5da74c4a9f1d..97e2a559e2bf 100644
>> > --- a/net/vmw_vsock/Makefile
>> > +++ b/net/vmw_vsock/Makefile
>> > @@ -7,7 +7,7 @@ obj-$(CONFIG_VIRTIO_VSOCKETS_COMMON) += vmw_vsock_virtio_transport_common.o
>> > obj-$(CONFIG_HYPERV_VSOCKETS) += hv_sock.o
>> > obj-$(CONFIG_VSOCKETS_LOOPBACK) += vsock_loopback.o
>> >
>> > -vsock-y += af_vsock.o af_vsock_tap.o vsock_addr.o
>> > +vsock-y += af_vsock.o af_vsock_tap.o vsock_addr.o vsock_nl_gen.o
>> > vsock-$(CONFIG_BPF_SYSCALL) += vsock_bpf.o
>> >
>> > vsock_diag-y += diag.o
>> > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> > index c9b28e34b1b3..e16e72471b4a 100644
>> > --- a/net/vmw_vsock/af_vsock.c
>> > +++ b/net/vmw_vsock/af_vsock.c
>> > @@ -130,6 +130,27 @@
>> >  *       a different transport that *does* support local mode. For
>> >  *       example, virtio-vsock may not support local mode, but the socket
>> >  *       may still accept a connection from vhost-vsock which does.
>> > + *
>> > + * - A guest has a single vsock device, owned by the guest->host transport.
>> > + *   The VSOCK_CMD_DEV_NETNS_SET netlink command moves it to the namespace the
>> > + *   request was sent from. It starts out in init_net. The mode rules then
>> > + *   decide who may use it, and which namespace packets from the host are
>> > + *   delivered to:
>> > + *
>> > + *   - assigned to a global mode namespace - every global mode namespace may
>> > + *     use it. Until the command is issued nothing has moved and no mode has
>> > + *     changed, so the default is the behaviour that predates it.
>> > + *   - assigned to a local mode namespace - only that namespace may use it.
>> > + *     This is how a nested VM is isolated from the rest of the guest.
>> > + *
>> > + *   Connections made before an assignment, from a namespace that can no
>> > + *   longer reach the device, are closed with ECONNRESET. Nothing is sent to
>> > + *   the peer. As with device removal, it finds out on its next send.
>> > + *
>> > + *   The assignment holds a reference on the namespace, the way an open socket
>> > + *   does, so deleting that namespace does not move the device: its destruction
>> > + *   is deferred until the device moves to another namespace, on another
>> > + *   assignment or when the transport unregisters.
>> >  */
>> >
>> > #include <linux/compat.h>
>> > @@ -161,10 +182,14 @@
>> > #include <linux/workqueue.h>
>> > #include <net/sock.h>
>> > #include <net/af_vsock.h>
>> > +#include <linux/net_namespace.h>
>> > +#include <net/genetlink.h>
>> > #include <net/netns/vsock.h>
>> > #include <uapi/linux/vm_sockets.h>
>> > #include <uapi/asm-generic/ioctls.h>
>> >
>> > +#include "vsock_nl_gen.h"
>> > +
>> > #define VSOCK_NET_MODE_STR_GLOBAL "global"
>> > #define VSOCK_NET_MODE_STR_LOCAL "local"
>> >
>> > @@ -206,7 +231,21 @@ static const struct vsock_transport *transport_g2h;
>> > static const struct vsock_transport *transport_dgram;
>> > /* Transport used for local communication */
>> > static const struct vsock_transport *transport_local;
>> > -static DEFINE_MUTEX(vsock_register_mutex);
>> > +/* Protects transport registration and the g2h device's netns. */
>> > +DEFINE_MUTEX(vsock_register_mutex);
>> > +EXPORT_SYMBOL_GPL(vsock_register_mutex);
>>
>> Should we add some helpers instead of exporting the mutex?
>>
>> e.g. vsock_register_lock/unlock
>>
>> Now not sure about the "register", any other option?
>
>maybe vsock_cid_lock() and rename to vsock_cid_mutex?

I like this!

>
>It synchronizes with
>__vsock_find_cid()/__vsock_registered_transport_cid().
>
>>
>> > +
>> > +/* Network namespace of the g2h device. Protected by
>> > + * vsock_register_mutex/RCU.
>> > + */
>> > +static struct net __rcu *vsock_g2h_net = RCU_INITIALIZER(&init_net);
>> > +static netns_tracker vsock_g2h_net_tracker;
>> > +
>> > +/* Held across an assign's swap and reset sweep, so that a later assign cannot
>> > + * move the device back before the sweep has closed every socket that lost it.
>> > + * Must be taken before vsock_register_mutex.
>> > + */
>> > +static DEFINE_MUTEX(vsock_g2h_assign_mutex);
>> >
>> > /**** UTILS ****/
>> >
>> > @@ -553,7 +592,42 @@ void vsock_enqueue_accept(struct sock *listener, struct sock *connected)
>> > }
>> > EXPORT_SYMBOL_GPL(vsock_enqueue_accept);
>> >
>> > -static bool vsock_use_local_transport(unsigned int remote_cid)
>> > +/* Return true if @t honours namespace assignment. One that does not keeps the
>> > + * reachability rules it had before VSOCK_CMD_DEV_NETNS_SET existed.
>> > + */
>> > +static bool vsock_net_assignable(const struct vsock_transport *t)
>> > +{
>> > +	return t && t->netns_assign_allow;
>> > +}
>> > +
>> > +static bool vsock_g2h_unreachable(const struct vsock_transport *t,
>> > +				  struct net *net)
>> > +{
>> > +	return t == transport_g2h && vsock_net_assignable(t) &&
>> > +	       !vsock_g2h_net_reachable(net);
>> > +}
>> > +
>> > +/* Return the CID of the transport in @transport, as seen from @net.
>> > + *
>> > + * Returns VMADDR_CID_ANY if the transport supports net assignment but is not
>> > + * reachable from the net.
>> > + */
>> > +static u32
>> > +__vsock_registered_transport_cid(const struct vsock_transport **transport,
>> > +				 struct net *net)
>> > +{
>> > +	lockdep_assert_held(&vsock_register_mutex);
>> > +
>> > +	if (!*transport)
>> > +		return VMADDR_CID_ANY;
>> > +
>> > +	if (vsock_g2h_unreachable(*transport, net))
>> > +		return VMADDR_CID_ANY;
>> > +
>> > +	return (*transport)->get_local_cid();
>> > +}
>> > +
>> > +static bool vsock_use_local_transport(struct net *net, unsigned int remote_cid)
>> > {
>> > 	lockdep_assert_held(&vsock_register_mutex);
>> >
>> > @@ -563,11 +637,10 @@ static bool vsock_use_local_transport(unsigned int remote_cid)
>> > 	if (remote_cid == VMADDR_CID_LOCAL)
>> > 		return true;
>> >
>> > -	if (transport_g2h) {
>> > +	if (transport_g2h && !vsock_g2h_unreachable(transport_g2h, net))
>>
>> can we remove the `transport_g2h` in the condition?
>>
>> IIUC vsock_net_assignable() will do the same check, right?
>
>Ah yeah, good call.
>
>>
>> > 		return remote_cid == transport_g2h->get_local_cid();
>> > -	} else {
>> > -		return remote_cid == VMADDR_CID_HOST;
>> > -	}
>> > +
>> > +	return remote_cid == VMADDR_CID_HOST;
>> > }
>> >
>> > static void vsock_deassign_transport(struct vsock_sock *vsk)
>> > @@ -626,7 +699,7 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>> > 		break;
>> > 	case SOCK_STREAM:
>> > 	case SOCK_SEQPACKET:
>> > -		if (vsock_use_local_transport(remote_cid))
>> > +		if (vsock_use_local_transport(sock_net(sk), remote_cid))
>> > 			new_transport = transport_local;
>> > 		else if (remote_cid <= VMADDR_CID_HOST ||
>> > 			 (remote_flags & VMADDR_FLAG_TO_HOST))
>> > @@ -651,6 +724,11 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>> > 		goto err;
>> > 	}
>> >
>> > +	if (vsock_g2h_unreachable(new_transport, sock_net(sk))) {
>> > +		ret = -ENETUNREACH;
>> > +		goto err;
>> > +	}
>> > +
>> > 	if (vsk->transport && vsk->transport == new_transport) {
>> > 		ret = 0;
>> > 		goto err;
>> > @@ -717,21 +795,24 @@ EXPORT_SYMBOL_GPL(vsock_assign_transport);
>> >  * Provide safe access to static transport_{h2g,g2h,dgram,local} callbacks.
>> >  * Otherwise we may race with module removal. Do not use on `vsk->transport`.
>> >  */
>> > -static u32 vsock_registered_transport_cid(const struct vsock_transport **transport)
>> > +static u32
>> > +vsock_registered_transport_cid(const struct vsock_transport **transport,
>> > +			       struct net *net)
>> > {
>> > -	u32 cid = VMADDR_CID_ANY;
>> > +	u32 cid;
>> >
>> > 	mutex_lock(&vsock_register_mutex);
>> > -	if (*transport)
>> > -		cid = (*transport)->get_local_cid();
>> > +	cid = __vsock_registered_transport_cid(transport, net);
>> > 	mutex_unlock(&vsock_register_mutex);
>> >
>> > 	return cid;
>> > }
>> >
>> > -bool vsock_find_cid(unsigned int cid)
>> > +bool __vsock_find_cid(struct net *net, unsigned int cid)
>> > {
>> > -	if (cid == vsock_registered_transport_cid(&transport_g2h))
>> > +	lockdep_assert_held(&vsock_register_mutex);
>> > +
>> > +	if (cid == __vsock_registered_transport_cid(&transport_g2h, net))
>> > 		return true;
>> >
>> > 	if (transport_h2g && cid == VMADDR_CID_HOST)
>> > @@ -742,8 +823,303 @@ bool vsock_find_cid(unsigned int cid)
>> >
>> > 	return false;
>> > }
>> > +EXPORT_SYMBOL_GPL(__vsock_find_cid);
>> > +
>> > +bool vsock_find_cid(struct net *net, unsigned int cid)
>> > +{
>> > +	bool found;
>> > +
>> > +	mutex_lock(&vsock_register_mutex);
>> > +	found = __vsock_find_cid(net, cid);
>> > +	mutex_unlock(&vsock_register_mutex);
>> > +
>> > +	return found;
>> > +}
>> > EXPORT_SYMBOL_GPL(vsock_find_cid);
>> >
>> > +/* Return the namespace the g2h device is assigned to, with a reference held.
>> > + *
>> > + * The assignment itself holds a reference, so the namespace cannot be going
>> > + * away here and this never fails.
>> > + */
>> > +struct net *vsock_g2h_net_get(netns_tracker *tracker)
>> > +{
>> > +	struct net *net;
>> > +
>> > +	rcu_read_lock();
>> > +	net = rcu_dereference(vsock_g2h_net);
>> > +	get_net_track(net, tracker, GFP_ATOMIC);
>> > +	rcu_read_unlock();
>> > +
>> > +	return net;
>> > +}
>> > +EXPORT_SYMBOL_GPL(vsock_g2h_net_get);
>> > +
>> > +/* True if @net is still the namespace the device is assigned to. Cheap enough
>> > + * to call per packet on the RX path.
>> > + */
>> > +bool vsock_g2h_net_eq(const struct net *net)
>> > +{
>> > +	return rcu_access_pointer(vsock_g2h_net) == net;
>> > +}
>> > +EXPORT_SYMBOL_GPL(vsock_g2h_net_eq);
>> > +
>> > +bool vsock_g2h_net_reachable(struct net *net)
>> > +{
>> > +	bool reachable;
>> > +
>> > +	rcu_read_lock();
>> > +	reachable = vsock_net_check_mode(net, rcu_dereference(vsock_g2h_net));
>> > +	rcu_read_unlock();
>> > +
>> > +	return reachable;
>> > +}
>> > +EXPORT_SYMBOL_GPL(vsock_g2h_net_reachable);
>> > +
>> > +static bool vsock_g2h_reachable_sk(struct vsock_sock *vsk)
>> > +{
>> > +	if (!vsock_net_assignable(vsk->transport))
>> > +		return true;
>> > +
>> > +	return vsock_g2h_net_reachable(sock_net(sk_vsock(vsk)));
>> > +}
>> > +
>> > +/* Move @vsk to TCP_ESTABLISHED and into the connected table, unless the device
>> > + * has moved to a namespace @vsk cannot reach. Returns false without doing
>> > + * either in that case.
>> > + *
>> > + * The reset sweep walks the same table under the same lock, so an assign
>> > + * cannot land between the check and the insert: either the sweep finds @vsk
>> > + * and closes it, or @vsk is never added.
>> > + */
>> > +bool vsock_maybe_set_connected(struct vsock_sock *vsk)
>> > +{
>> > +	struct list_head *list;
>> > +	bool reachable;
>> > +
>> > +	list = vsock_connected_sockets(&vsk->remote_addr, &vsk->local_addr);
>> > +
>> > +	spin_lock_bh(&vsock_table_lock);
>> > +	reachable = vsock_g2h_reachable_sk(vsk);
>> > +	if (reachable) {
>> > +		sk_vsock(vsk)->sk_state = TCP_ESTABLISHED;
>> > +		__vsock_insert_connected(list, vsk);
>> > +	}
>> > +	spin_unlock_bh(&vsock_table_lock);
>> > +
>> > +	return reachable;
>> > +}
>> > +EXPORT_SYMBOL_GPL(vsock_maybe_set_connected);
>> > +
>> > +static bool vsock_g2h_should_reset(struct vsock_sock *vsk,
>> > +				   const struct vsock_transport *t)
>> > +{
>> > +	return vsk->transport == t &&
>> > +	       READ_ONCE(sk_vsock(vsk)->sk_state) != TCP_CLOSE &&
>> > +	       !READ_ONCE(vsk->close_work_scheduled) &&
>> > +	       !vsock_g2h_reachable_sk(vsk);
>> > +}
>> > +
>> > +static struct vsock_sock *
>> > +vsock_g2h_next_unreachable(const struct vsock_transport *t, unsigned int *i)
>> > +{
>> > +	struct vsock_sock *vsk;
>> > +
>> > +	spin_lock_bh(&vsock_table_lock);
>> > +
>> > +	for (; *i < ARRAY_SIZE(vsock_connected_table); (*i)++) {
>> > +		list_for_each_entry(vsk, &vsock_connected_table[*i],
>> > +				    connected_table) {
>> > +			if (vsock_g2h_should_reset(vsk, t)) {
>> > +				sock_hold(sk_vsock(vsk));
>> > +				spin_unlock_bh(&vsock_table_lock);
>> > +				return vsk;
>> > +			}
>> > +		}
>> > +	}
>> > +
>> > +	spin_unlock_bh(&vsock_table_lock);
>> > +
>> > +	return NULL;
>> > +}
>> > +
>> > +/* Close every connected socket of @t that can no longer reach the g2h device.
>> > + */
>> > +static void vsock_g2h_reset_unreachable(const struct vsock_transport *t)
>> > +{
>> > +	struct vsock_sock *vsk;
>> > +	unsigned int i = 0;
>> > +	struct sock *sk;
>> > +	bool reset;
>> > +
>> > +	lockdep_assert_held(&vsock_g2h_assign_mutex);
>> > +	lockdep_assert_not_held(&vsock_register_mutex);
>> > +
>> > +	while ((vsk = vsock_g2h_next_unreachable(t, &i))) {
>>
>> can we reuse vsock_for_each_connected_socket() ?
>>
>> If not, maybe a comment here will be nice and maybe I'll try to merge
>> vsock_g2h_next_unreachable() here if it's not used somewhere else.
>
>I think we would need a variant that returns the socket, since we need
>to be able to acquire the lock_sock after releasing the
>vsock_table_lock.

That would be nice if it's not too complicated.

>
>Maybe the callback could return a bool, if true then return socket
>otherwise skip. Then the cb could also grab the sock_hold ref under the
>table lock.

Yeah, looks promising to me!

>
>>
>> I find these functions a bit hard to read.
>
>Yeah its all kind of a pain. The problem is that we need to hold
>sock_lock to set sk_state and sk_err, but can't acquire it under the
>table lock. Instead, we grab the socket ref sock_hold under the table
>lock to guarantee it stays alive between releasing the table lock and
>grabbing the socket lock.
>
>I was really tempted to not do this lock_sock dance though. The race
>condition I'm avoiding here is that if this reset races with an RST
>receive, then the socket could end up with TCP_CLOSING + sk_err
>ECONNRESET... but I'm not sure this actually propagates up into a real
>problem for any potential user.
>
>It also avoided some racing with the tx path, but now that send_pkt()
>also checks reachability I think that path is safe.
>
>What do you think about doing the below hunk (TCP_CLOSE, ECONNRESET,
>sk_error_report) with no lock_sock?

Looking at the code, it seems that in all the places where we close all 
connections (virtio_vsock_reset_sock, vhost_vsock_reset_orphans) we do 
with no lock_sock but with vsock_table_lock.

So, makes sense to me.

>
>
>>
>> > +		sk = sk_vsock(vsk);
>> > +
>> > +		lock_sock(sk);
>> > +
>> > +		reset = false;
>> > +		spin_lock_bh(&vsock_table_lock);
>> > +		if (__vsock_in_connected_table(vsk) &&
>> > +		    vsock_g2h_should_reset(vsk, t)) {
>> > +			__vsock_remove_connected(vsk);
>> > +			reset = true;
>> > +		}
>> > +		spin_unlock_bh(&vsock_table_lock);
>> > +
>> > +		if (reset) {
>> > +			sk->sk_state = TCP_CLOSE;
>> > +			sk->sk_err = ECONNRESET;
>> > +			sk_error_report(sk);
>> > +		}
>> > +
>> > +		release_sock(sk);
>> > +		sock_put(sk);
>> > +	}
>> > +}
>> > +
>> > +/* Point the g2h device at @net, taking the reference that keeps @net alive,
>> > + * and return the namespace it leaves behind.
>> > + */
>> > +static struct net *vsock_g2h_net_swap(struct net *net, netns_tracker *old)
>> > +{
>> > +	lockdep_assert_held(&vsock_register_mutex);
>> > +
>> > +	*old = vsock_g2h_net_tracker;
>> > +	get_net_track(net, &vsock_g2h_net_tracker, GFP_KERNEL);
>> > +
>> > +	return rcu_replace_pointer(vsock_g2h_net, net,
>> > +				   lockdep_is_held(&vsock_register_mutex));
>> > +}
>> > +
>> > +/* Drop the namespace the device just left, once the readers that may still
>> > + * see it in vsock_g2h_net_get() are gone. Runs without the mutex held.
>> > + */
>> > +static void vsock_g2h_net_release(struct net *old, netns_tracker *tracker)
>> > +{
>> > +	synchronize_rcu();
>> > +	put_net_track(old, tracker);
>> > +}
>> > +
>> > +static int vsock_nl_dev_netns_fill(struct sk_buff *msg, struct genl_info *info)
>> > +{
>> > +	struct net *net = genl_info_net(info);
>> > +	struct net *assigned;
>> > +	bool equal;
>> > +	void *hdr;
>> > +	s32 id;
>> > +
>> > +	lockdep_assert_held(&vsock_register_mutex);
>> > +
>> > +	rcu_read_lock();
>>
>> Why we need the rcu lock if vsock_register_mutex is held ?
>
>We don't now, will remove. Back in v2 we used it to guarantee the
>non-null vsock_g2h_net was still available to check the mode even if
>maybe_get_net() returned NULL... and accidentally carried it forward.
>
>>
>> > +	assigned = rcu_dereference(vsock_g2h_net);
>> > +	equal = net_eq(net, assigned);
>> > +	if (!equal) {
>> > +		if (vsock_net_assignable(transport_g2h) &&
>> > +		    !vsock_net_check_mode(net, assigned))
>> > +			id = NETNSA_NSID_NOT_ASSIGNED;
>> > +		else
>> > +			id = peernet2id_alloc(net, assigned, GFP_ATOMIC);
>> > +	}
>> > +	rcu_read_unlock();
>> > +
>> > +	hdr = genlmsg_iput(msg, info);
>> > +	if (!hdr)
>> > +		return -EMSGSIZE;
>> > +
>> > +	if (!equal && nla_put_s32(msg, VSOCK_A_NETNS_ID, id)) {
>> > +		genlmsg_cancel(msg, hdr);
>> > +		return -EMSGSIZE;
>> > +	}
>> > +
>> > +	genlmsg_end(msg, hdr);
>> > +
>> > +	return 0;
>> > +}
>> > +
>> > +/* Move the g2h device to @net, which keeps @net alive until the device leaves
>> > + * again. Returns -ENODEV if no g2h transport is loaded, -EOPNOTSUPP if the
>> > + * loaded one cannot be moved, and -EADDRINUSE if a guest in @net already uses
>> > + * the device's CID.
>> > + */
>> > +static int vsock_g2h_net_assign(struct net *net, struct sk_buff *msg,
>> > +				struct genl_info *info)
>> > +{
>> > +	struct netlink_ext_ack *extack = info->extack;
>> > +	const struct vsock_transport *t;
>> > +	netns_tracker old_tracker;
>> > +	struct net *old;
>> > +	void *hdr;
>> > +	int ret;
>> > +
>>
>> I'd add here a comment about lock ordering here, and why this is safe.
>>
>> Oh, we have on top, so maybe we can avoid.
>
>Maybe move the comment here?

Or keep on top and add another here. Or put a reference here to the 
comment on top. Up to you ;-)

Thanks,
Stefano

>
>>
>> > +	mutex_lock(&vsock_g2h_assign_mutex);
>> > +	mutex_lock(&vsock_register_mutex);
>> > +
>> > +	ret = -ENODEV;
>> > +	if (!transport_g2h) {
>> > +		NL_SET_ERR_MSG(extack, "no guest-to-host transport is loaded");
>> > +		goto unlock;
>> > +	}
>> > +
>> > +	ret = -EOPNOTSUPP;
>> > +	if (!vsock_net_assignable(transport_g2h)) {
>> > +		NL_SET_ERR_MSG(extack,
>> > +			       "the loaded guest-to-host transport does not support namespace assignment");
>> > +		goto unlock;
>> > +	}
>> > +
>> > +	if (transport_h2g && !transport_h2g->has_remote_cid) {
>> > +		NL_SET_ERR_MSG(extack,
>> > +			       "the loaded host-to-guest transport cannot check the device's CID");
>> > +		goto unlock;
>> > +	}
>> > +
>> > +	ret = -EADDRINUSE;
>> > +	if (transport_h2g &&
>> > +	    transport_h2g->has_remote_cid(net,
>> > +					  transport_g2h->get_local_cid())) {
>> > +		NL_SET_ERR_MSG(extack,
>> > +			       "a guest in the target namespace already uses the device's CID");
>> > +		goto unlock;
>> > +	}
>> > +
>> > +	ret = -EMSGSIZE;
>> > +	hdr = genlmsg_iput(msg, info);
>> > +	if (!hdr)
>> > +		goto unlock;
>> > +	genlmsg_end(msg, hdr);
>> > +
>> > +	ret = genlmsg_reply(msg, info);
>> > +	msg = NULL;
>> > +	if (ret)
>> > +		goto unlock;
>> > +
>> > +	old = vsock_g2h_net_swap(net, &old_tracker);
>>
>> From LLM reviewing, please help to check since I know very little about
>> netlink:
>>
>> Why is a reply needed here? It is always empty: after a successful SET
>> the device is in the caller's netns, so netns-id is never included, yet
>> the spec declares it in the reply.
>>
>> Sending it before the swap also means a full receive buffer (-EAGAIN)
>> makes the assign fail.
>>
>> Suggestion: drop the reply (both in the spec and here) and rely on the
>> netlink ack, like the other *-set ops do (netdev napi-set, dpll pin-set,
>> devlink param-set, etc.). The state can be read back with GET. This
>> would also remove the need for the msg/info parameters in
>> vsock_g2h_net_assign().
>
>This makes sense and is much better.
>
>>
>> Thanks,
>> Stefano
>>
>> > +	t = transport_g2h;
>> > +
>> > +	mutex_unlock(&vsock_register_mutex);
>> > +
>> > +	/* See vsock_maybe_set_connected() comment about synchronizing with
>> > +	 * connecting sockets.
>> > +	 */
>> > +	vsock_g2h_reset_unreachable(t);
>> > +
>> > +	mutex_unlock(&vsock_g2h_assign_mutex);
>> > +
>> > +	vsock_g2h_net_release(old, &old_tracker);
>> > +
>> > +	return 0;
>> > +
>> > +unlock:
>> > +	mutex_unlock(&vsock_register_mutex);
>> > +	mutex_unlock(&vsock_g2h_assign_mutex);
>> > +	nlmsg_free(msg);
>> > +
>> > +	return ret;
>> > +}
>> > +
>> > static struct sock *vsock_dequeue_accept(struct sock *listener)
>> > {
>> > 	struct vsock_sock *vlistener;
>> > @@ -910,7 +1286,8 @@ static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr)
>> > 	 * like AF_INET prevents binding to a non-local IP address (in most
>> > 	 * cases), we only allow binding to a local CID.
>> > 	 */
>> > -	if (addr->svm_cid != VMADDR_CID_ANY && !vsock_find_cid(addr->svm_cid))
>> > +	if (addr->svm_cid != VMADDR_CID_ANY &&
>> > +	    !vsock_find_cid(sock_net(sk_vsock(vsk)), addr->svm_cid))
>> > 		return -EADDRNOTAVAIL;
>> >
>> > 	switch (sk->sk_socket->type) {
>> > @@ -2798,6 +3175,7 @@ static long vsock_dev_do_ioctl(struct file *filp,
>> > {
>> > 	u32 __user *p = ptr;
>> > 	int retval = 0;
>> > +	struct net *net;
>>
>> reverse xmas tree
>
>Roger that.
>
>
>Thanks!
>
>-Bobby
>
>>
>> > 	u32 cid;
>> >
>> > 	switch (cmd) {
>> > @@ -2805,11 +3183,14 @@ static long vsock_dev_do_ioctl(struct file *filp,
>> > 		/* To be compatible with the VMCI behavior, we prioritize the
>> > 		 * guest CID instead of well-know host CID (VMADDR_CID_HOST).
>> > 		 */
>> > -		cid = vsock_registered_transport_cid(&transport_g2h);
>> > +		net = current->nsproxy->net_ns;
>> > +		cid = vsock_registered_transport_cid(&transport_g2h, net);
>> > 		if (cid == VMADDR_CID_ANY)
>> > -			cid = vsock_registered_transport_cid(&transport_h2g);
>> > +			cid = vsock_registered_transport_cid(&transport_h2g,
>> > +							     net);
>> > 		if (cid == VMADDR_CID_ANY)
>> > -			cid = vsock_registered_transport_cid(&transport_local);
>> > +			cid = vsock_registered_transport_cid(&transport_local,
>> > +							     net);
>> >
>> > 		if (put_user(cid, p) != 0)
>> > 			retval = -EFAULT;
>> > @@ -2850,6 +3231,44 @@ static struct miscdevice vsock_device = {
>> > 	.fops		= &vsock_device_ops,
>> > };
>> >
>> > +int vsock_nl_dev_netns_get_doit(struct sk_buff *skb, struct genl_info *info)
>> > +{
>> > +	struct sk_buff *msg;
>> > +	int err;
>> > +
>> > +	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
>> > +	if (!msg)
>> > +		return -ENOMEM;
>> > +
>> > +	mutex_lock(&vsock_register_mutex);
>> > +	if (transport_g2h) {
>> > +		err = vsock_nl_dev_netns_fill(msg, info);
>> > +	} else {
>> > +		NL_SET_ERR_MSG(info->extack,
>> > +			       "no guest-to-host transport is loaded");
>> > +		err = -ENODEV;
>> > +	}
>> > +	mutex_unlock(&vsock_register_mutex);
>> > +
>> > +	if (err) {
>> > +		nlmsg_free(msg);
>> > +		return err;
>> > +	}
>> > +
>> > +	return genlmsg_reply(msg, info);
>> > +}
>> > +
>> > +int vsock_nl_dev_netns_set_doit(struct sk_buff *skb, struct genl_info *info)
>> > +{
>> > +	struct sk_buff *msg;
>> > +
>> > +	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
>> > +	if (!msg)
>> > +		return -ENOMEM;
>> > +
>> > +	return vsock_g2h_net_assign(genl_info_net(info), msg, info);
>> > +}
>> > +
>> > static int __vsock_net_mode_string(const struct ctl_table *table, int write,
>> > 				   void *buffer, size_t *lenp, loff_t *ppos,
>> > 				   enum vsock_net_mode mode,
>> > @@ -3065,6 +3484,8 @@ static int __init vsock_init(void)
>> >
>> > 	vsock_init_tables();
>> >
>> > +	get_net_track(&init_net, &vsock_g2h_net_tracker, GFP_KERNEL);
>> > +
>> > 	vsock_proto.owner = THIS_MODULE;
>> > 	vsock_device.minor = MISC_DYNAMIC_MINOR;
>> > 	err = misc_register(&vsock_device);
>> > @@ -3091,10 +3512,18 @@ static int __init vsock_init(void)
>> > 		goto err_unregister_sock;
>> > 	}
>> >
>> > +	err = genl_register_family(&vsock_nl_family);
>> > +	if (err) {
>> > +		pr_err("Cannot register vsock netlink family: %d\n", err);
>> > +		goto err_unregister_pernet;
>> > +	}
>> > +
>> > 	vsock_bpf_build_proto();
>> >
>> > 	return 0;
>> >
>> > +err_unregister_pernet:
>> > +	unregister_pernet_subsys(&vsock_pernet_ops);
>> > err_unregister_sock:
>> > 	sock_unregister(AF_VSOCK);
>> > err_unregister_proto:
>> > @@ -3102,15 +3531,20 @@ static int __init vsock_init(void)
>> > err_deregister_misc:
>> > 	misc_deregister(&vsock_device);
>> > err_reset_transport:
>> > +	put_net_track(&init_net, &vsock_g2h_net_tracker);
>> > 	return err;
>> > }
>> >
>> > static void __exit vsock_exit(void)
>> > {
>> > +	genl_unregister_family(&vsock_nl_family);
>> > 	misc_deregister(&vsock_device);
>> > 	sock_unregister(AF_VSOCK);
>> > 	proto_unregister(&vsock_proto);
>> > 	unregister_pernet_subsys(&vsock_pernet_ops);
>> > +
>> > +	put_net_track(rcu_dereference_protected(vsock_g2h_net, true),
>> > +		      &vsock_g2h_net_tracker);
>> > }
>> >
>> > const struct vsock_transport *vsock_core_get_transport(struct vsock_sock *vsk)
>> > @@ -3177,13 +3611,18 @@ EXPORT_SYMBOL_GPL(vsock_core_register);
>> >
>> > void vsock_core_unregister(const struct vsock_transport *t)
>> > {
>> > +	netns_tracker old_tracker;
>> > +	struct net *old = NULL;
>> > +
>> > 	mutex_lock(&vsock_register_mutex);
>> >
>> > 	if (transport_h2g == t)
>> > 		transport_h2g = NULL;
>> >
>> > -	if (transport_g2h == t)
>> > +	if (transport_g2h == t) {
>> > 		transport_g2h = NULL;
>> > +		old = vsock_g2h_net_swap(&init_net, &old_tracker);
>> > +	}
>> >
>> > 	if (transport_dgram == t)
>> > 		transport_dgram = NULL;
>> > @@ -3192,6 +3631,10 @@ void vsock_core_unregister(const struct vsock_transport *t)
>> > 		transport_local = NULL;
>> >
>> > 	mutex_unlock(&vsock_register_mutex);
>> > +
>> > +	/* The device is gone, so release the namespace it was holding. */
>> > +	if (old)
>> > +		vsock_g2h_net_release(old, &old_tracker);
>> > }
>> > EXPORT_SYMBOL_GPL(vsock_core_unregister);
>> >
>> > diff --git a/net/vmw_vsock/vsock_nl_gen.c b/net/vmw_vsock/vsock_nl_gen.c
>> > new file mode 100644
>> > index 000000000000..81db4c61d7bb
>> > --- /dev/null
>> > +++ b/net/vmw_vsock/vsock_nl_gen.c
>> > @@ -0,0 +1,36 @@
>> > +// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
>> > +/* Do not edit directly, auto-generated from: */
>> > +/*	Documentation/netlink/specs/vsock.yaml */
>> > +/* YNL-GEN kernel source */
>> > +/* To regenerate run: tools/net/ynl/ynl-regen.sh */
>> > +
>> > +#include <net/netlink.h>
>> > +#include <net/genetlink.h>
>> > +
>> > +#include "vsock_nl_gen.h"
>> > +
>> > +#include <uapi/linux/vsock.h>
>> > +
>> > +/* Ops table for vsock */
>> > +static const struct genl_split_ops vsock_nl_ops[] = {
>> > +	{
>> > +		.cmd	= VSOCK_CMD_DEV_NETNS_SET,
>> > +		.doit	= vsock_nl_dev_netns_set_doit,
>> > +		.flags	= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>> > +	},
>> > +	{
>> > +		.cmd	= VSOCK_CMD_DEV_NETNS_GET,
>> > +		.doit	= vsock_nl_dev_netns_get_doit,
>> > +		.flags	= GENL_CMD_CAP_DO,
>> > +	},
>> > +};
>> > +
>> > +struct genl_family vsock_nl_family __ro_after_init = {
>> > +	.name		= VSOCK_FAMILY_NAME,
>> > +	.version	= VSOCK_FAMILY_VERSION,
>> > +	.netnsok	= true,
>> > +	.parallel_ops	= true,
>> > +	.module		= THIS_MODULE,
>> > +	.split_ops	= vsock_nl_ops,
>> > +	.n_split_ops	= ARRAY_SIZE(vsock_nl_ops),
>> > +};
>> > diff --git a/net/vmw_vsock/vsock_nl_gen.h b/net/vmw_vsock/vsock_nl_gen.h
>> > new file mode 100644
>> > index 000000000000..c041195584a0
>> > --- /dev/null
>> > +++ b/net/vmw_vsock/vsock_nl_gen.h
>> > @@ -0,0 +1,20 @@
>> > +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
>> > +/* Do not edit directly, auto-generated from: */
>> > +/*	Documentation/netlink/specs/vsock.yaml */
>> > +/* YNL-GEN kernel header */
>> > +/* To regenerate run: tools/net/ynl/ynl-regen.sh */
>> > +
>> > +#ifndef _LINUX_VSOCK_GEN_H
>> > +#define _LINUX_VSOCK_GEN_H
>> > +
>> > +#include <net/netlink.h>
>> > +#include <net/genetlink.h>
>> > +
>> > +#include <uapi/linux/vsock.h>
>> > +
>> > +int vsock_nl_dev_netns_set_doit(struct sk_buff *skb, struct genl_info *info);
>> > +int vsock_nl_dev_netns_get_doit(struct sk_buff *skb, struct genl_info *info);
>> > +
>> > +extern struct genl_family vsock_nl_family;
>> > +
>> > +#endif /* _LINUX_VSOCK_GEN_H */
>> > diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
>> > index 3eee34e0efcf..f3150b41dd33 100644
>> > --- a/tools/net/ynl/Makefile.deps
>> > +++ b/tools/net/ynl/Makefile.deps
>> > @@ -62,4 +62,5 @@ CFLAGS_tc:= $(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
>> > 	$(call get_hdr_inc,_TC_SKBEDIT_H,tc_act/tc_skbedit.h) \
>> > 	$(call get_hdr_inc,_TC_TUNNEL_KEY_H,tc_act/tc_tunnel_key.h)
>> > CFLAGS_tcp_metrics:=$(call get_hdr_inc,_LINUX_TCP_METRICS_H,tcp_metrics.h)
>> > +CFLAGS_vsock:=$(call get_hdr_inc,_LINUX_VSOCK_H,vsock.h)
>> > CFLAGS_wireguard:=$(call get_hdr_inc2,_LINUX_WIREGUARD_H,_WG_UAPI_WIREGUARD_H,wireguard.h)
>> >
>> > --
>> > 2.53.0-Meta
>> >
>>
>

