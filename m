Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795101428;
	b=qoVoHyGlvRMxVbsM0fmG2Z+ZK+ZIoUL/o2+TB2TsnDK/U6plB6pwNlA5cOpWg5sDk9aC
	 72FJN/a+eMpaJB1+nzWvf7oSvsJ7aKg1KSaxScPV6w6EoV3//aAKRPAijFdDrW7PbmK+A
	 OzMhk6v3M2xZ4jIBU8DSCdHzD+yZ92pmQlAruX9CH/SEvekeGOijDZZu6cYQ4x5ZEMwEp
	 8eB1MgK7IQvgS5V98j5rOJTzq9zLo5aY4U9sVNhk8jm7pjEMlrsimiArGpWf1+m+KVqaZ
	 SAgkwvwIawBkGfR+Xu0Qy9egzud/rzGeAOpeDjbHqNCZqcIe4OeTdnUwGcP2OJ8lzGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795101428;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=mjCxSf15mAPakEhD7vh/i5/i7+CcuyVlsLkCJ9N8WsQ=;
	b=mfH2Y2ixA/IJAMQMU2GFw93ijvYVM9I6k/PEbnucjx5oyMQ7dvnkD8tp9joIOqHPJDQN
	 klHgonaA6GIueH5Egy6h3zZx8ZRrlrPvAhoqdyD2ZzCDQUDcoS13lQjcZc4QBblVwy998
	 p/co/yJPQZid5LkuB8cs/0/NvHz2TR80N8Ng+5/PwEFrD314TBXMluEefEl9XuDGSzMI3
	 FvMlU/EMzIZgK+xSXrxl3rVRHvR9R88Fad7L5eFUpneHIcKQ/zX02jukdUr/R33PDYHud
	 8KDH6y97cYro60znwG8ZdEjIvH5T4O0fGe+OXthQFijOL170WccR6UPMqcg8uyWDfng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bFvsnCza;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B8C606A320
	for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 15:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98B8C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bFvsnCza
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795101426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mjCxSf15mAPakEhD7vh/i5/i7+CcuyVlsLkCJ9N8WsQ=;
	b=bFvsnCzaLt0i4kQ4a0tYtrxyy0+DDgjpwjmenzhaLBHUVv3OG8uqP6hWP50fpgN8HxYTvA
	SUdlH4cfmk9xJzunPgIWmGZEHxVH+3dqdtDZbhEaPrX4RtaO99Rr08ZvHyTiju+5NCavKO
	TBfuAHSYS4DBMUUiC5OsD73WBqvX9s0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-yxEed_LkMRmHu_-e1CxRfw-1; Thu, 19 Nov 2026 10:17:05 -0500
X-MC-Unique: yxEed_LkMRmHu_-e1CxRfw-1
X-Mimecast-MFC-AGG-ID: yxEed_LkMRmHu_-e1CxRfw_1795101424
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4b764ffc014so20384435e9.0
        for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 07:17:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795101424; x=1795706224;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mjCxSf15mAPakEhD7vh/i5/i7+CcuyVlsLkCJ9N8WsQ=;
        b=HsWsLQSQY2weL1xtoE2n90mg1Zkk5mtu/WY2/LCuHhbwXCsIc8v1yKXKxSdM/VQbFN
         5stbMEysDoz+crDTGUqjDENsWHa2eaYJRW71Q29lo6JO2V7KFn0vHK3q0Nb2+nkHYJ8h
         V9K7ent7+56z7tT925mYxzboRBKhizQrnP1gAfAH8+BLo0JFFTtEP6q3VFWLwMIrluKS
         C/7AtO/hvsS7c5T5kJsdoxpaEQHE/umeooDWgLb8pHFrfS89bLe6Rdj8nOjrMJ6kudM8
         tn5O7dL38zCys1X9ICtt93eTKflIH0Qqyct7HtSEVsFs3QCOGUeoewb2V3hRPqrskNhV
         Zwtw==
X-Forwarded-Encrypted: i=1; AL+hErFkgcs4ezVQMkim/ssMFA9UYLD0Yf9Spz0Hz/YZkX+CSdWmbv0Bn63QHE2Tke2L7yhcpmmsYmPX/yVuEEqPuw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/DSfjNeEscaOzCliFBZLARFnoPS3Brm8XlAUENZsjJ0T2hCr/N
	13XkvHR9wXAQxb9ruRHaRaM/VDFUKibtbGY4ouWUOfwPfb+xWNp3ItviIy5w0hSVfdvj1DWCJAi
	f+a3wvdlQmwFmieeiI+8KXl1GjjBsJf4M0NkvbthQlwtrr3qrszM8+2lbqtpE1HOph8nZ
X-Gm-Gg: AYBFou31esGwqpdRbUTTNDPWngq09ycgvyJAv0SDL8mUk//TzZil9Fez10M34X5wDTc
	zFY5SU2rz9aVDIuQDcROAlSxNPZyFIBKlLkSSfNPFgw1vqWlJmbZ3+TMWTBaover0G/yPkyf6gf
	jBKBUCy2p9GSHePtv0rV4HTosHcJ3Muc2EVsveO66X5vOmLRRXjFxgwym+tX8ZvEOUPE/SUZLo9
	g0mA0oeN4m5TX2Q6Stf+p+Y2xVrpqsMj82FFqrG7kqjFQ77cqKFHMurfomoavCEoNsppKX+IvaC
	majmE44sAb7kJqclsjU48PCn+7uxzQ3kJyPTLwBl7+KNApcJ5XALBDs5jq1H5WB7bRGjLVlRCQ4
	ncqYW9dhC30sOl3dzVbKnkIV77v8HED4f2PkXUzhUtA==
X-Received: by 2002:a05:600c:4583:b0:4a7:9025:5c3b with SMTP id 5b1f17b1804b1-4bb7da2633emr133918225e9.19.1795101423911;
        Thu, 19 Nov 2026 07:17:03 -0800 (PST)
X-Received: by 2002:a05:600c:4583:b0:4a7:9025:5c3b with SMTP id 5b1f17b1804b1-4bb7da2633emr133917645e9.19.1795101423444;
        Thu, 19 Nov 2026 07:17:03 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1522:6500:ac93:c62:f076:48c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb84e47177sm29776395e9.2.2026.11.19.07.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 07:17:02 -0800 (PST)
Date: Thu, 19 Nov 2026 10:16:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: raoxu <raoxu@uniontech.com>
Cc: jasowangio@gmail.com, eperezma@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost/net: Fix receive queue test in busy poll
Message-ID: <20261119101645-mutt-send-email-mst@kernel.org>
References: <005FA5F7354482C7+20261110051642.249640-1-raoxu@uniontech.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <005FA5F7354482C7+20261110051642.249640-1-raoxu@uniontech.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cY7amLIFHivBar4eayPg_8vubzl1wT00Up_k2xTimUs_1795101424
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 10, 2026 at 01:16:42PM +0800, raoxu wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> sock_has_rx_data() returns a positive result when receive data is
> available. Socket implementations with a peek_len() callback follow
> that convention, but the fallback for sockets without one returns
> skb_queue_empty(), which has the opposite meaning.
> 
> This makes busy polling stop when a raw packet socket has no queued data
> and fail to recognize queued data through the fallback path. Return the
> negated queue-empty result so the fallback matches the callback and its
> callers.
> 
> Signed-off-by: Xu Rao <raoxu@uniontech.com>


do u want to send v2 addressing review?

> ---
>  drivers/vhost/net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 4570a4ffbab2..10ed2d55ff07 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -538,7 +538,7 @@ static int sock_has_rx_data(struct socket *sock)
>  	if (sock->ops->peek_len)
>  		return sock->ops->peek_len(sock);
> 
> -	return skb_queue_empty(&sock->sk->sk_receive_queue);
> +	return !skb_queue_empty(&sock->sk->sk_receive_queue);
>  }
> 
>  static void vhost_net_busy_poll_try_queue(struct vhost_net *net,
> --
> 2.50.1

