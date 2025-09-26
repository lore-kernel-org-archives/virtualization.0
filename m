Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A792BD5AF
	for <virtualization@lists.linux.dev>; Fri, 26 Sep 2025 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758905595; cv=none; b=saNYMmLnPkMqu8OFfkM4K0A0qq71+1OrdkFjyJjXDOFinAVW8lPMwLK4DajMKwGBLIdIdHsAH/o2YQfzwNpcFzg8oZ4eyyUoSLpZVnAewysRs7WYGs2Oz7RFZzLJ836sacdmVI6MZS081SkeqTVVJtHUDlibwSlH9beurDQPA1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758905595; c=relaxed/simple;
	bh=V8Lz4Idvu8x0IrJBFobzlRMrWGjnlLpDYLeqriHkxC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DtLhqjiOFXPM3EkrRydIldVUxq9X1Cb1m1zRfT/9aKMoaqufhkWd3a3P4+FOgbQYVk1f6vJpQHapvSxGnxWrYJ1DFXDAQ9isiqeJxeVtzCU/xQSg12HPVIQdG713aJpsKdPxnpigFVSpjo78E5kK2NQgl55nuQkt7iK1b7/O8GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OdtZgibk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OdtZgibk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758905591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F6ERqWdcM/YJpLfSOtqH+tcv4QvhRwOVTuKYDDboR0Q=;
	b=OdtZgibkrBiA6EGpNah9bjQD/M9m23kSfpFfAe/DJKlzsDn1seoZBmjZA0AUhJu57kOO8u
	aBQgJ85y4NDeFCsuklc1EOv7NHdjjRx4SAtFgbaw4OkPFHYVxlpMLgJQiT/p2Ht7ubDp62
	WLn75JkwwZE8dra9l1q3bS9a+5CtJOs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-VtD1vNZ4PUi0AoZrUiYrcw-1; Fri, 26 Sep 2025 12:53:10 -0400
X-MC-Unique: VtD1vNZ4PUi0AoZrUiYrcw-1
X-Mimecast-MFC-AGG-ID: VtD1vNZ4PUi0AoZrUiYrcw_1758905589
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e375dab7dso9396685e9.3
        for <virtualization@lists.linux.dev>; Fri, 26 Sep 2025 09:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758905589; x=1759510389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6ERqWdcM/YJpLfSOtqH+tcv4QvhRwOVTuKYDDboR0Q=;
        b=PHouhhZ7x2QepEn1meEkYGnAh8VEYDCy3IGMLNpucFYxUTUOR8kjtVCP/ypqHg/DKe
         /YCbiqKzuf3R5+oRS/voYAFLYrg+zkssq7IsvlIUZG+T0JIfb9ZPG9fWzU4KyqYJiITi
         +Yw/c/+PzGBBTQrc18QiOTyAUj6TqwRZ8uqxJRtkGa7JFVNQG+rEgiQb1J6n0FBWoIUm
         lNpxfeFI/6rBc5C8zwnqe9004CvL/tMeJR+v0g146v8LiaqH+ZgoP8KdMAKpqBsiFmIX
         TgC46sCCtHWblhbfMMJGzcgKJDNz1LATC9pu03lS8UqnETBq/0kx6TwvytsxNAO86/eC
         Racg==
X-Forwarded-Encrypted: i=1; AJvYcCUQxF70HldOPt2jtTsbhg5tUrC0xPm+vWAmniWnLZwL1jT4yEYzLtcwkSIU1UPIBRVAjI+z3GXSTurLmGDClw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxb6hHKKBVf8U5UBYoQqPcH0nhsYkuLJ0WHca9LeFwYn61P6UgB
	AJWvz9YFnpQ/pSg79L/9qexuzA9u298VCgl7ELShgDUNTsDeCTK4QxyboOpjlfTq//H2TG6dB0k
	1XUynLgkAcPbt0l4YWwb0Pzak0Iy/vU0BomAxTz9PzNe1dhCzC/oe6ipXHsn8lP3zsJWe
X-Gm-Gg: ASbGncsiIv/R9jv7j1g4GGfcfei8IOk2Tl/aZejpT4NJTO76jJw2Ber14n/z4+ma8ZX
	UE3C8naWcG2Kw8Ev1WHacddWL+Jbd8MTciKXxJY6iTk8iJ7jPfnrgC92NERhweFawMNhlyi5B/e
	6vwJJA61rMT+9BblMf8t18Vkcm0u8GJIV2kS+ZliJ9n/pbpnP3Rws7wy446rkTm11JYdL99AZF8
	wnoVUnSw9QnHklWrSocHHZgPLajm6/XQL80ju54xe2MPnxzsNsvVG04ecVd39xlBZViHj3eENnS
	K9qOQ2lwdvcMtJk51zCl0nAbjrxXT9IUMZba+ZYr
X-Received: by 2002:a05:600c:4689:b0:46e:32f5:2d4b with SMTP id 5b1f17b1804b1-46e32f52ec4mr70647475e9.37.1758905588921;
        Fri, 26 Sep 2025 09:53:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3BkULf3Lwx+2tbUTcS+B/aKr41qUaW8DLeBacXymSbzz/oDdFVZkAI/iUyC8ROZYaR/clmg==
X-Received: by 2002:a05:600c:4689:b0:46e:32f5:2d4b with SMTP id 5b1f17b1804b1-46e32f52ec4mr70647105e9.37.1758905588424;
        Fri, 26 Sep 2025 09:53:08 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.94.69])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc86c5958sm7652818f8f.57.2025.09.26.09.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 09:53:07 -0700 (PDT)
Date: Fri, 26 Sep 2025 18:52:54 +0200
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
	linux-hyperv@vger.kernel.org, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v6 6/9] vhost/vsock: add netns support
Message-ID: <4dpdqwdzxk7rkp6c5us6gkzf67ni2j4ekl2aggab66whpfyne3@f4clvj5iilmm>
References: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
 <20250916-vsock-vmtest-v6-6-064d2eb0c89d@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250916-vsock-vmtest-v6-6-064d2eb0c89d@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YXB8-iwZnCXFkoWiAyLdxavfod9ChTNo3qPgPeDnuQA_1758905589
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Sep 16, 2025 at 04:43:50PM -0700, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add the ability to isolate vsock flows using namespaces.
>
>The VM, via the vhost_vsock struct, inherits its namespace from the
>process that opens the vhost-vsock device. vhost_vsock lookup functions
>are modified to take into account the mode (e.g., if CIDs are matching
>but modes don't align, then return NULL).
>
>vhost_vsock now acquires a reference to the namespace.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>
>---
>Changes in v5:
>- respect pid namespaces when assigning namespace to vhost_vsock
>---
> drivers/vhost/vsock.c | 74 +++++++++++++++++++++++++++++++++++++++++++++------
> 1 file changed, 66 insertions(+), 8 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 34adf0cf9124..1aabe9f85503 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -46,6 +46,11 @@ static DEFINE_READ_MOSTLY_HASHTABLE(vhost_vsock_hash, 8);
> struct vhost_vsock {
> 	struct vhost_dev dev;
> 	struct vhost_virtqueue vqs[2];
>+	struct net *net;
>+	netns_tracker ns_tracker;
>+
>+	/* The ns mode at the time vhost_vsock was created */
>+	enum vsock_net_mode orig_net_mode;
>
> 	/* Link to global vhost_vsock_hash, writes use vhost_vsock_mutex */
> 	struct hlist_node hash;
>@@ -64,10 +69,40 @@ static u32 vhost_transport_get_local_cid(void)
> 	return VHOST_VSOCK_DEFAULT_HOST_CID;
> }
>
>+/* Return true if the namespace net can access the vhost_vsock vsock.
>+ * Otherwise, return false.
>+ *
>+ * If the netns is the same, it doesn't matter if it is local or global. The
>+ * vsock sockets within a namespace can always communicate.
>+ *
>+ * If the netns is different, then we need to check if the current namespace
>+ * mode is global and if the namespace mode at the time of the vhost_vsock
>+ * being created is global. If so, then we allow it. By checking the namespace
>+ * mode at the time of the vhost_vsock's creation we allow the flow to continue
>+ * working even if the namespace mode changes to "local" in the middle of a
>+ * socket's lifetime. If we used the current namespace mode instead, then any
>+ * socket that was alive prior to the mode change would suddenly fail.
>+ */
>+static bool vhost_vsock_net_check_mode(struct net *net,
>+				       struct vhost_vsock *vsock,
>+				       bool check_global)
>+{
>+	if (net_eq(net, vsock->net))
>+		return true;
>+
>+	return check_global &&
>+	       (vsock_net_mode(net) == VSOCK_NET_MODE_GLOBAL &&
>+	        vsock->orig_net_mode == VSOCK_NET_MODE_GLOBAL);
>+}
>+
> /* Callers that dereference the return value must hold vhost_vsock_mutex or the
>  * RCU read lock.
>+ *
>+ * If check_global is true, evaluate the vhost_vsock namespace and namespace
>+ * net argument as matching if they are both in global mode.
>  */
>-static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
>+static struct vhost_vsock *vhost_vsock_get(u32 guest_cid, struct net *net,
>+					   bool check_global)
> {
> 	struct vhost_vsock *vsock;
>
>@@ -78,9 +113,9 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
> 		if (other_cid == 0)
> 			continue;
>
>-		if (other_cid == guest_cid)
>+		if (other_cid == guest_cid &&
>+		    vhost_vsock_net_check_mode(net, vsock, check_global))
> 			return vsock;
>-
> 	}
>
> 	return NULL;
>@@ -272,13 +307,14 @@ static int
> vhost_transport_send_pkt(struct sk_buff *skb)
> {
> 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
>+	struct net *net = virtio_vsock_skb_net(skb);
> 	struct vhost_vsock *vsock;
> 	int len = skb->len;
>
> 	rcu_read_lock();
>
> 	/* Find the vhost_vsock according to guest context id  */
>-	vsock = vhost_vsock_get(le64_to_cpu(hdr->dst_cid));
>+	vsock = vhost_vsock_get(le64_to_cpu(hdr->dst_cid), net, true);
> 	if (!vsock) {
> 		rcu_read_unlock();
> 		kfree_skb(skb);
>@@ -305,7 +341,7 @@ vhost_transport_cancel_pkt(struct vsock_sock *vsk)
> 	rcu_read_lock();
>
> 	/* Find the vhost_vsock according to guest context id  */
>-	vsock = vhost_vsock_get(vsk->remote_addr.svm_cid);
>+	vsock = vhost_vsock_get(vsk->remote_addr.svm_cid, sock_net(sk_vsock(vsk)), true);
> 	if (!vsock)
> 		goto out;
>
>@@ -462,11 +498,12 @@ static struct virtio_transport vhost_transport = {
>
> static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
> {
>+	struct net *net = sock_net(sk_vsock(vsk));
> 	struct vhost_vsock *vsock;
> 	bool seqpacket_allow = false;
>
> 	rcu_read_lock();
>-	vsock = vhost_vsock_get(remote_cid);
>+	vsock = vhost_vsock_get(remote_cid, net, true);
>
> 	if (vsock)
> 		seqpacket_allow = vsock->seqpacket_allow;
>@@ -526,6 +563,8 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
> 			continue;
> 		}
>
>+		virtio_vsock_skb_set_net(skb, vsock->net);
>+		virtio_vsock_skb_set_orig_net_mode(skb, vsock->orig_net_mode);

In virtio_transport_common.c we do this in the alloc_skb function, can 
we do the same also here?

And maybe also in the virtio_transport.c (i.e. in virtio_vsock_rx_fill() 
or adding a wrapper around virtio_vsock_alloc_linear_skb()).

> 		total_len += sizeof(*hdr) + skb->len;
>
> 		/* Deliver to monitoring devices all received packets */
>@@ -652,10 +691,14 @@ static void vhost_vsock_free(struct vhost_vsock *vsock)
>
> static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
> {
>+
> 	struct vhost_virtqueue **vqs;
> 	struct vhost_vsock *vsock;
>+	struct net *net;
> 	int ret;
>
>+	net = current->nsproxy->net_ns;
>+
> 	/* This struct is large and allocation could fail, fall back to vmalloc
> 	 * if there is no other way.
> 	 */
>@@ -669,6 +712,12 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
> 		goto out;
> 	}
>
>+	vsock->net = get_net_track(net, &vsock->ns_tracker, GFP_KERNEL);
>+
>+	/* Cache the mode of the namespace so that if that netns mode changes,
>+	 * the vhost_vsock will continue to function as expected. */
>+	vsock->orig_net_mode = vsock_net_mode(net);
>+
> 	vsock->guest_cid = 0; /* no CID assigned yet */
> 	vsock->seqpacket_allow = false;
>
>@@ -707,8 +756,16 @@ static void vhost_vsock_reset_orphans(struct sock *sk)
> 	 * executing.
> 	 */
>
>+	/* DELETE ME:

mmm, to be deleted, right? :-)

>+	 *
>+	 * for each connected socket:
>+	 *	vhost_vsock = vsock_sk(sk)
>+	 *
>+	 *	find the peer
>+	 */
>+
> 	/* If the peer is still valid, no need to reset connection */
>-	if (vhost_vsock_get(vsk->remote_addr.svm_cid))
>+	if (vhost_vsock_get(vsk->remote_addr.svm_cid, sock_net(sk), false))

Can we add a comment here to explain why `check_global` is false?

Thanks,
Stefano

> 		return;
>
> 	/* If the close timeout is pending, let it expire.  This avoids races
>@@ -753,6 +810,7 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
> 	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
>
> 	vhost_dev_cleanup(&vsock->dev);
>+	put_net_track(vsock->net, &vsock->ns_tracker);
> 	kfree(vsock->dev.vqs);
> 	vhost_vsock_free(vsock);
> 	return 0;
>@@ -779,7 +837,7 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
>
> 	/* Refuse if CID is already in use */
> 	mutex_lock(&vhost_vsock_mutex);
>-	other = vhost_vsock_get(guest_cid);
>+	other = vhost_vsock_get(guest_cid, vsock->net, true);
> 	if (other && other != vsock) {
> 		mutex_unlock(&vhost_vsock_mutex);
> 		return -EADDRINUSE;
>
>-- 
>2.47.3
>

