Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FF82147ED
	for <virtualization@lists.linux.dev>; Thu, 20 Mar 2025 10:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742467300; cv=none; b=d/wwQZ+6Ym5KjHC5JHF0JjVqt7LB9ws/1fxzBVSL57llPibQhau1U2Od7ZwivOnPfS9fuDpotjFeLAstgn8kiqRMqjeqiik+wmw4kiKGQpjftFHb7Ccy4CjPT3eEaPz7xfUYC/rQqKXnEUR52HtOfKLH+mTh8qf6p56lLRl34GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742467300; c=relaxed/simple;
	bh=91z6EV/QxcFRkZHyq9xOk4pUc30+MtQy/mfod8WuAhY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=shnu6OjvupB2w8S002m+7Cb8J2fjyEN7Mqp0+F0I/yb4sDNQKgXdwAHLj1qwB+0MDYH4+uBKgQ/8seWFu29wFHSaHeQyDqL8pqp1tAXiPfTzKKIIJmpPIxUG3KaNIVK33O19zBKps/Il3SSceYIMM4ZVjH4m4pu/xKmfA3HFjdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k9NZ+iou; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k9NZ+iou"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K8fIiq001170;
	Thu, 20 Mar 2025 10:41:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AhhnvF
	ZlQus8DDjKhr6iLJMS0RiI0PtumR74+NTL6mE=; b=k9NZ+ioupRpc7hgZNQV3Cu
	tgplUOUDfItC2SZ0VGaC2m01REnPb1xomL/I4UdpNdHWu7qw0q7laskb9dtKkQ7H
	IBHUcmE4ipNLeBBVrC/N1N2rQbdY0ttqztf/HNLUtBS5SfhTWsuyOXgxqJvhQElU
	pH6Plt0IAHRvNvTNzBHr6tXs1kWWZltum8yDilMcWLuUoc2y5lVqbSEX2QkWyFtX
	wsxddM1+/Z6+lOYqVCA+F4YlIpAvAEonyA9eLFdKbQ/yuOtdtmZAm3icwm3GhM8f
	Nb98AKULQd6JS76wNtuK2fSJ570dTLYJfJJQW1fCvawg7bv5rAy/hW1ffGLqd6Yg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45g5503es2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 10:41:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52K8RPUb012481;
	Thu, 20 Mar 2025 10:41:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dmvp7f48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 10:41:26 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52KAfN0Q54133108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 10:41:23 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 016FE20040;
	Thu, 20 Mar 2025 10:41:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CD762004B;
	Thu, 20 Mar 2025 10:41:22 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.171.78.15])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 20 Mar 2025 10:41:22 +0000 (GMT)
Date: Thu, 20 Mar 2025 11:41:20 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Amit Shah <amit@kernel.org>,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        arnd@arndb.de, gregkh@linuxfoundation.org, brueckner@linux.ibm.com,
        schnelle@linux.ibm.com, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH] virtio: console: Make resizing compliant with virtio
 spec
Message-ID: <20250320114120.383a706f.pasic@linux.ibm.com>
In-Reply-To: <fe72c90a59354f2507c1d528c4e5b8562b20a3e8.camel@linux.ibm.com>
References: <20250225092135.1200551-1-maxbr@linux.ibm.com>
	<f5ab160dadc2219b9576e50588dce88f22e9bcb1.camel@kernel.org>
	<649563cf1b8abd42401ed78d84bfd576d48bdbb8.camel@linux.ibm.com>
	<f27debf87882df65574f21cfced31fecf1dd1da3.camel@kernel.org>
	<dc3ff60fd16e5b5f94c12cf6a5a7893b94f705a8.camel@linux.ibm.com>
	<20250319105852-mutt-send-email-mst@kernel.org>
	<20250319181308.365ee0ea.pasic@linux.ibm.com>
	<fe72c90a59354f2507c1d528c4e5b8562b20a3e8.camel@linux.ibm.com>
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
X-Proofpoint-GUID: VsRLRUz6LmUIlubWdKR4HuFQ-SUxorZI
X-Proofpoint-ORIG-GUID: VsRLRUz6LmUIlubWdKR4HuFQ-SUxorZI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=881 spamscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503200064

On Thu, 20 Mar 2025 08:12:23 +0100
Maximilian Immanuel Brandtner <maxbr@linux.ibm.com> wrote:

> > Another thing I noticed during looking at this. AFAICT Linux does not
> > seem to handle endiannes here. And AFAIU the message is supposed to
> > hold
> > le16 that is little endian u16! Maximilian, is this in your opinion
> > something we need to fix as well? Or am I just missing the
> > conversion?
> > 
> > Regards,
> > Halil  
> 
> Thanks, I didn't notice that, as I only tested this feature on x86. I
> double checked struct virtio_console_config as it also defines cols
> before rows, but there the kernel follows the spec (including
> endianness).
> I'll send a patch v2 shortly.

I can send a fix for the endiannes issue. It should be a separate
patch anyway.

Regards,
Halil
