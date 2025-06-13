Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FBAAD5E
	for <virtualization@lists.linux.dev>; Fri, 13 Jun 2025 02:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749780961; cv=none; b=Tn1WKYiBynKiL/uV0FAetdeIWc2eTKaHj09OT8cRWCNA1gXIzq/57UiGL5e8dcQkD2BZIlfrRjIkT3cIJvfVyVlV4XDMJR1/FI1e4JcFyyhsogxPXYB7llEnHWnQF47sBPaSZ0u9wKxIYMSTG3o7mZ62BL94vpaBRT4TbLpdZ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749780961; c=relaxed/simple;
	bh=hhA4hRWSrpkLSGj8Jisx6+n8n8ogU+EaoUZol/upAgE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=jQbuG6KcOqQi5qacnj+8Xtyv3XCCQ2IhVECOQI14mDugqBpn/VywItd+j5NGWl4kF/WcOC47+yyhz6W3zep8HqinLaM4u719lBw7nOn9IGl0VUIixyvCoWpfi/8Vy6GLl0VGPzLlksPCDSqoGvMxFikuED4dAdMpHuDmQOPDAWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbY4+yk2; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbY4+yk2"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e7db5c13088so1434258276.1
        for <virtualization@lists.linux.dev>; Thu, 12 Jun 2025 19:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749780959; x=1750385759; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4OSg9tMv2M+t3/zopdwTDlZ3XltE4WsKCLg6MjL/6Q=;
        b=CbY4+yk27wJtC/LAWnAnnYrAIH9X0EU6+a7EoQSqtAGcbiVAtjBJaZSqOxmMg3t3ho
         b+hSX/4pUn4OM+UaUS6kWyoiupSqn9ewjNxm0HSOj4817eeAziYp6M14NS9gyVDQ+oGZ
         M27Az9KVeg3j/mDmLxuY4f4JIC6/fTM4LLJRSRTB7Ait3EiNdJ7ZsnQyLdMnTzjljjTp
         azdjd9Rct8PzlFAd8aRQ3kqFYfc/lgcG2akZrYWJXrj3U7GtmMWhuWVaSte8JnJ00sNF
         ct5KhZROPHQ9cJSw2uX+/Zgc0D3EvhyszsVW91tW8csCAVkq9MkocJTrf2pizYdA3W0h
         oOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749780959; x=1750385759;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A4OSg9tMv2M+t3/zopdwTDlZ3XltE4WsKCLg6MjL/6Q=;
        b=kgZQ+PCOW4/Zs3UW2kXKeVuz1nC/+2oHXwQtwFnlTkb5JoXkmUL+QpJu6TJF/XrtFk
         buRHn3UZ0kL32nrSr+ajE9/+C5en5/djd7olj1X60dLSpbWxWLgTYybo7VBD+ouvSuPb
         wW0EEV3rvCTJVU+RlL0E1JGuyB5uON0IWB6R0cYL1q6OzDYvTKp71j+93fJ7nNmMxyU9
         NXPd2778e/W7yr3X9ScF7yBpz5pnQ3JvDWrxw8A09VQcOv0kryNOKvFf6jM6HRU5xRbw
         hENv9vLZsFyerV76FlOcWc+cAZ/vv6KuJonmNAtHP3VxeUGu9xg9zksPqu3mBKPwhjf6
         ygzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsR1GSX021EgDLDj8FHIEa+/6IY0S5ecpA1c/vTvonUv8vYRqDq+gTyOgCq0NK+LhMIKMZmIt7Eq1z5xVEEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxwq19eyassrgiXEOHRgZ8/iZkpcOfoH9hoU9HZ1nbyTkyNB7yF
	fRo1CsNeIFhzRvv7t8qwQQuB5VQbwQyIV5wxem3/PHKllpIhZ2iAnahP
X-Gm-Gg: ASbGncsYhcgtAssGNlPWPsFyC2Bhi9VrxEyQSgdIhqZykaMeDqo4NtHGGYx3+VBY3dV
	F2XSBf9quVvDCwdynvSXHXCyvta+GgxVZX9PP1iOj4vLVqDn5n126HudLgrA1TGgWOa0Q+4jhj5
	isccoD4LUKv4q8E1splo+5ObeZEpULSZnwKeoneBEt596JE9JoZ1Bie2HOMuX3++EAE5y/EcF1j
	EJmKbiVk9V2f4wSPr3mwpv5UDHLRTXWvSSvrRXAMNw/62zTBkFswIzzpOOeo9ObrN+wK+FWIFt9
	m+3pUjtSCFzVkjF7N6+BiUGBvJ4XNOT0c7OWUNvYWP2mgEB5b5qeCTXJmMLS1W5vbwZSnEwyGTV
	y5plecFJkHIsFMCXC0jUeWrhMHXEjy+JHDegLRApl8Q==
X-Google-Smtp-Source: AGHT+IFNJsQBvWYBgsCWdmxYYF6e6UN9FeyqBxn+1/yGfoGQcLpzsbu5qgjeR9PWb955JCwfENqtVQ==
X-Received: by 2002:a05:6902:250f:b0:e81:b5c8:3d71 with SMTP id 3f1490d57ef6-e821ddc2fccmr967447276.17.1749780959097;
        Thu, 12 Jun 2025 19:15:59 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e820e09d3ffsm813581276.23.2025.06.12.19.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 19:15:58 -0700 (PDT)
Date: Thu, 12 Jun 2025 22:15:58 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Wang <jasowang@redhat.com>, 
 mst@redhat.com, 
 jasowang@redhat.com
Cc: eperezma@redhat.com, 
 kvm@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 davem@davemloft.net, 
 andrew+netdev@lunn.ch, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com
Message-ID: <684b89de38e3_dcc452944e@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250612083213.2704-2-jasowang@redhat.com>
References: <20250612083213.2704-1-jasowang@redhat.com>
 <20250612083213.2704-2-jasowang@redhat.com>
Subject: Re: [PATCH net-next 2/2] vhost-net: reduce one userspace copy when
 building XDP buff
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Wang wrote:
> We used to do twice copy_from_iter() to copy virtio-net and packet
> separately. This introduce overheads for userspace access hardening as
> well as SMAP (for x86 it's stac/clac). So this patch tries to use one
> copy_from_iter() to copy them once and move the virtio-net header
> afterwards to reduce overheads.
> 
> Testpmd + vhost_net shows 10% improvement from 5.45Mpps to 6.0Mpps.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Willem de Bruijn <willemb@google.com>

> ---
>  drivers/vhost/net.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 777eb6193985..2845e0a473ea 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -690,13 +690,13 @@ static int vhost_net_build_xdp(struct vhost_net_virtqueue *nvq,
>  	if (unlikely(!buf))
>  		return -ENOMEM;
>  
> -	copied = copy_from_iter(buf, sock_hlen, from);
> -	if (copied != sock_hlen) {
> +	copied = copy_from_iter(buf + pad - sock_hlen, len, from);
> +	if (copied != len) {
>  		ret = -EFAULT;
>  		goto err;
>  	}
>  
> -	gso = buf;
> +	gso = buf + pad - sock_hlen;
>  
>  	if (!sock_hlen)
>  		memset(buf, 0, pad);
> @@ -715,12 +715,7 @@ static int vhost_net_build_xdp(struct vhost_net_virtqueue *nvq,
>  		}
>  	}
>  
> -	len -= sock_hlen;
> -	copied = copy_from_iter(buf + pad, len, from);
> -	if (copied != len) {
> -		ret = -EFAULT;
> -		goto err;
> -	}
> +	memcpy(buf, buf + pad - sock_hlen, sock_hlen);

It's not trivial to see that the dst and src do not overlap, and does
does not need memmove.

Minimal pad that I can find is 32B and and maximal sock_hlen is 12B.

So this is safe. But not obviously so. Unfortunately, these offsets
are not all known at compile time, so a BUILD_BUG_ON is not possible.

>  	xdp_init_buff(xdp, buflen, NULL);
>  	xdp_prepare_buff(xdp, buf, pad, len, true);
> -- 
> 2.34.1
> 


