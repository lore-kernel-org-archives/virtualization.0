Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233442A1A4
	for <virtualization@lists.linux.dev>; Thu, 20 Mar 2025 17:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742491192; cv=none; b=Stn46tGSX/RgVTst2H80u55IgFcyJR4G/RcfiO1h/emrk7y9NnFVAEUjC6UxUc/tQ3JZFvSQvovX9zZ10UMC8lfP+tz66it2Ar3Y30hMu/eVIY/wcMyZLUNqsEfveJhxE2l5w061qvHWspKSrWFVUdLJOHVFo07ED8RnMGek/gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742491192; c=relaxed/simple;
	bh=/I8SEdyVFZRskuVLg+DN/P8lsx/XNNJjnQvHLLb4DEg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KP1FPanlykeYAEwRaAjaVqvCeIfVIhKBHC5KIt1VGpqzde1U+gHG3Pq1cLBf202HFZjErBDw8fPHvjvTSHGp07dbeWJFcXQZ7Xtsx4OpyRFOvM8PHQ3A+85iOK3sKqN+KOpkF8xO2oqC00A2xpOBMT5AQm2f/pB0qUfeCeZcK4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bgQ037eh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bgQ037eh"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KDU4WZ029673;
	Thu, 20 Mar 2025 17:19:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/I8SEd
	yVFZRskuVLg+DN/P8lsx/XNNJjnQvHLLb4DEg=; b=bgQ037ehBIv63YI4n7dzFK
	6o8J4F+QicTdH3EgDEcykhgCLV7ake7NvimjJMnAlD941VvgZ0Fko6zH4x5gmRZH
	xp2ek3I2HjmSK9m2Mj7Trio8zfmdcuX9sCGpBJBSi2MiTcepeb8JmHhKqUATMTdS
	2iqVfOpK+wtD0bgTBWGuSSOY/cOuCG1rFQJxEAozWIPSgPyUwmdX/yuHTb/18xSB
	Z//h/Cu1qtXjYKw1FVsiGCKa9+XIMlElw64+qMCDs2OYrKQT22efgGZV2WtcDIj1
	8SA6ZttgmQR+qvH04PFe+toEmfqcMVDTxq9U6evKGT7VAw39R5o+r0fDWpUBVZKA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45gbd9m22r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 17:19:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52KDnI2h005664;
	Thu, 20 Mar 2025 17:19:44 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dm9098u7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 17:19:44 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52KHJePL46858710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 17:19:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56C7820043;
	Thu, 20 Mar 2025 17:19:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28E7520040;
	Thu, 20 Mar 2025 17:19:39 +0000 (GMT)
Received: from li-9b52914c-2c8b-11b2-a85c-a36f6d484b4a.ibm.com (unknown [9.171.57.148])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 20 Mar 2025 17:19:39 +0000 (GMT)
Message-ID: <3e28dc9eb03e2269e2c4613d415291cbda99dfad.camel@linux.ibm.com>
Subject: Re: [PATCH] virtio: console: Make resizing compliant with virtio
 spec
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Amit Shah <amit@kernel.org>,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        arnd@arndb.de, gregkh@linuxfoundation.org, brueckner@linux.ibm.com,
        schnelle@linux.ibm.com
Date: Thu, 20 Mar 2025 18:19:38 +0100
In-Reply-To: <20250320151901.4906e2a9.pasic@linux.ibm.com>
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
	 <20250320151901.4906e2a9.pasic@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: iMVS08fHSZSnOGMIUynwNE83jQwRamW_
X-Proofpoint-GUID: iMVS08fHSZSnOGMIUynwNE83jQwRamW_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_04,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 mlxlogscore=937 lowpriorityscore=0 adultscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2503200107

On Thu, 2025-03-20 at 15:19 +0100, Halil Pasic wrote:
> On Thu, 20 Mar 2025 15:09:57 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
>=20
> > > I already implemented it in my patch v2 (just waiting for Amit to
> > > confirm the new commit message). But if you want to split it you
> > > can
> > > create a seperate patch for it as well (I don't really mind
> > > either
> > > way).
> > > =C2=A0=20
>=20
> Your v2 has not been posted yet, or? I can't find it in my Inbox.
>=20
> I understand that you have confirmed that the byte order handling is
> needed but missing, right?

Yes, I wanted to first hear back from Amit whether he liked the new
commit message, but seeing as he hasn't yet replied I'll just post it
now. I've confirmed that the endianness handling is necessary, but not
implementated. I've looked all the way down into hvc_console() up until
tty_do_resize(), but there are no endianess adjustments up until that
point aka I'm pretty certain the endianness is broken.

I'll post my v2 without the endianness fix then

>=20
> >=20
> > It is conceptually a different bug and warrants a patch and a
> > commit
> > message of its own. At least IMHO.

