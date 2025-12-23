Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725922DC357
	for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 10:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766485604; cv=none; b=iF0jRwufvoL+4/inE8lEaLk7ADcdHfNfrZdg/fEdpkG3Ns9ZJBVVHJ2N3/wBTdAgTWI2gkwgoMYpu87yLdJ5LwEsGoBItW1L455GWqqV0uYK/G/0r+EVZ/fEV7ZPG1rDjU9fgkOzo6+a9HF7b52PhL6cLJYeaeex8+gVaLw4BNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766485604; c=relaxed/simple;
	bh=sNEqRtQD4cC/+OMMSzcvqkxq3t+X4HG/LceG/m0g/kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=BT2jEg1Cw4AKQqA6iu1YKPgQruLM498dG1z0A1Fm0nDNOVU0SBeX6z+eT0krLbYHAbZ0uliKbXHn+kiqUoILMNUoUBEc8rt65Agcb2JelVrWIYIzm/d/TB1evEiWWe2mDDF3B9cBD9ndBlj4WZ1rnpYtXcCNKvw+cOOHv8iAaLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LC094IuK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LC094IuK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766485601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Xk52MTUM6mXrnsoh/1vCK6e+/qWXck10bUHZ/gzoQs=;
	b=LC094IuKYvSX/y2SvHgkJpcZu0sSGS1xwCVZABzK4wUNdEShgrR+slBAxK5xNYJeVv8m4p
	sO4WGxIBq4Gmof78Hd62xKB0OFGAGnOWOmgEIrDBNW5b+lTqTaeRInCqfzB5ezInFe5Y4D
	bfG0+XilPdB8HQaNK8DaTmCj+N9opss=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-bmHcgMMGPUaKw5jpQ8tzXg-1; Tue, 23 Dec 2025 05:26:39 -0500
X-MC-Unique: bmHcgMMGPUaKw5jpQ8tzXg-1
X-Mimecast-MFC-AGG-ID: bmHcgMMGPUaKw5jpQ8tzXg_1766485598
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477771366cbso31812305e9.0
        for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 02:26:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766485598; x=1767090398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Xk52MTUM6mXrnsoh/1vCK6e+/qWXck10bUHZ/gzoQs=;
        b=YMw+odKonGkf/b45g8Hvrgz1i4mLCmAkRWYizOwXiWVQ1xSkDS4QLUpelnw5WJ8xFZ
         gION97YzRx4jz4DXmUH4NbxGpxRDXmp1Bge8BartBdwg33ujUico1WfZWpgrXBl4dAI9
         u17KDSUfufu34uzgW0IPC+PcIMnIjj/9lgp+/Q59FtX7Cvzx8uehAT8UOjAUih98Qp8i
         V1ZTgnMbTsQXrC/hj4C79oinz2PMuHOTjAMFzWStHpnJxP9WcwEdKv4pEbYxqTFQmuzY
         oR4jVty206AN1HJFsraBrFXqpCt3w/yc9voydaVIy7bVtgM6MBnCkoIdBK6fX/wmXyRZ
         9ApQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxLppEM93HseGVH+t0cU9iCrFiEegvCSXEgO37ZZb+MFwAjUs6n/JMJpC2bPcl4mplSTnzsfMYYplxGaphvg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTFUc9hrJE/wafBqh+mX28DuCMCM1i3EL+ujm0hhTQleLS9R9s
	G0pO3zJ3qV2mIQsOjq/OMsSMnrYuSu8ujCGDk6C5TGG2AC3a28oktQGfTVeAZf/Y2OWgamnQ8yQ
	gG1jgFONqIXmyJ9NF7QrJW0GhlGPK7GBf5TdgLCNYCoPiWSwcm0YkQu9uf5BG8XXxOL1i
X-Gm-Gg: AY/fxX58gssGFiLlg5VU0OQ5mxD+tChJFdrNlKlq9lN/kSeAmkGcFUIy4uyOh4CAoJV
	3m8L8LHR0Jw9DnBWCcYXxjckSoPj243aHxToRbmgANEXuvEVj4LGx78DF+0kWq+qtEODlMLfHG/
	Okg1FbYynvv1RcB0rFWk4UWFNX39xEKKw2HkCmaWcLnjR7vYACQ3XcbaYubY7Yrbv95FWVXA4Id
	O4sypvF77Eo7ALkK14iJIxyUgoPkkR+vZRZ5Uvo15e6dRwxg7dMBnqojPWyv0PcK8FIHM0teQu2
	JQNvYREgLvK27F+SU8s4PpHdqGFw+c0yEaID5iEftR0xYEruZOxenMqexu1ZKLQxDl2ph/kuTtV
	GZm0Ctrd/nJBCohnqxpWjIQKjs0083Kz2WtlPcfnxRyKcDfY1pF8i
X-Received: by 2002:a05:600c:1c21:b0:47b:e2a9:2bd9 with SMTP id 5b1f17b1804b1-47d19583142mr164372395e9.31.1766485598482;
        Tue, 23 Dec 2025 02:26:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbUtwawXu/vlfSTAPP1ZyM81dCauGdjKgGdznuMdm2wRU0UBQ0kTjpv1BCy/z2B8qhN87GiA==
X-Received: by 2002:a05:600c:1c21:b0:47b:e2a9:2bd9 with SMTP id 5b1f17b1804b1-47d19583142mr164372085e9.31.1766485598067;
        Tue, 23 Dec 2025 02:26:38 -0800 (PST)
Received: from sgarzare-redhat (18.red-88-19-32.staticip.rima-tde.net. [88.19.32.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d19346d33sm240268595e9.3.2025.12.23.02.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 02:26:37 -0800 (PST)
Date: Tue, 23 Dec 2025 11:26:31 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] vsock: Make accept()ed sockets use custom
 setsockopt()
Message-ID: <aUptJ2ECAPbLEZNp@sgarzare-redhat>
References: <20251223-vsock-child-sock-custom-sockopt-v1-0-4654a75d0f58@rbox.co>
 <20251223-vsock-child-sock-custom-sockopt-v1-1-4654a75d0f58@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251223-vsock-child-sock-custom-sockopt-v1-1-4654a75d0f58@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: N7NFEAZU6zYxMV39Cg1-68jOa3MBkpzA59fhmvJEk6Y_1766485598
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Dec 23, 2025 at 10:15:28AM +0100, Michal Luczaj wrote:
>SO_ZEROCOPY handling in vsock_connectible_setsockopt() does not get called
>on accept()ed sockets due to a missing flag. Flip it.
>
>Fixes: e0718bd82e27 ("vsock: enable setting SO_ZEROCOPY")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/af_vsock.c | 1 +
> 1 file changed, 1 insertion(+)

Thanks for the fix!

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index adcba1b7bf74..c093db8fec2d 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1787,6 +1787,7 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
> 		} else {
> 			newsock->state = SS_CONNECTED;
> 			sock_graft(connected, newsock);
>+			set_bit(SOCK_CUSTOM_SOCKOPT, &newsock->flags);

I was a bit confused about next lines calling set_bit on 
`connected->sk_socket->flags`, but after `sock_graft(connected, 
newsock)` they are equivalent.

So, maybe I would move the new line before the sock_graft() call or use 
`connected->sk_socket->flags` if you want to keep it after it.

WDYT?

BTW the fix LGTM.
Thanks,
Stefano

> 			if (vsock_msgzerocopy_allow(vconnected->transport))
> 				set_bit(SOCK_SUPPORT_ZC,
> 					&connected->sk_socket->flags);
>
>-- 
>2.52.0
>

