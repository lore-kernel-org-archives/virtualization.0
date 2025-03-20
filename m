Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493A221C184
	for <virtualization@lists.linux.dev>; Thu, 20 Mar 2025 11:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742471644; cv=none; b=n/u+Fe0n/TwjtcVUnpCkKWyHp9P2bVWfASGmDC9PJIwxrIDvxWYajoMgsLrOB+o5zitG07faf+Ms19AAj/gPDj5+NdAT88w7H6RQKKgz6rpU6TF1BpaVk8ojj6EAABvUssIzUjknPu4AyfKQKKLFUL74g2sjs8EwwzIq+iA+Da0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742471644; c=relaxed/simple;
	bh=C6wy5pOoxyLzqkI8j2GkdeuxaiPU5QU+49cf+4/SKsU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i6g5XzjJJaiLi1u/I12zANVK+W2abUMzdh84r43o+2WYcPvJl+ppzv6dsqQxX0EZ0NE8qrV0QnAjNJ3C/ES/fcCxKA/BGTYKsvUbyDXUM2ZeGMdsHxQ9pEGft2+934QaEdmUyY1jJI0y1z/EAKLDjLEEfoDC2KCfn8CZ9Ms/X+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FMpVk4FE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FMpVk4FE"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K93sAT030169;
	Thu, 20 Mar 2025 11:53:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=C6wy5p
	OoxyLzqkI8j2GkdeuxaiPU5QU+49cf+4/SKsU=; b=FMpVk4FEYy0g8o6MLEbEyK
	mBHtGuK6FBorBXxiDR+4aDOoMVDECKszm8hulpOAlnhEEWz9QwZc+hrRaxXYWfrM
	ClCnK+45Bta1GbPKuRLIXI4hzxEcWcDp22anzuSpW0ceXpdWZKoIl2MRqQCKvKUD
	jn4D4wLs5dZMoWb26VRXtiiAYEaCW4E3iXwtpG61rmRnG+wy+jzpKEnOHCLT5oId
	mWXu1CAyeU6HDL/6vSwX3SFZGg37x4S3J3NK1oxX7Q6sFQVpsTlJZOag7SXgOogf
	Iv5Cc4w6jkzXYWbPw9ppiZ23bwL7+OjdMU+I/zQ3nqqOTclDTgc0SsYLWVCZa0Ew
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45g53qbtr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 11:53:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52KARD3G023197;
	Thu, 20 Mar 2025 11:53:56 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dp3kykfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 11:53:56 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52KBrrqm41877772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 11:53:53 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B4AF20040;
	Thu, 20 Mar 2025 11:53:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FCF520043;
	Thu, 20 Mar 2025 11:53:44 +0000 (GMT)
Received: from li-9b52914c-2c8b-11b2-a85c-a36f6d484b4a.ibm.com (unknown [9.171.33.254])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 20 Mar 2025 11:53:43 +0000 (GMT)
Message-ID: <dedc20f946d50bc2b45c1f974554001495657f37.camel@linux.ibm.com>
Subject: Re: [PATCH] virtio: console: Make resizing compliant with virtio
 spec
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Amit Shah <amit@kernel.org>,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        arnd@arndb.de, gregkh@linuxfoundation.org, brueckner@linux.ibm.com,
        schnelle@linux.ibm.com
Date: Thu, 20 Mar 2025 12:53:43 +0100
In-Reply-To: <20250320114120.383a706f.pasic@linux.ibm.com>
References: <20250225092135.1200551-1-maxbr@linux.ibm.com>
	 <f5ab160dadc2219b9576e50588dce88f22e9bcb1.camel@kernel.org>
	 <649563cf1b8abd42401ed78d84bfd576d48bdbb8.camel@linux.ibm.com>
	 <f27debf87882df65574f21cfced31fecf1dd1da3.camel@kernel.org>
	 <dc3ff60fd16e5b5f94c12cf6a5a7893b94f705a8.camel@linux.ibm.com>
	 <20250319105852-mutt-send-email-mst@kernel.org>
	 <20250319181308.365ee0ea.pasic@linux.ibm.com>
	 <fe72c90a59354f2507c1d528c4e5b8562b20a3e8.camel@linux.ibm.com>
	 <20250320114120.383a706f.pasic@linux.ibm.com>
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
X-Proofpoint-GUID: GNKRPBlS20SRDTVo-kcaDjfkKcOduWjH
X-Proofpoint-ORIG-GUID: GNKRPBlS20SRDTVo-kcaDjfkKcOduWjH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=926
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200070

On Thu, 2025-03-20 at 11:41 +0100, Halil Pasic wrote:
> On Thu, 20 Mar 2025 08:12:23 +0100
> Maximilian Immanuel Brandtner <maxbr@linux.ibm.com> wrote:
>=20
> > > Another thing I noticed during looking at this. AFAICT Linux does
> > > not
> > > seem to handle endiannes here. And AFAIU the message is supposed
> > > to
> > > hold
> > > le16 that is little endian u16! Maximilian, is this in your
> > > opinion
> > > something we need to fix as well? Or am I just missing the
> > > conversion?
> > >=20
> > > Regards,
> > > Halil=C2=A0=20
> >=20
> > Thanks, I didn't notice that, as I only tested this feature on x86.
> > I
> > double checked struct virtio_console_config as it also defines cols
> > before rows, but there the kernel follows the spec (including
> > endianness).
> > I'll send a patch v2 shortly.
>=20
> I can send a fix for the endiannes issue. It should be a separate
> patch anyway.
>=20
> Regards,
> Halil

I already implemented it in my patch v2 (just waiting for Amit to
confirm the new commit message). But if you want to split it you can
create a seperate patch for it as well (I don't really mind either
way).

