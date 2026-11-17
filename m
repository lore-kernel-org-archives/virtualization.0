Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794878612;
	b=fAjNiwbXkb3muA7pDyDVIU+XA7dyljIr01hRxEat0ctbhnR1KV4w+u6sN89ccw85ZYsN
	 pByqonILdZNIw7/tLrWjN/qd91VhtXlEEAGmmRWWxaOg1RHGdOSyj18bpsqt5lHHWTu60
	 bMtYilW+bQ27oP5C19JqCWmmfDDI/nioS6/zD8Uq2xio0p2PtVKn8ibQW06jO5OVtWZOO
	 JwaJV0k1iOzOsr4h69cDKbslS81gJGZh/ucFD7j37f7onCZUBWavRI8CYkmyFR6YKOCo7
	 5VLSldAf88rN243h1KQpHKKbSIamIxuEIvnnBGBZVbAvrYIDw6jX32r/N2mE0UTfSyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794878612;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 CC:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Originating-IP:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=6RCPXUXfIxo+y2UnkG/bhthPFYIMWnxtExJ5BNdZHk0=;
	b=j70hQW3OO91SmA3KSPJ3LU4FuXdDtvkozhzUdm0L8JjkZwWzB2w38mvv62QrOkwnMXso
	 X8YRpejYDgy/y4lg0UYGM9ABhIsjHIXW15MuX4oCcJn4C2okYIc7YHShtd65kfMux1i6n
	 TUsg8GOepoXh7YE2xAIq1VlZXdYbzeXR5pHzgYCwAopdQu/gdoAkppNKyWTJYBij9Z9AJ
	 jDlEyqM7+5Z7eBMdjGqrF1wwwL2yI8ezgkA/URz9LQ2mNRKUcPCj/aWUw/SAtxJw+0J0v
	 OOsATP7nleTaOJDEU2paEOTvkfes8CnjkbE9OWtl1+Q3zGyNaqb1W/DzQqZZgVlf3rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=SDswVXvu;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD82606A31C
	for <virtualization@lists.linux.dev>; Tue, 17 Nov 2026 01:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABD82606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=SDswVXvu
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGNOqqu1978717;
	Mon, 16 Nov 2026 17:23:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=6RCPXUXfIxo
	+y2UnkG/bhthPFYIMWnxtExJ5BNdZHk0=; b=SDswVXvuAUI8muhYNcUukufeX/8
	D0GSKX1dQ5mDP6hG9AJk7bmtYcsUtAXz/xqd+GyP3Czju46I9wy6c81vEzz3d+nr
	3zzWn80O8v8Z//Bt3Pq6YemXWZ0MwbwZYeU/1VhOf3fZQlUgHarY5yfEBh1btC+q
	FAEuQzvBZTF0bygBuW5y94wMAvw4GNVIlqD8p/O8obf0jZlUjDaNT1qoH5z5NDad
	udafcX4jcAM+RT8yaHcFlFBzwJmYcfgYnJq+YvvLZN9xNojTZL3F/iVpC9mftDU9
	15DSOQ7bujgsnTXW9BMI8AYcDHAkQNQ/vVw+bpDl3x68XTwDzvSFxFRHscA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hxku5xbr2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 16 Nov 2026 17:23:12 -0800 (PST)
Received: from localhost (2620:10d:c085:208::7cb7) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Tue, 17 Nov
 2026 01:23:11 +0000
Date: Mon, 16 Nov 2026 17:23:10 -0800
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
        Eric Dumazet <edumazet@kernel.org>,
        George Zhang
	<georgezhang@vmware.com>, Andy King <acking@vmware.com>,
        Dmitry Torokhov
	<dtor@vmware.com>, <virtualization@lists.linux.dev>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <sargun@sargun.me>,
        <jlinbox@meta.com>
Subject: Re: [PATCH net-next v6 1/8] vsock: only undo SS_CONNECTING when
 connect() fails
Message-ID: <avusfpnZuzMV3WxB@devvm29614.prn0.facebook.com>
References: <20261113-vsock-guest-ns-v6-0-3737ce4673c0@meta.com>
 <20261113-vsock-guest-ns-v6-1-3737ce4673c0@meta.com>
 <6bdfe6f7-aba8-4fb8-ac24-62fe020e1422@rbox.co>
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
In-Reply-To: <6bdfe6f7-aba8-4fb8-ac24-62fe020e1422@rbox.co>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDAwNCBTYWx0ZWRfXw+sA7WyR5fAw
 TXovZZcIazZICOswjUfauPnRZHKFDpY4OamNG3a9JpkvewckKGNTvzKwEdnOguhJtqIYtYFUORE
 Oaf8zJKi9lKXWEz7SKlSSR6GOGUZ/9s=
X-Proofpoint-ORIG-GUID: KMXLMYJs4-5j-kqvUpTGAlw7R4_j3K2w
X-Proofpoint-GUID: KMXLMYJs4-5j-kqvUpTGAlw7R4_j3K2w
X-Authority-Analysis: v=2.4 cv=SuoFe/O0 c=1 sm=1 tr=0 ts=6afbac80 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=8elwO82fXORLTBIkMd32:22 a=VwQbUJbxAAAA:8
 a=VabnemYjAAAA:8 a=LG5T7v2SAAAA:8 a=He0p99DsmHbbqY9DTv8A:9 a=CjuIK1q_8ugA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDAwNCBTYWx0ZWRfX7m85Y5zQnTEb
 cMVAlqDIp0L2XulWWy+37PM46rNDD2UY88oV3B2zR4ZtJPzZP+9UGqIVwRIIlZXTvIQx3EiZDC4
 gnkFY9xidHqSP4RoTbA661mzuoizyd7SYwiNmLi1KDMmkzkgvlQ4Kp61rXBcobVCl/zKyBVil60
 7am3E8oOWIzMZlEajob5IKnlA3kjYWd5+OTUfZg7Wa/QtQBIWSXnfLK7a1ng8uVvNECyQ0aqPDD
 UH6C+hqMkjYARmkePb09z0KEEQ85Tg1J1V/c8BTRcJnODLrf2uy/E5mHretdmt9JQuCEKwf63G+
 4lCbtvEVGeaZ3Bt2v1anQCC47V5lYoFsR5hPoMxkbtl86hPzsvl7VC9+9h4ir4te1TUs3X5BUNa
 tGwOB75rcksb/sblhi6g3vr6FErZTmmr8tAv5tODQC+Gg5tnvGhAZVQDMsqHhMfWVpDYLdPgNV+
 a7jxS+n385ic9UFqJEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_07,2026-11-16_01,2025-10-01_01

On Mon, Nov 16, 2026 at 12:10:19AM +0100, Michal Luczaj wrote:
> On 11/14/26 04:14, Bobby Eshleman wrote:
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
> > Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
> > Suggested-by: Michal Luczaj <mhal@rbox.co>
> > Link: https://lore.kernel.org/netdev/179447093204.2199510.8895677421994612994@kernel.org/
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Reviewed-by: Michal Luczaj <mhal@rbox.co>
> 
> Thanks! To be precise, the Link: above is more of Sashiko's musings on
> what's wrong with Jerome's (not merged) patch. The patch of yours makes it
> moot.
> 
> I believe the first time lore mentions the issue at hand:
> Link:
> https://lore.kernel.org/netdev/20260909-vsock-connect-reset-closing-v1-1-50298b9ccfbf@rbox.co/
> 
> And there was at least one report off-list, so:
> Reported-by: Kyle Zeng <kylebot@openai.com>
> 
> BTW, I've noticed Sashiko already commented on this patch. I feel I'm
> responsible for that wall of text, so I took the liberty to reply. Hope
> this will help.
> 

Got it, will address this. And I think I will actually break this out
into a separate fix for net instead of net-next.

Yes, I much appreciated you responding in the Sashiko thread! Thanks!

Best,
Bobby
