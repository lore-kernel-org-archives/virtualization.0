Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5638A12A152
	for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 12:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269242; cv=none; b=ACsYmD2AiQZPJTu18s/Rqbaua02cvdwi1ueqPBFdnJKeTSp7Jm6FZGKZj44T6NWeCW7PJRGNbip71b4QcX8OfBq5ZwOEWn950YMmAZdDaRZ3tXdYXroJQOb4j+7HZqcS3lx6726gZgBEIs8deeCWZfJflP2QMqC95n7y7f5F1wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269242; c=relaxed/simple;
	bh=v3wOCF8o/S4wuzpk/wmLZzvaeaiomHMa2c2ZgC8afb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANIKA69WH7eXG5hmBj8eBi9wQDMfEG1/WLwyv8RCOCLmwRsi63yGBFw5E8YSUx/3MnRyWz7sbO2CPXvzEw/1lG1/UgsZwRwkNzDyPmIVeAJGsTTExTATk6lubXlnZ/tkduKqjoY15JG2WWqGdiyiYXfUNwTjkmG5zDaSIUCkrrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=laCQRLcS; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="laCQRLcS"
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E5F1B3F118
	for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 12:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713269230;
	bh=8qh+OGIppDcwUEuYTXl04FIpbLsqyomKVATKW4bbPxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=laCQRLcSFQWdg6BjNAvCdw/q4ZhrN6ZfzLWnTuKAfAj+ybdBCM00Vk+7xTUyUS+Hk
	 k0fAi4kzWx2LKt4TSdFFzwcfC+JNaFOLc6bOyYydmX/b9EwP6kZOOlT8vNNKvIGT/c
	 fEJHHJrjGtNh1U72QQ9TjtzF2+gJLszu7I0xS6y7nHCxzvE9i0LkzIDPBIoMmRKZXX
	 3mT1C+fMn24Y61lTYQkdb9upAiTJ9Oeld8B+KGQn+KznM9ZkH6PXZTumsK87B3S4fX
	 CmIXdvYGYKr02FhUMi+uE9qlgDBC9TUAX1HQne+r2UqP6dUrqHEKyKi/jEeapGKalm
	 /06qyPki26TAQ==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a52539e4970so165680566b.1
        for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 05:07:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713269230; x=1713874030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qh+OGIppDcwUEuYTXl04FIpbLsqyomKVATKW4bbPxg=;
        b=crLvxcewPgfTGnk+am8zh4k9hjgWkVPpvNPQZeRYRcf3fCHFJkBgcFti4i90RBRDcI
         Ofkkol93aQ0n+vVi693hg6CDIQ7nFM1t6GeOFFRQu+or4kYDzkx1lTWabNrHrwExdjmL
         XOq4FifWof4Lw/Eo4xGDSrr3AuhRbtRhPgLRDOrrPqanjLKGxVpzvEiFTTfpc3wsleY3
         XQ2yFrqHzmCJBfcl1VdXi7S9MVvFNiKKLKL6Mfb/W/B0VQtQpJnWOD7NbTGDMQSA6oEh
         GZBmtLnA+stowgDHYM63h/rjsO72rNu+fPDvBblJyPEVyxkSKCft+FOgpRMtfQZutrt5
         AudA==
X-Forwarded-Encrypted: i=1; AJvYcCVfnaD8uT65t+ul3M8wq9ZFfgD6cV/bMICjpf5GQo1YlVpGjJn0j0t1BUz8xrDKgnEPo+Z6V9lI7WG9kXRYaJvz2q5Iv6/5ybUjKO1Gyh0=
X-Gm-Message-State: AOJu0YywCPoNTT2PhTTjO30DTKDEZnz1iZQCWLPGE0soiz+r8ZeHzz1R
	qJ5FefiqJfQ3gLaCk01CAIs9T38hcIluXRkbWj5EoHZ2wMxKZFgiZi/Po799SkzoN1sGEBbXVNF
	AAg/9CughoW6uI0BVuwuTUHLnvllGjs3AMgh//mAKi2zU5YYlATKzVoK2W3dANYEKAzzg8aPELe
	ohCg0h
X-Received: by 2002:a17:907:986:b0:a55:42bf:622c with SMTP id bf6-20020a170907098600b00a5542bf622cmr1264309ejc.52.1713269230380;
        Tue, 16 Apr 2024 05:07:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6O7nK5ovDC5jADXFDJtmS3WIYzX/BpVSUcNHWimsat/CiZxjOcfV4z1j6hR3k9CtwTTj+fg==
X-Received: by 2002:a17:907:986:b0:a55:42bf:622c with SMTP id bf6-20020a170907098600b00a5542bf622cmr1264285ejc.52.1713269229737;
        Tue, 16 Apr 2024 05:07:09 -0700 (PDT)
Received: from localhost (host-82-49-69-7.retail.telecomitalia.it. [82.49.69.7])
        by smtp.gmail.com with ESMTPSA id e12-20020a170906844c00b00a4e393b6349sm6780050ejy.5.2024.04.16.05.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 05:07:09 -0700 (PDT)
Date: Tue, 16 Apr 2024 14:07:08 +0200
From: Andrea Righi <andrea.righi@canonical.com>
To: Ricardo Ribalda <ribalda@google.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev, stevensd@chromium.org
Subject: Re: ACPI timeouts when enabling KASAN
Message-ID: <Zh5p7ILwQYEoUR8l@gpd>
References: <CANiDSCtJKZDwSpy3RWW7FPQiJf+LqxrZJs=N7KrvCz0EFjh2wQ@mail.gmail.com>
 <20240414043707-mutt-send-email-mst@kernel.org>
 <20240415145153.21075173@imammedo.users.ipa.redhat.com>
 <CAJZ5v0j3BVUKDFE-_Tdykt42zCiDfYMpSYN54JUqdr2O8a__1w@mail.gmail.com>
 <CANiDSCuvDQWam0v1b3adA=j6w+dA263QruBonsA6TJBvO9XsWQ@mail.gmail.com>
 <20240416133309.6d09ac3b@imammedo.users.ipa.redhat.com>
 <CANiDSCv=E4j0C3R_pCYMxqxe8Xep6LKQGAqJ3PC0x1kFAMq5mg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiDSCv=E4j0C3R_pCYMxqxe8Xep6LKQGAqJ3PC0x1kFAMq5mg@mail.gmail.com>

On Tue, Apr 16, 2024 at 01:36:40PM +0200, Ricardo Ribalda wrote:
> Hi Igor
> 
> On Tue, 16 Apr 2024 at 13:33, Igor Mammedov <imammedo@redhat.com> wrote:
> >
> > On Mon, 15 Apr 2024 16:18:22 +0200
> > Ricardo Ribalda <ribalda@google.com> wrote:
> >
> > > Hi Igor, Hi Rafael
> > >
> > > Yes, it seems that it is just KASAN being extremely slow.
> > > From a completely newbie here... Is there a reason why qemu generates
> > > the table vs returning a precomputed one?
> >
> > it can be a pre-generated Package
> > like we do with ARM (example: acpi_dsdt_add_pci_route_table)
> >
> > > This is the config file:
> > > https://gitlab.freedesktop.org/linux-media/media-ci/-/blob/main/testdata/virtme/virtme.config?ref_type=heads
> > >
> > > And this is the qemu cli:
> > >
> > > /usr/bin/qemu-system-x86_64 -m 4G -fsdev
> > > local,id=virtfs3,path=/,security_model=none,readonly=on,multidevs=remap
> > > -device virtio-9p-pci,fsdev=virtfs3,mount_tag=/dev/root -device
> > > i6300esb,id=watchdog0 -parallel none -net none -smp 2 -vga none
> > > -display none -serial chardev:console -chardev
> > > file,id=console,path=/proc/self/fd/2 -chardev
> > > stdio,id=stdin,signal=on,mux=off -device virtio-serial-pci -device
> > > virtserialport,name=virtme.stdin,chardev=stdin -chardev
> > > file,id=stdout,path=/proc/self/fd/1 -device virtio-serial-pci -device
> > > virtserialport,name=virtme.stdout,chardev=stdout -chardev
> > > file,id=stderr,path=/proc/self/fd/2 -device virtio-serial-pci -device
> > > virtserialport,name=virtme.stderr,chardev=stderr -chardev
> > > file,id=dev_stdout,path=/proc/self/fd/1 -device virtio-serial-pci
> > > -device virtserialport,name=virtme.dev_stdout,chardev=dev_stdout
> > > -chardev file,id=dev_stderr,path=/proc/self/fd/2 -device
> > > virtio-serial-pci -device
> > > virtserialport,name=virtme.dev_stderr,chardev=dev_stderr -chardev
> > > file,id=ret,path=/tmp/virtme_retefeobj4f -device virtio-serial-pci
> > > -device virtserialport,name=virtme.ret,chardev=ret -no-reboot -kernel
> > > ./arch/x86/boot/bzImage -append 'nr_open=1048576
> > > virtme_link_mods=/builds/linux-media/media-staging/.virtme_mods/lib/modules/0.0.0
> > > console=ttyS0 earlyprintk=serial,ttyS0,115200 panic=-1
> > > virtme.exec=`c2ggL21lZGlhLWNpL3Rlc3RkYXRhL3ZpcnRtZS90ZXN0LnNoIC9tZWRpYS1jaS90aGlyZF9wYXJ0eS92NGwtdXRpbHMgLTMy`
> > > virtme_root_user=1 rootfstype=9p
> > > rootflags=version=9p2000.L,trans=virtio,access=any raid=noautodetect
> > > ro init=/usr/lib/python3/dist-packages/virtme/guest/virtme-init'
> >
> > boots fine for me on old Xeon E5-2630v3.
> > Perhaps issue is that your host is too slow,
> > is there reason not to use KVM instead of TCG?
> 
> I am using a e2 instance that does not support nested virtualization :(
> 
> >
> > Alternatively you can try using q35 machine type
> > instead of default 'pc', it doesn't have _PRT in
> > simple configuration like yours.
> > But then running things that depend on time is not
> > reliable under TCG, so you might hit timeout elsewhere.
> 
> I will give it a try... but you are correct, if this is running this
> slow I expect that nothing from my CI will work reliably.

I'm really interested to see if q35 helps here. If that's the case maybe
we should default to q35 in virtme-ng when KVM isn't available (even if
on my box q35 is actually slower than the default pc, so in that case we
may need to come up with some logic to pick the right machine type).

Thanks,
-Andrea
