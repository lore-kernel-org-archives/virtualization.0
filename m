Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCA224113D
	for <virtualization@lists.linux.dev>; Wed, 12 Nov 2025 14:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762956827; cv=none; b=pPshlcjYFQqlzOM2eFc59EqRNl4EG+2IM6dnIvDurbNVTMJDwTEEqztbM6+TbY0pUKr0fjU4sfdxXJ7pKNwh2LWuv5YjM1yi7Z0VHzvpFx4ZSOFI0uxGnrrQkQ5sEmX5E9LiH8C55OV6PbXa67qiIUhJiREz9im1PgJadzX9cTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762956827; c=relaxed/simple;
	bh=0efl0X57BhletZnyf/eddvK+jKMzKLs1ot/NC4gKr6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JZJqi+4kKFR7v2BFnvrjJBhDU3zrWVYYy8Wlx7QXz0Dz2p2my369Oz1eJbx1nHADqNfF7QTLNUDkYDlSd0EDcZk1E5Bf5JGyR3j5SZ7xt6XDf/dLFXe92eHIziV+yXGv7DpSuhinniiMfAhD/z9IITskYbVGeZFJuh721A+geVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N6KzZToe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N6KzZToe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762956824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9EWdL2WpfP4agPf1IrRgcJrlbWTrsDu6O8KsN+miJKM=;
	b=N6KzZToeLqDgldiMJ8vOskVStiyxYpIy1xkuRIkCYNpciqK85e3WMXWwx5R6VIT6YpYOqu
	oCKsMCmPjva69JlxNUFUnOUOWUzc7w81x6vPHmCHO63pZnTszMDz+6NhXXpAiRW2hpgbp3
	w9uRLD8u6PsANbsRrY1WZYsnoqWOwGc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-EVkOtxODMfO6ZyefCL2nig-1; Wed, 12 Nov 2025 09:13:42 -0500
X-MC-Unique: EVkOtxODMfO6ZyefCL2nig-1
X-Mimecast-MFC-AGG-ID: EVkOtxODMfO6ZyefCL2nig_1762956822
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ed6466f2baso22256281cf.0
        for <virtualization@lists.linux.dev>; Wed, 12 Nov 2025 06:13:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762956822; x=1763561622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9EWdL2WpfP4agPf1IrRgcJrlbWTrsDu6O8KsN+miJKM=;
        b=stKKRKZvyDzwHj2dRaWgSbpBiWaZKeqDltu9GlfNJnPa0q0ElSslKOv1PR9sMdyrTp
         bjJ51ZdH9aDClnbfv4zXn261tbLEseNxQjqvncC+fffbtyE+FeaY+wu91Iwq+dLQw4Bx
         MHN//lJv1qlt6PDOnWYiMSk0AKN9mamzkZUuxQawDNVmYP6xhILXiDoCb1qCOjp8Zrsg
         sVZAEv9XXwNpJAjC6BD/JuROadMQcND66Dsd6Mu15bPO0ykpjjk7xBqGIos2EFmHUwEl
         lRkDym9BmRmOzVznpOOIzDyYhEHSGlkDmH20yLA0My3kVX2uvwgvDWVtxlr2N6gd+uuR
         Vsmg==
X-Forwarded-Encrypted: i=1; AJvYcCWOUSz8Sgxa9sQLcayTspvmV9XxDYLvkOrfloXY1Gfgrx4dHYaxEVXe5j1VMGPjkxhx92TFJrDL1huSH8/nvg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwVjf/Jt2CLwfE+JL7UY5CEbblD2L8S/DFZZR88qCdQAMVXQO47
	2UFoDxrHvaGkJeW2yfcUpUMMa8fp1xhDc4JIJ3ansCHRGuKOhcrz8KppUkRm4h90WKAfPCKarG8
	zkEcrGsB6+06NikOFazkXw+nbOpmnIjHWSl4FekkP+Ci+eweESBIhhH2GT4MCPEnz+DBq
X-Gm-Gg: ASbGnctVgL5gW9wGEt3v6lq9LsXcrr9yCpWm+4h6+Ta9sXFrXg3MSzp0xAGCMdvGAzb
	99s1zeBUkMu5PdQXc7R45BYTMCq5PpZdoR0WMbishEG8643CusNucwvINCxnDCimeFK5UQAKS0C
	oC8zZ6PbF3JeXkV88RV2KfVLrras9XqQYmOzpV351GwM4A79rHKu8HbD9nZCZ7scRf2370EaOWV
	1TaMVsppor558avFYFXRxIq3QonC8mGOf2BASt2u1lAO6pCYPUMs5UNvIdjIH0kri2T0b2GTv5p
	rM5GO/TdxM2fWfe9KIrwHn/MxpgBAReAfHTBWoez4aQ7vl8GAFN0pOqSROS7CGWzUd5v1lvYoOZ
	kKpZmkiAM3FHP9XyFDNbMJHEVSwOfoQb6g9qOpV0m9PXFMu93WHY=
X-Received: by 2002:ac8:59c9:0:b0:4ed:6fe8:1396 with SMTP id d75a77b69052e-4eddbdd6d1amr37245941cf.77.1762956822179;
        Wed, 12 Nov 2025 06:13:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDn3sUGixjKRYmWarO18Beo8/5b+a9+r56tGzTb/AmMIrdVHA0QqmPP6HV3IfDjsUZ1ypKuA==
X-Received: by 2002:ac8:59c9:0:b0:4ed:6fe8:1396 with SMTP id d75a77b69052e-4eddbdd6d1amr37245241cf.77.1762956821641;
        Wed, 12 Nov 2025 06:13:41 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eda578532csm86211281cf.19.2025.11.12.06.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 06:13:41 -0800 (PST)
Date: Wed, 12 Nov 2025 15:13:34 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v9 01/14] vsock: a per-net vsock NS mode state
Message-ID: <fr76vx3j47n3nfh753z2stwyu6k4lfdkx7zoisusdbiu27azjr@hygsraaern74>
References: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
 <20251111-vsock-vmtest-v9-1-852787a37bed@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251111-vsock-vmtest-v9-1-852787a37bed@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zR01hS3s6jKHxghvR-m6txeuSPvImwJgNfRCMoDVsk4_1762956822
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Nov 11, 2025 at 10:54:43PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add the per-net vsock NS mode state. This only adds the structure for
>holding the mode and some of the functions for setting/getting and
>checking the mode, but does not integrate the functionality yet.
>
>A "net_mode" field is added to vsock_sock to store the mode of the
>namespace when the vsock_sock was created. In order to evaluate
>namespace mode rules we need to know both a) which namespace the
>endpoints are in, and b) what mode that namespace had when the endpoints
>were created. This allows us to handle the changing of modes from global
>to local *after* a socket has been created by remembering that the mode
>was global when the socket was created. If we were to use the current
>net's mode instead, then the lookup would fail and the socket would
>break.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v9:
>- use xchg(), WRITE_ONCE(), READ_ONCE() for mode and mode_locked (Stefano)
>- clarify mode0/mode1 meaning in vsock_net_check_mode() comment
>- remove spin lock in net->vsock (not used anymore)
>- change mode from u8 to enum vsock_net_mode in vsock_net_write_mode()
>
>Changes in v7:
>- clarify vsock_net_check_mode() comments
>- change to `orig_net_mode == VSOCK_NET_MODE_GLOBAL && orig_net_mode == vsk->orig_net_mode`
>- remove extraneous explanation of `orig_net_mode`
>- rename `written` to `mode_locked`
>- rename `vsock_hdr` to `sysctl_hdr`
>- change `orig_net_mode` to `net_mode`
>- make vsock_net_check_mode() more generic by taking just net pointers
>  and modes, instead of a vsock_sock ptr, for reuse by transports
>  (e.g., vhost_vsock)
>
>Changes in v6:
>- add orig_net_mode to store mode at creation time which will be used to
>  avoid breakage when namespace changes mode during socket/VM lifespan
>
>Changes in v5:
>- use /proc/sys/net/vsock/ns_mode instead of /proc/net/vsock_ns_mode
>- change from net->vsock.ns_mode to net->vsock.mode
>- change vsock_net_set_mode() to vsock_net_write_mode()
>- vsock_net_write_mode() returns bool for write success to avoid
>  need to use vsock_net_mode_can_set()
>- remove vsock_net_mode_can_set()
>---
> MAINTAINERS                 |  1 +
> include/net/af_vsock.h      | 41 +++++++++++++++++++++++++++++++++++++++++
> include/net/net_namespace.h |  4 ++++
> include/net/netns/vsock.h   | 17 +++++++++++++++++
> 4 files changed, 63 insertions(+)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 0dc4aa37d903..15c590a571f2 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -27098,6 +27098,7 @@ L:	netdev@vger.kernel.org
> S:	Maintained
> F:	drivers/vhost/vsock.c
> F:	include/linux/virtio_vsock.h
>+F:	include/net/netns/vsock.h
> F:	include/uapi/linux/virtio_vsock.h
> F:	net/vmw_vsock/virtio_transport.c
> F:	net/vmw_vsock/virtio_transport_common.c
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index d40e978126e3..f3c3f74355e8 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -10,6 +10,7 @@
>
> #include <linux/kernel.h>
> #include <linux/workqueue.h>
>+#include <net/netns/vsock.h>
> #include <net/sock.h>
> #include <uapi/linux/vm_sockets.h>
>
>@@ -65,6 +66,7 @@ struct vsock_sock {
> 	u32 peer_shutdown;
> 	bool sent_request;
> 	bool ignore_connecting_rst;
>+	enum vsock_net_mode net_mode;
>
> 	/* Protected by lock_sock(sk) */
> 	u64 buffer_size;
>@@ -256,4 +258,43 @@ static inline bool vsock_msgzerocopy_allow(const struct vsock_transport *t)
> {
> 	return t->msgzerocopy_allow && t->msgzerocopy_allow();
> }
>+
>+static inline enum vsock_net_mode vsock_net_mode(struct net *net)
>+{
>+	return READ_ONCE(net->vsock.mode);
>+}
>+
>+static inline bool vsock_net_write_mode(struct net *net, enum vsock_net_mode mode)
>+{
>+	if (xchg(&net->vsock.mode_locked, true))

LGTM, but it seems that some architecture doesn't support xchg on 1 
byte, e.g. see commit d66a65b7f5d2 ("scsi: elx: efct: Fix link error for 
_bad_cmpxchg")

So maybe we just need to change the type of mode_locked to int.

The rest LGTM.

Stefano

>+		return false;
>+
>+	WRITE_ONCE(net->vsock.mode, mode);
>+	return true;
>+}
>+
>+/* Return true if two namespaces and modes pass the mode rules. Otherwise,
>+ * return false.
>+ *
>+ * - ns0 and ns1 are the namespaces being checked.
>+ * - mode0 and mode1 are the vsock namespace modes of ns0 and ns1 at the time
>+ *   the vsock objects were created.
>+ *
>+ * Read more about modes in the comment header of net/vmw_vsock/af_vsock.c.
>+ */
>+static inline bool vsock_net_check_mode(struct net *ns0, enum vsock_net_mode mode0,
>+					struct net *ns1, enum vsock_net_mode mode1)
>+{
>+	/* Any vsocks within the same network namespace are always reachable,
>+	 * regardless of the mode.
>+	 */
>+	if (net_eq(ns0, ns1))
>+		return true;
>+
>+	/*
>+	 * If the network namespaces differ, vsocks are only reachable if both
>+	 * were created in VSOCK_NET_MODE_GLOBAL mode.
>+	 */
>+	return mode0 == VSOCK_NET_MODE_GLOBAL && mode0 == mode1;
>+}
> #endif /* __AF_VSOCK_H__ */
>diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
>index cb664f6e3558..66d3de1d935f 100644
>--- a/include/net/net_namespace.h
>+++ b/include/net/net_namespace.h
>@@ -37,6 +37,7 @@
> #include <net/netns/smc.h>
> #include <net/netns/bpf.h>
> #include <net/netns/mctp.h>
>+#include <net/netns/vsock.h>
> #include <net/net_trackers.h>
> #include <linux/ns_common.h>
> #include <linux/idr.h>
>@@ -196,6 +197,9 @@ struct net {
> 	/* Move to a better place when the config guard is removed. */
> 	struct mutex		rtnl_mutex;
> #endif
>+#if IS_ENABLED(CONFIG_VSOCKETS)
>+	struct netns_vsock	vsock;
>+#endif
> } __randomize_layout;
>
> #include <linux/seq_file_net.h>
>diff --git a/include/net/netns/vsock.h b/include/net/netns/vsock.h
>new file mode 100644
>index 000000000000..21189d7bdd4e
>--- /dev/null
>+++ b/include/net/netns/vsock.h
>@@ -0,0 +1,17 @@
>+/* SPDX-License-Identifier: GPL-2.0 */
>+#ifndef __NET_NET_NAMESPACE_VSOCK_H
>+#define __NET_NET_NAMESPACE_VSOCK_H
>+
>+#include <linux/types.h>
>+
>+enum vsock_net_mode {
>+	VSOCK_NET_MODE_GLOBAL,
>+	VSOCK_NET_MODE_LOCAL,
>+};
>+
>+struct netns_vsock {
>+	struct ctl_table_header *sysctl_hdr;
>+	enum vsock_net_mode mode;
>+	bool mode_locked;
>+};
>+#endif /* __NET_NET_NAMESPACE_VSOCK_H */
>
>-- 
>2.47.3
>

