Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460C952BE3A
	for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 12:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068121; cv=none; b=ZlNLbYlN7+Ci2utk+SyN5t3dLkECSuto1tzbWGBQMGriFvyTZwmCZV9rlv9XpbT+jxqLG1j5WVxLfisNgRMfrQ78Cq+/UJDBBxzalztFRqaYxZT+HKait4Rgfzad/W3GvbdAo7rXGH3OiIOUpEUeajOeKdLFYEMTb82agc2AjrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068121; c=relaxed/simple;
	bh=UcJGkwqiMjGtSF6NA79GHlmLHfxRC4ibcg8xqEoW8S0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UxUCE22eJiCdCee2CZsxzeZBIZJJVV+msokRWwTS5ml5KHpKUqDgXKUkuaww8RUxWKQB0DQdZqtRzL9/t1XuVVCuF/Wvo+N4MPYVBW3saZnylMsFuHn+qu3NVJMy9W1MNEzmoJOZG9a31ncngrsv9bG94kL7dMX4BmZ9aBuXIGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cybsk0KQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cybsk0KQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792068118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8G626NslS9713bDGKxdM9ANXWftz+fd8qMceZqc0Pgo=;
	b=Cybsk0KQtukqT11qGe8LYcivDjlXRDYqdpor6ctJOgQZQShqTABOPivkNEBqVTG4GtI41W
	47NT6jYC7GpQsxvLTOEfddhNtROpRxAf7R8xvWnC6sIA7vYLpHWmB4CRbxxolpx5HxMb3C
	ZJMermseU2qKgyceUCZRfQFzqHRBh4g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-_GUdHFbwMz-cXd08D0FakQ-1; Thu, 15 Oct 2026 12:41:48 +0000
X-MC-Unique: _GUdHFbwMz-cXd08D0FakQ-1
X-Mimecast-MFC-AGG-ID: _GUdHFbwMz-cXd08D0FakQ_1792068107
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48c7fe9736eso4240346f8f.0
        for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 05:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792068107; x=1792672907;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8G626NslS9713bDGKxdM9ANXWftz+fd8qMceZqc0Pgo=;
        b=ocoptGP2LHLK8OF/GKqc5Hzh0W+27E4khyX2CuZdaVPDOO/1NMVolREWssj3T7cD10
         QetHPvEcFjteta45m9CbHWsI9VEAgFMr70b3LKy3Gh/zhulGEwVdkfeSI7pf8k9224OL
         DDjv4EYsivZ5Nj/vQv1VpPyT5SIqKrQ9uI4iBokmzvPt/JVrHyZ2J15c+Y3B2dzghCGh
         UUPIq6g4ZmtYh/jOM7rSplCMqOsuLSdhXhzEQQ1++ZRAVHHKisviestv94Hmw5ziAtME
         7oSHVnxpmEi2JS7IQJ9Ay0cDB3M62NpM90bpBMomjjaqUtSug7t3V6/s1OzVRS8+kVWP
         dR1Q==
X-Forwarded-Encrypted: i=1; AKwUvByjM0Z8hbN5vydsaGAgavAqUf9sCU6ArYojfv5p2lg6w4u6RADroMvxafvECAMo3BuFzio/lqXze8LyUPTi0A==@lists.linux.dev
X-Gm-Message-State: AFq9FYLv0DTv+GWSfs2Kh09JHkPbTdVuJnEJmBhuN8F4LlUbPrjg4Jbj
	g5aTjmyYQY06qX7qi8B6YhGmOTX7T00g1UsySym1jq2AhkI1/ah3P1RaUggcKvM5qRfIwtC92nM
	/hO45cdUxboDnX6sqk05iw9RNQCwd1XaExxLWP2Nvuf70v7uI8CxP5uZmk6zfNqL64MMJ
X-Gm-Gg: AYBFou3D7SwUV7X6rSUpsAN5LVl2bJb306IC7IaIARTB2Asur0DN5WGNTnH93ngYPe1
	sUsmZ4uEgwrrdwHVDfZfZeX08VN1Ho6+a6wE60LFsUsI+NaVCKBFBsLgMR21Itg9x+yyiauVgHs
	b1PN+6uHOsFG0NfPq+EhmfVka5DN4F4laPBC9NjdMT+JC08QEkizMcHnU0sCxmyXnIbhxsia9xU
	/ExqOp9Aqt0dc7w01dOUN5j6TINOyRrrUhLHNwmlzIb+MZDWwvtoZjZskZeCQEUFyVuSucNzbdF
	YKXQ/5bMJFngShthYzVyqARno6XoTECqfL925DZiw+t4rHZAhorR22T0bClv/WaUjkleuw==
X-Received: by 2002:a05:6000:491b:b0:48b:e50:7152 with SMTP id ffacd0b85a97d-48df0134f9dmr7487615f8f.28.1792068106164;
        Thu, 15 Oct 2026 05:41:46 -0700 (PDT)
X-Received: by 2002:a05:6000:491b:b0:48b:e50:7152 with SMTP id ffacd0b85a97d-48df0134f9dmr7487547f8f.28.1792068105517;
        Thu, 15 Oct 2026 05:41:45 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48df5ac1093sm3458581f8f.44.2026.10.15.05.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:41:42 -0700 (PDT)
Date: Thu, 15 Oct 2026 08:41:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Rusty Russell <rusty@rustcorp.com.au>,
	Max Krasnyansky <maxk@qualcomm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Simon Horman <horms@kernel.org>, linux-doc@vger.kernel.org
Subject: [PATCH net-next v2 5/7] net: add a sysctl to opt out of virtio net
 hdr checksum validation
Message-ID: <ad05a40681719a579691a1da6413f0dd7064f2a0.1792067836.git.mst@redhat.com>
References: <cover.1792067836.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1792067836.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pkZR0OGARe1sPSou9aHnuM4NDpWjxNEmQtUxB07qKhI_1792068107
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
 Documentation/admin-guide/sysctl/net.rst | 15 +++++++
 include/linux/virtio_net.h               | 23 ++++++++++
 include/net/netns/core.h                 |  1 +
 net/core/dev.c                           |  6 +++
 net/core/net_namespace.c                 |  1 +
 net/core/sysctl_net_core.c               | 54 ++++++++++++++++++++++++
 6 files changed, 100 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index e586e17fc7a5..7f230929c37e 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -246,6 +246,21 @@ processes are dropped unless socket option SOF_TIMESTAMPING_OPT_TSONLY is set.
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
+Default: 1 (on)
+
+
 wmem_default
 ------------
 
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 357115ff0ec2..aa2f8ac4657c 100644
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
@@ -152,6 +166,12 @@ virtio_net_csum_partial_ok_at_offset(struct sk_buff *skb, u8 hdr_gso_type,
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
 
@@ -483,6 +503,9 @@ virtio_net_tnl_offsets_ok(struct sk_buff *skb, bool outer_isv6,
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
index eb35da3556f4..c784c0143b0e 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/sched/isolation.h>
 #include <linux/hex.h>
+#include <linux/jump_label.h>
 
 #include <net/ip.h>
 #include <net/sock.h>
@@ -678,6 +679,48 @@ static struct ctl_table net_core_table[] = {
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
@@ -737,6 +780,15 @@ static const struct ctl_table netns_core_table[] = {
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
@@ -841,6 +893,8 @@ static __net_exit void sysctl_core_net_exit(struct net *net)
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

