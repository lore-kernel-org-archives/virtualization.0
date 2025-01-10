Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F92D219A9A
	for <virtualization@lists.linux.dev>; Fri, 10 Jan 2025 22:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736549536; cv=none; b=beobezKbF3BR3+JhX0n7Ck/Z9vaUzEKs0hkVdwikCpKvqp93z4yLG3yOC2/dQjY9E1dA+lcviTD1OpguQnI9Y4oBBagMJF63aMaUmKxXe0eKYu5xTj83ot75CA286nIMDmiJ0W40OeWV82ScPOlgz+2H9H5KwuIDOfMQ8152HBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736549536; c=relaxed/simple;
	bh=JZHqlk+65oHwniuof9YMax5W0VcsEzP6KM6gcWIovm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQnP3/ZdB2KtR4gTHfr5d+gI6cE75bHfXYx6m2d3+vkDhtT3TLGx9WX6aXGjxLiBvToPKUxtbm1ITu5+7weCLipW6lZiniqMT26py6rYvD+CZ4UGQsk3Uj4abp0WfQx5fL7wD9lOyIdtZQXt31yo92+MhFE6qSL0LVqAoI780Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io; spf=pass smtp.mailfrom=theori.io; dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b=elZJ8BLM; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theori.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="elZJ8BLM"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2156e078563so38166995ad.2
        for <virtualization@lists.linux.dev>; Fri, 10 Jan 2025 14:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1736549534; x=1737154334; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vbi6CHxANPrMQarVV/c3DpvaHRVNCAuF1gxqd1Fssgk=;
        b=elZJ8BLMaHsmjmmLhM+tkaicC1pxdiI8LgAJRk8Qbu891YUpULi0Kk6OS4No7ExWYr
         u7GwLlHwo49eh4gA8qOmNfHfvEc8aRpfikC+Wdpf7K+QHrRT7Dfvx43wNj7lU3Qlogo2
         YmeQkyAm6lGVKQnOB7Cb6mQ50lqlx0uCrlyr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736549534; x=1737154334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vbi6CHxANPrMQarVV/c3DpvaHRVNCAuF1gxqd1Fssgk=;
        b=QUWTtrc39uHAMfWgegD8D9ZYwMIf2setVK9WhfC9RbAXo897pEs2JkNjkD0oOioJyf
         YQLnBTq7l0NgJKSzI29C8UKL9e6bLPI3hNjTS6T8O3s3dzLLusJIWuXly2ECb7nKBODq
         ONA/cs7O0ZdmhaaWWU3PEEHPPl1qwK+LqOG49ApZSMD3AioOiPRXstqz7aYnp0Sqxi3t
         2ukKoUVVRQPU8sb+60btz2aHIVwX2XuMM3VP+AniZaS84sOy1zpk535Vy6MFoT0CE6YA
         kf10+/ZC85U/HYihYgfHEqUf2slAl6duudmWLnLE/nX18XvljKnZKm0v1V1XzQg9k/IC
         Knag==
X-Forwarded-Encrypted: i=1; AJvYcCXfSsrOyi22y2LDTpaZauriF8+r+ba0DFqMNDwJfz+SMl/gUgnNRI2S1+D5w1ljC6hjW8Ruo6DRqyqkQ4PBoA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyGoUvnFMBCmI6Bl7zIFOS6UeYnmwZSULVGGVpS4csJO+yD1kZz
	R2pm8Df5tQdnkQx30DCm1p2PXt0jCLVjJC0NzgPFxrRGCT2EFzKpd0Jr86ljRrw=
X-Gm-Gg: ASbGncsuhmXc8PAITeMJMDEOmDiN9DF+F7uW+oONi0NMYmlLm//dl9/C3/2K/WjlgvT
	J+HqbLpEjavjFfxp4tZQGCvMVuecOL2qZqIe27uCNCiCuw77E5pFKpWL2vAIY4VLOdZbuUx4JOd
	2miUvjeqjIVS882mXSdVAlr/a3ENSfze4XGK1qMF/lI9jBFkeVBjabo1b9dbbfUChA07D+hStsm
	XG7agxjfQMvo484CMwKpgamh7u9v3/yP3avWXIVjKWkYJhiHGYIeqcRNRdnZbogj53y7w==
X-Google-Smtp-Source: AGHT+IENF/FxDNTliDs2DD6iZam46B2U64YorZ5+dfuiE11gQj49C7rnn2z29pL0pKaqTcMm+AS1GA==
X-Received: by 2002:a17:902:e84c:b0:215:4757:9ef3 with SMTP id d9443c01a7336-21a83f338b0mr168094885ad.9.1736549533645;
        Fri, 10 Jan 2025 14:52:13 -0800 (PST)
Received: from v4bel-B760M-AORUS-ELITE-AX ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10f4f3sm17847985ad.31.2025.01.10.14.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 14:52:13 -0800 (PST)
Date: Fri, 10 Jan 2025 17:52:06 -0500
From: Hyunwoo Kim <v4bel@theori.io>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luigi Leonardi <leonardi@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Wongi Lee <qwerty@theori.io>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eric Dumazet <edumazet@google.com>, kvm@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Michal Luczaj <mhal@rbox.co>,
	virtualization@lists.linux.dev,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	stable@vger.kernel.org, imv4bel@gmail.com, v4bel@theori.io
Subject: Re: [PATCH net v2 5/5] vsock: prevent null-ptr-deref in
 vsock_*[has_data|has_space]
Message-ID: <Z4GklsPT0bP8cLac@v4bel-B760M-AORUS-ELITE-AX>
References: <20250110083511.30419-1-sgarzare@redhat.com>
 <20250110083511.30419-6-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110083511.30419-6-sgarzare@redhat.com>

On Fri, Jan 10, 2025 at 09:35:11AM +0100, Stefano Garzarella wrote:
> Recent reports have shown how we sometimes call vsock_*_has_data()
> when a vsock socket has been de-assigned from a transport (see attached
> links), but we shouldn't.
> 
> Previous commits should have solved the real problems, but we may have
> more in the future, so to avoid null-ptr-deref, we can return 0
> (no space, no data available) but with a warning.
> 
> This way the code should continue to run in a nearly consistent state
> and have a warning that allows us to debug future problems.
> 
> Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/netdev/Z2K%2FI4nlHdfMRTZC@v4bel-B760M-AORUS-ELITE-AX/
> Link: https://lore.kernel.org/netdev/5ca20d4c-1017-49c2-9516-f6f75fd331e9@rbox.co/
> Link: https://lore.kernel.org/netdev/677f84a8.050a0220.25a300.01b3.GAE@google.com/
> Co-developed-by: Hyunwoo Kim <v4bel@theori.io>
> Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
> Co-developed-by: Wongi Lee <qwerty@theori.io>
> Signed-off-by: Wongi Lee <qwerty@theori.io>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/af_vsock.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 74d35a871644..fa9d1b49599b 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -879,6 +879,9 @@ EXPORT_SYMBOL_GPL(vsock_create_connected);
>  
>  s64 vsock_stream_has_data(struct vsock_sock *vsk)
>  {
> +	if (WARN_ON(!vsk->transport))
> +		return 0;
> +
>  	return vsk->transport->stream_has_data(vsk);
>  }
>  EXPORT_SYMBOL_GPL(vsock_stream_has_data);
> @@ -887,6 +890,9 @@ s64 vsock_connectible_has_data(struct vsock_sock *vsk)
>  {
>  	struct sock *sk = sk_vsock(vsk);
>  
> +	if (WARN_ON(!vsk->transport))
> +		return 0;
> +
>  	if (sk->sk_type == SOCK_SEQPACKET)
>  		return vsk->transport->seqpacket_has_data(vsk);
>  	else
> @@ -896,6 +902,9 @@ EXPORT_SYMBOL_GPL(vsock_connectible_has_data);
>  
>  s64 vsock_stream_has_space(struct vsock_sock *vsk)
>  {
> +	if (WARN_ON(!vsk->transport))
> +		return 0;
> +
>  	return vsk->transport->stream_has_space(vsk);
>  }
>  EXPORT_SYMBOL_GPL(vsock_stream_has_space);
> -- 
> 2.47.1
> 

Reviewed-by: Hyunwoo Kim <v4bel@theori.io>


Regards,
Hyunwoo Kim
