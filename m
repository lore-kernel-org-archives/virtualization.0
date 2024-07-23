Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F52D155733
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Jul 2024 14:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721745734; cv=none; b=ZkuyGSOKh0hhk2S1MjJi6MNRY4Zj69tmxAc8BCGWc2MZsSLUB7gl2CXxvIhtnANCplOQObcEOqgRBeT5DHHBWk+VpcdtKZ8J2d1fn6B5tOamrQMhCqgJimOaxBpYTbnTEP9wAN79XsQNDucekHlSiBdy0EzcgxYK4O8ijeJ+orw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721745734; c=relaxed/simple;
	bh=CHALTMCrX1vY5jlI9iPcWZs2oNv9LvUYT1e9X1sN7+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=J63vHE9znSi62SY092Ok/uHa3d9WVQS9f/h/3lq3/GF1Gyb3Rc+/AQZsrhmlBRQQXQUU17OLl9facEuBxSpCso2c1wjraXMR8UtbpIeQXH/+ZtVK9ESaxz++PEbiD7F0admn76LC1LsyNJ8pcaXOZTV3OYx1ZCiYnY3QE5vfPJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YjTNELxw; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YjTNELxw"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5280380FF8
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Jul 2024 14:42:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eZJHL-rbzOhz for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Jul 2024 14:42:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5A06381004
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5A06381004
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YjTNELxw
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5A06381004
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Jul 2024 14:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721745731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mbUg7e/tJ5pOz4Dg3u16mJqy+HPalD6htYuhg6ITzCM=;
	b=YjTNELxwBH9tIG/ss0LvK5l/xg+WI7qcPqWTcRpj+KumYlm0wLdaTI1jnWA5Um/iKy/m83
	SZwFAXn4omdkwNmyggWppNAQRmPvfszsP4zk7T14kMf4oAX8NZJEuSLvPwXFPVKFPGx5m8
	HKt/jIA/CIXrmsVW/FVq5LPHszl5Msk=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-WvH7YwWcPVGAkss66EM2mg-1; Tue, 23 Jul 2024 10:42:10 -0400
X-MC-Unique: WvH7YwWcPVGAkss66EM2mg-1
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-826e8dd4518so1466948241.0
        for <virtualization@lists.linux-foundation.org>; Tue, 23 Jul 2024 07:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721745729; x=1722350529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbUg7e/tJ5pOz4Dg3u16mJqy+HPalD6htYuhg6ITzCM=;
        b=SNCssomZ6mryv1Q8JQYXWHLmF5JDa05Hc4C2wL0jDXPIMlpCvdjGEw+0YfhL7VWk/w
         wODERALm0TYotoK2saOf5MDmavsVVSJVfDSan4ZDw8DL8FyXNRuUboiFC+ELTdnS8Jm0
         CQhxXnsPgmqCr3KJaqZgQkRQDMO770YUaRuRTqB0+23W4PVQEwNZjQJohPQoPGbYBphp
         XlqkXSy4tMfcyB8jI9TvaUl8Q7UzMSe0vzx6iQCjcZ5E1Dx7sXhlFJJj0Nm7GgzH+D4P
         65L4n8pLfEME4fZR5pZQobJSWp+B2Iawi41Wkjz43trkKevjb3UJnQjqRg/EeTKZMHa/
         ZKSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhzUGsNm2w2jpoMjSO0AbVm3E94KG3PNHeV4IzEO7Da2i/+79R/InNvTPcAoUnLTYw0hrQJYXfEvv9o3gEFZrHkoA5E6N9yYiwJ6AW94qDj4U8fIw97ZVBzA==
X-Gm-Message-State: AOJu0YyP9eg9CvXDz0WZOW7ivCOll0VlBO//VRtIwjlX0qipTQCDTM1m
	Q6pQQMobEbuKlQXeWG6J+Oz8Pz+X5H0Uiz5Rj5STl+XqoRsQeGMhOT//68q3WWuaMC97ipB88uU
	c/exxmhSub/kivOZmKkOmx0ghsPcb4LgMFH28QVSV8Ku7lk5UQSIVTwOjL9d7rEUx3gpTpFB8EK
	IJ5yw=
X-Received: by 2002:a05:6122:411b:b0:4f5:254e:e111 with SMTP id 71dfb90a1353d-4f5254ee847mr7883007e0c.7.1721745729281;
        Tue, 23 Jul 2024 07:42:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBLlNaASMpCBTCeROjh0z7+DMfFqI5ijim7b74MbzA0Jd6atMGmiEs2Wq/F8Wn5UYNq4Bt9g==
X-Received: by 2002:a05:6122:411b:b0:4f5:254e:e111 with SMTP id 71dfb90a1353d-4f5254ee847mr7882948e0c.7.1721745728733;
        Tue, 23 Jul 2024 07:42:08 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-79.retail.telecomitalia.it. [82.57.51.79])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f9cd505d9sm45142171cf.58.2024.07.23.07.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 07:42:08 -0700 (PDT)
Date: Tue, 23 Jul 2024 16:42:00 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, bryantan@vmware.com, vdasa@vmware.com, pv-drivers@vmware.com, 
	dan.carpenter@linaro.org, simon.horman@corigine.com, oxffffaa@gmail.com, 
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	bpf@vger.kernel.org, bobby.eshleman@bytedance.com, jiang.wang@bytedance.com, 
	amery.hung@bytedance.com, xiyou.wangcong@gmail.com
Subject: Re: [RFC PATCH net-next v6 07/14] virtio/vsock: add common datagram
 send path
Message-ID: <bpb36dtlbs6osr5cudvwrbagt7bls3cllg35lsusrly5pxwe7o@kjphrbuc64ix>
References: <20240710212555.1617795-1-amery.hung@bytedance.com>
 <20240710212555.1617795-8-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240710212555.1617795-8-amery.hung@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Jul 10, 2024 at 09:25:48PM GMT, Amery Hung wrote:
>From: Bobby Eshleman <bobby.eshleman@bytedance.com>
>
>This commit implements the common function
>virtio_transport_dgram_enqueue for enqueueing datagrams. It does not add
>usage in either vhost or virtio yet.
>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>Signed-off-by: Amery Hung <amery.hung@bytedance.com>
>---
> include/linux/virtio_vsock.h            |  1 +
> include/net/af_vsock.h                  |  2 +
> net/vmw_vsock/af_vsock.c                |  2 +-
> net/vmw_vsock/virtio_transport_common.c | 87 ++++++++++++++++++++++++-
> 4 files changed, 90 insertions(+), 2 deletions(-)
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index f749a066af46..4408749febd2 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -152,6 +152,7 @@ struct virtio_vsock_pkt_info {
> 	u16 op;
> 	u32 flags;
> 	bool reply;
>+	u8 remote_flags;
> };
>
> struct virtio_transport {
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 44db8f2c507d..6e97d344ac75 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -216,6 +216,8 @@ void vsock_for_each_connected_socket(struct vsock_transport *transport,
> 				     void (*fn)(struct sock *sk));
> int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk);
> bool vsock_find_cid(unsigned int cid);
>+const struct vsock_transport *vsock_dgram_lookup_transport(unsigned int cid,
>+							   __u8 flags);

Why __u8 and not just u8?


>
> struct vsock_skb_cb {
> 	unsigned int src_cid;
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index ab08cd81720e..f83b655fdbe9 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -487,7 +487,7 @@ vsock_connectible_lookup_transport(unsigned int cid, __u8 flags)
> 	return transport;
> }
>
>-static const struct vsock_transport *
>+const struct vsock_transport *
> vsock_dgram_lookup_transport(unsigned int cid, __u8 flags)
> {
> 	const struct vsock_transport *transport;
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index a1c76836d798..46cd1807f8e3 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1040,13 +1040,98 @@ int virtio_transport_shutdown(struct vsock_sock *vsk, int mode)
> }
> EXPORT_SYMBOL_GPL(virtio_transport_shutdown);
>
>+static int virtio_transport_dgram_send_pkt_info(struct vsock_sock *vsk,
>+						struct virtio_vsock_pkt_info *info)
>+{
>+	u32 src_cid, src_port, dst_cid, dst_port;
>+	const struct vsock_transport *transport;
>+	const struct virtio_transport *t_ops;
>+	struct sock *sk = sk_vsock(vsk);
>+	struct virtio_vsock_hdr *hdr;
>+	struct sk_buff *skb;
>+	void *payload;
>+	int noblock = 0;
>+	int err;
>+
>+	info->type = virtio_transport_get_type(sk_vsock(vsk));
>+
>+	if (info->pkt_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE)
>+		return -EMSGSIZE;
>+
>+	transport = vsock_dgram_lookup_transport(info->remote_cid, info->remote_flags);

Can `transport` be null?

I don't understand why we are calling vsock_dgram_lookup_transport()
again. Didn't we already do that in vsock_dgram_sendmsg()?

Also should we add a comment mentioning that we can't use
virtio_transport_get_ops()? IIUC becuase the vsk can be not assigned
to a specific transport, right?

>+	t_ops = container_of(transport, struct virtio_transport, transport);
>+	if (unlikely(!t_ops))
>+		return -EFAULT;
>+
>+	if (info->msg)
>+		noblock = info->msg->msg_flags & MSG_DONTWAIT;
>+
>+	/* Use sock_alloc_send_skb to throttle by sk_sndbuf. This helps avoid
>+	 * triggering the OOM.
>+	 */
>+	skb = sock_alloc_send_skb(sk, info->pkt_len + VIRTIO_VSOCK_SKB_HEADROOM,
>+				  noblock, &err);
>+	if (!skb)
>+		return err;
>+
>+	skb_reserve(skb, VIRTIO_VSOCK_SKB_HEADROOM);
>+
>+	src_cid = t_ops->transport.get_local_cid();
>+	src_port = vsk->local_addr.svm_port;
>+	dst_cid = info->remote_cid;
>+	dst_port = info->remote_port;
>+
>+	hdr = virtio_vsock_hdr(skb);
>+	hdr->type	= cpu_to_le16(info->type);
>+	hdr->op		= cpu_to_le16(info->op);
>+	hdr->src_cid	= cpu_to_le64(src_cid);
>+	hdr->dst_cid	= cpu_to_le64(dst_cid);
>+	hdr->src_port	= cpu_to_le32(src_port);
>+	hdr->dst_port	= cpu_to_le32(dst_port);
>+	hdr->flags	= cpu_to_le32(info->flags);
>+	hdr->len	= cpu_to_le32(info->pkt_len);
>+
>+	if (info->msg && info->pkt_len > 0) {
>+		payload = skb_put(skb, info->pkt_len);
>+		err = memcpy_from_msg(payload, info->msg, info->pkt_len);
>+		if (err)
>+			goto out;
>+	}
>+
>+	trace_virtio_transport_alloc_pkt(src_cid, src_port,
>+					 dst_cid, dst_port,
>+					 info->pkt_len,
>+					 info->type,
>+					 info->op,
>+					 info->flags,
>+					 false);
>+
>+	return t_ops->send_pkt(skb);
>+out:
>+	kfree_skb(skb);
>+	return err;
>+}
>+
> int
> virtio_transport_dgram_enqueue(struct vsock_sock *vsk,
> 			       struct sockaddr_vm *remote_addr,
> 			       struct msghdr *msg,
> 			       size_t dgram_len)
> {
>-	return -EOPNOTSUPP;
>+	/* Here we are only using the info struct to retain style uniformity
>+	 * and to ease future refactoring and merging.
>+	 */
>+	struct virtio_vsock_pkt_info info = {
>+		.op = VIRTIO_VSOCK_OP_RW,
>+		.remote_cid = remote_addr->svm_cid,
>+		.remote_port = remote_addr->svm_port,
>+		.remote_flags = remote_addr->svm_flags,
>+		.msg = msg,
>+		.vsk = vsk,
>+		.pkt_len = dgram_len,
>+	};
>+
>+	return virtio_transport_dgram_send_pkt_info(vsk, &info);
> }
> EXPORT_SYMBOL_GPL(virtio_transport_dgram_enqueue);
>
>-- 
>2.20.1
>

