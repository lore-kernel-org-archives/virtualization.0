Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2259B37B01F
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 14:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161076; cv=none; b=eovhIE2gKLjovbNncZVzUWnBjOrJOYXwx0VPctiQrmjeTi6WyfIvJEe8WJdU0fniE2y2bs7EFmokwDGQbaoW5WIDdSoaDFVVOy2FKJI08otaAT34I2qYRbObF04qZqEtCmIsqDYYyepvn9NMs/eAZgSll1u4YE5fruiN27DWjYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161076; c=relaxed/simple;
	bh=K91HiQt1yEIn09CwVOcy8afHlysNdhjOqO+vmGR1S5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mO1oZIFwV59Gu0/GBcRgTPu7LtXUTXIQbQmQIMtDjkXOlE4o05u8UPSYpZ0L5Fp9uroFdwexQhOrk41d0f/ynfbDBchQ4jBOttwwiCyBOTPmiV1uhuzxAz74E+Jrz6eepRvgY3QkLe/7+t8kRl+BuB8exeMC3JaSlKJDJawwVug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFEBuNnB; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFEBuNnB"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6dde81a6820so2436335eaf.2
        for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 07:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792161074; x=1792765874; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mLwSzLny46jupzvFLvBEk+T6b2l6mUuh85ElZv2WpbQ=;
        b=PFEBuNnBZkz7cJx3r7WSPmXDvBRch54V4b31lGXvo7gvQXp6V1dOJvcUHFe2gWmGII
         eGltnjBXMreOpz8qfkuNt4VbMQaEl5t8VxabSU1SejhLaOwRyWKzKLan0bVYVqR7UzaP
         3j4G0iJ67e7qV9jreiMqb9TcKqT62/bzBly2cUzEKQQX2PJo8ds4pwBwA6Hf60y8Mpx6
         iDfqFTO6MgRr3m9tlrMXK0LnL6s4btei70WHh92wM3RQCzxZki7l09C8gK161k44zhRv
         3DGP2yqOIWhGaEQoDbN9uA/6M0v120KknyqtUMONgYih0sZ+0loIHawBphQRwtreMR9b
         HqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792161074; x=1792765874;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mLwSzLny46jupzvFLvBEk+T6b2l6mUuh85ElZv2WpbQ=;
        b=mS6Xt87d+l1ALFZh1I0jzyR26CuAjjtQxBd4y4EaYCi9v8uUxUQpVGJcLNaoiMqvUp
         OhGxX4XoHy1PX81jX9YBABSkiMdF6Sf4njQzeII1OeJN276mc7xhq/rudYOsu2BYK9nD
         oRJxsaN3eaabhUG/k433cRgytFiwKJA3UDjrSnpqeDgzE4E6VnPcezJORiAIwBaeAiWP
         wFp7s9HnADOZBqkbqLyqoamJs+3WrSBVMSW11VJNNYOlQqK7rOS4HqsDQZND+e03h6Aq
         SbaD5ciIRo+LFCPPSIEyG8WnSilcoAmgNhYt2+gckok0VcLx2LbLfkRb6o/vHzh3iy9T
         oJBw==
X-Forwarded-Encrypted: i=1; AKwUvBzQN4s9B9jQjQdtCi6SJQiL4mqF7DZ5DIzURz92PID13q3r3LK6aBT4H4K+wvOZRn355vauGRLYR0o8ILexcA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJhq3O/v8WGwR9ql1HVloa48Y0M6FgMit3xE3YBcL2WCSy9tt58
	SOBN+InxVFTkJT7pB+yCZTr04D4h/+e5qRMRz38IH+woYMkBGDt8+LGo
X-Gm-Gg: AYBFou1v34kYSNbF1LH3VeNpgaiAZeXURliGIKPWi0z629HnTywKpv9BufTCE3nSP1h
	3SA7oOB3tRH50lNsQuOnEjRqWkAa5W5I37SVjGM7AWS7n/QY+5ccbhrqMrwY/HhFNYNyh7wjnXb
	5N1X/SSMldofqg20NfPXsAPVhtM8quies/0w2urXZvvgdZfzk0FgeB3OLfsgHCia1laK7fkREu/
	cAsfMp2UjdDNFJe9eP10R8yorTwjfPjQjg1EsFDBqWsDfwXO2Si2+qROwK9FoLur+Y0CknZyOMt
	MqbT04dllVn/02nSYQxR2my8NaHFmXJ52dtibPuKTtTbG0F9jFVhL1A0ILxbf+JSAM5KuzLk5y6
	0zQOcVUegoJnb/V1ofl1IB2pkStMSoVFPojRwecSKrySkFL+/s7s6cB4OOrv6GZtoDqG4L8S2th
	oyJtJQByVtGkpA7ByPmmjdV+inZnLP0hVBFwN10s9Rub2Lfbvm0cBQZRZEnw/luODZ4Xw=
X-Received: by 2002:a05:6820:1c86:b0:6f7:384:a09a with SMTP id 006d021491bc7-6f70384ab38mr11546790eaf.24.1792161073822;
        Fri, 16 Oct 2026 07:31:13 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:45::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a73b763339sm1824054fac.15.2026.10.16.07.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 07:31:12 -0700 (PDT)
Date: Fri, 16 Oct 2026 07:31:10 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Jia Jia <physicalmtea@gmail.com>, stefanha@redhat.com, mst@redhat.com,
	jasowangio@gmail.com, eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/4] vsock/virtio: split socket lookup from
 locked RX processing
Message-ID: <atI1LidDfxztx7sj@devvm29614.prn0.facebook.com>
References: <20261014115640.184286-1-physicalmtea@gmail.com>
 <20261014115640.184286-2-physicalmtea@gmail.com>
 <atImp74JbTbEb0d_@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atImp74JbTbEb0d_@sgarzare-redhat>

On Fri, Oct 16, 2026 at 03:47:33PM +0200, Stefano Garzarella wrote:
> On Wed, Oct 14, 2026 at 07:56:37PM +0800, Jia Jia wrote:
> > Split virtio_transport_recv_pkt() so socket lookup is separate from
> > receive state machine processing under the socket lock. This prepares the
> > receive path to keep a looked-up socket across multiple packets in a later
> > change.
> > 
> > Keep virtio_transport_recv_pkt() on its existing per-packet locking path.
> > The locked helper obtains packet-specific addresses from the skb and uses
> > the matched socket namespace for reset replies. Preserve source validation
> > and failure handling.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > ---
> > net/vmw_vsock/virtio_transport_common.c | 128 ++++++++++++++----------
> > 1 file changed, 75 insertions(+), 53 deletions(-)
> > 
> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > index f225f53ed4bab..61ee3bc205d5d 100644
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
> > @@ -1774,81 +1774,60 @@ static bool virtio_transport_valid_type(u16 type)
> > 	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET);
> > }
> > 
> > -/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
> > - * lock.
> > - */
> > -void virtio_transport_recv_pkt(struct virtio_transport *t,
> > -			       struct sk_buff *skb, struct net *net)
> > +static struct sock *
> > +virtio_transport_find_socket(struct sk_buff *skb, struct sockaddr_vm *src,
> > +			     struct sockaddr_vm *dst, struct net *net)
> > {
> > 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> > -	struct sockaddr_vm src, dst;
> > -	struct vsock_sock *vsk;
> > 	struct sock *sk;
> > -	bool space_available;
> > -
> > -	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
> > -			le32_to_cpu(hdr->src_port));
> > -	vsock_addr_init(&dst, le64_to_cpu(hdr->dst_cid),
> > -			le32_to_cpu(hdr->dst_port));
> > -
> > -	trace_virtio_transport_recv_pkt(src.svm_cid, src.svm_port,
> > -					dst.svm_cid, dst.svm_port,
> > -					le32_to_cpu(hdr->len),
> > -					le16_to_cpu(hdr->type),
> > -					le16_to_cpu(hdr->op),
> > -					le32_to_cpu(hdr->flags),
> > -					le32_to_cpu(hdr->buf_alloc),
> > -					le32_to_cpu(hdr->fwd_cnt));
> > 
> > -	if (!virtio_transport_valid_type(le16_to_cpu(hdr->type))) {
> > -		(void)virtio_transport_reset_no_sock(t, skb, net);
> > -		goto free_pkt;
> > -	}
> > +	if (!virtio_transport_valid_type(le16_to_cpu(hdr->type)))
> > +		return NULL;
> > 
> > -	/* The socket must be in connected or bound table
> > -	 * otherwise send reset back
> > -	 */
> > -	sk = vsock_find_connected_socket_net(&src, &dst, net);
> > -	if (!sk) {
> > -		sk = vsock_find_bound_socket_net(&dst, net);
> > -		if (!sk) {
> > -			(void)virtio_transport_reset_no_sock(t, skb, net);
> > -			goto free_pkt;
> > -		}
> > -	}
> > +	sk = vsock_find_connected_socket_net(src, dst, net);
> > +	if (!sk)
> > +		sk = vsock_find_bound_socket_net(dst, net);
> > +	if (!sk)
> > +		return NULL;
> > 
> > 	if (virtio_transport_get_type(sk) != le16_to_cpu(hdr->type)) {
> > -		(void)virtio_transport_reset_no_sock(t, skb, net);
> > 		sock_put(sk);
> > -		goto free_pkt;
> > +		return NULL;
> > 	}
> > 
> > -	if (!skb_set_owner_sk_safe(skb, sk)) {
> > -		WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> > -		goto free_pkt;
> > -	}
> > +	return sk;
> > +}
> > 
> > -	vsk = vsock_sk(sk);
> > +/*
> > + * The caller holds sk's socket lock and must free skb if this returns true.
> 
> Why the skb must be freed by the caller and not by this function itself?
> 
> > + */
> > +static bool
> > +virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> > +				 struct sk_buff *skb, struct sock *sk)
> > +{
> > +	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> > +	struct sockaddr_vm src;
> > +	struct vsock_sock *vsk = vsock_sk(sk);
> > +	bool space_available;
> 
> Please, follow the netdev convection for ordering local variables: https://www.kernel.org/doc/html/v7.2/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs
> 
> > 
> > -	lock_sock(sk);
> > +	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
> > +			le32_to_cpu(hdr->src_port));
> > 
> > -	/* Check if sk has been closed or assigned to another transport before
> > -	 * lock_sock (note: listener sockets are not assigned to any transport)
> > +	/* Listener sockets accept packets from any source and are not assigned to
> > +	 * a transport.
> > 	 */
> 
> Why changing this comment in this commit?
> 
> Oh because we moved out lock_sock, right?
> 
> I think we should keep in some way the old info that was much more
> informative that the current comment that just say what the check is doing
> and not why.
> 
> > 	if (sock_flag(sk, SOCK_DONE) ||
> > 	    (sk->sk_state != TCP_LISTEN &&
> > 	     !vsock_check_source(vsk, &t->transport, &src))) {
> > -		(void)virtio_transport_reset_no_sock(t, skb, net);
> > -		release_sock(sk);
> > -		sock_put(sk);
> > -		goto free_pkt;
> > +		(void)virtio_transport_reset_no_sock(t, skb, sock_net(sk));
> 
> We need to be careful here, IIRC Bobby used the net from the caller for a
> reason.
> 
> Are you sure it's fine this change? Why not passing net as parameter and
> minimize changes?

I think you may be remembering this issue:

a6ae12a599e0 ("virtio: set skb owner of virtio_transport_reset_no_sock() reply")

?

If so, sock_net(sk) might still be okay, but I 100% agree we shouldn't
change things haphazardly if avoidable.

> 
> > +		return true;
> > 	}
> > 
> > 	space_available = virtio_transport_space_update(sk, skb);
> > 
> > 	/* Update CID in case it has changed after a transport reset event */
> > 	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
> > -		vsk->local_addr.svm_cid = dst.svm_cid;
> > +		vsk->local_addr.svm_cid = le64_to_cpu(hdr->dst_cid);
> > 
> > 	if (space_available)
> > 		sk->sk_write_space(sk);
> > @@ -1870,17 +1849,60 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> > 		kfree_skb(skb);
> > 		break;
> > 	default:
> > -		(void)virtio_transport_reset_no_sock(t, skb, net);
> > +		(void)virtio_transport_reset_no_sock(t, skb, sock_net(sk));
> > 		kfree_skb(skb);
> > 		break;
> > 	}
> > 
> > +	return false;
> > +}
> > +
> > +/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
> > + * lock.
> > + */
> > +void virtio_transport_recv_pkt(struct virtio_transport *t,
> > +			       struct sk_buff *skb, struct net *net)
> > +{
> > +	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> > +	struct sockaddr_vm src, dst;
> > +	struct sock *sk;
> > +	bool free_pkt;
> > +
> > +	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
> > +			le32_to_cpu(hdr->src_port));
> > +	vsock_addr_init(&dst, le64_to_cpu(hdr->dst_cid),
> > +			le32_to_cpu(hdr->dst_port));
> > +
> > +	trace_virtio_transport_recv_pkt(src.svm_cid, src.svm_port,
> > +					dst.svm_cid, dst.svm_port,
> > +					le32_to_cpu(hdr->len),
> > +					le16_to_cpu(hdr->type),
> > +					le16_to_cpu(hdr->op),
> > +					le32_to_cpu(hdr->flags),
> > +					le32_to_cpu(hdr->buf_alloc),
> > +					le32_to_cpu(hdr->fwd_cnt));
> > +
> > +	sk = virtio_transport_find_socket(skb, &src, &dst, net);
> > +	if (!sk) {
> > +		(void)virtio_transport_reset_no_sock(t, skb, net);
> > +		goto free_pkt;
> > +	}
> > +
> > +	if (!skb_set_owner_sk_safe(skb, sk)) {
> > +		WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> > +		goto free_pkt;
> > +	}
> > +
> > +	lock_sock(sk);
> > +	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk);
> > 	release_sock(sk);
> > 
> > 	/* Release refcnt obtained when we fetched this socket out of the
> > 	 * bound or connected list.
> > 	 */
> > 	sock_put(sk);
> > +	if (free_pkt)
> > +		kfree_skb(skb);
> > 	return;
> > 
> > free_pkt:
> > -- 
> > 2.53.0
> > 
> 
