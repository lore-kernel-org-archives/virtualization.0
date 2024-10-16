Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADB5206055
	for <virtualization@lists.linux.dev>; Wed, 16 Oct 2024 10:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729075037; cv=none; b=Tb05KwYqS6gwURRmqqoo80dw+0UkFyRvmzGgquwODI9KKLdof8ZJU7XDsdNellEqMr306tcyW2H6RrDHjCi7Vps9jVOBwIEIQcmipXuhwIWQ41mZvfMuH3lMhYe2nPnaq+ZGvp4+RHjlycWM8BAARDvR9d2mQ6oYVN23CN6F+6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729075037; c=relaxed/simple;
	bh=PotmV07TYsdzBCkgsXti5FhmuYzcIq8RKvfDe6ByBpI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R9zoHX157MmmHzTg6XiN+0x2Qn2ulGWNFtDAFbrSYUpCJPlLBrBNTPK1I1i9j4gNmcovUGU+WBmeMBSyGCsCtCeJd+UHbkDah/j5Kx8cURLL15XAy1adekm3CG7JqAV05g+qsNGtz9YJEBWrW0jBO37La7dXCnaY9QRmhammSSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q45K40cU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q45K40cU"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GAKEWI023035;
	Wed, 16 Oct 2024 10:37:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zMeyJS
	0z7cn5JjFKCkgSbMvXgBCHzt6or6qpLiwiFAU=; b=Q45K40cUR2vLXWMfC1NfAw
	3W9w4L+9Wmtz7d1DOvF7KIZrrQHVUkrrP+0zBcp16g34JBH++2G7ot7vQY++mQgS
	5bWRJojDib/0i1n1YVPJ4WNZ8N74YLnQkZbKkhI5RsfLGPv4nO3XYMc0rzdBYyQA
	tg53sJwG5m6bhZlm8C6OTIfm4bekpYXr0ZacrXcQC4HY0YPhBuuOacC8zNX/nqRg
	dU+cppVGBrL7ApVDQdEBv2sxL9hNI1uZeOOmITYquvwWtXxVBxC/NR98bZgLT0fK
	Xay0Mr+nrttKPuensrB4bqaX4PWWyyIzcHzNgBeNBWzSJLjN848iN8RO/5V8mBNg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42abn0g2wk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 10:37:10 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49GAbAcC030714;
	Wed, 16 Oct 2024 10:37:10 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42abn0g2w6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 10:37:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49G81Lrc005215;
	Wed, 16 Oct 2024 10:37:09 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4285nj8kqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 10:37:09 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49GAb5vm54985128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 10:37:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7ED8F20040;
	Wed, 16 Oct 2024 10:37:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3953A2004D;
	Wed, 16 Oct 2024 10:37:04 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.171.7.78])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 16 Oct 2024 10:37:04 +0000 (GMT)
Date: Wed, 16 Oct 2024 12:37:02 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Eric Farman <farman@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, David Hildenbrand
 <david@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        Vasily Gorbik
 <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian
 Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
        Cornelia Huck
 <cohuck@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio
 Imbrenda <imbrenda@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eugenio =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Andrew Morton
 <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mario
 Casquero <mcasquer@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2 4/7] s390/physmem_info: query diag500(STORAGE LIMIT)
 to support QEMU/KVM memory devices
Message-ID: <20241016123702.04688e2d.pasic@linux.ibm.com>
In-Reply-To: <8131b905c61a7baf4bd09ec4a08e1ace84d36754.camel@linux.ibm.com>
References: <20241014144622.876731-1-david@redhat.com>
	<20241014144622.876731-5-david@redhat.com>
	<20241014184339.10447-E-hca@linux.ibm.com>
	<8131b905c61a7baf4bd09ec4a08e1ace84d36754.camel@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: H5ULsniXk0Rfka_9RRyv3agVS3JiWal7
X-Proofpoint-ORIG-GUID: FKcGPPcfDhFwjLM7_HrSq6Zn3U2EPmeB
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 priorityscore=1501 mlxlogscore=919 lowpriorityscore=0
 clxscore=1011 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410160065

On Tue, 15 Oct 2024 11:01:44 -0400
Eric Farman <farman@linux.ibm.com> wrote:

> > +		  [subcode] "i" (DIAG500_SC_STOR_LIMIT)
> > +		: "memory", "1", "2");
> > +	if (!storage_limit)
> > +		return -EINVAL;
> > +	/* Convert inclusive end to exclusive end */
> > +	*max_physmem_end = storage_limit + 1;
> >  	return 0;
> >  }
> >  
> >   
> 
> I like the idea of a defined constant here instead of hardcoded, but maybe it should be placed
> somewhere in include/uapi so that QEMU can pick it up with update-linux-headers.sh and be in sync
> with the kernel, instead of just an equivalent definition in [1] ?
> 
> [1] https://lore.kernel.org/qemu-devel/20241008105455.2302628-8-david@redhat.com/

I think it is fine to have equivalent definitions. This is more or less
an ISA thing we are introducing here. And IMHO it would be fine to have
such a definition even if the emulator was supposed to run on an OS that
is not Linux and without without KVM.

Regards,
Halil
