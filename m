Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96A622371A;
	Mon, 10 Mar 2025 13:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741611913; cv=none; b=qLRbo4eJFZ75lZpciIk2/HQmeVt/FNNLuOxermU1MJc8ezDtePFiYM45lE4pwhsJSgVblBEId4ySjx2ftXJgobG9nTVgD1gzjikV5L52Y5Z6uUKZNoTQ0BCjl77UpStOSh1JcFmZPET9cNT/ePtH7DT54XYwlNiy0A5kJhC/Afc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741611913; c=relaxed/simple;
	bh=jSWalryUBeg65pH1e5awawo2SZjfFgHRyuFhxxW6sks=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pXMYweEWVIN5y9/QFHa1tj1ART2eCeJsPXb2S7qtT5MFBekIgnTc1eKwsI+KgrdN0R71bm5mULZ127BD6MnB3OKtvUs0Y1Hu2nLTQj3zlUxRPtVuUKqFV3B+oNM0GbyJM4nF4XKK1rDynFpzRfwQ4RtXkBUBTOhxWYBDW2g4tno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RWWT7F3S; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RWWT7F3S"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52A3kdoM018172;
	Mon, 10 Mar 2025 13:05:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jSWalr
	yUBeg65pH1e5awawo2SZjfFgHRyuFhxxW6sks=; b=RWWT7F3S396tmF31p1gWDa
	spTZTQBEya+9jdR1hRElHql/UHNIXH07cx4uhF+/JrnwWiwbp9F7hrVFBuP4fEY/
	d9F+GqUnCtyKTUhlaG5tmbPbLHUMI4NcBa9QAXjsV0zjHsWIR+J36m4Eimga3N7J
	4gdn2znPL+xJ6nbLiYYcpj1ox/IJsJ+n8/JLysDyDjW7b9guwP5teAA2niHwkSIs
	asppQsGMlBmHHpbhmoc9Q8cgEmE+kIYLT3mncz6tAM2F1Mkg88rnOcUOFOBJPtTH
	JcYsU1H/P1ROMaPGzeVaNwuK563yHDz1hXlGVvCDp9N0R/bPw//TDUK1BLwdYrRw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 459rf92hn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 13:05:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52AB06nl027544;
	Mon, 10 Mar 2025 13:05:02 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4591qkektt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 13:05:02 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52AD4wVb9044426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 13:04:58 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B80B020043;
	Mon, 10 Mar 2025 13:04:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84FAE2004E;
	Mon, 10 Mar 2025 13:04:58 +0000 (GMT)
Received: from li-9b52914c-2c8b-11b2-a85c-a36f6d484b4a.boeblingen.de.ibm.com (unknown [9.155.199.15])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 10 Mar 2025 13:04:58 +0000 (GMT)
Message-ID: <62008b201c5a64df28c0039020d9bd7959744014.camel@linux.ibm.com>
Subject: Re: [PATCH] virtio: console: Make resizing compliant with virtio
 spec
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>, Amit Shah <amit@kernel.org>,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, brueckner@linux.ibm.com,
        pasic@linux.ibm.com
Date: Mon, 10 Mar 2025 14:04:56 +0100
In-Reply-To: <12d78b156c65130c60503b3925b4440d570fa245.camel@linux.ibm.com>
References: <20250225092135.1200551-1-maxbr@linux.ibm.com>
	 <f5ab160dadc2219b9576e50588dce88f22e9bcb1.camel@kernel.org>
	 <67efe42ea8c10120f13f14838f7a3d883184ecf5.camel@linux.ibm.com>
	 <35286574f42ae6a413eaca14633a11d50cbadb2b.camel@linux.ibm.com>
	 <12d78b156c65130c60503b3925b4440d570fa245.camel@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 85uaQQHaeomS4ek-cXBD-eYvGD1fdbEF
X-Proofpoint-GUID: 85uaQQHaeomS4ek-cXBD-eYvGD1fdbEF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_05,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503100102

On Wed, 2025-03-05 at 13:15 +0100, Niklas Schnelle wrote:
> On Wed, 2025-03-05 at 13:13 +0100, Niklas Schnelle wrote:
> > On Wed, 2025-03-05 at 10:53 +0100, Maximilian Immanuel Brandtner
> > wrote:
> > > On Mon, 2025-03-03 at 12:54 +0100, Amit Shah wrote:
> > > > On Tue, 2025-02-25 at 10:21 +0100, Maximilian Immanuel
> > > > Brandtner
> > > > wrote:
> > > > > According to the virtio spec[0] the virtio console resize
> > > > > struct
> > > > > defines
> > > > > cols before rows. In the kernel implementation it is the
> > > > > other way
> > > > > around
> > > > > resulting in the two properties being switched.
> > > >=20
> > > > Not true, see below.
> > > >=20
> > > > > While QEMU doesn't currently support resizing consoles,
> > > > > TinyEMU
> > > >=20
> > > > QEMU does support console resizing - just that it uses the
> > > > classical
> > > > way of doing it: via the config space, and not via a control
> > > > message
> > > > (yet).
> > > >=20
> > > > https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/tree/drivers/char/virtio_console.c#n1787
> > > >=20
> > > > https://lists.nongnu.org/archive/html/qemu-devel/2010-05/msg00031.h=
tml
> > >=20
> > > I didn't know about this patch-set, however as of right now QEMU
> > > does
> > > not set VIRTIO_CONSOLE_F_SIZE, never uses VIRTIO_CONSOLE_RESIZE,
> > > and
> > > resizing is never mentioned in hw/char/virtio-console.c or
> > > hw/char/virtio-serial-bus.c. Suffice to say I don't see any
> > > indicating
> > > of resize currently being used under QEMU. Perhaps QEMU supported
> > > resizing at one point, but not anymore. If you disagree please
> > > send me
> > > where the resizing logic can currently be found in the QEMU
> > > source
> > > code. I at least was unable to find it.
> > >=20
> > > >=20
> > > > > diff --git a/drivers/char/virtio_console.c
> > > > > b/drivers/char/virtio_console.c
> > > > > index 24442485e73e..9668e89873cf 100644
> > > > > --- a/drivers/char/virtio_console.c
> > > > > +++ b/drivers/char/virtio_console.c
> > > > > @@ -1579,8 +1579,8 @@ static void
> > > > > handle_control_message(struct
> > > > > virtio_device *vdev,
> > > > > =C2=A0 break;
> > > > > =C2=A0 case VIRTIO_CONSOLE_RESIZE: {
> > > > > =C2=A0 struct {
> > > > > - __u16 rows;
> > > > > =C2=A0 __u16 cols;
> > > > > + __u16 rows;
> > > > > =C2=A0 } size;
> > > > > =C2=A0
> > > > > =C2=A0 if (!is_console_port(port))
> > > >=20
> > > > This VIRTIO_CONSOLE_RESIZE message is a control message, as
> > > > opposed
> > > > to
> > > > the config space row/col values that is documented in the spec.
> > > >=20
> > > > Maybe more context will be helpful:
> > > >=20
> > > > Initially, virtio_console was just a way to create one hvc
> > > > console
> > > > port
> > > > over the virtio transport.=C2=A0 The size of that console port coul=
d
> > > > be
> > > > changed by changing the size parameters in the virtio device's
> > > > configuration space.=C2=A0 Those are the values documented in the
> > > > spec.=20
> > > > These are read via virtio_cread(), and do not have a struct
> > > > representation.
> > > >=20
> > > > When the MULTIPORT feature was added to the virtio_console.c
> > > > driver,
> > > > more than one console port could be associated with the single
> > > > device.
> > > > Eg. we could have hvc0, hvc1, hvc2 all as part of the same
> > > > device.=20
> > > > With this, the single config space value for row/col could not
> > > > be
> > > > used
> > > > for the "extra" hvc1/hvc2 devices -- so a new
> > > > VIRTIO_CONSOLE_RESIZE
> > > > control message was added that conveys each console's
> > > > dimensions.
> > > >=20
> > > > Your patch is trying to change the control message, and not the
> > > > config
> > > > space.
> > > >=20
> > > > Now - the lack of the 'struct size' definition for the control
> > > > message
> > > > in the spec is unfortunate, but that can be easily added -- and
> > > > I
> > > > prefer we add it based on this Linux implementation (ie. first
> > > > rows,
> > > > then cols).
> > > >=20
> > > > But note that all this only affects devices that implement
> > > > multiport
> > > > support, and have multiple console ports on a single device.=C2=A0 =
I
> > > > don't
> > > > recall there are any implementations using such a
> > > > configuration.
> > > >=20
> > > > ... which all leads me to ask if you've actually seen a
> > > > misconfiguration happen when trying to resize consoles which
> > > > led to
> > > > this patch.
> > > >=20
> > > > =C2=A0Amit
> > >=20
> > > I'm working on implementing console resizing for virtio in QEMU
> > > and
> > > Libvirt. As SIGWINCH is raised on the virsh frontend the new
> > > console
> > > size needs to be transfered to QEMU (in my RFC patch via QOM,
> > > which
> > > then causes QEMU to trigger a virtio control msg in the
> > > chr_resize
> > > function of the virtio-console chardev). (The patch-set should
> > > make its
> > > way unto the QEMU mailing-list soon). The way I implemented it
> > > QEMU
> > > sends a resize control message where the control message has the
> > > following format:
> > >=20
> > > ```
> > > struct {
> > > =C2=A0=C2=A0=C2=A0 le32 id;=C2=A0=C2=A0=C2=A0 // port->id
> > > =C2=A0=C2=A0=C2=A0 le16 event; // VIRTIO_CONSOLE_RESIZE
> > > =C2=A0=C2=A0=C2=A0 le16 value; // 0
> > > =C2=A0=C2=A0=C2=A0 le16 cols;=C2=A0 // ws.ws_col
> > > =C2=A0=C2=A0=C2=A0 le16 rows;=C2=A0 // ws.ws_row
> > > }
> > > ```
> > >=20
> > > This strongly seems to me to be in accordance with the spec[0].
> > > It
> > > resulted in the rows and cols being switched after a resize
> > > event. I
> > > was able to track the issue down to this part of the kernel.
> > > Applying
> > > the patch I sent upstream, fixed the issue.
> > > As of right now I only implemented resize for multiport (because
> > > in the
> > > virtio spec I was only able to find references to resizing as a
> > > control
> > > message which requires multiport. In your email you claimed that
> > > config
> > > space resizing exists as well. I was only able to find references
> > > to
> > > resizing as a control message in the spec. I would love to see
> > > what
> > > part of the spec you are refering to specifically, as it would
> > > allow me
> > > to implement resizing without multiport as well).=20
> > > It seems to me that either the spec or the kernel implementation
> > > has to
> > > change. If you prefer changing the spec that would be fine by me
> > > as
> > > well, however there seems to be no implementation that uses the
> > > linux
> > > ordering and Alpine seems to patch their kernel to use the spec
> > > ordering instead (as described in the initial email)(this was
> > > really
> > > Niklas Schnelle's finding so for further questions I would refer
> > > to
> > > him).
> >=20
> > I don't think this was patched in the (official) alpine kernel.
> > What
> > happened is that I tested TinyEMU[0] with the kernel + initrd from
> > the
> > JSLinux site and that has working console resizing. In the TinyEMU
> > code
> > this is implemented in
> > TinyEMU/virtio.c:virtio_console_resize_event():
> >=20
> > void virtio_console_resize_event(VIRTIODevice *s, int width, int
> > height)
> > {
> > =C2=A0=C2=A0=C2=A0 /* indicate the console size */
> > =C2=A0=C2=A0=C2=A0 put_le16(s->config_space + 0, width);
> > =C2=A0=C2=A0=C2=A0 put_le16(s->config_space + 2, height);
> >=20
> > =C2=A0=C2=A0=C2=A0 virtio_config_change_notify(s);
> > }
> >=20
> > On second look this indeed seems to use the config space. It writes
> > first the width then height which matches config_work_handler().
> > But
> > like Maximilian I could only find the VIRTIO_CONSOLE_RESIZE message
> > mechanism in the spec, also with width (cols) then height (rows)
> > but
> > not matching the kernel struct changed by this patch.
> >=20
>=20
> Forgot to note, the idea that Alpine was patched came because the
> kernel used in TinyEMU has '-dirty' in the local version so we were
> wondering if it was patched for this. But seeing the
> config_work_handler() it's probably just using that.
>=20
> Thanks,
> Niklas

Just to make sure that everyone here is one the same page there is
indeed a difference between the ordering of the control resize message
and the kernel implementation; however as this bug has been around for
~15 years the spec should be changed instead, right?

I would like to get a clear ACK of the issue, as I would like to
reference this discussion when creating a bug-report on the virtio-spec
github.

Thanks,
Max
