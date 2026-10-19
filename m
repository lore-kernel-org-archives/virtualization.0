Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F974EB87C
	for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 12:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792411425; cv=none; b=QgMoc3dBrPMowAXMwf+kC4tvtDKOj5W3KwZYio2w/YmiDuAqwoHik6pZKUtFeEM2nugxUlm7x1B8JqDWoWyWDTre+3hH75okVNwUFodWrNP4D7yAxtEU33Oe8zVl9aTJ+b1SC6izM7a60fxEftdH5/xHYu1YeYcjV7IUwVbKc5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792411425; c=relaxed/simple;
	bh=GYG/wROZyn9yWeSLhWnGtSwcLFkx0ZKTvigP/MSUhuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TYd9TbrolVT/j+PByM1LFoquqZRV7B19H14mWyZM5QVXRCikFDGoCfnNPvTqeutrTtY4oLJb4UcEV60dZt8EyomWx/hpUdumQK6OeLhgref3aGf5vkykCYxCtaMplwO6dZeVMsWdWUAcSRvv9VfnV4/G/GCo9eTaZoDX8B2SLFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IQZ3eDOu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQZ3eDOu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792411421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jiIpdFi7wq8bySoNKTHttc7wqvbUqA359o6ksyHXeoI=;
	b=IQZ3eDOufRuAPlGhk6imGLNLb/hDYqD5aVJvnicYm/sPAzdyrINYCi3mqXTID6ASyCG0xz
	pZGGYTjZdjyO4q0FITqmVBnICP0pqokn3/GF4YWPgmGciCwOCWSfGYAZOwkL40p8seZ67D
	2dyWuGIenEgIEby4SbkE/j1mz0DaSAE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-_77V7TfKMgq5gEXyF2rRkA-1; Mon, 19 Oct 2026 12:03:40 +0000
X-MC-Unique: _77V7TfKMgq5gEXyF2rRkA-1
X-Mimecast-MFC-AGG-ID: _77V7TfKMgq5gEXyF2rRkA_1792411419
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49953abe51fso15894145e9.1
        for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 05:03:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792411419; x=1793016219;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jiIpdFi7wq8bySoNKTHttc7wqvbUqA359o6ksyHXeoI=;
        b=IJRic9x7+8HN4TRrgWth2MwBra15XeCCRY45sXj2i+rucD6K64u4xLCRyxBCHWFLo7
         O3GWJ8oc62SBUWJPgFTE1hIpvDSO8GgqMUP/Mx2ZTNDeqSu63XxuH1qnDS2TSioYnGy5
         cH0pZCyfE0qGubIhrqoE6b5T+epi3fpKhFZBsDi6ru7UVfQwEAp3etJtRCAG634OSfak
         EJ6vWVWOzRaoB2KEG6p3jL5sKYdigC9pQwrZWQ6L7OvaXH/2W94/Cll3lAoHPn8wGCN3
         KqbDqfLHmrnNlVif+SBHlteCSeFLKdP0F/r1G/qCYma6EnLg+2gxX0GQnQauOB2RWjiS
         HoKQ==
X-Forwarded-Encrypted: i=1; AKwUvBzcR/82reIpv/ebFQrDY1uTLnGnXdmRS7voo6n0ItQGDYr/fLeZfJxqZCZO7XeOn4HXd8W6IlDB1jU1RKxB+Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYIyg26+AY0ztpjedzHvYXrj399Cqd/EaujIBXDCrot4Rvj2mJyV
	rhTcFmJfMOYLbbOKJ+g32p/8ryN7XgioPFPDqJ0GbAVQmsyrH7eB5BmpW7EW4ss8kPTM3ZbWa2v
	910Z5yV0MEJUwCHRC5GZSssoX8Q1YyVtyKa7T6rdIbAez2mo4v4CLzNMlrJF3piDa2B/j
X-Gm-Gg: AYBFou1PGeLzUCNkR8jfhtnc2/OFpI1koxSERQu81VJexdtWDyONKqrFHIEnoo+6GHU
	+sLht8lIAp8KNourhJ/WDjjD4ALrw5mSE5a8z0Db4ebti/c5oB4mJRdxJ59810VHvsh13z1t6Hb
	Z9ekccEQojOcsW54T5ArAdG3u5Eg+vVRVmqhfDifub0iSabXGV9VFNZXDYdGr0lIl7bitKP1F9g
	q51wlV8Kxezwbq1D5VMuDei/d5uKMg+8CZb30hGg5xRsI7ZAMFOELHxKy7jRfGJ3lfZAxhSnVEV
	jwgiZfN3DcEy7jA1oz+i3HaW6pvMm9xMeEcqDNRBYUJ+xNw2G8O/Wq43buBz40Do1SmgGQ==
X-Received: by 2002:a05:600c:6207:b0:4a1:e3e4:c438 with SMTP id 5b1f17b1804b1-4a1e3e4c4efmr78430495e9.26.1792411418256;
        Mon, 19 Oct 2026 05:03:38 -0700 (PDT)
X-Received: by 2002:a05:600c:6207:b0:4a1:e3e4:c438 with SMTP id 5b1f17b1804b1-4a1e3e4c4efmr78429605e9.26.1792411417380;
        Mon, 19 Oct 2026 05:03:37 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bdbb4a30sm354173035e9.15.2026.10.19.05.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 05:03:34 -0700 (PDT)
Date: Mon, 19 Oct 2026 08:03:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Chris Arges <carges@cloudflare.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Phil Sutter <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Simon Horman <horms@kernel.org>, linux-doc@vger.kernel.org
Subject: [PATCH net v3 6/8] net: add a sysctl to opt out of virtio net hdr
 checksum validation
Message-ID: <6f23c55c6eba3e3ec6b2c7e3a80728a326ed58af.1792411304.git.mst@redhat.com>
References: <cover.1792411304.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1792411304.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7DpZl45OV691CxZsCmcea2YdlnbtomujKHyoKqaOqbE_1792411419
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The ingress validation as implemented by the previous
patch is stricter than what it replaced: GSO
packets whose checksum metadata matches no transport header are
dropped, and non-GSO ones get their checksum completed in place.
Such packets used to pass with the metadata unvalidated,
and with no overhead.

I judge that this should not affect any deployments, but there is still
some risk that it does.  In case a deployment depends on them anyway,
provide a per-netns switch to get the old behavior back:

echo 0 > /proc/sys/net/core/virtio_net_hdr_csum_check

The default is validating.

Assisted-by: LLM
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 Documentation/admin-guide/sysctl/net.rst | 19 ++++++++
 include/linux/virtio_net.h               | 23 +++++++++
 include/net/netns/core.h                 |  1 +
 net/core/dev.c                           |  6 +++
 net/core/net_namespace.c                 |  1 +
 net/core/sysctl_net_core.c               | 60 ++++++++++++++++++++++++
 6 files changed, 110 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index e586e17fc7a5..b1a1c4714b22 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -246,6 +246,25 @@ processes are dropped unless socket option SOF_TIMESTAMPING_OPT_TSONLY is set.
 Default: 1 (on)
 
 
+virtio_net_hdr_csum_check
+-------------------------
+
+When processing packets with a virtio net header (through tun, tap, a
+packet socket or a virtio network device) that request checksum offload
+(VIRTIO_NET_HDR_F_NEEDS_CSUM), validate the packet: complete the checksum
+in software, or drop the packet where the header does not match it.
+
+When disabled, the header is trusted not to corrupt the packet, and the
+checksum is offloaded to hardware (or not verified if it never reaches
+hardware). This is only safe if no protocol is processing the packets.
+
+The setting is per network namespace, but only writable by the host
+root: root inside a network namespace created by an unprivileged user
+cannot disable the validation.
+
+Default: 1 (on)
+
+
 wmem_default
 ------------
 
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 97b554ef7123..25aa95c11e31 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -5,6 +5,7 @@
 #include <linux/if_vlan.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
+#include <linux/jump_label.h>
 #include <linux/netdevice.h>
 #include <linux/udp.h>
 #include <net/gso.h>
@@ -78,6 +79,19 @@ static inline struct iphdr *virtio_net_ip4_parse(struct sk_buff *skb,
 	*thoff = nhoff + iph->ihl * sizeof(u32);
 	return iph;
 }
+/* Defined in net/core/dev.c, enabled while any network namespace
+ * has net.core.virtio_net_hdr_csum_check set to 0.
+ */
+DECLARE_STATIC_KEY_FALSE(virtio_net_hdr_csum_check_disabled_key);
+
+/* Failsafe: a namespace can disable the check with
+ * net.core.virtio_net_hdr_csum_check.
+ */
+static inline bool virtio_net_hdr_csum_check_disabled(struct sk_buff *skb)
+{
+	return static_branch_unlikely(&virtio_net_hdr_csum_check_disabled_key) &&
+	       !READ_ONCE(dev_net(skb->dev)->core.sysctl_virtio_net_hdr_csum_check);
+}
 
 /* Where does the L3 header start, and what protocol is it?
  * Handles Ethernet and VLAN headers; other devices use the
@@ -179,6 +193,12 @@ virtio_net_csum_partial_ok_at_offset(struct sk_buff *skb, u8 hdr_gso_type,
 	unsigned int thoff;
 	int ip_proto;
 
+	/* Failsafe: a namespace opted out of the validation,
+	 * trust the checksum metadata as before.
+	 */
+	if (virtio_net_hdr_csum_check_disabled(skb))
+		return true;
+
 	if (!virtio_net_l4_start(skb, nhoff, proto, &thoff, &ip_proto))
 		return false;
 
@@ -516,6 +536,9 @@ virtio_net_tnl_offsets_ok(struct sk_buff *skb, bool outer_isv6,
 	unsigned int thoff;
 	int ip_proto;
 
+	if (virtio_net_hdr_csum_check_disabled(skb))
+		return true;
+
 	if (!virtio_net_l3_start(skb, &nhoff, &proto))
 		return false;
 	if (outer_isv6 != (proto == htons(ETH_P_IPV6)))
diff --git a/include/net/netns/core.h b/include/net/netns/core.h
index 9ef3d70e5e9c..ae8110772c97 100644
--- a/include/net/netns/core.h
+++ b/include/net/netns/core.h
@@ -18,6 +18,7 @@ struct netns_core {
 	u8	sysctl_txrehash;
 	u8	sysctl_tstamp_allow_data;
 	u8	sysctl_bypass_prot_mem;
+	u8	sysctl_virtio_net_hdr_csum_check;
 
 #ifdef CONFIG_PROC_FS
 	struct prot_inuse __percpu *prot_inuse;
diff --git a/net/core/dev.c b/net/core/dev.c
index e76762e29360..d14950b1af3a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2389,6 +2389,12 @@ EXPORT_SYMBOL(tcf_sw_enabled_key);
 
 DEFINE_STATIC_KEY_FALSE(netstamp_needed_key);
 EXPORT_SYMBOL(netstamp_needed_key);
+
+/* Enabled while any network namespace has net.core.virtio_net_hdr_csum_check
+ * set to 0.
+ */
+DEFINE_STATIC_KEY_FALSE(virtio_net_hdr_csum_check_disabled_key);
+EXPORT_SYMBOL(virtio_net_hdr_csum_check_disabled_key);
 #ifdef CONFIG_JUMP_LABEL
 static atomic_t netstamp_needed_deferred;
 static atomic_t netstamp_wanted;
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index da5f881fbd3b..2d340fafba85 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -396,6 +396,7 @@ static __net_init void preinit_net_sysctl(struct net *net)
 	net->core.sysctl_optmem_max = 128 * 1024;
 	net->core.sysctl_txrehash = SOCK_TXREHASH_ENABLED;
 	net->core.sysctl_tstamp_allow_data = 1;
+	net->core.sysctl_virtio_net_hdr_csum_check = 1;
 	net->core.sysctl_txq_reselection = msecs_to_jiffies(1000);
 }
 
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index eb35da3556f4..c65ff86cc5f9 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/sched/isolation.h>
 #include <linux/hex.h>
+#include <linux/jump_label.h>
 
 #include <net/ip.h>
 #include <net/sock.h>
@@ -678,6 +679,54 @@ static struct ctl_table net_core_table[] = {
 	},
 };
 
+/* Defined in net/core/dev.c, declared for the gate in
+ * include/linux/virtio_net.h.
+ */
+DECLARE_STATIC_KEY_FALSE(virtio_net_hdr_csum_check_disabled_key);
+
+/*
+ * Protects changes to virtio_net_hdr_csum_check_disabled_key and each
+ * net->core.sysctl_virtio_net_hdr_csum_check. Readers don't use a lock.
+ */
+static DEFINE_MUTEX(virtio_net_hdr_csum_check_mutex);
+
+static int virtio_net_hdr_csum_check_sysctl(const struct ctl_table *table,
+					    int write, void *buffer,
+					    size_t *lenp, loff_t *ppos)
+{
+	struct net *net = (struct net *)table->data;
+	/* checkpatch warns but this can't be const: tmp.data is set below */
+	struct ctl_table tmp = *table;
+	u8 old;
+	int ret;
+
+	/* Root in a user namespace must not be able to weaken the
+	 * validation for the network namespace it controls.
+	 */
+	if (write && !capable(CAP_NET_ADMIN))
+		return -EPERM;
+
+	/*
+	 * Make sure virtio_net_hdr_csum_check_disabled_key counts zero values of
+	 * net->core.sysctl_virtio_net_hdr_csum_check.
+	 */
+	mutex_lock(&virtio_net_hdr_csum_check_mutex);
+
+	old = net->core.sysctl_virtio_net_hdr_csum_check;
+	tmp.data = &net->core.sysctl_virtio_net_hdr_csum_check;
+	ret = proc_dou8vec_minmax(&tmp, write, buffer, lenp, ppos);
+	if (write && !ret && old != net->core.sysctl_virtio_net_hdr_csum_check) {
+		if (net->core.sysctl_virtio_net_hdr_csum_check)
+			static_branch_dec(&virtio_net_hdr_csum_check_disabled_key);
+		else
+			static_branch_inc(&virtio_net_hdr_csum_check_disabled_key);
+	}
+
+	mutex_unlock(&virtio_net_hdr_csum_check_mutex);
+
+	return ret;
+}
+
 static const struct ctl_table netns_core_table[] = {
 #if IS_ENABLED(CONFIG_RPS)
 	{
@@ -737,6 +786,15 @@ static const struct ctl_table netns_core_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE
 	},
+	{
+		.procname	= "virtio_net_hdr_csum_check",
+		.data		= &init_net,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= virtio_net_hdr_csum_check_sysctl,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE
+	},
 	/* sysctl_core_net_init() will set the values after this
 	 * to readonly in network namespaces
 	 */
@@ -841,6 +899,8 @@ static __net_exit void sysctl_core_net_exit(struct net *net)
 	tbl = net->core.sysctl_hdr->ctl_table_arg;
 	unregister_net_sysctl_table(net->core.sysctl_hdr);
 	BUG_ON(tbl == netns_core_table);
+	if (!net->core.sysctl_virtio_net_hdr_csum_check)
+		static_branch_dec(&virtio_net_hdr_csum_check_disabled_key);
 #if IS_ENABLED(CONFIG_RPS)
 	kfree(net->core.rps_default_mask);
 #endif
-- 
MST

