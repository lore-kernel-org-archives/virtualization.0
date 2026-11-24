Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795480796;
	b=ea7cm55FnsCtZBRr79VIhZ8R3Bz/YDMEyXut9q9YRCwag/6o/jDySIKi6l/cWKSaDb5g
	 xnN4GfQCgB/rLJLIEO1u90aD+fHClgpC8x+NlGs29VrjCrf30XQ1WKsAbbIzKIt/decau
	 ArJKzkiRHQV2zg5JVqeYeY005XcMyvBxEuCHHDDbZaYP9DS+GakzfKE+kKGJn3Gf+Q++T
	 YGsEe7yMjG3QYzjThBAzCstseAM6Z8U/itJMBT1ekF4L2qrJRxvfLfMlcnVQkwuthcaRi
	 CFfFHx1zX0yo2w+p8RXJy2zis0NPSxrd1LPP6nKGf9sZFFK3svYuC2fz3AnpZCcFTYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795480796;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 CC:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Originating-IP:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version;
	bh=efALRy5JehNWwR5fNw4avw3lMC0wfy+UAUaAyAGBkW8=;
	b=pneehtV9zaHd11du+eSekcQsAla540sl1fXFjbkphJ8NQLpbLCkn+lVTTZOGs4gOj+B9
	 PztchXLLz+VpPU86wbQ8Yxq07UT2ZDZAtLuq6Eb9j41GOixuB9ElzKBr/47/AYtGgkR6+
	 28IBZU44bg9ffykkR3wE6K2oNM7Dn3dCqWmrsnnxWZiQhuFxEv7en5XEHBxpsFtsFxGwi
	 ULKgseXW1bBjsAmM4wj1MjtuQsYamKXc22dHWoXC1y+fphjS7CoDqL01tyOk1EeFkpsDX
	 p9tutufksOjQs6u1TJqB5E9Z1tFzNtLEBAQWnSPvCff6ssmOpiU2tVxVeoaem5Q4q5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=MQ8d7z+H;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0410E606A31E
	for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 00:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0410E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=MQ8d7z+H
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANJw71x2854679;
	Mon, 23 Nov 2026 16:39:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=efALRy5JehN
	WwR5fNw4avw3lMC0wfy+UAUaAyAGBkW8=; b=MQ8d7z+HPPVzwqqHYCFi8TAuGwm
	B9aeFtqef2e09TvZfP65mSE4FZYADxTllsLWaz7gzGazpDqtMiS7J9D2QPeGr+3Z
	1/sCV+dRKUxpaqEv0XjThiTEAtUmFlH+5dTw1nYaUH+LHv0CuITIWrSelt8lpyu0
	Fr4atcCmSUBbDE3oI9X6dF/715epjh8k3wuKHB64EkdOVdZqqfTtoSxAP9WncO+1
	dtVsfdxyJKAChQe8b8LMhMoYCTqUShqttQQOd8UzZJVYQbdy6pktGNbmrFTsEA8f
	JWZAfjwSDDSdNY3jLutjx8se6BA55cBr1eJNMpF8UDhg+4lZYqItkvgKOHw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j3bfmwfvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 23 Nov 2026 16:39:54 -0800 (PST)
Received: from localhost (2620:10d:c0a8:1b::2d) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Tue, 24 Nov
 2026 00:39:37 +0000
Date: Mon, 23 Nov 2026 16:39:36 -0800
From: Bobby Eshleman <bobbyeshleman@meta.com>
To: Nguyen Dinh Phi <phind.uet@gmail.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi
	<stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Jason Wang
	<jasowangio@gmail.com>,
        Eugenio =?iso-8859-1?Q?P=E9rez?=
	<eperezma@redhat.com>,
        Asias He <asias@redhat.com>, <kvm@vger.kernel.org>,
        <virtualization@lists.linux.dev>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] vhost/vsock: annotate lockless accesses to guest_cid
Message-ID: <awTcyKKYa8R7s6h1@devvm29614.prn0.facebook.com>
References: <20261117164916.2332953-1-phind.uet@gmail.com>
 <20261118012321-mutt-send-email-mst@kernel.org>
 <a7752192-b417-4e70-8f39-a3cdc983f447@gmail.com>
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
In-Reply-To: <a7752192-b417-4e70-8f39-a3cdc983f447@gmail.com>
X-Authority-Analysis: v=2.4 cv=DqvDa2/+ c=1 sm=1 tr=0 ts=6b04dcda cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=crHB47gyY4rKiduisYu9:22 a=pGLkceISAAAA:8
 a=BpIEGQ5VxnvoCYnNX3YA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: WMQG2mlDY79KFTZ1_j5ltsmJFe1zfpH_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAwMSBTYWx0ZWRfX8MBqf1PahJTV
 FDRNyD2aYRuxT+r4naWLGIQoRkN0jFDLil2xAoygo3uc7S/Cof8sxQFNA23fvlZnw+3OGMEt/Wx
 6rw+rltyDJmixWNnylpfTrLyJOSPOPc=
X-Proofpoint-ORIG-GUID: WMQG2mlDY79KFTZ1_j5ltsmJFe1zfpH_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAwMSBTYWx0ZWRfXwWTiFaotObcB
 EM1sufzoe0pFQ9Iuoyiae5qj2SfvlTIJiMtUGa3Cvjp+XSRn3UA4ySp924cMHBISYGzVRN3MMAZ
 trfJI3QknuOBkpRSMLJNdXZs/UbgTBJSyRFgAyExEnzbEx/YhSOqLQM2aOVBhIG1EYvp/kAVAyC
 FgV7rVO+S5LlNDgJZBgeSezY2wUN7+1XAa1T/My0nw4mv5VQGVTzQI2VJD5znETK/6lXzfj/gsn
 f3TdSb6AgP8bHXZKLyam0VTPOyVpK6huf2JRc2xUkd95us/vf5ZolIh8PLafbDV7Mz1q4RgPFkN
 wjJqqnriWaEZnwJnBvXGh2uCA8V2FrfeKrYvs/YI/J9yTkSfxKt80fKID8VA3zNvLs9q3/I+JJB
 Dft5gKkA+AzF6KBeq+RVFW62db3n2iJZG9aV0maXlxNCx1SVPVJp4jw93J6Tqw+tO9PXjvQ5b9R
 PtDJoMA1C1HEISAYJew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_05,2026-11-23_01,2025-10-01_01

On Tue, Nov 24, 2026 at 12:48:34AM +0800, Nguyen Dinh Phi wrote:
> On 11/18/2026 2:33 PM, Michael S. Tsirkin wrote:
> > On Wed, Nov 18, 2026 at 12:48:43AM +0800, Nguyen Dinh Phi wrote:
> >> vhost_vsock.guest_cid is written by vhost_vsock_set_cid() under
> >> vhost_vsock_mutex, but It is also read without that mutex in
> >> vhost_vsock_handle_tx_kick(), and vhost_vsock_get().
> >>
> >> KCSAN will report data-race if we issue VHOST_VSOCK_SET_GUEST_CID
> >> ioctl while the device has TX traffic. For example:
> >>
> >>  write to 0xffff88810f1596ac of 4 bytes by task 7914 on cpu 1:
> >>    vhost_vsock_dev_ioctl+0x25f/0x720
> >>    __x64_sys_ioctl+0xc2/0x110
> >>    x64_sys_call+0x299/0x20a0
> >>    do_syscall_64+0xc9/0x510
> >>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >>
> >>   read to 0xffff88810f1596ac of 4 bytes by task 7910 on cpu 3:
> >>    vhost_vsock_handle_tx_kick+0x41b/0x740
> >>    vhost_run_work_list+0x97/0xc0
> >>    vhost_task_fn+0x98/0x1f0
> >>    ret_from_fork+0x2e2/0x3c0
> >>    ret_from_fork_asm+0x1a/0x30
> >>
> >>   value changed: 0x0000004d -> 0x00000032
> >>
> >> Both readers load the CID once and works correctly with either the
> >> old or the new value.
> >>
> >> Mark the store with WRITE_ONCE() and the two lockless loads with
> >> READ_ONCE(), so KCSAN knows the race is intentional.
> > 
> > You make it sounds like it is just KCSAN false positive.
> > Is it?
> > if yes, this should be data_race. If no, document why.
> >
> 
> This is an actual data race, not a false positive. The value of guest_cid
> can change while the TX worker or lookup path reads it with plain accesses.
> Because each check loads the CID once and either value is valid, the result
> is equivalent to the read running just before or just after the ioctl.
> Even so, plain concurrent accesses are a data race under the Linux kernel
> memory model, and using READ_ONCE()/WRITE_ONCE() also prevents
> compiler re-fetching or tearing rather than just silencing KCSAN.
> 
> >>
> >> Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")
> >> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
> >> ---
> >>  drivers/vhost/vsock.c | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> >> index 88a310390eb0..f26c59013075 100644
> >> --- a/drivers/vhost/vsock.c
> >> +++ b/drivers/vhost/vsock.c
> >> @@ -78,7 +78,7 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid, struct net *net)
> >>  
> >>  	hash_for_each_possible_rcu(vhost_vsock_hash, vsock, hash, guest_cid,
> >>  				   lockdep_is_held(&vhost_vsock_mutex)) {
> >> -		u32 other_cid = vsock->guest_cid;
> >> +		u32 other_cid = READ_ONCE(vsock->guest_cid);
> >>  
> >>  		/* Skip instances that have no CID yet */
> >>  		if (other_cid == 0)
> >> @@ -572,7 +572,7 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
> >>  		hdr = virtio_vsock_hdr(skb);
> >>  
> >>  		/* Only accept correctly addressed packets */
> >> -		if (le64_to_cpu(hdr->src_cid) == vsock->guest_cid &&
> >> +		if (le64_to_cpu(hdr->src_cid) == READ_ONCE(vsock->guest_cid) &&
> >>  		    le64_to_cpu(hdr->dst_cid) ==
> >>  		    vhost_transport_get_local_cid())
> >>  			virtio_transport_recv_pkt(&vhost_transport, skb,
> > 
> > Will prevent compiler from hoisting the reads out of the loops.
> > Does it matter?
> > 
> 
> Not much in practice: because the loop body calls non-inline functions, the
> field needs to be reloaded across calls anyway (and in `vhost_vsock_get()`,
> the `vsock` pointer changes on every iteration). I checked with gcc 16.2 and
> clang 21, and the compiler does not hoist the load out of the loop even
> without the patch.

I do appreciate actually looking at compiler output, but I would advise
taking it with a grain of salt. My now-very-rusty reading of
memory-barriers.txt is that we do not expect memory ordering
optimizations to be consistent over time.

I think the code looks okay. I do second Michael's ask for clarifying
its not just a false positive, as that was initial reading as well.

Best,
Bobby
