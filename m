Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA3D4E3239
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790607627; cv=none; b=ZCDeMGPjDO/RvF23N3WVWROycERFx8b/fPa4sALU23FHYnVCC71bw35SC+ZV1dpUW0pFSu94tIZUV7EgXc3Q/+fX0XeDwJFfEnB/aTkz4CDNit9m2qcLYLdWvhiOsaH6YCohItVQhFYQUooI1UrobjwIo8141KqirjsicoL5pJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790607627; c=relaxed/simple;
	bh=FarrX1AXajp0rcAMMevqe1ADxQNLZJK0VOe0E5fUEKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=S824zXoStbVQA8rKUHRDq/jpageYfVD61E4OiHN6RwokB+V2s7lYsKUcfeU2WOtxZcYIP5K2Qi6zZzOzqjdjWf1QJh38q2/TmFdbu6cM7OJN1XdEi1Ilv7kT1ZGZYFfZAHmAdyQFGCkgwzf0xLM+1Hz23OwJYsCIZ+CE3VlHtVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KQEXO095; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KQEXO095"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790607624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eLs8yZfJYGp54djsbn71UyAfwiNLWW6mOvXDf6yGk6E=;
	b=KQEXO095cr7w/2y/QKSIbVo3b3+XPYsgB+4hJwNH/Js/WDxs8RK09aHO0OYs2J9NS3BAMP
	t+iS3dR0skWgZo6Cs+Of0HTpM5kbhYSAUADRZL4HUNCUhhiGy8ccqzHeJdfCs4COvjLDw1
	mWsmkwS8ekVdS6/7wJEkpssAzEvdBRs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-PCpnJBXvOwqR9g4kJX8ipg-1; Mon, 28 Sep 2026 11:00:22 -0400
X-MC-Unique: PCpnJBXvOwqR9g4kJX8ipg-1
X-Mimecast-MFC-AGG-ID: PCpnJBXvOwqR9g4kJX8ipg_1790607621
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48aec01b6b6so464672f8f.1
        for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 08:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790607621; x=1791212421;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eLs8yZfJYGp54djsbn71UyAfwiNLWW6mOvXDf6yGk6E=;
        b=PCZFjhF7aRQ/EnDKrle1yjbz92V/Vo2GIV+ZpmSDzfnOOrZOu/yc4ZXtd2dqeq/SLQ
         qzSSGD9CCAaLs3i5jL/U7WBwlrTztic01yptPdvpC+OkEC8k+bc8ScYierBR5CexrpMK
         HSgEohT9cEKrOThcPsVComDeb1/4yWvawr4u8M1vi0eJLVCfjwMQVPYZTZVElYBXiZWA
         vrUQ4JnAw7t9E4aJj+2lcLMOIagv0lbHq0ZBo2m0iVvHald2Gvt9/BuBEr03drOi3juX
         7IyFXZFDsIJUEysSXhbjoPxpiOGbzri/4RDx2tVK4FhmDuxERrCcyS2gastlVI0rUPY0
         +vPw==
X-Forwarded-Encrypted: i=1; AKwUvBwYwnxtysF1gysjQ+h2puWWvzD62Ur8ESoKBfGw6BfYMX8ldxFumzfRlN7ahiL2crWkeSS7/865zRcqUzqV0g==@lists.linux.dev
X-Gm-Message-State: AFq9FYK6EVftnhdGw6k0kwuOTBnxnbmKcuQ/mfpBCzf09P4VFci9casl
	YMIzdSsWoqe2wDIDPp7CQ82BCCE9jyDMTs71Gle8OEh3S79gw8gUYk3mB9NOmWLI5wzQu277Hll
	bwJYnEOwKtMsjPPkFZzz1TaV7CCzqeEcjXi/VQBkK8msWGnvb75eGH3s493KtChe5QAh8
X-Gm-Gg: AYBFou0EFv1J7sqzVeiGnFB138b+1EninF1YgLSPPsvrpytPTsYNVPXHADRu81wGJFb
	rCDnA3koSLWjyNcpzBNXvjqpKBxR3DagtwMFygN6SuuJ5wqCe8dmhvuOdB9rMSXraK174e9B6qm
	sjrIbpL1PMe9VdZhRe9VmHffz9cOp6nbBuBXFI+OB9+XV27hSYyqYKoBDf8p+sInGzojJOU4ujC
	MUaE30mQmhaZVfjEMqHIb5ElCjvHW0nK7rXbPNcpINCq6SM/w7x2oR0F+CMb95nTeHaM98oGpT9
	En1nNsPPbbPfm83WsTZjEGQjIqiYa5JKQZplwKzyUkze7NPbopBhegEfMy/dPZWsfGG0aFtaUQ8
	s1kA=
X-Received: by 2002:a05:6000:4b0a:b0:488:823d:507b with SMTP id ffacd0b85a97d-488823d5296mr15209782f8f.52.1790607621212;
        Mon, 28 Sep 2026 08:00:21 -0700 (PDT)
X-Received: by 2002:a05:6000:4b0a:b0:488:823d:507b with SMTP id ffacd0b85a97d-488823d5296mr15209714f8f.52.1790607620571;
        Mon, 28 Sep 2026 08:00:20 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.146.191])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a349731sm28558683f8f.12.2026.09.28.08.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 08:00:19 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:00:12 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: David Carlier <devnexen@gmail.com>
Cc: netdev@vger.kernel.org, bobbyeshleman@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] vsock: report pending receive data to
 io_uring
Message-ID: <arqAF53k2arP4enr@sgarzare-redhat>
References: <20260923184008.153541-1-devnexen@gmail.com>
 <20260923184008.153541-2-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260923184008.153541-2-devnexen@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3dd9RwBZdwwlrOtID9njKOmMCOUCkIZ9_E-aFzoNIu8_1790607621
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 23, 2026 at 07:40:07PM +0100, David Carlier wrote:
> AF_VSOCK stream receives never fill msghdr.msg_inq, so io_uring cannot set
> IORING_CQE_F_SOCK_NONEMPTY and retries a multishot receive even after the
> queue has been drained.
> 
> Fill the hint at the common receive exit using the transport callback that
> SIOCINQ already uses, and report 1 once the connection is finished so the
> caller performs the receive which observes EOF, as TCP does after a FIN.
> 
> A vsock loopback ping-pong with io_uring multishot receive drops entries
> into __vsock_connectible_recvmsg from 1.97 to 1.00 per delivered message,
> and receiver CPU time by about 3% (25 runs of 50000 messages, p=0.006).
> 
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  net/vmw_vsock/af_vsock.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index f840498b58af..20d6f9ca6a96 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -2543,6 +2543,35 @@ static int __vsock_seqpacket_recvmsg(struct sock *sk, struct msghdr *msg,
>  	return err;
>  }
>  
> +/* Bytes a following receive can consume, 1 if it would only see EOF, or -1
> + * if the transport cannot tell.
> + *
> + * Called under the socket lock after a nonnegative stream receive, so a NULL
> + * transport implies SOCK_DONE.
> + */
> +static int vsock_stream_inq_hint(struct sock *sk)
> +{
> +	struct vsock_sock *vsk = vsock_sk(sk);
> +	s64 data;
> +
> +	if ((sk->sk_shutdown & RCV_SHUTDOWN) || !vsk->transport ||
> +	    (sock_flag(sk, SOCK_DONE) && sk->sk_state != TCP_ESTABLISHED))
> +		return 1;
> +
> +	data = vsock_stream_has_data(vsk);
> +	if (data < 0)
> +		return -1;
> +	if (data > 0)
> +		return min_t(s64, data, INT_MAX);
> +
> +	/* Empty but finished: keep the caller reading so it sees EOF. */
> +	if (sock_flag(sk, SOCK_DONE) ||
> +	    (READ_ONCE(vsk->peer_shutdown) & SEND_SHUTDOWN))
> +		return 1;
> +
> +	return 0;
> +}
> +
>  int
>  __vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>  			    int flags)
> @@ -2606,6 +2635,12 @@ __vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>  		err = __vsock_seqpacket_recvmsg(sk, msg, len, flags);
>  
>  out:
> +	/* Seqpacket has_data counts messages, while io_uring treats msg_inq as

Do you mean vsock_stream_has_data() on SOCK_SEQPACKET doesn't return 
bytes?

IMO names are confusing, but it should return number of bytes, we should 
fix it, but of course not in this patch.

LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


> +	 * a byte length when sizing retries, so only streams report a hint.
> +	 */
> +	if (msg->msg_get_inq && err >= 0 && sk->sk_type == SOCK_STREAM)
> +		msg->msg_inq = vsock_stream_inq_hint(sk);
> +
>  	release_sock(sk);
>  	return err;
>  }
> -- 
> 2.55.0
> 

