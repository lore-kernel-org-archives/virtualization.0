Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788A52512DE;
	Wed, 19 Mar 2025 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742375583; cv=none; b=D5R70DDRSV1EzbULv5bup4gBilqtslJgdjvkSFqsaSQm6O4Tu5PqwMXBOTxPItlm+VfaMH9ttx4rFG3wlUhWDjqJZ1ynhH3Se9ENofMIRmsGp163wHU5UU/JOwb7DAgx1QyrLSVEyM010X62TSAKdjsfSNKcJ1rMkmdkbFZXbO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742375583; c=relaxed/simple;
	bh=Mi1MTCTK3bzz3F58KuznINtPcGv3R+R6E1K9KEVJTeU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E9mfUbR9DR77H2VSWVK9bZYnn4bJUG1lO0I4Zkb3bHEQuPiNAaz8UHS8htCk0SEOKjHx/RnZyk057yeC9IBJvDyRsvx2lI+Zbv6ZPamU2RUesDAapxbEp62wp/WQ1oXFX2vuHTKHNVp7DiKIkT4jqYaBE6zIGX739w72pjpnJs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flMv/SXI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flMv/SXI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7BEC4CEE9;
	Wed, 19 Mar 2025 09:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742375582;
	bh=Mi1MTCTK3bzz3F58KuznINtPcGv3R+R6E1K9KEVJTeU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=flMv/SXI2+a9OWJWwBf5kxte7Tfg+pomOJO/WIjjB4hpwF2EEDtbdEwkTcUqb1Kl1
	 BDtG3b/F6tM0LL2BQzP15ZNywd6Jw5ymjT4Yg2DzDtGgbq5Gr62ZlVgefQLwa1myDt
	 cHfrW+GcSLukXcMVTpPOhzLAFcTB8jN8FSj7VlGYG9WPD07enhlz/GPkKjxacWh7JT
	 JHJ2MpZgUAqIalanjrRwbpwGljNbdj5A4AotStcFPQo7nSMLQw6EKPG6mQYC6pDLT2
	 0OhAcLFqotkLW1TkkleimY7yAcbKQ0avEM+oPL5co9zHX/mXz54iFFnlNWB9Pqw+50
	 3n9J/GKIxo6Zw==
Message-ID: <47658d4bed58f30e2dcb806f2e6c0258de87ba43.camel@kernel.org>
Subject: Re: [PATCH] virtio: console: Make resizing compliant with virtio
 spec
From: Amit Shah <amit@kernel.org>
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, brueckner@linux.ibm.com, 
	schnelle@linux.ibm.com, pasic@linux.ibm.com
Date: Wed, 19 Mar 2025 10:12:58 +0100
In-Reply-To: <1da328a9ec235e3c163dec1631fbb2d39966ac1f.camel@linux.ibm.com>
References: <20250225092135.1200551-1-maxbr@linux.ibm.com>
		 <f5ab160dadc2219b9576e50588dce88f22e9bcb1.camel@kernel.org>
		 <649563cf1b8abd42401ed78d84bfd576d48bdbb8.camel@linux.ibm.com>
		 <f27debf87882df65574f21cfced31fecf1dd1da3.camel@kernel.org>
	 <1da328a9ec235e3c163dec1631fbb2d39966ac1f.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Wed, 2025-03-19 at 09:54 +0100, Maximilian Immanuel Brandtner wrote:
> On Tue, 2025-03-18 at 15:25 +0100, Amit Shah wrote:
> > On Tue, 2025-03-18 at 11:07 +0100, Maximilian Immanuel Brandtner
> > wrote:
> > > On Mon, 2025-03-03 at 12:54 +0100, Amit Shah wrote:
> > > > On Tue, 2025-02-25 at 10:21 +0100, Maximilian Immanuel
> > > > Brandtner
> > > > wrote:
> > > > > According to the virtio spec[0] the virtio console resize
> > > > > struct
> > > > > defines
> > > > > cols before rows. In the kernel implementation it is the
> > > > > other
> > > > > way
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
> > > >=20
> > > > > diff --git a/drivers/char/virtio_console.c
> > > > > b/drivers/char/virtio_console.c
> > > > > index 24442485e73e..9668e89873cf 100644
> > > > > --- a/drivers/char/virtio_console.c
> > > > > +++ b/drivers/char/virtio_console.c
> > > > > @@ -1579,8 +1579,8 @@ static void
> > > > > handle_control_message(struct
> > > > > virtio_device *vdev,
> > > > > =C2=A0		break;
> > > > > =C2=A0	case VIRTIO_CONSOLE_RESIZE: {
> > > > > =C2=A0		struct {
> > > > > -			__u16 rows;
> > > > > =C2=A0			__u16 cols;
> > > > > +			__u16 rows;
> > > > > =C2=A0		} size;
> > > > > =C2=A0
> > > > > =C2=A0		if (!is_console_port(port))
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
> > >=20
> > > Under section 5.3.6.2 multiport device operation for
> > > VIRTIO_CONSOLE_RESIZE the spec says the following
> > >=20
> > > ```
> > > Sent by the device to indicate a console size change. value is
> > > unused.
> > > The buffer is followed by the number of columns and rows:
> > >=20
> > > struct virtio_console_resize {=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le16 cols;=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le16 rows;=20
> > > };
> > > ```
> >=20
> > Indeed.
> >=20
> >=20
> > > It would be extremely surprising to me if the section `multiport
> > > device
> > > operation` does not document resize for multiport control
> > > messages,
> > > but
> > > rather config messages, especially as VIRTIO_CONSOLE_RESIZE is
> > > documented as a virtio_console_control event.
> >=20
> > You're right.
> >=20
> > I was mistaken in my earlier reply - I had missed this
> > virtio_console_resize definition in the spec.=C2=A0 So indeed there's a
> > discrepancy in Linux kernel and the spec's ordering for the control
> > message.
> >=20
> > OK, that needs fixing someplace.=C2=A0 Perhaps in the kernel (like your
> > orig. patch), but with an accurate commit message.
> >=20
> > Like I said, I don't think anyone is using this control message to
> > change console sizes.=C2=A0 I don't even think anyone's using multiple
> > console ports on the same device.
> >=20
> > > In fact as far as I can tell this is the only part of the spec
> > > that
> > > documents resize. I would be legitimately interested in resizing
> > > without multiport and I would genuinely like to find out about
> > > how
> > > it
> > > could be used. In what section of the documentation could I find
> > > it?
> >=20
> > See section 5.3.4 that describes `struct virtio_console_config` and
> > this note:
> >=20
> > ```
> > =C2=A0=C2=A0=C2=A0 If the VIRTIO_CONSOLE_F_SIZE feature is negotiated, =
the driver
> > can
> > read the console dimensions from cols and rows.=20
> > ```
> > 		Amit
>=20
> The way I understand VIRTIO_CONSOLE_F_SIZE, it has to be negotiated
> for
> any resize events to be sent (including resize control messages) (at
> least as of right now it is necessary to enable this feature to sent
> resize control messages).

That's right, but virtio feature negotiation just means that the host
and guest figure out what the other endpoint supports.  Console
resizing wasn't part of the orig virtio console implementation, and was
added later.

For the resizing case, it's one-way communication from the host to the
guest: the host sets row/col values and notifies the guest.  If the
guest is old and does not have the F_SIZE feature, it will just ignore
it.  If the host doesn't have that feature, well, it can't send the
resize messages.

The commit to resize the console was added way back in 2008:

https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/drivers/char/virtio_console.c?id=3Dc29834584ea4eafccf2f62a0b8a32e64f7920=
44c

This line:

+	if (virtio_has_feature(dev, VIRTIO_CONSOLE_F_SIZE)) {

is the negotiation part -- if the host device has that feature, read
the values from the config space and apply them.

		Amit
