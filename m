Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F096C6EB79
	for <virtualization@lists.linux.dev>; Sun, 13 Jul 2025 21:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752442419; cv=none; b=SRMZvGm85kAYgX92X7jrAoBB68yYbaoNyDXGU/oTzV1O0NjuttHvL/ZVFpVnqKGooQPOr0CZzTYyL5u2pnjfqrUSyZEgJNTabD+/ozzubPV/ZtaEl+VYXb1CFHuHKFKGuZ9aaO0OLuhqh2zWi+zNxhph+pDCy0t7lnwn/EszNTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752442419; c=relaxed/simple;
	bh=9miPHwpn8nq14baVQAOZjpSRxHsJQkqJ8AOESi4cE9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J+xv4zfgu0knVnDX4GQLMyL/XA6OlIrap1NCU82LIeDXXW0rMtdawCSwawqRw6y6JHMmvjJyrWtzdQPSwgFL9DBKhR70GpsGh+AsKoxdwqyUHKMoc3f9mkQGh1QsaEe93dvr3TxxLZg7D/1QXonpfkKnCOTm7HB5y0l+uiN2Av0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rjLcvpBz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rjLcvpBz"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DAkgQx001869;
	Sun, 13 Jul 2025 21:33:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CG496P
	usav3IjXOQLJBeuwEaOkRI9A3AnG79tEMdxAk=; b=rjLcvpBzddDK7obil9zmsW
	g0mt8TBkdKIo26TwwTfljyutFWSo/4HqHM7fC+xIadh13e/iE3BZ/1XlCwM3XvRR
	0XFF6Q9zX0Ec3G1pZjB1wMSAtrRoQMwAqGGuzYHXLOo4rlWM5D5IHWBaR7mcl5Lj
	AJ4Q52c7NbYGyIVYVCpCAbPkvEb/2FYENqlT7MRhuOrbkqcOnyHtolaIpr6JI+M2
	FU+IOzp6ccla8xZwEGBSLDZIG6dfVo+/MA+QNCMSGrFpdHdkIpNOXRznZUbL+KlK
	z/QldOlxHtA5UiEz47K1vJkg66vQ0ECpg8HqHdkEx/mArMAL0K3BMuvHFmpL0ksw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47vamthm1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Jul 2025 21:33:31 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56DLXUZW014797;
	Sun, 13 Jul 2025 21:33:30 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47vamthm1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Jul 2025 21:33:30 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56DHAjvN031905;
	Sun, 13 Jul 2025 21:33:30 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v21tubcy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Jul 2025 21:33:30 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56DLXTfl38601282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 13 Jul 2025 21:33:29 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00DBC58056;
	Sun, 13 Jul 2025 21:33:29 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEEBF58052;
	Sun, 13 Jul 2025 21:33:28 +0000 (GMT)
Received: from [9.61.242.231] (unknown [9.61.242.231])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 13 Jul 2025 21:33:28 +0000 (GMT)
Message-ID: <ae225e65-0a13-47a8-9bfc-0f8497af2e58@linux.ibm.com>
Date: Sun, 13 Jul 2025 16:33:28 -0500
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] virtio-net: Fix VLAN filter table initialization
 timing
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: yin31149@gmail.com, eperezma@redhat.com, mst@redhat.com,
        jasowang@redhat.com, virtualization@lists.linux.dev
References: <20250713-vlan-v1-1-a3cf0bcfa644@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
In-Reply-To: <20250713-vlan-v1-1-a3cf0bcfa644@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JfBJut9YC3CKZojC9E9X9rGKpoDQWc-4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEzMDE0OCBTYWx0ZWRfX/F1DNokVXbIP zlNR4otXaHQ2qarFnM1S1IL7DHJJ824oEXQWBrqGwm9Ne2clYKatsA7Ar69AlhM5yIc2IdLEtZu fhbF2KME6vpdyeYgp14lPAWUGwoXUUnRFerOM5K15WEGgoWaMAdLS1Gs3nYQp2gECMheAD4aUBe
 mum9IBVWdIQZ7/aKpLHnSMln9Yqls0MlOEYG/EQDSX7mQ+eOSBvG76lsxWurKBaGrUafh6D6rNO DFRe/Lxn08GoNx5IQZ21lNukJXLxYgArfLpnt/wbksY6Td/1WfJylCj74Ff08C8Y7upls23FhWz KZkkJQU9Ah5zcguUOIiHCT8+VxkLalil5qUohpSHE6LvGQGWRJ1r03aOznerZhMUrdMAqns06fm
 9PaIdgBV2+NtPXSpvhqsC65/GBKukifkJWw0Cph5qB3lhM7IhRssmUB+C3GpLqOn2vEKYWsc
X-Proofpoint-ORIG-GUID: -J4Oz2_wOQDDNm-IZZoNr9LLY2Q_gCRh
X-Authority-Analysis: v=2.4 cv=dNSmmPZb c=1 sm=1 tr=0 ts=6874262b cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=DozxDcYkCRIvZaggQ8kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-13_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=651 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507130148

On 13-Jul-25 06:52, Akihiko Odaki wrote:
> Konstantin, please see if this patch fixes your workload.
Yes, it does. It delays vlans[] initialization until 
virtio_net_set_status(0xf) which later also calls vhost_net_start() 
which is where the NIC is actually programmed.

