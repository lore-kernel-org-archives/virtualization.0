Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1121EF394
	for <virtualization@lists.linux.dev>; Wed, 19 Mar 2025 17:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742404409; cv=none; b=sX+lyIk8jkFUsv4UZbXqdySyJnrsqaUOnTb3neqgPDDusldP5XjRz5npsAxnYbuo6RYx4SK0DGRZtDoGGTyiAKAPUSd6o1kxcU/AcFxckrTN6iF76dUSYW3JI/IA84eByaB7jDnYVmLVLnldR29+uuOfwqM9pUeWLoQ96+8U+DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742404409; c=relaxed/simple;
	bh=IAjut6kA6biRQj8j/Er7jEHY1eriV31CNC9TAMH4rNM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tKXFcQJrcLaYMM/m/+HPFhJjhDwI+ZaALS8ei9hgTpFlQPlHsctYDpGpaZW/5NRLIysUd5+dx3oO1aVZ/mqNLDZy6Lep9ovBSLvjHIFzu0LkH/CUSP5m2b182eKwreuSTPYy21HUiWSlpC0ShKKQmaGTh/Kv2JAwK12hSnlxJrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Nye3yCmC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Nye3yCmC"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JAKBp5014576;
	Wed, 19 Mar 2025 17:13:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RsCNcM
	qK04N1b38eos//s0uJB0c+0qaqrQjFA+WVsks=; b=Nye3yCmCWXcFXX3yVfbJz7
	Fp+ismWImz1pwMiiDCGSS71jcPbaI1eKwdday50b8RGRrHbddUgz8KT3DDznWsV/
	N8KNdKCu/9hSU1PCNntIGaB6jicr/+9YYs3DMOCMrHPAKj4+u0HeHZ71tlzF3ACz
	y6ZOuBPteGDG3TqJpGAnJpoxiEfQZWILQlGCVhSWm0SDL8ndR5vhjWPRU8VbeBEu
	i8vvF+t87ISFmu17tj4ToMt2cO4NzaW8UtaiEyxE+BmxGSTI5zgfqtAj8AhUdxyC
	P1997TFqU/oRVnIOBZsMYjKHka5bQgJae3r5AJn2QBkinBC+Mg7YZzsmwX6EQAvw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fg0pw66j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 17:13:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52JEjkNX023214;
	Wed, 19 Mar 2025 17:13:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dp3ktjdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 17:13:13 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52JHDAVr20971836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 17:13:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C22D20043;
	Wed, 19 Mar 2025 17:13:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F2B320040;
	Wed, 19 Mar 2025 17:13:10 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.152.224.212])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Mar 2025 17:13:10 +0000 (GMT)
Date: Wed, 19 Mar 2025 18:13:08 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
        Amit Shah
 <amit@kernel.org>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev, arnd@arndb.de,
        gregkh@linuxfoundation.org, brueckner@linux.ibm.com,
        schnelle@linux.ibm.com, Halil Pasic
 <pasic@linux.ibm.com>
Subject: Re: [PATCH] virtio: console: Make resizing compliant with virtio
 spec
Message-ID: <20250319181308.365ee0ea.pasic@linux.ibm.com>
In-Reply-To: <20250319105852-mutt-send-email-mst@kernel.org>
References: <20250225092135.1200551-1-maxbr@linux.ibm.com>
	<f5ab160dadc2219b9576e50588dce88f22e9bcb1.camel@kernel.org>
	<649563cf1b8abd42401ed78d84bfd576d48bdbb8.camel@linux.ibm.com>
	<f27debf87882df65574f21cfced31fecf1dd1da3.camel@kernel.org>
	<dc3ff60fd16e5b5f94c12cf6a5a7893b94f705a8.camel@linux.ibm.com>
	<20250319105852-mutt-send-email-mst@kernel.org>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RlE0oyKHYFLv8Z_-Ctd2EQediNuR3Sg6
X-Proofpoint-ORIG-GUID: RlE0oyKHYFLv8Z_-Ctd2EQediNuR3Sg6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_06,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1011
 impostorscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503190111

On Wed, 19 Mar 2025 11:00:06 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> > > I was mistaken in my earlier reply - I had missed this
> > > virtio_console_resize definition in the spec.  So indeed there's a
> > > discrepancy in Linux kernel and the spec's ordering for the control
> > > message.
> > > 
> > > OK, that needs fixing someplace.  Perhaps in the kernel (like your
> > > orig. patch), but with an accurate commit message.  
> > 
> > So should I send a patch v2 or should the spec be changed instead? Or
> > would you like to first await the opinion of the spec maintainers?
> > 
> > The mail I initially sent to the virtio mailing list seems to have
> > fallen on deaf ears. I now added Michael Tsirkin to this thread so that
> > things might get going.  
> 
> 
> If we can fix the driver to fit the spec, that's best.
> We generally try to avoid changing the spec just because
> drivers are buggy.

I think the call if fixing the driver is possible needs to be made by
the maintainers of the driver. Fixing the driver IMHO implies that
if this is seeing any usage in the wild where it properly works a
fix on the driver side would imply a function regression. But any
implementers should have complained. So IMHO it is not unreasonable to
assume that this is not seeing any usage in the wild.

And people would still have the opportunity to catch the regression
during testing and complain about it.

I agree with Michael, changing the spec because of a buggy
implementation should rather be the exception than the rule. And AFAIK
it is not like we have declared something a reference implementation,
so in that sense the implementation in Linux is just one implementation.

I suppose making it runtime configurable via module parameter is an
overkill at this point.

So based no what we know I'm slightly in favor of let us just fix it
in Linux and see if anybody complains.

Another thing I noticed during looking at this. AFAICT Linux does not
seem to handle endiannes here. And AFAIU the message is supposed to hold
le16 that is little endian u16! Maximilian, is this in your opinion
something we need to fix as well? Or am I just missing the conversion?

Regards,
Halil
