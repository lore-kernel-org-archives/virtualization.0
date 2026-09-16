Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DA63BA24E
	for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 12:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561865; cv=none; b=oCSz5KMwptiEfGfGTuOS5o0qBBhsCH6m5vQ9cG4e6VziTgg2VYWQsWN9vv9ovvtJbGFf8wjV9DxGPP43BjzmSr/hopNKdcb4OJWa2/ENxwjiJjzp/B67HK8ugNke33pFDipgEuokVF0rikdTEExSb6xoHLZ+oMHw1GzP19Xz0AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561865; c=relaxed/simple;
	bh=XGXi9MYz+h2MYHPVx7/i/kQbavA7JbRWDIW6+ytE058=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rNrqer6bk9FVlxxczUpQ7/ndaQIq/rwIb1wsczcDw/SvbPO1IdqnVEAgFnbPqtfpeso40t48ZMUPykqKhXjQnJMCeEJpReqDF7jBuOz0WHNMkmnXLhtryeaUI2Qoalol+TFoIQGC18smp/OYOm2fma6vbbBoxukK7EhTdwlE1TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DO74XkCq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DO74XkCq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789561862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pLMe/wNCn5zgtYuy3BxEIMyOkeNzl/Thlke2TpXOG+M=;
	b=DO74XkCqRa5oKucfYqETULuWcx29AwxpLw+x8C+mCU7iU4CfMXgl8b92rHocqDRcqG2fOE
	/0+gfXG22LTtxxOuyXGV2Ma3LWo2dXmLeM+oxxKlb6bG1ZualsdidBXYYN2jgraklxC9G7
	DjOVw+FatpfUQ+cuwhmgtmw+cn9XBFE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-MZKBCB2DPiiWTBcOzeu3Kw-1; Wed, 16 Sep 2026 08:31:01 -0400
X-MC-Unique: MZKBCB2DPiiWTBcOzeu3Kw-1
X-Mimecast-MFC-AGG-ID: MZKBCB2DPiiWTBcOzeu3Kw_1789561860
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49e6c17ec1dso47344065e9.2
        for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 05:31:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789561860; x=1790166660;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pLMe/wNCn5zgtYuy3BxEIMyOkeNzl/Thlke2TpXOG+M=;
        b=RuOSgrF7M+KGuYGSOtCi92EyGomEAr+xez/OBbGraR6pMplKrTMJllT6kjii1rLyCz
         JLlmvQgxONticrTTLkayHNn0aInr1obrXr5Uw2PSkREYiMO7C28VOxzgPDpcYvhbuDn7
         ZtGmLk2ilC5dAAmxl/2WUbueCbrbEF6FJFWZOUVlVwUVxlzSoqwk/jfxIMS8zA3cqrgx
         XuWC21NbEb88rC/NyVjv2u/SEXQ6gK8o72JkTmh+ygHLNMRb7c2wbWDABmEfg961Z9IM
         dAny+PkQIDXYCyq/ED7pmVUBOmO9fNlonTYwHP/czjB9+hc8okmZH2t5I5u9htJCNDvE
         W4ew==
X-Forwarded-Encrypted: i=1; AKwUvBy2qhHpve4X3ZihiY0JJK86PknfZr5WeQu/TLBxoxnysw/CVcESqUgH5mGdXPaMrA7FtjmwgXoxvR8h90XPSQ==@lists.linux.dev
X-Gm-Message-State: AFuF++nhrBWUvRtYvj1+OnH6CpIAOy+OIOszYxBVBTAkovk/qVHf+ECg
	DEYu0LemeEQKlOFKq8GAkCutdeFVjIWThFwMpKDDQhjbiI1JQxiQwJNXNQadVuLZEivPs+lwB39
	te0ojdzLatCdl2sT0le1TDMcr8EQ3RuIOhg7bhUINvAyRGeke2/NtNkmIzHLHV20JiOFE
X-Gm-Gg: AYBFou2Y7NoAw/kRpl0OQ/kP+gkLWwvOvEBZ5ZcZzGdnlQ8hg9m9S4hyYEh5Tug+Ui/
	uq+6kOcynhvmgOUnh2qD74GXbs3ZZqwC8UKxj8VMxSPn21GyYY7XDgolzHsFSvkNr9ohR+FSaW2
	zFd9u6EPNB6tJtNWTYNXlXyk+vHZuLGvZMnf6LK3OwnXh8Vj7A3R2F5gGsarNwfD+8L1WoYmmqS
	DJJBjkWHb1JqcrA5OpQcuBiYfKVrXBD0uNQ2Zy3sJ/Mp2agMwsHBGHongvLD2jYg1hpKqa88Cd+
	cobKkG3mRTP09wfFIulqsJT46+uYUs+hCkO7p7nkEhPP5Gnng221Hdyf3CadB1eH3zB5Yn43VOs
	qtgNqnO/MHESLFika8UUn7z0zrUVeRzOhZZcjZTZDx6BUNg==
X-Received: by 2002:a05:600c:6296:b0:49e:602a:b4ec with SMTP id 5b1f17b1804b1-49eb730e225mr61109825e9.8.1789561859690;
        Wed, 16 Sep 2026 05:30:59 -0700 (PDT)
X-Received: by 2002:a05:600c:6296:b0:49e:602a:b4ec with SMTP id 5b1f17b1804b1-49eb730e225mr61107955e9.8.1789561859097;
        Wed, 16 Sep 2026 05:30:59 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e83d903f6sm72500905e9.4.2026.09.16.05.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 05:30:58 -0700 (PDT)
Date: Wed, 16 Sep 2026 14:30:55 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Asias He <asias@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Hyunwoo Kim <imv4bel@gmail.com>
Subject: Re: [PATCH net v2 4/5] vsock: Do not reset a TCP_CLOSING socket
Message-ID: <aqqFkBYebKK1nZNJ@sgarzare-redhat>
References: <20260915-vsock-connect-reset-closing-v2-0-a1d9abb472f7@rbox.co>
 <20260915-vsock-connect-reset-closing-v2-4-a1d9abb472f7@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260915-vsock-connect-reset-closing-v2-4-a1d9abb472f7@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oO5TGZJug7ns6qmx_Tm0C3s_p4n6KTLgX4Q01miVD-s_1789561860
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Sep 15, 2026 at 03:15:15PM +0200, Michal Luczaj wrote:
>Handle the previously overlooked TCP_ESTABLISHED -> TCP_CLOSING
>transition (on VIRTIO_VSOCK_OP_RST), which could race with the connect
>loop.
>
>Resetting a socket that is still present in connected_table can lead to
>memory corruption. The reporter noted lost transports for in-flight skbs,
>and I have reproduced crashes caused by re-insertion into connected_table.
>
>  list_add double add: new=, prev=, next=.
>  kernel BUG at lib/list_debug.c:35!
>  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
>  Workqueue: vsock-loopback vsock_loopback_work
>  RIP: 0010:__list_add_valid_or_report+0x11f/0x130
>  Call Trace:
>   vsock_insert_connected.cold+0xe/0x13
>   virtio_transport_recv_pkt+0x10e9/0x1460
>   vsock_loopback_work+0x305/0x480
>   process_one_work+0xe4c/0x1560
>   worker_thread+0x4f1/0xd60
>   kthread+0x36e/0x470
>   ret_from_fork+0x47b/0x6b0
>   ret_from_fork_asm+0x1a/0x30
>
>Drop the redundant err=0 and the inaccurate comment above signal_pending().
>This fix is supplementary to commit 002541ef650b ("vsock: Ignore
>signal/timeout on connect() if already established"). Details under Link.
>
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
>Link: https://lore.kernel.org/netdev/anzT1fREOSyHT99k@v4bel/
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/af_vsock.c | 20 +++++++++-----------
> 1 file changed, 9 insertions(+), 11 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 499e902becfa..adf3f018347e 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1712,7 +1712,6 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
> 	long timeout;
> 	DEFINE_WAIT(wait);
>
>-	err = 0;
> 	sk = sock->sk;
> 	vsk = vsock_sk(sk);
>
>@@ -1834,23 +1833,22 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
> 		timeout = schedule_timeout(timeout);
> 		lock_sock(sk);
>
>-		/* Connection established. Whatever happens to socket once we
>-		 * release it, that's not connect()'s concern. No need to go
>+		/* Connection was established. Whatever happens to socket once
>+		 * we release it, that's not connect()'s concern. No need to go
> 		 * into signal and timeout handling. Call it a day.
> 		 *
> 		 * Note that allowing to "reset" an already established socket
> 		 * here is racy and insecure.
> 		 */
>-		if (sk->sk_state == TCP_ESTABLISHED)
>-			break;
>+		if (sk->sk_state == TCP_ESTABLISHED ||
>+		    sk->sk_state == TCP_CLOSING) {
>+			err = 0;
>+			goto out_wait;
>+		}
>
> 		/* If connection was _not_ established and a signal/timeout came
> 		 * to be, we want the socket's state reset. User space may want
> 		 * to retry.
>-		 *
>-		 * sk_state != TCP_ESTABLISHED implies that socket is not on
>-		 * vsock_connected_table. We keep the binding and the transport
>-		 * assigned.

Should we keep "We keep the binding and the transport assigned." or 
maybe add on the other phrase, "User space may want to retry, so we keep 
..."

> 		 */
> 		if (signal_pending(current) || timeout == 0) {
> 			err = timeout == 0 ? -ETIMEDOUT : sock_intr_errno(timeout);
>@@ -1874,8 +1872,8 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
> 		prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
> 	}
>
>-	err = sock_error(sk);
>-	if (err) {

Should we add a comment here explaining why we are doing this?

Thanks,
Stefano

>+	if (sk->sk_state != TCP_ESTABLISHED && sk->sk_state != TCP_CLOSING) {
>+		err = sock_error(sk);
> 		sk->sk_state = TCP_CLOSE;
> 		sock->state = SS_UNCONNECTED;
> 	}
>
>-- 
>2.55.0
>

