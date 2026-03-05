Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66662375F62
	for <virtualization@lists.linux.dev>; Thu,  5 Mar 2026 09:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772704307; cv=none; b=QDmFnkt8onowXqTuHAt0X6WpGncQEWa82evFMo6Sz1NZiYrTWj9M9TegPQfoWzUYet6L3Ij+d1EsL6Ff+QQn9naJoxsVU6N5s32pRYR4M7dUh1wfI+KXWQHkGAY4iyNFQFyqNkS7yWHldycnXJKHJqLPwtrvCKeSMSSaeZtPt5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772704307; c=relaxed/simple;
	bh=FXKFzKWzjI52GgzmHNUOFYfH3/rjrQEHZljmfESAyPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rEkSiWuIobKW1cvpnAvLKzqbs6iFsoicMYCoXa58trK+n2NrTkVklSAL5lN3Pjsmhtn5zjNzdoLm03jbAK36nJLkdbsBHZyCnzoPXnqM7b74aTgJ2ruRkoZQhFJmfiA5Zlv+TsOkToO2J65pSDE/Ova4vrqyRr8JmSm0EW2lkb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sauac6gp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sauac6gp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772704304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oAP2D1giB2BB8maYBYz4xIYderWfSFnBx/vi02aaqOM=;
	b=Sauac6gpa9kNQkQzzrLq9lNn57X0vA7bqiOAWMGElW7J3dkt3XkpLn4laGnAJuHEAnID2s
	VMvrxHQgxjO55H+GE7NXDIVGECCZY2hDp+UUfeLcm+9Fvs8m8b3iYrtn6w2Ex1nCCVtatN
	e5OBZ5uKB5JUCAMS4zZn//k2RvnT/5M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-qt7bUkUZN0Sp8oo1gN8s2Q-1; Thu, 05 Mar 2026 04:51:43 -0500
X-MC-Unique: qt7bUkUZN0Sp8oo1gN8s2Q-1
X-Mimecast-MFC-AGG-ID: qt7bUkUZN0Sp8oo1gN8s2Q_1772704301
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4836c819456so59138365e9.3
        for <virtualization@lists.linux.dev>; Thu, 05 Mar 2026 01:51:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772704301; x=1773309101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oAP2D1giB2BB8maYBYz4xIYderWfSFnBx/vi02aaqOM=;
        b=QskpSirGOtuwt5mGCiJSj5raLUfbxILw+7wEUEHEAcaUh8esuMMOeWie/RfuR8uAzG
         j7LCGnrjnBEA2wjs6e3iy5h2B1FWSLwy56EeKQuAN1ttBTAwN47QDNr56LrqTcW4bQlA
         ZNMiTDF/wRG4yviVqqlEeVFCHaMF0/pZXeLXhWoBCkTtYsJHlvXTwcTjdB2kKoRiU14X
         r/BzheOB7M3imj+H3CaoQsWoRPu+aGC8rXGR225gKcGsk9vZ3Wk620N2crQ02Oc74ihk
         oJyWdrteH6ZUPH37XkSnnNDfu103OnvfFv4JsVg0BtQByUd831URHJX75yon4LUXADe7
         dofw==
X-Gm-Message-State: AOJu0YxAdmlIpxUgSBmIPSgeLy/nOwXMfeGXpy/vWgkxxCp3uhFr3IUJ
	VdkeGaCNfFLPxqLJkLwwAXvYbU8rC8GpFNSoZtATFZdU7lXg5TXOwn1YZysNeymYPKYObUPgjjp
	ICB5S/qSGuvJGHiC+ZBrCa7yq5lkYyE8VlFp6ph/zRQRC5vA3m8+CzXQIXhoohrNPTsj5
X-Gm-Gg: ATEYQzxGGrpQci6zCoXmjz2iiCs4ZzEZJQh0Mb0tQtNdKXa50OSGi5BADo0sK0uLn/x
	Gi3LZij44HIk6jwvB+/pak/V0vSbDBR2sO07qbIeRZ+SfnA/j2xutm+0C1yFgICOB2ezvGm6v70
	7pm7Ctnmm2PqfxiBsHvn1ho37EBgl/x+HXLtW4gmdlgcFAWXwbns4mhCGxEcNgqj2lJMF3wibaA
	eGU/OpMgQxqFD7i5VwueOl5cY/q+XB8GotPILZ9U0fIXVRFNr22/URRnobNw+uK5ICsMnKx1X8e
	M/8xEnEmiR9+IWAEVzczQd2vnYLFLQyIJ9k6yqB3StfOPGdWPUqK6oZOe8rwRYn4JdfCA7/T42N
	8wtl1pb79cxS7VhhtvmP+ava3/71LioXGAdsNuW+n35bpWbJkVo8VZAD4/PigVr5RKvUWbzM=
X-Received: by 2002:a05:600c:4f8b:b0:477:a1a2:d829 with SMTP id 5b1f17b1804b1-48519856a67mr89432345e9.13.1772704300519;
        Thu, 05 Mar 2026 01:51:40 -0800 (PST)
X-Received: by 2002:a05:600c:4f8b:b0:477:a1a2:d829 with SMTP id 5b1f17b1804b1-48519856a67mr89431665e9.13.1772704299890;
        Thu, 05 Mar 2026 01:51:39 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851ad02eeesm28284255e9.19.2026.03.05.01.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 01:51:39 -0800 (PST)
Date: Thu, 5 Mar 2026 10:51:34 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alexander Graf <graf@amazon.com>, mst@redhat.com, pabeni@redhat.com, 
	kuba@kernel.org
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, eperezma@redhat.com, 
	Jason Wang <jasowang@redhat.com>, mst@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, 
	bcm-kernel-feedback-list@broadcom.com, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	nh-open-source@amazon.com, syzbot@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next v4] vsock: add G2H fallback for CIDs not owned
 by H2G transport
Message-ID: <aalQditGLRMrlyV7@sgarzare-redhat>
References: <20260304230027.59857-1-graf@amazon.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260304230027.59857-1-graf@amazon.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1mQAZb5PcwcH9pSQRXBQCI4WPYkzoXR6J7-r-gXYzM4_1772704301
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Mar 04, 2026 at 11:00:27PM +0000, Alexander Graf wrote:
>When no H2G transport is loaded, vsock currently routes all CIDs to the
>G2H transport (commit 65b422d9b61b ("vsock: forward all packets to the
>host when no H2G is registered"). Extend that existing behavior: when
>an H2G transport is loaded but does not claim a given CID, the
>connection falls back to G2H in the same way.
>
>This matters in environments like Nitro Enclaves, where an instance may
>run nested VMs via vhost-vsock (H2G) while also needing to reach sibling
>enclaves at higher CIDs through virtio-vsock-pci (G2H). With the old
>code, any CID > 2 was unconditionally routed to H2G when vhost was
>loaded, making those enclaves unreachable without setting
>VMADDR_FLAG_TO_HOST explicitly on every connect.
>
>Requiring every application to set VMADDR_FLAG_TO_HOST creates friction:
>tools like socat, iperf, and others would all need to learn about it.
>The flag was introduced 6 years ago and I am still not aware of any tool
>that supports it. Even if there was support, it would be cumbersome to
>use. The most natural experience is a single CID address space where H2G
>only wins for CIDs it actually owns, and everything else falls through to
>G2H, extending the behavior that already exists when H2G is absent.
>
>To give user space at least a hint that the kernel applied this logic,
>automatically set the VMADDR_FLAG_TO_HOST on the remote address so it
>can determine the path taken via getpeername().
>
>Add a per-network namespace sysctl net.vsock.g2h_fallback (default 1).
>At 0 it forces strict routing: H2G always wins for CID > VMADDR_CID_HOST,
>or ENODEV if H2G is not loaded.
>
>Signed-off-by: Alexander Graf <graf@amazon.com>
>Tested-by: syzbot@syzkaller.appspotmail.com
>
>---
>
>v1 -> v2:
>
>  - Rebase on 7.0, include namespace support
>  - Add net.vsock.g2h_fallback sysctl
>  - Rework description
>  - Set VMADDR_FLAG_TO_HOST automatically
>  - Add VMCI support
>  - Update vsock_assign_transport() comment
>
>v2 -> v3:
>
>  - Use has_remote_cid() on G2H transport to gate the fallback. This is
>    used by VMCI to indicate that it never takes G2H CIDs > 2.
>  - Move g2h_fallback into struct netns_vsock to enable namespaces
>    and fix syzbot warning
>  - Gate the !transport_h2g case on g2h_fallback as well, folding the
>    pre-existing no-H2G fallback into the new logic
>  - Remove has_remote_cid() from VMCI again. Instead implement it in
>    virtio.
>
>v3 -> v4:
>
>  - Fix commit reference format (checkpatch)
>  - vhost: use !!vhost_vsock_get() instead of != NULL (checkpatch)
>  - Add braces around final else branch (checkpatch)
>  - Replace 'vhost' with 'H2G transport' (Stefano)
>---
> Documentation/admin-guide/sysctl/net.rst | 28 +++++++++++++++++++
> drivers/vhost/vsock.c                    | 13 +++++++++
> include/net/af_vsock.h                   |  9 ++++++
> include/net/netns/vsock.h                |  2 ++
> net/vmw_vsock/af_vsock.c                 | 35 ++++++++++++++++++++----
> net/vmw_vsock/virtio_transport.c         |  7 +++++
> 6 files changed, 89 insertions(+), 5 deletions(-)
>
>diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
>index 3b2ad61995d4..0724a793798f 100644
>--- a/Documentation/admin-guide/sysctl/net.rst
>+++ b/Documentation/admin-guide/sysctl/net.rst
>@@ -602,3 +602,31 @@ it does not modify the current namespace or any existing children.
>
> A namespace with ``ns_mode`` set to ``local`` cannot change
> ``child_ns_mode`` to ``global`` (returns ``-EPERM``).
>+
>+g2h_fallback
>+------------
>+
>+Controls whether connections to CIDs not owned by the host-to-guest (H2G)
>+transport automatically fall back to the guest-to-host (G2H) transport.
>+
>+When enabled, if a connect targets a CID that the H2G transport (e.g.
>+vhost-vsock) does not serve, or if no H2G transport is loaded at all, the
>+connection is routed via the G2H transport (e.g. virtio-vsock) instead. This
>+allows a host running both nested VMs (via vhost-vsock) and sibling VMs
>+reachable through the hypervisor (e.g. Nitro Enclaves) to address both using
>+a single CID space, without requiring applications to set
>+``VMADDR_FLAG_TO_HOST``.
>+
>+When the fallback is taken, ``VMADDR_FLAG_TO_HOST`` is automatically set on
>+the remote address so that userspace can determine the path via
>+``getpeername()``.
>+
>+Note: With this sysctl enabled, user space that attempts to talk to a guest
>+CID which is not implemented by the H2G transport will create host vsock
>+traffic. Environments that rely on H2G-only isolation should set it to 0.
>+
>+Values:
>+
>+	- 0 - Connections to CIDs <= 2 or with VMADDR_FLAG_TO_HOST use G2H;
>+	  all others use H2G (or fail with ENODEV if H2G is not loaded).
>+	- 1 - Connections to CIDs not owned by H2G fall back to G2H. (default)
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 054f7a718f50..1d8ec6bed53e 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -91,6 +91,18 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid, struct net *net)
> 	return NULL;
> }
>
>+static bool vhost_transport_has_remote_cid(struct vsock_sock *vsk, u32 cid)
>+{
>+	struct sock *sk = sk_vsock(vsk);
>+	struct net *net = sock_net(sk);
>+	bool found;
>+
>+	rcu_read_lock();
>+	found = !!vhost_vsock_get(cid, net);
>+	rcu_read_unlock();
>+	return found;
>+}
>+
> static void
> vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 			    struct vhost_virtqueue *vq)
>@@ -424,6 +436,7 @@ static struct virtio_transport vhost_transport = {
> 		.module                   = THIS_MODULE,
>
> 		.get_local_cid            = vhost_transport_get_local_cid,
>+		.has_remote_cid           = vhost_transport_has_remote_cid,
>
> 		.init                     = virtio_transport_do_socket_init,
> 		.destruct                 = virtio_transport_destruct,
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 533d8e75f7bb..4e40063adab4 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -179,6 +179,15 @@ struct vsock_transport {
> 	/* Addressing. */
> 	u32 (*get_local_cid)(void);
>
>+	/* Check if this transport serves a specific remote CID.
>+	 * For H2G transports: return true if the CID belongs to a registered
>+	 * guest. If not implemented, all CIDs > VMADDR_CID_HOST go to H2G.
>+	 * For G2H transports: return true if the transport can reach arbitrary
>+	 * CIDs via the hypervisor (i.e. supports the fallback overlay). VMCI
>+	 * does not implement this as it only serves CIDs 0 and 2.
>+	 */
>+	bool (*has_remote_cid)(struct vsock_sock *vsk, u32 remote_cid);
>+
> 	/* Read a single skb */
> 	int (*read_skb)(struct vsock_sock *, skb_read_actor_t);
>
>diff --git a/include/net/netns/vsock.h b/include/net/netns/vsock.h
>index dc8cbe45f406..7f84aad92f57 100644
>--- a/include/net/netns/vsock.h
>+++ b/include/net/netns/vsock.h
>@@ -20,5 +20,7 @@ struct netns_vsock {
>
> 	/* 0 = unlocked, 1 = locked to global, 2 = locked to local */
> 	int child_ns_mode_locked;
>+
>+	int g2h_fallback;
> };
> #endif /* __NET_NET_NAMESPACE_VSOCK_H */
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 2f7d94d682cb..50843a977878 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -545,9 +545,13 @@ static void vsock_deassign_transport(struct vsock_sock *vsk)
>  * The vsk->remote_addr is used to decide which transport to use:
>  *  - remote CID == VMADDR_CID_LOCAL or g2h->local_cid or VMADDR_CID_HOST if
>  *    g2h is not loaded, will use local transport;
>- *  - remote CID <= VMADDR_CID_HOST or h2g is not loaded or remote flags field
>- *    includes VMADDR_FLAG_TO_HOST flag value, will use guest->host transport;
>- *  - remote CID > VMADDR_CID_HOST will use host->guest transport;
>+ *  - remote CID <= VMADDR_CID_HOST or remote flags field includes
>+ *    VMADDR_FLAG_TO_HOST, will use guest->host transport;
>+ *  - remote CID > VMADDR_CID_HOST and h2g is loaded and h2g claims that CID,
>+ *    will use host->guest transport;
>+ *  - h2g not loaded or h2g does not claim that CID and g2h claims the CID via
>+ *    has_remote_cid, will use guest->host transport (when g2h_fallback=1)
>+ *  - anything else goes to h2g or returns -ENODEV if no h2g is available
>  */
> int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> {
>@@ -581,11 +585,21 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> 	case SOCK_SEQPACKET:
> 		if (vsock_use_local_transport(remote_cid))
> 			new_transport = transport_local;
>-		else if (remote_cid <= VMADDR_CID_HOST || !transport_h2g ||
>+		else if (remote_cid <= VMADDR_CID_HOST ||
> 			 (remote_flags & VMADDR_FLAG_TO_HOST))
> 			new_transport = transport_g2h;
>-		else
>+		else if (transport_h2g &&
>+			 (!transport_h2g->has_remote_cid ||
>+			  transport_h2g->has_remote_cid(vsk, remote_cid)))
>+			new_transport = transport_h2g;
>+		else if (sock_net(sk)->vsock.g2h_fallback &&
>+			 transport_g2h && transport_g2h->has_remote_cid &&
>+			 transport_g2h->has_remote_cid(vsk, remote_cid)) {
>+			vsk->remote_addr.svm_flags |= VMADDR_FLAG_TO_HOST;
>+			new_transport = transport_g2h;
>+		} else {
> 			new_transport = transport_h2g;
>+		}
> 		break;
> 	default:
> 		ret = -ESOCKTNOSUPPORT;
>@@ -2879,6 +2893,15 @@ static struct ctl_table vsock_table[] = {
> 		.mode		= 0644,
> 		.proc_handler	= vsock_net_child_mode_string
> 	},
>+	{
>+		.procname	= "g2h_fallback",
>+		.data		= &init_net.vsock.g2h_fallback,
>+		.maxlen		= sizeof(int),
>+		.mode		= 0644,
>+		.proc_handler	= proc_dointvec_minmax,
>+		.extra1		= SYSCTL_ZERO,
>+		.extra2		= SYSCTL_ONE,
>+	},
> };
>
> static int __net_init vsock_sysctl_register(struct net *net)
>@@ -2894,6 +2917,7 @@ static int __net_init vsock_sysctl_register(struct net *net)
>
> 		table[0].data = &net->vsock.mode;
> 		table[1].data = &net->vsock.child_ns_mode;
>+		table[2].data = &net->vsock.g2h_fallback;
> 	}
>
> 	net->vsock.sysctl_hdr = register_net_sysctl_sz(net, "net/vsock", table,
>@@ -2928,6 +2952,7 @@ static void vsock_net_init(struct net *net)
> 		net->vsock.mode = vsock_net_child_mode(current->nsproxy->net_ns);
>
> 	net->vsock.child_ns_mode = net->vsock.mode;
>+	net->vsock.g2h_fallback = 1;

My last concern is what I mentioned in v3 [1].
Let me quote it here as well:

     @Michael @Paolo @Jakub
     I don't know what the sysctl policy is in general in net or virtio.
     Is this fine or should we inherit this from the parent and set the
     default only for init_ns?

I slightly prefer to inherit it, but I don't know what the convention 
is, it's not a strong opinion. Since I'll be away in a few days, 
regardless of this:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

[1] https://lore.kernel.org/netdev/aahRzq5vS76rPI28@sgarzare-redhat/

> }
>
> static __net_init int vsock_sysctl_init_net(struct net *net)
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 77fe5b7b066c..57f2d6ec3ffc 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -547,11 +547,18 @@ bool virtio_transport_stream_allow(struct vsock_sock *vsk, u32 cid, u32 port)
> static bool virtio_transport_seqpacket_allow(struct vsock_sock *vsk,
> 					     u32 remote_cid);
>
>+static bool virtio_transport_has_remote_cid(struct vsock_sock *vsk, u32 cid)
>+{
>+	/* The CID could be implemented by the host. Always assume it is. */
>+	return true;
>+}
>+
> static struct virtio_transport virtio_transport = {
> 	.transport = {
> 		.module                   = THIS_MODULE,
>
> 		.get_local_cid            = virtio_transport_get_local_cid,
>+		.has_remote_cid           = virtio_transport_has_remote_cid,
>
> 		.init                     = virtio_transport_do_socket_init,
> 		.destruct                 = virtio_transport_destruct,
>-- 
>2.47.1
>
>
>
>
>Amazon Web Services Development Center Germany GmbH
>Tamara-Danz-Str. 13
>10243 Berlin
>Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
>Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
>Sitz: Berlin
>Ust-ID: DE 365 538 597
>
>

