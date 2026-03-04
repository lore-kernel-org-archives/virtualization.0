Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ED03B4E9E
	for <virtualization@lists.linux.dev>; Wed,  4 Mar 2026 17:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772645189; cv=none; b=GNeJEFhKdPxVVtqyoth6GkjqYQSsZNuOfk8hlp83uVd3WYK5CP8PSxgpNA0UfOBHUpsivHHFrCxVFw6LfRTGUw9kz7I/22amT7MXkwp/itJStDcp5j5KHf04amgH7y0B+8ni2Xv/LAsbtxHb2O6xWRthGDxoJFDv7NPzlQEdp3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772645189; c=relaxed/simple;
	bh=wxfzCjlPbqtpzxBhJEG0z4XAx/4LsMgepxfFOOGEjkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=awHqL5ZFEX5g1qP5xB16sfAulZc4BMt24Qf+Yptt0SzKcm1VmWEKqlQsvGppUwkf2K/JLpcIMErwH86gbzebnTG4zjFvkMBQdMm2QbEes2VsVP+FBsyLarjs8CFya5YNo+vL3bSmFIi0OHfmzQ40LpQQHoZvRnIWL+XzFzMXqKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d0Hap17k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d0Hap17k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772645183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=85kgFNh7a8akSjl1hmjKjQyP7rsitUvp+G+d7OlEtL4=;
	b=d0Hap17kBjddFbYgQqUnrwSmdDVUsDwq74bb4sZuMR+6NM+Y4rP8+hLRjhQ3Cio0LXxDJX
	3F0zEld7Pq35ohl+Q+I4w77M17Jf9pl5Pdg9VzP0a2RnZDKMaYiARasAAXNYjV0xdjiWZj
	ryceQYfrI8wAAOrVAiO8ggi3U49UeLE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-75zQ5VQaPjijiSW6UBaZSQ-1; Wed, 04 Mar 2026 12:26:22 -0500
X-MC-Unique: 75zQ5VQaPjijiSW6UBaZSQ-1
X-Mimecast-MFC-AGG-ID: 75zQ5VQaPjijiSW6UBaZSQ_1772645181
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-439ae2cba40so3041886f8f.1
        for <virtualization@lists.linux.dev>; Wed, 04 Mar 2026 09:26:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772645181; x=1773249981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=85kgFNh7a8akSjl1hmjKjQyP7rsitUvp+G+d7OlEtL4=;
        b=hJZIQdm5OCoyzPkOlITbXakmpz7j+wnCyS/kxHh2iuovRvSwPntA6x+rUmDcFqid3S
         9/+JIFfMVgwPYGN2i3jUAlDzDdRqYK6bt3MM/mUe9XnEWpXF7Vx30zfmXokNh2ZxoQxJ
         IpiHMqnck0ZuvFWUUwGzVA3mYxLGSZxFe3KWXGESd0HuRJSViCfzVfbFasHI5Ob3VNoZ
         QPrhEIGNUQTSpYbMrTSUIXwSUlm829O6ihkFkkPhUyp7XxYUCt5rS/WKWkC+qDVhYCV1
         9UrtDLUBku0GLrZkdgTs4qQ43OxDHeUxGhX8mOZp1wm8CeFdM+0NdBzoD7fcL223DLEM
         GkBA==
X-Gm-Message-State: AOJu0YzrFZ7LYcQvcooy70P1GXCq78IcBxBUF4DX8kbpxGub8Z9aYsxa
	w0X0NsYW/TDL4sXztNjockdHQnIR75VzLevcfpCENkGB6yGvT8jhPqeHHymDP1FydRpJ2j8nT6p
	YRLad/vX4KyFb/EGjk+jB0NwcP8jI9O6H+ouQ5AVAtti7hR3TBl5PiwK/QHBYM+4D7HZj
X-Gm-Gg: ATEYQzyiOTDLrkmCyqj+iPb9x12MZeBH7IZBjxzd8gSj+LagjaGxbBqLvzCbTOfZ0rA
	JArwd9H30vWdhk+TWKDeY4iYIZNr1d8nDkw2o/a1oOe4zvtAvTG47Kz36xDQUQVvB/cdT9jmKuj
	qdNfUJH7BIyjSiAdMjrLr+7/Hb5+na6iODJdNX/iOAwpk1Pb1H1ec+4ON7o/HN1F1/rvq58JsVn
	hukNAaS2JuhDS3VXu/l36mc/7Hez4/Xh4p/zZRys4AFpyTj8cbVuuahEPSlYfWS4ZC+ls0am/RX
	/sK4XxCWRAvEXO+EWDu/cmVK+1yvAwZCwG1R/ZlDjah3jroaGsY37mv2y7r/8O9i4xnFjE4/A0Z
	CaWO16bGoV/TUiiCdOfAZbvmpmYFCNBbRg13dTJQEtA63HxSKSP1JNmyr+Cyc+d9Bi0Qc7zs=
X-Received: by 2002:a05:6000:1a87:b0:439:c6d9:7fc with SMTP id ffacd0b85a97d-439c7fc619bmr5459657f8f.25.1772645180640;
        Wed, 04 Mar 2026 09:26:20 -0800 (PST)
X-Received: by 2002:a05:6000:1a87:b0:439:c6d9:7fc with SMTP id ffacd0b85a97d-439c7fc619bmr5459580f8f.25.1772645180001;
        Wed, 04 Mar 2026 09:26:20 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b59723fesm26176557f8f.38.2026.03.04.09.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 09:26:19 -0800 (PST)
Date: Wed, 4 Mar 2026 18:26:16 +0100
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
Subject: Re: [PATCH v3] vsock: add G2H fallback for CIDs not owned by H2G
 transport
Message-ID: <aahRzq5vS76rPI28@sgarzare-redhat>
References: <20260303214329.71711-1-graf@amazon.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260303214329.71711-1-graf@amazon.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GNeyTa-8JBNFHRyHU1TXMPsROLGH2xCQotPd2DpxPF0_1772645181
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline


nit: `net-next` tag...

On Tue, Mar 03, 2026 at 09:43:29PM +0000, Alexander Graf wrote:
>When no H2G transport is loaded, vsock currently routes all CIDs to the
>G2H transport (commit 65b422d9b61b, "vsock: forward all packets to the
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
>---
> Documentation/admin-guide/sysctl/net.rst | 28 +++++++++++++++++++
> drivers/vhost/vsock.c                    | 13 +++++++++
> include/net/af_vsock.h                   |  9 +++++++
> include/net/netns/vsock.h                |  2 ++
> net/vmw_vsock/af_vsock.c                 | 34 ++++++++++++++++++++----
> net/vmw_vsock/virtio_transport.c         |  7 +++++
> 6 files changed, 88 insertions(+), 5 deletions(-)

Checkpatch reports something:

     $ ./scripts/checkpatch.pl --strict -g master..HEAD --codespell
     ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit 65b422d9b61b ("vsock: forward all packets to the host when no H2G is registered")'
     #9:
     G2H transport (commit 65b422d9b61b, "vsock: forward all packets to the

     CHECK: Comparison to NULL could be written "vhost_vsock_get"
     #131: FILE: drivers/vhost/vsock.c:101:
     +	found = vhost_vsock_get(cid, net) != NULL;

     CHECK: Unbalanced braces around else statement
     #186: FILE: net/vmw_vsock/af_vsock.c:600:
     +		} else

     WARNING: The commit message has 'syzkaller', perhaps it also needs a 'Fixes:' tag?

     total: 1 errors, 1 warnings, 2 checks, 162 lines checked

     NOTE: For some of the reported defects, checkpatch may be able to
           mechanically convert to the typical style using --fix or --fix-inplace.

     Commit 728a7b66be31 ("vsock: add G2H fallback for CIDs not owned by H2G transport") has style problems, please review.

     NOTE: If any of the errors are false positives, please report
           them to the maintainer, see CHECKPATCH in MAINTAINERS.


Not strong opinion on them, maybe the ERROR one fixed could help some
tools.

Also from https://patchwork.kernel.org/project/netdevbpf/patch/20260303214329.71711-1-graf@amazon.com/
it seems several maintainers (especially from net) are missing.

>
>diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
>index 3b2ad61995d4..98b9eaa9cb9e 100644
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
>+CID which is not implemented by vhost will create host vsock traffic.

nit: IMO we should avoid to use `vhost` here but be a bit more generic
using H2G.

>+Environments that rely on H2G-only isolation should set it to 0.
>+
>+Values:
>+
>+	- 0 - Connections to CIDs <= 2 or with VMADDR_FLAG_TO_HOST use G2H;
>+	  all others use H2G (or fail with ENODEV if H2G is not loaded).
>+	- 1 - Connections to CIDs not owned by H2G fall back to G2H. (default)
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 054f7a718f50..319e3a690108 100644
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
>+	found = vhost_vsock_get(cid, net) != NULL;
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
>index 2f7d94d682cb..0cdc3df9b63c 100644
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
>@@ -581,10 +585,19 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
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
>+		} else
> 			new_transport = transport_h2g;
> 		break;
> 	default:
>@@ -2879,6 +2892,15 @@ static struct ctl_table vsock_table[] = {
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
>@@ -2894,6 +2916,7 @@ static int __net_init vsock_sysctl_register(struct net *net)
>
> 		table[0].data = &net->vsock.mode;
> 		table[1].data = &net->vsock.child_ns_mode;
>+		table[2].data = &net->vsock.g2h_fallback;
> 	}
>
> 	net->vsock.sysctl_hdr = register_net_sysctl_sz(net, "net/vsock", table,
>@@ -2928,6 +2951,7 @@ static void vsock_net_init(struct net *net)
> 		net->vsock.mode = vsock_net_child_mode(current->nsproxy->net_ns);
>
> 	net->vsock.child_ns_mode = net->vsock.mode;
>+	net->vsock.g2h_fallback = 1;

@Michael @Paolo @Jakub
I don't know what the sysctl policy is in general in net or virtio.
Is this fine or should we inherit this from the parent and set the
default only for init_ns?

The rest LGTM.

Thanks,
Stefano

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

