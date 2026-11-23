Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795450746;
	b=kpx0ruLrFEIKd2ti3LD0+igBzGN25NZydfZToAnkpS5eTPThhSUspwfQEZzur9Qpyzpz
	 Ln8QJC69nfkRGHTdr1mvWR+m5V7iBTngGuopDe1bkiW4N/cvo5yjDkzpcNIJTOtWt2XIq
	 3O10R7kgLfMQ3bvQ8OYJYiNzqNkzWdZh/C5jUBw5/OVumEt8dk3g7IrJhWe9QT6PvAwb9
	 MqLNvDitXYLAY7ASMcUcAzI9H3GclgiYoVOtfPBp00JNbkm5+Y3qGmEdJYI7Hy2lC8ZQC
	 6HomI6CRHc2NJwDMmNBW7s4E9JUYHeNaxSDqlmlUveoKTOEBaP5x0DK4BYUdvO9Fu7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795450746;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 CC:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Originating-IP:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version;
	bh=T3dIrp743mScXUEVTG9HzJg8wQXGZt9Ea7srRCQkNSQ=;
	b=0F1c3tzf3NmJNbAI7tdxIxzWB1IbGrRqr9xy7R207gTC3sIYDjpdnqHT2q6JAv1g0wba
	 bnk1EUZxV0FbSmkFSBC5b4aV2+6waIGB98YbVj2ZP75TM4pAVgxqWoAKzcpWmsx0g5Jw6
	 TiWJzIfYwo2QyqmU7WQtnsuY8lSpy2RRu0esAlNo8NJXG+rSfnE1khQYyV08HNr2pMaZ9
	 EbHhI1/gq4W8kgaf0ondwVFt6p/NScmF4nFaIEi0rZx2iSW7h0LSp2L3Npm3ynwKSjln6
	 EFoCGUzs6jAEPsFnPCyjqrdWFmkKQoAFhiKCvlFVkg3l2WVcczp5OoSLmu3hEKA1m7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=ftmTbLuk;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E806606A31E
	for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 16:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E806606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=ftmTbLuk
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6ANGIIRg3716626;
	Mon, 23 Nov 2026 08:18:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=T3dIrp743mS
	cXUEVTG9HzJg8wQXGZt9Ea7srRCQkNSQ=; b=ftmTbLuksZ18qcfFfRkriR971dv
	dEYLc8rH4Og7I8wESceYbNcIzKBwhPNKt+zG3i8U5lIgQrebN0Ae1QFkj1HVVePN
	7u87nd31X7efKdDfnkGw2B2tqxWkc3oVUvlCgJXauNpsnV9gddXaElDys2VcXhxR
	+8Y76P6oINjFpwHqdywWh/DaySDNZZaHDz7VfFK2dIT0IYKtkMyvUs6dtONqjzZn
	WgpHGJPDTSMWbiw3CGI87ALp6M4+dzo9poARQtizBW9erbRjn09Ojy3TdtO/fVn9
	qrWHiWuhnGDZ7Apkmwln6u9VeCfa7gKZPJ2QnKW9K39cHkLFi8sBLTCbMaw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4j37udt00r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 23 Nov 2026 08:18:49 -0800 (PST)
Received: from localhost (2620:10d:c085:208::f) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Mon, 23 Nov
 2026 16:18:47 +0000
Date: Mon, 23 Nov 2026 08:18:47 -0800
From: Bobby Eshleman <bobbyeshleman@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>
CC: Paolo Abeni <pabeni@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowangio@gmail.com>,
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Simon Horman
	<horms@kernel.org>, <kvm@vger.kernel.org>,
        <virtualization@lists.linux.dev>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] vsock: only deliver taps to namespaces that can
 reach the device
Message-ID: <awRnZ9S+3B996VqJ@devvm29614.prn0.facebook.com>
References: <20261116-vsock-tap-net-v1-1-7e24f45adad3@meta.com>
 <awQJo8WE5Gn4nYHp@sgarzare-redhat>
 <12a2b44d-3d24-4b77-9dd5-24361d5fe910@redhat.com>
 <awQ5xzF8P0NJiCsv@sgarzare-redhat>
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
In-Reply-To: <awQ5xzF8P0NJiCsv@sgarzare-redhat>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA2NCBTYWx0ZWRfX5r3cneGfkihi
 SNwtFPkMtyBsD7xby0vFdVN7Veu2bLp9FJANDCVXDLDMydzzHzPMOksVokwfKKSRKQHEnNI5+K2
 K6sqW7IFpidNYXSPeBclQv5eMZqHjZ6seFeXsN7/syjfQjRGZnkcUra+gWVfdIhGS/U9ik3etY4
 qcM4PxkjSJCYUIgeTaRb3/V2OsCL6Pj0/LPpqCZjNXaqr8/f3ged9Y7ROkd5ICkyvoF8phbLeAe
 EbI3LegRksfvyc9X1yPcbJEyiAZSvw6d7b5aQZrsqjDILmd3VwKOAU0Jj0tp8uW7F3N4tVX/2BN
 7xs2aACmI7uynv+HqSbUKS9z63YAH/AEP2ivj75gAvrsegqaQvSg4EcmXAdJi884ZEkzftbUV29
 JShS/Hy1Blccvx/uYdP9Ucu/YPenqXTtRXsAVWsLSfgyDUpBr+T7QghZYuh8M29+GF4dSFrnFuZ
 oJahC5jVyqebJ9kJ/kg==
X-Proofpoint-ORIG-GUID: vkp3xM5VmOZ-hvVr8sf5yf6TGZeYqnHg
X-Proofpoint-GUID: vkp3xM5VmOZ-hvVr8sf5yf6TGZeYqnHg
X-Authority-Analysis: v=2.4 cv=VK5IDNPX c=1 sm=1 tr=0 ts=6b046769 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=_78whYxrdx1mplLwxq1U:22 a=20KFwNOVAAAA:8
 a=QUIw27DrvkiG4lpEvKAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA2NCBTYWx0ZWRfXzO4NYOeXqdXM
 PEcKJjN339C23yg71j/WjRFVdZZbuea4Qe4n/IVN3nQQAA6rgPm+GG8A/srvFX7rwgRb6LAiPHf
 wWo7XD7TXJgA5MvgfJ43rvR9CgzuLUg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01

On Mon, Nov 23, 2026 at 02:17:54PM +0100, Stefano Garzarella wrote:
> On Mon, Nov 23, 2026 at 12:58:38PM +0100, Paolo Abeni wrote:
> > On 11/23/26 10:43, Stefano Garzarella wrote:
> > > On Mon, Nov 16, 2026 at 03:46:49PM -0800, Bobby Eshleman wrote:
> > > > vsock_deliver_tap() clones every packet to every vsockmon device on the
> > > > system. Creating one needs only CAP_NET_ADMIN in the owning user
> > > > namespace, so an unprivileged user can capture the traffic of local mode
> > > > namespaces.
> > > > 
> > > > Pass the packet's netns to vsock_deliver_tap() and only deliver to
> > > > devices that pass vsock_net_check_mode(), the same rule socket lookups
> > > > use. vhost passes the vhost_vsock netns, loopback the sending socket's
> > > > netns, and virtio-vsock NULL (global mode).
> > > 
> > > For local namespaces I think we are fine, but what about global?
> > > 
> > > Is it okay that a namespace with global can capture all the packets of other global namespaces?
> > > 
> > > Asking because at this point the CAP_NET_ADMIN is useless, since an user on a global namespace, without CAP_NET_ADMIN, can just create a namespace to have CAP_NET_ADMIN and access all the traffic. Should we fix also that?
> > My take is that the above question is quite orthogonal to the current patch
> > and may impact old applications relying on the legacy behavior.
> 
> True, but I'm not sure that behavior was correct since the beginning.
> E.g., what is the point of having CAP_NET_ADMIN requirement if an
> unprivileged user can just crate a new namespace and get it?
> 
> Anyway, it's eventually pre-existing netns support in vsock, so it should be
> fixed with a followup.
> 
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> Thanks,
> Stefano
> 

Its a fair point and I agree we should take it up in a follow up. My
current instinct is that CAP_NET_ADMIN probably shouldn't be enforced
for some (all?) of these global-mode paths.

Best,
Bobby
