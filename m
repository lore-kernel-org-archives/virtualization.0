Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8928648551A
	for <virtualization@lists.linux.dev>; Fri,  7 Aug 2026 13:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108451; cv=none; b=G2V41m4Bs8eywPbgGT7j6tOy4Qnl0bnFRjmEGv8Dfu/VHg5aHvxqSIDUVBTUmtvvCkbOwUNIuH65haiYCYsRmEJefa/MEu6OSTbBPA/iQaujPc49VyCvNKsWXkgTyNsjHEC/3btJGNqhbhTpEp0p1oUv789t/rj1yY5nvuXcilo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108451; c=relaxed/simple;
	bh=WzpJDU9FbKqDMi0AmEFKjRX4c4fT3hvj8KwBS7N71qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ORAUImFZSXVgfci76Uz12xpW4+8FvA6BpSRPI+nRL7M7fxq7DCn2P17n7pmnMRRIUAVxXlBfQAL5dmR1pyuw7QgSGWBMOJVFKMbVpeCtRyc7qrMq1Ms1FYZRogo/krX4McQSn6UE3lx+5UjmeEcMnkIThj9HcKs5oek8tZyumYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A2ddCFRd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A2ddCFRd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786108437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xUbzS3I8i6QFWa+8ZY5NS44GUz1hHJ0wwcZwZwY6pas=;
	b=A2ddCFRdZBU53EgewIoEwjpBvMk8TkVNoHVo0s0IGBzeO0UXKw/NEtzZJQ3RaeBwHbpsG2
	YnaCCZrpjzitbBlXb4QQVeiL3QTmNMweHSS0EZ9NHwGH1f0X+vzBW5dtxz3wPnBQEiCvEd
	7uG+1XPnNoibXIGNh8QDxQwy1Eu1fkE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-azAdvyIKMAmQo_nF6KJ0AQ-1; Fri, 07 Aug 2026 09:13:54 -0400
X-MC-Unique: azAdvyIKMAmQo_nF6KJ0AQ-1
X-Mimecast-MFC-AGG-ID: azAdvyIKMAmQo_nF6KJ0AQ_1786108433
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493a7fa8481so13595925e9.1
        for <virtualization@lists.linux.dev>; Fri, 07 Aug 2026 06:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786108433; x=1786713233;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xUbzS3I8i6QFWa+8ZY5NS44GUz1hHJ0wwcZwZwY6pas=;
        b=Ot0EbHr8KZ3AeEOlnGvraBwMXWeb8eYOq47Tv1t92Ejqo5iGid6D8/6sZujzzxCwpK
         z00HV2nJ/xXXZi/OuAtrUGdHnEJ9KXHjlOGxY+Nl89wt3XtzFTFrLoHCihxe1NHDMJeW
         7T61Id6FHGinJ2uHznMU3YndTI7yEAMsWbrjlGYenVRNMqQJLDy7kYYl4iB1FPLG6vfJ
         P8GYgZrmcPYq0n+KVSd8PZle8ZBQvH+gPeYP1XmRES4gp/GuMc6T/7S9TRLzL4aD/s+t
         vR/cKFTNFmHpwq6s8y1v7yY2lDWi8Wd5qPG23T51CurQ3kgQTA6ZJaEmhHQZXATkgagY
         qfWA==
X-Forwarded-Encrypted: i=1; AHgh+RpoJNDTR0FLKJ9/mGVVw3FmECIV4Apw07TmpIjzqmAkeXSZE/PQRuOPk9ev7TfFVXNJ3BS88FLdGI+5Ryko6Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzX+DVVfw3E5CxR7eh5Vd8x1Sjr0NV/dT1N3gNbXeosGACaZSHV
	U8CKIMV3Edg+vmtob/VUdUTAatkZJBsKTcRXkUoyPtSFVsXFtOw+tOxVC3osEDz8A/v5rZkoYWk
	/vpyizI42Ysb2d0F5pNgtsmj7wlWRM7cK5hNdc6yeniHUspCSqIRTkjo3ctG/OIyR6YLu
X-Gm-Gg: AR+sD13M9UVDd7fb6TRsGKvamUib47CaX79AUrn3MBQpH7ZHoyerBez+gf15zIW1UHC
	XHtIzoRn79b8k0NaIPnUIjsW3a3NA6jGhHNtVwY9U3PdtreFyTMiY/hX4sz6iUnr9b8vqVBFjLP
	9H6ye7dZiB7eMf9xz5YLgVMxKunBwz2COlWuj2bt5ir86RSrOlMMGYQK2NxfUEKPkTsTKkcYJHP
	S+2eE2uq5iH4G46/3Xa+aN+X1Zlq9SxnioIVEhafiiBtfO5jWuayeO2cXs242s2xv44FDpz/G82
	GRVZZbgnn3RmAC45XSR41ZxmWD6xpaWgX45TpmPgbZyu3liBblRmokcGQf2eS8xfVMxXCa90uxK
	wiw==
X-Received: by 2002:a05:600c:a48:b0:495:69eb:27d3 with SMTP id 5b1f17b1804b1-499553f4c4cmr145495185e9.8.1786108432785;
        Fri, 07 Aug 2026 06:13:52 -0700 (PDT)
X-Received: by 2002:a05:600c:a48:b0:495:69eb:27d3 with SMTP id 5b1f17b1804b1-499553f4c4cmr145494565e9.8.1786108432334;
        Fri, 07 Aug 2026 06:13:52 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.96.150])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995bdca3ddsm51398005e9.1.2026.08.07.06.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:13:51 -0700 (PDT)
Date: Fri, 7 Aug 2026 15:13:35 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>, 
	phind.uet@gmail.com
Cc: "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S . Tsirkin" <mst@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, 
	Asias He <asias@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+53515d23498d641e21ea@syzkaller.appspotmail.com
Subject: Re: [PATCH] vsock: fix memory leak of rejected child sockets in
 vsock_accept()
Message-ID: <anXZQSE4Bh8ilEHo@sgarzare-redhat>
References: <20260807114804.320862-1-nagachaithanya9911@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260807114804.320862-1-nagachaithanya9911@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -sO0XBEhEx6pwX4EEr0dGkk7uKr41-hvuVQpcaKfRqo_1786108433
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Aug 07, 2026 at 11:48:04AM +0000, Chaithanya Lagisetty wrote:
>When a listener socket carries an error (e.g. sk_err set by a connect()
>issued on the socket before listen()), vsock_accept() dequeues the child
>from the accept queue but rejects it. Previously it only marked the child
>as rejected and relied on vsock_pending_work() to clean it up. However,
>rejected child sockets created through virtio_transport and vsock_loopback
>never reach that cleanup path, causing the child socket, along with its
>LSM blob and transport-specific state, to leak permanently.
>
>Fix this by releasing the child's references directly in vsock_accept()
>on the reject path: remove it from the connected table and drop the
>references taken by sk_alloc(), __vsock_insert_connected() and
>vsock_enqueue_accept(), so the socket reaches vsock_sk_destruct() and is
>freed. The now-unused 'rejected' flag and its handling in
>vsock_pending_work() are removed.
>
>Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
>Reported-by: syzbot+53515d23498d641e21ea@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=53515d23498d641e21ea
>Signed-off-by: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
>---
> include/net/af_vsock.h   |  4 +---
> net/vmw_vsock/af_vsock.c | 38 ++++++++++++++++++++------------------
> 2 files changed, 21 insertions(+), 21 deletions(-)

Thanks for this, this is something similar of what I suggested some days 
ago to Phi in 
https://lore.kernel.org/netdev/anLuRE4ix5-BZ7-t@sgarzare-redhat/

Phi's work also includes more cleanups, so let's avoid duplicated work.

Please test Phi's v5 series that should include something similar, plus 
other stuff that should fix exaclty the same report.

Stefano

>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 30046a3c20f7..b70cea7f754f 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -53,12 +53,10 @@ struct vsock_sock {
> 	 * for connection requests are placed in the pending list until they
> 	 * are connected, at which point they are put in the accept queue list
> 	 * so they can be accepted in accept().  If accept() cannot accept the
>-	 * connection, it is marked as rejected so the cleanup function knows
>-	 * to clean up the socket.
>+	 * connection, the child is cleaned up directly in vsock_accept().
> 	 */
> 	struct list_head pending_links;
> 	struct list_head accept_queue;
>-	bool rejected;
> 	struct delayed_work connect_work;
> 	struct delayed_work pending_work;
> 	struct delayed_work close_work;
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 622dbd046799..2084c88ac836 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -39,9 +39,9 @@
>  * from the listener socket's pending list and enqueued in the listener
>  * socket's accept queue.  Callers of accept(2) will accept connected sockets
>  * from the listener socket's accept queue.  If the socket cannot be accepted
>- * for some reason then it is marked rejected.  Once the connection is
>- * accepted, it is owned by the user process and the responsibility for cleanup
>- * falls with that user process.
>+ * for some reason then it is cleaned up directly in vsock_accept().  Once the
>+ * connection is accepted, it is owned by the user process and the
>+ * responsibility for cleanup falls with that user process.
>  *
>  * - It is possible that these pending sockets will never reach the connected
>  * state; in fact, we may never receive another packet after the connection
>@@ -49,9 +49,7 @@
>  * future, after some amount of time passes where a connection should have been
>  * established.  This function ensures that the socket is off all lists so it
>  * cannot be retrieved, then drops all references to the socket so it is cleaned
>- * up (sock_put() -> sk_free() -> our sk_destruct implementation).  Note this
>- * function will also cleanup rejected sockets, those that reach the connected
>- * state but leave it before they have been accepted.
>+ * up (sock_put() -> sk_free() -> our sk_destruct implementation).
>  *
>  * - Lock ordering for pending or accept queue sockets is:
>  *
>@@ -774,11 +772,11 @@ static void vsock_pending_work(struct work_struct *work)
>
> 	if (vsock_is_pending(sk)) {
> 		vsock_remove_pending(listener, sk);
>-	} else if (!vsk->rejected) {
>-		/* We are not on the pending list and accept() did not reject
>-		 * us, so we must have been accepted by our user process.  We
>-		 * just need to drop our references to the sockets and be on
>-		 * our way.
>+	} else {
>+		/* We are not on the pending list, so we must have been accepted
>+		 * by our user process (rejected sockets are cleaned up directly
>+		 * in vsock_accept()).  We just need to drop our references to
>+		 * the sockets and be on our way.
> 		 */
> 		cleanup = false;
> 		goto out;
>@@ -942,7 +940,6 @@ static struct sock *__vsock_create(struct net *net,
> 	vsk->listener = NULL;
> 	INIT_LIST_HEAD(&vsk->pending_links);
> 	INIT_LIST_HEAD(&vsk->accept_queue);
>-	vsk->rejected = false;
> 	vsk->sent_request = false;
> 	vsk->ignore_connecting_rst = false;
> 	WRITE_ONCE(vsk->peer_shutdown, 0);
>@@ -1919,14 +1916,19 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
> 		vconnected = vsock_sk(connected);
>
> 		/* If the listener socket has received an error, then we should
>-		 * reject this socket and return.  Note that we simply mark the
>-		 * socket rejected, drop our reference, and let the cleanup
>-		 * function handle the cleanup; the fact that we found it in
>-		 * the listener's accept queue guarantees that the cleanup
>-		 * function hasn't run yet.
>+		 * reject this socket and return.  The child was found on the
>+		 * listener's accept queue, so it still holds the references
>+		 * taken by sk_alloc(), __vsock_insert_connected() and
>+		 * vsock_enqueue_accept().  Drop them here so the socket is
>+		 * destroyed.  We cannot defer this to vsock_pending_work():
>+		 * rejected child sockets created through virtio_transport and
>+		 * vsock_loopback are not cleaned up by that worker, so the
>+		 * child would otherwise leak permanently.
> 		 */
> 		if (err) {
>-			vconnected->rejected = true;
>+			vsock_remove_connected(vconnected);
>+			connected->sk_state = TCP_CLOSE;
>+			sock_put(connected);
> 		} else {
> 			newsock->state = SS_CONNECTED;
> 			sock_graft(connected, newsock);
>-- 
>2.43.0
>

