Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B58622259C
	for <virtualization@lists.linux.dev>; Thu, 20 Mar 2025 14:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742480355; cv=none; b=LFxhcepRH0AE78ivWyz0z/eSgAVqqlQHPmm7YtY+j5AcJAXbnBDXAuzQeo39X7p3/2qaRFXRnrg3W9eZrvG3jXdtKK2nYLLQq678CZIrSlFrZOc45BPdWDbx0nTaB6O8zrHvr0UyO0TYVzAkxWIw98zXlQmNAkDVYDHgn8oTDo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742480355; c=relaxed/simple;
	bh=5aTg2hG1xVgTq2UspKqDoiXmNZ1caYSIIgvZaYnc9oY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FY5I6CGcpKwXKoEBJxzhuyyEiYYZ2ew51vdbLb+KMs88b06sNU2eJqyXehs75oApwgz7na4zwLq4fRWj91zL4cNta0D3TrZ4Tni67ZvQkruHwV1GAuNn3S8heJY6FOtAZZXcFrZ05D14l+7qzJjsTayhIdSEHWFiBEHKW36WpKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TDGA4DTC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TDGA4DTC"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K6qgIG030285;
	Thu, 20 Mar 2025 14:19:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Q5PhqV
	NMVCf6UJWarlXHiI8rghA9oQRQs5oaYAEkGlE=; b=TDGA4DTCDT4dNs8KAWWLLS
	fiGyXaoZVmrUtt0NxGbQLatCN4tC0I8kg6t1yUU2VuQCE28zgrAfnPfP0kvZ7yK+
	YTHqASDXryqUL0NRROG2kJGSz8a0+h4gUyp9c5tC8ZPAAXTOw+F4NZx5OyP04f6U
	1gyPi4nrdVMofRHUVAypTGqQg8ZVvpkFvIptsaGyqo1hkONETGT2z9dcaP9kPt3H
	i+fRUCzeuudeO6XPKaUe7mt31m0qivKtZpr8ZfXvXnT3zIFsbAOZivVPgnRngWhS
	BCgBaY2MmzmYBqAFcZb1B4K4bTbs2vAr7/tsKw8eeCCI7bunLx61d0YAGfS59x7A
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45g53qchy2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 14:19:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52KEB19b005659;
	Thu, 20 Mar 2025 14:19:06 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dm908gw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 14:19:06 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52KEJ2LV35062502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 14:19:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5F8220043;
	Thu, 20 Mar 2025 14:19:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A55B20040;
	Thu, 20 Mar 2025 14:19:02 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.152.224.212])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Mar 2025 14:19:02 +0000 (GMT)
Date: Thu, 20 Mar 2025 15:19:01 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Amit Shah <amit@kernel.org>,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        arnd@arndb.de, gregkh@linuxfoundation.org, brueckner@linux.ibm.com,
        schnelle@linux.ibm.com, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH] virtio: console: Make resizing compliant with virtio
 spec
Message-ID: <20250320151901.4906e2a9.pasic@linux.ibm.com>
In-Reply-To: <20250320150957.0507abb5.pasic@linux.ibm.com>
References: <20250225092135.1200551-1-maxbr@linux.ibm.com>
	<f5ab160dadc2219b9576e50588dce88f22e9bcb1.camel@kernel.org>
	<649563cf1b8abd42401ed78d84bfd576d48bdbb8.camel@linux.ibm.com>
	<f27debf87882df65574f21cfced31fecf1dd1da3.camel@kernel.org>
	<dc3ff60fd16e5b5f94c12cf6a5a7893b94f705a8.camel@linux.ibm.com>
	<20250319105852-mutt-send-email-mst@kernel.org>
	<20250319181308.365ee0ea.pasic@linux.ibm.com>
	<fe72c90a59354f2507c1d528c4e5b8562b20a3e8.camel@linux.ibm.com>
	<20250320114120.383a706f.pasic@linux.ibm.com>
	<dedc20f946d50bc2b45c1f974554001495657f37.camel@linux.ibm.com>
	<20250320150957.0507abb5.pasic@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cQCp618t5ybaD5w7tt6_FxRmhNJn1glG
X-Proofpoint-ORIG-GUID: cQCp618t5ybaD5w7tt6_FxRmhNJn1glG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=689
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200087

On Thu, 20 Mar 2025 15:09:57 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> > I already implemented it in my patch v2 (just waiting for Amit to
> > confirm the new commit message). But if you want to split it you can
> > create a seperate patch for it as well (I don't really mind either
> > way).
> >   

Your v2 has not been posted yet, or? I can't find it in my Inbox.

I understand that you have confirmed that the byte order handling is
needed but missing, right?

> 
> It is conceptually a different bug and warrants a patch and a commit
> message of its own. At least IMHO.
