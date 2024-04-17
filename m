Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADD013D53D
	for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713358347; cv=none; b=W3lIy5u7WuZAxzO9FODG1sW1jgPxQ/hKhlIbC9IOmSnwMIhsYdOU7H79h/PuP98hSCbfdEVx/hV9uC2cO5Z6z6VlPO4whIzteI1/OjLV2x0zzxwfuYH3pScjVXRHBmfRK+Uud+rITd/i6xj3coWME0yChDane83jiPpaKCQYQzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713358347; c=relaxed/simple;
	bh=YDmVm5AVngmbLaYtCfBesGMM8UJbIuBz9YcE1q4/cow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebV1EZI1TTdRbcPaRzGQJvmEsUo/82CnCKOGulsf2wkTJK453vUUNo76NlZuhXLvjUGQHfJmVam5uCHbqyAcar3nVo9wqcDXfGPIGHSUDILCWAbtbgpi9ZNRtJkQDleiC/rYDOAxjwpWMlBozpapmSrluZTqgTQ897fAsYsCIWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=AsH4ZTGT; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="AsH4ZTGT"
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4708B3F8DC
	for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 12:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713358341;
	bh=5M44Flat2qvFXe0JwhDrjEffyJMTMA0n3BPrV8iMlNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=AsH4ZTGTmdr71plZro1fg4X3Duyyfz25W7YsKJSSIEcPpG6N1aMenMXu9sfi7JUX4
	 yhi0IL+V8qd5ZWUgt++p6VA6jqDXgzLLUfhoYynSQcPnBj3ctZPryod7Dv8UEqUBA2
	 /Tzgb1GInKPCPTbfv2Tg/XmVv7aVs82DKQ0Be9Z3Xcyhs1DCBoZEI749aewloA346I
	 vlY4RdVIbwDTUhA7Bcc5QfFD1jMqOMiW5T+acem6X2CLqPXk3r8OVFTSuPXrTbT/R+
	 JKaURtYzNzCzrCM8HELyg+eya6EIdU7pXtMp6T6wINUTCHJ//f8oc1sjZWZO1cUlUz
	 JGYLcK+hnsy1Q==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a526a77445bso275240766b.2
        for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 05:52:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713358339; x=1713963139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5M44Flat2qvFXe0JwhDrjEffyJMTMA0n3BPrV8iMlNM=;
        b=iCWmldyNA7N9+mCvqgGp8RUN/aoc6qG4NdiEeTjtNZrtbmFFYxmhelZhJznmJhTUFP
         +P4xrybVivDU4U8q5Wb7iQXxD+xNnNLQl8aXlctcqEFPXmD98pbrx1AnMCJiZqwNWw1l
         WVUgcEePOhgYFaqf8kZCKdAYsDzVJYLQfdICuGMvqsGfPPMfnBH7wi97xwQz7vRCPvGL
         XpHOwUnthemfTGM66XSJGBR+aM1tpgwJJ6G8p3loQySJ33rG4k0Grwuyn3iIe518S+Wg
         8ix8QA5hRQlvroQB5+O80zXfjPwvwdVln6v9FE7JSj7q9E9rs5LDHE8anUnwW5ae8E7g
         VTOg==
X-Forwarded-Encrypted: i=1; AJvYcCXgUYPzNXouqBnbN/QFdpiZdQpael7be1CitTnYm0ZojWrp+89pNbgLYX6KJ6PYTxaQFPJXoaUHyLf4XDhdCGTq/uUeKoHq6NvmNSmAMic=
X-Gm-Message-State: AOJu0YyJ/FhqWWU6WGzDnP/ke2uo3m8yFR3sBsa97j3THACH92iN3N+w
	1HadCAuHMjGjPlSiH2XgbgqjqtoA2qMa5CULXXNXLscMF7fVMdLZf5MfrKpO5fz4g1mHeMDHdZu
	fUyr0K2XlP+AP448sND2dY3zl6lC7Ht8w3FgPK78/jKSpwVMQvjYqegSppJQ1ARJbz6N+qmRA8Q
	bF4BU2
X-Received: by 2002:a17:906:ae8d:b0:a52:6fca:9151 with SMTP id md13-20020a170906ae8d00b00a526fca9151mr5532798ejb.49.1713358338898;
        Wed, 17 Apr 2024 05:52:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHT8F57og42KSokTM8QaXJ/T6iWMG3kVcMArk/OH6ZgdlUqVuzN93o4CuzJxuqZ+Umi8Rh+QA==
X-Received: by 2002:a17:906:ae8d:b0:a52:6fca:9151 with SMTP id md13-20020a170906ae8d00b00a526fca9151mr5532773ejb.49.1713358338224;
        Wed, 17 Apr 2024 05:52:18 -0700 (PDT)
Received: from localhost (host-82-49-69-7.retail.telecomitalia.it. [82.49.69.7])
        by smtp.gmail.com with ESMTPSA id h24-20020a170906261800b00a528064f438sm3391884ejc.34.2024.04.17.05.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 05:52:17 -0700 (PDT)
Date: Wed, 17 Apr 2024 14:52:16 +0200
From: Andrea Righi <andrea.righi@canonical.com>
To: Ricardo Ribalda <ribalda@google.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev, stevensd@chromium.org
Subject: Re: ACPI timeouts when enabling KASAN
Message-ID: <Zh_GAHBcIzC9Hsmg@gpd>
References: <CANiDSCtJKZDwSpy3RWW7FPQiJf+LqxrZJs=N7KrvCz0EFjh2wQ@mail.gmail.com>
 <20240414043707-mutt-send-email-mst@kernel.org>
 <20240415145153.21075173@imammedo.users.ipa.redhat.com>
 <CAJZ5v0j3BVUKDFE-_Tdykt42zCiDfYMpSYN54JUqdr2O8a__1w@mail.gmail.com>
 <CANiDSCuvDQWam0v1b3adA=j6w+dA263QruBonsA6TJBvO9XsWQ@mail.gmail.com>
 <20240416133309.6d09ac3b@imammedo.users.ipa.redhat.com>
 <CANiDSCv=E4j0C3R_pCYMxqxe8Xep6LKQGAqJ3PC0x1kFAMq5mg@mail.gmail.com>
 <Zh5p7ILwQYEoUR8l@gpd>
 <CANiDSCv5naibDcHxrOi1Z-6k6EeQYk3eUg6UTeGu2WXj0+aLnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiDSCv5naibDcHxrOi1Z-6k6EeQYk3eUg6UTeGu2WXj0+aLnw@mail.gmail.com>

On Wed, Apr 17, 2024 at 02:13:57PM +0200, Ricardo Ribalda wrote:
> Hi Igor, Hi Andrea
> 
> 
> On Tue, 16 Apr 2024 at 14:07, Andrea Righi <andrea.righi@canonical.com> wrote:
> >
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
> >
> 
> Adding
> --qemu-opts -machine q35
> to virtme-run did the trick for me. It boots much faster
> 
> Not sure if we should blindly default to that machine type or not. My
> usecase might not be very common after all

Hm... I'll just add a note to the troubleshooting section for now. I'm
not sure if there's a reliable way to automatically detect when it's
better to use q35 or default pc.

Thanks,
-Andrea

> 
> 
> Thanks!
> 
> > Thanks,
> > -Andrea
> 
> 
> 
> -- 
> Ricardo Ribalda
