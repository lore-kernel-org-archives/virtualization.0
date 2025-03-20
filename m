Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173051E378C;
	Thu, 20 Mar 2025 07:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742455438; cv=none; b=ocSzpkuekANRcmYepxC29kTobpye2Dh/SIQ4usWvRhrrnqlHlBgpUWaO1GIaNHMfSihm5pmszcgu9Q3/J1mSNUF3FPvKazht7dTRhM3zSwJ/y8oAozcHq9sdnAn+HB0Hy5QSoW1sjfuV26Ot6x/ViJgPe7BDkmX0tkZQcnt9GU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742455438; c=relaxed/simple;
	bh=Ef/v1S7KSonF2hXC+jsXzgEivJWZgJJ4PuB2T7iPgW4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UXdVN1lu/QbejDVbnqDtujiyxU1S6QjU2ZFgpHh3Efu9f34CYnFe10cUTk/TzMa3kp6dPjAGxmSRFJvpOO2uCKsubMenvLYgBj9IvQSOnuslTtfw9pMHD7ZfMiZh+Df7leBw6PwyV6pTUFcsIgHXBd5U3xszKIP+c63wGZh+K3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ebdFlopP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ebdFlopP"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K79ReW029965;
	Thu, 20 Mar 2025 07:23:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2RLQtA
	NJOsY9F23aeFI0Eifr5tCnaCx1RfFpmrkeSpE=; b=ebdFlopPTsv9UtzyUsNDdT
	1kb2ya3HNypn92qNe1PW0ADFZAsz+IVLqkdPzthr0k2y3sxRyrSR0gwXFsEEBUX3
	EcBFGyjHRWsV/4bYg/Gd5/QEo4qqZXSJGNx9enZHkMZ6F1VB4gnIW2MkkeUxmBtu
	kXVAjkrULpsAz6Aa/O/8kdpwouhR0bqR1d+dt2q2+4uHPAvI5NdtncQdAjhJdLeV
	kKNtVJiuOqBptCWLGtKCTppYGMe+sYB+eDcuLVRMN7j4R8mnzJ3Scu96x7qQ1HAH
	Jsgq4FLpE4fH0mpY7VEKvYwlNjY7Sn14Mhuzbn7zczeh+Zq3VUEuDSOj9NP42mFQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45g53qak9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 07:23:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52K4c7L7012447;
	Thu, 20 Mar 2025 07:23:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dmvp6npt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 07:23:50 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52K7Nk2454591854
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 07:23:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7030920043;
	Thu, 20 Mar 2025 07:23:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4AE2920040;
	Thu, 20 Mar 2025 07:23:46 +0000 (GMT)
Received: from li-9b52914c-2c8b-11b2-a85c-a36f6d484b4a.boeblingen.de.ibm.com (unknown [9.155.199.15])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 20 Mar 2025 07:23:46 +0000 (GMT)
Message-ID: <f3b74fc70a02f01eaf41ee74de636c0a86829011.camel@linux.ibm.com>
Subject: Re: [PATCH] virtio: console: Make resizing compliant with virtio
 spec
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: Amit Shah <amit@kernel.org>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, brueckner@linux.ibm.com,
        schnelle@linux.ibm.com, pasic@linux.ibm.com
Date: Thu, 20 Mar 2025 08:23:46 +0100
In-Reply-To: <f27debf87882df65574f21cfced31fecf1dd1da3.camel@kernel.org>
References: <20250225092135.1200551-1-maxbr@linux.ibm.com>
	 <f5ab160dadc2219b9576e50588dce88f22e9bcb1.camel@kernel.org>
	 <649563cf1b8abd42401ed78d84bfd576d48bdbb8.camel@linux.ibm.com>
	 <f27debf87882df65574f21cfced31fecf1dd1da3.camel@kernel.org>
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
X-Proofpoint-GUID: jYZCbXiqnPyeuzLeiUQOl2xWFBjRTouC
X-Proofpoint-ORIG-GUID: jYZCbXiqnPyeuzLeiUQOl2xWFBjRTouC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_02,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200042

On Tue, 2025-03-18 at 15:25 +0100, Amit Shah wrote:
> On Tue, 2025-03-18 at 11:07 +0100, Maximilian Immanuel Brandtner
> wrote:
> > On Mon, 2025-03-03 at 12:54 +0100, Amit Shah wrote:
> > > On Tue, 2025-02-25 at 10:21 +0100, Maximilian Immanuel Brandtner
> > > wrote:
> > > > According to the virtio spec[0] the virtio console resize
> > > > struct
> > > > defines
> > > > cols before rows. In the kernel implementation it is the other
> > > > way
> > > > around
> > > > resulting in the two properties being switched.
> > >=20
> > > Not true, see below.
> > >=20
> > > > While QEMU doesn't currently support resizing consoles, TinyEMU
> > >=20
> > > QEMU does support console resizing - just that it uses the
> > > classical
> > > way of doing it: via the config space, and not via a control
> > > message
> > > (yet).
> > >=20
> > > https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/drivers/char/virtio_console.c#n1787
> > >=20
> > > https://lists.nongnu.org/archive/html/qemu-devel/2010-05/msg00031.htm=
l
> > >=20
> > > > diff --git a/drivers/char/virtio_console.c
> > > > b/drivers/char/virtio_console.c
> > > > index 24442485e73e..9668e89873cf 100644
> > > > --- a/drivers/char/virtio_console.c
> > > > +++ b/drivers/char/virtio_console.c
> > > > @@ -1579,8 +1579,8 @@ static void handle_control_message(struct
> > > > virtio_device *vdev,
> > > > =C2=A0		break;
> > > > =C2=A0	case VIRTIO_CONSOLE_RESIZE: {
> > > > =C2=A0		struct {
> > > > -			__u16 rows;
> > > > =C2=A0			__u16 cols;
> > > > +			__u16 rows;
> > > > =C2=A0		} size;
> > > > =C2=A0
> > > > =C2=A0		if (!is_console_port(port))
> > >=20
> > > This VIRTIO_CONSOLE_RESIZE message is a control message, as
> > > opposed
> > > to
> > > the config space row/col values that is documented in the spec.
> > >=20
> > > Maybe more context will be helpful:
> > >=20
> > > Initially, virtio_console was just a way to create one hvc
> > > console
> > > port
> > > over the virtio transport.=C2=A0 The size of that console port could
> > > be
> > > changed by changing the size parameters in the virtio device's
> > > configuration space.=C2=A0 Those are the values documented in the
> > > spec.=20
> > > These are read via virtio_cread(), and do not have a struct
> > > representation.
> > >=20
> > > When the MULTIPORT feature was added to the virtio_console.c
> > > driver,
> > > more than one console port could be associated with the single
> > > device.
> > > Eg. we could have hvc0, hvc1, hvc2 all as part of the same
> > > device.=20
> > > With this, the single config space value for row/col could not be
> > > used
> > > for the "extra" hvc1/hvc2 devices -- so a new
> > > VIRTIO_CONSOLE_RESIZE
> > > control message was added that conveys each console's dimensions.
> > >=20
> > > Your patch is trying to change the control message, and not the
> > > config
> > > space.
> > >=20
> > > Now - the lack of the 'struct size' definition for the control
> > > message
> > > in the spec is unfortunate, but that can be easily added -- and I
> > > prefer we add it based on this Linux implementation (ie. first
> > > rows,
> > > then cols).
> >=20
> > Under section 5.3.6.2 multiport device operation for
> > VIRTIO_CONSOLE_RESIZE the spec says the following
> >=20
> > ```
> > Sent by the device to indicate a console size change. value is
> > unused.
> > The buffer is followed by the number of columns and rows:
> >=20
> > struct virtio_console_resize {=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le16 cols;=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le16 rows;=20
> > };
> > ```
>=20
> Indeed.
>=20
>=20
> > It would be extremely surprising to me if the section `multiport
> > device
> > operation` does not document resize for multiport control messages,
> > but
> > rather config messages, especially as VIRTIO_CONSOLE_RESIZE is
> > documented as a virtio_console_control event.
>=20
> You're right.
>=20
> I was mistaken in my earlier reply - I had missed this
> virtio_console_resize definition in the spec.=C2=A0 So indeed there's a
> discrepancy in Linux kernel and the spec's ordering for the control
> message.
>=20
> OK, that needs fixing someplace.=C2=A0 Perhaps in the kernel (like your
> orig. patch), but with an accurate commit message.
>=20

Would the following do?

virtio: console: Make resize control event handling compliant with spec

According to section 5.3.6.2 of the virtio spec a control buffer with
the event VIRTIO_CONSOLE_RESIZE is followed by a virtio_console_resize
struct containing 2 little endian 16bit integers cols,rows. The kernel
implementation assumes native endianness (which results in mangled
values on big endian architectures) and swaps the ordering of columns
and rows. This patch fixes these discrepancies between kernel and spec.

> Like I said, I don't think anyone is using this control message to
> change console sizes.=C2=A0 I don't even think anyone's using multiple
> console ports on the same device.
>=20
> > In fact as far as I can tell this is the only part of the spec that
> > documents resize. I would be legitimately interested in resizing
> > without multiport and I would genuinely like to find out about how
> > it
> > could be used. In what section of the documentation could I find
> > it?
>=20
> See section 5.3.4 that describes `struct virtio_console_config` and
> this note:
>=20
> ```
> =C2=A0=C2=A0=C2=A0 If the VIRTIO_CONSOLE_F_SIZE feature is negotiated, th=
e driver
> can
> read the console dimensions from cols and rows.=20
> ```
>=20
> 		Amit

