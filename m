Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0485435B65E
	for <virtualization@lists.linux.dev>; Sun,  8 Feb 2026 14:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770561310; cv=none; b=gUQoInQDLEBn9EYvlCjn+OyLDkYc1+OcIuMfHmc0fkG+G0yK3ItSefNrHKQznqQI321DzDFlA+vDmU/YLXFQf8XftHN8+PvxvB2cjrx2IAz5UlzvrZbsIj0AnipK9xEpvuUC33n+AM9UMn288dK6nQ6xTBusr6BOKbHJz9VuMIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770561310; c=relaxed/simple;
	bh=wqFcfW6h1LSDWP+UoiYxFixHMysJrx5XeQZ09Za9f1A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=qUiDyRHoS7N4Lqy9c/xnvlTjnGkHvxihgwbGw5ESp3XnMH8smCDK2RbgXGewaujONAADePGJu+Ss6dc++RO5vB1Ypua2jl2v9gmm98KbSR8rAXC+2k5NX8HPL+dCR/pQXkr0zrdWqdZGMiqcPoOQ/OsMjIbZv2XtwcmDbcXLjY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AmkBzO2C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AmkBzO2C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770561309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fuXRRboAX7h/UGA1Bg3Zez56bIM2TDoXzKPU/mliA4M=;
	b=AmkBzO2C2/wVWF06qmFMtE1K3nEyT9UsaUDQlNWgDyq7j2HkvGRKPlC1uzkAWuWnptOjf3
	cs9DcFhtNW9ABUTwm2k5lMD0tICMFD6MxPP45iH0VxrDlMM9sGjD7CLtgOtGwnWKS2ju15
	R9ZP+glTzNxnC9vHP5nof0/0MYHWMpY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-YmmV4r8yO-GY1U8dunHN_A-1; Sun,
 08 Feb 2026 09:35:07 -0500
X-MC-Unique: YmmV4r8yO-GY1U8dunHN_A-1
X-Mimecast-MFC-AGG-ID: YmmV4r8yO-GY1U8dunHN_A_1770561306
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4091C195608E;
	Sun,  8 Feb 2026 14:35:06 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.33])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 960F218004BB;
	Sun,  8 Feb 2026 14:35:02 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	mst@redhat.com,
	jasowang@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC 2/3] vhost/net: add netfilter socket support
Date: Sun,  8 Feb 2026 22:32:23 +0800
Message-ID: <20260208143441.2177372-3-lulu@redhat.com>
In-Reply-To: <20260208143441.2177372-1-lulu@redhat.com>
References: <20260208143441.2177372-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: N3QgTE2v2I3pP5FExVM9osH_wB070L7P6FrifR3j3Q4_1770561306
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Introduce the netfilter socket plumbing and the VHOST_NET_SET_FILTER ioctl.
Initialize the netfilter state on open and release it on reset/close.

Key points:
- Add filter_sock + filter_lock to vhost_net
- Validate SOCK_SEQPACKET AF_UNIX filter socket from userspace
- Add vhost_net_set_filter() and VHOST_NET_SET_FILTER ioctl handler
- Initialize filter state on open and clean up on reset/release

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/net.c | 109 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 7f886d3dba7d..f02deff0e53c 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -131,6 +131,7 @@ struct vhost_net_virtqueue {
 	struct vhost_net_buf rxq;
 	/* Batched XDP buffs */
 	struct xdp_buff *xdp;
+
 };
 
 struct vhost_net {
@@ -147,6 +148,15 @@ struct vhost_net {
 	bool tx_flush;
 	/* Private page frag cache */
 	struct page_frag_cache pf_cache;
+
+	/*
+	 * Optional vhost-net filter offload socket.
+	 * When configured, RX packets can be routed through a userspace
+	 * filter chain via a SOCK_SEQPACKET control socket. Access to
+	 * filter_sock is protected by filter_lock.
+	 */
+	struct socket *filter_sock;
+	spinlock_t filter_lock;
 };
 
 static unsigned vhost_net_zcopy_mask __read_mostly;
@@ -1128,6 +1138,95 @@ static int get_rx_bufs(struct vhost_net_virtqueue *nvq,
 	return r;
 }
 
+/*
+ * Validate and acquire the filter socket from userspace.
+ *
+ * Returns:
+ *   - NULL when fd == -1 (explicitly disable filter)
+ *   - a ref-counted struct socket on success
+ *   - ERR_PTR(-errno) on validation failure
+ */
+static struct socket *get_filter_socket(int fd)
+{
+	int r;
+	struct socket *sock;
+
+	/* Special case: userspace asks to disable filter. */
+	if (fd == -1)
+		return NULL;
+
+	sock = sockfd_lookup(fd, &r);
+	if (!sock)
+		return ERR_PTR(-ENOTSOCK);
+
+	if (sock->sk->sk_family != AF_UNIX ||
+	    sock->sk->sk_type != SOCK_SEQPACKET) {
+		sockfd_put(sock);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return sock;
+}
+
+/*
+ * Drop the currently configured filter socket, if any.
+ *
+ * Caller does not need to hold filter_lock; this function clears the pointer
+ * under the lock and releases the socket reference afterwards.
+ */
+static void vhost_net_filter_stop(struct vhost_net *n)
+{
+	struct socket *sock = n->filter_sock;
+
+	spin_lock(&n->filter_lock);
+	n->filter_sock = NULL;
+	spin_unlock(&n->filter_lock);
+
+	if (sock)
+		sockfd_put(sock);
+}
+
+/*
+ * Install or remove a filter socket for this vhost-net device.
+ *
+ * The ioctl passes an fd for a SOCK_SEQPACKET AF_UNIX socket created by
+ * userspace. We validate the socket type, replace any existing filter socket,
+ * and keep a reference so RX path can safely send filter requests.
+ */
+static long vhost_net_set_filter(struct vhost_net *n, int fd)
+{
+	struct socket *sock;
+	int r;
+
+	mutex_lock(&n->dev.mutex);
+	r = vhost_dev_check_owner(&n->dev);
+	if (r)
+		goto out;
+
+	sock = get_filter_socket(fd);
+	if (IS_ERR(sock)) {
+		r = PTR_ERR(sock);
+		goto out;
+	}
+
+	vhost_net_filter_stop(n);
+
+	if (!sock) {
+		r = 0;
+		goto out;
+	}
+
+	spin_lock(&n->filter_lock);
+	n->filter_sock = sock;
+	spin_unlock(&n->filter_lock);
+
+	r = 0;
+
+out:
+	mutex_unlock(&n->dev.mutex);
+	return r;
+}
+
 /* Expects to be always run from workqueue - which acts as
  * read-size critical section for our kind of RCU. */
 static void handle_rx(struct vhost_net *net)
@@ -1383,6 +1482,8 @@ static int vhost_net_open(struct inode *inode, struct file *f)
 
 	f->private_data = n;
 	page_frag_cache_init(&n->pf_cache);
+	spin_lock_init(&n->filter_lock);
+	n->filter_sock = NULL;
 
 	return 0;
 }
@@ -1433,6 +1534,7 @@ static int vhost_net_release(struct inode *inode, struct file *f)
 	struct socket *tx_sock;
 	struct socket *rx_sock;
 
+	vhost_net_filter_stop(n);
 	vhost_net_stop(n, &tx_sock, &rx_sock);
 	vhost_net_flush(n);
 	vhost_dev_stop(&n->dev);
@@ -1637,6 +1739,8 @@ static long vhost_net_reset_owner(struct vhost_net *n)
 	err = vhost_dev_check_owner(&n->dev);
 	if (err)
 		goto done;
+
+	vhost_net_filter_stop(n);
 	umem = vhost_dev_reset_owner_prepare();
 	if (!umem) {
 		err = -ENOMEM;
@@ -1737,6 +1841,7 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 	void __user *argp = (void __user *)arg;
 	u64 __user *featurep = argp;
 	struct vhost_vring_file backend;
+	struct vhost_net_filter filter;
 	u64 features, count, copied;
 	int r, i;
 
@@ -1745,6 +1850,10 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 		if (copy_from_user(&backend, argp, sizeof backend))
 			return -EFAULT;
 		return vhost_net_set_backend(n, backend.index, backend.fd);
+	case VHOST_NET_SET_FILTER:
+		if (copy_from_user(&filter, argp, sizeof(filter)))
+			return -EFAULT;
+		return vhost_net_set_filter(n, filter.fd);
 	case VHOST_GET_FEATURES:
 		features = vhost_net_features[0];
 		if (copy_to_user(featurep, &features, sizeof features))
-- 
2.52.0

