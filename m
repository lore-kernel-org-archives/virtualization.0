Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8640A347535
	for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781275874; cv=none; b=WzJVj5PIuP/dMsUGqqP8WEk2LQJiP3D+v6v07laeAq2piwm0+XKSk6k0if0fkY0+MAOKGojsLr365BKiTsHHxYW+IZ81sRsBMHO/dmnBvP0JgRZyaU7Ye7N3Du/Inafvv0uXhXvCSeBZRTkCxD5pr3FiwaQoQhwMGgRZJPOraDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781275874; c=relaxed/simple;
	bh=xtXxe3z9/83f1d9JXlONnXmtGAWAAyq34DBcdNeg+WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcKSOozRGPH51razBUUf4VJQhIkh3MggLvfjPfiFWFi01q4841acTW4dL2/CVBNNf3cRm4hG1Ifg1FzArQr6t1apWGkKcOadl21BNZkkNqF8yDKW37PURhPwCs1NT23aUFqmI45gH/MUOOnljrZQj0VgnQ7uJLbAg/MmNx5WEpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQGooGTW; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQGooGTW"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36d5b11201aso766898a91.2
        for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 07:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781275872; x=1781880672; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YeDBR9JZ0sbjdg1IEKBF44Dw6trVSJWUdQSKPXsa88o=;
        b=TQGooGTWiW/WRiqJb7c7nfuaAi2M6ePkBmak0jU5e0+4V6Sosl1Fvkitn3TZYktKo+
         ZN1bZAh6u+d3ypS9DUTJOmeY+JMjWVc0hR5zq9OQeRzrbq4BVXzcCm2qmVUDLI8lSKg8
         grB3w7bIYgdQlOHLd9ldNDKsIEoswLpv9QVV0skQF5FC8ckAsLJyqja8y8errYMfVGmX
         neKFpYgVhVswa2LNHf02KnWLekjzZQe+QjXrkRX93dVuKUGQcd1Jl50v3B8U/wuoAmYR
         IKD+LjHwu6maidYMs6HGalk+rbYKhwzLvwVPaTJ0UpksTeevAHxFoo9qxo6IezGGgOs2
         mOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781275872; x=1781880672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YeDBR9JZ0sbjdg1IEKBF44Dw6trVSJWUdQSKPXsa88o=;
        b=pY9sT2eL7xQRoE50LtCXwKbwCWktkD99vBGG0Qs5lzpUDsOf2ZyTbc2Ab6viSJqQju
         3VPpStLQC0V45+FsT8sxg2zXxVirDdEA7WUp3+tI2lEnhbuYuXgPNMR5+wOUNjkUMoPQ
         zVjIvbuOVmDmV67kkyinNmBeWBHLG9DWMCVvyNb5rHGwixfJqNzchLFEB6lvE9qyJNFz
         EpGvRfqY3lVqgOfgWgIQMQi1X+i9Qt2GeSCl1JETTemy2wshIFnbbHM2zMy3vINKSJoQ
         DtKvdmweheLoBk3RxVjluYwDLIF67vNk9uQnufB+lKzIhd2NMwTeIT+ZrLOwJhfCDwAS
         UnFQ==
X-Forwarded-Encrypted: i=1; AFNElJ+rdr1YgAIrTatfn90BccY0fI0FD34mMoUfamvRxVPq/yxqohjgd8sfXHu1peOFKVWrTK1QUqJpDdlmoj+Qng==@lists.linux.dev
X-Gm-Message-State: AOJu0YyfRPovh1k4r+DnfTL8OmfWfndIgpw8kVQAb/NA5cWaPT6Uz0b3
	MjMXI6GGFCeX6hWGuHTNudBxPoYodMpVprYvU7GU013kS3IuTqd2U5F5oEdYYPSy
X-Gm-Gg: Acq92OFevCUjVXiWFdK3DBxZIS5b0LAuzg140htf4vYPV9RU7hdA8u3jTjCvor+6H8I
	sw04H5F3LnWPedybE2/tSuUIs/1BtdYksSHOst1KpvqmIny4j/A4QRKqqsXKl8cfEtGxKb8nRsg
	t4UqMPCINvdTLDuu85SAKN0YtdzFf0iYY+Un8MhSDf1k5S7b4e5MP3d+zEkZYNghlgpvuoc1FrC
	82Uf7XmSOjA7dVLfj9e1olLaMrWm6Pnp74IBeuAK7BSfRMa5PeujTJ6JZoGHN+JZYskkb5XPGzS
	iUbgAHtaVrlO49UAlTXjUTL62qm8apXrjz2wyzmsSgP+FAtWLPmndHRo7FT7agS0GU4ZrR1shsf
	BbvLjzuzHdx0ZmSQGvC41x/q2lkrm241t+2iVFfhUUW/H83mHczj5oqGAMAWyMic90METaU3aKX
	un0P5l08nL3EhvieccWPEHAE2niNGRE9pFIsk+qFjKnMDD
X-Received: by 2002:a17:90b:3b4c:b0:366:10f1:3d86 with SMTP id 98e67ed59e1d1-37a0458dc83mr3802343a91.22.1781275871672;
        Fri, 12 Jun 2026 07:51:11 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a263a43f0sm2791084a91.15.2026.06.12.07.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 07:51:11 -0700 (PDT)
Date: Fri, 12 Jun 2026 07:51:09 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	pabeni@redhat.com, sgarzare@redhat.com, stefanha@redhat.com,
	bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, leonardi@redhat.com,
	horms@kernel.org, edumazet@google.com, kuba@kernel.org
Subject: Re: [PATCH net-next v3 2/4] vsock: fold sk_acceptq_added() into
 vsock_add_pending()
Message-ID: <aiwc3c7LWhub8SP+@devvm29614.prn0.facebook.com>
References: <20260612045216.105796-1-rafdog35@gmail.com>
 <20260612045216.105796-3-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612045216.105796-3-rafdog35@gmail.com>

On Fri, Jun 12, 2026 at 04:52:14AM +0000, Raf Dickson wrote:
> Move sk_acceptq_added() into vsock_add_pending() so callers cannot
> forget it. vmci is the only transport using the pending list and
> is updated accordingly.
> 
> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Raf Dickson <rafdog35@gmail.com>
> ---
>  net/vmw_vsock/af_vsock.c       | 1 +
>  net/vmw_vsock/vmci_transport.c | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 1f94f0d44c..6cfa89b6f3 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -483,6 +483,7 @@ void vsock_add_pending(struct sock *listener, struct sock *pending)
>  	sock_hold(pending);
>  	sock_hold(listener);
>  	list_add_tail(&vpending->pending_links, &vlistener->pending_links);
> +	sk_acceptq_added(listener);
>  }
>  EXPORT_SYMBOL_GPL(vsock_add_pending);
>  
> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
> index 635ebf9da4..c2db016cca 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
> @@ -1109,7 +1109,6 @@ static int vmci_transport_recv_listen(struct sock *sk,
>  	}
>  
>  	vsock_add_pending(sk, pending);
> -	sk_acceptq_added(sk);
>  
>  	pending->sk_state = TCP_SYN_SENT;
>  	vmci_trans(vpending)->produce_size =
> -- 
> 2.54.0
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
