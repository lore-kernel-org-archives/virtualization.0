Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB97D24DCF6
	for <virtualization@lists.linux.dev>; Thu, 11 Dec 2025 08:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765442298; cv=none; b=awHmGy/sL1O5C4gDazkO/H3at9zk6FjJ/dlAicoKzlRi5kA6s+/MIKJR0swiQbkJyRLsGtmvA2XCZGRG+ExMoWNFKFmOkkr9IvMNivFZd8qgby7frGNfE0MreVtV4+qktVQpLLCk4jVr3IFTtWsYIkCdIxWpEs/efaxQYzs7xDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765442298; c=relaxed/simple;
	bh=rqOciKOGlRMnIs2IsSG8/n7lvAuH5dsUqS/rCEgD3Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ps7ThCBK1DAutXGGCJzRB85j/DNUCGYO5gf/xAtyc4MZWEDFm70zKawrphQTuWMy3e+qgniVazNibhXiWdPiAp+RTPUPvHUELYVQpyM8l4FpODrMqhKZJv9REFWvPsN9LvikjsJMkmL+/3F9mC2Wgc6LsR49GcAbRoHizuEFv80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u/XsNz/j; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u/XsNz/j"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477bf34f5f5so5728915e9.0
        for <virtualization@lists.linux.dev>; Thu, 11 Dec 2025 00:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765442295; x=1766047095; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Sg8nQv6XwVOonN2RpR1c8Sf1QdNCd4fo1IwTQexW1A=;
        b=u/XsNz/jrZVcpZEOkrkeyOYPaN5dezKcHW6AfcgHIBYuEUTv/4hXaVtcd0FOko2KEA
         Mn49OdhreEYe4e6xLWb4tsJIZIVU9c1CVWJwv066skYTh6MBLEsEO+gxuTw27jR4WzYX
         IUWpfPxqr5CT8TCr9aQnlWB/PQcY/jYoBYEbDdFCI/rbXaLb4aFbndApo0xyULHXii2h
         7HSdrn1WZSU2FHWQYm8DE5giyfLzoxq/dOM/Piepv7aj4QUZ/uREGduzVXVUSWbug1oJ
         20ddJps/+WHFWcK3GTL2DG7+L6kG6NV0656dKW0iMTT9gEEIEQqkXXi29rpWUwhBLWB/
         eRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765442295; x=1766047095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Sg8nQv6XwVOonN2RpR1c8Sf1QdNCd4fo1IwTQexW1A=;
        b=BMbUFCk1UOlui1jacyW2IJY/sD+wzr1rxAYH7ar0J6JAFv5iSwAcLpyk4TEN5Sawn2
         o0gPa9pxMbe4WEB/uaPqw2kvF4Z0Ma0uqtjFLx6zC4m0WKFp62jB9Fd3P0TP4v/x8z7b
         X98bZcw2z8hO3SbTn9z5zM2e79cBtdEWPmSq04EHfY9xJ3ABoMi/cAG1oSuRrDWAC+FB
         n1Io2hvBB8nSzy1mzSsF1lIE9e/6LUAoMXosScaIxmE/MY9nCBo/pbhrLhz2bboylZPf
         /TZyVVurzpldwIF0WcUyU3YKZoKaL1DHPGTLrIANdcxr/Chv/FctTphMmihwVg9endVe
         1SpA==
X-Forwarded-Encrypted: i=1; AJvYcCUyGrzrYDJMz645BWAcPR1IgnsB1KZphqX/Phh9nkcCkQ2406XBjwypcGgG29lyUAU/lL1u+2L7q7eUYCunag==@lists.linux.dev
X-Gm-Message-State: AOJu0YzJNj1rvhGgrmhTquurp1Fq/ep9ke8oAi0ZrqX5nJx/TukF0/pM
	nS4iMm5GIDJCeERGvgFZ5gHLNBVYM08Ymjm/vX7Hy1+Z3vFBNyozh1jlXyJwpxdOU3T8Ms7zm63
	pEcyy
X-Gm-Gg: AY/fxX6nGp7y/dJyIBhhHepClTlVEZi3hqRXlXRsmVyAPNaJvEM3lBhuXHCAeNOP3yw
	YwpeyhpkJpwLNtNMzVlE++ohh2iK8lxJawR/EtzD0TnUrE5MBPXvNiys2srAHWn20aiO8tJcBtA
	lucSY8g8bFi8SBhOpmi0JhfRXmXfck5D5OfAN3cwP6DYN/pqV+fAO5cWPFbUNgBxrBSQzBLDxVg
	YbZUMsm/gcPWBvInbOBtz9bVsH4ZRmUJWAYCZKIrz6DXnqdJrL0V7I3gfxTfnnMZ9SirychMIPy
	/RhRybhCBNAgeWu1YnGfJkeU+M9gZF6S7q9zLrOlZCnJZiXIVvVQ/kAkDQJFeu4zJOBZWytoEIX
	Vy5DcpqbtRNrQr3uE6r2TRmajb+yvllgyC7STh9nPir7RKlBp4Qdr4T4WLicHD4nXxkBB0DBcng
	qNGXeK8HrtRN3uZq2X
X-Google-Smtp-Source: AGHT+IGSsWe5a0d99Xs6fnmOMLI4LBdo2k+QjtiypzD0IVANglEDUotcgPQFMk6WXuHYX1bSUfn69A==
X-Received: by 2002:a05:600c:c165:b0:477:6e02:54a5 with SMTP id 5b1f17b1804b1-47a8378cdf5mr49788055e9.18.1765442295248;
        Thu, 11 Dec 2025 00:38:15 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a89f74284sm22968035e9.9.2025.12.11.00.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 00:38:14 -0800 (PST)
Date: Thu, 11 Dec 2025 11:38:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] vsock/virtio: Fix error code in
 virtio_transport_recv_listen()
Message-ID: <aTqC8rhgHmxC5fAQ@stanley.mountain>
References: <aTp2q-K4xNwiDQSW@stanley.mountain>
 <xz4ukol5bvxmk2ctrjtvpyncipntjlf4bdr7kjdam2ig5gf7ho@vuuwwu7asj7i>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xz4ukol5bvxmk2ctrjtvpyncipntjlf4bdr7kjdam2ig5gf7ho@vuuwwu7asj7i>

On Thu, Dec 11, 2025 at 09:30:06AM +0100, Stefano Garzarella wrote:
> On Thu, Dec 11, 2025 at 10:45:47AM +0300, Dan Carpenter wrote:
> > Return a negative error code if the transport doesn't match.  Don't
> > return success.
> > 
> > Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> > From static analysis.  Not tested.
> > 
> > net/vmw_vsock/virtio_transport_common.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > index dcc8a1d5851e..77fbc6c541bf 100644
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
> > @@ -1550,7 +1550,7 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
> > 		release_sock(child);
> > 		virtio_transport_reset_no_sock(t, skb);
> > 		sock_put(child);
> > -		return ret;
> > +		return ret ?: -EINVAL;
> 
> Thanks for this fix. I think we have a similar issue also in
> net/vmw_vsock/vmci_transport.c introduced by the same commit.
> In net/vmw_vsock/hyperv_transport.c we have a similar pattern, but the
> calling function return void, so no issue there.
> 
> Do you mind to fix also that one?

Sure.  I will resend a v2.

The check doesn't catch that one because the != comparison is
hidden inside the vmci_check_transport() call.  So I would have missed
it.  Thanks for catching it.

regards,
dan carpenter


