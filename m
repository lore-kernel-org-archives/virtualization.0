Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C4913C8EE
	for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 12:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713356057; cv=none; b=GZ1b97W2X84CJYEPxfRhqn6/XM3vhlxHRtcvLv+uXWIiyxy9u4Mp8LZP3Feue5ogWWSZo2SzGIdGtnbG7s91Y1sZOvThmKctnRyi0h6+yjBDvqMvBCIXeYcnYpyBiK6lhg7VwITpa51BKKe1GCZbazMv3IKSXav1cRQczzPhcr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713356057; c=relaxed/simple;
	bh=YLQYx3yRR85mOCiFCb3A/+MmYdnq1yOyyRnoLs/DSiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AKj3RnPthG83ASVvoy6JepfUrIfbN4eBtd2q3dPzQNkUxEPtGBZkz5MWOEknEib9zxUx2/xDI3/la/eUGI3M2sxrrcAjDRN9n3xJQ3ipVcBFyM2DswABF5CFTiCwLEkFA58nh+PPHAHUwQfxrI/CuiiBwnxuBBr0sH1JKSWLjOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ssn+mnK0; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ssn+mnK0"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-78f05afc8d6so12248085a.3
        for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 05:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713356054; x=1713960854; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=boEo4oSy66gSiyGTYQVWrqV+iO92l6Ai9YOZF8Um5xI=;
        b=ssn+mnK02rhoEbN4UjbGZErSip+cmMu+Z1ArOv8MVeKxFN/BvsLHuCHn/1BbtEptRo
         pZkXOEkHNXKh4RVy4d0hqGkfPFcDs5MSCH6/0/MPExiyiz7VWP1cLF78/ohCYlqt/lfe
         0Oq+F7FsVpleSkEk6zAvFwoSjHFMRc2jIjOyriFCju6UBnouIg1XeWN2gZoOeOo1ghv/
         AY68RDTVW4v4VtRZimywynSbLg1O1Bxy9a4WrZh1nIYcJGIAdsmNRZW2k4HHf05XvXtb
         3vakZqVA94pIowGkbOYF3+lGzYxPVnKTMwzwZKLf50pwFqdNggYID/vaAqQIIY7hjjcW
         +2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713356054; x=1713960854;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=boEo4oSy66gSiyGTYQVWrqV+iO92l6Ai9YOZF8Um5xI=;
        b=wtOH/67AXW6NGe4WPtVXg4SY1uzmXur4fb0sHoYh4o1PxdiSZHfSduvouR1EdL4vJl
         No6ksoLBeV7azdN8LFuX4idlTAF6khEJMOtOBpFlmxtPt1GePoyeqZxqFjTW9eQEgPqp
         F18oNh7DVpY8DBU315IBwIs+ud80yulbCIZwHsh8Dl/LkJZT17fAZrkEaWN3pQ1duiqg
         Tby3HJrmVg4aLNBGvcooIdcyd9JwZoqqLuIHwj/wnpxE1uaFilXsC+4T+lcceBrxh8fm
         K2Yqm5NR64JTtOXe0v4j5izfp42LixbdWSHEe6wgFVZ8yuFKionVQ2V4tvMp31Q78y0m
         uPlw==
X-Forwarded-Encrypted: i=1; AJvYcCVQwZZ3CONR95pkSc4GQAGmlhVuu1gHQyh9QICHRsQQwYBczDqjvfqVAeS2GCPN1zzFLQhA0PyC92Rb44CO00pk6NjV9l+k3kGIIhWGTFE=
X-Gm-Message-State: AOJu0YxQcD4W3G2Io//dN/LbJCK9kH2/7z9od/6c4oeRuFrkf4J8Uaut
	aQJ747IVxQYViRsyPy+/lBL2sxQPmYCzHf4TiKV/G6lsm3YK4QTEQ6LKvbWGa3gif1HmMppwWgu
	jgX7HsRSdyAD2UEbszVqsFJIcQCAIjpoXossM
X-Google-Smtp-Source: AGHT+IEwncaQ5LyruhNDIKN2wXOAvnR9V8xbLDAAZRgSpA48+oMQ7FxPLXZYzhqAAciY4XIkOqP9Fliw8xK08y4XBus=
X-Received: by 2002:ad4:548a:0:b0:69b:457c:654a with SMTP id
 pv10-20020ad4548a000000b0069b457c654amr16361306qvb.45.1713356054179; Wed, 17
 Apr 2024 05:14:14 -0700 (PDT)
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
 <Zh5p7ILwQYEoUR8l@gpd>
In-Reply-To: <Zh5p7ILwQYEoUR8l@gpd>
From: Ricardo Ribalda <ribalda@google.com>
Date: Wed, 17 Apr 2024 14:13:57 +0200
Message-ID: <CANiDSCv5naibDcHxrOi1Z-6k6EeQYk3eUg6UTeGu2WXj0+aLnw@mail.gmail.com>
Subject: Re: ACPI timeouts when enabling KASAN
To: Andrea Righi <andrea.righi@canonical.com>
Cc: Igor Mammedov <imammedo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, stevensd@chromium.org
Content-Type: text/plain; charset="UTF-8"

Hi Igor, Hi Andrea


On Tue, 16 Apr 2024 at 14:07, Andrea Righi <andrea.righi@canonical.com> wrote:
>
> On Tue, Apr 16, 2024 at 01:36:40PM +0200, Ricardo Ribalda wrote:
> > Hi Igor
> >
> > On Tue, 16 Apr 2024 at 13:33, Igor Mammedov <imammedo@redhat.com> wrote:
> > >
> > > On Mon, 15 Apr 2024 16:18:22 +0200
> > > Ricardo Ribalda <ribalda@google.com> wrote:
> > >
> > > > Hi Igor, Hi Rafael
> > > >
> > > > Yes, it seems that it is just KASAN being extremely slow.
> > > > From a completely newbie here... Is there a reason why qemu generates
> > > > the table vs returning a precomputed one?
> > >
> > > it can be a pre-generated Package
> > > like we do with ARM (example: acpi_dsdt_add_pci_route_table)
> > >
> > > > This is the config file:
> > > > https://gitlab.freedesktop.org/linux-media/media-ci/-/blob/main/testdata/virtme/virtme.config?ref_type=heads
> > > >
> > > > And this is the qemu cli:
> > > >
> > > > /usr/bin/qemu-system-x86_64 -m 4G -fsdev
> > > > local,id=virtfs3,path=/,security_model=none,readonly=on,multidevs=remap
> > > > -device virtio-9p-pci,fsdev=virtfs3,mount_tag=/dev/root -device
> > > > i6300esb,id=watchdog0 -parallel none -net none -smp 2 -vga none
> > > > -display none -serial chardev:console -chardev
> > > > file,id=console,path=/proc/self/fd/2 -chardev
> > > > stdio,id=stdin,signal=on,mux=off -device virtio-serial-pci -device
> > > > virtserialport,name=virtme.stdin,chardev=stdin -chardev
> > > > file,id=stdout,path=/proc/self/fd/1 -device virtio-serial-pci -device
> > > > virtserialport,name=virtme.stdout,chardev=stdout -chardev
> > > > file,id=stderr,path=/proc/self/fd/2 -device virtio-serial-pci -device
> > > > virtserialport,name=virtme.stderr,chardev=stderr -chardev
> > > > file,id=dev_stdout,path=/proc/self/fd/1 -device virtio-serial-pci
> > > > -device virtserialport,name=virtme.dev_stdout,chardev=dev_stdout
> > > > -chardev file,id=dev_stderr,path=/proc/self/fd/2 -device
> > > > virtio-serial-pci -device
> > > > virtserialport,name=virtme.dev_stderr,chardev=dev_stderr -chardev
> > > > file,id=ret,path=/tmp/virtme_retefeobj4f -device virtio-serial-pci
> > > > -device virtserialport,name=virtme.ret,chardev=ret -no-reboot -kernel
> > > > ./arch/x86/boot/bzImage -append 'nr_open=1048576
> > > > virtme_link_mods=/builds/linux-media/media-staging/.virtme_mods/lib/modules/0.0.0
> > > > console=ttyS0 earlyprintk=serial,ttyS0,115200 panic=-1
> > > > virtme.exec=`c2ggL21lZGlhLWNpL3Rlc3RkYXRhL3ZpcnRtZS90ZXN0LnNoIC9tZWRpYS1jaS90aGlyZF9wYXJ0eS92NGwtdXRpbHMgLTMy`
> > > > virtme_root_user=1 rootfstype=9p
> > > > rootflags=version=9p2000.L,trans=virtio,access=any raid=noautodetect
> > > > ro init=/usr/lib/python3/dist-packages/virtme/guest/virtme-init'
> > >
> > > boots fine for me on old Xeon E5-2630v3.
> > > Perhaps issue is that your host is too slow,
> > > is there reason not to use KVM instead of TCG?
> >
> > I am using a e2 instance that does not support nested virtualization :(
> >
> > >
> > > Alternatively you can try using q35 machine type
> > > instead of default 'pc', it doesn't have _PRT in
> > > simple configuration like yours.
> > > But then running things that depend on time is not
> > > reliable under TCG, so you might hit timeout elsewhere.
> >
> > I will give it a try... but you are correct, if this is running this
> > slow I expect that nothing from my CI will work reliably.
>
> I'm really interested to see if q35 helps here. If that's the case maybe
> we should default to q35 in virtme-ng when KVM isn't available (even if
> on my box q35 is actually slower than the default pc, so in that case we
> may need to come up with some logic to pick the right machine type).
>

Adding
--qemu-opts -machine q35
to virtme-run did the trick for me. It boots much faster

Not sure if we should blindly default to that machine type or not. My
usecase might not be very common after all


Thanks!

> Thanks,
> -Andrea



-- 
Ricardo Ribalda
