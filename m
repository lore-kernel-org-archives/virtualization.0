Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793869507;
	b=RaUA7u4osE1q6sNLnARk/DlRoN3l5zbySDSL50Wm7Ff6behg7nBG84bNREFtak8I7UaJ
	 Ympp0AftqBChzLvG+5DJ3o+53NoaRmAyCTifTksThx5R3+f3uKWzR38vjcL8kQ2kAuq6k
	 N16kdOkWTyEj1UFqp5+7G8v4G5AAR8VTyJj0tUdFV6HerRJB89ikMu/R5/Ex8T6NqCgJd
	 NoLr/IBx8WJA+OzAwicF9oz3uXgZxM1Ht4Aq92jY43b9G5cjqQaABLpcrXDTztznllO+K
	 EZ1oR7Jsfqc9YHXDIH1bQObuaovNMdzdlKh5cKC4yeXo4HQEi0YP/mjOhMuDPKxdRfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793869507;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=OKDdMZ8wV3aSy4GLecm7p1foBFtioFQmSifyw+llv2w=;
	b=hCHLNGLTJlx+PLqnjE+Z+IilmrAbqNJC2dAcRw7kQwnPFYvbD6EMMbOOv09AFef/vAQc
	 WSN/BY98r2UkYWC5GeE4KiVzXcS/Zd40AQhtQwC2s/VwV5JeyueAhSDM9pd1272XJQWJJ
	 z1vP/BBZgFr7JWoAoqFk3Sv3EHcaQdsNYbh4V0CZtlkvi7/i4AwnXlpjiEGgULzNYCBlx
	 EnikZ9SIhOvP0WZBbHhLHlmqDeAflyWXl502ocgcphAsfl4omDgStZ6fd1SSRMlfYtd6W
	 XgBgOvndU0hdBLN3uFpsIFYS00tmLV7WjJbpgZKjbx+gNgN6EzSRBJIIRFvP6+fFXpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LRE2HQrN;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7572606A335
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 09:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7572606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LRE2HQrN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793869505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OKDdMZ8wV3aSy4GLecm7p1foBFtioFQmSifyw+llv2w=;
	b=LRE2HQrNdRiyhy6oGdH/PAFRGtV+eNA2pEg/SiPvb1BZbhA7VHGTFozP+rkql9y5ZwAhNA
	k7SoAj19z4qNqGLSTLIGnVhkKYrF3DLXKkJaIDnBhY80UdK/jWs3YDlVyJuWkMgOMk/KaT
	VAClS4nfslQrYJ8EzbvwqIsZ5WT57vE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-OyTv1TJGOhG4Q7k7sryVlw-1; Thu, 05 Nov 2026 04:05:02 -0500
X-MC-Unique: OyTv1TJGOhG4Q7k7sryVlw-1
X-Mimecast-MFC-AGG-ID: OyTv1TJGOhG4Q7k7sryVlw_1793869501
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c4048584447so180414866b.1
        for <virtualization@lists.linux.dev>; Thu, 05 Nov 2026 01:05:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793869501; x=1794474301;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OKDdMZ8wV3aSy4GLecm7p1foBFtioFQmSifyw+llv2w=;
        b=HHi0ditXJI/ZwnJL3rJYfGP22z0h1sSGdp3JBIeBj6roQVXvK/xdvQ17gFOjOUpZgN
         fS762iU+ve2qUlwQFiwxmQRp3iEMowx73VPy5JYfFjUExnzRqJQOfsdKMGQMndQJ2SQP
         U5Ez0rnZzU4swtYEq9avTNhSJRtw007kJcW2TylkDdL1oZm/MkaXydFa8X7isf/x0GQR
         XBqfYaQlFjH/rCe1aTDWzETliVa/c4h23H8OWIpYd+Qp09BRiiyNEQppxpzlI6lWBmKS
         5B+B8reqj2CX1rGm5G+zghcJCqSA3MjQJ4zzrksxtw72L4/buwHqau5zhho8f/zT/ews
         LTOA==
X-Forwarded-Encrypted: i=1; AKwUvBwKFjDb7vDNJ7yfHBxBAVLFsnMxOcQ8lOkd94lIKxwWRhtXTy+7SB9kKsgaScnlGMRDWFaNXHMDegVpZxQQVw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/5ZqmJebIXpcwUNnXXjspKQuqZrO+oVlXuk35vGdiekYHxjuAA
	yHrK8eUt++wDW0gq+m5FuGuk0ZW0uGy4/sDK8ZGmftZbETPfjN3GFXlxid+5PwEUwMmloBZCJ7c
	BU/xMONf1HAfPIfqmcm7rxAiKsVpAQ25hAsOsLp9Wy/tyU0FjWhuPBIlBHhBu3sPEWm7y
X-Gm-Gg: AYBFou02MU6Dr9O9+qWe3cC1j7chHztRaWldM7kAAiNnVPf8aSIZYo4xaoJcbnFnC4d
	RzrCHIIB1LMbRwTHz0B3MmZe9mXQDmTB6Z9jU+quHxrgajKosBVNxAbojtu1ZkQDT8+FiysOv2x
	2SY0loljtNa/Rs+m4pnc+1NZZaYT9tLgS60EMWYTW23NA0dMmUkds7wNIKPcbs9ekkCTrHuz1wW
	U8d8tazP9g4BjETRJ4Z0dKk3G3tLmROfA/t21NYf+Vtu5cqvyem7dh9nT/kU8XvVTK7eHTfD5Ri
	t0MTHXmiFwWZ2TTRxjTLlLMxVB4bRr+Zsu5VhSvZfDlBzb5tLmXYpWJ+BJB0mozR780esoFRF12
	89HNj37wEDGnjWpqhJzf3e1ovz8W7JXGu0zoJ56wvcEYypD9mfeoY
X-Received: by 2002:a17:907:86a7:b0:c2e:6a4f:a88b with SMTP id a640c23a62f3a-c4ca73f6a56mr1619384766b.0.1793869500507;
        Thu, 05 Nov 2026 01:05:00 -0800 (PST)
X-Received: by 2002:a17:907:86a7:b0:c2e:6a4f:a88b with SMTP id a640c23a62f3a-c4ca73f6a56mr1619380866b.0.1793869499953;
        Thu, 05 Nov 2026 01:04:59 -0800 (PST)
Received: from sgarzare-redhat ([80.116.143.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fec9cd43bsm8597436f8f.14.2026.11.05.01.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 01:04:58 -0800 (PST)
Date: Thu, 5 Nov 2026 10:04:49 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: netdev@vger.kernel.org, stefanha@redhat.com, bobbyeshleman@gmail.com, 
	mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/5] vsock/virtio: split socket lookup from
 locked RX processing
Message-ID: <auxGc7T-7vCsGWlE@sgarzare-redhat>
References: <20261103041134.33310-1-physicalmtea@gmail.com>
 <20261103041134.33310-2-physicalmtea@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261103041134.33310-2-physicalmtea@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6mdjAngKgddqjUbiXPsZGtNaUMl5YXbkXyLY3LpFMfs_1793869501
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Nov 03, 2026 at 12:11:30PM +0800, Jia Jia wrote:
>Split virtio_transport_recv_pkt() so socket lookup is separate from
>processing that occurs while holding the socket lock. This prepares the
>receive path to retain a looked-up socket across multiple packets in a
>later change.
>
>Keep virtio_transport_recv_pkt() on its existing per-packet locking path.
>Pass the caller-provided network namespace to the locked helper so reset
>handling retains its existing semantics. Preserve source validation and
>failure handling.
>
>Signed-off-by: Jia Jia <physicalmtea@gmail.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 131 ++++++++++++++----------
> 1 file changed, 78 insertions(+), 53 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index f225f53ed4bab..43325d7aebbb1 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1774,6 +1774,80 @@ static bool virtio_transport_valid_type(u16 type)
> 	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET);
> }
>
>+static struct sock *
>+virtio_transport_find_socket(struct sockaddr_vm *src,
>+			     struct sockaddr_vm *dst, struct net *net)
>+{
>+	struct sock *sk;
>+
>+	sk = vsock_find_connected_socket_net(src, dst, net);
>+	if (!sk)
>+		sk = vsock_find_bound_socket_net(dst, net);
>+
>+	return sk;
>+}
>+
>+/*
>+ * The caller holds sk's socket lock.
>+ */
>+static void
>+virtio_transport_recv_pkt_locked(struct virtio_transport *t,
>+				 struct sk_buff *skb, struct sock *sk,
>+				 struct net *net)
>+{
>+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
>+	struct vsock_sock *vsk = vsock_sk(sk);
>+	struct sockaddr_vm src;
>+	bool space_available;
>+
>+	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
>+			le32_to_cpu(hdr->src_port));
>+
>+	/*
>+	 * The socket may have been closed or reassigned after lookup but before
>+	 * its socket lock was acquired. Listener sockets have no assigned
>+	 * transport.
>+	 */
>+	if (sock_flag(sk, SOCK_DONE) ||
>+	    (sk->sk_state != TCP_LISTEN &&
>+	     !vsock_check_source(vsk, &t->transport, &src))) {
>+		(void)virtio_transport_reset_no_sock(t, skb, net);
>+		kfree_skb(skb);
>+		return;
>+	}
>+
>+	space_available = virtio_transport_space_update(sk, skb);
>+
>+	/* Update CID in case it has changed after a transport reset event */
>+	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
>+		vsk->local_addr.svm_cid = le64_to_cpu(hdr->dst_cid);
>+
>+	if (space_available)
>+		sk->sk_write_space(sk);
>+
>+	switch (sk->sk_state) {
>+	case TCP_LISTEN:
>+		virtio_transport_recv_listen(sk, skb, t);
>+		kfree_skb(skb);
>+		break;
>+	case TCP_SYN_SENT:
>+		virtio_transport_recv_connecting(sk, skb);
>+		kfree_skb(skb);
>+		break;
>+	case TCP_ESTABLISHED:
>+		virtio_transport_recv_connected(sk, skb);
>+		break;
>+	case TCP_CLOSING:
>+		virtio_transport_recv_disconnecting(sk, skb);
>+		kfree_skb(skb);
>+		break;
>+	default:
>+		(void)virtio_transport_reset_no_sock(t, skb, net);
>+		kfree_skb(skb);
>+		break;
>+	}
>+}
>+
> /* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
>  * lock.
>  */
>@@ -1782,9 +1856,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> {
> 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> 	struct sockaddr_vm src, dst;
>-	struct vsock_sock *vsk;
> 	struct sock *sk;
>-	bool space_available;
>
> 	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
> 			le32_to_cpu(hdr->src_port));
>@@ -1808,13 +1880,10 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> 	/* The socket must be in connected or bound table
> 	 * otherwise send reset back
> 	 */
>-	sk = vsock_find_connected_socket_net(&src, &dst, net);
>+	sk = virtio_transport_find_socket(&src, &dst, net);
> 	if (!sk) {
>-		sk = vsock_find_bound_socket_net(&dst, net);
>-		if (!sk) {
>-			(void)virtio_transport_reset_no_sock(t, skb, net);
>-			goto free_pkt;
>-		}
>+		(void)virtio_transport_reset_no_sock(t, skb, net);
>+		goto free_pkt;
> 	}
>
> 	if (virtio_transport_get_type(sk) != le16_to_cpu(hdr->type)) {
>@@ -1828,52 +1897,8 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> 		goto free_pkt;
> 	}
>
>-	vsk = vsock_sk(sk);
>-
> 	lock_sock(sk);
>-
>-	/* Check if sk has been closed or assigned to another transport before
>-	 * lock_sock (note: listener sockets are not assigned to any transport)
>-	 */
>-	if (sock_flag(sk, SOCK_DONE) ||
>-	    (sk->sk_state != TCP_LISTEN &&
>-	     !vsock_check_source(vsk, &t->transport, &src))) {
>-		(void)virtio_transport_reset_no_sock(t, skb, net);
>-		release_sock(sk);
>-		sock_put(sk);
>-		goto free_pkt;
>-	}
>-
>-	space_available = virtio_transport_space_update(sk, skb);
>-
>-	/* Update CID in case it has changed after a transport reset event */
>-	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
>-		vsk->local_addr.svm_cid = dst.svm_cid;
>-
>-	if (space_available)
>-		sk->sk_write_space(sk);
>-
>-	switch (sk->sk_state) {
>-	case TCP_LISTEN:
>-		virtio_transport_recv_listen(sk, skb, t);
>-		kfree_skb(skb);
>-		break;
>-	case TCP_SYN_SENT:
>-		virtio_transport_recv_connecting(sk, skb);
>-		kfree_skb(skb);
>-		break;
>-	case TCP_ESTABLISHED:
>-		virtio_transport_recv_connected(sk, skb);
>-		break;
>-	case TCP_CLOSING:
>-		virtio_transport_recv_disconnecting(sk, skb);
>-		kfree_skb(skb);
>-		break;
>-	default:
>-		(void)virtio_transport_reset_no_sock(t, skb, net);
>-		kfree_skb(skb);
>-		break;
>-	}
>+	virtio_transport_recv_pkt_locked(t, skb, sk, net);
>

nit: if you need to resend, please remove this blank line or add a blank 
line after lock_sock().

The rest LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


> 	release_sock(sk);
>
>-- 
>2.53.0
>

