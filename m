Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614AD1292FC
	for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 11:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713267197; cv=none; b=Mv0HJ23jmf4fdooXhr7eIL7UuE6C7Qq/xNBhfq34IN9kmMdQmgmfHatzOaSF58MNNUrnpFijpV9LcRbO1q2kC2lw5s0MvTPjLCoxAYye1tuDonWo7xV6pwe764gS8WmroBvFGA3/0lt9y7WCET6Jirt18BGihaTkvXBFavUeEEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713267197; c=relaxed/simple;
	bh=1tGDnXR/Xobyxxthz2qYMHcG2MvdM2q6TFDh9mKXEdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tEx+LbTZRiStMfp5DRmSmsTlFDzn6x6qtQIYKyyxaxTx5Qw0+x1NexXnMcQPWohnmGm8adpAdTZ8w8urfv9pZJrvaOHBQ0yGYaLBUZJAdsoqV2Qn3fsGSrbVn5LRrgWDF2vFOc6wn6RO/bB/TJsF+ckhFJL2m7kE9HXP/c+Z0rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aqrX6Il+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aqrX6Il+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713267194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d9QTq/NdCJL4pdjxuU7HFgX1xOaFV7P8M1l6PlP/vx0=;
	b=aqrX6Il+3I6hwc62JRZGg1rboMQyfJVL+2kidsIYwzDsyuhodjBSqKVKe5RcB+ySt0OHAb
	LNCHJF+4Oqtf1dx5VkUN+3LA4BHdvc04H5MpLfPsbfFQHoivQDTR3M1iPValSHOklMwfom
	7VZ8P5p4PATbDDUiFodEgf7/f3LUqq8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-XDjEJ779NM2hsuhv5lQxyw-1; Tue, 16 Apr 2024 07:33:12 -0400
X-MC-Unique: XDjEJ779NM2hsuhv5lQxyw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4183909fec8so15653825e9.0
        for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 04:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713267191; x=1713871991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGYiyNBVXCNC9ZRpGWry6lAWddrP50TJb3y/0v8dEh0=;
        b=jn52bdeeWA6C/u9eP6Y/N9KLpbs45TlzZG/45XrEWStmxSt3mszkIv0sbSyhG+A6FH
         ce8XKpanUArVSPBmPUbsO38P7oiuoIJ2jALwF5CEXa8GouuiFk/xOeMQbTLqt34dn0Rp
         Q9HwwKMJOAAUry/QzJbmzElzbedgywVBG0YekUM+zm/QHljhj87ccCjVuf0R3TKeow5g
         miSr+E1BA9CPk3h7NEYHvpmUA6N6TizqOjeYltWedmgMXTzDgSrRUzEHZVH5vRz7IAK6
         X1TKBFOdtAeTXXEwGiTg1gzI9pdejj8l7Mac2UG2HZrebcgAh6+rEvyo/emCrFkR/cF8
         8F7w==
X-Forwarded-Encrypted: i=1; AJvYcCVoCoBHRVfgVNMq6nrDuq67M1N9Xf7QSsixbpNWGctlYB7SS4gv/h0b4SCQHc9m1dixVgmkHGFl53CezczLoSuQM7UAxJ0GLEjCjeeJgP0=
X-Gm-Message-State: AOJu0YwIVwhnnzmj+ji4hhTU0ZdBBK0A06GWCejZEGjn9c/CufohjUOo
	ObA74WduOw5ElGyMCqiFcvSG9jtnSbChKhlDG0Az7ZY0ySFiWJjwZ1gOmKMaqRZrpTrCfnIHUSH
	feUjBmjjmIp3LJpDDqMdl655i3Ahdm8cJtQiflv9AvfjE8+A8cjnGeU6q2pDc0UMz
X-Received: by 2002:a05:6000:1d86:b0:347:e6ef:ea97 with SMTP id bk6-20020a0560001d8600b00347e6efea97mr4456223wrb.24.1713267191499;
        Tue, 16 Apr 2024 04:33:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFD53Ty+L0X5R/PozAEkNqk8+mB62r/niL7/JgsBj9dwH7AgzjLXldfERNv4WJ7TXF2vpFatw==
X-Received: by 2002:a05:6000:1d86:b0:347:e6ef:ea97 with SMTP id bk6-20020a0560001d8600b00347e6efea97mr4456197wrb.24.1713267191109;
        Tue, 16 Apr 2024 04:33:11 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id d4-20020adfa404000000b003497fba9b1dsm1175397wra.102.2024.04.16.04.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 04:33:10 -0700 (PDT)
Date: Tue, 16 Apr 2024 13:33:09 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ricardo Ribalda <ribalda@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Andrea Righi <andrea.righi@canonical.com>,
 virtualization@lists.linux.dev, stevensd@chromium.org
Subject: Re: ACPI timeouts when enabling KASAN
Message-ID: <20240416133309.6d09ac3b@imammedo.users.ipa.redhat.com>
In-Reply-To: <CANiDSCuvDQWam0v1b3adA=j6w+dA263QruBonsA6TJBvO9XsWQ@mail.gmail.com>
References: <CANiDSCtJKZDwSpy3RWW7FPQiJf+LqxrZJs=N7KrvCz0EFjh2wQ@mail.gmail.com>
	<20240414043707-mutt-send-email-mst@kernel.org>
	<20240415145153.21075173@imammedo.users.ipa.redhat.com>
	<CAJZ5v0j3BVUKDFE-_Tdykt42zCiDfYMpSYN54JUqdr2O8a__1w@mail.gmail.com>
	<CANiDSCuvDQWam0v1b3adA=j6w+dA263QruBonsA6TJBvO9XsWQ@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Apr 2024 16:18:22 +0200
Ricardo Ribalda <ribalda@google.com> wrote:

> Hi Igor, Hi Rafael
>=20
> Yes, it seems that it is just KASAN being extremely slow.
> From a completely newbie here... Is there a reason why qemu generates
> the table vs returning a precomputed one?

it can be a pre-generated Package
like we do with ARM (example: acpi_dsdt_add_pci_route_table)

> This is the config file:
> https://gitlab.freedesktop.org/linux-media/media-ci/-/blob/main/testdata/=
virtme/virtme.config?ref_type=3Dheads
>=20
> And this is the qemu cli:
>=20
> /usr/bin/qemu-system-x86_64 -m 4G -fsdev
> local,id=3Dvirtfs3,path=3D/,security_model=3Dnone,readonly=3Don,multidevs=
=3Dremap
> -device virtio-9p-pci,fsdev=3Dvirtfs3,mount_tag=3D/dev/root -device
> i6300esb,id=3Dwatchdog0 -parallel none -net none -smp 2 -vga none
> -display none -serial chardev:console -chardev
> file,id=3Dconsole,path=3D/proc/self/fd/2 -chardev
> stdio,id=3Dstdin,signal=3Don,mux=3Doff -device virtio-serial-pci -device
> virtserialport,name=3Dvirtme.stdin,chardev=3Dstdin -chardev
> file,id=3Dstdout,path=3D/proc/self/fd/1 -device virtio-serial-pci -device
> virtserialport,name=3Dvirtme.stdout,chardev=3Dstdout -chardev
> file,id=3Dstderr,path=3D/proc/self/fd/2 -device virtio-serial-pci -device
> virtserialport,name=3Dvirtme.stderr,chardev=3Dstderr -chardev
> file,id=3Ddev_stdout,path=3D/proc/self/fd/1 -device virtio-serial-pci
> -device virtserialport,name=3Dvirtme.dev_stdout,chardev=3Ddev_stdout
> -chardev file,id=3Ddev_stderr,path=3D/proc/self/fd/2 -device
> virtio-serial-pci -device
> virtserialport,name=3Dvirtme.dev_stderr,chardev=3Ddev_stderr -chardev
> file,id=3Dret,path=3D/tmp/virtme_retefeobj4f -device virtio-serial-pci
> -device virtserialport,name=3Dvirtme.ret,chardev=3Dret -no-reboot -kernel
> ./arch/x86/boot/bzImage -append 'nr_open=3D1048576
> virtme_link_mods=3D/builds/linux-media/media-staging/.virtme_mods/lib/mod=
ules/0.0.0
> console=3DttyS0 earlyprintk=3Dserial,ttyS0,115200 panic=3D-1
> virtme.exec=3D`c2ggL21lZGlhLWNpL3Rlc3RkYXRhL3ZpcnRtZS90ZXN0LnNoIC9tZWRpYS=
1jaS90aGlyZF9wYXJ0eS92NGwtdXRpbHMgLTMy`
> virtme_root_user=3D1 rootfstype=3D9p
> rootflags=3Dversion=3D9p2000.L,trans=3Dvirtio,access=3Dany raid=3Dnoautod=
etect
> ro init=3D/usr/lib/python3/dist-packages/virtme/guest/virtme-init'

boots fine for me on old Xeon E5-2630v3.
Perhaps issue is that your host is too slow,
is there reason not to use KVM instead of TCG?

Alternatively you can try using q35 machine type
instead of default 'pc', it doesn't have _PRT in
simple configuration like yours.
But then running things that depend on time is not
reliable under TCG, so you might hit timeout elsewhere.

>=20
> Regards!
>=20
> On Mon, 15 Apr 2024 at 14:55, Rafael J. Wysocki <rafael@kernel.org> wrote=
:
> >
> > On Mon, Apr 15, 2024 at 2:52=E2=80=AFPM Igor Mammedov <imammedo@redhat.=
com> wrote: =20
> > >
> > > On Sun, 14 Apr 2024 04:37:24 -0400
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > =20
> > > > On Fri, Apr 12, 2024 at 11:43:22PM +0200, Ricardo Ribalda wrote: =
=20
> > > > > Hi
> > > > >
> > > > > I am using virtme to do some CI around linux-media.
> > > > >
> > > > > Everything works as expected, but when I enable KASAN, I am start=
ing
> > > > > to get a lot of timeouts when the Method _PRT is executed. Eg:
> > > > >
> > > > > [   56.335875] ACPI Error: Aborting method \_SB.PCI0._PRT due to
> > > > > previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
> > > > > [   56.529826] ACPI Error: Method execution failed \_SB.PCI0._PRT=
 due
> > > > > to previous error (AE_AML_LOOP_TIMEOUT) (20230628/uteval-68)
> > > > > [   56.532391] virtio-pci 0000:00:02.0: can't derive routing for =
PCI INT A
> > > > > [   56.532823] virtio-pci 0000:00:02.0: PCI INT A: no GSI
> > > > > [   86.877471] ACPI Error: Aborting method \_SB.PCI0._PRT due to
> > > > > previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
> > > > > [   87.073854] ACPI Error: Method execution failed \_SB.PCI0._PRT=
 due
> > > > > to previous error (AE_AML_LOOP_TIMEOUT) (20230628/uteval-68)
> > > > > [   87.075550] virtio-pci 0000:00:04.0: can't derive routing for =
PCI INT A
> > > > > [   87.075810] virtio-pci 0000:00:04.0: PCI INT A: no GSI
> > > > >
> > > > > 0000:00:04.0 and 0000:00:02.0 are virtio devices (console and 9p-=
filesystem)
> > > > >
> > > > > If I increase the timeout (ACPI_MAX_LOOP_TIMEOUT), then the Metho=
d is
> > > > > always executed, but it is very annoying that I have to wait more=
 than
> > > > > 5 minutes to start the vm.
> > > > >
> > > > > Despite not having kvm enabled, the machine is quite decent, so I
> > > > > would expect that it could run that method relatively fast.
> > > > >
> > > > > Do you have any hint of what I should be looking at? =20
> > >
> > > The way QEMU generates _PRT haven't been changed for ages,
> > > it's not likely to be a culprit.
> > >
> > > CCing Rafael who might have an idea why ACPI misbehaves. =20
> >
> > It looks like the method evaluation time increases with KASAN enabled
> > and it gets aborted due to exceeding the evaluation time limit.
> >
> > Thanks! =20
>=20
>=20
>=20

