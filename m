Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB1D35F0C
	for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 11:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713267420; cv=none; b=noMwKiDW5R3QuE5bxXufxthNHesRHz1lIi+aMJGIKogOX5mC3NUo2rs/dvH04fp1N0BG2BRPu1UNuEob77p7OwE2u3rDrjTOVFUunNiqAJ++5QDGDp+5y5/zL7fJsGKZS7/jHLe8dSR4tZ4Z5IvB9JZs+I0zByy6SZ7+GlqboVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713267420; c=relaxed/simple;
	bh=hZr1QnTjfkcyAgglqXMmT1/LqgceAWAM0p91Grd1T5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VHO61M7uKY04ar9cR/YB59pKzBWoRpoqJ57KWg2i1dj53KBCOlP2IL/MkGIlwrgfdnCDN8DSKkMrwdAUCn4VzQ2FuRzm27Ah+yqCR6XiRmT9J7MMV2oVgS8bt9mknH9SYFOJtMaIe+DLNOG24vD73mOYqGzCZ3JWy+0FUKe+qm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0mqZNbdT; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0mqZNbdT"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-343d7ff2350so3089408f8f.0
        for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 04:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713267417; x=1713872217; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=srxIalN2Qf78tohNVwtx5kHylBrbbT+RcMY6h6SubJU=;
        b=0mqZNbdTRPt2Lmw5/CwuvylY1ym0fqlCDyz45fKjv9Mr+dhv3ZQDtYXuuEXqLzT8HQ
         1vp8OYPr77E4A0fbPGN4GIxpCOzfJr1odpxoVYanhbuA0g83OagYCpoT7vcXP3GUcv8C
         2U2WfNB/Bo72qvAUACVcfR67SU8A8Cz31TzeQZfTmV1lNMWvzDxYrHbpNs2EUDVH2Gau
         INdM+1oCRhVMnFmHHXtUGuEp0GkgVfvoCiv4MvlUv0klRV9P21myRVMeFxeYRw8ddsk9
         q3BBtm/5iATFKxAbWRzvMMcns2DDEc54eoRujOp9g1n8YgvecG1eoLUi024pNXKfma4Y
         0Lhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713267417; x=1713872217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=srxIalN2Qf78tohNVwtx5kHylBrbbT+RcMY6h6SubJU=;
        b=VJwBrJSVvE+pLmGVLQYQCYATYQ7/hGn6RT7Hv1WiqTNHCGnIlICRbq+mGiwtum3bb2
         HrVMKOY/1f3dhGx4VH3ZxNE12H9lGNyfjACYZhRUKeXqlXWdmsXfgDS0/j7oB2TfznpC
         AUPZS/AHDNj960vfRWSl7gTq4Wuy1iOVAWX3cgbvpPaMtN9HKhTHMWOVi5uR2w7V6uUB
         VubUrC2EmwS1jV3gUr9y2mWCHNW3V5UkkE9Kjdw3tKEjCIkwSEL22fR1wy6/q/E6Pjrh
         YEZjT0ZTxyNitZCCVEkSsBBB0DJI2bO4N/ZkI3NkT1gUbf+n7HaSUiWmfXi0Pi+ua+G4
         GXsg==
X-Forwarded-Encrypted: i=1; AJvYcCWyeX7GjOPOvACDPv9aAGU+tctIG2Rbb7mUalRfEjGb1EZArdwGLLIlZ+4Rl5x/V5Cnzv0Wq+haNY50sOv3NCFBifMTtKAlvSDJsa3H6V4=
X-Gm-Message-State: AOJu0YwoV8oRW0+fNbdX6VtOzzLeqOz0H0b0Kt+JNn4Xw1yGWyDcL9Yq
	6qLi8ktg0bc9T1lgmC4hIUgXp4G30dW9fKZgJjXV/ruKlSD7EIVT1XIRX6B16+eGbjGuLBjLYDv
	z94GWvv7oydhtGnDqYoPts7fj0XxPRgkFOW1+
X-Google-Smtp-Source: AGHT+IGYEz//P6s6IDw307RqN/c5hNB83Su9ri/mdqBbEizh0GFZGaJKJQt88YUYcPcDGCQBG7FHNguxSEwzaZTASsg=
X-Received: by 2002:a05:6000:1842:b0:343:eb6c:ae80 with SMTP id
 c2-20020a056000184200b00343eb6cae80mr9984428wri.28.1713267417421; Tue, 16 Apr
 2024 04:36:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CANiDSCtJKZDwSpy3RWW7FPQiJf+LqxrZJs=N7KrvCz0EFjh2wQ@mail.gmail.com>
 <20240414043707-mutt-send-email-mst@kernel.org> <20240415145153.21075173@imammedo.users.ipa.redhat.com>
 <CAJZ5v0j3BVUKDFE-_Tdykt42zCiDfYMpSYN54JUqdr2O8a__1w@mail.gmail.com>
 <CANiDSCuvDQWam0v1b3adA=j6w+dA263QruBonsA6TJBvO9XsWQ@mail.gmail.com> <20240416133309.6d09ac3b@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240416133309.6d09ac3b@imammedo.users.ipa.redhat.com>
From: Ricardo Ribalda <ribalda@google.com>
Date: Tue, 16 Apr 2024 13:36:40 +0200
Message-ID: <CANiDSCv=E4j0C3R_pCYMxqxe8Xep6LKQGAqJ3PC0x1kFAMq5mg@mail.gmail.com>
Subject: Re: ACPI timeouts when enabling KASAN
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Andrea Righi <andrea.righi@canonical.com>, virtualization@lists.linux.dev, 
	stevensd@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Igor

On Tue, 16 Apr 2024 at 13:33, Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Mon, 15 Apr 2024 16:18:22 +0200
> Ricardo Ribalda <ribalda@google.com> wrote:
>
> > Hi Igor, Hi Rafael
> >
> > Yes, it seems that it is just KASAN being extremely slow.
> > From a completely newbie here... Is there a reason why qemu generates
> > the table vs returning a precomputed one?
>
> it can be a pre-generated Package
> like we do with ARM (example: acpi_dsdt_add_pci_route_table)
>
> > This is the config file:
> > https://gitlab.freedesktop.org/linux-media/media-ci/-/blob/main/testdat=
a/virtme/virtme.config?ref_type=3Dheads
> >
> > And this is the qemu cli:
> >
> > /usr/bin/qemu-system-x86_64 -m 4G -fsdev
> > local,id=3Dvirtfs3,path=3D/,security_model=3Dnone,readonly=3Don,multide=
vs=3Dremap
> > -device virtio-9p-pci,fsdev=3Dvirtfs3,mount_tag=3D/dev/root -device
> > i6300esb,id=3Dwatchdog0 -parallel none -net none -smp 2 -vga none
> > -display none -serial chardev:console -chardev
> > file,id=3Dconsole,path=3D/proc/self/fd/2 -chardev
> > stdio,id=3Dstdin,signal=3Don,mux=3Doff -device virtio-serial-pci -devic=
e
> > virtserialport,name=3Dvirtme.stdin,chardev=3Dstdin -chardev
> > file,id=3Dstdout,path=3D/proc/self/fd/1 -device virtio-serial-pci -devi=
ce
> > virtserialport,name=3Dvirtme.stdout,chardev=3Dstdout -chardev
> > file,id=3Dstderr,path=3D/proc/self/fd/2 -device virtio-serial-pci -devi=
ce
> > virtserialport,name=3Dvirtme.stderr,chardev=3Dstderr -chardev
> > file,id=3Ddev_stdout,path=3D/proc/self/fd/1 -device virtio-serial-pci
> > -device virtserialport,name=3Dvirtme.dev_stdout,chardev=3Ddev_stdout
> > -chardev file,id=3Ddev_stderr,path=3D/proc/self/fd/2 -device
> > virtio-serial-pci -device
> > virtserialport,name=3Dvirtme.dev_stderr,chardev=3Ddev_stderr -chardev
> > file,id=3Dret,path=3D/tmp/virtme_retefeobj4f -device virtio-serial-pci
> > -device virtserialport,name=3Dvirtme.ret,chardev=3Dret -no-reboot -kern=
el
> > ./arch/x86/boot/bzImage -append 'nr_open=3D1048576
> > virtme_link_mods=3D/builds/linux-media/media-staging/.virtme_mods/lib/m=
odules/0.0.0
> > console=3DttyS0 earlyprintk=3Dserial,ttyS0,115200 panic=3D-1
> > virtme.exec=3D`c2ggL21lZGlhLWNpL3Rlc3RkYXRhL3ZpcnRtZS90ZXN0LnNoIC9tZWRp=
YS1jaS90aGlyZF9wYXJ0eS92NGwtdXRpbHMgLTMy`
> > virtme_root_user=3D1 rootfstype=3D9p
> > rootflags=3Dversion=3D9p2000.L,trans=3Dvirtio,access=3Dany raid=3Dnoaut=
odetect
> > ro init=3D/usr/lib/python3/dist-packages/virtme/guest/virtme-init'
>
> boots fine for me on old Xeon E5-2630v3.
> Perhaps issue is that your host is too slow,
> is there reason not to use KVM instead of TCG?

I am using a e2 instance that does not support nested virtualization :(

>
> Alternatively you can try using q35 machine type
> instead of default 'pc', it doesn't have _PRT in
> simple configuration like yours.
> But then running things that depend on time is not
> reliable under TCG, so you might hit timeout elsewhere.

I will give it a try... but you are correct, if this is running this
slow I expect that nothing from my CI will work reliably.

Thanks!


>
> >
> > Regards!
> >
> > On Mon, 15 Apr 2024 at 14:55, Rafael J. Wysocki <rafael@kernel.org> wro=
te:
> > >
> > > On Mon, Apr 15, 2024 at 2:52=E2=80=AFPM Igor Mammedov <imammedo@redha=
t.com> wrote:
> > > >
> > > > On Sun, 14 Apr 2024 04:37:24 -0400
> > > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > >
> > > > > On Fri, Apr 12, 2024 at 11:43:22PM +0200, Ricardo Ribalda wrote:
> > > > > > Hi
> > > > > >
> > > > > > I am using virtme to do some CI around linux-media.
> > > > > >
> > > > > > Everything works as expected, but when I enable KASAN, I am sta=
rting
> > > > > > to get a lot of timeouts when the Method _PRT is executed. Eg:
> > > > > >
> > > > > > [   56.335875] ACPI Error: Aborting method \_SB.PCI0._PRT due t=
o
> > > > > > previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
> > > > > > [   56.529826] ACPI Error: Method execution failed \_SB.PCI0._P=
RT due
> > > > > > to previous error (AE_AML_LOOP_TIMEOUT) (20230628/uteval-68)
> > > > > > [   56.532391] virtio-pci 0000:00:02.0: can't derive routing fo=
r PCI INT A
> > > > > > [   56.532823] virtio-pci 0000:00:02.0: PCI INT A: no GSI
> > > > > > [   86.877471] ACPI Error: Aborting method \_SB.PCI0._PRT due t=
o
> > > > > > previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
> > > > > > [   87.073854] ACPI Error: Method execution failed \_SB.PCI0._P=
RT due
> > > > > > to previous error (AE_AML_LOOP_TIMEOUT) (20230628/uteval-68)
> > > > > > [   87.075550] virtio-pci 0000:00:04.0: can't derive routing fo=
r PCI INT A
> > > > > > [   87.075810] virtio-pci 0000:00:04.0: PCI INT A: no GSI
> > > > > >
> > > > > > 0000:00:04.0 and 0000:00:02.0 are virtio devices (console and 9=
p-filesystem)
> > > > > >
> > > > > > If I increase the timeout (ACPI_MAX_LOOP_TIMEOUT), then the Met=
hod is
> > > > > > always executed, but it is very annoying that I have to wait mo=
re than
> > > > > > 5 minutes to start the vm.
> > > > > >
> > > > > > Despite not having kvm enabled, the machine is quite decent, so=
 I
> > > > > > would expect that it could run that method relatively fast.
> > > > > >
> > > > > > Do you have any hint of what I should be looking at?
> > > >
> > > > The way QEMU generates _PRT haven't been changed for ages,
> > > > it's not likely to be a culprit.
> > > >
> > > > CCing Rafael who might have an idea why ACPI misbehaves.
> > >
> > > It looks like the method evaluation time increases with KASAN enabled
> > > and it gets aborted due to exceeding the evaluation time limit.
> > >
> > > Thanks!
> >
> >
> >
>


--=20
Ricardo Ribalda
