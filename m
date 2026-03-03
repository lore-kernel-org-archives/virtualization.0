Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DA1344DA0
	for <virtualization@lists.linux.dev>; Tue,  3 Mar 2026 12:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772541155; cv=none; b=o/c7M2Uyd8jMGzRJeYbV+CZGQVJkKp6iauxvupz3aAd0ekt95wQ/7HQ+LUQB6NedhYegLT4tY/vHc4wPLjCY2vu0eTxWOkXtzJsdqfgLtGPmUMnjl72XbCxjvdQ1ayGpG7f473UXdXWe6zTpHIhHYnTBNnUU1LzeISdSsHRAQe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772541155; c=relaxed/simple;
	bh=vMNiiAt1Fwy9Teu2yIb26JC5dV3q4DvAFgv8ItOJHfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tLkyBzIZAkzPcx7wlacO8xUYN5oYdlXaCHo78mHKqb3Jjo3gWPtREXY6ov8WaVABq1Wb86b1Ofgpg5A9a35pVttn+SykpimS+3yE/qX92VhNVdMCxruIFKKL2qOTl9MuBmPC1KSH7kV/sGKxM7j1Fzh/P/yjmUgC05CGpFZ0e8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SXaaPb9D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SXaaPb9D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772541152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=33vOBPb9YBeaZHuv0n0JQPoCQUrGGFAN/nM5xsJK9iY=;
	b=SXaaPb9Dj+H8CayS2k7Y9zkczKf5kgovdsWZtpouQ8htFgqpv9ZQcJb6LUWIiEu/cDKCYP
	d6BlpWOpLk5B44Z0pzPGtTSorGYxUdLjL+YSecZEeGSb0MgrKW79JNsXoEpDPIgSeiklGT
	5k9M0liU8UTi4VO6FudSXXZeFSZQORs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-KVamsVGqNz219U89hiEUCA-1; Tue, 03 Mar 2026 07:32:29 -0500
X-MC-Unique: KVamsVGqNz219U89hiEUCA-1
X-Mimecast-MFC-AGG-ID: KVamsVGqNz219U89hiEUCA_1772541148
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4836c819456so39208645e9.3
        for <virtualization@lists.linux.dev>; Tue, 03 Mar 2026 04:32:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772541148; x=1773145948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33vOBPb9YBeaZHuv0n0JQPoCQUrGGFAN/nM5xsJK9iY=;
        b=igo9e2jgEkhXj3pVBEDFk6H/cjDv+ab6pJ5wwkDGoMKimssoHuqzOJsQCdEkQUaDOt
         6ISkXm+TYH+ISsnEaMjPjn37vq1zCvwqI09OQq2+ao2MI67MbWyyvJXwnTS9/J2vvuvN
         vtu152raw3okelwK+QjNnvuUZkRJLS/tM7kL4eYbKDylwP0dDuBrXd1d2uipnFp5r4XM
         uKQRWiWGYZPftAJKkiBxvuh8t2rZWPU2dgde5MzmaiTVad0+WClbW6jevkA3iqNLcZD7
         y2vTCwUS8t5d4Yh7oAXJrkZIfOjqh1xAwC8AHb1QtBsSl48xzIjqxz8jd8Lyg4ZEJdbv
         YZvA==
X-Gm-Message-State: AOJu0YyXL15HmQ+aM8EV6gbpfzGBSVC/vKA4BnbriVUmYxp58FlIHzmm
	5UD2Yl4z+Tx+r35febVAGzFSq/M28QdoUhxl4PnS89r1yPI20lza+n+qrURs1wW4tMQdiTqTT9W
	giDA6pDCd5eimwkkoh2T3dr1lhE3YJlwQhAn1hA13xUGiJGXsxNT5ng+8aehgAD3nnzXq
X-Gm-Gg: ATEYQzx0k7Z452noOEv1AxYLNHUYMQPU5s7sd60U9dr3QgkvwVeyZ3h2fakEb5ameYg
	dzMYtKbw4Nqnd1vKQMVk2Kua1mSmD1I3ydg1L6+fk/UEKg610QG8VNHIgHOsRQj/rHnEqwg908y
	+bNqqd00J0eOFLtaT2rwAkkQswFBZeqHZoXpqjdxfTWssryn7rQsLYbfTU+LJNgz0gtWw37/+Tr
	XqMSsoiny3qjTMdUPwkKyUEVknFQ3BfSIjc//0nduampFgmvhe/3ziOPBmeGm3VezoXuUavVNUB
	Hm1HZI32dh72G3DqbX2I3Gs9SfxeliHRp4WiOH9+Gw8JbQX7nzb5io1nEDUImFYvS5EbtSDngcO
	CV7EIrawtEAeUKjCWILyrPBWR0ebftS7JR9AzVxsQT23HURmFZoo14gj6wb8xpNb462+AW/Y=
X-Received: by 2002:a05:600c:3b22:b0:479:35e7:a0e3 with SMTP id 5b1f17b1804b1-483c9c2d29amr255124405e9.30.1772541148132;
        Tue, 03 Mar 2026 04:32:28 -0800 (PST)
X-Received: by 2002:a05:600c:3b22:b0:479:35e7:a0e3 with SMTP id 5b1f17b1804b1-483c9c2d29amr255123855e9.30.1772541147625;
        Tue, 03 Mar 2026 04:32:27 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851262ee4asm24386825e9.1.2026.03.03.04.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 04:32:25 -0800 (PST)
Date: Tue, 3 Mar 2026 13:32:20 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, eperezma@redhat.com, 
	Jason Wang <jasowang@redhat.com>, mst@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, 
	bcm-kernel-feedback-list@broadcom.com, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	nh-open-source@amazon.com
Subject: Re: [PATCH v2] vsock: add G2H fallback for CIDs not owned by H2G
 transport
Message-ID: <aabUfziQhUFeZZx9@sgarzare-redhat>
References: <20260302194926.90378-1-graf@amazon.com>
 <aaa0UCkzFRyuVp4N@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aaa0UCkzFRyuVp4N@sgarzare-redhat>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9qNGtIURkBZ7H2eJqXa2xc-e2pHLDvpgJ31WOKJesnU_1772541148
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Mar 03, 2026 at 11:28:20AM +0100, Stefano Garzarella wrote:
>Please mark this as `net-next` material. AF_VSOCK core changes are 
>queued by net maintainers and that will help them to get the right 
>tree:
>https://docs.kernel.org/process/maintainer-netdev.html#git-trees-and-patch-flow
>
>On Mon, Mar 02, 2026 at 07:49:26PM +0000, Alexander Graf wrote:
>>Vsock maintains a single CID number space which can be used to
>>communicate to the host (G2H) or to a child-VM (H2G). The current logic
>>assumes that G2H is only relevant for CID <= 2 because these target the
>>hypervisor. However, in environments like Nitro Enclaves, an instance
>>that hosts vhost_vsock powered VMs may still want to communicate to
>>Enclaves that are reachable at higher CIDs through virtio-vsock-pci.
>>
>>Vsock introduced VMADDR_FLAG_TO_HOST to allow user space applications
>>to clearly express a desire to talk to the host instead of a guest via
>>the passed target CID. However, users may not actually know which one
>>they want to talk to and the application ecosystem has not picked up a
>>way for users to specify that desire.
>>
>>Instead, make it easy for users and introduce a G2H fallback mechanism:
>>when user space attempts to connect to a CID and the H2G transport
>>(vhost-vsock / VMCI) does not own it, automatically route the connection
>>through the G2H transport. This provides a single unified CID address
>>space where vhost-registered CIDs go to nested VMs and all other CIDs
>>are routed to the hypervisor.
>>
>>To give user space at least a hint that the kernel applied this logic,
>>automatically set the VMADDR_FLAG_TO_HOST on the remote address so it
>>can determine the path taken via getpeername().
>>
>>To force the system back into old behavior, provide a sysctl
>>(net.vsock.g2h_fallback, defaults to 1).
>
>I'm still concerned about this change. Perhaps we should document the 
>fact that if H2G is not loaded, we already behave in this way, and 
>sysctl helps us definitively to better define this behavior.
>
>>
>>Signed-off-by: Alexander Graf <graf@amazon.com>
>>
>>---
>>
>>v1 -> v2:
>>
>> - Rebase on 7.0, include namespace support
>> - Add net.vsock.g2h_fallback sysctl
>> - Rework description
>> - Set VMADDR_FLAG_TO_HOST automatically
>> - Add VMCI support
>> - Update vsock_assign_transport() comment
>>---
>>Documentation/admin-guide/sysctl/net.rst | 22 ++++++++++++++++++++++
>>drivers/misc/vmw_vmci/vmci_context.c     |  1 +
>>drivers/vhost/vsock.c                    | 13 +++++++++++++
>>include/linux/vmw_vmci_api.h             |  1 +
>>include/net/af_vsock.h                   |  3 +++
>>net/vmw_vsock/af_vsock.c                 | 20 +++++++++++++++++++-
>>net/vmw_vsock/vmci_transport.c           |  6 ++++++
>>7 files changed, 65 insertions(+), 1 deletion(-)
>>
>>diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
>>index 3b2ad61995d4..cc364baa9021 100644
>>--- a/Documentation/admin-guide/sysctl/net.rst
>>+++ b/Documentation/admin-guide/sysctl/net.rst
>>@@ -602,3 +602,25 @@ it does not modify the current namespace or any existing children.
>>
>>A namespace with ``ns_mode`` set to ``local`` cannot change
>>``child_ns_mode`` to ``global`` (returns ``-EPERM``).
>>+
>>+g2h_fallback
>>+------------
>>+
>>+Controls whether connections to CIDs not owned by the host-to-guest (H2G)
>>+transport automatically fall back to the guest-to-host (G2H) transport.
>>+
>>+When enabled, if a connect targets a CID that the H2G transport (e.g.
>>+vhost-vsock) does not serve, the connection is routed via the G2H transport
>>+(e.g. virtio-vsock) instead. This allows a host running both nested VMs
>>+(via vhost-vsock) and sibling VMs reachable through the hypervisor (e.g.
>>+Nitro Enclaves) to address both using a single CID space, without requiring
>>+applications to set ``VMADDR_FLAG_TO_HOST``.
>>+
>>+When the fallback is taken, ``VMADDR_FLAG_TO_HOST`` is automatically set on
>>+the remote address so that userspace can determine the path via
>>+``getpeername()``.
>>+
>>+Values:
>>+
>>+	- 0 - Connections to CIDs < 3 get handled by G2H, others by H2G.
>>+	- 1 - Connections to CIDs not owned by H2G fall back to G2H. (default)
>>diff --git a/drivers/misc/vmw_vmci/vmci_context.c b/drivers/misc/vmw_vmci/vmci_context.c
>>index 19ca00feed6e..577296784df5 100644
>>--- a/drivers/misc/vmw_vmci/vmci_context.c
>>+++ b/drivers/misc/vmw_vmci/vmci_context.c
>>@@ -364,6 +364,7 @@ bool vmci_ctx_exists(u32 cid)
>>	rcu_read_unlock();
>>	return exists;
>>}
>>+EXPORT_SYMBOL_GPL(vmci_ctx_exists);
>>
>>/*
>> * Retrieves VMCI context corresponding to the given cid.
>>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>>index 054f7a718f50..319e3a690108 100644
>>--- a/drivers/vhost/vsock.c
>>+++ b/drivers/vhost/vsock.c
>>@@ -91,6 +91,18 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid, struct net *net)
>>	return NULL;
>>}
>>
>>+static bool vhost_transport_has_remote_cid(struct vsock_sock *vsk, u32 cid)
>>+{
>>+	struct sock *sk = sk_vsock(vsk);
>>+	struct net *net = sock_net(sk);
>>+	bool found;
>>+
>>+	rcu_read_lock();
>>+	found = vhost_vsock_get(cid, net) != NULL;
>>+	rcu_read_unlock();
>>+	return found;
>>+}
>>+
>>static void
>>vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
>>			    struct vhost_virtqueue *vq)
>>@@ -424,6 +436,7 @@ static struct virtio_transport vhost_transport = {
>>		.module                   = THIS_MODULE,
>>
>>		.get_local_cid            = vhost_transport_get_local_cid,
>>+		.has_remote_cid           = vhost_transport_has_remote_cid,
>>
>>		.init                     = virtio_transport_do_socket_init,
>>		.destruct                 = virtio_transport_destruct,
>>diff --git a/include/linux/vmw_vmci_api.h b/include/linux/vmw_vmci_api.h
>>index 41764a684423..c412d17c572f 100644
>>--- a/include/linux/vmw_vmci_api.h
>>+++ b/include/linux/vmw_vmci_api.h
>>@@ -37,6 +37,7 @@ int vmci_doorbell_create(struct vmci_handle *handle, u32 flags,
>>int vmci_doorbell_destroy(struct vmci_handle handle);
>>u32 vmci_get_context_id(void);
>>bool vmci_is_context_owner(u32 context_id, kuid_t uid);
>>+bool vmci_ctx_exists(u32 cid);
>>int vmci_register_vsock_callback(vmci_vsock_cb callback);
>>
>>int vmci_event_subscribe(u32 event,
>>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>>index 533d8e75f7bb..0aeb25642827 100644
>>--- a/include/net/af_vsock.h
>>+++ b/include/net/af_vsock.h
>>@@ -179,6 +179,9 @@ struct vsock_transport {
>>	/* Addressing. */
>>	u32 (*get_local_cid)(void);
>>
>>+	/* Check if this transport serves a specific remote CID. */
>>+	bool (*has_remote_cid)(struct vsock_sock *vsk, u32 remote_cid);
>>+
>>	/* Read a single skb */
>>	int (*read_skb)(struct vsock_sock *, skb_read_actor_t);
>>
>>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>index 2f7d94d682cb..b41bc734d6c0 100644
>>--- a/net/vmw_vsock/af_vsock.c
>>+++ b/net/vmw_vsock/af_vsock.c
>>@@ -210,6 +210,8 @@ static const struct vsock_transport *transport_dgram;
>>static const struct vsock_transport *transport_local;
>>static DEFINE_MUTEX(vsock_register_mutex);
>>
>>+static int vsock_g2h_fallback = 1;
>>+
>>/**** UTILS ****/
>>
>>/* Each bound VSocket is stored in the bind hash table and each connected
>>@@ -547,7 +549,8 @@ static void vsock_deassign_transport(struct vsock_sock *vsk)
>> *    g2h is not loaded, will use local transport;
>> *  - remote CID <= VMADDR_CID_HOST or h2g is not loaded or remote flags field
>> *    includes VMADDR_FLAG_TO_HOST flag value, will use guest->host transport;
>>- *  - remote CID > VMADDR_CID_HOST will use host->guest transport;
>>+ *  - remote CID > VMADDR_CID_HOST will use host->guest transport if h2g has
>>+ *    registered that CID, otherwise will use guest->host transport (overlay);
>> */
>>int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>>{
>>@@ -584,6 +587,12 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>>		else if (remote_cid <= VMADDR_CID_HOST || !transport_h2g ||
>>			 (remote_flags & VMADDR_FLAG_TO_HOST))
>>			new_transport = transport_g2h;
>>+		else if (vsock_g2h_fallback &&
>
>IMO `vsock_g2h_fallback` should also control the fallback when 
>transport_h2g == NULL. In this way is easiest to justify why the 
>default is to have the fallback enabled.
>
>>+			 transport_h2g->has_remote_cid &&
>>+			 !transport_h2g->has_remote_cid(vsk, remote_cid)) {
>>+			vsk->remote_addr.svm_flags |= VMADDR_FLAG_TO_HOST;
>>+			new_transport = transport_g2h;
>>+		}
>>		else
>>			new_transport = transport_h2g;
>>		break;
>>@@ -2879,6 +2888,15 @@ static struct ctl_table vsock_table[] = {
>>		.mode		= 0644,
>>		.proc_handler	= vsock_net_child_mode_string
>>	},
>>+	{
>>+		.procname	= "g2h_fallback",
>>+		.data		= &vsock_g2h_fallback,
>>+		.maxlen		= sizeof(int),
>>+		.mode		= 0644,
>>+		.proc_handler	= proc_dointvec_minmax,
>>+		.extra1		= SYSCTL_ZERO,
>>+		.extra2		= SYSCTL_ONE,
>>+	},
>
>syzbot is reporting a warning with this change:
>https://lore.kernel.org/netdev/69a6940b.a70a0220.135158.0007.GAE@google.com/
>    sysctl net/vsock/g2h_fallback: data points to kernel global data:     
>vsock_g2h_fallback
>
>IIUC because vsock_table is per-netns stuff, while `g2h_fallback` is a 
>global setting, so I guess we need to use another ctl_table for that.

Oh right, as Michael pointed out maybe it is better to have this 
per-netns and inherit the value from the parent while init_ns will have 
the default.

Stefano

>
>Thanks,
>Stefano
>
>>};
>>
>>static int __net_init vsock_sysctl_register(struct net *net)
>>diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>>index 4296ca1183f1..de3dff52c566 100644
>>--- a/net/vmw_vsock/vmci_transport.c
>>+++ b/net/vmw_vsock/vmci_transport.c
>>@@ -2045,6 +2045,11 @@ static u32 vmci_transport_get_local_cid(void)
>>	return vmci_get_context_id();
>>}
>>
>>+static bool vmci_transport_has_remote_cid(struct vsock_sock *vsk, u32 cid)
>>+{
>>+	return vmci_ctx_exists(cid);
>>+}
>>+
>>static struct vsock_transport vmci_transport = {
>>	.module = THIS_MODULE,
>>	.init = vmci_transport_socket_init,
>>@@ -2074,6 +2079,7 @@ static struct vsock_transport vmci_transport = {
>>	.notify_send_post_enqueue = vmci_transport_notify_send_post_enqueue,
>>	.shutdown = vmci_transport_shutdown,
>>	.get_local_cid = vmci_transport_get_local_cid,
>>+	.has_remote_cid = vmci_transport_has_remote_cid,
>>};
>>
>>static bool vmci_check_transport(struct vsock_sock *vsk)
>>-- 
>>2.47.1
>>
>>
>>
>>
>>Amazon Web Services Development Center Germany GmbH
>>Tamara-Danz-Str. 13
>>10243 Berlin
>>Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
>>Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
>>Sitz: Berlin
>>Ust-ID: DE 365 538 597
>>
>>

