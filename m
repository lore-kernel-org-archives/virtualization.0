Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0228313D24A
	for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 14:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364747; cv=none; b=K1z+tcEUjuecWo5VzqcgEk/JVT7JKT4D71OQLgWZvvsjGW5SPvnJFfPgt7GxxHPt0lCy7Ab57BLRqGKJPKpGWrScLa32LqF/IpG+6FZTcaG7S2iP/In6tTGyvZMzL61UzLqerkNWF+OWQC6U7DLbtl6ePQ3IMyCCcCRvml0fJdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364747; c=relaxed/simple;
	bh=U9kFTwzlDeXzOVTub0F14Ew2Msp7hUWhoO0rFREQkCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksvEektBODJPvsq2/0EZwvDJUO40Eclphf2Mys9/HwkMMFBHnEzxFfusSkl16Fv3ny3TBL+8PKMXOKLlkYVBc/orOg6Cm8ZjPGk2PxR/2o/QW6j0muPoAZJ/v7VSwgC+JL9ioRtOfPBmLoK4dKLEpFW2JLv0wySKxr+CyYJFvTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=NEBKztpv; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="NEBKztpv"
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 100FC3FB69
	for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 14:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713364737;
	bh=szbpLVAbob6xbpNyi5eEkvr50T6w3dagKLU7eG/YjDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=NEBKztpvj6iZ5ssBWZIrtQ0tRAW6ulkDvg4dXrlCURrQddb8QgvBJ3n6AhusLQS8m
	 nC9ZfpCduVj2xdZ+eKmFE0F8q0SrSsI8ruLCzj5gBtqvEEvsLR3tvEowAEfiUOU9jR
	 kEyhU2Uap/h7ifIbE7gLCTa8ayMG4WIlHk7ZWppELfMXNi8gdyR64RuM8NvHYKYGXm
	 yOVQSBcaTmTcA3qd8sW5MuAe/wibV4HhfKdZ/05FaK7ZIY762Cpm361ZEXC+0kveQm
	 BqcXwqYoty1d22jstp7SUI/9vVwHt1FWKmtXebFiKRFk6kMyCUyqU1ZQCAY6mr8gxW
	 ZfxuQvcCmmUMA==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a467a6d4e3eso246985166b.3
        for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 07:38:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713364736; x=1713969536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szbpLVAbob6xbpNyi5eEkvr50T6w3dagKLU7eG/YjDI=;
        b=WdEvlnG5gkGQBM2ti2H8CXkD28lhMatmVvtv4wI6rAShsE622Xp8Y1qwlnWSPQMmTZ
         HM0y0foXQSuPxQ+IrJ4DomuZnNUjhgzcCsIKGLJMzHRsZmi1dau5+/EFhMdLEwu8ypO4
         7ClLWZnHhtnCzhR8J/hDWUkF7wF9YUdlJTJtY2jhrmWI6MUN6GLhkaug0UnvHvRlWU9i
         Zo0r7VHerkyYKZsqu4PQh4JIDSIYe0qm/QReIQHeoCwfD46aRHHEhubZL+2QZGICVEG3
         FVTdCi2B01Io8xDoWKKk0cxQqJkhF2XTsfhW2RGj9qTLhH+fOfpM1/eLSg3/qLjEV/nB
         rHoA==
X-Forwarded-Encrypted: i=1; AJvYcCVwvXFFCFqk/3+8FqN9tciFV6QKnllyowXSDWYqOOsGPUU3GRYzoyxnxZlVdNFan4QqbFs3h8vBniuFCWIVbXCU06/u8WHLC7MjvvCbg9k=
X-Gm-Message-State: AOJu0Yz9oNtRyemsamyGe963Rd7cn9mx3NZQJO+9Nwkrz3vYWOcUCyY6
	1llqwgdGoPv1Px/ztCH5VCGxQFklIwJyINXYSpUsazfvZONkCeDf3P2dSS5QXJ0pnW96wQkPN6C
	Qo0/xrj0rI3s6IeagVqkMefEiZMZfs9V2crpd4MtYUman+ukcCYXMXHXe+F/BWUtV8Lp4jdujd+
	i8IPGA
X-Received: by 2002:a17:906:694d:b0:a55:2ac2:c7d with SMTP id c13-20020a170906694d00b00a552ac20c7dmr4528059ejs.8.1713364736069;
        Wed, 17 Apr 2024 07:38:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPn3kyyrYzCA6KZPJ4EdvJMvv81sKmU2lGOwC3E/+UJk0OdfKAu06g1iOhidjlbESOaiwNPA==
X-Received: by 2002:a17:906:694d:b0:a55:2ac2:c7d with SMTP id c13-20020a170906694d00b00a552ac20c7dmr4528038ejs.8.1713364735340;
        Wed, 17 Apr 2024 07:38:55 -0700 (PDT)
Received: from localhost (host-82-49-69-7.retail.telecomitalia.it. [82.49.69.7])
        by smtp.gmail.com with ESMTPSA id hd11-20020a170907968b00b00a55358244ffsm2801197ejc.204.2024.04.17.07.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 07:38:54 -0700 (PDT)
Date: Wed, 17 Apr 2024 16:38:54 +0200
From: Andrea Righi <andrea.righi@canonical.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Ricardo Ribalda <ribalda@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev, stevensd@chromium.org
Subject: Re: ACPI timeouts when enabling KASAN
Message-ID: <Zh_e_t7TBUdYdtyc@gpd>
References: <CANiDSCtJKZDwSpy3RWW7FPQiJf+LqxrZJs=N7KrvCz0EFjh2wQ@mail.gmail.com>
 <20240414043707-mutt-send-email-mst@kernel.org>
 <20240415145153.21075173@imammedo.users.ipa.redhat.com>
 <CAJZ5v0j3BVUKDFE-_Tdykt42zCiDfYMpSYN54JUqdr2O8a__1w@mail.gmail.com>
 <CANiDSCuvDQWam0v1b3adA=j6w+dA263QruBonsA6TJBvO9XsWQ@mail.gmail.com>
 <20240416133309.6d09ac3b@imammedo.users.ipa.redhat.com>
 <CANiDSCv=E4j0C3R_pCYMxqxe8Xep6LKQGAqJ3PC0x1kFAMq5mg@mail.gmail.com>
 <Zh5p7ILwQYEoUR8l@gpd>
 <20240417145544.38d7b482@imammedo.users.ipa.redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417145544.38d7b482@imammedo.users.ipa.redhat.com>

On Wed, Apr 17, 2024 at 02:55:44PM +0200, Igor Mammedov wrote:
> On Tue, 16 Apr 2024 14:07:08 +0200
> Andrea Righi <andrea.righi@canonical.com> wrote:
> 
> > On Tue, Apr 16, 2024 at 01:36:40PM +0200, Ricardo Ribalda wrote:
> > > Hi Igor
> > > 
> > > On Tue, 16 Apr 2024 at 13:33, Igor Mammedov <imammedo@redhat.com> wrote:  
> > > >
> > > > On Mon, 15 Apr 2024 16:18:22 +0200
> > > > Ricardo Ribalda <ribalda@google.com> wrote:
> > > >  
> > > > > Hi Igor, Hi Rafael
> > > > >
> > > > > Yes, it seems that it is just KASAN being extremely slow.
> > > > > From a completely newbie here... Is there a reason why qemu generates
> > > > > the table vs returning a precomputed one?  
> > > >
> > > > it can be a pre-generated Package
> > > > like we do with ARM (example: acpi_dsdt_add_pci_route_table)
> > > >  
> > > > > This is the config file:
> > > > > https://gitlab.freedesktop.org/linux-media/media-ci/-/blob/main/testdata/virtme/virtme.config?ref_type=heads
> > > > >
> > > > > And this is the qemu cli:
> > > > >
> > > > > /usr/bin/qemu-system-x86_64 -m 4G -fsdev
> > > > > local,id=virtfs3,path=/,security_model=none,readonly=on,multidevs=remap
> > > > > -device virtio-9p-pci,fsdev=virtfs3,mount_tag=/dev/root -device
> > > > > i6300esb,id=watchdog0 -parallel none -net none -smp 2 -vga none
> > > > > -display none -serial chardev:console -chardev
> > > > > file,id=console,path=/proc/self/fd/2 -chardev
> > > > > stdio,id=stdin,signal=on,mux=off -device virtio-serial-pci -device
> > > > > virtserialport,name=virtme.stdin,chardev=stdin -chardev
> > > > > file,id=stdout,path=/proc/self/fd/1 -device virtio-serial-pci -device
> > > > > virtserialport,name=virtme.stdout,chardev=stdout -chardev
> > > > > file,id=stderr,path=/proc/self/fd/2 -device virtio-serial-pci -device
> > > > > virtserialport,name=virtme.stderr,chardev=stderr -chardev
> > > > > file,id=dev_stdout,path=/proc/self/fd/1 -device virtio-serial-pci
> > > > > -device virtserialport,name=virtme.dev_stdout,chardev=dev_stdout
> > > > > -chardev file,id=dev_stderr,path=/proc/self/fd/2 -device
> > > > > virtio-serial-pci -device
> > > > > virtserialport,name=virtme.dev_stderr,chardev=dev_stderr -chardev
> > > > > file,id=ret,path=/tmp/virtme_retefeobj4f -device virtio-serial-pci
> > > > > -device virtserialport,name=virtme.ret,chardev=ret -no-reboot -kernel
> > > > > ./arch/x86/boot/bzImage -append 'nr_open=1048576
> > > > > virtme_link_mods=/builds/linux-media/media-staging/.virtme_mods/lib/modules/0.0.0
> > > > > console=ttyS0 earlyprintk=serial,ttyS0,115200 panic=-1
> > > > > virtme.exec=`c2ggL21lZGlhLWNpL3Rlc3RkYXRhL3ZpcnRtZS90ZXN0LnNoIC9tZWRpYS1jaS90aGlyZF9wYXJ0eS92NGwtdXRpbHMgLTMy`
> > > > > virtme_root_user=1 rootfstype=9p
> > > > > rootflags=version=9p2000.L,trans=virtio,access=any raid=noautodetect
> > > > > ro init=/usr/lib/python3/dist-packages/virtme/guest/virtme-init'  
> > > >
> > > > boots fine for me on old Xeon E5-2630v3.
> > > > Perhaps issue is that your host is too slow,
> > > > is there reason not to use KVM instead of TCG?  
> > > 
> > > I am using a e2 instance that does not support nested virtualization :(
> > >   
> > > >
> > > > Alternatively you can try using q35 machine type
> > > > instead of default 'pc', it doesn't have _PRT in
> > > > simple configuration like yours.
> > > > But then running things that depend on time is not
> > > > reliable under TCG, so you might hit timeout elsewhere.  
> > > 
> > > I will give it a try... but you are correct, if this is running this
> > > slow I expect that nothing from my CI will work reliably.  
> > 
> > I'm really interested to see if q35 helps here. If that's the case maybe
> > we should default to q35 in virtme-ng when KVM isn't available (even if
> > on my box q35 is actually slower than the default pc, so in that case we
> > may need to come up with some logic to pick the right machine type).
> 
> it might be interesting to find out why q35 is slower (it shouldn't be)

Nevermind, I was comparing native kvm vs q35, of course it was slower...

> With above config one can put all devices on hostbridge as integrated endpoints
> which roughly will be the same as PCI topo in 'pc' machine)
> 
> another thing that might help is adding '-cpu max' instead of default
> qemu64 cpu model.

Doing the proper comparison (disabling kvm), adding '-cpu max' to the
equation and measuring the boot time of multiple virtme-ng runs, gives
me the following result (average of 10 runs):

                     machine
              +----------------
              | default     q35
     ---------+----------------
cpu  |default |     13s     11s
     |max     |     15s     14s

I've tried a couple of kernel configs and I get similar results.

In the scope of virtme-ng (optimize boot time) I'd say that it'd makes
sense to use '-machine q35' and default cpu settings when kvm is
unavailable.

Ricardo, do you see similar results?

Thanks,
-Andrea
