Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E3E38D6A2
	for <virtualization@lists.linux.dev>; Thu, 20 Aug 2026 18:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787249243; cv=none; b=A1K0bacI43cpk1VnTSyVxm+BbuvO8aBklu7vaFmtp2Ng2XdlEvQRZXKXjQDPbFaynxAPRbk0fPfkdjrL0wyCKQoTvJMY6o9UZlMzGHoX0+0yX6NM3IQsG0uTGmAq5augiGTFvLkrRde2NKFDV8S+/r5UrLFWXEV+/RwSsndc7Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787249243; c=relaxed/simple;
	bh=ni3ajiGa788PkOa6kZ1AEOtext1QsSQ8nmKnd6IXZ/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amJ8IGX21vD89r6RFaQxzW5aRtf5TOn+qNyo8oPbEUHISsY91qTZvW10xtzR5L04WwgMkjlIjQQ7l0G1zA+7Apf+yJlWpWzVJcvrB60c33WJuD/VFVf5UJKQU6dgbtXBNCDlsT5QnKGx1cPcfChsCiF4TtzbHrH1DmlWBCEl8zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVNo0zNH; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVNo0zNH"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6b14b207e05so151918eaf.3
        for <virtualization@lists.linux.dev>; Thu, 20 Aug 2026 11:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787249240; x=1787854040; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eoDlMO2HjMe2TjRXcPUA1zA1Xxgl6+t6qZXrrtvEsbA=;
        b=fVNo0zNHj63w9BHpfgAYT5aF3Y/z/V1tFVGewh9xkAT/KnGn17d/6xHHYiTOSk0ymH
         ixpJurtcTpLqovofUmtrPN89i6J5XNzEjc+2tgEcAAllmzjMvCMzbLvCiMGqxsMcbLSQ
         yXo0pYyZHyVdCY6/FE03ViusEkR8v6bjdVMd5y1QVjBRlOHDvPjkImDrrtTbJPwJr33y
         KRNEYBCbkTwtCSeqBW2cWvvuMP0ApbxOtmm0QgADehu8FKDmWO4rMoyc5bjRr8yjG3/L
         XETCh4H4qFoZOC5L1mdK/LzTvwH5RkNAxh4726YZdAPws9brxMexaQ0dymTj8RW0TqRy
         itHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787249240; x=1787854040;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eoDlMO2HjMe2TjRXcPUA1zA1Xxgl6+t6qZXrrtvEsbA=;
        b=Ftb/m2gWuozHrdGCufAPvHLWCoDnHYk0XpzOK8rWXU9St2DjwP9RUGYB9XAU1MER2p
         //gxA3Kx7cQEQIgMY1n3PS14HZKyy+K0HJXXh9rwlfApMcDPLvKGe4I29VlnCIhCM2sn
         S/Arpb4D63Gn4lsm5k7e9DXowNyUH0BzCxx3j77dcaAE3Zw7ZvhqABrRIZL4clhCos2u
         jerZmDwOFLvbpFmbsgUYg0BHwwdKjt1gcIxcUGD+61yF84YQ7SbSsV3y9Y9JfNJuJH6A
         eSgKP0fxG3c5ums9CHACQU2LbNqTx9lu3cQ9i6wwnDcF9YxQ97aJFpKDiKnW5lekPmms
         ZD3w==
X-Forwarded-Encrypted: i=1; AHgh+RoYZJnowxYrMU0x+IwIGHQ4qPU1gd9gvsuxVw1S/mMVxmyjkAqQ1dhNmRndHFVQeIZuQFn54Zrsy8R5J9t0IA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4CEkxdo7ZT55LYwO3LF5RYbC28TpSTS+ezIHDqiLre6RQA0po
	4h3hM5AZTYD+JRq50Fk3HwBP9cL00Gt4onNjJf+/EsxkU5TS882OJ2dA
X-Gm-Gg: AR+sD12gYQlD5MwXRp2x8jgR/nUgya/L0ohRpb/LwF5xOBdG45icC0W1Dy+w9knUkbo
	6ykrzmEZpTCRkoAumyheNgYQP6mz7VY69ysQebn+gAAhd+kSl1wai1X2AuDBEWVoySKSpzrKevn
	TnlP9Ns/gvtAlFBH7g1r+LrHnkTXStlqgAbgpms75TOOuYcq/v1NO1h/cRzRxLfbCc04IAn3i5j
	aLt0DKSg6tIeDbSxhYUTTlp8jsEQ01gU4mnwc1SZpR4pmg8MY/dRznasnHoDK0Ft3ouFCGTx4lz
	k8NtYxXDy5/tfNP3lkdrKrRad37HCoZadngwrCh7geyvaVGFII8QbJFNf//KfwsFNKW3TJoFzv0
	ayY0+48v9a52pnorDKX5iCAjJZqMS3b3ZebgABtyDIzkjAaFTbHDNny21i+OG5VD0bNci5rlMOO
	ImPbNoiqyFL1LwM7kDQWffF9tjsrrdBFzg2AAL8cxC7bQXlT3hrL/ByAiQ6L8izKO0/nSDS8HYK
	aEmP2oe
X-Received: by 2002:a05:6820:200a:b0:6ab:13:b207 with SMTP id 006d021491bc7-6b1593ee12cmr572636eaf.27.1787249240224;
        Thu, 20 Aug 2026 11:07:20 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b13cf065d3sm5797270eaf.12.2026.08.20.11.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 11:07:18 -0700 (PDT)
Date: Thu, 20 Aug 2026 11:07:16 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: netdev@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH net v2] vsock/virtio: validate packet source for
 connected sockets
Message-ID: <aodCVDNMDPhxw45G@devvm29614.prn0.facebook.com>
References: <20260820001517.2148196-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820001517.2148196-1-4ncienth@gmail.com>

On Thu, Aug 20, 2026 at 09:15:17AM +0900, Daehyeon Ko wrote:
> virtio_transport_recv_pkt() looks up sockets first by the full source and
> destination tuple, then by destination only in the bound table.  The
> fallback is needed for listening and connecting sockets, but sockets remain
> in the bound table after connect(), so it can also return a non-listening
> socket.
> 
> The fallback does not validate the source address.  In TCP_SYN_SENT, a
> RESPONSE from an unrelated source can transition the victim socket to
> TCP_ESTABLISHED while its stored remote address remains unchanged.
> Subsequent RW packets from that source are delivered through the same
> destination-only fallback.
> 
> This was reproduced with capability-empty processes under different UIDs.
> The attacker discovered the target tuple through unprivileged AF_VSOCK
> sock_diag and caused the victim socket to read 16 attacker-chosen bytes;
> the intended peer-side socket read 0 of those 16 bytes.
> 
> After lock_sock(), reject packets for non-listening sockets unless their
> source port matches the stored remote port.  Require the CID to match too,
> except that the loopback transport uses VMADDR_CID_LOCAL as the packet
> source for connections addressed through its valid CID aliases.
> 
> Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
> Closes: https://lore.kernel.org/netdev/20260813121236.2328599-1-4ncienth@gmail.com/
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
> ---
> Changes in v2:
> - Preserve valid loopback CID aliases by matching the source port and
>   accepting VMADDR_CID_LOCAL only for the loopback transport.
> - Rewrite the commit message and receive-path comment for clarity.
> 
> v1: https://lore.kernel.org/netdev/20260813121236.2328599-1-4ncienth@gmail.com/
> 
>  net/vmw_vsock/virtio_transport_common.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 8becad812..d8990f5f6 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -1764,6 +1764,21 @@ static bool virtio_transport_valid_type(u16 type)
>  	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET);
>  }
>  
> +static bool virtio_transport_source_matches(const struct virtio_transport *t,
> +					    const struct sockaddr_vm *src,
> +					    const struct sockaddr_vm *remote)
> +{
> +	if (src->svm_port != remote->svm_port)
> +		return false;
> +
> +	if (src->svm_cid == remote->svm_cid)
> +		return true;
> +
> +	/* The loopback transport represents its peer as VMADDR_CID_LOCAL. */
> +	return t->transport.get_local_cid() == VMADDR_CID_LOCAL &&
> +	       src->svm_cid == VMADDR_CID_LOCAL;

nit: not a strong preference, but I feel this comes out a little more
readable as:

	return src->svm_cid == t->transport.get_local_cid(); 

Otherwise, all looks good to me.

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>

> +}
> +
>  /* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
>   * lock.
>   */
> @@ -1823,10 +1838,15 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>  	lock_sock(sk);
>  
>  	/* Check if sk has been closed or assigned to another transport before
> -	 * lock_sock (note: listener sockets are not assigned to any transport)
> +	 * lock_sock (note: listener sockets are not assigned to any transport).
> +	 * The bound-table fallback matches only the destination, so reject packets
> +	 * from a peer other than the one stored in the socket.
>  	 */
>  	if (sock_flag(sk, SOCK_DONE) ||
> -	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
> +	    (sk->sk_state != TCP_LISTEN &&
> +	     (vsk->transport != &t->transport ||
> +	      !virtio_transport_source_matches(t, &src,
> +					       &vsk->remote_addr)))) {
>  		(void)virtio_transport_reset_no_sock(t, skb, net);
>  		release_sock(sk);
>  		sock_put(sk);
> 
> base-commit: e2466392a0b8496000e12181cb1ee1535eb0da25
> -- 
> 2.54.0
