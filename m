Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795475974;
	b=F/K+L9RgJe1qhEd+mQJmeI8JfFXYgbut2IMcNLz43X4IwDbsZMm3D1If9bUDfNSKBS8f
	 rEwsV2JHkMDpiXBQSpnsdSUQWlT7grSsT8gu0D98X8y2lAWe4xx4EamuGNMkrBnSLZepw
	 nffVeMoqzbUnInDKNuxWnN4PZhROuoaYactjcJbz0hzoFH6DgD+aH3WPWw52I9OgOx/eL
	 WvscDP11ueO8PiJHaO/BkUxK3xnmRPgD8Yxhuyt3uLz3XNMkw5sDD2e5VVD6ffPPAbw12
	 oYHWlhVbAiCmoow9SnaGtxNySuPUfrrNnNgc1iGWJOZkl0bbxJakNI6AerJOZ/WMUug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795475974;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 CC:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Originating-IP:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version;
	bh=8vJ4rc7Ztjrf5+f9gvb+rymWWVA3mVc8hXo5yAPcMrM=;
	b=hgnctokj7yqRBUXlnzeGWF3Js76eLdiANR005L31G5/g15RdakDohcmLeT4B69m2EErh
	 2Lq7IuD9E0TxWRg2PKQiJYWQ7DlIViXLCszwQitROyDb2bxvlQgfxMbpZl3JeVZe+gXjh
	 eWbMFDPBaq8lzEQPrpGFaUrOJha13y8hzd5iq6yeeR0tI9wmxIlKFLN37gESydNE7estG
	 DozutrHnMdokZiUYJsTkgwHizbOV2qrW+5CcyfSCztu+mbCISqtv4N8DwNdC/k/JkpdJz
	 TT2KGJQ6ReXMI5UUElDF/HmSljuhiSp4yAj77Sm2d/47v2XJoixDLMqLemcvAvsvvsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b="mWwaV/ek";
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB98606A331
	for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 23:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AB98606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=mWwaV/ek
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANJwF872641869;
	Mon, 23 Nov 2026 15:19:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=8vJ4rc7Ztjr
	f5+f9gvb+rymWWVA3mVc8hXo5yAPcMrM=; b=mWwaV/ek2boEeWNrZrvj/xchpig
	wQr9+OgG/dqJQ2Mb1J32KazB2HNwF8ZksRq1if7ElRCJI5vAyZCnl/AVo5IGD4Cp
	Fm65PLOk4ulFUm65V0g4a5FLR0t998i87IJaSyvSaE9WfLZjf6x1vzgPGU0ilSaY
	xyso3d+Pvlbc+lbvTftMuUpS5axc8NU2ghzaZ00GF7Wsul85RD6OPEBQv/13b/et
	fOZAgDRuMjsaTAMM29XyDp/B6Jstcw7OFNiBp7Fk6C3nriJ3XZabBo+7r7zPDHxz
	pZqXvfhRUg7DIuOzk7qsNyeDl1FGuGOCWvIZZGMlXpfTd07FIeUwby3G0kg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j399b5cnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 23 Nov 2026 15:19:17 -0800 (PST)
Received: from localhost (2620:10d:c085:108::150d) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Mon, 23 Nov
 2026 23:19:16 +0000
Date: Mon, 23 Nov 2026 15:19:12 -0800
From: Bobby Eshleman <bobbyeshleman@meta.com>
To: Michal Luczaj <mhal@rbox.co>
CC: Stefano Garzarella <sgarzare@redhat.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>,
        George Zhang <georgezhang@vmware.com>, Andy King
	<acking@vmware.com>,
        Dmitry Torokhov <dtor@vmware.com>, <virtualization@lists.linux.dev>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kyle Zeng <kylebot@openai.com>
Subject: Re: [PATCH net v2] vsock: only undo SS_CONNECTING when connect()
 fails
Message-ID: <awTJ8EOl52W0ph1K@devvm29614.prn0.facebook.com>
References: <20261117-vsock-connect-close-v2-1-db5388323770@meta.com>
 <ed28d36a-682e-4db5-abf4-1339734e7c57@rbox.co>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ed28d36a-682e-4db5-abf4-1339734e7c57@rbox.co>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA5MiBTYWx0ZWRfX4XTKjePjSP8g
 h8Sao59kxufLzLTTB1S2kIFpuwAk6QOWkWnOsPAbaouuEL1m0ZEt5Gy8LDhDJUT0FZvSpgcPF+f
 irs17XsT6qE36MTMNrnHzhOjRfQQ212Xtn/lWRkhrfDJma8N2pgLN+GVsJqdCMFpUxt5p6EtS9Q
 Wd17kwernWQnzF9YE+iENkyqRYyVCxQRaVXiVQX9IwO1pfcc+RP8jj2D8TaF7IwgK9v2k5GgbxM
 SUe0BC6rKcMSL8t5Wpxw8v/xb7hK6vkQhkYpuyAhszd2NoEvznP6WcslN3pd8wmhexeEx+zt2Fx
 0wBNbyof0CYc8JTnadCPJOJ5uWl3AJ07zpaZMCFDGQfgatJaXpbeIwQXS1yLbFymjyQwXT3nFoE
 ztbDgbspqfWzLqxw7yF+AbKs62conDoeghDy0Ajorh1X2alO+/8DnmR/8L1O8md2KoSOymfbHfS
 76xvYBCVlCk2qQ2W4qQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA5MiBTYWx0ZWRfXwGcnWV3sunVa
 p5qgBIgxs9Ecwz9ltujQjywpFxW+FBW5poEMCSNpCN6U/m+OA6XPCDxW1jgxEGc//vgQq1+E6Bq
 gDJnQigTIa/1WA7ZVUE7wg832FmU/lQ=
X-Proofpoint-GUID: I-znb6DrbVu6-RbYbz0pYYoIi718ZdX8
X-Authority-Analysis: v=2.4 cv=YJMKWhGx c=1 sm=1 tr=0 ts=6b04c9f5 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=03ozwUkBphtHgyqjj1sw:22 a=wjE4qe255kbLy1X9BfwA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: I-znb6DrbVu6-RbYbz0pYYoIi718ZdX8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_05,2026-11-23_01,2025-10-01_01

On Sat, Nov 21, 2026 at 07:32:15PM +0100, Michal Luczaj wrote:
> On 11/18/26 02:34, Bobby Eshleman wrote:
> > vsock_connect() sleeps with the socket unlocked. Meanwhile the transport
> > can complete the handshake, setting sock->state to SS_CONNECTED, and then
> > reset the connection, e.g. in vhost_vsock_reset_orphans(),
> > virtio_vsock_reset_sock() or vmci_transport_handle_detach(). When
> > connect() gets the lock back, it finds sk_err set and moves the socket
> > back to SS_UNCONNECTED. Userspace can then connect() the socket again,
> > and a connect() to a CID on another transport makes
> > vsock_assign_transport() release the transport the socket was connected
> > on.
> > 
> > Only move the socket back to SS_UNCONNECTED if it is still
> > SS_CONNECTING. A socket that got connected stays SS_CONNECTED, and
> > another connect() fails with -EISCONN.
> > 
> > Likewise, only move sk_state to TCP_CLOSE if it is still TCP_SYN_SENT.
> > Otherwise a second thread blocked in connect() on the same socket can
> > time out after the first one failed and called listen(), and overwrite
> > TCP_LISTEN.
> 
> Ohh, this took me a while.
> 
> > +/* Avoid breaking the socket when another thread has changed its state while
> > + * we were asleep.
> > + */
> > +static void vsock_connect_close(struct socket *sock)
> > +{
> > +	struct sock *sk = sock->sk;
> > +
> > +	if (sk->sk_state == TCP_SYN_SENT)
> > +		sk->sk_state = TCP_CLOSE;
> > +	if (sock->state == SS_CONNECTING)
> > +		sock->state = SS_UNCONNECTED;
> > +}
> 
> I was wondering why not
> 
> 	if (sk->sk_state == TCP_SYN_SENT) {
> 		sk->sk_state = TCP_CLOSE;
> 		sock->state = SS_UNCONNECTED;
> 	}
> 
> and I think the only reasons we can't say "SYN_SENT iff CONNECTING" is
> because shutdown() can flip SYN_SENT/CONNECTING to SYN_SENT/DISCONNECTING.
> On connect's failure, the blocking path kinda-ignores such shutdown() and
> resets the socket to UNCONNECTED anyway, while the non-blocking (i.e.
> vsock_connect_timeout()) also consults sk_shutdown != SHUTDOWN_MASK.
> 
> So how about being consistent:
> 
> static void vsock_connect_close(struct socket *sock)
> {
> 	struct sock *sk = sock->sk;
> 
> 	// we follow vsock_connect_timeout():
> 	// TCP_SYN_SENT implies SS_{DIS,}CONNECTING;
> 	// and we do check sk_shutdown
> 	//
> 	// or am I missing something?
> 
> 	if (sk->sk_state == TCP_SYN_SENT &&
> 	    sk->sk_shutdown != SHUTDOWN_MASK) {
> 		sk->sk_state = TCP_CLOSE;
> 		sock->state = SS_UNCONNECTED;
> 	}
> }
> 
> What do you think?

I think we could say TCP_SYN_SENT implies SS_{DIS,}CONNECTING, but
probably not the reverse... without a peer on the other end our connect
request gets an RST reply, switching to TCP_CLOSE but leaving untouched
SS_CONNECTING. Using only TCP_SYN_SENT then skips resetting
SS_CONNECTING to SS_UNCONNECTED, and future connect() retries hit
-EALREADY forever.

It seems to work for vsock_connect_timeout() because that function only
needs to test if the attempt to connect is still pending (if yes, then
close everything up), but vsock_connect_close() needs to know more
precisely if the socket still holds the state that this current connect
attempt changed... so it separately checks "Did we set TCP_SYN_SENT? if
so, set to TCP_CLOSE.  Did we set SS_CONNECTING?  If so, set to
SS_UNCONNECTED."

I think it might even make more sense to consolidate in the other
direction and make vsock_connect_timeout() a caller of the new
vsock_connect_close(), since it appears there is a similar edge case
there...

connect(), O_NONBLOCK
  transport->connect()  /* OP_REQUEST */
  mod_delayed_work(connect_work)

shutdown(SHUT_RDWR)
  sock->state = SS_DISCONNECTING
  sk_shutdown = SHUTDOWN_MASK

vsock_connect_timeout()
  skips the socket because of SHUTDOWN_MASK
  /* still TCP_SYN_SENT / SS_DISCONNECTING */

late OP_RESPONSE, virtio_transport_recv_connecting()
  sk_state = TCP_ESTABLISHED
  sock->state = SS_CONNECTED
  vsock_insert_connected()

So the attempt never times out, and a late OP_RESPONSE connects a
socket the user already shut down, overwriting SS_DISCONNECTING with
SS_CONNECTED. I think that's a separate bug for a separate patch,
though.

Or am I off track / missing something?

> 
> I guess this approach also addresses "[Severity: Low] What happens if
> another thread calls shutdown() while a blocking connect() is asleep?". As
> for "[Severity: Medium] Can a connect() waiter that times out late still
> abort a newer connect attempt on the same socket?", isn't this the current
> situation?
> 
> thanks,
> Michal

Yeah, Sashiko is worried that a racing shutdown() breaks reusing the
socket, but AFAIK vsock doesn't support reuse after shutdown anyway.
Before this patch a second connect() could succeed, but the shutdown
flags are never cleared, so sendmsg() still returns -EPIPE and recvmsg()
returns 0. With this patch the socket stays SS_DISCONNECTING, so
connect() fails with -EINVAL instead.

And agreed about the medium issue, the late connect() waiter race is no
different than before this patch.

Thanks,
Bobby
