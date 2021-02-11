Return-Path: <SRS0=kV/H=HN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4EBC433DB
	for <virtualization@archiver.kernel.org>; Thu, 11 Feb 2021 13:19:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B00A364E7D
	for <virtualization@archiver.kernel.org>; Thu, 11 Feb 2021 13:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B00A364E7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 67D6A850E0;
	Thu, 11 Feb 2021 13:19:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nz3aa8bwEEwQ; Thu, 11 Feb 2021 13:19:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 74E6084E97;
	Thu, 11 Feb 2021 13:19:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 640A3C0174;
	Thu, 11 Feb 2021 13:19:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71137C013A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 13:19:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6B7D96F4F8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 13:19:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aSvXFahykG8S
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 13:19:15 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id 4F5B66F625; Thu, 11 Feb 2021 13:19:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 70F676F4F8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 13:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613049552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hmk14exEuAu1KNsA1eN9M3YU73ik9B3Wqe10eKOKhmo=;
 b=Pd5O61t/Yi9iQAvjSZWyrsUMcVrU1O4NzhOti0DouSmvk09ggo2pqXkt3tsBS/af6FEo1s
 LtxC9MNYWm/8hDPSPZzJjCNutJRHXBg9UxoF1mEX9stVE7XuBSYPJYAKT7htEbbie5/Bzq
 dXX7j5kEH9mrKBsJnu24gvzTNcDXN0Q=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-GuJBcBNBOwezWbulyXQe6Q-1; Thu, 11 Feb 2021 08:19:08 -0500
X-MC-Unique: GuJBcBNBOwezWbulyXQe6Q-1
Received: by mail-ed1-f71.google.com with SMTP id bd22so4603085edb.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 05:19:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Hmk14exEuAu1KNsA1eN9M3YU73ik9B3Wqe10eKOKhmo=;
 b=GW2KkJNbEJA37ihsPylUbBpLFzPljLrYhUqSsWcuBt1Udn+JvzNGW+ibmJ1ufXHgfR
 IgwzsO69x2YfcfI03psSsuUIaF1vIc76zM8EY9CR0Z58NPO4iE+QwNP62eE5Xlg30DeL
 CB+UQQDT6bzFdV4y3rccVY1El3zDdj+J54Qc7+e3TnP09dDOVP1Lh5vVXHKYW79uUiZJ
 2rvoVbQchbqS7yYY1xTMVjO43HYmCPWds7gRXST+2p1DSMobDVD4ngsoe3YgT+wjGxaE
 xy2YidtIjns/15SqxvLs1aMe4ZTAPdVt75uXsWetiSo9f+ZPjQuJusjf+xcK06fEtECw
 cCcA==
X-Gm-Message-State: AOAM531hKD16fMm7/XMWht8ZD4seaftLZvn+SNaeHVHhS/snrZqYYAAu
 SqxSWNEDV/mE6aaf56ymLrKIbeGLP3dxA6G+um+zZjwS/a5nPuwoUsKrc72LZYZk4u+qh/KTfrQ
 3o5DmcXR3iObQNj7aHVj4joyvOZY7TSvxCCL4jGM+hQ==
X-Received: by 2002:a17:907:210d:: with SMTP id
 qn13mr8293107ejb.377.1613049547482; 
 Thu, 11 Feb 2021 05:19:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyxJgriiJCTazbhHBmTN5Qv/1jX0/Iyqy0dukmtptWSTg97rk7GMZLbA0+lOCu+wbSRGVi5hg==
X-Received: by 2002:a17:907:210d:: with SMTP id
 qn13mr8293081ejb.377.1613049547302; 
 Thu, 11 Feb 2021 05:19:07 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id g22sm4356281ejw.31.2021.02.11.05.19.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Feb 2021 05:19:06 -0800 (PST)
Date: Thu, 11 Feb 2021 14:19:04 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v4 08/17] af_vsock: update comments for stream sockets
Message-ID: <20210211131904.ejkq3gltlqcffduq@steredhat>
References: <20210207151259.803917-1-arseny.krasnov@kaspersky.com>
 <20210207151632.805240-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210207151632.805240-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Vander Stoep <jeffv@google.com>,
 stsp2@yandex.ru, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 netdev@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Sun, Feb 07, 2021 at 06:16:29PM +0300, Arseny Krasnov wrote:
>This replaces 'stream' to 'connect oriented' in comments as SEQPACKET is
>also connect oriented.

I'm not a native speaker but maybe is better 'connection oriented' or 
looking at socket(2) man page 'connection-based' is also fine.

Thanks,
Stefano

>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> net/vmw_vsock/af_vsock.c | 31 +++++++++++++++++--------------
> 1 file changed, 17 insertions(+), 14 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index c77998a14018..6e5e192cb703 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -415,8 +415,8 @@ static void vsock_deassign_transport(struct vsock_sock *vsk)
>
> /* Assign a transport to a socket and call the .init transport callback.
>  *
>- * Note: for stream socket this must be called when vsk->remote_addr is set
>- * (e.g. during the connect() or when a connection request on a listener
>+ * Note: for connect oriented socket this must be called when vsk->remote_addr
>+ * is set (e.g. during the connect() or when a connection request on a listener
>  * socket is received).
>  * The vsk->remote_addr is used to decide which transport to use:
>  *  - remote CID == VMADDR_CID_LOCAL or g2h->local_cid or VMADDR_CID_HOST if
>@@ -479,10 +479,10 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> 			return 0;
>
> 		/* transport->release() must be called with sock lock acquired.
>-		 * This path can only be taken during vsock_stream_connect(),
>-		 * where we have already held the sock lock.
>-		 * In the other cases, this function is called on a new socket
>-		 * which is not assigned to any transport.
>+		 * This path can only be taken during vsock_connect(), where we
>+		 * have already held the sock lock. In the other cases, this
>+		 * function is called on a new socket which is not assigned to
>+		 * any transport.
> 		 */
> 		vsk->transport->release(vsk);
> 		vsock_deassign_transport(vsk);
>@@ -659,9 +659,10 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
>
> 	vsock_addr_init(&vsk->local_addr, new_addr.svm_cid, new_addr.svm_port);
>
>-	/* Remove stream sockets from the unbound list and add them to the hash
>-	 * table for easy lookup by its address.  The unbound list is simply an
>-	 * extra entry at the end of the hash table, a trick used by AF_UNIX.
>+	/* Remove connect oriented sockets from the unbound list and add them
>+	 * to the hash table for easy lookup by its address.  The unbound list
>+	 * is simply an extra entry at the end of the hash table, a trick used
>+	 * by AF_UNIX.
> 	 */
> 	__vsock_remove_bound(vsk);
> 	__vsock_insert_bound(vsock_bound_sockets(&vsk->local_addr), vsk);
>@@ -952,10 +953,10 @@ static int vsock_shutdown(struct socket *sock, int mode)
> 	if ((mode & ~SHUTDOWN_MASK) || !mode)
> 		return -EINVAL;
>
>-	/* If this is a STREAM socket and it is not connected then bail out
>-	 * immediately.  If it is a DGRAM socket then we must first kick the
>-	 * socket so that it wakes up from any sleeping calls, for example
>-	 * recv(), and then afterwards return the error.
>+	/* If this is a connect oriented socket and it is not connected then
>+	 * bail out immediately.  If it is a DGRAM socket then we must first
>+	 * kick the socket so that it wakes up from any sleeping calls, for
>+	 * example recv(), and then afterwards return the error.
> 	 */
>
> 	sk = sock->sk;
>@@ -1786,7 +1787,9 @@ static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
>
> 	transport = vsk->transport;
>
>-	/* Callers should not provide a destination with stream sockets. */
>+	/* Callers should not provide a destination with connect oriented
>+	 * sockets.
>+	 */
> 	if (msg->msg_namelen) {
> 		err = sk->sk_state == TCP_ESTABLISHED ? -EISCONN : -EOPNOTSUPP;
> 		goto out;
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
