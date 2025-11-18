Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565AF2DC339
	for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 18:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763489053; cv=none; b=J5qoD3q7bjGNY/A1ctOlePzb23IG0w+huz9uluemynCFymT7emwZiVN6a+JwamkcpbjHTa+kL4GqdsxGRmXtoTfpy/wL/vt6ytgZxKN5IcX+EDPvCKWxhewaMZVkW9CY03+LiiklxyOST3YQJL+7es42HfL8k539sRoCjlxWzHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763489053; c=relaxed/simple;
	bh=s+cwPXsVLSNo1ubmatgKVj1SDIBuFfEsEXm/mCHspCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=G31WsHskw23jbf0C8Vif1Ci5S1FYMqvo2WtWmxr852R/xaeRIkux/DjG47geHycfIfuuamLN2iHC2usGE+vcrXHe0bwzqxr0LkHpSTZ4/8CY2QrhJnJUeb9S+nf7JJcW/wE93XvqZkYPxX2WPMVUykJ93eTIiLYZt/0sWz9ewZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Crhlc/09; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Crhlc/09"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763489049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ySMhDYrMZ/Xx4AMvhjc7dxlay0zt2DHzPjG22vBPrHE=;
	b=Crhlc/09yrplKjsjd+Pw876e/k64zQoQjvKbSD7d5zT17lOl6EFrxxqUQ0keO8jrq3ofLJ
	wWJK2dbIS1iAx7W2uzvM9i8jkBWkV12WduqCiE+IldurObdZVeoHCZRP4bRBpfXgKmrP/o
	BgjGxyYVcJsGmb4bJX2EbkQv9STUzjE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-qCiOLl67NWmCvoa-Zj-cqw-1; Tue, 18 Nov 2025 13:04:06 -0500
X-MC-Unique: qCiOLl67NWmCvoa-Zj-cqw-1
X-Mimecast-MFC-AGG-ID: qCiOLl67NWmCvoa-Zj-cqw_1763489045
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42b478551a6so844996f8f.1
        for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 10:04:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763489045; x=1764093845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ySMhDYrMZ/Xx4AMvhjc7dxlay0zt2DHzPjG22vBPrHE=;
        b=X1brpaq3XWnwF1iA5K9iMiR4dro4iwkGMQ1hN94Y4dAS1Zq9zjVNWclgAQqGlgf7B5
         Pq8mubUuKJowu51SPUsBoGIESAwalbq/Lz5lbaVoAxdROt+28+/ifF2auwIF7WHT+Xqo
         XGMXAPB9U5PcGJgw+3eS8pnhSrMvetiq4JFINDHDN2nN+zCN59HPPeCVNd72XijMosb6
         OmJqrs4l+wuHfsD3NIcQUK0PR9H/3TRl8MXIXllrFaN2magxk3+QQMQZe1VU6I4JQ9Cq
         I3UyWFKsgNNMp0rsFM6pLpvaG6FKMgbv27fGXzvkzMotboZ2VUJYdWUx4RRUkcPAjSBu
         6dag==
X-Forwarded-Encrypted: i=1; AJvYcCWDFtfyJTT3hJveyUc3hReigqBtD0CYqF+sv2GnRdqE/d5fF8BDK5SAnrMXBnLj3Bdk5IEDHWy1ZY4ao2ghgA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyg9qwPlSCjnuMUmGhheHEdgdiMJVWpWFPo6FYORhEz4hUs3SEt
	QaB33MLqsB8PbQrcLczlWZhcgIXBjfY2pipvATIa97ncr8nBC7FRpM+gRazZeB009yerC5ZsSp4
	01XfgNTLIycudIukl/pSNtpfu1oNJIqIGu8YURpUlHz5yBTnTSd7iZrrqH1DThBPyDSS6
X-Gm-Gg: ASbGncskoYIfxJudSJp8sO6TKqwHEC3e1i/dcfWgApBY8XevTSl4eevLhCmZLwXjaH3
	CAKA/wHG0rajxe0v7OZZuobk5S+rsId/vkEbaPayDmgtVmVkQxs4E+4CUyb+vYuRXQL+Iixl5FV
	OjPSSMawWY67P9VZA3yaDG2le5JIEZB1MigEu0IjmdVcNEHdxR3rFOROgtR+BtDTYOU2/0Hvtv6
	zyA6V0nR0VBqIPX30cFCummbesUZ2ky94Fycs+GO/AUcjWeoxQ0FJLv+rfc2CmyuHZQsj3EB5wE
	Uv4JOyI3ErvQ+eFOx8HrYIfx2m9lOjKRGEJNDo4UGXRfOfndHVnFSEbWN4CbMKAt8q+F7LiL+tl
	EuNP1ezHHl5EMe8QNgiea/Ew9klcw55M3IcWE2jilps4qBBAv
X-Received: by 2002:a7b:c014:0:b0:477:994b:dbb8 with SMTP id 5b1f17b1804b1-477994bddeemr81419115e9.11.1763489045235;
        Tue, 18 Nov 2025 10:04:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpBG/2sJMbhkzpQOcxnTlmbcbHN4RuL+yQSZxX8aLutRGg8XkylL+hIZNfpXYQY2Dh7dA7sA==
X-Received: by 2002:a7b:c014:0:b0:477:994b:dbb8 with SMTP id 5b1f17b1804b1-477994bddeemr81418715e9.11.1763489044753;
        Tue, 18 Nov 2025 10:04:04 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-250.retail.telecomitalia.it. [82.57.51.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b10142d3sm3864205e9.5.2025.11.18.10.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 10:04:03 -0800 (PST)
Date: Tue, 18 Nov 2025 19:03:49 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v10 01/11] vsock: a per-net vsock NS mode state
Message-ID: <7qu24adya4hyiu6enzgflua3nac7o3d4ymrhzksjig54p4vh6n@n4ehmhlbh5wn>
References: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
 <20251117-vsock-vmtest-v10-1-df08f165bf3e@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251117-vsock-vmtest-v10-1-df08f165bf3e@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7Ki6XLHtFdcxyePjGz6EhJQoJ2PI0Sutw7JyBIqSDuc_1763489045
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Nov 17, 2025 at 06:00:24PM -0800, Bobby Eshleman wrote:
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
>Changes in v10:
>- change mode_locked to int (Stefano)
>
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
> include/net/af_vsock.h      | 44 ++++++++++++++++++++++++++++++++++++++++++++
> include/net/net_namespace.h |  4 ++++
> include/net/netns/vsock.h   | 17 +++++++++++++++++
> 4 files changed, 66 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 37f4278db851..e1e0e2092d0c 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -27101,6 +27101,7 @@ L:	netdev@vger.kernel.org
> S:	Maintained
> F:	drivers/vhost/vsock.c
> F:	include/linux/virtio_vsock.h
>+F:	include/net/netns/vsock.h
> F:	include/uapi/linux/virtio_vsock.h
> F:	net/vmw_vsock/virtio_transport.c
> F:	net/vmw_vsock/virtio_transport_common.c
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index d40e978126e3..9b5bdd083b6f 100644
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
>@@ -256,4 +258,46 @@ static inline bool vsock_msgzerocopy_allow(const struct vsock_transport *t)
> {
> 	return t->msgzerocopy_allow && t->msgzerocopy_allow();
> }
>+
>+static inline enum vsock_net_mode vsock_net_mode(struct net *net)
>+{
>+	return READ_ONCE(net->vsock.mode);
>+}
>+
>+static inline bool vsock_net_write_mode(struct net *net,
>+					enum vsock_net_mode mode)
>+{
>+	if (xchg(&net->vsock.mode_locked, 1))
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
>+static inline bool vsock_net_check_mode(struct net *ns0,
>+					enum vsock_net_mode mode0,
>+					struct net *ns1,
>+					enum vsock_net_mode mode1)
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
>index 000000000000..c1a5e805949d
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
>+	int mode_locked;
>+};
>+#endif /* __NET_NET_NAMESPACE_VSOCK_H */
>
>-- 
>2.47.3
>

