Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795110143;
	b=aqc/r4xhA0MRd1gMEkUpb21tqsVAAuoZMULMeY3+CJNMN98k1Mh98hXG4S1EYQ5ASarO
	 d1/iu65US9YAoSn8EhK2nINsIlTA9KVSxtOUkHrz7SzGIhHf2cgD7GSxYquqnxbR6o5CE
	 kfBNqnvVMI7plf6NgBzyeHjVo/HAEOaNxg81kaCRVSPkPjyRtkWvEYABnHAGtZDx/+7gi
	 Sayzfi7VYo+2ZbEcMi/JIhI8Ye4LK3Xoyk/sVishZy2C70fBR8IL1iy2c87+/E8tjd85W
	 9Y+DAiJpxY0cYneGP8B8rAO49hEaocVjoRcjWvN5cKJfk4AEcILJGDMkiNxigVmN5Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795110143;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 CC:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Originating-IP:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version;
	bh=G2BOqqjoP0pazrgA6aUayConw0OIxAUKTfBLvDGlW30=;
	b=Nt79I8dyQ7A3FuHSsYQF/r5eVLkY3Q8esY1U22ABW6j/K+BlEM3QorEtMFq3xyV1Zlir
	 nyg8yPPGO0ci4iU/0ylZiwurDPM0Y0q6tMd1kEaXOdeoKYaF/pVLgqYbxkNVyvqgDZGiw
	 uDgrwTiAcxzcTFC/6tYo2L41Ptk6PA9/rFBKxbezomfw/r+s3Lm/2dRf1kp8iufU1PS2C
	 2LI3efB27Do6INr0aMgw98gOuOoqkc9faQOmQHn4ThYfOosTKraR0ZQ8p/GJ2K6BbuTuz
	 pJ74o5cpwa2Epb2Bd5ZfoJfNiNskugRmjK6YhiDOv3d/xqmW8gAElARGuO4caf7R3+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=f67K80ZS;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4490606A320
	for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 17:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4490606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=f67K80ZS
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJF8ilo3223786;
	Thu, 19 Nov 2026 09:42:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=G2BOqqjoP0p
	azrgA6aUayConw0OIxAUKTfBLvDGlW30=; b=f67K80ZSKWqYAuowzLy9IVSzeoZ
	Jhqpfjn7ERXrdfOGJtkZRJhqKb41AqVF0IukKEp4ZJWCAu/EMJpKJThcRR0j7p41
	A0BYLgXK8jU8/BGuEZIzrWUQZNvT6OZckOevsR2QS0dJpb+O0CaSdMmJuNxljZwK
	ZKiMMRV+SPUwiFWmJfRSkW3Hofcvus3oFPCZP0TAooTbYQw61pvul4wDahUio/0Q
	+dUkR67nKYDctfo82jJfAH7fI+v7+VLhPHErPhhklqOhuLdDL/Szlu96h5uzocRD
	DHmLsTQzZxj1CKqeU3g5W8i0t3+mbbdZH+6BnsTKoRtF7uCtY8C59wPa7Dw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j20a530um-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 19 Nov 2026 09:42:06 -0800 (PST)
Received: from localhost (2620:10d:c085:108::150d) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Thu, 19 Nov
 2026 17:42:05 +0000
Date: Thu, 19 Nov 2026 09:42:04 -0800
From: Bobby Eshleman <bobbyeshleman@meta.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Stefano Garzarella <sgarzare@redhat.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan
	<skhan@linuxfoundation.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael
 S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowangio@gmail.com>,
        Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>,
        Eugenio =?iso-8859-1?Q?P=E9rez?=
	<eperezma@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Randy Dunlap
	<rdunlap@infradead.org>,
        Donald Hunter <donald.hunter@gmail.com>,
        "Eric
 Dumazet" <edumazet@kernel.org>,
        George Zhang <georgezhang@vmware.com>,
        "Andy
 King" <acking@vmware.com>, Dmitry Torokhov <dtor@vmware.com>,
        <virtualization@lists.linux.dev>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <sargun@sargun.me>, <jlinbox@meta.com>
Subject: Re: [PATCH net-next v7 0/7] vsock: assign the guest vsock device to
 a network namespace
Message-ID: <av807G4qhzToOIMT@devvm29614.prn0.facebook.com>
References: <20261117-vsock-guest-ns-v7-0-7e522ea9dd9b@meta.com>
 <20261118182846.4ab756d1@kernel.org>
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
In-Reply-To: <20261118182846.4ab756d1@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA3MCBTYWx0ZWRfXyidvreKQk6wK
 LlsF+SzTNY4ng9p5UNHi4tKeuhAuveilzAk/9KDdvz7cb/zyJffKxNKgHO+q8eFIyJZNfroiBIt
 UlydNSUgnv+PcWKUhxFYJK8Tv4ycfpX7TqNh29IAyJ5JuoZvObkdT3mhZ79LR8dctDOmKhBrzdo
 EiZuyCeCrOaL2GpTLBLBo2i1VID9Hw1Xu9QUxt04sc617I6tGq9oGcxYUYlR4VMVLBvnOrrHeAt
 SkES8ZFl0wxhH96yl7klR7d6Wknofcd/ak5GkGU87mbXc1EtJ0VxEGuOLKT4gsSN1wWFfuaD86I
 cf4HdvpcUTFzuPK/bxpG2miO6NjG3x2VEdVTKfb7a7YFcjfa3uTC4XKsW0MAPytKwVXwK6WmCFt
 IPaGqZ0LQJv8W8b+KkSW54RiiFyxfPiVmTt/9G3uIYCpxWTUrrn4HlJTXbVtW5Z1Cv9+y8LYmGM
 d0nXoppYzMXNES4U3XA==
X-Authority-Analysis: v=2.4 cv=KrHYSmWN c=1 sm=1 tr=0 ts=6aff34ee cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=03ozwUkBphtHgyqjj1sw:22 a=VwQbUJbxAAAA:8
 a=VabnemYjAAAA:8 a=dqsvmvxRPFBq9XHrJFsA:9 a=CjuIK1q_8ugA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: HdmLTcJAmAU3n8_qiw1GLnU6knj5_445
X-Proofpoint-GUID: HdmLTcJAmAU3n8_qiw1GLnU6knj5_445
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA3MCBTYWx0ZWRfX5I3YUg6f0mmJ
 ubh0ZySQpuSIiBufNJibvmMRLApct+aSRPOkI6tUzQfGpUUvPXeQc3o0S7aX7rrK+1rxydIxf+q
 POEezORn5yAZnVmVQ15OF1eKcAvAaRo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_04,2026-11-19_01,2025-10-01_01

On Wed, Nov 18, 2026 at 06:28:46PM -0800, Jakub Kicinski wrote:
> On Tue, 17 Nov 2026 17:54:43 -0800 Bobby Eshleman wrote:
> > vsock network namespaces let a host put each VM in a namespace of its
> > own. A guest has no equivalent yet. It has a single G2H device that
> > cannot be assigned to a network namespace.
> 
> PW says this did not apply at the time of posting, pls respin

Ah I forgot to call out in the cover that this now depends on this fix in
net:

https://lore.kernel.org/all/20261116-vsock-tap-net-v1-1-7e24f45adad3@meta.com/

In that thread Paolo is also wondering if it is really an improvement
rather than a fix, which is a fair take, so unless there are objections
I'll just pull that patch into this series.

Best,
Bobby
