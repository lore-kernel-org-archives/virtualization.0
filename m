Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A35283FDD
	for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 14:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781275923; cv=none; b=C98xBdOpKhiqKmLCfKr2wxWqBf3NiCVPuHF+YJ1C4JnQ6Hl5noaW2wzIB1D1EYaOdutA7ussgnGs2kbSMVFCLupU70qMyOraAFqd+hxkA9tnwTAKWodxambPuhdkrQi5fqGvIYOmXY7/paDKmowa4YdJEN86Uaneokzrj4hNha4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781275923; c=relaxed/simple;
	bh=MtLXFPswneMburYu+lWG7VpR1RjssBUjozfMNoj/Av4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ng63kj8UjT9VuuuIaUH8egg90So4dVGpxiwxzkgrtgLPCskYheDsjV0wLthZTybtfU7eLwz26PdM2NGkDI4bzY6zsX3FaKzwnsQT6C/iaYEW5pQI37pHatnTGbaZYO7ubEfK9r6hnG94L9jXXMpcgjHBUo//7ZzneoZweLtNHGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asnzoVJV; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asnzoVJV"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c2da7fa321so4673855ad.1
        for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 07:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781275922; x=1781880722; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JqMd8Q5yt8mAGXSVOkSVuvsH9v3zwILU1VT0pazsblM=;
        b=asnzoVJVFY/qkFMNRt8QEjuMppXmrLfv7gistE6TJjHkIM6UhcOEvhgHnRX+v2lHYW
         taTV3cd8PNiCITYdfLJZPNeQ2ykbrj8ArA/Jx66b5ToW/HVxzGRUeKKHkjpkebpgyeBx
         ihdNkcWXq025Qhp8QAbp6/uCE4GZzhiJuNbl9l/igQz612Wi02/IjYDcZQ5+TrAiBgu8
         DvQUHOiFBPSttk+jBtE3GOwZCDbXfi7DKFMCat0xBCPe93szihyNI8cp3YQZeDnBA92v
         T4snj+0ZmaQuqcx5pssVEi4CnH6QAPX8US69NIAaLg7L0IJLwm09WVnLwtelTkle0+Zo
         NxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781275922; x=1781880722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JqMd8Q5yt8mAGXSVOkSVuvsH9v3zwILU1VT0pazsblM=;
        b=Kym9xVemwZUeU8xCNgJHqlkfKvrrQadCzBkhaUDTo3jrnOTA8LTuFxfFSKaULX1isE
         sfyduuJkNPUF/4zphEnOm2kwirigGjh+ngBwXiDxdHFY07uDOlbQy2ykZXPmrXkismy3
         1m38Hz9u1BaDfWhT5PXSl+9bdI+h0DtJCGYs6K7QfB0vXKLsJPG2ZDB72H9f/Z5ido11
         OskK9/fbSYutc1sMnMpaMo7TUWddRnQz4jfHAHYB/X5XDDjB7Nri9GN0SbO2YQW5JHwD
         X4gbKvSs0Ty9Ol4hqyrAg92C+wRF9pT40t23WnK8Rzq9ngFk7tsSVQFou7u1CKuZXXC4
         5aPw==
X-Forwarded-Encrypted: i=1; AFNElJ/PRRMjwWMa/pOvuw0KmFb0qXJHMbk2DF8Rg6Xdf34rqcPCTbSlUFbolCRvkK3t3cpe0/9v0LV8/OyqUq58nA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz9og6Vjz2bYzAzzPo9d4FnAy/mBhELXPAbC4UqOkRBPf8aSDnc
	iqexi0rvE+3gCswjpgHepM/M5rQVqSYwkw7R95umdmpDMWXUbb6yNpvf
X-Gm-Gg: Acq92OF1eIuM65B+3nj75DK+MdyrkLST11rn+PCrnsKjTnKvl7IiyXfVR9HwXcmAbef
	HEoZEehZ78RRCoEvgq7ZMGBNdxgkGA5RkLcZcAIIyY4yF8222uQeQN0R7vYFVPw0qWX52Vo0xHf
	2R7Ya812PYGo1dbD/v1Q+ztsQebmO4cTBRTefb12P/XGL1R98UyXDbfwCjIRaeyRLpDaO1MT1/X
	2giC2QB5aPmk7ERPrNCiqAFUyBJfDLzkNsQgm1RBuJoCxsNKxxzqhEmCKbeBgc701Ijjvhj85x/
	1xe7Yd7yqf/X0AbYSqC6f2QTUYKXkDm3a0M/cJXP79HkiO1ih4BULg+arPmthfu5iSFcaxwRVyB
	ZRoOA5Oa4iY/NlEj2jvITwZutyeA2N0u6SWCIo1d5yfJod0chL3sXuf3aTYojFMlCmwlpkRjltq
	IalQHnKHp0lLG6nxyCOZraj9A/yLAmojqahg9y7JPsAS6L
X-Received: by 2002:a17:903:2bcb:b0:2bc:8f9a:3642 with SMTP id d9443c01a7336-2c4114a22d3mr39476645ad.16.1781275921806;
        Fri, 12 Jun 2026 07:52:01 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac72asm25666815ad.38.2026.06.12.07.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 07:52:01 -0700 (PDT)
Date: Fri, 12 Jun 2026 07:51:59 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	pabeni@redhat.com, sgarzare@redhat.com, stefanha@redhat.com,
	bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, leonardi@redhat.com,
	horms@kernel.org, edumazet@google.com, kuba@kernel.org
Subject: Re: [PATCH net-next v3 4/4] vsock: fold sk_acceptq_removed() into
 vsock_remove_pending()
Message-ID: <aiwdD5EAqxW6Xunv@devvm29614.prn0.facebook.com>
References: <20260612045216.105796-1-rafdog35@gmail.com>
 <20260612045216.105796-5-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612045216.105796-5-rafdog35@gmail.com>

On Fri, Jun 12, 2026 at 04:52:16AM +0000, Raf Dickson wrote:
> Callers of vsock_remove_pending() must also call sk_acceptq_removed()
> to keep sk_ack_backlog consistent. Move the call into
> vsock_remove_pending() itself to make it automatic and prevent future
> callers from forgetting it.
> 
> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Raf Dickson <rafdog35@gmail.com>
> ---
>  net/vmw_vsock/af_vsock.c       | 2 +-
>  net/vmw_vsock/vmci_transport.c | 4 +---
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 24916dd4e9..4a7d6d247a 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -494,6 +494,7 @@ void vsock_remove_pending(struct sock *listener, struct sock *pending)
>  	list_del_init(&vpending->pending_links);
>  	sock_put(listener);
>  	sock_put(pending);
> +	sk_acceptq_removed(listener);
>  }
>  EXPORT_SYMBOL_GPL(vsock_remove_pending);
>  
> @@ -773,7 +774,6 @@ static void vsock_pending_work(struct work_struct *work)
>  	if (vsock_is_pending(sk)) {
>  		vsock_remove_pending(listener, sk);
>  
> -		sk_acceptq_removed(listener);
>  	} else if (!vsk->rejected) {
>  		/* We are not on the pending list and accept() did not reject
>  		 * us, so we must have been accepted by our user process.  We
> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
> index c2db016cca..3e6445f4e1 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
> @@ -980,10 +980,8 @@ static int vmci_transport_recv_listen(struct sock *sk,
>  			err = -EINVAL;
>  		}
>  
> -		if (err < 0) {
> +		if (err < 0)
>  			vsock_remove_pending(sk, pending);
> -			sk_acceptq_removed(sk);
> -		}
>  
>  		release_sock(pending);
>  		vmci_transport_release_pending(pending);
> -- 
> 2.54.0
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
