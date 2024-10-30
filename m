Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4985194A73
	for <virtualization@lists.linux.dev>; Wed, 30 Oct 2024 09:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730279906; cv=none; b=FRF26aKZuVTd7xHJUdBSs+2KocEmXKd4bOLE6875X/CmeQ7MAkzIEXpXQwT4EvNUg2u8PEMRG1SyUUf8BgocHNOOggzJ/BJxyUAVJcnQVmT5cKs+gdb3qOsvT8mpE4vpdd99N1gVR0Bqo5mY/3GHK81Qh8hlmFaDjfKedWgCnnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730279906; c=relaxed/simple;
	bh=mrzUihUwK1kLG+bYYOGkwULFloc6lD3FUZNPd5rYjSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBH6UfGDOa4mfrVkQLnRG6xRr74OEvqC2Uwiaii8Zz57IEUepQ2iz+6PJknW91TjqGwnUbfTM5IgL/DTuLNOKy2xdC0wz31Ayb8TVm54krzUKuwWIXAtWfqMSHz6LUxfSorQ+2USys3gD5FARkp2/NrXOIIBtGYnClnmbkC7PrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jj/uDHjk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jj/uDHjk"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49U2d3BX003176;
	Wed, 30 Oct 2024 09:18:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=jqu18WWYA7mw0ZGNsF1kdxCvtmyRwS
	c6a2CbR1IFlB8=; b=jj/uDHjkkjLhSmhyTR5vc1Q3am/xkkBWxLTUI+Pup5Fe8V
	WCsIq5eb6poelcJKbph8X+6byZTLeomNpyjmmx03Oroc/a4xEFD6d7JOZ13roQR0
	Ni20wPPskTGGXGhiMYyDxGOSxqhRZ4cKAx/XhqiWKiuYjBIC2JGYcPe2ILVV0gDK
	mb7gNAvF1SdJ+M9Fcvr3YejR3izwRI2ff9YFVvMxbJAoZTLcDnw4Aq/PvQD5FqO5
	tJl6fZ9zj559VGoL9xWwq48oNDigLdr6OIKZGUf82JyFFP73nJ20bpsodAFr9aol
	XzFiHn8DvyYrl4wlIQSXdqq5piMTxj4IzLDCtkKQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42j3nsx8ee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 09:18:18 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49U9IHCM006146;
	Wed, 30 Oct 2024 09:18:17 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42j3nsx8ec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 09:18:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49U7pooi018404;
	Wed, 30 Oct 2024 09:18:16 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42hc8k78y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 09:18:16 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49U9ICFd31588748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 09:18:12 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8236320043;
	Wed, 30 Oct 2024 09:18:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E764620040;
	Wed, 30 Oct 2024 09:18:09 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 30 Oct 2024 09:18:09 +0000 (GMT)
Date: Wed, 30 Oct 2024 10:18:07 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3 1/7] Documentation: s390-diag.rst: make diag500 a
 generic KVM hypercall
Message-ID: <20241030091807.6264-C-hca@linux.ibm.com>
References: <20241025141453.1210600-1-david@redhat.com>
 <20241025141453.1210600-2-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025141453.1210600-2-david@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xbg5UVAt4jfMY0OkVx_kJRYkSZy8lNGS
X-Proofpoint-GUID: ANSw34wLFtb4MLTfjsXS-gU2XHH8XCJ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 mlxlogscore=440 clxscore=1015 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410300072

On Fri, Oct 25, 2024 at 04:14:46PM +0200, David Hildenbrand wrote:
> Let's make it a generic KVM hypercall, allowing other subfunctions to
> be more independent of virtio.
> 
> While at it, document that unsupported/unimplemented subfunctions result
> in a SPECIFICATION exception.
> 
> This is a preparation for documenting a new hypercall.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  Documentation/virt/kvm/s390/s390-diag.rst | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
