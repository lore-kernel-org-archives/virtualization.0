Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CAD3783CC
	for <virtualization@lists.linux.dev>; Mon, 17 Aug 2026 17:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786989407; cv=none; b=L3FlcKieAVaz+ApFWPWBB0BSecN9b68DGOzdwOBHMEgjn8qaHP5bZVQbAjMFqkGjFNUxKPVH4AJtqrxZCwGpn3Aa60aZubFA6J6WjCagXjIMcTr77MSTii+BmcyEfSOvgEojG9WyZd2A6dK3k/vpm4C/UeMx2QyDHWqW5L/xez8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786989407; c=relaxed/simple;
	bh=9JWIDMRvb6uL0k6LrrHl7ti08cD3k8wEjt9ZJwkEjxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0mz4KaE9+47BJ1Eq6AkqmDFGWnziMbugdYTSV+xrRCkkr3BUdntj0IBi7l1nkqVApL2ZoOebjeToPspYW9Izwjey2SvnnmHQGb7pklzbYSw8jmO4VTFOf7J0kYoeOAOK6tP8kGt85KtLXmtlAvx4yR/8ii5rBYW60q6RYW+d/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtW+EF46; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtW+EF46"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7eb34c17b96so2730896a34.2
        for <virtualization@lists.linux.dev>; Mon, 17 Aug 2026 10:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786989404; x=1787594204; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8k1YxolwhVR5S1sB1XwRYtHWGpS7hH+697FP1h9LyqI=;
        b=CtW+EF46HT0VghwgjBy0oj6fFoNECpnk2gSPQB9co8SCY3dbyRjGlMYoqgJiTuLXWV
         tVW+IhivB6Lq/uKpUhVBrOWzik3wKr2zxTFGF8vzZqf/AS8ZLuKJE+tPHYrcueQYnsoi
         IvhDSD0QXn1EoF08+Zbh0Q4/dWBXSTnExW27F8N98Sn7MAKlywMJMfE4IWTnclc5ZUHo
         Dah9xWAaaeBwzmYqmagwtc9F6qYPMLuXrTQj2dcFwulynXB6y5RfMx5tsAuHHt0IMQkR
         H3Vpd+6+r/m/kN6Joo/5ZpKc0XOvNrUiaG4jsepKUHki9i6Qq7Tr9iL5DuP+c0zVbPLC
         aIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786989404; x=1787594204;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8k1YxolwhVR5S1sB1XwRYtHWGpS7hH+697FP1h9LyqI=;
        b=V5fqfiHLIAm0XdHjvs7qnYQCMWoVJxQ+S7SuYzmG9kRR0sH5fHo1r/7MpkBLZSBzKI
         U0GeVsH8XqKDBdKBYENdz5pwsnSESSNFnbtYEXyM9QcJddyPm14j7miDqLaYEHNKoGGr
         BI8z68XsDwr6coGUIwJ/tl79u1J6pjK/QkcT6EZJERXN6ekuSIAkLXeyq+xAhRbb9xoy
         zlhBtvnvNUvvAGs6us6frpnb1KbKf4N5cFDHyvOWz3kfndbI/m4UufiCb+plJf+Vy9ye
         xwpUuf+kjeHyHR4npCKOE6q3k3DEb95Pgkn8bnI61euF4r1GjFcLVbVH8d9zcUVXu0M4
         LZYg==
X-Forwarded-Encrypted: i=1; AHgh+Rp68OV7C5HerYc5D7JSjpWTREojyk/b25Y3+9UHHYNLCaain80C2dRB0mgB//VtjwgY7ZB8WqF59/vp3kl6hQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXFcTLYfyUlLiO6tHzREVuk4wkLHG+EemU2CZbrzUuWBfFLkoS
	vFpXe5wW0WeO7a3fN145RzfXisc8rwXgrg+RVe9div+sgpV8r/pXfYU2
X-Gm-Gg: AR+sD10Nt/Io0in68eU2kgx9Vumt9Pwy6NMLPmy7kqX+PN6V9T1pLjLJgq2LcRVnCRP
	LQmHFE8NFIxgTaQa4KJ1ZHFaClsVaCe5LeQ7K/L9V2w1T0s2v48UgHPxLZdSo8vjXxywgzhitvv
	zajVzq3mE0XnlzIPFw4zA9/n12H2QZWhgDZHIfR+WeVjRFycDELbU1EYncxLXeof5PABKNAphKM
	G6j5rv0hSa5ho8q+EXn6YUcJpVRLZCle5gS5GFcmDpA9X5GEvN765A/B3eLgNmVIkjzONBXMiHO
	RNZYAJ2lOsgdd5ctvHSAIuqc0ZaDV5obBEORX5JJ5etpoLUEbGgiPzQQtOeqABToUu4TnDGTE8j
	MV3uuBicJlEOsFb1p0rI+tWXxm+6JqahKa3KCE5EcLw8HP9Tk5zrca2ZoR7Xp1sa2dWG8fhdrNz
	VM2OZbE1WThKbCSRg4p5G6LLT+rrzUEAAvlr7w8BQfoVG9flAqidCoe2ZTBxjG8ilDacGVcZI+C
	bJQ8F+vkA==
X-Received: by 2002:a05:6830:6809:b0:7e7:5e4:ee11 with SMTP id 46e09a7af769-7f3de809148mr27312808a34.16.1786989404542;
        Mon, 17 Aug 2026 10:56:44 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:52::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f41c0b935bsm2004457a34.14.2026.08.17.10.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 10:56:43 -0700 (PDT)
Date: Mon, 17 Aug 2026 10:56:38 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: netdev@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH net] vsock/virtio: validate packet source for connected
 sockets
Message-ID: <aoNLVoPQssG1V6bt@devvm29614.prn0.facebook.com>
References: <20260813121236.2328599-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813121236.2328599-1-4ncienth@gmail.com>

On Thu, Aug 13, 2026 at 09:12:36PM +0900, Daehyeon Ko wrote:
> virtio_transport_recv_pkt() first looks up a socket using the full source
> and destination tuple.  If that misses, it falls back to a bound-socket
> lookup using only the destination address.  The fallback is needed for
> listening and connecting sockets, but it can also select an established
> socket that remains in the bound table.
> 
> As a result, a packet from an unrelated source can be dispatched to a
> non-listening socket.  In TCP_SYN_SENT, a source-blind RESPONSE marks the
> selected socket established while retaining its original remote address.
> Subsequent RW packets can likewise be delivered through the
> destination-only fallback.
> 
> This was reproduced with two capless processes under different UIDs.  The
> attacker discovered the victim tuple through unprivileged AF_VSOCK
> sock_diag and injected a chosen 16-byte payload into the victim established
> loopback socket.  The legitimate peer received none of those bytes.
> 
> After taking the socket lock, verify that packets for non-listening sockets
> come from the peer stored in remote_addr.  Listening sockets continue to
> accept packets from any source.
> 
> Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 8becad812..f73e0406a 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -1822,11 +1822,15 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>  
>  	lock_sock(sk);
>  
> -	/* Check if sk has been closed or assigned to another transport before
> -	 * lock_sock (note: listener sockets are not assigned to any transport)
> +	/* Check if sk has been closed, assigned to another transport, or if the
> +	 * packet is from a different peer than the one connected to sk.  These
> +	 * properties could have changed before lock_sock.  Listener sockets are
> +	 * not assigned to any transport and accept packets from any peer.
>  	 */
>  	if (sock_flag(sk, SOCK_DONE) ||
> -	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
> +	    (sk->sk_state != TCP_LISTEN &&
> +	     (vsk->transport != &t->transport ||
> +	      !vsock_addr_equals_addr(&src, &vsk->remote_addr)))) {

Does this equality work for loopback, when the CID may be
VMADDR_CID_LOCAL and/or VMADDR_CID_HOST on host or the guest CID in
guest?

Best,
Bobby
