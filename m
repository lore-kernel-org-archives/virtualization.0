Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792768192;
	b=pLXEl0tEMHoTSYwJ75yjKFOI5/AJ5D398jmc7RDZitjLPYCEKSOCzyvRLQDKgmxDnR7L
	 iI9hEzSGFWy+55EgXOD4/KSlrM38yGs89vvixmo/br9AWPczNLdOoC6/my1YTCq4YHygI
	 RLzQM0qJInc4GqbwtJWd/fzzm9VhJZh+aC92eQnAazoeIL3AN/wTkhmbrYvNMXAk/UbLR
	 wNYJ8goPiwqaa5YwL0j1Xdpiz0ye0qGC65VpgZB7eTwgLQfeoBg0jLMazMzQxvCeBvk8G
	 bC/Cs3QjQEIfxjfpTtiu8jAvb8ABRvshqgo6IpbwB5KUvgZHvc0OpsfJCHh8E7sCuag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792768192;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mailer:X-Mutt-Fcc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding;
	bh=mXloVW6rZxDahnxqb4ykjI1/+DaQ13fITP+bGDCTCpc=;
	b=xqYwQF9uTJHLWzK+OnZ02xLSj4NyGkt0qkcFmohlePAl78mAEfu5JVKin/4dD/fqxyUv
	 GedyTNrjsLxP3d777Dch/NZ3IKkgPL3v5FAqhyYmY3WdV+mHBT4U49Ewxw3r+3jZQbn+k
	 KJjfvwo1XcLgPerLCwJCeZbZYdVYxkCQSDpSqxxqC2K0Y999qDQxu3As04S6K7pos8yFH
	 7XrG/HdNwIFRmFJUHi0AyxRgmanBLij5XtEExYttoELZndrUPoTTE8cySl1t09043w54j
	 MXEecDijdWy9U+Fvc45nJerrZKuzhNAa7BjiRrTzU0KJgIV6dQzC6WR4ZoUl7USsAjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KHOWVnbt;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C95960A6F61
	for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 15:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C95960A6F61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KHOWVnbt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792768191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mXloVW6rZxDahnxqb4ykjI1/+DaQ13fITP+bGDCTCpc=;
	b=KHOWVnbtovRehnx1uxB5IL/ATzX3NKHOs9Ez1+8z/vySp2T9I8RzpKEdqA+qCSAcUTELZ+
	j+cFWfuMJhUx+EwnncLzj/kzg2Mw7lsJcJWxKjAZjsZjI2sKHQ77+IgRHgmH0DRxdp06s8
	qtm2+vIHI/RrFe/y/dxG8IbAv+FDggs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-Z8EnLWqhMQefsdnnseD6pw-1; Fri, 23 Oct 2026 11:09:47 -0400
X-MC-Unique: Z8EnLWqhMQefsdnnseD6pw-1
X-Mimecast-MFC-AGG-ID: Z8EnLWqhMQefsdnnseD6pw_1792768187
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48af4a0bd0fso530888f8f.2
        for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 08:09:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792768186; x=1793372986;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mXloVW6rZxDahnxqb4ykjI1/+DaQ13fITP+bGDCTCpc=;
        b=uKrOTGrqWMFec7hWCfleXmFJs8Q5uytDdc05HWbcW4Noo18Eyn6fV8tBUYboixp6qd
         0SFmAuPlDOWy/BKwBefe5f3RODYfJGbOG7kMaburGcPLIksLo24VG/kp09Y+5h96PDhC
         buvQ9QawvFQXOxNmDAtAlBxHc+OO6c1xhb3f+USvAuzIJ/GM21z+mikpUmjxM49oj8Bh
         R7MxZ4R6+gtG2DkVRxr2Ek/a8s7L/2OK2MafD2aYCjxtdvoXjbhPaUZT4jYVnKE5N8gj
         d/RjDYcylHZxcAor4/WsfPme37vPerjKNPdmqEAipSknf1LdrBFqnbRnk16hpLNLlD4e
         XNWA==
X-Forwarded-Encrypted: i=1; AKwUvBzPA7rWEPgLbKjiovLA+FYTNvn+6eQEOEnhw/P55sbc0W9OvltztljUoNyBjaQsg1r4fO8yqtT7Cb2rcwJeYw==@lists.linux.dev
X-Gm-Message-State: AFq9FYK07d9e0BN3ndXMwCZM7TSL3FV6bC03zaI58LowjYnvzXxeQLHn
	7MsmegZ0Y+sdXJwMHzMtUn93FIzMO6OqRUVQB1z3VK0S+JGrpXZB+uVU63vVw73MfhhQKfqid0c
	k/Qas0WsGS8ah/wes3Iw8fdcS2ScuQb7WL4aFfd0W9JBz78sdovmAqtAZlziZLRj42MFM
X-Gm-Gg: AYBFou3pMcQP8EUrBSLlZ5wSV26mETRvJn4hj3WHalsvh8OpbeMG5nDgXNxPTfLY/gI
	zHTuj+NlPc2xcIZaOg0oI7/xmh7g6lE3GSqHbGNV3nusJSVw17MKmER+QU/xDqi8N/CwY8S7xpA
	v82z+5nHyHxqjtWSJ4gWl3nqvdK1oJKHV9dh2UyWJp1JJBInRxwgYnyx+dv+2EEK2ghyGjC0F42
	r0Fe0EFICzupDfDQR+/WOUPHhARUkbfxiJl6sN5YrrKWUhjrl6RPs9JHUNnoMR1o2CZ42LrbJ0k
	Rhqg6hyDFNc8LqmfDc8WNVN3MP9UmELyxqARQHyvliJ99YI9NY3ieYERSOl3OsQUQNXcck8=
X-Received: by 2002:a5d:584f:0:b0:48e:261b:a49d with SMTP id ffacd0b85a97d-48e38587cd3mr4057116f8f.15.1792768186337;
        Fri, 23 Oct 2026 08:09:46 -0700 (PDT)
X-Received: by 2002:a5d:584f:0:b0:48e:261b:a49d with SMTP id ffacd0b85a97d-48e38587cd3mr4057050f8f.15.1792768185685;
        Fri, 23 Oct 2026 08:09:45 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73f6:2400:30a8:9e33:7d82:c035])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d410708sm305580f8f.38.2026.10.23.08.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 08:09:43 -0700 (PDT)
Date: Fri, 23 Oct 2026 11:09:41 -0400
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
	Willem de Bruijn <willemb@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Simon Horman <horms@kernel.org>, linux-doc@vger.kernel.org
Subject: [PATCH net v6 5/5] net: add a sysctl to opt out of virtio net hdr
 checksum validation
Message-ID: <a631141eaf64501420583332af5d97d2641a8d98.1792768096.git.mst@redhat.com>
References: <cover.1792768096.git.mst@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <cover.1792768096.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Uyuzl7okyQaqPcI45d3H8WOZZ5ccEjdsVPda0C25ZFw_1792768187
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The ingress validation as implemented by the previous
patch is stricter than what it replaced: GSO
packets whose checksum metadata matches no transport header are
dropped, and non-GSO ones get their checksum completed in place.
Such packets used to pass with the metadata unvalidated,
and with no overhead.

I judge that this should not affect any deployments, but there is still
some risk that it does.  In case a deployment depends on them anyway,
provide a per-netns switch to get the old behavior back:

echo 0 > /proc/sys/net/core/virtio_net_hdr_validate

The default is validating.

Reviewed-by: Björn Töpel <bjorn@kernel.org>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Notes (changelog):
    v4->v5:
        document the netns lifetime requirement (sashiko)

 Documentation/admin-guide/sysctl/net.rst | 19 +++++++++
 include/linux/virtio_net.h               | 25 ++++++++++++
 include/net/netns/core.h                 |  1 +
 net/core/dev.c                           |  7 ++++
 net/core/net_namespace.c                 |  1 +
 net/core/sysctl_net_core.c               | 50 ++++++++++++++++++++++++
 6 files changed, 103 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index e586e17fc7a5..3c0223575438 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -246,6 +246,25 @@ processes are dropped unless socket option SOF_TIMESTAMPING_OPT_TSONLY is set.
 Default: 1 (on)
 
 
+virtio_net_hdr_validate
+-----------------------
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
index 14120710d075..c6b5957b3248 100644
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
@@ -85,6 +86,18 @@ static inline struct iphdr *virtio_net_ip4_parse(struct sk_buff *skb,
 	return (struct iphdr *)(skb->data + nhoff);
 }
 
+/* Defined in net/core/dev.c, enabled while any network namespace
+ * has net.core.virtio_net_hdr_validate set to 0.
+ */
+DECLARE_STATIC_KEY_FALSE(virtio_net_hdr_validate_disabled_key);
+
+/*The caller must keep the netns of skb->dev alive. */
+static inline bool virtio_net_hdr_validate_disabled(struct sk_buff *skb)
+{
+	return static_branch_unlikely(&virtio_net_hdr_validate_disabled_key) &&
+	       !READ_ONCE(dev_net(skb->dev)->core.sysctl_virtio_net_hdr_validate);
+}
+
 /* Where does the L3 header start, and what protocol is it?
  * Handles Ethernet and VLAN headers; other devices use the
  * network header offset the caller set up.
@@ -198,6 +211,12 @@ virtio_net_csum_partial_ok_at_offset(struct sk_buff *skb, u8 hdr_gso_type,
 	unsigned int thoff;
 	int ip_proto;
 
+	/* Failsafe: a namespace opted out of the validation,
+	 * trust the checksum metadata as before.
+	 */
+	if (virtio_net_hdr_validate_disabled(skb))
+		return true;
+
 	if (!virtio_net_l4_start(skb, nhoff, proto, &thoff, &ip_proto))
 		return false;
 
@@ -240,6 +259,9 @@ virtio_net_csum_partial_ok(struct sk_buff *skb, u8 hdr_gso_type)
 	int nhoff;
 	__be16 proto;
 
+	if (virtio_net_hdr_validate_disabled(skb))
+		return true;
+
 	if (!virtio_net_l3_start(skb, &nhoff, &proto))
 		return false;
 
@@ -531,6 +553,9 @@ virtio_net_tnl_offsets_ok(struct sk_buff *skb, bool outer_isv6,
 	unsigned int thoff;
 	int ip_proto;
 
+	if (virtio_net_hdr_validate_disabled(skb))
+		return true;
+
 	if (!virtio_net_l3_start(skb, &nhoff, &proto))
 		return false;
 	if (outer_isv6 != (proto == htons(ETH_P_IPV6)))
diff --git a/include/net/netns/core.h b/include/net/netns/core.h
index 9ef3d70e5e9c..02ce232fe9a9 100644
--- a/include/net/netns/core.h
+++ b/include/net/netns/core.h
@@ -18,6 +18,7 @@ struct netns_core {
 	u8	sysctl_txrehash;
 	u8	sysctl_tstamp_allow_data;
 	u8	sysctl_bypass_prot_mem;
+	u8	sysctl_virtio_net_hdr_validate;
 
 #ifdef CONFIG_PROC_FS
 	struct prot_inuse __percpu *prot_inuse;
diff --git a/net/core/dev.c b/net/core/dev.c
index e76762e29360..43b8823c83f6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -128,6 +128,7 @@
 #include <linux/if_vlan.h>
 #include <linux/ip.h>
 #include <net/ip.h>
+#include <linux/virtio_net.h>
 #include <net/mpls.h>
 #include <linux/ipv6.h>
 #include <linux/in.h>
@@ -2389,6 +2390,12 @@ EXPORT_SYMBOL(tcf_sw_enabled_key);
 
 DEFINE_STATIC_KEY_FALSE(netstamp_needed_key);
 EXPORT_SYMBOL(netstamp_needed_key);
+
+/* Enabled while any network namespace has net.core.virtio_net_hdr_validate
+ * set to 0.
+ */
+DEFINE_STATIC_KEY_FALSE(virtio_net_hdr_validate_disabled_key);
+EXPORT_SYMBOL(virtio_net_hdr_validate_disabled_key);
 #ifdef CONFIG_JUMP_LABEL
 static atomic_t netstamp_needed_deferred;
 static atomic_t netstamp_wanted;
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index da5f881fbd3b..8a21baaa7e6d 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -396,6 +396,7 @@ static __net_init void preinit_net_sysctl(struct net *net)
 	net->core.sysctl_optmem_max = 128 * 1024;
 	net->core.sysctl_txrehash = SOCK_TXREHASH_ENABLED;
 	net->core.sysctl_tstamp_allow_data = 1;
+	net->core.sysctl_virtio_net_hdr_validate = 1;
 	net->core.sysctl_txq_reselection = msecs_to_jiffies(1000);
 }
 
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index eb35da3556f4..3e4037b82a97 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -18,6 +18,8 @@
 #include <linux/slab.h>
 #include <linux/sched/isolation.h>
 #include <linux/hex.h>
+#include <linux/virtio_net.h>
+#include <linux/jump_label.h>
 
 #include <net/ip.h>
 #include <net/sock.h>
@@ -678,6 +680,43 @@ static struct ctl_table net_core_table[] = {
 	},
 };
 
+/* Protects changes to virtio_net_hdr_validate_disabled_key and each
+ * net->core.sysctl_virtio_net_hdr_validate.  The packet path reads
+ * the value without a lock.
+ */
+static DEFINE_MUTEX(virtio_net_hdr_validate_mutex);
+
+static int virtio_net_hdr_validate_sysctl(const struct ctl_table *table,
+					  int write, void *buffer,
+					  size_t *lenp, loff_t *ppos)
+{
+	u8 *value = table->data;
+	u8 old, new;
+	int ret;
+
+	/* Root in a user namespace must not be able to weaken the
+	 * validation for the network namespace it controls.
+	 */
+	if (write && !capable(CAP_NET_ADMIN))
+		return -EPERM;
+
+	mutex_lock(&virtio_net_hdr_validate_mutex);
+
+	old = READ_ONCE(*value);
+	ret = proc_dou8vec_minmax(table, write, buffer, lenp, ppos);
+	new = READ_ONCE(*value);
+	if (write && !ret && old != new) {
+		if (new)
+			static_branch_dec(&virtio_net_hdr_validate_disabled_key);
+		else
+			static_branch_inc(&virtio_net_hdr_validate_disabled_key);
+	}
+
+	mutex_unlock(&virtio_net_hdr_validate_mutex);
+
+	return ret;
+}
+
 static const struct ctl_table netns_core_table[] = {
 #if IS_ENABLED(CONFIG_RPS)
 	{
@@ -737,6 +776,15 @@ static const struct ctl_table netns_core_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE
 	},
+	{
+		.procname	= "virtio_net_hdr_validate",
+		.data		= &init_net.core.sysctl_virtio_net_hdr_validate,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= virtio_net_hdr_validate_sysctl,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE
+	},
 	/* sysctl_core_net_init() will set the values after this
 	 * to readonly in network namespaces
 	 */
@@ -841,6 +889,8 @@ static __net_exit void sysctl_core_net_exit(struct net *net)
 	tbl = net->core.sysctl_hdr->ctl_table_arg;
 	unregister_net_sysctl_table(net->core.sysctl_hdr);
 	BUG_ON(tbl == netns_core_table);
+	if (!net->core.sysctl_virtio_net_hdr_validate)
+		static_branch_dec(&virtio_net_hdr_validate_disabled_key);
 #if IS_ENABLED(CONFIG_RPS)
 	kfree(net->core.rps_default_mask);
 #endif
-- 
MST

