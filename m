Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648637;
	b=EadExJqEaW40ZzyWF0DsD8VdqZvwpV9OW4HvIyB8zBm3NtgnlzwOJc7NkR66PIa1CoZW
	 +QbUXILkVEREuhXMK6zcRu4X22hefWYEma4Yk/zWF6afsHJ7uqjeOmNjNR+mKqHnyiC79
	 A/DoTv4HZmH7EfPQt/0Xm78ShfdZWVc7/Ggy+GmA7ExlK1J3xztUmP2rzG8RDSFIsGEKH
	 61SmPLImiK4uKY+fpqeLt5ULFpeb4vh0xZIGKa5AAEH9oQSrV6Hy8qc0GYTf3K1QP7E0s
	 GMXvBN5qLfGBoTuMbkfWCsGnAenqOXUaDvpbhsCtLnMDdiDwZY00OSIusyT7f7W2lfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648637;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 CC:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Originating-IP:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version;
	bh=Xs/bknxSjUD992DcwA52sYwD2HmK67B3GQnMd3KGXmA=;
	b=4PN48Fkup+Tu87dMVHb94dVd48/8MNVHEU0uTUqdVYfHx6FTJeoSMWYnlfKWnhp++hFG
	 DSpdLxXVNYQkw5nnUrTZnRW9Mui24Mu1k3K7IUDBcL/hgCr6Z8aONrmzxL7GzDhItIE76
	 IEByVPLhGV2mcfIKlB8NnAt1c8XlsQLQB/ywqXA95F59CW1sF7J1CCn2S+UBylDyYyXKV
	 smXfaZsm/sF73Lhnw5QyuIkBQpKsYApEBgU7u5VXqNs5T+OSZ9YgQ8Rs61fYbJm5ZLAiZ
	 3Ew5gwHVcmomZ5aekEpbgQ6qexwGxGJ8Z/m9VC9WiFoL34SeVw7PappgA5FPneDZNqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=Xz6MZ6Q5;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F43A606A326
	for <virtualization@lists.linux.dev>; Mon,  2 Nov 2026 19:43:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F43A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=Xz6MZ6Q5
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2IhL6b3944200;
	Mon, 2 Nov 2026 11:43:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=Xs/bknxSjUD
	992DcwA52sYwD2HmK67B3GQnMd3KGXmA=; b=Xz6MZ6Q55LH2h5+cH8Uv9SYwyhG
	fqA0wCgtCeQ2MLDJE5lEOYNeF2tBmMxf/Ozjov+u3E3gde/WflZJDwBao7xj7sS8
	x+YiE+yvgTc53YY5b89vpl2L1l5FAQsyGao1lBjvZhO8LmPpCMJBYfR3WLhJRaz2
	Ju7xsfJ+U1/q/2/dM4jxfqRL6Ri1wUnlzo7YVwGCzoLAfU43sEFrXSNt0sPjpgP5
	gLVtCwSquAWEu6Ibk9k1YodRwN+FMA10HHh0dhV5VT1HmU1Ongvi3dFQqWf18xtd
	P9ElzdgxTJCRynqy7J0zQLiia8LoN7NTX3cEsjNE3ribWcsz5OF/7y+21Dg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hne57ca7n-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 02 Nov 2026 11:43:37 -0800 (PST)
Received: from localhost (2620:10d:c085:208::7cb7) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Mon, 2 Nov
 2026 19:43:36 +0000
Date: Mon, 2 Nov 2026 11:43:35 -0800
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
Message-ID: <aujn5/nm9f9YX6bM@devvm29614.prn0.facebook.com>
References: <20261020-vsock-guest-ns-v4-0-047527cfccfc@meta.com>
 <20261020-vsock-guest-ns-v4-4-047527cfccfc@meta.com>
 <atjZZP2ebhXKzMxL@sgarzare-redhat>
 <atld3+5LKmGxJ8+s@devvm29614.prn0.facebook.com>
 <atnjOZjKUBagRVWq@sgarzare-redhat>
 <d946003a-8bec-4e8b-89a3-05eeb96780cc@rbox.co>
 <auT+YIawHSMPHbJI@devvm29614.prn0.facebook.com>
 <5a411a67-f550-459d-be9b-5e8e51d3018c@rbox.co>
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
In-Reply-To: <5a411a67-f550-459d-be9b-5e8e51d3018c@rbox.co>
X-Proofpoint-GUID: QR2S-efKBO6QdYqmIxgc6lAyUaLaTRaV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA3OCBTYWx0ZWRfX/+ZJayM1LQ+r
 9CV/sgjbk1pFruMf2Sg0Afqz45bxdOm/q1kCI1B+bg8HW4Cjn7g4Lr79nb2RdSW2Xmzq4dF0XOW
 GqQjtLSbwrhVrlFabcgVpqZqM5ZWyic=
X-Authority-Analysis: v=2.4 cv=SJ/Xx+vH c=1 sm=1 tr=0 ts=6ae8e7e9 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=wpfVPzegXHpEFt3DAXn9:22 a=VwQbUJbxAAAA:8
 a=BjZWFOVnn3HtxxQ2TYoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: QR2S-efKBO6QdYqmIxgc6lAyUaLaTRaV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA3OCBTYWx0ZWRfX2ea4iepLya8e
 u/RHH1/wfHIKJZ8+Jf7wOY4wj8XR9xzoUNBYjnpFjO47yzsaKfjU/XN8j7g82pGNcHLIAuDVzMJ
 KMGfZDToKxladXb1lbLFhLwt5iGVw3LJBtrZsMaVjskGsjdSEfVKQXCCYwA5zkPm482GMtvPwN3
 jyJIuvtvK2eZdI8VGkblCf8zlVF/GyFNxFgJDRGQUE4YhkD6gz6U8H7oeeXXITLS0LjBEBIQkVd
 hciJv6mh5dbOOr8WbBAG68O9jPfYLSopCyL97moXfPwULj4fUglw2KjlroxFs7mDRTA3fUU1qXY
 XulWKBv1MwarGtHmsJHqll9CuwDtloBZZGQW/RsUBi0kqUJ/29Ugn3cBOSVu/19P+N8EkFP2I+3
 RQ+4KR1LzEbgliAqZ8kR4kJ2WqGwZjinnsOjv8iLgk7AxJ9WUGp/AjfY+5pp07gMXMNbiYKu5YO
 VcLFK14qbwpeW4bMkfw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_05,2026-11-02_03,2025-10-01_01

On Mon, Nov 02, 2026 at 02:21:27AM +0100, Michal Luczaj wrote:
> On 10/30/26 21:30, Bobby Eshleman wrote:
> >>>> Yeah its all kind of a pain. The problem is that we need to hold
> >>>> sock_lock to set sk_state and sk_err, but can't acquire it under the
> >>>> table lock. Instead, we grab the socket ref sock_hold under the table
> >>>> lock to guarantee it stays alive between releasing the table lock and
> >>>> grabbing the socket lock.
> >>>>
> >>>> I was really tempted to not do this lock_sock dance though. The race
> >>>> condition I'm avoiding here is that if this reset races with an RST
> >>>> receive, then the socket could end up with TCP_CLOSING + sk_err
> >>>> ECONNRESET... but I'm not sure this actually propagates up into a real
> >>>> problem for any potential user.
> >>
> >> Right, vsock_connect() is fragile. Two things to be cautious about:
> >> 1. Don't let it reset the already connected socket. Because that would
> >> allow user to "re-connect()" and make mess in connected_table.
> >> 2. Don't let it re-assign transport of an already connected socket. Because
> >> that breaks the contract in few places.
> >>
> >> State 1 is not an issue: vsock_g2h_reset_unreachable() calls
> >> __vsock_remove_connected().
> >>
> >> State 2 may be problematic: if vsock_g2h_reset_unreachable() sets TCP_CLOSE
> >> when connect() is scheduled out, then after the wake-up sock may get reset
> >> to SS_UNCONNECTED. Then user re-connect()s and hits the transport
> >> re-assignment logic. I'm worried that, as we re-assign, someone may be
> >> holding a reference to such "connected" (even if not in connected_table
> >> anymore) vsock.
> > 
> > I see path you're looking at... after vsock_connect() gets scheduled
> > back in we set TCP_CLOSE/SS_UNCONNECTED if sock_error returns non-zero.
> > Could you elaborate on your last concern there about someone holding a
> > reference? I'm not sure I fully understood.
> 
> Ah, sorry, let me explain. This case reminded me of the vsock's TCP_CLOSING
> bug[1]: reporter mentioned vsk->trans getting freed when skb was still in
> flight. I did not reproduce the exact scenario, but it did sound plausible
> and I thought it applies here: virtio_transport_destruct() frees vsk->trans
> the moment vsock_loopback_work() invokes virtio_transport_consume_skb_sent().
> 
> Now, to get there let's start with vsock_connect() setting SS_UNCONNECTED
> (on a connected) socket after vsock_g2h_reset_unreachable(). Then user is
> able to re-assign the transport, which involves
> virtio_transport_destruct(). But since we're dealing with a connected
> socket, (before the reset) some send() might have triggered
> vsock_loopback_work(). Does this make sense to you?

Ah you're right. I think that your approach of making vsock_connect()
more robust is probably the right way to go...

I think this is the new race...

1) vsock_connect(cid=VMADDR_CID_HOST)
   -> enqueue pkt
   -> sleep

2) rx worker receives OP_RESPONSE
   ->  sets TCP_ESTABLISHED/SS_CONNECTED

   (vsock_connect() still asleep)

2) sendmsg()
   -> sees SS_CONNECTED
   -> enqueues skb

3) netns reset sets TCP_CLOSE and sk_err=ECONNRESET

4) vsock_connect()
   -> scheduled back in
   -> sees sk_err != 0
   -> sets SS_UNCONNECTED

5) vsock_connect(CID=VMADDR_CID_LOCAL) call #2
   -> sees SS_UNCONNECTED
   -> frees old vsk->trans

6) sendmsg's skb tx completes
   -> tx worker dereferences vsk->trans for the UAF

If connect() checks for SS_CONNECTING before setting SS_UNCONNECTED,
then in step 4 sock->state stays as SS_CONNECTING and the second
connect() call will hit -EISCONN instead of freeing vsk->trans.

Seems to work for a racing vsock_shutdown() too, where sock->state would
become SS_DISCONNECTING, and the second connect() would hit -EINVAL
instead of freeing the vsk->trans.

I guess the rule would be that vsock_connect() sets SS_CONNECTING before
sleeping and only changes it to SS_UNCONNECTED after waking if and only
if it is still SS_CONNECTING.

WDYT?

> 
> Another thing is this feature of vsock_assign_transport(): in some
> re-assign failure paths you may end up with vsk->transport = NULL. In the
> past this caused issues with sockmap: see WARN_ON_ONCE in
> vsock_bpf_recvmsg(). Problem here is that normally vsock gets removed from
> sockmap on close(), but in our (reset+reassign) case close() is never invoked.
> 
> [1]: https://lore.kernel.org/netdev/anzT1fREOSyHT99k@v4bel/
> 
> >> So I don't know, maybe it's vsock_connect() that should be fixed/hardened
> >> instead?
> >>
> >> Or at least disallow transport *re*-assignment? Does the "re-" part have a
> >> use case?
> >>
> >> Hope it's not too off-topic.
> >>
> >>>> It also avoided some racing with the tx path, but now that send_pkt()
> >>>> also checks reachability I think that path is safe.
> >>>>
> >>>> What do you think about doing the below hunk (TCP_CLOSE, ECONNRESET,
> >>>> sk_error_report) with no lock_sock?
> >>>
> >>> Looking at the code, it seems that in all the places where we close all 
> >>> connections (virtio_vsock_reset_sock, vhost_vsock_reset_orphans) we do 
> >>> with no lock_sock but with vsock_table_lock.
> >>>
> >>> So, makes sense to me.
> >>
> >> virtio_vsock_reset_sock() and vhost_vsock_reset_orphans() are my pet
> >> peeves: state switcheroo without taking lock_sock(). Which, again, races
> >> vsock_connect().
> > 
> > True, I don't love that either, but I feel the impact is at least
> > constrained by the fact that it only happens when the module or device
> > is already going away.
> 
> Doesn't it happen on suspend as well? Is so, with a poorly timed connect()
> things can go south on resume.

Ah that's true.

Thanks,
Bobby
