Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FE43161B2
	for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 09:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763459491; cv=none; b=IMY2iyiZlB8f/wjGZ0pOYtF7CGQAyLTaf6Dtl1hqf2LrlpRnrPK1n/OwTosrA7uuIkqvRoOivbT8mCr+aGFqeoQMWMG7iRMF1t5uLNB5QEXBre19SXavmEeCKwXKZ/nHseO7ar5I61YnmgDiEDgzDJeXzN3RVmwyV8eEt5MJnlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763459491; c=relaxed/simple;
	bh=vCEQwxutYMtvzkfn4aDJG38kRsbNkfFL4sVGu5IhVa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kLymnbFG+AoNqclpeh93bKeyxlsLGEVnnhNpcAZMdVd0Ym020+f+kRBNdnyPtlIFyHOD7qRhTyM1Nol++SkaniqyhVUWrCoDFijWGGd2DgxiC+wN2VskRGXNT78p024zwICa44yRLB6jpP8RpGL3f3RwkBEfHwKECXAHKGmR2k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OvHQ7OAF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OvHQ7OAF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763459488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IsM7rn4162L4RtQdGi/Pr9MgOF3AH3PyQCj0ogQCAI4=;
	b=OvHQ7OAFTAMC7Nw+0QK8VpFxPzDLP1uhMWIa/rrRjs32attwUBb2LwD9/aOla4/PdZMYHD
	toWKq62gdapf2CQykFZvU6D6qFU8Tn7HtzuXCE23tDYjVXUyCbf034jUnmcJbJfoOxhg7Z
	6IC9CND/zm2Tx2CSGydLs6B0vCwnNcs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-5LtlA-_JN-2qKsG0sAsm7A-1; Tue, 18 Nov 2025 04:51:27 -0500
X-MC-Unique: 5LtlA-_JN-2qKsG0sAsm7A-1
X-Mimecast-MFC-AGG-ID: 5LtlA-_JN-2qKsG0sAsm7A_1763459486
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6430efef759so6082675a12.1
        for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 01:51:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763459486; x=1764064286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IsM7rn4162L4RtQdGi/Pr9MgOF3AH3PyQCj0ogQCAI4=;
        b=QxgpQCQ5VJGEN/IIKbCu8Gg9LLbi6su+e6GrrK3yOwctNW6jeA300kJ+vD0z0Xhg/J
         1G1c9wDkhIcKgT2EWzLkZF2/wx7jnvvdKYnBQgoJxFak10vPUabG/lbq7vLIn3B+qifP
         KLzwvB5SmUIqaz6iIIxX+pOL5ZJnZ8/r91h2ObyvJZSKVv6y27iJwpJHDpy/pq3ILO35
         3razuMmURCsFLJQquDiFAJaQtghKjvCIM57H5AFEBD6+PTbBkaKtLqlDbZ7AXmWUM8Fl
         De3Y03XD9Vxz6LoYLtHxR061woJJ8qZZ1GsnHm9eLwbyqrbSqHpLThq9AtfHZqXa3m74
         Uy/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzfdnomvWVYKg/FleCQ/JpDreOw+gCDZAAwTMuvvzWb1padEeUFUt/sgbwlX1iy8RyVNUzGMz2Kb66Dluf4Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzvqLu9Nzgic1RMCQ56yfa+L/B0xuUnuRdI1izfcIg0Rx15Un92
	kVmZYPt/SQco5WmduWdHKCaKkzBTVIIKqLFOLpO82HdOSyb0iwGIgPlS+R+pIA3aSilNiGxBsrB
	N1j773jkHz0364VkpG4imFxJhYtgfz4AOIoJvBaO9VfDRKBXqOteyh5y3k6YSR9WqbbE+
X-Gm-Gg: ASbGncv/qSEf8qX/Zu7eqswBr2R9CoALiehyWmPNqDWjchj0/6CnSe2kzxNWSDx1Xl2
	B87diKZA8H4vARt2zzSVvSpEDNUWU02fe8uMF8YnHs5z9oEnLWrUCDDHN45+EtJnclnFlSLZguR
	lRYfLQ8H3bAiqDJXOe6hanxlWCeyYK2khv0H2iIr0kfvAGeFY86QF6RuKitDqXHsPQDlEoivxha
	yZb8EMhI8jd9YLnpaO62dTOfrJu9LDYi/YurSlrBKJWJA1LnncSouHXDkm7bHtriXKCXEv0TxKn
	ZFx28h0ysg/gmvKr3X9RZlY7i6XNtIZHbl+ojdQmAez+PjTKlrowP7co+sfE4Pgkt0fz6QoGiy3
	qDV4S9lznMgvl8p7JbhUoW5Ohb/MGl673ssJXLkR8lJ9Sf+RJ
X-Received: by 2002:a05:6402:50d3:b0:63c:334c:fbc7 with SMTP id 4fb4d7f45d1cf-64350e8a2camr15790740a12.19.1763459485777;
        Tue, 18 Nov 2025 01:51:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGBtJLv1qV30eWxs9yIBS6qQkoQ9Ttvf4h0pcNbfbjcxMK1pThVxKi8AHK6HbL+sLLiYnMhQ==
X-Received: by 2002:a05:6402:50d3:b0:63c:334c:fbc7 with SMTP id 4fb4d7f45d1cf-64350e8a2camr15790720a12.19.1763459485342;
        Tue, 18 Nov 2025 01:51:25 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-250.retail.telecomitalia.it. [82.57.51.250])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a497ffdsm12370564a12.21.2025.11.18.01.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 01:51:24 -0800 (PST)
Date: Tue, 18 Nov 2025 10:51:11 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	George Zhang <georgezhang@vmware.com>, Andy King <acking@vmware.com>, Dmitry Torokhov <dtor@vmware.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vsock: Ignore signal/timeout on connect() if already
 established
Message-ID: <dh6gl6xzufrxk23dwei3dcyljjlspjx3gwdhi6o3umtltpypkw@ef4n6llndg5p>
References: <20251117-vsock-interrupted-connect-v1-1-bc021e907c3f@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251117-vsock-interrupted-connect-v1-1-bc021e907c3f@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6TZFatxMtfgsaKYiieF8NpxBUK9_CZiEp_WDreEWCDA_1763459486
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Nov 17, 2025 at 09:57:25PM +0100, Michal Luczaj wrote:
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
>Note that this patch does not tackle related problems described in
>https://lore.kernel.org/netdev/70371863-fa71-48e0-a1e5-fee83e7ca37c@rbox.co/

Ooops, it seems I forgot to reply. Thanks for bringing this to my 
attention agan. Next time feel free to ping me :-)

I'll reply in that thread.

>---
> net/vmw_vsock/af_vsock.c | 48 ++++++++++++++++++++++++++++++++++++++++--------
> 1 file changed, 40 insertions(+), 8 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 76763247a377..a52e7dbe7878 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1528,6 +1528,23 @@ static void vsock_connect_timeout(struct work_struct *work)
> 	sock_put(sk);
> }
>
>+static void vsock_reset_interrupted(struct sock *sk)
>+{
>+	struct vsock_sock *vsk = vsock_sk(sk);
>+
>+	/* Try to cancel VIRTIO_VSOCK_OP_REQUEST skb sent out by
>+	 * transport->connect().
>+	 */
>+	vsock_transport_cancel_pkt(vsk);
>+
>+	/* Listener might have already responded with VIRTIO_VSOCK_OP_RESPONSE.
>+	 * Its handling expects our sk_state == TCP_SYN_SENT, which hereby we
>+	 * break. In such case VIRTIO_VSOCK_OP_RST will follow.
>+	 */
>+	sk->sk_state = TCP_CLOSE;
>+	sk->sk_socket->state = SS_UNCONNECTED;
>+}
>+
> static int vsock_connect(struct socket *sock, struct sockaddr *addr,
> 			 int addr_len, int flags)
> {
>@@ -1661,18 +1678,33 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
> 		timeout = schedule_timeout(timeout);
> 		lock_sock(sk);
>
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
> 		if (signal_pending(current)) {
> 			err = sock_intr_errno(timeout);
>-			sk->sk_state = sk->sk_state == TCP_ESTABLISHED ? TCP_CLOSING : TCP_CLOSE;
>-			sock->state = SS_UNCONNECTED;
>-			vsock_transport_cancel_pkt(vsk);
>-			vsock_remove_connected(vsk);
>+			vsock_reset_interrupted(sk);
> 			goto out_wait;
>-		} else if ((sk->sk_state != TCP_ESTABLISHED) && (timeout == 0)) {
>+		}
>+
>+		if (timeout == 0) {
> 			err = -ETIMEDOUT;
>-			sk->sk_state = TCP_CLOSE;
>-			sock->state = SS_UNCONNECTED;
>-			vsock_transport_cancel_pkt(vsk);
>+			vsock_reset_interrupted(sk);
> 			goto out_wait;

I'm fine with the change, but now both code blocks are the same, so
can we unify them?
I mean something like this:
		if (signal_pending(current) || timeout == 0 {
			err = timeout == 0 ? -ETIMEDOUT : sock_intr_errno(timeout);
			...
		}

Maybe at that point we can also remove the vsock_reset_interrupted()
function and put the code right there.

BTW I don't have a strong opinion, what do you prefer?

Thanks,
Stefano

