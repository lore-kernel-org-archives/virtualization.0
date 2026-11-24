Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795552247;
	b=MaE4WxxRkehTugywnLmzD7Ck8wAhbzHVWenWBhEd9I9V3x8w1YqrYOKQSmLKflsVRtqD
	 tcibQn+Ygjp0rGsblQx1xyOMFr3PnAZdtxBkoixcLKR667jeCBFPWVW5E6uyGUWJT9qUG
	 jyV5wF/WRmt6rdYD+22k3T0l+jKLVZXydG1vP8riIvQOO2LUWEle0BZj0PgKVyoBhp4dS
	 PYfTmBRfIBcK5hMpm48zcyIwH8qb/fY1vs22QGzePqD5p8CXUf9SosnNMoTnmSBizR8Ze
	 mL4LDP2yjDNXh81vgWPs3jW00N1c0Z4bAjQNZ8oqQalBZmnXF6wN9lwXnZSTAxP5/PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795552247;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 CC:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Originating-IP:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version;
	bh=iswGJYDERYr+zAWg75b8sg5Zn4Dv7nFZ+rihAnJo3tM=;
	b=AkU01/52OGjDklz1deh99uEJZdLM3+Hu8UafgLX4iqtZysemiGmqfPdRQsM5ahDgZXZW
	 1wWfJHlIRbOf8u3dUQ4QVMsTntOC+u6bAGVZqMVwOcfQ/jEcsGUAqPSwIfW6ylHTEz+EG
	 nz6Owl3Yt7ibdSmTrVGF49DcXjLIgTmI7d09C2xPqoKi3Y36UPE6LVECsc1g0ZPPMoGnM
	 tsOXa+myCXtDvukh4n+KqBwSSNkvW3nEs7vOKmFntLx0i6F18rDHaEsnHNQnYTAXsNfLF
	 LOcn7cg6mv7jJQ3Iz+veLih2ZukxWujAMxZ6iMmSH/KpEe6IdYHV79XXo9di4T0FYUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b="gm/dN8cG";
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A05606A323
	for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 20:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64A05606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=gm/dN8cG
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOIXVuU977599;
	Tue, 24 Nov 2026 12:30:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=iswGJYDERYr
	+zAWg75b8sg5Zn4Dv7nFZ+rihAnJo3tM=; b=gm/dN8cGjBc4GQMGCJumRi1BZG9
	YPt9dAnkPwz5EGIZhd5OtTxzIbdPiIjfBr5QY8Mc0xRuqsMMjjkdb/wkRzCZmJiZ
	vS32Hj6i3Mgu/zflaJpYaKNAS+UOq7iuiLXBLMGfwFp8DJSsJzS/ZtxN6YT6ZaZ4
	XoRHhdVH3FqtnW/gyGGhqTPk2zc/H6DvMfS8be+ihtke2V9HUhtLQMtY6BKu568v
	3v6W+d/NsMi3OM10UOoIlPEdj3NGLYArOHcTYfdSK/G++WhQ2HzHC/9xpVKQFf91
	2BCz+X/VecipzS63oBUO6nRHod4O32AfAmD0t1cQTf+wE6Ypn757uSawtbw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j5dcn2k71-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 24 Nov 2026 12:30:38 -0800 (PST)
Received: from localhost (2620:10d:c085:208::f) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Tue, 24 Nov
 2026 20:30:36 +0000
Date: Tue, 24 Nov 2026 12:30:35 -0800
From: Bobby Eshleman <bobbyeshleman@meta.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: Michal Luczaj <mhal@rbox.co>, Stefano Garzarella <sgarzare@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Simon Horman <horms@kernel.org>,
        George
 Zhang <georgezhang@vmware.com>, Andy King <acking@vmware.com>,
        Dmitry
 Torokhov <dtor@vmware.com>, <virtualization@lists.linux.dev>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kyle Zeng
	<kylebot@openai.com>
Subject: Re: [PATCH net v2] vsock: only undo SS_CONNECTING when connect()
 fails
Message-ID: <awXz6yo12ZOQPE8E@devvm29614.prn0.facebook.com>
References: <20261117-vsock-connect-close-v2-1-db5388323770@meta.com>
 <ed28d36a-682e-4db5-abf4-1339734e7c57@rbox.co>
 <awTJ8EOl52W0ph1K@devvm29614.prn0.facebook.com>
 <ebb9c249-85bf-4737-841f-ab6ddcaab5a9@redhat.com>
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
In-Reply-To: <ebb9c249-85bf-4737-841f-ab6ddcaab5a9@redhat.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA4MCBTYWx0ZWRfX1XwEk7IFnqVL
 IsxEauoxA2030kImjzgsVvv73kGtN9s6cXqJh1kqtOM0Ov+1qSRbP4ALaSnNis747jWVFk4/rWf
 lF2zvnQtTnh6e/5iQKYjYe3ji9lwVe0=
X-Proofpoint-ORIG-GUID: DpeAX_CIYOBp6U1WXu6qNU39rpokBsXw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA4MCBTYWx0ZWRfX0lDTlwiTBfL/
 ZgsfVpoM8ZXQ5vsstvo27BBlhSB9k5MKdGEvIKdzNZiKxuRh8ZQJia9S6wEXd9/fxyczw334iBx
 XdkXHFBKZDRFRTI3dLSA6j4p/w2BScHptf9iQRnjdWQ4t23+wKBnYwPjXGj4Wh/EVT1AfQq0vP3
 dDjRVDEcQo34ZXTfBhZx2149bLRvJ/MR64tDyDedgbDT2OUJ9Z54LbxEYVhloEsOb9CHxC34uIh
 EpaX8F7dkuE7OGHO7AQkrzO62LhSI/yQLxaceUGNsxVdxM3KAQXtGv4pFmlT38NuWtbs91NuVqo
 suhvJOorO5uhYMQKc4HBHeM67bpkeLGVb1fJ0Lrfsr0r0Kpn5BV+Bd9un8D6JS/iAH57b0zUJBO
 k2jLQRd5XQJSmLfQIp9CZRCvSaI63a7wakmdASDfi+6WrQht81gsvISHa0wJUwU/bjsSq2/cOZ9
 Wvz0zeGZAuFFGkH2UNA==
X-Authority-Analysis: v=2.4 cv=Ku3YSmWN c=1 sm=1 tr=0 ts=6b05f3ee cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=xtH7KyWI9dI7BmFOsl-x:22 a=4zObMqdbO8GudoyobMYA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: DpeAX_CIYOBp6U1WXu6qNU39rpokBsXw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_05,2026-11-23_01,2025-10-01_01

On Tue, Nov 24, 2026 at 03:39:17PM +0100, Paolo Abeni wrote:
> On 11/24/26 00:19, Bobby Eshleman wrote:
> > On Sat, Nov 21, 2026 at 07:32:15PM +0100, Michal Luczaj wrote:
> > > On 11/18/26 02:34, Bobby Eshleman wrote:
> > > > vsock_connect() sleeps with the socket unlocked. Meanwhile the transport
> > > > can complete the handshake, setting sock->state to SS_CONNECTED, and then
> > > > reset the connection, e.g. in vhost_vsock_reset_orphans(),
> > > > virtio_vsock_reset_sock() or vmci_transport_handle_detach(). When
> > > > connect() gets the lock back, it finds sk_err set and moves the socket
> > > > back to SS_UNCONNECTED. Userspace can then connect() the socket again,
> > > > and a connect() to a CID on another transport makes
> > > > vsock_assign_transport() release the transport the socket was connected
> > > > on.
> > > > 
> > > > Only move the socket back to SS_UNCONNECTED if it is still
> > > > SS_CONNECTING. A socket that got connected stays SS_CONNECTED, and
> > > > another connect() fails with -EISCONN.
> > > > 
> > > > Likewise, only move sk_state to TCP_CLOSE if it is still TCP_SYN_SENT.
> > > > Otherwise a second thread blocked in connect() on the same socket can
> > > > time out after the first one failed and called listen(), and overwrite
> > > > TCP_LISTEN.
> > > 
> > > Ohh, this took me a while.
> > > 
> > > > +/* Avoid breaking the socket when another thread has changed its state while
> > > > + * we were asleep.
> > > > + */
> > > > +static void vsock_connect_close(struct socket *sock)
> > > > +{
> > > > +	struct sock *sk = sock->sk;
> > > > +
> > > > +	if (sk->sk_state == TCP_SYN_SENT)
> > > > +		sk->sk_state = TCP_CLOSE;
> > > > +	if (sock->state == SS_CONNECTING)
> > > > +		sock->state = SS_UNCONNECTED;
> > > > +}
> > > 
> > > I was wondering why not
> > > 
> > > 	if (sk->sk_state == TCP_SYN_SENT) {
> > > 		sk->sk_state = TCP_CLOSE;
> > > 		sock->state = SS_UNCONNECTED;
> > > 	}
> > > 
> > > and I think the only reasons we can't say "SYN_SENT iff CONNECTING" is
> > > because shutdown() can flip SYN_SENT/CONNECTING to SYN_SENT/DISCONNECTING.
> > > On connect's failure, the blocking path kinda-ignores such shutdown() and
> > > resets the socket to UNCONNECTED anyway, while the non-blocking (i.e.
> > > vsock_connect_timeout()) also consults sk_shutdown != SHUTDOWN_MASK.
> > > 
> > > So how about being consistent:
> > > 
> > > static void vsock_connect_close(struct socket *sock)
> > > {
> > > 	struct sock *sk = sock->sk;
> > > 
> > > 	// we follow vsock_connect_timeout():
> > > 	// TCP_SYN_SENT implies SS_{DIS,}CONNECTING;
> > > 	// and we do check sk_shutdown
> > > 	//
> > > 	// or am I missing something?
> > > 
> > > 	if (sk->sk_state == TCP_SYN_SENT &&
> > > 	    sk->sk_shutdown != SHUTDOWN_MASK) {
> > > 		sk->sk_state = TCP_CLOSE;
> > > 		sock->state = SS_UNCONNECTED;
> > > 	}
> > > }
> > > 
> > > What do you think?
> > 
> > I think we could say TCP_SYN_SENT implies SS_{DIS,}CONNECTING, but
> > probably not the reverse... without a peer on the other end our connect
> > request gets an RST reply, switching to TCP_CLOSE but leaving untouched
> > SS_CONNECTING. Using only TCP_SYN_SENT then skips resetting
> > SS_CONNECTING to SS_UNCONNECTED, and future connect() retries hit
> > -EALREADY forever.
> > 
> > It seems to work for vsock_connect_timeout() because that function only
> > needs to test if the attempt to connect is still pending (if yes, then
> > close everything up), but vsock_connect_close() needs to know more
> > precisely if the socket still holds the state that this current connect
> > attempt changed... so it separately checks "Did we set TCP_SYN_SENT? if
> > so, set to TCP_CLOSE.  Did we set SS_CONNECTING?  If so, set to
> > SS_UNCONNECTED."
> > 
> > I think it might even make more sense to consolidate in the other
> > direction and make vsock_connect_timeout() a caller of the new
> > vsock_connect_close(), since it appears there is a similar edge case
> > there...
> > 
> > connect(), O_NONBLOCK
> >    transport->connect()  /* OP_REQUEST */
> >    mod_delayed_work(connect_work)
> > 
> > shutdown(SHUT_RDWR)
> >    sock->state = SS_DISCONNECTING
> >    sk_shutdown = SHUTDOWN_MASK
> > 
> > vsock_connect_timeout()
> >    skips the socket because of SHUTDOWN_MASK
> >    /* still TCP_SYN_SENT / SS_DISCONNECTING */
> > 
> > late OP_RESPONSE, virtio_transport_recv_connecting()
> >    sk_state = TCP_ESTABLISHED
> >    sock->state = SS_CONNECTED
> >    vsock_insert_connected()
> > 
> > So the attempt never times out, and a late OP_RESPONSE connects a
> > socket the user already shut down, overwriting SS_DISCONNECTING with
> > SS_CONNECTED. I think that's a separate bug for a separate patch,
> > though.
> > 
> > Or am I off track / missing something?
> I have slightly different question: is the 'multiple threads
> connecting/disconnecting the same socket concurrently' a
> relevant scenario? Otherwise if final state is self-consistent
> (i.e. _NOT_ TCP_SYN_SENT + SS_DISCONNECTING) I think there is
> nothing to fix here.
> 
> /P

To your point, the only user-facing issue I can see with
vsock_connect_timeout() would be seen in pretty rare cases.... Since it
skips the socket when sk_shutdown == SHUTDOWN_MASK, if the peer never
responds with RST the connect attempt never times out, the socket sits
in TCP_SYN_SENT + SS_DISCONNECTING (connect() returning -EINVAL) until
close(). But I'm pretty sure this could only happen on the vhost side if
the guest was unresponsive/crashed or on the virtio side if maybe
vhost's RST dropped during VM migration when vhost's send queue is
purged. IMHO this should probably be fixed, but I don't think its worth
turning the code upside down for.

Looking at this connect()/shutdown() sequence again today... with
O_NONBLOCK, there is some inconsistent behavior that although is not
caused by vsock_connect_timeout(), I'd like to mention here since its
come up. It exists even for a single thread making both calls. Playing
w/ vsock_loopback and bpftrace, it does end up with SS_DISCONNECTING +
TCP_SYN_SENT, but I think the most unexpected thing from the user's
perspective is that it temporarily flips to SS_CONNECTED even after
shutdown() and a number of syscalls present the socket as connected:

  repro    connect()     -> -EINPROGRESS  SS_CONNECTING     TCP_SYN_SENT
  repro    shutdown()    -> 0             SS_DISCONNECTING  TCP_SYN_SENT
  repro    getpeername() -> -ENOTCONN     SS_DISCONNECTING  TCP_SYN_SENT
  repro    connect()     -> -EINVAL       SS_DISCONNECTING  TCP_SYN_SENT
  repro    recv()        -> -ENOTCONN     SS_DISCONNECTING  TCP_SYN_SENT
  repro    SO_ERROR      =  0
  repro    poll()        -> IN|HUP|RDHUP  SS_DISCONNECTING  TCP_SYN_SENT
  kworker  recv_pkt(OP_RESPONSE)          SS_CONNECTED      TCP_ESTABLISHED
  ^ the switch to connected is here

  repro    getpeername() -> 0             SS_CONNECTED      TCP_ESTABLISHED
  repro    connect()     -> -EISCONN      SS_CONNECTED      TCP_ESTABLISHED
  repro    recv()        -> 0             SS_CONNECTED      TCP_ESTABLISHED
  repro    SO_ERROR      =  0
  ^ the socket starts partially acting like it's connected/established

  repro    poll()        -> IN|HUP|RDHUP  SS_CONNECTED      TCP_ESTABLISHED
  kworker  recv_pkt(OP_RST)               SS_CONNECTED      TCP_CLOSING
  ^ eventually RST shows up and shuts things down

TCP handles this better... shutdown() on SYN_SENT socket aborts the
connect attempt w/ tcp_disconnect() resulting in TCP_CLOSE,
SS_UNCONNECTED, sk_err = ECONNRESET, and the late SYN-ACK doesn't push
it into established, and users see POLLERR/SO_ERROR.

I think the TCP approach also fixes that edge case with
vsock_connect_timeout(), since the user would at least see the errors.

Best,
Bobby
