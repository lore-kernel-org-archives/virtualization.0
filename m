Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DBA1E98FB
	for <virtualization@lists.linux.dev>; Thu, 20 Mar 2025 07:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742454755; cv=none; b=rSKQNaOM+1N5j+sgUKsqCNdXlYzISESz8T40h/7Oh8F6m3lM24VxbYNynNFqxf17LhDyZmjTwlDsXYNSP0R4Q1rU4yV7JtEBMtboviadPJumIW7fOjaHi5LO3Yt9tyEDmEqkLJzuufVCq4YuR7SDep3cEfS0VRMH4FOH3DwTnPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742454755; c=relaxed/simple;
	bh=KZouUQ5SRA9OqBiLEQJ6o7UW/hD/GQMmK4rNL4LSd88=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FT4K4Ts7Dihftdp6zMSaBA/CqJagcJ0eAUE0GC2OYWqmE0UoVl3LpQ8uqZGuihW0PpwpEwSPKRxK4Azrc/eaTrIQdq666f2m4lL1QltLDAFMfJW9R3t7/U76GIkNvzgiPoCTsJBD/L4upAVDogf3AvObocFwmSYnJXSDWIZGfM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jzzPPV3Y; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jzzPPV3Y"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K6IF8H031578;
	Thu, 20 Mar 2025 07:12:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KZouUQ
	5SRA9OqBiLEQJ6o7UW/hD/GQMmK4rNL4LSd88=; b=jzzPPV3Y7RN42O8MDNvAtO
	Y1xb1+RQNLe8cq7k6gY6GI72r6NljzNbGZuTEMyuoycIBuh9hsneD4ig4bOIWbt7
	kjRLoHAwRY4sKnALX8lsC1XLLHruVaBSojsgsaxkfpfTun7PR70qHJFmK3aa0ac9
	wXdqvW3gr3GByucwDQTp3OO/1kZh1wnOxNJ23qSCxwvhdQ1pEWDBs+IPQv7ruMEs
	CVLqxpPpMH71+0bZoJZLRfAOfpurpw9czpNDar9HM0ydSJmBgxco0EIzbNL4sbXq
	Rx0Rnxh5QBKehpxq+xEg+GuIbJYq2bcE9DBF2sH1d7Ctha1z1X3nxXrO07MzNAKA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45g5502hxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 07:12:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52K3vHdh005642;
	Thu, 20 Mar 2025 07:12:27 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dm906ra9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 07:12:27 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52K7CNWe39059718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 07:12:23 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A74DA20040;
	Thu, 20 Mar 2025 07:12:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 726C320043;
	Thu, 20 Mar 2025 07:12:23 +0000 (GMT)
Received: from li-9b52914c-2c8b-11b2-a85c-a36f6d484b4a.boeblingen.de.ibm.com (unknown [9.155.199.15])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 20 Mar 2025 07:12:23 +0000 (GMT)
Message-ID: <fe72c90a59354f2507c1d528c4e5b8562b20a3e8.camel@linux.ibm.com>
Subject: Re: [PATCH] virtio: console: Make resizing compliant with virtio
 spec
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: Halil Pasic <pasic@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Amit Shah <amit@kernel.org>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev, arnd@arndb.de,
        gregkh@linuxfoundation.org, brueckner@linux.ibm.com,
        schnelle@linux.ibm.com
Date: Thu, 20 Mar 2025 08:12:23 +0100
In-Reply-To: <20250319181308.365ee0ea.pasic@linux.ibm.com>
References: <20250225092135.1200551-1-maxbr@linux.ibm.com>
	 <f5ab160dadc2219b9576e50588dce88f22e9bcb1.camel@kernel.org>
	 <649563cf1b8abd42401ed78d84bfd576d48bdbb8.camel@linux.ibm.com>
	 <f27debf87882df65574f21cfced31fecf1dd1da3.camel@kernel.org>
	 <dc3ff60fd16e5b5f94c12cf6a5a7893b94f705a8.camel@linux.ibm.com>
	 <20250319105852-mutt-send-email-mst@kernel.org>
	 <20250319181308.365ee0ea.pasic@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: svZ-QXaf7tbrdIwMpWby_IWuy8LTCZJx
X-Proofpoint-ORIG-GUID: svZ-QXaf7tbrdIwMpWby_IWuy8LTCZJx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_02,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503200042

On Wed, 2025-03-19 at 18:13 +0100, Halil Pasic wrote:
> On Wed, 19 Mar 2025 11:00:06 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>=20
> > > > I was mistaken in my earlier reply - I had missed this
> > > > virtio_console_resize definition in the spec.=C2=A0 So indeed
> > > > there's a
> > > > discrepancy in Linux kernel and the spec's ordering for the
> > > > control
> > > > message.
> > > >=20
> > > > OK, that needs fixing someplace.=C2=A0 Perhaps in the kernel (like
> > > > your
> > > > orig. patch), but with an accurate commit message.=C2=A0=20
> > >=20
> > > So should I send a patch v2 or should the spec be changed
> > > instead? Or
> > > would you like to first await the opinion of the spec
> > > maintainers?
> > >=20
> > > The mail I initially sent to the virtio mailing list seems to
> > > have
> > > fallen on deaf ears. I now added Michael Tsirkin to this thread
> > > so that
> > > things might get going.=C2=A0=20
> >=20
> >=20
> > If we can fix the driver to fit the spec, that's best.
> > We generally try to avoid changing the spec just because
> > drivers are buggy.
>=20
> I think the call if fixing the driver is possible needs to be made by
> the maintainers of the driver. Fixing the driver IMHO implies that
> if this is seeing any usage in the wild where it properly works a
> fix on the driver side would imply a function regression. But any
> implementers should have complained. So IMHO it is not unreasonable
> to
> assume that this is not seeing any usage in the wild.
>=20
> And people would still have the opportunity to catch the regression
> during testing and complain about it.
>=20
> I agree with Michael, changing the spec because of a buggy
> implementation should rather be the exception than the rule. And
> AFAIK
> it is not like we have declared something a reference implementation,
> so in that sense the implementation in Linux is just one
> implementation.
>=20
> I suppose making it runtime configurable via module parameter is an
> overkill at this point.
>=20
> So based no what we know I'm slightly in favor of let us just fix it
> in Linux and see if anybody complains.
>=20
> Another thing I noticed during looking at this. AFAICT Linux does not
> seem to handle endiannes here. And AFAIU the message is supposed to
> hold
> le16 that is little endian u16! Maximilian, is this in your opinion
> something we need to fix as well? Or am I just missing the
> conversion?
>=20
> Regards,
> Halil

Thanks, I didn't notice that, as I only tested this feature on x86. I
double checked struct virtio_console_config as it also defines cols
before rows, but there the kernel follows the spec (including
endianness).
I'll send a patch v2 shortly.
