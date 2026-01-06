Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC043019BE
	for <virtualization@lists.linux.dev>; Tue,  6 Jan 2026 18:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767723474; cv=none; b=UnrltzWA2Pa5e3ukzZCTkg/QxalE820xRaQ93JV8Jogck/kJo35Xz7yRaflrd3JMTrl5EQUseXUvo8FoTTiSVO7N2P85Zke/rPovlLlgX9nDlN175kPWB6PNPH0foyEyj4TN3d+7AnFnQ3PO/7p0csSZCRxP8dH8zJqPq/cZ1u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767723474; c=relaxed/simple;
	bh=hbVXGVUkpaJ36ieg+1Gp9BoxksljLrOy+6GnHSTFfV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I0KjXEaV/kM/NK2ZymbL3aMpC85Sg/RqEs7EdZnHpcVNOEzExyqtZGfsNQQnUaY+vi6l3T+XuzZZh5sf9cP0B9aJHpCpm9y8KbPfRjvtSnmH/xv2VJsp8v1/xNi1pL7idQFKLRO8EOq8UuvZ70cTQmV8fXQK9imVkqPPZ787SzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NC+JFZEs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NC+JFZEs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767723471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NfVy8of3+aJW6NeuJLXPr8pnZKn/sYRSl6dFs62/nAA=;
	b=NC+JFZEsHmthhlPAWGGGFMAf09hFnxEpuylom5F3S9Pf1MI0VX63Qo4RddsK8fx2cP0XYH
	4khij9gGEiehq3JRuECrNBwVn0I7dc6OS9mhy/xvf5pBKZeSGrDro9PSd/E50HU+yxug3k
	f8vVlOCJSF1RG+CbBNnYig7f1Yq+Yy0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-8S4c5p8rPH6gKkYTnBViBw-1; Tue, 06 Jan 2026 13:17:50 -0500
X-MC-Unique: 8S4c5p8rPH6gKkYTnBViBw-1
X-Mimecast-MFC-AGG-ID: 8S4c5p8rPH6gKkYTnBViBw_1767723469
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b79ff60ed8eso145755766b.0
        for <virtualization@lists.linux.dev>; Tue, 06 Jan 2026 10:17:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767723469; x=1768328269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NfVy8of3+aJW6NeuJLXPr8pnZKn/sYRSl6dFs62/nAA=;
        b=c5nZvLD1P06A6bwHMvwDXBkNI80Dibxy08zW1k0CLC6dh0hhA9ZAwCfNpazwdocT1W
         wK+hG4OuDqt4gGR4rbmlZQbzfKBEDEEZcvcw7TkKuOQVp5Ix65819g2Q3M01Jbe9aJn/
         wivJjYXoy3EgXLcFUQogp5bZ62J9uf8wh24ilb6i1YSGFwgZwZ4yf3oABQENMWdo+89q
         1oOFBqYB0CNhdGZxbe8KyYpwli76yKMCImfzWLVkN4bRBpqbMBIwQ39xij/MGDVTHpH3
         kmbYRupc4fAQP4XOoP9M2NFfpoX59LRjkuzdqeZRCYPKMrhxsxkEKULQ2fcxs443oisl
         /3dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrsQtyw/aG083YeFOFNIk1V4fgOf6nXwYUs+Wr30EP9LwkAFt+vxpum5n50PJQ6glN23e1fuviRjYvO/UwyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyAduB7eFr2lrgUYDAH26uTw7j9TNBK9gHe+IuhLHJ9SgXKXXKO
	pszkqHa8IX2z4ImIY+9nU4kUSV4nVcdns6o9qtGDYvkb1oc8TFmi5ALCji212yfFrQkraVK3Txh
	Jof4hrRn9Vt1ZT0whQTcNi7c/AeoVbfmiOECEA6g7FxHeCT7KE+RREMpyi30Fo/P38K3dT2fTmO
	hUd5yiMVKF+aHDT+pI1NYRrlSfRz+vGLh+Z+Z/J2Y5dQ0=
X-Gm-Gg: AY/fxX7bubIaCaUVP3WTcQ6iaZYkus21mBOCuIabCbPanMnCRCsx/9MN1jxreMcL7Sh
	fO4ozMchwHVEOsFv32qrfYty0JBfsVerATPw0aDJ/BGuORxtNdy/9Co6urvuW4WdlKsJik/MpCX
	ZgYRQ+b8ek5sBwFS1QfdDLR4r+XAn515SzYzzJZpGx/lryxCFmtMY76XDmHlX3i+lgFM9QyVzq/
	cGgpxegjEGkdMO3efdqRCIe
X-Received: by 2002:a17:907:1c09:b0:b80:402f:569e with SMTP id a640c23a62f3a-b8444f3b2c0mr7683466b.25.1767723469222;
        Tue, 06 Jan 2026 10:17:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbW+DIj65TyFKYfPGXJs0UUucWEQ4iwiu139bnv8qw7NBLAUOB2v79PYba6VDsXnm+Y7t5P+yjtPw4ydyHEZQ=
X-Received: by 2002:a17:907:1c09:b0:b80:402f:569e with SMTP id
 a640c23a62f3a-b8444f3b2c0mr7681466b.25.1767723468813; Tue, 06 Jan 2026
 10:17:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <aQJRnX7OpFRY/1+H@fedora> <aQkgsuxa2UaL_qdt@bywater>
 <aTsE1VIk4V/A49HE@fedora> <aT7XAsTWr0_yyfx_@bywater> <aVLOPMmpvArnVAHZ@fedora>
 <aVLq1ibPcPHk-7Qv@bywater> <aVWQ0laxIdp3fx+p@fedora>
In-Reply-To: <aVWQ0laxIdp3fx+p@fedora>
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Date: Tue, 6 Jan 2026 19:17:37 +0100
X-Gm-Features: AQt7F2r9-ci3DQUZfnLTBt5oJltITOVEcZKMD_u9FzKGObMxxXgIW9lPtyc0X0Q
Message-ID: <CAHYGQ0yVCgguwnLLYBCFrtEuNMErNaB5Fye5HG_KoZgusixh3Q@mail.gmail.com>
Subject: Re: [PATCH v6] can: virtio: Add virtio CAN driver
To: Francesco Valla <francesco@valla.it>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Harald Mommer <harald.mommer@oss.qualcomm.com>, 
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-can@vger.kernel.org, 
	virtualization@lists.linux.dev, Wolfgang Grandegger <wg@grandegger.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 63_bqQ_LNMDQ4mBSF2aW6sDnR8DZ0LW9cRP0OqAdEvU_1767723469
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 10:08=E2=80=AFPM Matias Ezequiel Vara Larsen
<mvaralar@redhat.com> wrote:
>
> On Mon, Dec 29, 2025 at 09:55:50PM +0100, Francesco Valla wrote:
> > Hi Matias,
> >
> > On Mon, Dec 29, 2025 at 07:53:48PM +0100, Matias Ezequiel Vara Larsen w=
rote:
> > > > While stress testing this, I noticed that flooding the virtio-can
> > > > interface with packets leads to an hang of the interface itself.
> > > > I am seeing this issuing, at host side:
> > > >
> > > >   while true; do cansend can0 123#00; done
> > > >
> > > > with:
> > > >
> > > >  - QEMU: the tip of the master branch plus [2]
> > > >  - vhost-device: the tip of the main branch
> > > >
> > > > and the following QEMU invocation:
> > > >
> > > > qemu-system-x86_64 -serial mon:stdio \
> > > >     -m 2G -smp 2 \
> > > >     -kernel $(pwd)/BUILD.bin/arch/x86/boot/bzImage \
> > > >     -initrd /home/francesco/SRC/LINUX_KERNEL/initramfs.gz \
> > > >     -append "loglevel=3D7 console=3DttyS0" \
> > > >     -machine memory-backend=3Dpc.ram \
> > > >     -object memory-backend-file,id=3Dpc.ram,size=3D2G,mem-path=3D/t=
mp/pc.ram,share=3Don \
> > > >     -chardev socket,id=3Dcan0,path=3D/tmp/sock-can0 \
> > > >     -device vhost-user-can-pci,chardev=3Dcan0
> > > >
> > > >
> > > > Restarting the interface (i.e.: ip link set down and the up) does n=
ot
> > > > fix the situation.
> > > >
> > > > I'll try to do some more testing during the next days.
> > >
> > > I tried this and I could not reproduce it. [2] requires a minimal cha=
nge
> > > to apply, i.e., qdev-properties.h has changed to /core. I'll send a v=
2
> > > for that. I used latest vhost-device-can. I run `candump can0` in the
> > > guest and `while true; do cangen vcan0; done` in the host. Am I missi=
ng
> > > something?
> >
> > With the plain 'cangen' you are not really flooding the interface, sinc=
e
> > you are only sending a random CAN frame every 200ms. The only way I can
> > reproduce this behaviour in a consistent manner is running from the hos=
t:
> >
> >     while true; do cansend vcan0 134#00; done
> >
> > which seems to generate the maximum amount of traffic.
> >
> You were right. I could reproduce it. After a while, I stop to get packet=
s
> in the guest. I'll investigate.
>

I think I found the problem and it is in the device. When the driver
adds descriptors in the rx queue, It seems the device is collecting
all descriptors from the rx queue and trying to consume them in one
run. However, in some situations, there are not enough msgs to write
in a descriptor and the device returns but the descriptor is never
consumed and the driver does not provide a new one. I can see that the
host continues to send msgs to the device but the number of
descriptors in the rx queue continues to be 0. I am trying to figure
out how to fix it.

Matias

