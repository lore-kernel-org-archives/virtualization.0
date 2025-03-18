Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E1E224CC;
	Tue, 18 Mar 2025 10:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742292459; cv=none; b=kvl1Pjh6bH3ploREtY9SXAeNeqA7JUcTa2GnSNG563mp91NBJV7WDWzR9AFZS3DTPRfF8JXSH+NI4U+VaIPF+LGdO0clAvp4eVi6bntVWhdFMimvCPk1V6k2bxNRK4+zz73qk3tuqDV2iWbZwziQ2DK2r3WA4/owGe+BCQ0zpuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742292459; c=relaxed/simple;
	bh=+ISdKmXgFs1C7oP9Ozri5R8MClEuKMPYaSraYlfzSEQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jDvNruCaGqI9/V+8YCVkkPELgojTXQx63iCBNQAAE/qLyzENDwfeYpz2i9Z2vHyLT5MDtPR4sfBJa3sYquB6s/d92EowcN9TnfCQ5rTkF261i5PIQdZ0qUUsaxkCPCBP8O2zKpb7Ka/D5zH5h4xsI58p3v3/bse/LgpeF/1J7lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M4vzoOBT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M4vzoOBT"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I8xLdu012733;
	Tue, 18 Mar 2025 10:07:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OW7FGx
	twuhQz7FQIkRKh8JRCfEKnWnHWxNLHxJQKBy8=; b=M4vzoOBTuatzC3uwpWrKWY
	OsL4VpMJiTgyYh2HbBHtp41WVc135SwDZYn/wxtPkruqJbvefHbttZ113wz7zzmc
	EGL320DFhd5+0KUsBfz2dWwN5xcbdNSbuvqvc2SUWWAFyBlkQyvyfxDJrFaZbf45
	N98d08Y/j7x2XZ9pfpd1y41ijoTOn1bQHWXMsA3YnXWnsIWuRmUxjQb/nhi0QHMB
	rPUdiHTWFdyf6gXtr10lqOK/KS0KX7EtE9nA61vIg7DB5aTqmN9y4FB2hif7Kd9i
	1t8I81FfXbu5ttAhaFynUr4QOXO2zHAdyYYpC91XEqDHfC0AdFyXoS9md1nCd9bg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45eu55twja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 10:07:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52I7vq2g024440;
	Tue, 18 Mar 2025 10:07:30 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dncm34s2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 10:07:30 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52IA7Q4d48300482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 10:07:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0E752006B;
	Tue, 18 Mar 2025 10:07:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADCF22006A;
	Tue, 18 Mar 2025 10:07:26 +0000 (GMT)
Received: from li-9b52914c-2c8b-11b2-a85c-a36f6d484b4a.boeblingen.de.ibm.com (unknown [9.155.199.15])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 18 Mar 2025 10:07:26 +0000 (GMT)
Message-ID: <649563cf1b8abd42401ed78d84bfd576d48bdbb8.camel@linux.ibm.com>
Subject: Re: [PATCH] virtio: console: Make resizing compliant with virtio
 spec
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: Amit Shah <amit@kernel.org>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, brueckner@linux.ibm.com,
        schnelle@linux.ibm.com, pasic@linux.ibm.com
Date: Tue, 18 Mar 2025 11:07:26 +0100
In-Reply-To: <f5ab160dadc2219b9576e50588dce88f22e9bcb1.camel@kernel.org>
References: <20250225092135.1200551-1-maxbr@linux.ibm.com>
	 <f5ab160dadc2219b9576e50588dce88f22e9bcb1.camel@kernel.org>
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
X-Proofpoint-ORIG-GUID: tnZDim3aAFqnogX3XY3ymudg_94svXBV
X-Proofpoint-GUID: tnZDim3aAFqnogX3XY3ymudg_94svXBV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_04,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503180072

On Mon, 2025-03-03 at 12:54 +0100, Amit Shah wrote:
> On Tue, 2025-02-25 at 10:21 +0100, Maximilian Immanuel Brandtner
> wrote:
> > According to the virtio spec[0] the virtio console resize struct
> > defines
> > cols before rows. In the kernel implementation it is the other way
> > around
> > resulting in the two properties being switched.
>=20
> Not true, see below.
>=20
> > While QEMU doesn't currently support resizing consoles, TinyEMU
>=20
> QEMU does support console resizing - just that it uses the classical
> way of doing it: via the config space, and not via a control message
> (yet).
>=20
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/char/virtio_console.c#n1787
>=20
> https://lists.nongnu.org/archive/html/qemu-devel/2010-05/msg00031.html
>=20
> > diff --git a/drivers/char/virtio_console.c
> > b/drivers/char/virtio_console.c
> > index 24442485e73e..9668e89873cf 100644
> > --- a/drivers/char/virtio_console.c
> > +++ b/drivers/char/virtio_console.c
> > @@ -1579,8 +1579,8 @@ static void handle_control_message(struct
> > virtio_device *vdev,
> > =C2=A0		break;
> > =C2=A0	case VIRTIO_CONSOLE_RESIZE: {
> > =C2=A0		struct {
> > -			__u16 rows;
> > =C2=A0			__u16 cols;
> > +			__u16 rows;
> > =C2=A0		} size;
> > =C2=A0
> > =C2=A0		if (!is_console_port(port))
>=20
> This VIRTIO_CONSOLE_RESIZE message is a control message, as opposed
> to
> the config space row/col values that is documented in the spec.
>=20
> Maybe more context will be helpful:
>=20
> Initially, virtio_console was just a way to create one hvc console
> port
> over the virtio transport.=C2=A0 The size of that console port could be
> changed by changing the size parameters in the virtio device's
> configuration space.=C2=A0 Those are the values documented in the spec.=
=20
> These are read via virtio_cread(), and do not have a struct
> representation.
>=20
> When the MULTIPORT feature was added to the virtio_console.c driver,
> more than one console port could be associated with the single
> device.
> Eg. we could have hvc0, hvc1, hvc2 all as part of the same device.=20
> With this, the single config space value for row/col could not be
> used
> for the "extra" hvc1/hvc2 devices -- so a new VIRTIO_CONSOLE_RESIZE
> control message was added that conveys each console's dimensions.
>=20
> Your patch is trying to change the control message, and not the
> config
> space.
>=20
> Now - the lack of the 'struct size' definition for the control
> message
> in the spec is unfortunate, but that can be easily added -- and I
> prefer we add it based on this Linux implementation (ie. first rows,
> then cols).

Under section 5.3.6.2 multiport device operation for
VIRTIO_CONSOLE_RESIZE the spec says the following

```
Sent by the device to indicate a console size change. value is unused.
The buffer is followed by the number of columns and rows:

struct virtio_console_resize {=20
        le16 cols;=20
        le16 rows;=20
};
```

It would be extremely surprising to me if the section `multiport device
operation` does not document resize for multiport control messages, but
rather config messages, especially as VIRTIO_CONSOLE_RESIZE is
documented as a virtio_console_control event.

In fact as far as I can tell this is the only part of the spec that
documents resize. I would be legitimately interested in resizing
without multiport and I would genuinely like to find out about how it
could be used. In what section of the documentation could I find it?

>=20
> But note that all this only affects devices that implement multiport
> support, and have multiple console ports on a single device.=C2=A0 I don'=
t
> recall there are any implementations using such a configuration.
>=20
> ... which all leads me to ask if you've actually seen a
> misconfiguration happen when trying to resize consoles which led to
> this patch.
>=20
> 		Amit

