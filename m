Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795201248;
	b=WO/7G0F1d4X390bFQOse3TJztSaCZM4uSa9jRE3Gvhio8cIOjR6lmxq9Mvh0V5TSqQx3
	 D6A6UXN0d84ZV+kxkhx5Mr30YTtJzVAzJI4n7CyYlLwj0dbldJSkCSDtdMhEbZD0Ym6BA
	 MC5suhZhoDS1YxLAZrvQmGEz2/CQbymdUOODMYIsJNJLHPL5JIpzWUlMyId8C2zynJ2lA
	 UCNhDuZ/VrsZg6gEeox74PoIzYygfCehExK0Awte5nZBzX1ObPjz+XACbFZM04EFy7dlO
	 fkwJAy4p+UWatBdZwV40lcWH0kT+OKrFVoVCibdF4TM0IeHfYLkaooPG4wqaxyTmCVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795201248;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 CC:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Originating-IP:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version;
	bh=4lpNV2jmhoKFdDPX/CDwLD6+HSpFiqIgbtHFCV1Iw9s=;
	b=eWpGpReFC5TPGdg0W3p/FX+xnl/LvIT4iUK7ux1wqsjQg9EITKCQZb0AB3VRiEpyFsN0
	 5rT6ltiiF2FpcLjTe3G4HFNOi26xIyGvAAHmccRr50eFJK4PBKv4fgsFfMKD9zm0Fo0mD
	 R+uYWwZzHHDfvaCpBIBATOAagj6vChmSgUkZGZuqQN7bFVdLlAXlOs2oCpw2AiP8cOcV5
	 lt1SsNtwC4y2oGx0l0vds+gcjfwpM5A+8MP8czIWA6Sa5rjJufh8AyxLjviuaM+I6EHCD
	 JFyZARnVvtRt6/I8/70M7QGWucvIyc3f3fWWXOjrf3SjgpsnUaK7gt7fDAmYlBy9YJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=UsjNcrb9;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4B160A2635;
	Fri, 20 Nov 2026 19:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E4B160A2635
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=UsjNcrb9
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKGrwLe650468;
	Fri, 20 Nov 2026 11:00:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=4lpNV2jmhoK
	FdDPX/CDwLD6+HSpFiqIgbtHFCV1Iw9s=; b=UsjNcrb9daup5TMZLVT3bUxcrBv
	H5Y52ZXvrpPnjdagi77cZygAkp3D+scjxj69oV53Rm17MxeA11+APc+VezwEHURb
	WjfBlj2GaVlA571w3/+jc9it1nus9IahzTcW9UPXJKoHuABz5GyYlTZBtfbdLse+
	NcZzTHx9d0+93gBSDwp56XOOw2dEInBT7/UYil0eTERWL0XFsbNsXGg3Y0LtC+R1
	uxfgVg3abQKpNeBPjSuGn7C0S19Q4uGW8dIwPZGgerQFkEWGQnydP9mgr4iUj3To
	EKsE8ykrNvnZyPO0NObmvD1JlvPOvAHFspq4ifjXlByKmi412+3Z+8P4inw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j2t4ks2au-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 20 Nov 2026 11:00:44 -0800 (PST)
Received: from localhost (2620:10d:c0a8:1b::30) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Fri, 20 Nov
 2026 19:00:42 +0000
Date: Fri, 20 Nov 2026 11:00:41 -0800
From: Bobby Eshleman <bobbyeshleman@meta.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <virtualization@lists.linux.dev>, <kvm@vger.kernel.org>,
        "Michael S.
 Tsirkin" <mst@redhat.com>,
        Eugenio Perez <eperezma@redhat.com>
Subject: Re: [PATCH net-next v7 4/7] vsock: add a netlink command to assign
 the g2h device to a netns
Message-ID: <awCY2UrEthUvfihw@devvm29614.prn0.facebook.com>
References: <20261117-vsock-guest-ns-v7-0-7e522ea9dd9b@meta.com>
 <20261117-vsock-guest-ns-v7-4-7e522ea9dd9b@meta.com>
 <sashiko-outbox-222310@kernel.org>
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
In-Reply-To: <sashiko-outbox-222310@kernel.org>
X-Proofpoint-GUID: h-WS7pbn4eeYsfvf9CVS1nyMHZiSTbmv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3NSBTYWx0ZWRfX2I4XJmqEmoUc
 eKUN/Wk6bnr1/QgzweUAZmZOf6uOwr0FrYprUWa5JyDPGK/G19rdSaIf+dZ+w4HgNCUNrOempMQ
 PJa9XhvE1zL9hda/cVBrNuhBKF5Q6q99Bt5ZWtxXOZmwnb5yDUDdx7j/k3kGg+RWHKf0cz7dwBP
 lZAURflCV+UJgg5AIo7dKrTLI528jqOTIqBAjh0bPYstYOM1oZyjq01Z68TvWaZ59qDgTOK9lVh
 Vs5MP+gcNOAJ3CULzM8kZm0XjU9HWcEpqHl1etTpW5LU8JBlEtBmGCeCKFAvUxE2kbrOwJpz1xi
 ZlXaZXXw5bcMHw0U79DM8qBCaUJv6VFt4cgzXzAWWcZEDKvuzxbisz6U/1PRD/tNC1OIYOYnie3
 SrQTsfpcLMhY2LFmvez1aU/IBGFOJC/n2P1w+tNjBWbsoZsAtqQpN8G/wyd3mDA7BjgLbDbofT+
 dNCiyaXIyWqNHLatxow==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3NSBTYWx0ZWRfX3TR+u+180G8r
 NecHghQNIInc2c7DRH6HSzXm95OWZj4jdoGgxDkrRslzOm0LnKaA0uVx1CSmogggCcMS05mr3Ks
 CObdekvTihWPFiIHMXSqcJJD4s5jK0A=
X-Proofpoint-ORIG-GUID: h-WS7pbn4eeYsfvf9CVS1nyMHZiSTbmv
X-Authority-Analysis: v=2.4 cv=HZyB3SE8 c=1 sm=1 tr=0 ts=6b0098dc cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=8elwO82fXORLTBIkMd32:22 a=VwQbUJbxAAAA:8
 a=nKUyGthK1eciPSpQ-oIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01

On Thu, Nov 19, 2026 at 01:55:35AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [Medium] vsock: swept sockets lose seqpacket data and return EOF
>   instead of ECONNRESET
> - [Medium] vsock: vsock_shutdown() clears SOCK_DONE on swept sockets in
>   connected table
> --

I'm going to respin this and there will be some changes that I think
will resolve this back-and-forth with sashiko.

Replying below to explain what the next rev will do differently, to give
context for review when that comes out.

pw-bot: cr

[...]

> 
> [Severity: Medium]
> Can calling shutdown() on a swept socket clear SOCK_DONE and cause
> vsock_g2h_should_reset() to match it again?
> 
> When vsock_g2h_reset_unreachable() sweeps a socket that has unread data
> queued, it leaves the socket in vsock_connected_table with sk->sk_state set
> to TCP_ESTABLISHED and relies on SOCK_DONE to prevent
> vsock_g2h_should_reset() from matching it again.  However, vsock_shutdown()
> unconditionally clears SOCK_DONE whenever sock->state is not SS_UNCONNECTED:
> 
> net/vmw_vsock/af_vsock.c:vsock_shutdown() {
> 	...
> 	if (sock->state == SS_UNCONNECTED) {
> 		err = -ENOTCONN;
> 		if (sock_type_connectible(sk->sk_type))
> 			goto out;
> 	} else {
> 		sock->state = SS_DISCONNECTING;
> 		err = 0;
> 	}
> 
> 	/* Receive and send shutdowns are treated alike. */
> 	mode = mode & (RCV_SHUTDOWN | SEND_SHUTDOWN);
> 	if (mode) {
> 		...
> 		if (sock_type_connectible(sk->sk_type)) {
> 			sock_reset_flag(sk, SOCK_DONE);
> 			vsock_send_shutdown(sk, mode);
> 		}
> 	}
> }
> 
> Because vsock_next_connected_socket() restarts from the head of the current
> bucket on each iteration, a process calling shutdown() on its swept socket
> makes vsock_g2h_should_reset() true again and re-matches the same socket in a
> loop under vsock_g2h_assign_mutex.  On a swept socket with sk->sk_state set
> to TCP_CLOSING, clearing SOCK_DONE also causes subsequent recvmsg() calls to
> return -ENOTCONN, and on a TCP_ESTABLISHED swept socket it bypasses the
> sock_flag(sk, SOCK_DONE) check in virtio_transport_recv_pkt() if the device
> later moves back to a reachable namespace.

In this series I've been trying to make the socket losing access to the
device moving to another netns equal in behavior to the socket receiving
a peer RST, which keeps sockets in TCP_ESTABLISHED and uses SOCK_DONE to
distinguish between "peer alive" and "peer reset" instead of ->sk_state.

The last several versions have been trying to get this mental model
working race and edge-case free... but the last several revisions have
just been a game of a whack-a-mole.

Instead, I think a better and simpler model is to treat the move as if
the device had been removed, the way virtio_vsock_reset_sock() already
handles a device unplug, i.e., just set TCP_CLOSE and ECONNRESET. This
problem then goes away because we aren't messing with SOCK_DONE and
shutdown won't cause this re-matching in the iterator.

> 
> > +
> > +/* Close every connected socket of @t that can no longer reach the g2h device.
> > + */
> > +static void vsock_g2h_reset_unreachable(const struct vsock_transport *t)
> > +{
> > +	struct vsock_sock *vsk;
> > +	unsigned int i = 0;
> > +	struct sock *sk;
> > +	bool reset;
> > +
> > +	lockdep_assert_held(&vsock_g2h_assign_mutex);
> > +	lockdep_assert_not_held(&vsock_register_mutex);
> > +
> > +	/* lock_sock() cannot be taken under vsock_table_lock, so pick the
> > +	 * sockets one at a time, then recheck each under both locks.
> > +	 */
> > +	while ((sk = vsock_next_connected_socket(t, &i,
> > +						 vsock_g2h_should_reset))) {
> > +		vsk = vsock_sk(sk);
> > +
> > +		lock_sock(sk);
> > +
> > +		reset = false;
> > +		spin_lock_bh(&vsock_table_lock);
> > +		/* It may have been closed since we dropped the table lock. */
> > +		if (__vsock_in_connected_table(vsk) && vsk->transport == t &&
> > +		    vsock_g2h_should_reset(vsk))
> > +			reset = true;
> > +		spin_unlock_bh(&vsock_table_lock);
> > +
> > +		if (reset) {
> > +			sock_set_flag(sk, SOCK_DONE);
> > +			WRITE_ONCE(vsk->peer_shutdown, SHUTDOWN_MASK);
> > +			/* Same as a peer reset, stay TCP_ESTABLISHED while data
> > +			 * is queued so that recv() can still read it.
> > +			 */
> > +			if (vsock_connectible_has_data(vsk) <= 0)
> > +				sk->sk_state = TCP_CLOSING;
> > +			sk->sk_err = ECONNRESET;
> > +			sk_error_report(sk);
> > +			if (t->cancel_pkt)
> > +				t->cancel_pkt(vsk);
> > +		}
> 
> [Severity: Medium]
> Does setting sk->sk_err = ECONNRESET and sk->sk_state = TCP_CLOSING here
> cause SOCK_SEQPACKET sockets to drop queued messages and empty sockets to
> return 0 instead of -ECONNRESET?
> 
> When a SOCK_SEQPACKET socket has unread messages queued at sweep time,
> sk->sk_state remains TCP_ESTABLISHED and __vsock_seqpacket_recvmsg() dequeues
> the message, but then checks sk->sk_err and overwrites the return value with
> -ECONNRESET, discarding each queued message:

Yes, this will go away when loss of netns access behaves the same as
device removal... sk_state == TCP_CLOSE with !sock_flag(sk, SOCK_DONE)
will cause recvmsg to return -ENOTCONN. If a reader is already blocked
in recvmsg() then seqpacket may return 0 / EOF. I think this will be the
right move and overall much simpler.

I'm expecting Sashiko to complain again about some of the quirks that
were there when trying this approach before: -ENOTCONN instead of
-ECONNRESET, the lockless socket-state change, and a few others... but
all of them are tractable/tolerable issues or actually belong in a
different series.

Best,
Bobby
