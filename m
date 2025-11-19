Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6125302745
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763571270; cv=none; b=IyPU96G+TYXHNx5+EkNI/A4Jli07CO8BYdunroXvUYOd2t9cWwoYT/2yB+1r2S3F/donikCacjIjmq9s3PTeaqcoRYaE9eiqujD+NeSzL6Pd9XfLu1hG8aU+WSqq7tcW4SNgiTANPupbLOhX8MI+c/R4eVYhQNgn/MT62EybBxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763571270; c=relaxed/simple;
	bh=6Drx87rd2S6vqtLc2UQEqHu/AwZAnnmLchlU5R8QGSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mZYbqEtGS+8n3YMRMJdKcp3jlfbY9m90UXo5GRERbOld6HIdo1RVHC9PfvC5Tw/ZjK0diaqUv96bt4tqtT8FWf9q+SxbebxEtYCziE2QHqGs/PinZDhbLTZkvZuKrtlDFcA3sAXBcuh5sz+sChBpDWumUf7d5dZUrp3s/RaSq2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P0GwJd16; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P0GwJd16"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763571267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q7i+Mz78wevuh6Uu7ucpzLg6JjFWyPkNjEckCxSDH8c=;
	b=P0GwJd169LvGmlwNclO4wxZytJ4tT6D3f5t9Lr+Zzb16uxDLWcnKjEAAH9Qbi3XTReDdxR
	vURP+QzVsKo+QC3rKmgOyZ562bozVWE8yHoLbRaJM7YfwTCGuOisjEkOSPdfcpZPAWm2ia
	NZxWRUypx10+FMoIX+3gxhzfeaBzul8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-yPk1cBVMOzKkYwDEX7W2uw-1; Wed, 19 Nov 2025 11:54:26 -0500
X-MC-Unique: yPk1cBVMOzKkYwDEX7W2uw-1
X-Mimecast-MFC-AGG-ID: yPk1cBVMOzKkYwDEX7W2uw_1763571265
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-88050bdc2abso240749796d6.2
        for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 08:54:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763571265; x=1764176065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q7i+Mz78wevuh6Uu7ucpzLg6JjFWyPkNjEckCxSDH8c=;
        b=JRChCuenqA8zfGr3HbFfvLv8dGU6AldTaEXMDv+nQQgF6eGzfqiiAVh/tT7unmHUhU
         nsXmDMI+3q10mspbQ6gozmt+uHGq/q3AfpWTsyaYxb6ExHY+el0t6Wyps4NJlr+cOTJV
         ddqpjcUIM/hAGldQlch5dqweQRxgY4C2a0v0pGb9bdxgv7wj0jgR4DxwxfbgaSdJIBoT
         mJwhm5v6+/n9ijR6A4Uk+d7AdaH20wf6K8yMLyqbcS50KS1YQShHlL9bc9xK83jMNG8r
         EskIqlLYDLYvgjhJ3f95vTX7zT5yLuWBmbEBOW0MqeelvpAdFHytpROMcHXHnNAHyggd
         jqRA==
X-Forwarded-Encrypted: i=1; AJvYcCWQhkUwIak+zs5hHHJ+ENF8izrf1Z+oTmJVaA8JY5YUhntQxkNwfYZvGib3Zoi3TknRqABYaeK7lWPm3mlUEA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxd5l+UMZbu/6ndKQLR8jvBDA7OhmL+cXSDnNg7oWE89FKoROBM
	AbXCjNk3GC9wRQG5IISp1AiASG51VV4KQYtuoQWsazWdofeAvbRE3giLLPTogWT4pabmZts1x4u
	dyBogTKeaKITxeNiWH488+5ANOR+3Y7vY+OTGnq5GBNT+IAW23wRHLfQOrmPx6/p9ziOy
X-Gm-Gg: ASbGnctTkbTlXxcC2xPxnQHZulxr8O63nQT+lGsxEx8eSgoT7vNdvxBl31btPPnSmHD
	AqdE23cqrLeN7ALmEWCy4+W0ful+iK+uyoMsEXbnMWkxFO5EG1cS14w60l51zHQy5fe2LbLywIz
	Rbu518gs3Whp+QXdkbL+Vp9WpH85XJHr65iq30Q5jAgTc0UGVAK1oJ0FDJOOnnnzF5f8QKO02Hd
	ygLATrDssKCpLnjbgBujaJ+IKormVLCFTKag5u7Y77ZGvqVIpZpnB6nhNWAfl5juwqTuepSDKaI
	XeNUWR4kcT6ixbxy97Tj6JyF2PCpm2evb/KKugywm207ehp2wp9luMGa3hSzuohnGg9Bf2lVXVU
	Hh86kckoqhAcyinlWOQyAgYDJElGU1zWt1MaSHLCNlZa348pl5O/1XGDhvhtb1A==
X-Received: by 2002:a05:6214:2622:b0:880:3ce2:65ad with SMTP id 6a1803df08f44-88292658f3cmr303443666d6.41.1763571265436;
        Wed, 19 Nov 2025 08:54:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEk44v06isDGAGdQhuvIG2e1Oku4AF/KluQ2knA4CgjrLpg1l9m1A5GTudXhBWUK9jrtvM4+Q==
X-Received: by 2002:a05:6214:2622:b0:880:3ce2:65ad with SMTP id 6a1803df08f44-88292658f3cmr303443426d6.41.1763571265033;
        Wed, 19 Nov 2025 08:54:25 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-882865cff46sm139739426d6.57.2025.11.19.08.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 08:54:24 -0800 (PST)
Date: Wed, 19 Nov 2025 17:54:14 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	George Zhang <georgezhang@vmware.com>, Andy King <acking@vmware.com>, Dmitry Torokhov <dtor@vmware.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] vsock: Ignore signal/timeout on connect() if
 already established
Message-ID: <kkqegkw6zqn2nasssskzqikjvphetgd4gsgo6yi5kce2ghnwvt@6kzf3vqqgemh>
References: <20251119-vsock-interrupted-connect-v2-1-70734cf1233f@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251119-vsock-interrupted-connect-v2-1-70734cf1233f@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1K2Kc9c_SUVJvuYADuz-yIi3mfD80f7bUlt_3y-_nYE_1763571265
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Nov 19, 2025 at 03:02:59PM +0100, Michal Luczaj wrote:
>During connect(), acting on a signal/timeout by disconnecting an already
>established socket leads to several issues:
>
>1. connect() invoking vsock_transport_cancel_pkt() ->
>   virtio_transport_purge_skbs() may race with sendmsg() invoking
>   virtio_transport_get_credit(). This results in a permanently elevated
>   `vvs->bytes_unsent`. Which, in turn, confuses the SOCK_LINGER handling.
>
>2. connect() resetting a connected socket's state may race with socket
>   being placed in a sockmap. A disconnected socket remaining in a sockmap
>   breaks sockmap's assumptions. And gives rise to WARNs.
>
>3. connect() transitioning SS_CONNECTED -> SS_UNCONNECTED allows for a
>   transport change/drop after TCP_ESTABLISHED. Which poses a problem for
>   any simultaneous sendmsg() or connect() and may result in a
>   use-after-free/null-ptr-deref.
>
>Do not disconnect socket on signal/timeout. Keep the logic for unconnected
>sockets: they don't linger, can't be placed in a sockmap, are rejected by
>sendmsg().
>
>[1]: https://lore.kernel.org/netdev/e07fd95c-9a38-4eea-9638-133e38c2ec9b@rbox.co/
>[2]: https://lore.kernel.org/netdev/20250317-vsock-trans-signal-race-v4-0-fc8837f3f1d4@rbox.co/
>[3]: https://lore.kernel.org/netdev/60f1b7db-3099-4f6a-875e-af9f6ef194f6@rbox.co/
>
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
>Changes in v2:
>- Keep changes to minimum, fold in vsock_reset_interrupted() [Stefano]

Thanks for addressing that! LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


>- Link to v1: https://lore.kernel.org/r/20251117-vsock-interrupted-connect-v1-1-bc021e907c3f@rbox.co
>---
> net/vmw_vsock/af_vsock.c | 40 +++++++++++++++++++++++++++++++---------
> 1 file changed, 31 insertions(+), 9 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 76763247a377..a9ca9c3b87b3 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1661,18 +1661,40 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
> 		timeout = schedule_timeout(timeout);
> 		lock_sock(sk);
>
>-		if (signal_pending(current)) {
>-			err = sock_intr_errno(timeout);
>-			sk->sk_state = sk->sk_state == TCP_ESTABLISHED ? TCP_CLOSING : TCP_CLOSE;
>-			sock->state = SS_UNCONNECTED;
>-			vsock_transport_cancel_pkt(vsk);
>-			vsock_remove_connected(vsk);
>-			goto out_wait;
>-		} else if ((sk->sk_state != TCP_ESTABLISHED) && (timeout == 0)) {
>-			err = -ETIMEDOUT;
>+		/* Connection established. Whatever happens to socket once we
>+		 * release it, that's not connect()'s concern. No need to go
>+		 * into signal and timeout handling. Call it a day.
>+		 *
>+		 * Note that allowing to "reset" an already established socket
>+		 * here is racy and insecure.
>+		 */
>+		if (sk->sk_state == TCP_ESTABLISHED)
>+			break;
>+
>+		/* If connection was _not_ established and a signal/timeout came
>+		 * to be, we want the socket's state reset. User space may want
>+		 * to retry.
>+		 *
>+		 * sk_state != TCP_ESTABLISHED implies that socket is not on
>+		 * vsock_connected_table. We keep the binding and the transport
>+		 * assigned.
>+		 */
>+		if (signal_pending(current) || timeout == 0) {
>+			err = timeout == 0 ? -ETIMEDOUT : sock_intr_errno(timeout);
>+
>+			/* Listener might have already responded with
>+			 * VIRTIO_VSOCK_OP_RESPONSE. Its handling expects our
>+			 * sk_state == TCP_SYN_SENT, which hereby we break.
>+			 * In such case VIRTIO_VSOCK_OP_RST will follow.
>+			 */
> 			sk->sk_state = TCP_CLOSE;
> 			sock->state = SS_UNCONNECTED;
>+
>+			/* Try to cancel VIRTIO_VSOCK_OP_REQUEST skb sent out by
>+			 * transport->connect().
>+			 */
> 			vsock_transport_cancel_pkt(vsk);
>+
> 			goto out_wait;
> 		}
>
>
>---
>base-commit: 106a67494c53c56f55a2bd0757be0edb6eaa5407
>change-id: 20250815-vsock-interrupted-connect-f92dfa5042cd
>
>Best regards,
>-- 
>Michal Luczaj <mhal@rbox.co>
>

