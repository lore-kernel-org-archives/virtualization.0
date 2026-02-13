Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47E346B5
	for <virtualization@lists.linux.dev>; Fri, 13 Feb 2026 01:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770945254; cv=none; b=niNQAq8JHZSPWF11+VL6IaOluRNeChK4D+9NmH4jHWaF7EJDMC7V866oWJh8f1Z6JGyt3Z5UmfnWkh1AKGqbHCPlXYkgZa9r1qqQPjssRNNdU2BMK6vSZAXz/p4NqT70wKEzjVnLkpI78rCLOb8m9pp4YzZbal1KnAjv0cv87S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770945254; c=relaxed/simple;
	bh=md7cp6wH2+N6MD3mWQSj0qSboD+7rUfa+MjyvhsGzmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmhOwQhPl6SvziL2wh+jvzok+s1k/h0VQ6v9TgSElImz9iLXUXSACxtH/yfvoC5TpijrSlEUuv4GRwlxgHOVZ/QtXAn3amECw+9fokFFWMEf0MDWkTWcTonEdVB0O5vCP/AMsb5z21ENQszEEZfMYmuaCq68iX007rSxNiU+8Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZCnpFEZz; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCnpFEZz"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79495b1aaa7so5074097b3.1
        for <virtualization@lists.linux.dev>; Thu, 12 Feb 2026 17:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770945253; x=1771550053; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pVvyXAJYhGKiBzDbhgb+tCE1hBe6OOdBiT7l2EEI8Wc=;
        b=ZCnpFEZzY2l8hWq8si5HcwwdGTosMyhzbSfY38cEkITNhVCvZBztqxuAXRAUmC7OfQ
         VRYN4435JqOtbUsxXfJ6qIw8TifBHto4VPyEcyUGc0DBcG0ko6OdR1/mohXYeMQmVm9I
         elSycnMWCHX+KPy1vfSm0a7+Z4ilboAVy0wfep5/vWHrEemcCH0zNlDGNs100H/wuj62
         bhac59iTPC7AMBMIOB/yPkkPFsIxZlsDuBkNnPprX4ii9mmtMc7Z2KOOraogZHz8JC9v
         KJflb9QbMrklkbvjRfaAv3myEolef6TgZG1/gOsoSnCHdGSzu33CfQrU18pfBkZfKM8g
         3X1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770945253; x=1771550053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pVvyXAJYhGKiBzDbhgb+tCE1hBe6OOdBiT7l2EEI8Wc=;
        b=vlq+Lb8k6fFMmlD4VDmWcART92q3QUq8EikTGzhTWAjuQLhCNWPCq9LP20C4AF3T0V
         yX6hdSrpCaBUS0nOtP/22FFRfI00tDHtSSTYIOFBJXDYwswRJjwF0gHxU8beag86mttI
         5dFH3IBDJY4F0yqb2mJ6qo6WGGEbRQKO+enbSpyCsgVFPgUUlkkq/v4Y+Qh4vQcx9NbO
         QUCZULwnlU9GX24r38QAQSm9vRJ5y2p8XrJJQZpKmI09tpnWC0ligIm8aH/XoK9fccvG
         yx5EmXHxWGIlaFA3rGeGkDD3OW0e1aQCYKZ0NOAG81+qY177CzA4hE3GpJFZ0UOyxbSW
         92LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwexRx3Cx68QXdxgx1Zx2+0YNSLnttfNolPl17R43wNJ1hCXwhKilJt3ejmC/pe0oPdKvdrl8RlnZ8vV9gUQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxi8o+w7taRUMgNs8WzRU8ZpC7S1m0CqjRrGm0AZGQjGDUCpBXl
	cLDLWqmqX0Y4/MpQQB/nfLgeXOrI9Fcimdqrn949f012DmnNxXyA63lX
X-Gm-Gg: AZuq6aLct2ol4elUDekilpFHnI6nnx9haRhT9qN08MrmNBAX0tfTv6aDDyuWqQRDtEh
	Mxpygks72R6hiZwX+KPvKef5FZvP+AaEFiF66AUwHtqcas6ABtSFOb8K4Jxl0ETfdiF1lStNSkh
	GKsgSyyKmdy7rlXQM72A7pIBtqktOwe4BTor6ydT0ugNHn5Q+NFKxhmrjHK7iGVEJPMe315T5sy
	r7HwJgwby3NrHdqCMunhhRhBF8NViCusB+KtM+NKvFb4WrZnkOfe+jN/BLMcEy/UvYUmrcT8oU3
	JwePdGOis4oq91LMyIgHiYHDc6ICyKJfp8VhXtFaDpi925FtYECSFK6aKedgvK3DX3SiuGxOLAN
	ijvenitpgAlnon+HlL673lSIPvvnwZRzqFMgthwDRf3jOs3mSi7qeJ8agqUvK9jKqyMwt35Quvs
	Qx0+FerUg57j74cH/MaREYQyZYwpDhdfNPx/IgtrE1Knos66/3l/B8ffVBhQ==
X-Received: by 2002:a05:690c:e3eb:b0:796:2fde:5dee with SMTP id 00721157ae682-7979e899542mr7425397b3.34.1770945252544;
        Thu, 12 Feb 2026 17:14:12 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:4a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c18b3desm56788687b3.14.2026.02.12.17.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 17:14:12 -0800 (PST)
Date: Thu, 12 Feb 2026 17:14:10 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net 1/2] vsock: fix child netns mode initialization
Message-ID: <aY564m7pM4pSj+/w@devvm11784.nha0.facebook.com>
References: <20260212205916.97533-1-sgarzare@redhat.com>
 <20260212205916.97533-2-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212205916.97533-2-sgarzare@redhat.com>

On Thu, Feb 12, 2026 at 09:59:15PM +0100, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> When a new network namespace is created, vsock_net_init() correctly
> initializes the namespace's mode by reading the parent's `child_ns_mode`
> via vsock_net_child_mode(). However, the `child_ns_mode` of the new
> namespace was always hardcoded to VSOCK_NET_MODE_GLOBAL, regardless of
> its own mode.
> 
> This means that if a parent namespace has `child_ns_mode` set to "local",
> the child namespace correctly gets mode "local", but its `child_ns_mode`
> is reset to "global". As a result, further nested namespaces will
> incorrectly get mode "global" instead of inheriting "local", breaking
> the expected propagation of the mode through nested namespaces.
> 
> Fix this by initializing `child_ns_mode` to the namespace's own mode,
> so the setting propagates correctly through all levels of nesting.
> 
> Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
> Cc: bobbyeshleman@meta.com
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/af_vsock.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 20ad2b2dc17b..3b629b4a0359 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -91,7 +91,8 @@
>   *   - /proc/sys/net/vsock/ns_mode (read-only) reports the current namespace's
>   *     mode, which is set at namespace creation and immutable thereafter.
>   *   - /proc/sys/net/vsock/child_ns_mode (writable) controls what mode future
> - *     child namespaces will inherit when created. The default is "global".
> + *     child namespaces will inherit when created. The initial value matches
> + *     the namespace's own ns_mode.
>   *
>   *   Changing child_ns_mode only affects newly created namespaces, not the
>   *   current namespace or existing children. At namespace creation, ns_mode
> @@ -2912,7 +2913,7 @@ static void vsock_net_init(struct net *net)
>  	else
>  		net->vsock.mode = vsock_net_child_mode(current->nsproxy->net_ns);
>  
> -	net->vsock.child_ns_mode = VSOCK_NET_MODE_GLOBAL;
> +	net->vsock.child_ns_mode = net->vsock.mode;
>  }
>  
>  static __net_init int vsock_sysctl_init_net(struct net *net)
> -- 
> 2.53.0
> 

LGTM.

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
