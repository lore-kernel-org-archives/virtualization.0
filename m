Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794605652;
	b=V/EXwkF3oSxRXad3ipNPy8aaiQVYnSxeBgCtFsmfBUK8RExqiuqAyMlE9rvLEe+73eiq
	 dN0hlgZqU96d5WfX6NiMxVGM+uL8tEQRonxm6GgqHmOTQ1OTqRdDIqFnhcLw/8iGMdTNm
	 q13zxz6wdbDcIuvcRfeCgtuYq/IxJ6NpAPtpiItwPdpZcfjpyVpcML5P+Kw1rY+zFELNo
	 Yu2zKLxmqzzorvkhoxIqBJ5w90itDYVTcmgHxiQNhoCAkvWvAP18TycbfEJc8TI49LQc/
	 Mbpsx0FX15zYTJX+OT6NXcMbCCiKlcE4ZYrhYel/iAFkAH8KEFJEJekeE9oBElx+l2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605652;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 CC:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Originating-IP:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version;
	bh=bT4/su/kt3f5MZ69eUq74I8ys00QmHN4pzyX5zqRUbk=;
	b=3vEHsjd4TxrbIWv1aJnc0Wja+49rnmj4yjy0MvWzrIaa+/UT/RzGGUhQmIa0U+s0QaTq
	 1u0wIZGm++/YpcTpYSlOk6e5ofHxyk0njivGqWcS3pZ6gXh6PFGMlpLPWQrdQfnSXXWa6
	 KKQxKRzMCdqBxV7mqX1NrhwsHp1iHisN5s36AUoERf6BIbFsLMqbvW2sG6s050Llu9n08
	 rNcQccjLp9t8onKbYxaGpntD0JRp1v/7Flg2hFqiFSg/3j2neIWzXRpApBidZedUPHDkB
	 OsIN+p+cv4z1S9I0/NwAJ/I8DE5rB7YKbthP6DMP3LwvXaml8lTNtQpAuYxh6co8bjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=Vv6Klqp3;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDC3606A33A
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 21:34:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCDC3606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=Vv6Klqp3
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADLSiFo1114001;
	Fri, 13 Nov 2026 13:34:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=bT4/su/kt3f
	5MZ69eUq74I8ys00QmHN4pzyX5zqRUbk=; b=Vv6Klqp3zfXVhRL7kNuWvX5q+0i
	XG785uhWGpMRDismA+acLCaa+Rur/H9gPq87S66+jYcQeQ9ey+kk2mTyzruyaPd2
	JZaNtWcGTZn1d/jULezcFxSoWmVoJFa5UtmnMyvPeyVReLYHecFCRreNdev6nUvu
	FH2pWZMoX/ZQCVnt7IX5960j0j1kA1JkjcZe7fLUlzrl4kLutx9bYtQg5F3GAq0q
	g1U2Gn9yHKEN+8CCvuLxkO80IQwUCftXIdM78YrBiiaWb2IxUyraQnPXZmA1O1QZ
	0Ta68VmMXjZcafTLD5b4UZTXjJfkojh4jOMw2s7Ecr7iPvFTXtEeb9UVh9g==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hwftjtcp3-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 13 Nov 2026 13:34:09 -0800 (PST)
Received: from localhost (2620:10d:c0a8:fe::f072) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Fri, 13 Nov
 2026 21:34:08 +0000
Date: Fri, 13 Nov 2026 13:34:07 -0800
From: Bobby Eshleman <bobbyeshleman@meta.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <netdev@vger.kernel.org>, David Ahern <dsahern@kernel.org>,
        Stefano
 Garzarella <sgarzare@redhat.com>,
        <virtualization@lists.linux.dev>
Subject: Re: [PATCH RFC iproute2-next 2/2] ip: add "ip vsock" to move the
 guest vsock device to a netns
Message-ID: <aveCT0JPHPsqCkL4@devvm29614.prn0.facebook.com>
References: <20261105-vsock-guest-ns-v1-0-b1c11b3b69c7@meta.com>
 <20261105-vsock-guest-ns-v1-2-b1c11b3b69c7@meta.com>
 <20261106102659.77f8ba56@stephen-xps.local>
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
In-Reply-To: <20261106102659.77f8ba56@stephen-xps.local>
X-Authority-Analysis: v=2.4 cv=ZYiIpcVA c=1 sm=1 tr=0 ts=6af78251 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=VEq9NWtHcDJz48dA:21 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=PAz_-FQ8hEVmOPYdF0yf:22
 a=VabnemYjAAAA:8 a=CHgJ09IQ0WI7wAN8FdwA:9 a=CjuIK1q_8ugA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA4NiBTYWx0ZWRfX5Z5p0Euxs9l+
 /bhvQMcF0Zg6ZK/uveYj+A6LBfv4ti7wKaJO5Pd+OGpB5j9Pzp3jsnX7wSJDS6zm54/zCiRM186
 aoAWjkmdsp0Vfww0D54tQRzSltAcvskAxcmWnetl2LYaIMLmHc7y2hwYoUIVwT0Jmv2nFrjpCmG
 iQzStNW7KfomHy3Per7itCtAZ9nl2Dt+gSWPlosM7FQAL/p8c6/hrhBmHUjjc0cNyzP1SA4d3Q+
 IgyIMCvgXRdV90XxDbrTxWbGSvmhLUKKphRe25/W+x1gvLqFVFh9xwjZkgDTVbp81tjgznsIy4v
 pcLDyCzD4CNECwcXZXTVVOVWX/t0a1d2e3A04cp8N1y9Rd1056IKbJqG9rwAOmPu7GOFmEIlIid
 Na0dq+mka1SxM7T37/FMkkd9gJyH+Wxf8tKr/FmJh+NWY6yw8LdM4wY6sYa9ZK/vKgRPD7yc6wW
 MAZUtvZvbGTliQYrw5g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA4NiBTYWx0ZWRfX4TywDtri0zbc
 Wlm3dGExtVxp/vKlAOZKKdo98ypAA+9o3GudS8mb7sKZinI5d0M21nZ4DwRbAdG5ogIaEctcUO7
 5mtfpmO+zWp/h/V6T9f7/r4V7egNc1U=
X-Proofpoint-ORIG-GUID: YV-5JhPTdzAdUtJaZ2Bbc67y_UtXtXyH
X-Proofpoint-GUID: YV-5JhPTdzAdUtJaZ2Bbc67y_UtXtXyH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_06,2026-11-11_03,2025-10-01_01

On Fri, Nov 06, 2026 at 10:26:59AM +0100, Stephen Hemminger wrote:
> On Thu, 5 Nov 2026 11:30:36 -0800
> Bobby Eshleman <bobbyeshleman@meta.com> wrote:
> 
> > + * The guest's vsock device is not a netdev, so rtnetlink cannot move it.
> > + * The "vsock" generic netlink family moves it with VSOCK_CMD_DEV_NETNS_SET
> > + * and reports where it is with VSOCK_CMD_DEV_NETNS_GET. There is nothing to
> > + * name in a request: the kernel serves it in the namespace of the socket it
> > + * arrived on, so the destination is chosen by sending it from there, and the
> > + * reported namespace is an nsid relative to the sender.
> > + */
> 
> Please be more concise in comments, AI seems to think it gets paid by word.

True, will definitely shrink this down.

Best,
Bobby
