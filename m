Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793392261;
	b=P78w3Qpu6QOfERmB9L3fad57G6TsHWViQcqIhnBwt1OfRRoTlPQI7EKLcMMOxStF9T2/
	 a5jQVKdbwqXiw8YyYsb3PN+40AVdFcaRTjTG1+mg0JpIs7VBNSGcH68IKr+d9AmR78n+u
	 Xc+9TQbV7QsZiLsk2B7WKdtapM7dADpkNASQ1jhpBcs11XQhvn7TU8m8/FkqcphWGT05A
	 ViKF2GC9SmMUl6HHbAn9LE07Zk9+kinv82fwPFQ+9Q5s41afBST7UNseaxiafzjO4N5+a
	 1jbiWY2jYBI4QTGK0B/Z75Vkk5CX6UO5qYmJk2ZBFAgr2fK1A0ciE4DhtLPQNny+jDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793392261;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 CC:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Originating-IP:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version;
	bh=PunFyZW/30a+kuyc67KGszLqyQv1/BfkX7hCjwAirrc=;
	b=2r9YJwjs1sNjsipZnvMPoRcyRbo+CaiefV9IbFsJyS5BFJOpYTLqe1qTgBcb2oRy+Eht
	 PY7KsPDps//tFM491mR8ybihhWgeX2sCLdHe2Ufgh6J/QV6UbVta+bgJoFE9SvLZdK82r
	 0VXRG/QkCdgg8VtUlilsSD3XZ6XNAvtB6gdJUSotppQnu+iZ+TsuxY8DVP7yJzc3VLAL5
	 X/Yw//yTE56buezXiVg57kurIrg9VIqAw3091TTQTalLkCXzNM/xqMebnLubqlztd9z52
	 qhunzQiWFPX93lQpT6gki6qk03MkmRN3QRGz0yXr+Z3vK729+M90koWW7PGIS+NIm6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=CDBF4R0s;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22665606A31A
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 20:31:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22665606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=CDBF4R0s
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UHxBY83674304;
	Fri, 30 Oct 2026 13:30:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=PunFyZW/30a
	+kuyc67KGszLqyQv1/BfkX7hCjwAirrc=; b=CDBF4R0s9hM+Ea7IMLSiaRsTxDZ
	quio+vsBvOgVgH7k89sHccXF8cXSX9Wu69eM50YxI9R/TJQJ8RbO2pOLlDoHmy3F
	qKtOBLkbNWfS2YRUMApKnKH40RlYPg3nxiUA4W38mzSKlrSSAx5Pwspwa9uoVX14
	5zfZOPM5RjizWLDi20B29DwOUwpvdFW0kz1tzqBooSxza00XhfgYiafpS45fj6PG
	Ei/b5oAmUMBmTx7NDIn/Hd1hwPYEP6SJHP8YRo7fjjXqHW/mV7TniML0O8CSjzM5
	sMX2+7u7PIDlKOr9Ssi+DPfNfshwL4NqUSElPNgUgMOZNr4NZPT74z2UKfw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hme63fnun-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 30 Oct 2026 13:30:26 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:fe::f072) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Fri, 30 Oct
 2026 20:30:25 +0000
Date: Fri, 30 Oct 2026 13:30:24 -0700
From: Bobby Eshleman <bobbyeshleman@meta.com>
To: Michal Luczaj <mhal@rbox.co>
CC: Stefano Garzarella <sgarzare@redhat.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Stefan Hajnoczi
	<stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang
	<jasowangio@gmail.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eugenio
 =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        Shuah Khan
	<shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
        Donald Hunter
	<donald.hunter@gmail.com>,
        Eric Dumazet <edumazet@kernel.org>, <virtualization@lists.linux.dev>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <sargun@sargun.me>,
        <jlinbox@meta.com>
Subject: Re: [PATCH net-next v4 4/7] vsock: add a netlink command to assign
 the g2h device to a netns
Message-ID: <auT+YIawHSMPHbJI@devvm29614.prn0.facebook.com>
References: <20261020-vsock-guest-ns-v4-0-047527cfccfc@meta.com>
 <20261020-vsock-guest-ns-v4-4-047527cfccfc@meta.com>
 <atjZZP2ebhXKzMxL@sgarzare-redhat>
 <atld3+5LKmGxJ8+s@devvm29614.prn0.facebook.com>
 <atnjOZjKUBagRVWq@sgarzare-redhat>
 <d946003a-8bec-4e8b-89a3-05eeb96780cc@rbox.co>
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
In-Reply-To: <d946003a-8bec-4e8b-89a3-05eeb96780cc@rbox.co>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4MSBTYWx0ZWRfX+u8t3xPcK3Uy
 So3oF9phiOG+8ojVRe7MR4HP4ySg8uFKCHxq4CJMxeBrqsSpTk2sbDrDBEBnL/5uP8iK+UCj5Dr
 O2UVoq4zX0VCVgHvGXmS/4RB/W4K9kk=
X-Proofpoint-ORIG-GUID: SI97KzjvKEBjGtzT_r0z5xUn00r9BRfJ
X-Authority-Analysis: v=2.4 cv=Mbv5KJ/f c=1 sm=1 tr=0 ts=6ae4fe62 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=JnKecZnUtZousrUlYMGU:22 a=xYO5Uv-UIaOSZ6Su2S0A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4MSBTYWx0ZWRfX89pfh9+x+N7/
 9tCBN5hdBCjSCETHefDSnTYmixNoa043R36J17ev2Q8xfZdSf+ULWkYcWNPfWJdz/jNZh22jVyt
 7BZwb0ywCLU74DW6rGSLBR1PaT+GPzWZ+SdMmdBNM/yYPIgppA4NoMlKQFmw0xRPWEKOmqSTHvB
 5fREQTcgUcbu4wrErS/+fjZm4xFyWLDOsAx5eOXqPVKlsQdY1sP/CQ2B1Ue0qde50YuuX7QDcrZ
 fTsIDkKsy7gLXetWuYqcu2OT5tXHZgdtGGXDqfCWdMpa4ZrKInDxzQQIoZ0BMWU6KgAUsml823g
 pakFktNTQ5aEuMzMy+CLFCJ9cyKD1eLhBLwbkdF/RiIRFsoQ0V7RmRg0EXF5UBopPI/50rAqPYT
 STGbbTj3RBMPkHz9TLubQLvt6Zay5HuRDmnPBXIpU/ocBhrrerBhpG8/pBqyFF/3L7qTREilCzm
 LhqgKa3NJT/Ai1rH0Vg==
X-Proofpoint-GUID: SI97KzjvKEBjGtzT_r0z5xUn00r9BRfJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01

On Thu, Oct 29, 2026 at 10:39:50PM +0100, Michal Luczaj wrote:
> On 10/22/26 12:47, Stefano Garzarella wrote:
> >>>> +/* Move @vsk to TCP_ESTABLISHED and into the connected table, unless the device
> >>>> + * has moved to a namespace @vsk cannot reach. Returns false without doing
> >>>> + * either in that case.
> >>>> + *
> >>>> + * The reset sweep walks the same table under the same lock, so an assign
> >>>> + * cannot land between the check and the insert: either the sweep finds @vsk
> >>>> + * and closes it, or @vsk is never added.
> >>>> + */
> >>>> +bool vsock_maybe_set_connected(struct vsock_sock *vsk)
> >>>> +{
> >>>> +	struct list_head *list;
> >>>> +	bool reachable;
> >>>> +
> >>>> +	list = vsock_connected_sockets(&vsk->remote_addr, &vsk->local_addr);
> >>>> +
> >>>> +	spin_lock_bh(&vsock_table_lock);
> >>>> +	reachable = vsock_g2h_reachable_sk(vsk);
> >>>> +	if (reachable) {
> >>>> +		sk_vsock(vsk)->sk_state = TCP_ESTABLISHED;
> >>>> +		__vsock_insert_connected(list, vsk);
> >>>> +	}
> >>>> +	spin_unlock_bh(&vsock_table_lock);
> >>>> +
> >>>> +	return reachable;
> >>>> +}
> >>>> +EXPORT_SYMBOL_GPL(vsock_maybe_set_connected);
> >>>> +
> >>>> +static bool vsock_g2h_should_reset(struct vsock_sock *vsk,
> >>>> +				   const struct vsock_transport *t)
> >>>> +{
> >>>> +	return vsk->transport == t &&
> >>>> +	       READ_ONCE(sk_vsock(vsk)->sk_state) != TCP_CLOSE &&
> >>>> +	       !READ_ONCE(vsk->close_work_scheduled) &&
> >>>> +	       !vsock_g2h_reachable_sk(vsk);
> >>>> +}
> >>>> +
> >>>> +static struct vsock_sock *
> >>>> +vsock_g2h_next_unreachable(const struct vsock_transport *t, unsigned int *i)
> >>>> +{
> >>>> +	struct vsock_sock *vsk;
> >>>> +
> >>>> +	spin_lock_bh(&vsock_table_lock);
> >>>> +
> >>>> +	for (; *i < ARRAY_SIZE(vsock_connected_table); (*i)++) {
> >>>> +		list_for_each_entry(vsk, &vsock_connected_table[*i],
> >>>> +				    connected_table) {
> >>>> +			if (vsock_g2h_should_reset(vsk, t)) {
> >>>> +				sock_hold(sk_vsock(vsk));
> >>>> +				spin_unlock_bh(&vsock_table_lock);
> >>>> +				return vsk;
> >>>> +			}
> >>>> +		}
> >>>> +	}
> >>>> +
> >>>> +	spin_unlock_bh(&vsock_table_lock);
> >>>> +
> >>>> +	return NULL;
> >>>> +}
> >>>> +
> >>>> +/* Close every connected socket of @t that can no longer reach the g2h device.
> >>>> + */
> >>>> +static void vsock_g2h_reset_unreachable(const struct vsock_transport *t)
> >>>> +{
> >>>> +	struct vsock_sock *vsk;
> >>>> +	unsigned int i = 0;
> >>>> +	struct sock *sk;
> >>>> +	bool reset;
> >>>> +
> >>>> +	lockdep_assert_held(&vsock_g2h_assign_mutex);
> >>>> +	lockdep_assert_not_held(&vsock_register_mutex);
> >>>> +
> >>>> +	while ((vsk = vsock_g2h_next_unreachable(t, &i))) {
> >>>
> >>> can we reuse vsock_for_each_connected_socket() ?
> >>>
> >>> If not, maybe a comment here will be nice and maybe I'll try to merge
> >>> vsock_g2h_next_unreachable() here if it's not used somewhere else.
> >>
> >> I think we would need a variant that returns the socket, since we need
> >> to be able to acquire the lock_sock after releasing the
> >> vsock_table_lock.
> > 
> > That would be nice if it's not too complicated.
> > 
> >>
> >> Maybe the callback could return a bool, if true then return socket
> >> otherwise skip. Then the cb could also grab the sock_hold ref under the
> >> table lock.
> > 
> > Yeah, looks promising to me!
> > 
> >>
> >>>
> >>> I find these functions a bit hard to read.
> >>
> >> Yeah its all kind of a pain. The problem is that we need to hold
> >> sock_lock to set sk_state and sk_err, but can't acquire it under the
> >> table lock. Instead, we grab the socket ref sock_hold under the table
> >> lock to guarantee it stays alive between releasing the table lock and
> >> grabbing the socket lock.
> >>
> >> I was really tempted to not do this lock_sock dance though. The race
> >> condition I'm avoiding here is that if this reset races with an RST
> >> receive, then the socket could end up with TCP_CLOSING + sk_err
> >> ECONNRESET... but I'm not sure this actually propagates up into a real
> >> problem for any potential user.
> 
> Right, vsock_connect() is fragile. Two things to be cautious about:
> 1. Don't let it reset the already connected socket. Because that would
> allow user to "re-connect()" and make mess in connected_table.
> 2. Don't let it re-assign transport of an already connected socket. Because
> that breaks the contract in few places.
> 
> State 1 is not an issue: vsock_g2h_reset_unreachable() calls
> __vsock_remove_connected().
> 
> State 2 may be problematic: if vsock_g2h_reset_unreachable() sets TCP_CLOSE
> when connect() is scheduled out, then after the wake-up sock may get reset
> to SS_UNCONNECTED. Then user re-connect()s and hits the transport
> re-assignment logic. I'm worried that, as we re-assign, someone may be
> holding a reference to such "connected" (even if not in connected_table
> anymore) vsock.

I see path you're looking at... after vsock_connect() gets scheduled
back in we set TCP_CLOSE/SS_UNCONNECTED if sock_error returns non-zero.
Could you elaborate on your last concern there about someone holding a
reference? I'm not sure I fully understood.

> 
> So I don't know, maybe it's vsock_connect() that should be fixed/hardened
> instead?
> 
> Or at least disallow transport *re*-assignment? Does the "re-" part have a
> use case?
> 
> Hope it's not too off-topic.
> 
> >> It also avoided some racing with the tx path, but now that send_pkt()
> >> also checks reachability I think that path is safe.
> >>
> >> What do you think about doing the below hunk (TCP_CLOSE, ECONNRESET,
> >> sk_error_report) with no lock_sock?
> > 
> > Looking at the code, it seems that in all the places where we close all 
> > connections (virtio_vsock_reset_sock, vhost_vsock_reset_orphans) we do 
> > with no lock_sock but with vsock_table_lock.
> > 
> > So, makes sense to me.
> 
> virtio_vsock_reset_sock() and vhost_vsock_reset_orphans() are my pet
> peeves: state switcheroo without taking lock_sock(). Which, again, races
> vsock_connect().

True, I don't love that either, but I feel the impact is at least
constrained by the fact that it only happens when the module or device
is already going away.

Best,
Bobby
