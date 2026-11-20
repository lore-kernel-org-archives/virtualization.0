Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198107;
	b=Sv/EMJ/lkYoyHdnBAjerj/pc8ErRlNdGUQyq9WD6DjZ13BBgL46iU3sEmNv1kf/jtJDo
	 sZ1U0xXZ3GswY0jsg34DH8t5W57oBN5hNG8D5s0It70op/8+e91PW2b1llQY1TNbrnvg6
	 PTzbhxNqzzWSBNET9LsN1yqtYTs95Kvi3y+z4zv0fHBhfdsMTJOFW775n7ZslbjAdtj/D
	 2Qqlk2qFGQmQ59hhEUj/2+cXKThRVKrD/ip/PhMag95vu7B+GhJcQM1Q2XwoKorbixz8W
	 a3ZlQhReNMmJnVWWtDXPKgRQIT+DOowfyM/PbN8Mqotwmaa+DbQ4IlTy+cyzZpuGksQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198107;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 CC:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Originating-IP:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version;
	bh=0lbcaJ8L0yzVbe6zUbN1cAVyzh8iJfnZ5U61Z9GQ5bo=;
	b=IU4c4gt3oOWnFBzI/v8CvQ3wmSWVSc2OHttJr/wM42RMlah7k5spsH3VtqBTeyg06vq3
	 zCPyz6MN2kJc2iYxs+mR+08FhS+g2zPosp8KZfh55wdCwWiAgesd+A3QZI6Iu0mJYHW0t
	 890qHpDbE/CbJoFhJE/LojzpytZkzuXKFVr/AEWAMaMbLB3v+dfsFZFTusuJuGkyiU6NR
	 JBpCXg6MCHDIh5xVH73Ctsl95nVdZInKk//BNvBT/ygPcaq8RmGNJ2MTGsOPG6BZv9YZS
	 SQnwqBHgq8b9S1+Emrx0uC8I0rsEfooOIU3/nDySW5iXZ3631O4SjTta6typLDaqcBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=OnnzqY9b;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B7C606A89F
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 18:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51B7C606A89F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=OnnzqY9b
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKH3c402027770;
	Fri, 20 Nov 2026 10:08:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=0lbcaJ8L0yz
	Vbe6zUbN1cAVyzh8iJfnZ5U61Z9GQ5bo=; b=OnnzqY9btO1a9LoHSl5f9i07I2t
	3DSWQV5THMV//yn5ZW1IT8Jd9wUYh+nd8u+gE855io3Xb0jr0EXjdj9U9xgsnIVv
	wwM4HEXWhi3jA8GaUkqYyW2JWjo2nG/XPYEPpcxVcvH3q5BH7gY7BBT7cmaC8pZI
	+8gOkP5TdeNwK7gMBIkzJDVv3gPGjODbl+fNM4k4qBv55nenlV9RCie02O4LPdRR
	Sj4/EQb+48DAm8erItCCl48BeebChJICwA+S2hqGcWPb3dk+zoE1u9ChORcsTe6T
	qUTnjiEAZpi5rfNx86cTDPglLAD4hWssvOf4BDXBrE49s3H+M31uXzv6ZGg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j2t99rm3a-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 20 Nov 2026 10:08:05 -0800 (PST)
Received: from localhost (2620:10d:c0a8:1c::1b) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Fri, 20 Nov
 2026 18:08:04 +0000
Date: Fri, 20 Nov 2026 10:08:02 -0800
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
Message-ID: <awCMglMftdwqzDu1@devvm29614.prn0.facebook.com>
References: <20261117-vsock-guest-ns-v7-0-7e522ea9dd9b@meta.com>
 <20261118182846.4ab756d1@kernel.org>
 <av807G4qhzToOIMT@devvm29614.prn0.facebook.com>
 <20261119135303.54642e8e@kernel.org>
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
In-Reply-To: <20261119135303.54642e8e@kernel.org>
X-Authority-Analysis: v=2.4 cv=LvQHWXdc c=1 sm=1 tr=0 ts=6b008c85 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=xtH7KyWI9dI7BmFOsl-x:22 a=VwQbUJbxAAAA:8
 a=VabnemYjAAAA:8 a=oC9WaInZJ1af5pm4xKkA:9 a=CjuIK1q_8ugA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: e_pV_QEf9KJrrYzdE5m5xEFAncVLEaKF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3MSBTYWx0ZWRfX1Sc4JYQvrjPd
 uM07N837UQp0cqrLl62gDESgLL4sknWLgK/6A6ZG/QQwoRK54pAgk+qJLgoRXbxud+sxyO6pwIR
 +zwh3rsC9HWMNTAowk/o+0w0QAYEaEZBaaFXBCnPyU6vaeOoMnv0rZzTy1Ht6eADYSlviSHyYgR
 UFWL69qGbI/qaFx+tImhd7u2rF5w8u8r/FEbXQHoTCwUlgY4kbDLrHFun5Nv85Ljj9xb5oEdOUf
 a5ZpHSy+b7pJQGX1zJ5pNkQNjj1ZZSHUuKzL2STpBHgkn0zzrJf1PZwl3q2zozhxCtE6nPuqMzX
 il70beOuSUz3bthbq/lhQnUgQK+F/ZQ/SvBCfG8Bo9mviiBViSE6cn1cYvt1IdAzmGgwkWxvQw1
 atyTgr2PyeXH1CZ8RW9ZLTVlRQi784tl7X/b6ZPxuwEQ6kdtQdGv++CxeSvNM9CCzigHPy5X0i6
 6ruMSdLg8RLAYt/VgRQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3MSBTYWx0ZWRfX9HizSq1mZ519
 RZHw+lNUbZSx9VF6cG8jmYvt8YDCHlbgcDrKoeIcwwe8Ic6c/MgXSblrkOb5wMxHaqf9F4nvbol
 8mWWGK2fqageO7BIl0moSZ9dxhaJpZk=
X-Proofpoint-GUID: e_pV_QEf9KJrrYzdE5m5xEFAncVLEaKF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01

On Thu, Nov 19, 2026 at 01:53:03PM -0800, Jakub Kicinski wrote:
> On Thu, 19 Nov 2026 09:42:04 -0800 Bobby Eshleman wrote:
> > On Wed, Nov 18, 2026 at 06:28:46PM -0800, Jakub Kicinski wrote:
> > > On Tue, 17 Nov 2026 17:54:43 -0800 Bobby Eshleman wrote:  
> > > > vsock network namespaces let a host put each VM in a namespace of its
> > > > own. A guest has no equivalent yet. It has a single G2H device that
> > > > cannot be assigned to a network namespace.  
> > > 
> > > PW says this did not apply at the time of posting, pls respin  
> > 
> > Ah I forgot to call out in the cover that this now depends on this fix in
> > net:
> > 
> > https://lore.kernel.org/all/20261116-vsock-tap-net-v1-1-7e24f45adad3@meta.com/
> 
> If there's a dependency the posting has to be an RFC
> 
> > In that thread Paolo is also wondering if it is really an improvement
> > rather than a fix, which is a fair take, so unless there are objections
> > I'll just pull that patch into this series.
> 
> No need to repost that patch, we can apply it to net-next as is.
> The blocker is lack of an ACK from the vsock maintainers from my PoV.
> Please just wait for the net[-next] patch to settle, don't repost this.
> Enough noise on the list.

Sounds good, I'll wait for that patch before the respin of this one.

@Stefano, IIRC you may be on PTO right now, but if not do you mind
giving a look at
https://lore.kernel.org/all/20261116-vsock-tap-net-v1-1-7e24f45adad3@meta.com/
?

Best,
Bobby
