Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0273DC4D3
	for <virtualization@lists.linux.dev>; Thu, 13 Aug 2026 08:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786610318; cv=none; b=YPI04FBAIDp0lBlcpr/fUokCzeeWPVD/vhVjtUnsDKv0AVAIplhEezVnALN5kgvxCa8UBPnTKIdtBtjwcLyqh9y0DrLRhbWIXpc/sRNImhEukewxVLU80hn6qaWHvHUdjJmPGFpX+RmGkWF+uPSTlsiJ72cp8pOOe/CBXCD/K7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786610318; c=relaxed/simple;
	bh=3A1TTzgx3HjDy337B7QEOqwQ54G9OEVp/xDl3QsWJGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=O8Gtpv/qXYH6xgBMzyB0OZmjBKgjAWgKZ0fds/qua/psIz6Lzg6vPj8YDVyvTmH4Y/ui9jOk0oByeatALQQkxVM6ZpjO2Ltaagv2yuUiNgmgYA4TbiUEYS4vs5oOlaoTMBpfg3iWt9xn5y8Lnq7G6eAF/dUbOycHqRSsM15HATc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VWX7d7kI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VWX7d7kI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786610315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=smAcv540nFYZlu+sSf+onJiRx1q/LBaPc+nj8Z/q0is=;
	b=VWX7d7kI06grmSAQsoOeVpI+U7SJqINHFm6u9Q1xwsdY9GrYfJTB7jTFFe5i+uOBSppkv2
	/iF31dIjSHAEdiuA6oObxYr1ujSFwtCtxy1ePsATd94nMd7a8nmwCetQFTR9ZCulTAQaRH
	ZJjt69qzeChrdSsYliERx/Kau3JGx3U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-STZsEOPqPkCHnfLoB2S77g-1; Thu, 13 Aug 2026 04:38:34 -0400
X-MC-Unique: STZsEOPqPkCHnfLoB2S77g-1
X-Mimecast-MFC-AGG-ID: STZsEOPqPkCHnfLoB2S77g_1786610313
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49808ea1b64so7842065e9.1
        for <virtualization@lists.linux.dev>; Thu, 13 Aug 2026 01:38:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786610313; x=1787215113;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=smAcv540nFYZlu+sSf+onJiRx1q/LBaPc+nj8Z/q0is=;
        b=MIxYUpWvAfZqfUqFmZoTDy3trb/1K5xUSfTs7H6fXniu3FfjzVskuYdPLzFUUZOnuc
         JLDNzdXdeeRjohiPVBg78Vxu29anGIJ0FA2JSdXClsNZwLNpcSjTXBuZoZkAdpX9uOiw
         EK0Z9oOFvm3ldreewgWFJBgrb2tP9QrX8LFuF/ge3yNpEPyI9jqBkMBaX9I8xpranWUt
         2dMYyRiYioDPcNhEcLTaS4vqjc+eNPQZ+ZShUdKyv8hQkIyovZBNwM257BLz1Yk+7btx
         VU4Qft0wVwj8uC4hx0fZHRShK1ZbXoRbwswXI8LrbGGUYkuz31iCwMWGYlMYLsqteOg7
         QX/g==
X-Forwarded-Encrypted: i=1; AHgh+RpR5Bfh+SPRLRvAOSNTsrMZwmY8Ux0K61SK2k9ak4o6fXpw78XkFoY96Xc9Lz+7haoxvPzCe7NRCniiacXsag==@lists.linux.dev
X-Gm-Message-State: AOJu0YwBB5QVJFpVTe+hZisrF4d5qx0a4IB4SqVQjWm3UzmCJq7iBJCV
	c5dRjNuYPlRyMSjPEOG7lY17MWN8JV+Rb8FKYe/43iwtTkcus6L3g4joOjASq1k7WFYblbAh2wk
	q+xZBvht68pL2M1rSmMboZdIiPaBscoFlDo5ITisiRn/iTACTfMKXC8uLHCMJplHQuj4x71Mk/C
	hC
X-Gm-Gg: AR+sD10eOLacstdToLnKoRLxRn7a9fdJ6GNcu6GLufhis9Se6+0swXUiSPL+pg34x40
	yMuAM2pz67VyVorTOMYw6wUFRK+eYKoZdg6yiAx9+VLjm58foqBJ0HQKQTnLGd/RLyVGxzbdmsI
	SZVt5HNSwqcYFckQMuqUlTyD7qAqUMGIriNjjNU40qHy8njLvgf5yBN7VdhCa0ZSQwPsqof7NuL
	lQmgEsmcMe1Bw1BOJvRXt9VxRzNog5lZ2SfrnHne2s3G6uLNIhr2QpAamjJtKD01qLfpyOf08QC
	QkR5JugsqaAKeTfj9IomhMJbL5mHgrPtjfWGV2wH5cBlDDuZNOiKncR6wI7UI9C6u6czgM5plTr
	QE0NXuMJxMfE5YPAuLyuNqYz82Z5LC7ZpiQOfawsyMo9T0j84l5kj
X-Received: by 2002:a05:600d:6409:10b0:499:84fc:4548 with SMTP id 5b1f17b1804b1-49984fc45c0mr2858005e9.5.1786610312818;
        Thu, 13 Aug 2026 01:38:32 -0700 (PDT)
X-Received: by 2002:a05:600d:6409:10b0:499:84fc:4548 with SMTP id 5b1f17b1804b1-49984fc45c0mr2857405e9.5.1786610312345;
        Thu, 13 Aug 2026 01:38:32 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it. [82.53.135.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981b62894sm46251145e9.13.2026.08.13.01.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 01:38:31 -0700 (PDT)
Date: Thu, 13 Aug 2026 10:38:29 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Nguyen Dinh Phi <phind.uet@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] vsock: remove the now-unused rejected flag
Message-ID: <an15JxACeo30Owo_@sgarzare-redhat>
References: <20260810170935.2242314-1-phind.uet@gmail.com>
 <20260810170935.2242314-3-phind.uet@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260810170935.2242314-3-phind.uet@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rez_p3-6Ad4suFyx0RlPc3xMf3eTZkCwa6BDLJPZpTU_1786610313
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Aug 11, 2026 at 01:09:31AM +0800, Nguyen Dinh Phi wrote:
>After previous patch, the branch marking a socket rejected in
>vsock_accept() is unreachable, and nothing ever sets vsk->rejected
>elsewhere.
>
>Therefore, we can remove the `rejected` field from vsock_sock structure.

I'd like to mention here that since commit d021c344051a ("VSOCK: 
Introduce VM Sockets") where `rejected` was introduced, we didn't have 
any path where sk_err is set on a listener socket, so that path was dead 
since the beginning.

The rest LGTM!

Thanks,
Stefano

>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>---
> include/net/af_vsock.h   |  5 +----
> net/vmw_vsock/af_vsock.c | 46 +++++++++++++---------------------------
> 2 files changed, 16 insertions(+), 35 deletions(-)
>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 30046a3c20f7..3357ee62d10b 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -52,13 +52,10 @@ struct vsock_sock {
> 	 * The listening socket is the head for both lists.  Sockets created
> 	 * for connection requests are placed in the pending list until they
> 	 * are connected, at which point they are put in the accept queue list
>-	 * so they can be accepted in accept().  If accept() cannot accept the
>-	 * connection, it is marked as rejected so the cleanup function knows
>-	 * to clean up the socket.
>+	 * so they can be accepted in accept().
> 	 */
> 	struct list_head pending_links;
> 	struct list_head accept_queue;
>-	bool rejected;
> 	struct delayed_work connect_work;
> 	struct delayed_work pending_work;
> 	struct delayed_work close_work;
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index ff507761f472..b59890bbd217 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -38,10 +38,9 @@
>  * pending socket.  When that socket reaches the connected state, it is removed
>  * from the listener socket's pending list and enqueued in the listener
>  * socket's accept queue.  Callers of accept(2) will accept connected sockets
>- * from the listener socket's accept queue.  If the socket cannot be accepted
>- * for some reason then it is marked rejected.  Once the connection is
>- * accepted, it is owned by the user process and the responsibility for cleanup
>- * falls with that user process.
>+ * from the listener socket's accept queue. Once the connection is accepted,
>+ * it is owned by the user process and the responsibility for cleanup falls
>+ * with that user process.
>  *
>  * - It is possible that these pending sockets will never reach the connected
>  * state; in fact, we may never receive another packet after the connection
>@@ -49,9 +48,7 @@
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
>@@ -774,11 +771,10 @@ static void vsock_pending_work(struct work_struct *work)
>
> 	if (vsock_is_pending(sk)) {
> 		vsock_remove_pending(listener, sk);
>-	} else if (!vsk->rejected) {
>-		/* We are not on the pending list and accept() did not reject
>-		 * us, so we must have been accepted by our user process.  We
>-		 * just need to drop our references to the sockets and be on
>-		 * our way.
>+	} else {
>+		/* We are not on the pending list so we must have been accepted
>+		 * by our user process. We just need to drop our references to
>+		 * the sockets and be on our way.
> 		 */
> 		cleanup = false;
> 		goto out;
>@@ -942,7 +938,6 @@ static struct sock *__vsock_create(struct net *net,
> 	vsk->listener = NULL;
> 	INIT_LIST_HEAD(&vsk->pending_links);
> 	INIT_LIST_HEAD(&vsk->accept_queue);
>-	vsk->rejected = false;
> 	vsk->sent_request = false;
> 	vsk->ignore_connecting_rst = false;
> 	WRITE_ONCE(vsk->peer_shutdown, 0);
>@@ -1912,26 +1907,15 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
> 		lock_sock_nested(connected, SINGLE_DEPTH_NESTING);
> 		vconnected = vsock_sk(connected);
>
>-		/* If the listener socket has received an error, then we should
>-		 * reject this socket and return.  Note that we simply mark the
>-		 * socket rejected, drop our reference, and let the cleanup
>-		 * function handle the cleanup; the fact that we found it in
>-		 * the listener's accept queue guarantees that the cleanup
>-		 * function hasn't run yet.
>-		 */
>-		if (err) {
>-			vconnected->rejected = true;
>-		} else {
>-			newsock->state = SS_CONNECTED;
>-			sock_graft(connected, newsock);
>+		newsock->state = SS_CONNECTED;
>+		sock_graft(connected, newsock);
>
>-			set_bit(SOCK_CUSTOM_SOCKOPT,
>-				&connected->sk_socket->flags);
>+		set_bit(SOCK_CUSTOM_SOCKOPT,
>+			&connected->sk_socket->flags);
>
>-			if (vsock_msgzerocopy_allow(vconnected->transport))
>-				set_bit(SOCK_SUPPORT_ZC,
>-					&connected->sk_socket->flags);
>-		}
>+		if (vsock_msgzerocopy_allow(vconnected->transport))
>+			set_bit(SOCK_SUPPORT_ZC,
>+				&connected->sk_socket->flags);
>
> 		release_sock(connected);
> 		sock_put(connected);
>-- 
>2.53.0
>

