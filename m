Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F00274676
	for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 09:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758102590; cv=none; b=HwwCeCQEg+lMa/n7NGEmKWtq4RFHTFtV9HuoigMF1HBP55kGZNmSg7EXKW3GFkFssiYPQZg8vPHQaKe9VkdCADaQHCroo/86ohwMzU9Jx8RBZfV5T+8C7zxx19Ji2oZgG3uRarrh0qN10SGUsFm+gs82jPd0Brj7VX3B1X7fXtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758102590; c=relaxed/simple;
	bh=xPtTczU75jbOwSggNkBH3jHb0rKetM4qm0iJHnzquJQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ox71y2XqJ+6SwjRXgNKm+ro4oWd3yongyVV1NLvYZdXX4QF8SI7OOjpwoZumJN8XBMOZjyknl2ps4NPS4QQ7GdcxLDretA9NZc5TYV0NNWiJc2wePLIAs/DGxeW1EkGdQUQPBmErUkT1xypior3mjP9JdVp8X/HAKVtxLfugWbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NXmDKAf2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NXmDKAf2"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GLm2d3032503;
	Wed, 17 Sep 2025 09:49:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xPtTcz
	U75jbOwSggNkBH3jHb0rKetM4qm0iJHnzquJQ=; b=NXmDKAf2cTNiSDIaGo4hjQ
	VQpmksKuwb2Fvm92pkB+1LWG63Sso+K7CDUFtIboOfFqzieVWHD4LhZosV37STVV
	wjb6u33gOFM5P/sR1zu8qiWh6EOz4wC7/PsS5MJqOmJVRemvLEJqC1V50D1+gblv
	ZLUYp9+yuTmBwVtlHaeXrWfkst5+nsBUbYqS2N2uazXl1rlBZgvTC0UfifKH7vvG
	0BP2/+xRthFKjfpJ4RmbC+190/HSZaXJ7X31+mFdMiuvyOoXdkRIN3nzAzksdi3u
	F6hZqWH3uV30OG2Pzl+p6xj/1Y1P7IoMm4byBQxVE3L+O7xnwsfqOrKvSUx7pjSQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4hjtxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 09:49:44 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58H9nh54018066;
	Wed, 17 Sep 2025 09:49:43 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4hjtxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 09:49:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58H844q2009363;
	Wed, 17 Sep 2025 09:49:42 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 495nn3g91a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 09:49:42 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58H9neCa47907218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 09:49:40 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C631220043;
	Wed, 17 Sep 2025 09:49:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34C0B20040;
	Wed, 17 Sep 2025 09:49:40 +0000 (GMT)
Received: from li-9b52914c-2c8b-11b2-a85c-a36f6d484b4a.ibm.com (unknown [9.111.5.195])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Sep 2025 09:49:40 +0000 (GMT)
Message-ID: <f6e9109b19063892db91b15c73247f4dd1af30ce.camel@linux.ibm.com>
Subject: Re: [PATCH] Revert "virtio_console: fix order of fields cols and
 rows"
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: Filip Hejsek <filip.hejsek@gmail.com>,
        "Michael S. Tsirkin"
 <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        virtualization@lists.linux.dev
Date: Wed, 17 Sep 2025 11:49:39 +0200
In-Reply-To: <7d29cca832103f70584a9bd88c32b77f508e9045.camel@gmail.com>
References: 
	<7ebfa9a5ec3f07506b3d8f01cd4f2a35e2135679.1757666355.git.mst@redhat.com>
		 <32bc2a49fabd619ea7dcafd7f5d50fca206b38ac.camel@linux.ibm.com>
	 <7d29cca832103f70584a9bd88c32b77f508e9045.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: A2XWjbpHdOTtMPyz1CYcgiDm6YYA0VmK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX8RXu9+rwCiTv
 lXlndl0+EfM47hLYeTTuthtK1nE5ySniGGQc+LMAOybSXB9B1N1IgyPRJoRAGMCgybBJYowcVX8
 qar7FZGUwkFhl5taXwexyBh3Dhn3nSNnyY2EczcpN/52UQEPLUykERgQxl5s01WnnYMiBrVICnN
 uQZyVpHPFFu0Hrn9ZI5PgxBmxPtTZGPHs3BdKBr3ItpMv3oyFDqUrvChv5+iBcneM6H5S8cyf2O
 eGoQ0rjXmqQmO0M7WqohMHlrUpzi0iDzYy8HQ6lDEUEBhR53wp+67JppwESmbizKeFNUZYS2NIp
 sXmIf1QqF7I1nte5VN6spVXmuh7zDXlwba7Qv9PRA3J4dtQC1+8Q7wJHI0gkCCkqsRG/vDDyQWZ
 F5TNbCg5
X-Proofpoint-GUID: g2c-RVtScm76_BMVaKTADUTKz9OyiyLX
X-Authority-Analysis: v=2.4 cv=co2bk04i c=1 sm=1 tr=0 ts=68ca8438 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=KTf-2ZXJcRCJ3dXJ6e0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160204

On Mon, 2025-09-15 at 23:37 +0200, Filip Hejsek wrote:
> Hi,
>=20
> On Mon, 2025-09-15 at 18:44 +0200, Maximilian Immanuel Brandtner
> wrote:
> > [...]
> > As I already mentioned in the QEMU discussion, I proposed the fix,
> > because I was working on a similar implementation to bring resizing
> > to
> > QEMU.
>=20
> I couldn't find any mention of your implementation on the QEMU ML.
>=20
> > Unfortunately, the patch-set was stuck in limbo for a while and
> > now that someone else has picked up the slack, I've descided that
> > it's
> > better to contribute to the patch-set that is upstream instead of
> > sending a competing patch-set that does the same thing.
>=20
> Would it be OK for me to take a look at your WIP patches? I would
> like
> to see if you did anything differently.
>=20

For the stuff I can get clearance for anyways. The tl:dr of what's
different about my patch-set is as follows:
- introduce a new IOResizeHandler instead of using a chr backend event
- dynamically add a QOM-property to every character device that
supports resizing (instead of the qmp-command that you have
implemented)
- guest chardev implementations

I also used a g_unix_signal_source instead of a signal notifier and it
worked during testing, but I prefer your solution

> Also, you mentioned before that you were also working on patches for
> Libvirt. These will still be useful, because I won't be implementing
> that part.
>=20

I haven't properly implemented it for libvirt either. The libvirt patch
-set would have to be somewhat sizeable as well as virStream currently
doesn't implement a handle to perform hypervisor specific calls (which
a resize QMP call would be). Accordingly, the virStream implementation
would have to be changed on a deeper level which is why I just didn't
come around to it (I would also need to familiarize myself first with
libvirt more which I haven't done yet).

> > [...]
> > I don't really care if this discrepancy is fixed one way or the
> > other,
> > but it should most definitely be fixed.
>=20
> I'm of the same opinion, but if it is fixed on the kernel side, then
> (assuming no device implementation with the wrong order exists) I
> think
> maybe the fix should be backported to all widely used kernels. It
> seems
> that the patch hasn't been backported to the longterm kernels [1],
> which I think Debian kernels are based on.
>=20
> [1]:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/driv=
ers/char/virtio_console.c?h=3Dv6.12.47
>=20

Then I guess the patch-set should be backported

> > Kind regards,
> > Max Brandtner
>=20
> Regards,
> Filip Hejsek

