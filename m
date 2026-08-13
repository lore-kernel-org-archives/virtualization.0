Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C552353A85
	for <virtualization@lists.linux.dev>; Thu, 13 Aug 2026 10:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786617453; cv=none; b=JpTEucjHL0X+OUjVJ3hyfggMFEHdX0LwzL/+a/UjW963TVh3ro+ODqzLXs8zI20EXZ+opn9x0Fa+wqfXgUqLnvbcswheXHEZuZaiwdpSrr9I/izavQlViqSxJhUlnNIkEIJE6u+TL+r4qVSaU+PuIElaSmv4dL/2txDsHts+gRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786617453; c=relaxed/simple;
	bh=oWdYF08jHvVj4F1zUGqrZdPquHrB8nAd8r0zSS7EneU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U9ZYf7orOEtYRZI5y+NJalNAHvrL04qNzfuDZIRw1xmpf0at5Dbche/2Q7LI+N9s2cdKY0e3J9oftN9Ox1Y1oyizYCYd3orQosxHfPNmgX1WFhgV6CHHk5xPLnnjQdvIZ8vEfxlFZ3eTbUen8QIOPQ13C40fLmHZRph9ASIDoNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=YNIlbOAx; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="YNIlbOAx"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wuRx9-0026Kh-14; Thu, 13 Aug 2026 11:42:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=Ch28p8GCf3s5Gsmzi5fOhYlvuMProozeG6Sa1L/Yaw8=; b=YNIlbOAx6oSx+11boW+BXJrKAI
	cgn/gK1WjA8K+doz1Y/Bc9pYvGsoDnGjf19i6f62EtMMuBVN4+zVsVQIDa7AKcBPik7sraEM3o01i
	v2pkOHXfStkE/66e5MCzlLYh5M+rYRFayZIpyQZo+FTPS3UwtTuR3+CIv9pk5Du0Z7Ra/TZUoKJ8p
	+FpIFv+XM4K9P/k1PSABPy7kOeR/52SHRse9jppTjupUDHLcGAzzJWBcP5Qdi9sKQ0xZPTLx36ele
	NxobR04VeP4+1IphOyfhtxkdyw2fYNg38QUV70ellU6lt9QZhnOmxtBk9iZrNQkXogNJXrsEeKIUu
	/fVm4I6A==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wuRx8-0002cS-Bf; Thu, 13 Aug 2026 11:42:22 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wuRx4-000mCc-Nu;
	Thu, 13 Aug 2026 11:42:18 +0200
Message-ID: <218226a4-38e6-4a16-a660-6c1bb92f9f96@rbox.co>
Date: Thu, 13 Aug 2026 11:42:17 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vsock: do not reset a socket in connect() once it has
 connected
To: Hyunwoo Kim <imv4bel@gmail.com>, sgarzare@redhat.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, leonardi@redhat.com,
 bobbyeshleman@meta.com, stefanha@redhat.com, mst@redhat.com
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org
References: <anzT1fREOSyHT99k@v4bel>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <anzT1fREOSyHT99k@v4bel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/26 22:13, Hyunwoo Kim wrote:
> commit 002541ef650b ("vsock: Ignore signal/timeout on connect() if
> already established") stopped connect() from resetting an established
> socket. The check only looks at whether sk_state is TCP_ESTABLISHED at
> that moment, and the state can change while connect() sleeps.

I guess this makes my fix incomplete. "Fixes: 002541ef650b"?

> A peer RST moves the socket to TCP_CLOSING, and it is not removed from
> vsock_connected_table on that path. connect() then wakes up, fails the
> check, and resets a socket that had actually connected to TCP_CLOSE and
> SS_UNCONNECTED.

Thanks for the details. Do I get it right: connect() misses the fact that
socket might have already transitioned TCP_ESTABLISHED -> TCP_CLOSING
during schedule_timeout()?

How about:

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 622dbd046799..39c42ef016c3 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1807,15 +1807,18 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 		timeout = schedule_timeout(timeout);
 		lock_sock(sk);
 
-		/* Connection established. Whatever happens to socket once we
+		/* Connection (has been) established. Whatever happens to socket once we
 		 * release it, that's not connect()'s concern. No need to go
 		 * into signal and timeout handling. Call it a day.
 		 *
 		 * Note that allowing to "reset" an already established socket
 		 * here is racy and insecure.
 		 */
-		if (sk->sk_state == TCP_ESTABLISHED)
-			break;
+		if (sk->sk_state == TCP_ESTABLISHED ||
+		    sk->sk_state == TCP_CLOSING) {
+			err = -sk->sk_err;
+			goto out_wait;
+		}
 
 		/* If connection was _not_ established and a signal/timeout came
 		 * to be, we want the socket's state reset. User space may want

?

> The socket can now be connected again while it is still on the table.
> Reconnecting to an address served by a different transport makes
> vsock_assign_transport() drop the transport from a live socket and free
> vsk->trans, even if skbs it already sent are still in flight.
> Reconnecting to the same address inserts a node that is already on the
> table, provided shutdown() has cleared SOCK_DONE in between.
> 
> sock->state cannot be used for the check either. shutdown() overwrites
> SS_CONNECTED with SS_DISCONNECTING.
> 
> Record on the socket that the connection completed, and check that
> instead. The sk_err path after the loop does the same reset, so guard it
> as well.
