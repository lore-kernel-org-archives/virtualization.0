Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FED8372
	for <virtualization@lists.linux.dev>; Wed, 19 Mar 2025 13:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742389261; cv=none; b=oKvGn6lmE7SpfT5j1si7T5wzxWQXvA0vHjnGdaWbOmd821sjPRdGMT3rrf6xXiem2vG27zqinOhxcck8OMmHFeZjGSqTHNFmRaTiTR6r9yEc3T6R4FzKTf9I4q1fpnyIKTkKPYv8gy1P5eXa7i6UIiaoYIRQR8PsfsWAocsWZ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742389261; c=relaxed/simple;
	bh=ZmeFod5jFlhZxYSWrzG2lkqVF3A+Z6ORxJUV3Q73zOo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c4sR7nrMG0m9Drbpfen6kcqetf6n86uQsDeAVZvdenBpZ+SPZVgkdg/zglqf38jlbj9aUSj/eWc2zmcX5fZLXFMV7e81spa1NHbkJ2RCgDaKClO/SbfHCJrYShc0H6Iu330E5HuSDin5LDFXwx/ZgUmyVu5xODhwWxKanL7T5aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rqVOIbYi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rqVOIbYi"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JCS7SV012846;
	Wed, 19 Mar 2025 13:00:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=haySPe
	Qq84RWLVA6YBNfzmZoGCfQBLpN4wDdcbeSoIs=; b=rqVOIbYi7Im1eE0Emo3liZ
	XFcDJcaLF7telUBVsuL4UQpN/s38ky5TnuZ6o0QJdvTs9REJPAefOke8dcyYEZ88
	YBHXOes0YhOPdIsIpaPtan+BuMKptLLeAELwfA02Kto+pele2PdaT3njfrzJrMHP
	Z7ZBpaFKamvUaXoTfDpkbAxFdrN6spiLO6oj5Mp6SCNTDdFFAIXlsu46VBaYxsm+
	FOTh8Bk3mZYBl5xUpKuJSmNsymN0duAS9WUXOBoE/8MAdzFXJjWfqlDtt7O+L+lV
	kqkRtpK4EUJDRi3uIegsrNNVvp090xwkNnIbjfmqNFBHdKd4sSc8Sf2UmfEeO4ZA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fwy206rs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 13:00:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52JBIF2o005648;
	Wed, 19 Mar 2025 13:00:52 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dm901tt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 13:00:52 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52JD0mf034472396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 13:00:48 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E1532004D;
	Wed, 19 Mar 2025 13:00:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28B4C2004B;
	Wed, 19 Mar 2025 13:00:48 +0000 (GMT)
Received: from li-9b52914c-2c8b-11b2-a85c-a36f6d484b4a.boeblingen.de.ibm.com (unknown [9.155.199.15])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 19 Mar 2025 13:00:48 +0000 (GMT)
Message-ID: <dc3ff60fd16e5b5f94c12cf6a5a7893b94f705a8.camel@linux.ibm.com>
Subject: Re: [PATCH] virtio: console: Make resizing compliant with virtio
 spec
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: Amit Shah <amit@kernel.org>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev, mst@redhat.com
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, brueckner@linux.ibm.com,
        schnelle@linux.ibm.com, pasic@linux.ibm.com
Date: Wed, 19 Mar 2025 14:00:44 +0100
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
X-Proofpoint-ORIG-GUID: f15NxvF0XQ-NO8EmpiQIxKdxDAguPWKZ
X-Proofpoint-GUID: f15NxvF0XQ-NO8EmpiQIxKdxDAguPWKZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_04,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190089

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

So should I send a patch v2 or should the spec be changed instead? Or
would you like to first await the opinion of the spec maintainers?

The mail I initially sent to the virtio mailing list seems to have
fallen on deaf ears. I now added Michael Tsirkin to this thread so that
things might get going.

>=20
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
