Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FECC1F8BD6
	for <virtualization@lists.linux.dev>; Wed, 25 Jun 2025 08:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750841213; cv=none; b=sd3IdflMtJ9HD4B4caE8ceQHRX91V3jjNPJSy7x4Zp+HNBlXvxSPNAA49o1Pqqa0RBBeYmu67Mfq8NgB8dmesbMQ+bVP7UynLsdUqN/flnNv8W7h9yr9Wt0SsIZ1aWq/BYpzhK6ySpfs//3BLLcllHaDGNmwtoYIiU77QqqzW7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750841213; c=relaxed/simple;
	bh=T892iFCO06qpRgPeQchYWUIxyB8KQBY18W5Fu61V8v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DQiJ7ZMsK8zMb04OvB3xfSb+jFmqveRCrVnBNl/t1dYKfaBsxSTp2S99TrvM0jITgeSQl07rln5eqml8Brw5tWxTL9iXF6uGDHYxNlVi0GJuftgAJHXOjLQJlIR8CP1eS2Zbb112nAxXV8W8AdnEcoGxYxEWRCH/kg1HNkHyk+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hvKCKmJ2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hvKCKmJ2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750841211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D+42UAAF2j4BWLSQ4E8Q8fXFCTjQBZojHeATS4CdgFc=;
	b=hvKCKmJ2XqtjDku0KkeBJWH8wewm21z1PuvSk3pWtZV7Rhd4WB1GQ1AVeWzYuYYQIAAzzY
	8mC9w8fieDywWKiMEug9FHTCJfjRB0juqpahKZxZJ/1rkDLcKPaSU7btVkmU6b0XwLSoA2
	B2XGBMBTo9TODRRsd9CiPHmCgXLPN+c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-0qNjEJVZPqOFEV3w-GXNCw-1; Wed, 25 Jun 2025 04:46:49 -0400
X-MC-Unique: 0qNjEJVZPqOFEV3w-GXNCw-1
X-Mimecast-MFC-AGG-ID: 0qNjEJVZPqOFEV3w-GXNCw_1750841208
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451d2037f1eso38571545e9.0
        for <virtualization@lists.linux.dev>; Wed, 25 Jun 2025 01:46:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750841207; x=1751446007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+42UAAF2j4BWLSQ4E8Q8fXFCTjQBZojHeATS4CdgFc=;
        b=bFmOw+3aUuis1Zkz5V624aElssc7ettsDjZx1hUKkq8GylFj0vC+P/ccoh4BBfKhnd
         BEf4Jy+WGiSQkbXiVMdy4IXhgVnYKbRpTLv5HYW9Lq5r2RT1S20Jl+cM9K2/165FkiCG
         UqmcBOwdcEOQZBafH2LBHP9EHhNEYIH6gCYpqOIvEI3JivxGwL7wPUjPv4rNbDCE6hBf
         zaatUDs8VtvOi/HcV5Wwiky+gA38bdSB0j4bEvRLsK77PtbIzts72FeWgLXRtfvy3UVy
         4Xl94vOpeUVDmYhWa0fU22kSRE6PZnqWl1Jd/G0efAgy+ygUMaKkU1qbbhtVNiD6LpG9
         PrYg==
X-Forwarded-Encrypted: i=1; AJvYcCXj3EKOHq0gp25wn4v2Y95nK0e3MuHB57fSRy23K9thmrEB5Cn3/GAlHRffYSMazSC8GLF+KzPPGK6pPHDrVw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6kB0VpbshOipasRhBolAkD9swbDfwe15ZAd9JIRKPEA62BTgF
	sTqKacML74+ZTHEZWrwOTmheju2yfXi+KCY4WCqGWpWiicN4cN+2EzMzOqUTRBvMlprK3nQ7ZuC
	UIDY0/6N2/58wNZuYN+W2T0i6QIybmhS4V9W/7YqIR74a7NKq+T/QWGFBAnOX7P4e5SUQ
X-Gm-Gg: ASbGncsfoEjlpbqV2iW6fuHckRChMYF/sed9lOgG1I5/5EV0hqutonKy5g9UG0+NGNR
	67wXgD795rP37qTOJJOZ4moImtspu2f0RZbOwNxsJAmRav3LEznERgMmg6gmI75bDKPbcnKSAKS
	8lEC9Z3uaWD5ssIjPm9qqsZtbkZhZu+Lz5Dy7RQHg7xaZGcRYhT/m/XXgyacBL08jNXQZXEdKJW
	r3M43z4E98t9Nc6Wg2OFfVO6ekt9ouxsqtj2qOdlA1QbJ+isiV5+m06ppp22aZwFDk/zqS46Nky
	up2MClrHT7+34h2xJdlrEU0nnDDh
X-Received: by 2002:a05:600c:1d16:b0:453:8042:ba47 with SMTP id 5b1f17b1804b1-45381b0aa8bmr17319065e9.19.1750841207379;
        Wed, 25 Jun 2025 01:46:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdo3ANalwvdp1sAiXAQf4VC8mWRTnkMA0mUZ6qwOVf3rBLgRagdbcE6BtWV/oNmQJNx6Z7AQ==
X-Received: by 2002:a05:600c:1d16:b0:453:8042:ba47 with SMTP id 5b1f17b1804b1-45381b0aa8bmr17318795e9.19.1750841206778;
        Wed, 25 Jun 2025 01:46:46 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.151.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e811450bsm4062352f8f.97.2025.06.25.01.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 01:46:46 -0700 (PDT)
Date: Wed, 25 Jun 2025 10:46:41 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net v2 2/3] vsock: Fix transport_* TOCTOU
Message-ID: <lv6nvdc4lrwhipk6ehtivbnsn7ggb7bujky3z6ybhxorlmisgn@qyuo3egnbdu3>
References: <20250620-vsock-transports-toctou-v2-0-02ebd20b1d03@rbox.co>
 <20250620-vsock-transports-toctou-v2-2-02ebd20b1d03@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250620-vsock-transports-toctou-v2-2-02ebd20b1d03@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CM_QhxfQ5BqEUBxQRHzH2J1eWR2--IwmNONaGz4I8OE_1750841208
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Jun 20, 2025 at 09:52:44PM +0200, Michal Luczaj wrote:
>Transport assignment may race with module unload. Protect new_transport
>from becoming a stale pointer.
>
>This also takes care of an insecure call in vsock_use_local_transport();
>add a lockdep assert.
>
>BUG: unable to handle page fault for address: fffffbfff8056000
>Oops: Oops: 0000 [#1] SMP KASAN
>RIP: 0010:vsock_assign_transport+0x366/0x600
>Call Trace:
> vsock_connect+0x59c/0xc40
> __sys_connect+0xe8/0x100
> __x64_sys_connect+0x6e/0xc0
> do_syscall_64+0x92/0x1c0
> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>
>Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/af_vsock.c | 28 +++++++++++++++++++++++-----
> 1 file changed, 23 insertions(+), 5 deletions(-)

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 63a920af5bfe6960306a3e5eeae0cbf30648985e..a1b1073a2c89f865fcdb58b38d8e7feffcf1544f 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -407,6 +407,8 @@ EXPORT_SYMBOL_GPL(vsock_enqueue_accept);
>
> static bool vsock_use_local_transport(unsigned int remote_cid)
> {
>+	lockdep_assert_held(&vsock_register_mutex);
>+
> 	if (!transport_local)
> 		return false;
>
>@@ -464,6 +466,8 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>
> 	remote_flags = vsk->remote_addr.svm_flags;
>
>+	mutex_lock(&vsock_register_mutex);
>+
> 	switch (sk->sk_type) {
> 	case SOCK_DGRAM:
> 		new_transport = transport_dgram;
>@@ -479,12 +483,15 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> 			new_transport = transport_h2g;
> 		break;
> 	default:
>-		return -ESOCKTNOSUPPORT;
>+		ret = -ESOCKTNOSUPPORT;
>+		goto err;
> 	}
>
> 	if (vsk->transport) {
>-		if (vsk->transport == new_transport)
>-			return 0;
>+		if (vsk->transport == new_transport) {
>+			ret = 0;
>+			goto err;
>+		}
>
> 		/* transport->release() must be called with sock lock acquired.
> 		 * This path can only be taken during vsock_connect(), where we
>@@ -508,8 +515,16 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> 	/* We increase the module refcnt to prevent the transport unloading
> 	 * while there are open sockets assigned to it.
> 	 */
>-	if (!new_transport || !try_module_get(new_transport->module))
>-		return -ENODEV;
>+	if (!new_transport || !try_module_get(new_transport->module)) {
>+		ret = -ENODEV;
>+		goto err;
>+	}
>+
>+	/* It's safe to release the mutex after a successful try_module_get().
>+	 * Whichever transport `new_transport` points at, it won't go await
>+	 * until the last module_put() below or in vsock_deassign_transport().
>+	 */
>+	mutex_unlock(&vsock_register_mutex);
>
> 	if (sk->sk_type == SOCK_SEQPACKET) {
> 		if (!new_transport->seqpacket_allow ||
>@@ -528,6 +543,9 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> 	vsk->transport = new_transport;
>
> 	return 0;
>+err:
>+	mutex_unlock(&vsock_register_mutex);
>+	return ret;
> }
> EXPORT_SYMBOL_GPL(vsock_assign_transport);
>
>
>-- 
>2.49.0
>

