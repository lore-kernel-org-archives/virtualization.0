Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795712964;
	b=vjshsTzL7Pq0l0y7rJw5mkvtgyhKLDQ3OQRUm11Bm4rfF1FTYRUgBUC8qVhqHq/lURpT
	 YCF2B6coPxarvwxuz/ypocIUKZ2iaIScx3XV/0tH2Fr//RsUx4vJ+ZWbFmHcVYPHVTdJR
	 r/VMg75pYOGcLviNgtg+1akcm58s1EAKHpG/mCEuMACdfVbkdMH2E9/XyFYnQiRuimCh1
	 FzDk45lXhoNX/XHr4NsQZVW3Aoy1LVD8I7JoPUwMo2ObPpcvuSAwqx5xyBpmi9Ug+hdV/
	 8lzfz/CP+ysGy96D4WY/ox0FurpiONa+aReVZV/m8vLt+JZ6a6hnRdLGDYVxn65tdPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795712964;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=0j3943NrJYq6S/iYS9qFkZ6JQ/im3sXbK5fY5UClmLY=;
	b=Yi6v4reHZL99XUfkILo+jJ2DAV8X77NVuSz93ztgK/xZcz9vBwyKK4KuZ8Lq5vO/1c5X
	 mQ+VJSgMDFEXm1tBw4tHE5T3NSx2p8ZnxmrckrjdZlLo98YNv/PmgT2o34ZErvA2awnxC
	 tFS1/ElmwWeI/4J6vLShnRXzF4+wVn7OAt5Goygg7vRLdsTo/jC9AdgQ8xOanCpbFh4LX
	 rZeu3jYfSrymM2ioZ9UKJFTir4cT+pRXXutLCMt9ELxDcaYfOxCFzVJAPkbZ1Zz4ZE5Vd
	 /lIfSD5u8XR064JUEB8YCWJQxPJb41xb2MEo/F38SwR4/kZagH2T8/5ZdztJNj4ClKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FnML46z1;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761B9606A329
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 17:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 761B9606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FnML46z1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795712962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0j3943NrJYq6S/iYS9qFkZ6JQ/im3sXbK5fY5UClmLY=;
	b=FnML46z1aKTU851FRljT9jbreBq/r0otgjSuzrG9UzeVKalrUvdilILaCp0+AXV/dsZsQn
	XHYOTYka6ePHqawDF0hSkcAVqJVpd6Xgfb0E3zA+89XESBGSnVqBPOJ9cSMCAIRtb4tQbk
	od9mUfpu+Im94SnSTukCXX+5vSR5pKg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-EEJGT-mZOgmnbft0Dwf7dQ-1; Thu, 26 Nov 2026 17:09:20 +0000
X-MC-Unique: EEJGT-mZOgmnbft0Dwf7dQ-1
X-Mimecast-MFC-AGG-ID: EEJGT-mZOgmnbft0Dwf7dQ_1795712959
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4ad3d35e899so60122305e9.1
        for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 09:09:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795712959; x=1796317759;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0j3943NrJYq6S/iYS9qFkZ6JQ/im3sXbK5fY5UClmLY=;
        b=TnfMo9TOm6klcpdHnzBtwabcxEuDJFPHYbxAFxoJOBHvwdjWY3nggyUWLkDv9+F49t
         YXnVFhJcHEuGiJKT8R6bv8rFqVYBhaHhk50uL4+pgf5Cwr7ciJobfZPlLfyLHyJdwSQp
         3YKkrTaqMPbM9TaeV2F4NaSo8K8lcp0stk4c3rLOWJ/8mJd/Ac39ScWvWNnB/32iV8+Y
         SFe4klyC8NdZDle5pNLr5O8DL6uccfb8UbiTt56TlJqEXjRurzup2Z/CL1xn9TK9DURW
         TEmILeeNsb3uVFBem7C9nALnSQXDHi6CIvUw94JtA+KScOCg9D9BEZoT++rk9DtbpYwn
         Z4Og==
X-Forwarded-Encrypted: i=1; AL+hErGNg5uZfw8g8pyXgsm10z7SI6CcBvtacZCn5iOWaHNHA/vdWeVQBa5sSdaksVF4g0gu9YmJ/xonodadoRSN+A==@lists.linux.dev
X-Gm-Message-State: APuU4Z/d8MoSGYZs2Fsjoe18gmuP8omnPTpOAZqxOFLPuy+eiGcB4l9l
	1UHXphf6cwp6CR26CV/MvbqqFXhaxvYe1IQuxaaA/CTy+8sl3kqrWgTTDlPvelnkO1SiRGlOYlo
	kpLX36xfE9H2VKLYw6SQgvKOJhCGRQ72S5qMuOPfLdkkogj8vvosjm/FtjCsAm+7PlvHy
X-Gm-Gg: AZFdTZcPi8818Vig0Xaerbbxfca+Xdb6i2et8IR04/hYcW4XwyPKIoxFCvccJWGbUP7
	jZhZ492kBTAhcMEorwMB1LbvKgZZ07iUODcMK29MrDaRXFw8wfNpx4SQ4JbVmluAevgiWhD0MiL
	mxmWS1yy/wmlrMEg+vuTxV5/Poz3RS7mlX0yzjQTWhffEtspamvj3iqFBnVtgYPTv/ipMIcz7yi
	p+AEvPuQWBdG6cEGhvi0KeeNHRvMos/Ojmtjhd+RgOCWbXVRV5REeSdl0pgRPojMBu60FqC6di5
	OwlgSDmPp+lf+1HAqlRBRBWECI+/XRPFrl+wSKtCxdg/helWMiLBE/vHSzIlW8Vome8VgzplTuN
	C9IGZmlB0W60GODLEtBD7ziBdkgNbj2DiaNX5MJlYcaL9/WlAn2ek0Q==
X-Received: by 2002:a05:600c:64c8:b0:4bb:68e5:b952 with SMTP id 5b1f17b1804b1-4bb88819be1mr412484475e9.16.1795712959004;
        Thu, 26 Nov 2026 09:09:19 -0800 (PST)
X-Received: by 2002:a05:600c:64c8:b0:4bb:68e5:b952 with SMTP id 5b1f17b1804b1-4bb88819be1mr412483085e9.16.1795712957967;
        Thu, 26 Nov 2026 09:09:17 -0800 (PST)
Received: from sgarzare-redhat ([80.116.143.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b10b5f6sm39471009f8f.34.2026.11.26.09.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 09:09:17 -0800 (PST)
Date: Thu, 26 Nov 2026 18:09:14 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Cc: Bobby Eshleman <bobbyeshleman@meta.com>, 
	Alexei Starovoitov <ast@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, bpf@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
	Sashiko AI bot <sashiko-bot@kernel.org>
Subject: Re: [PATCH RFC v4 4/8] vsock/virtio: negotiate datagram support on
 the guest
Message-ID: <awg9rYcvF-Vw4_f5@sgarzare-redhat>
References: <20261124-vsock-dgram-support-v4-0-3607484e85e8@redhat.com>
 <20261124-vsock-dgram-support-v4-4-3607484e85e8@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261124-vsock-dgram-support-v4-4-3607484e85e8@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Q0WhblzdBhDOZkCzPFudk_1Fu42N5SDAfAuWY91bkWM_1795712959
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Nov 24, 2026 at 01:20:22PM +0100, Sergio Lopez wrote:
>Advertise VIRTIO_VSOCK_F_DGRAM and record whether the device
>negotiated it. Gate datagram socket initialization and destination
>checks on the negotiated feature and the transport's supported network
>namespace mode.
>
>Perform device capability checks at socket creation without requiring
>a remote address, which is not yet known for an unconnected datagram
>socket. The common virtio implementation provides the datagram data
>path.
>
>Discard received datagrams when the device has not negotiated support,
>including when a socket was initialized through another transport.
>Reject packets addressed to a different CID using the full 64-bit wire
>value before bound-socket lookup narrows it or matches a wildcard.
>
>Signed-off-by: Sergio Lopez <slp@redhat.com>
>---
> net/vmw_vsock/virtio_transport.c | 50 +++++++++++++++++++++++++++++++++++++---
> 1 file changed, 47 insertions(+), 3 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 4f9aa9c4c3aa..fd10f20d7611 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -57,6 +57,7 @@ struct virtio_vsock {
>
> 	u32 guest_cid;
> 	bool seqpacket_allow;
>+	bool dgram_allow;
>
> 	/* These fields are used only in tx path in function
> 	 * 'virtio_transport_send_pkt_work()', so to save
>@@ -547,6 +548,18 @@ bool virtio_transport_stream_allow(struct vsock_sock *vsk, u32 cid, u32 port)
>
> static bool virtio_transport_seqpacket_allow(struct vsock_sock *vsk,
> 					     u32 remote_cid);
>+static bool virtio_transport_dgram_allow_check(struct vsock_sock *vsk,
>+					       u32 cid, u32 port);
>+
>+static int virtio_transport_socket_init(struct vsock_sock *vsk,
>+					struct vsock_sock *psk)
>+{
>+	if (sk_vsock(vsk)->sk_type == SOCK_DGRAM &&
>+	    !virtio_transport_dgram_allow_check(vsk, 0, 0))
>+		return -ESOCKTNOSUPPORT;
>+
>+	return virtio_transport_do_socket_init(vsk, psk);
>+}
>
> static bool virtio_transport_has_remote_cid(struct vsock_sock *vsk, u32 cid)
> {
>@@ -561,7 +574,7 @@ static struct virtio_transport virtio_transport = {
> 		.get_local_cid            = virtio_transport_get_local_cid,
> 		.has_remote_cid           = virtio_transport_has_remote_cid,
>
>-		.init                     = virtio_transport_do_socket_init,
>+		.init                     = virtio_transport_socket_init,
> 		.destruct                 = virtio_transport_destruct,
> 		.release                  = virtio_transport_release,
> 		.connect                  = virtio_transport_connect,
>@@ -571,7 +584,7 @@ static struct virtio_transport virtio_transport = {
> 		.dgram_bind               = virtio_transport_dgram_bind,
> 		.dgram_dequeue            = virtio_transport_dgram_dequeue,
> 		.dgram_enqueue            = virtio_transport_dgram_enqueue,
>-		.dgram_allow              = virtio_transport_dgram_allow,
>+		.dgram_allow              = virtio_transport_dgram_allow_check,

IMO we should remove virtio_transport_dgram_allow() and implement it in 
every virtio transport.

>
> 		.stream_dequeue           = virtio_transport_stream_dequeue,
> 		.stream_enqueue           = virtio_transport_stream_enqueue,
>@@ -629,6 +642,25 @@ virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
> 	return seqpacket_allow;
> }
>
>+static bool
>+virtio_transport_dgram_allow_check(struct vsock_sock *vsk, u32 cid, u32 port)
>+{
>+	struct virtio_vsock *vsock;
>+	bool dgram_allow;
>+
>+	if (!vsock_net_mode_global(vsk))
>+		return false;
>+
>+	dgram_allow = false;
>+	rcu_read_lock();
>+	vsock = rcu_dereference(the_virtio_vsock);
>+	if (vsock)
>+		dgram_allow = vsock->dgram_allow;
>+	rcu_read_unlock();
>+
>+	return dgram_allow;
>+}
>+
> static void virtio_transport_rx_work(struct work_struct *work)
> {
> 	struct virtio_vsock *vsock =
>@@ -677,6 +709,14 @@ static void virtio_transport_rx_work(struct work_struct *work)
> 				continue;
> 			}
>
>+			/* Check the full wire CID before socket lookup truncates it. */
>+			if (le16_to_cpu(hdr->type) == VIRTIO_VSOCK_TYPE_DGRAM &&

Why only for DGRAM? What issues are we fixing?

>+			    (!vsock->dgram_allow ||
>+			     le64_to_cpu(hdr->dst_cid) != vsock->guest_cid)) {
>+				kfree_skb(skb);
>+				continue;
>+			}
>+
> 			if (payload_len)
> 				virtio_vsock_skb_put(skb, payload_len);
>
>@@ -835,6 +875,9 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
> 	if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_SEQPACKET))
> 		vsock->seqpacket_allow = true;
>
>+	if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_DGRAM))
>+		vsock->dgram_allow = true;
>+
> 	vdev->priv = vsock;
>
> 	ret = virtio_vsock_vqs_init(vsock);
>@@ -932,7 +975,8 @@ static struct virtio_device_id id_table[] = {
> };
>
> static unsigned int features[] = {
>-	VIRTIO_VSOCK_F_SEQPACKET
>+	VIRTIO_VSOCK_F_SEQPACKET,
>+	VIRTIO_VSOCK_F_DGRAM,

BTW I'm confused about the order of patches. The previous patch enables 
dgram unconditionally, here we are checking the feature. IMO we should 
first have patches to implement everything, just at end enables it.

Thanks,
Stefano

