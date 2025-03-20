Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F46EEBA
	for <virtualization@lists.linux.dev>; Thu, 20 Mar 2025 14:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742479813; cv=none; b=MW1zKn6DYZorl8L+X/4rYkp8sIcyOOHquiRAW1Yl+hupjS0nYZyCYD+ikVG2tJLk2rx5M+nzfi52l5qPciFkmFfMYXWzD7HO/b5yzi59EmZyA2Cjl5c5g8TU8caMJ0GuEQxFDAFx7fwh6FlbWrI1sqV997YCDmZ5eyYX1t2tCAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742479813; c=relaxed/simple;
	bh=PilF8uXnEgKDLE3lIVx9AaEvUZ7IMCyNJL1wiptCT+I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KF2Oe42Vxw0hKFE2eLNMYMP28pEbPx5Eh/mprfNPpZIw6BapP2Aiu8KUqDkrg7sBuNKdSVj6/5hTomQVdwbXP/H4I8b4JPgpEXNXk9j5xbyGDmUoDk5Zu3wGGd3840J6d5TLh4rv/ShGzM2EE3wWldLvDcseiLgOwqTEi3oNh3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZbVideOz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZbVideOz"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KDQlss020835;
	Thu, 20 Mar 2025 14:10:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NDRzyP
	APHrDYgi76Sv3SMz9AWHRNF/cGpZzkbsSh504=; b=ZbVideOzW0op9zkZGi0QNW
	3Olbr/R13ScQ8SmitczcDNjEIVHkJ6bL8p5i4a9Kr2pcZSKXJF1XCIoRYkcSdTx+
	Znq+YyLpXYpdBMpW2fKiKyz4556B5pFBlFvNSE4fnmVIzd9E479tP7NQ3VTt1e8+
	17MGyUCsPDD+opLoxukqcV0dIwNf0+2+tAtEt5MYWnCZTBD2W++WKlQlxmaOgodF
	6rV3IIyBm7hjffu0kytM6i4x63hkM6tDfrP0T4jk6AFq+L2yftY3uA9PVpf+hhqp
	Za74oPT21n9Ks0mqdHT7zO/hzo9BKByhEHE/bHUxNLedXL4RbGnb9aABq6W1d/rA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45g23vdkm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 14:10:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52KCp2Mw005752;
	Thu, 20 Mar 2025 14:10:02 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dpk2qyh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 14:10:02 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52KE9xVm50594214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 14:09:59 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3116220040;
	Thu, 20 Mar 2025 14:09:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6AB82004B;
	Thu, 20 Mar 2025 14:09:58 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.152.224.212])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Mar 2025 14:09:58 +0000 (GMT)
Date: Thu, 20 Mar 2025 15:09:57 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Amit Shah <amit@kernel.org>,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        arnd@arndb.de, gregkh@linuxfoundation.org, brueckner@linux.ibm.com,
        schnelle@linux.ibm.com, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH] virtio: console: Make resizing compliant with virtio
 spec
Message-ID: <20250320150957.0507abb5.pasic@linux.ibm.com>
In-Reply-To: <dedc20f946d50bc2b45c1f974554001495657f37.camel@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 1XUZiz0f-N1UrD0K28atwDcA_EkhIo3n
X-Proofpoint-GUID: 1XUZiz0f-N1UrD0K28atwDcA_EkhIo3n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 clxscore=1015 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200087

On Thu, 20 Mar 2025 12:53:43 +0100
Maximilian Immanuel Brandtner <maxbr@linux.ibm.com> wrote:

> On Thu, 2025-03-20 at 11:41 +0100, Halil Pasic wrote:
> > On Thu, 20 Mar 2025 08:12:23 +0100
> > Maximilian Immanuel Brandtner <maxbr@linux.ibm.com> wrote:
> >   
> > > > Another thing I noticed during looking at this. AFAICT Linux does
> > > > not
> > > > seem to handle endiannes here. And AFAIU the message is supposed
> > > > to
> > > > hold
> > > > le16 that is little endian u16! Maximilian, is this in your
> > > > opinion
> > > > something we need to fix as well? Or am I just missing the
> > > > conversion?
> > > > 
> > > > Regards,
> > > > Halil    
> > > 
> > > Thanks, I didn't notice that, as I only tested this feature on x86.
> > > I
> > > double checked struct virtio_console_config as it also defines cols
> > > before rows, but there the kernel follows the spec (including
> > > endianness).
> > > I'll send a patch v2 shortly.  
> > 
> > I can send a fix for the endiannes issue. It should be a separate
> > patch anyway.
> > 
> > Regards,
> > Halil  
> 
> I already implemented it in my patch v2 (just waiting for Amit to
> confirm the new commit message). But if you want to split it you can
> create a seperate patch for it as well (I don't really mind either
> way).
> 

It is conceptually a different bug and warrants a patch and a commit
message of its own. At least IMHO.

Regards,
Halil
