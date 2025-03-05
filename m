Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3316120767D;
	Wed,  5 Mar 2025 09:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741168457; cv=none; b=WQ4i11ZweemJW1l6aXF/+/2qsyuUIYogrgSOFAXSZXeaj9hpTmeWfl2d4aLeU0iyz3IursOHU4KZw8jWku/9WEltPnCBUTW8frA+EoNoPoFrBxlHapo/94TKF+9OxSMRqb2v32eUgT3ZHWb8CBJg6WzttK3Ronu/CaggM4vBwm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741168457; c=relaxed/simple;
	bh=47zWW+Fr0D8QYJuhnQ/YtVqvKTSCmEhDCJoJcn5cftI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A7sJdzREi5OdABkfXw+jXKdvi+J+EVZFUiEnTqRg/7eHSRBxmC0h5s8dDEpJ9N//9XF5LvTt7T1JN/mo+k3SfnjaG4wMc0y7VjpjF/ERH/2qfGws+oDkwHOu5I1lDkjwMoiJCXQHwl+DgkCFApVowhUJ1Yrt217F3Mu4nPOS0+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WTdMVXcm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WTdMVXcm"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5253kZAq017524;
	Wed, 5 Mar 2025 09:54:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZzlX3s
	0R7mufZH7jZS1CETYjVYKtQO8/6ocCC0sPuE4=; b=WTdMVXcmCTpkgS8EOuRySw
	yVW7kRloxvIYP83cQoyhdu7s9MElgtb/xAzsUvt9kCrcwi7gEMcuOcS4HZr+d1sz
	Bjb3CoRa7ST8YBAD+GJWmze42I+ZkjyhYI2XFQy/yAdxrkcM3qmGIt6X1X7G+5ek
	HXTgE31OA3q2XwiB1TTlTUtMtmGSu4g2uh+4FGc5AYutpheoSc+/vc24xsS5cdzY
	EuE0bku6mLkCmHn7JBCtsC92kF2ezHR7qNyip8ZhoNawkMgd+NsI9Csa5KkPKPaf
	XoDR+CYivd4FCK5MjoOaccqEHVjlnXYXwrVVuYRMRt+YS/fCC4IIXAHW7MIegnoA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 456f08sfjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 09:54:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5258mWVT020800;
	Wed, 5 Mar 2025 09:54:02 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 454esk1u6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 09:54:02 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5259rxeF28836134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Mar 2025 09:53:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B8C6201F3;
	Wed,  5 Mar 2025 09:53:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10AD9201F4;
	Wed,  5 Mar 2025 09:53:59 +0000 (GMT)
Received: from li-9b52914c-2c8b-11b2-a85c-a36f6d484b4a.boeblingen.de.ibm.com (unknown [9.155.199.15])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  5 Mar 2025 09:53:59 +0000 (GMT)
Message-ID: <67efe42ea8c10120f13f14838f7a3d883184ecf5.camel@linux.ibm.com>
Subject: Re: [PATCH] virtio: console: Make resizing compliant with virtio
 spec
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: Amit Shah <amit@kernel.org>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, brueckner@linux.ibm.com,
        schnelle@linux.ibm.com, pasic@linux.ibm.com
Date: Wed, 05 Mar 2025 10:53:58 +0100
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
X-Proofpoint-ORIG-GUID: mWYQOhJiau8aZ-pwAh38ouil9ZlVMcEl
X-Proofpoint-GUID: mWYQOhJiau8aZ-pwAh38ouil9ZlVMcEl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_03,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 adultscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503050075

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

I didn't know about this patch-set, however as of right now QEMU does
not set VIRTIO_CONSOLE_F_SIZE, never uses VIRTIO_CONSOLE_RESIZE, and
resizing is never mentioned in hw/char/virtio-console.c or
hw/char/virtio-serial-bus.c. Suffice to say I don't see any indicating
of resize currently being used under QEMU. Perhaps QEMU supported
resizing at one point, but not anymore. If you disagree please send me
where the resizing logic can currently be found in the QEMU source
code. I at least was unable to find it.

>=20
> > diff --git a/drivers/char/virtio_console.c
> > b/drivers/char/virtio_console.c
> > index 24442485e73e..9668e89873cf 100644
> > --- a/drivers/char/virtio_console.c
> > +++ b/drivers/char/virtio_console.c
> > @@ -1579,8 +1579,8 @@ static void handle_control_message(struct
> > virtio_device *vdev,
> > =C2=A0 break;
> > =C2=A0 case VIRTIO_CONSOLE_RESIZE: {
> > =C2=A0 struct {
> > - __u16 rows;
> > =C2=A0 __u16 cols;
> > + __u16 rows;
> > =C2=A0 } size;
> > =C2=A0
> > =C2=A0 if (!is_console_port(port))
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
>  Amit

I'm working on implementing console resizing for virtio in QEMU and
Libvirt. As SIGWINCH is raised on the virsh frontend the new console
size needs to be transfered to QEMU (in my RFC patch via QOM, which
then causes QEMU to trigger a virtio control msg in the chr_resize
function of the virtio-console chardev). (The patch-set should make its
way unto the QEMU mailing-list soon). The way I implemented it QEMU
sends a resize control message where the control message has the
following format:

```
struct {
    le32 id;    // port->id
    le16 event; // VIRTIO_CONSOLE_RESIZE
    le16 value; // 0
    le16 cols;  // ws.ws_col
    le16 rows;  // ws.ws_row
}
```

This strongly seems to me to be in accordance with the spec[0]. It
resulted in the rows and cols being switched after a resize event. I
was able to track the issue down to this part of the kernel. Applying
the patch I sent upstream, fixed the issue.
As of right now I only implemented resize for multiport (because in the
virtio spec I was only able to find references to resizing as a control
message which requires multiport. In your email you claimed that config
space resizing exists as well. I was only able to find references to
resizing as a control message in the spec. I would love to see what
part of the spec you are refering to specifically, as it would allow me
to implement resizing without multiport as well).=20
It seems to me that either the spec or the kernel implementation has to
change. If you prefer changing the spec that would be fine by me as
well, however there seems to be no implementation that uses the linux
ordering and Alpine seems to patch their kernel to use the spec
ordering instead (as described in the initial email)(this was really
Niklas Schnelle's finding so for further questions I would refer to
him).

[0]
https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html=
#x1-2980006

