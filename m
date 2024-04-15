Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC813D0D9
	for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 14:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713190722; cv=none; b=ZjyIXS1RkggcMIt0O1P74eaDYEGl/V5/UfGI9n9A/qdF+JDiBLRQ66bu/Mo8yeZisV6AHK8OvH21gXdtjTiiUr4VuRwyqJER+g6VcytzOganXZ8F3Mxwv+s6utvM7lAJ9NY1NrtINHDNJDj9NXykSd2z+nFx9QMPvpELVS0RkWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713190722; c=relaxed/simple;
	bh=aAXX4PziST+M8+lfz9r4dGwxs0b1HoLXxQVt4E44ceM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DQ47kj8UQ9lyOLzZ2tk0lCH7+LTCN4nbb2s7xPtA+adV0EKneJK2BQAFmkTqQi9U/lZbacLGlBKKlg28obxgVjmygo7++u6FO37ExNSb2p1kxojpqC05VDd9bUb+Vzi392PJaSyLPHP9QvAK/ThCpW7gApRaJoOZX4xZTelJRgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=171i3YUY; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="171i3YUY"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-78d743f3654so314537285a.0
        for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 07:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713190718; x=1713795518; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZcZDqhMhvNCBCZ2KSS9DRM9FHJw7fnbW2bM1ENmavs=;
        b=171i3YUYrhTtka7KPgy5oaTpqaOwJMIGq8CWaCpqX33YmyGeSJYrohYqiW2TkwGQbN
         OR/xvvVWcex2nHhOZJ2SB9hJBk2GWl+DhIZnUB/Ntm7N2LaeF5MhrPsWjSy8faZvtAif
         ToC0B59IwHCR1MntU+Y8ZOLWcpH6Bkm4DQpScMGwKPxe/NLFA/pcDhy1m/6c88QqjE1E
         z/55Mb+pYe9M7+8dVwWDgPj6J4f1FYtIGgXI4aC8HM4KKhwgdb93xJtf195MAMlJvEKz
         j2dNbxaExHjvqUVfjZXgi/X3HRNGHtI+eVNVHxZQZqICsfOlBPGwql83DZtlbBCKH70R
         wcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713190718; x=1713795518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZcZDqhMhvNCBCZ2KSS9DRM9FHJw7fnbW2bM1ENmavs=;
        b=chXVoSmH+8dt7lCgHfGvPGEez4wfFG9xrOAAGXhR42X2VRKk1GD5VgF7u7cE3+vjgk
         mb3ZDSZj6P3ogCifs+QLQHucSZgyuriC5hNAp01WG91X/Ud8BxVg3wFtKiKpxsH0uqN9
         DyWZ5OP7O+fgiazG7W5YlCVHly3sUfD6+ettuVlh5pxo97goDLJzVntm2oO5KFMS6dOL
         bEtjTgjvhPs5aXf+kqaYzXeZRihOPvADri2lkAMTchN2g4pO8dH2iRA1CQEK/j8fom/E
         9xCXCOJl/l90Z3wqRtRuypfcm8hRCIBfE2oc/TKxcCpbxILxYGq+Nugd3oN5EOotjl6b
         6IFA==
X-Forwarded-Encrypted: i=1; AJvYcCV8w2BedMKirsdEORlbIe5bBkuNTIn2lurrjMkndtgVlFY+O4Dtd9KUP2X6ln2ePPYGGyFnA4c55ExTDJ4X6mJKclXXWf+K47R2Edgpcso=
X-Gm-Message-State: AOJu0YxltpjU5VIXwUexBXvacyYz8tKsAqWXAOfwrqCAmnRihaP3lK/q
	6YLscmvHtgJXWLUKGnpASLK5u+Qva9EIxGgSfqrfsPV7HB2HaTlZJ63a+w+dvwlnhNg03hbZmjb
	5eZlNVTUBo/h/pQ9/rjj39Z4xkEDZbgNGbQnw
X-Google-Smtp-Source: AGHT+IGygygaHYRFPiOQvpjnwvf7Sj/h9DjcRq2z4h9J7oPSHpK01lp6p4iX8c7Xg/1lboFg81gRUJUdM4PxB+IP+bQ=
X-Received: by 2002:a0c:ed41:0:b0:69b:a25:327b with SMTP id
 v1-20020a0ced41000000b0069b0a25327bmr9572691qvq.37.1713190717865; Mon, 15 Apr
 2024 07:18:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CANiDSCtJKZDwSpy3RWW7FPQiJf+LqxrZJs=N7KrvCz0EFjh2wQ@mail.gmail.com>
 <20240414043707-mutt-send-email-mst@kernel.org> <20240415145153.21075173@imammedo.users.ipa.redhat.com>
 <CAJZ5v0j3BVUKDFE-_Tdykt42zCiDfYMpSYN54JUqdr2O8a__1w@mail.gmail.com>
In-Reply-To: <CAJZ5v0j3BVUKDFE-_Tdykt42zCiDfYMpSYN54JUqdr2O8a__1w@mail.gmail.com>
From: Ricardo Ribalda <ribalda@google.com>
Date: Mon, 15 Apr 2024 16:18:22 +0200
Message-ID: <CANiDSCuvDQWam0v1b3adA=j6w+dA263QruBonsA6TJBvO9XsWQ@mail.gmail.com>
Subject: Re: ACPI timeouts when enabling KASAN
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Andrea Righi <andrea.righi@canonical.com>, virtualization@lists.linux.dev, 
	stevensd@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Igor, Hi Rafael

Yes, it seems that it is just KASAN being extremely slow.
From a completely newbie here... Is there a reason why qemu generates
the table vs returning a precomputed one?

This is the config file:
https://gitlab.freedesktop.org/linux-media/media-ci/-/blob/main/testdata/vi=
rtme/virtme.config?ref_type=3Dheads

And this is the qemu cli:

/usr/bin/qemu-system-x86_64 -m 4G -fsdev
local,id=3Dvirtfs3,path=3D/,security_model=3Dnone,readonly=3Don,multidevs=
=3Dremap
-device virtio-9p-pci,fsdev=3Dvirtfs3,mount_tag=3D/dev/root -device
i6300esb,id=3Dwatchdog0 -parallel none -net none -smp 2 -vga none
-display none -serial chardev:console -chardev
file,id=3Dconsole,path=3D/proc/self/fd/2 -chardev
stdio,id=3Dstdin,signal=3Don,mux=3Doff -device virtio-serial-pci -device
virtserialport,name=3Dvirtme.stdin,chardev=3Dstdin -chardev
file,id=3Dstdout,path=3D/proc/self/fd/1 -device virtio-serial-pci -device
virtserialport,name=3Dvirtme.stdout,chardev=3Dstdout -chardev
file,id=3Dstderr,path=3D/proc/self/fd/2 -device virtio-serial-pci -device
virtserialport,name=3Dvirtme.stderr,chardev=3Dstderr -chardev
file,id=3Ddev_stdout,path=3D/proc/self/fd/1 -device virtio-serial-pci
-device virtserialport,name=3Dvirtme.dev_stdout,chardev=3Ddev_stdout
-chardev file,id=3Ddev_stderr,path=3D/proc/self/fd/2 -device
virtio-serial-pci -device
virtserialport,name=3Dvirtme.dev_stderr,chardev=3Ddev_stderr -chardev
file,id=3Dret,path=3D/tmp/virtme_retefeobj4f -device virtio-serial-pci
-device virtserialport,name=3Dvirtme.ret,chardev=3Dret -no-reboot -kernel
./arch/x86/boot/bzImage -append 'nr_open=3D1048576
virtme_link_mods=3D/builds/linux-media/media-staging/.virtme_mods/lib/modul=
es/0.0.0
console=3DttyS0 earlyprintk=3Dserial,ttyS0,115200 panic=3D-1
virtme.exec=3D`c2ggL21lZGlhLWNpL3Rlc3RkYXRhL3ZpcnRtZS90ZXN0LnNoIC9tZWRpYS1j=
aS90aGlyZF9wYXJ0eS92NGwtdXRpbHMgLTMy`
virtme_root_user=3D1 rootfstype=3D9p
rootflags=3Dversion=3D9p2000.L,trans=3Dvirtio,access=3Dany raid=3Dnoautodet=
ect
ro init=3D/usr/lib/python3/dist-packages/virtme/guest/virtme-init'

Regards!

On Mon, 15 Apr 2024 at 14:55, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Apr 15, 2024 at 2:52=E2=80=AFPM Igor Mammedov <imammedo@redhat.co=
m> wrote:
> >
> > On Sun, 14 Apr 2024 04:37:24 -0400
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >
> > > On Fri, Apr 12, 2024 at 11:43:22PM +0200, Ricardo Ribalda wrote:
> > > > Hi
> > > >
> > > > I am using virtme to do some CI around linux-media.
> > > >
> > > > Everything works as expected, but when I enable KASAN, I am startin=
g
> > > > to get a lot of timeouts when the Method _PRT is executed. Eg:
> > > >
> > > > [   56.335875] ACPI Error: Aborting method \_SB.PCI0._PRT due to
> > > > previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
> > > > [   56.529826] ACPI Error: Method execution failed \_SB.PCI0._PRT d=
ue
> > > > to previous error (AE_AML_LOOP_TIMEOUT) (20230628/uteval-68)
> > > > [   56.532391] virtio-pci 0000:00:02.0: can't derive routing for PC=
I INT A
> > > > [   56.532823] virtio-pci 0000:00:02.0: PCI INT A: no GSI
> > > > [   86.877471] ACPI Error: Aborting method \_SB.PCI0._PRT due to
> > > > previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
> > > > [   87.073854] ACPI Error: Method execution failed \_SB.PCI0._PRT d=
ue
> > > > to previous error (AE_AML_LOOP_TIMEOUT) (20230628/uteval-68)
> > > > [   87.075550] virtio-pci 0000:00:04.0: can't derive routing for PC=
I INT A
> > > > [   87.075810] virtio-pci 0000:00:04.0: PCI INT A: no GSI
> > > >
> > > > 0000:00:04.0 and 0000:00:02.0 are virtio devices (console and 9p-fi=
lesystem)
> > > >
> > > > If I increase the timeout (ACPI_MAX_LOOP_TIMEOUT), then the Method =
is
> > > > always executed, but it is very annoying that I have to wait more t=
han
> > > > 5 minutes to start the vm.
> > > >
> > > > Despite not having kvm enabled, the machine is quite decent, so I
> > > > would expect that it could run that method relatively fast.
> > > >
> > > > Do you have any hint of what I should be looking at?
> >
> > The way QEMU generates _PRT haven't been changed for ages,
> > it's not likely to be a culprit.
> >
> > CCing Rafael who might have an idea why ACPI misbehaves.
>
> It looks like the method evaluation time increases with KASAN enabled
> and it gets aborted due to exceeding the evaluation time limit.
>
> Thanks!



--=20
Ricardo Ribalda
