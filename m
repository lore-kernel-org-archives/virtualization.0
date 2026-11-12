Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794511179;
	b=fY5EV3TpL7vbdXeSMhITPt8BgcL9hXH3yK3Xgt1ThCTRQZ+I05oGQ7JGTyrifcH78Jz6
	 8I9V490tWNEKPmLQtyu6S63abs8jsb1EyOicNSVduVJt+7lDca3N3kXWj7J1kb9YrBQn+
	 8Dpd1jFX6KlSXdnEsm5sjZWDWng4Y+0Obb4wwCPEdobmF0j41dIv3+E08e1MT3modYEtW
	 WCC0fRB2rBgoSN2Moj2O4qlWeBY42UnCXVItt90cJBBPmr4uLppxYzZXkkB5iYXVCvg6b
	 58/oxSZdJHkMdEEjoIIRTH0BL7B2iWVR01NRF3oS7bZ9U0tWvRsabtw0byxy8zAm9uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511179;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 CC:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Originating-IP:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version;
	bh=a/3/vOknZNV5rMhfsRlvw02gGnblZnfFUGDt0wyzhjE=;
	b=nXsSFaeArz6ZMvVUiEn8Lgk2I87Ua5xBSX+GMhIXXcKZsT+Iy1QzXIZ5iJ01akO/r9Q5
	 v201p8gjXiYgkEq367pwTrBjsOLhS2fofk+FZmSXCQKTsvjwcYf3yqMrjP8L9w8Gx4z5S
	 h1V4/eMEGJAKopm4GLf8fjZlMWDNZ4pG0iHB/B/BlsC7bHjzeMhc8/ZOxZXt4bJ1bnUWL
	 /4BNf2khhNDg8wUpO+FSR0RtCVZwJPQyhecP8xYDU7vhCCb32vtdjKeSQmMwtA5CuIIOM
	 2/yjQ/YZ/f5HfXy9oj1Tho6V5B02n6iz6Dj3M4Qw0VUaRE6LQolgrgPxL7wo1wQFt3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=ReSOOSyy;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FBF606A321
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 19:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29FBF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=ReSOOSyy
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACFapVR3401241;
	Thu, 12 Nov 2026 11:19:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=a/3/vOknZNV
	5rMhfsRlvw02gGnblZnfFUGDt0wyzhjE=; b=ReSOOSyylrPqQ7w5znHrlGE8xe5
	SRq+nMfSWT9+K3w+QUWwgPFl18x3t8ZXFwVDYz8hzD0ukBdvnAXhHPR5hDNzXYia
	aIihrOdNs5daQ8LmrSNo9p8y7iFxcu/fzoSy0jp185nK8K00p875CxDwNBZq9/aw
	58lWmQWM2WF+Ob9S4vaoNqEAf8TT9oHqaT8YpssjLnJ1UvZJgkZMS12AM4FFfVSt
	WSes2w+bUupqKzGdsWbVHyKtN8emlkxnK4XoHnSBxwkoSZkybMBfL3AooSUuDK+y
	+Ry8GGkx3VTTUy+aemx2CdOtJi6eni9KrHkdFjhhR3AgWNK+/wjgKPnTc6A==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hvaudygk7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 12 Nov 2026 11:19:16 -0800 (PST)
Received: from localhost (2620:10d:c085:208::7cb7) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Thu, 12 Nov
 2026 19:19:14 +0000
Date: Thu, 12 Nov 2026 11:19:13 -0800
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
Subject: Re: [PATCH net-next v5 4/7] vsock: add a netlink command to assign
 the g2h device to a netns
Message-ID: <avYRMQww+ui4uPkz@devvm29614.prn0.facebook.com>
References: <20261103-vsock-guest-ns-v5-0-48179b9b66b8@meta.com>
 <20261103-vsock-guest-ns-v5-4-48179b9b66b8@meta.com>
 <c34123f3-e006-4c25-b8d7-cdf0784926f4@rbox.co>
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
In-Reply-To: <c34123f3-e006-4c25-b8d7-cdf0784926f4@rbox.co>
X-Authority-Analysis: v=2.4 cv=AKwTwrWT c=1 sm=1 tr=0 ts=6af61134 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=xtH7KyWI9dI7BmFOsl-x:22 a=VwQbUJbxAAAA:8
 a=Bgyc4cfSFuLOcWupkI0A:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: _cVSF3NSQ_uvq6t-vYkVz_6cKrlEOdZl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA3NyBTYWx0ZWRfX3ZEYaRYhoxQ8
 usrYrAigjaSSywUkrAML7m082FIZ9ahPa6osa/uLjGeURPOoNHW2DhRuRRqH8MO5qwe2ciVft8x
 NzE7lxNSVPJe1XXp4Iu0HiPfj/GkiZbi02cvfDvuuS1vqU0Dny9tFRHJC3vtiINZYIGuWEUewzN
 /pMtixzbQdUxfpN1rfc6nnBqAYW9q0Ky2ibw9EME0SEzeY7HcGeT2r5acmDJw0SBasnebv2sJlr
 LOI44viL/MzNw28pNFndfNU3SA9UhdAjQ4D7hArvOtZ7qvUs5y1MXsC6daoxsnOk2WaxPJ26iKd
 i8ii47IdwImq/MU8O5a30jphsmPyMdE6uBQGDiLehzjiXvuJyoYLckgbgQgywBSY8qgj+uq7rjL
 mkuSU6j7uiGvjX7zfAwE6UzWaBPzhUdmmcIOGq/Rao8qXqZ9wDo1sRuegm/RrlJTdCtyMCNC/qg
 DbgNkydXQ0fm7nWHtNQ==
X-Proofpoint-ORIG-GUID: _cVSF3NSQ_uvq6t-vYkVz_6cKrlEOdZl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA3NyBTYWx0ZWRfX0xgaferDqxVz
 fMjqjg/jghUeB/xn0OclUvGqHgL1ZiEL1sSDvdnPbjicEh9BXwwcUZZaGmFvNK+/7wz5h2yn+we
 AGI5UprcQ0+lFYfR17uH1zSuSF+OCBQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01

On Thu, Nov 12, 2026 at 11:34:49AM +0100, Michal Luczaj wrote:
> On 11/4/26 02:53, Bobby Eshleman wrote:
> 
> > +/* Avoid breaking the socket when another thread has changed its sock->state
> > + * while we were asleep.
> > + */
> > +static void vsock_connect_close(struct socket *sock)
> > +{
> > +	sock->sk->sk_state = TCP_CLOSE;
> > +	if (sock->state == SS_CONNECTING)
> > +		sock->state = SS_UNCONNECTED;
> > +}
> > +
> 
> It'd be nice to have it as a separate commit. If I'm not mistaken, this
> itself solved the vsock_connect() vs. transport reset
> (vhost_vsock_reset_orphans(), virtio_vsock_reset_sock(),
> vmci_transport_handle_detach()) races. And those were already reported a
> couple of times, including a recent NIPA/Sashiko Severity-Medium[1].
> 
> [1]:
> https://lore.kernel.org/netdev/179447093204.2199510.8895677421994612994@kernel.org/
> 
> thanks,
> Michal
> 

That's fair, will break out on its own.

Thanks,
Bobby
