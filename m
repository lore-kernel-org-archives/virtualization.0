Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB501494B8
	for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713370350; cv=none; b=DPHX3MFwtRE1iU/36O/m6sTGlPwys08E3ntAXAYhsUeneycWSVadzw2vp3s6TA6NTe5zw6xJLYyhrK+gOAjKDl0DEIlbl+CRYxHHPqj1jI2oJDrA9JyWsV485yU89MJ0+PxezCRlsWcUPIni3q1wR8SfHdDJJI2qDQ/uxKy2Wbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713370350; c=relaxed/simple;
	bh=m/XrinLLJynKDZigcRnnj0vr5t2jHFnEFkGR7PcfmNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qutPOMYK07c0mYM0MXyXg4TOoA/U2xmQewurpopkAgHVXedgj5O8RNz3wAJW2+AH1LeSl1sW1vSYxYChG105SI85IwccngoYrtQl+8EVMTw4c16WlGfe64Y+R+JfPp2Nprijxg4ErYqeo0WvSk9IUEaSh8d7T6YwqFbN8chFbww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tn82K1hM; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tn82K1hM"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-69629b4ae2bso49598826d6.3
        for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 09:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713370348; x=1713975148; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=40YDLiypuyfPbuwm+CvjcOrSpA+0PYTrsolR8zyV4iI=;
        b=Tn82K1hMQ4FTwXLs4/TPaj+bRE1qtbDdzpEawgRdDQjklHi7V3u1rMZvTWH5ArmYO3
         d7fmBAJgQNI25n+76My0hhSeHlU1LKrXuJ+K5gYguT4lwBGE38VM50GUl4nWQV0p/SuG
         gb6AqtMEsPKRDMTRIh65n+fLpjfIPG4He/uSVAk83Kap+1m94O4lWKowHIE6Eq4NkV/z
         Z51mUtfalv6oSMvsym4e3c5GZKuV0JlkfrE6F82sN6FYzdy/J3CRaPYNyRd1LLlVRseW
         l4GdRmCTvGsGJuF2kvgKEn+QoBUAv4jAOWnQy1WxK3AoeHZuj1OXdLc9D58arclyEIId
         novQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713370348; x=1713975148;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=40YDLiypuyfPbuwm+CvjcOrSpA+0PYTrsolR8zyV4iI=;
        b=Fd96rrYVKkkVydrtRf1Pn2vKumghdAWjx+D5Ebqu7p9MRvJlikOT17/ViJqF4MtZZV
         8KZBt3yuzCO+TsvhWMaa/wV5xodgPY2REgCiBiDvEYRInDJh65ITvXaJNwCxYTWkQ/4G
         B7zirB54fLCSxXOiBXDR2kUgDm5QFYOoJgRbmD7t0cH3Z/1RB/n3mNPDaNL4NZzXeRsJ
         +Yf0HdEPGtffRR0xpuC/xciskzW2MzAdM4bwZnjNyV43OcOEKc2GfDwLIce3k3dgqepv
         q7klIm3QP2dQ88CN9HLq61gIABhluYKvNY/LGfbs5TLrk7t0KRBpAl0cfHDOAaD31wdf
         WDPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUE+0i5ILbgWzjIyu7yD379jK6yIEpOJ+9pbsyf02nsHQe1z79FKvvymS907PKgiYHWgInf6Jw0RY+8tdFQw/6JR7j1H7E3B/ewqRcr/Q=
X-Gm-Message-State: AOJu0Yx+Lgi2M9GmhO+hyWS9VcgtrNQG1OSd952Dx/YnHzEwBLMaQLNz
	CbMF/pxOvFVs52xsasCF7w6rEpJJ31lVbYKUGziIxzJ4m5YgV1MPbc0l4Xe+hnrTF4QVXGrEQ0X
	NFATwyhbjUQQJ8tZB7uLY/zjF5OqnzT1b6YwW
X-Google-Smtp-Source: AGHT+IE+Y1pEaef9LsZm+FWg6JtTc0EbPbLV4yFQlaeAQgcy+gCuseTJOg+RB5MvpC7HDPN5VLD12+AjedBbg57zRck=
X-Received: by 2002:a05:6214:3a8b:b0:69b:1a1c:950b with SMTP id
 nz11-20020a0562143a8b00b0069b1a1c950bmr23908175qvb.48.1713370347937; Wed, 17
 Apr 2024 09:12:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CANiDSCtJKZDwSpy3RWW7FPQiJf+LqxrZJs=N7KrvCz0EFjh2wQ@mail.gmail.com>
 <20240414043707-mutt-send-email-mst@kernel.org> <20240415145153.21075173@imammedo.users.ipa.redhat.com>
 <CAJZ5v0j3BVUKDFE-_Tdykt42zCiDfYMpSYN54JUqdr2O8a__1w@mail.gmail.com>
 <CANiDSCuvDQWam0v1b3adA=j6w+dA263QruBonsA6TJBvO9XsWQ@mail.gmail.com>
 <20240416133309.6d09ac3b@imammedo.users.ipa.redhat.com> <CANiDSCv=E4j0C3R_pCYMxqxe8Xep6LKQGAqJ3PC0x1kFAMq5mg@mail.gmail.com>
 <Zh5p7ILwQYEoUR8l@gpd> <20240417145544.38d7b482@imammedo.users.ipa.redhat.com>
 <Zh_e_t7TBUdYdtyc@gpd>
In-Reply-To: <Zh_e_t7TBUdYdtyc@gpd>
From: Ricardo Ribalda <ribalda@google.com>
Date: Wed, 17 Apr 2024 18:12:10 +0200
Message-ID: <CANiDSCvjf1eQmYgoOOfMqPkXcDG2pocXAXGxqwg3Cx4Mba99DQ@mail.gmail.com>
Subject: Re: ACPI timeouts when enabling KASAN
To: Andrea Righi <andrea.righi@canonical.com>
Cc: Igor Mammedov <imammedo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, stevensd@chromium.org
Content-Type: text/plain; charset="UTF-8"

Hi Andrea

On Wed, 17 Apr 2024 at 16:38, Andrea Righi <andrea.righi@canonical.com> wrote:
>
> On Wed, Apr 17, 2024 at 02:55:44PM +0200, Igor Mammedov wrote:
> > On Tue, 16 Apr 2024 14:07:08 +0200
> > Andrea Righi <andrea.righi@canonical.com> wrote:
> >
> > > On Tue, Apr 16, 2024 at 01:36:40PM +0200, Ricardo Ribalda wrote:
> > > > Hi Igor
> > > >
> > > > On Tue, 16 Apr 2024 at 13:33, Igor Mammedov <imammedo@redhat.com> wrote:
> > > > >
> > > > > On Mon, 15 Apr 2024 16:18:22 +0200
> > > > > Ricardo Ribalda <ribalda@google.com> wrote:
> > > > >
> > > > > > Hi Igor, Hi Rafael
> > > > > >
> > > > > > Yes, it seems that it is just KASAN being extremely slow.
> > > > > > From a completely newbie here... Is there a reason why qemu generates
> > > > > > the table vs returning a precomputed one?
> > > > >
> > > > > it can be a pre-generated Package
> > > > > like we do with ARM (example: acpi_dsdt_add_pci_route_table)
> > > > >
> > > > > > This is the config file:
> > > > > > https://gitlab.freedesktop.org/linux-media/media-ci/-/blob/main/testdata/virtme/virtme.config?ref_type=heads
> > > > > >
> > > > > > And this is the qemu cli:
> > > > > >
> > > > > > /usr/bin/qemu-system-x86_64 -m 4G -fsdev
> > > > > > local,id=virtfs3,path=/,security_model=none,readonly=on,multidevs=remap
> > > > > > -device virtio-9p-pci,fsdev=virtfs3,mount_tag=/dev/root -device
> > > > > > i6300esb,id=watchdog0 -parallel none -net none -smp 2 -vga none
> > > > > > -display none -serial chardev:console -chardev
> > > > > > file,id=console,path=/proc/self/fd/2 -chardev
> > > > > > stdio,id=stdin,signal=on,mux=off -device virtio-serial-pci -device
> > > > > > virtserialport,name=virtme.stdin,chardev=stdin -chardev
> > > > > > file,id=stdout,path=/proc/self/fd/1 -device virtio-serial-pci -device
> > > > > > virtserialport,name=virtme.stdout,chardev=stdout -chardev
> > > > > > file,id=stderr,path=/proc/self/fd/2 -device virtio-serial-pci -device
> > > > > > virtserialport,name=virtme.stderr,chardev=stderr -chardev
> > > > > > file,id=dev_stdout,path=/proc/self/fd/1 -device virtio-serial-pci
> > > > > > -device virtserialport,name=virtme.dev_stdout,chardev=dev_stdout
> > > > > > -chardev file,id=dev_stderr,path=/proc/self/fd/2 -device
> > > > > > virtio-serial-pci -device
> > > > > > virtserialport,name=virtme.dev_stderr,chardev=dev_stderr -chardev
> > > > > > file,id=ret,path=/tmp/virtme_retefeobj4f -device virtio-serial-pci
> > > > > > -device virtserialport,name=virtme.ret,chardev=ret -no-reboot -kernel
> > > > > > ./arch/x86/boot/bzImage -append 'nr_open=1048576
> > > > > > virtme_link_mods=/builds/linux-media/media-staging/.virtme_mods/lib/modules/0.0.0
> > > > > > console=ttyS0 earlyprintk=serial,ttyS0,115200 panic=-1
> > > > > > virtme.exec=`c2ggL21lZGlhLWNpL3Rlc3RkYXRhL3ZpcnRtZS90ZXN0LnNoIC9tZWRpYS1jaS90aGlyZF9wYXJ0eS92NGwtdXRpbHMgLTMy`
> > > > > > virtme_root_user=1 rootfstype=9p
> > > > > > rootflags=version=9p2000.L,trans=virtio,access=any raid=noautodetect
> > > > > > ro init=/usr/lib/python3/dist-packages/virtme/guest/virtme-init'
> > > > >
> > > > > boots fine for me on old Xeon E5-2630v3.
> > > > > Perhaps issue is that your host is too slow,
> > > > > is there reason not to use KVM instead of TCG?
> > > >
> > > > I am using a e2 instance that does not support nested virtualization :(
> > > >
> > > > >
> > > > > Alternatively you can try using q35 machine type
> > > > > instead of default 'pc', it doesn't have _PRT in
> > > > > simple configuration like yours.
> > > > > But then running things that depend on time is not
> > > > > reliable under TCG, so you might hit timeout elsewhere.
> > > >
> > > > I will give it a try... but you are correct, if this is running this
> > > > slow I expect that nothing from my CI will work reliably.
> > >
> > > I'm really interested to see if q35 helps here. If that's the case maybe
> > > we should default to q35 in virtme-ng when KVM isn't available (even if
> > > on my box q35 is actually slower than the default pc, so in that case we
> > > may need to come up with some logic to pick the right machine type).
> >
> > it might be interesting to find out why q35 is slower (it shouldn't be)
>
> Nevermind, I was comparing native kvm vs q35, of course it was slower...
>
> > With above config one can put all devices on hostbridge as integrated endpoints
> > which roughly will be the same as PCI topo in 'pc' machine)
> >
> > another thing that might help is adding '-cpu max' instead of default
> > qemu64 cpu model.
>
> Doing the proper comparison (disabling kvm), adding '-cpu max' to the
> equation and measuring the boot time of multiple virtme-ng runs, gives
> me the following result (average of 10 runs):
>
>                      machine
>               +----------------
>               | default     q35
>      ---------+----------------
> cpu  |default |     13s     11s
>      |max     |     15s     14s
>
> I've tried a couple of kernel configs and I get similar results.
>
> In the scope of virtme-ng (optimize boot time) I'd say that it'd makes
> sense to use '-machine q35' and default cpu settings when kvm is
> unavailable.
>
> Ricardo, do you see similar results?

I see even more difference between q35 and default.
These are my kernel options:
https://gitlab.freedesktop.org/linux-media/media-ci/-/blob/main/test-virtme.sh?ref_type=heads#L27



I see an issue to automatically set the machine and it is that  we
would not be able to override it with something like:

virtme-run .......... --qemu-opts -machine q35



If this patch lands in qemu we might be able to ignore all these:
https://lore.kernel.org/qemu-devel/20240417135608.2613586-1-ribalda@chromium.org/T/#u

Regards!

>
> Thanks,
> -Andrea



-- 
Ricardo Ribalda
