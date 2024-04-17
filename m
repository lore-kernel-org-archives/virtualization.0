Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFDD3D72
	for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 12:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713358551; cv=none; b=C0sOcFxB5uzLgEyfxw80pFvfwaPAiu8z6ocpM+Ox3/Agxg3FGjgjYmaBBHn+5dasQ5KLWleyA7z1tI3uPbIUDpfNsxTs6XAAHzXaqMtI7nhPi9bBUhsl7Xb2THxr+JlOvzUmAQYQZX8TBCW9h7UOljz/ufosUi0Pq2IxQ9fIFT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713358551; c=relaxed/simple;
	bh=+f9nxHaax/Aiud6Og4T7wLf7q/WPq4uefFLdfOglHsw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=flj9YE9Cwo6peEJGDqIZpORRk1Q0OPiS383EPnFvhPFKfUTB2ho+i+ZDNOLw7GyDMaw5tGkT8OdtNQSLu+PETXYKC8SlQ1PY8L80o7d9hr/r/evc0bA90gS+WTGsjuhDgelbhyZx3dDT77ex26/2nkzTfY0RAdesZZEln7E+dZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WBtoyBd9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WBtoyBd9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713358549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZJygx4zSWxsFqwxWeSOxF/xHGUkV8SEY4StSvrIDZFo=;
	b=WBtoyBd9Q6p1G/0FqSpHykCt6qHHv24zdx5V6tTKlEzoHFdd//Sem2PF5Mrvb/l7YqbILi
	5dQetaFourzcrrc/uEa62q1WO1zTAVeyd9B14zbqxuHFoxTUDQ289coWDZEMgMy3KPrzM3
	BweniQvIZAlx4HLAd6b249eSTkL7XDI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-H4EsAP4XMoygOgCWLK437w-1; Wed, 17 Apr 2024 08:55:47 -0400
X-MC-Unique: H4EsAP4XMoygOgCWLK437w-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-418671bb02cso14357135e9.0
        for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 05:55:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713358546; x=1713963346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJygx4zSWxsFqwxWeSOxF/xHGUkV8SEY4StSvrIDZFo=;
        b=fPd7yFV2licqUjCcZYOqdnwm00mXdFpJ8yNoKW22f+0yoGFVd6t+m67zZAkgQggsIN
         mNNb/P9IXvQiVJ2qjLjcKuz+eRV3bVhX/MZjcfgkcq0S4bNue0/nF/7OREYbdFwMlhna
         zqAf2BIeLcLc43YtOH2k1UM1ocAf/tU/LvB+6wxtPPKql+yBj+oA8Xrtt0kaL80/f9M3
         W/o/YB51RcfcI4N/C0rsVJ53NuLMyTtCv0q5LbNZxq4kysOByM8MiYQxb6jBzxT7Obdd
         lIc62qK+cm3n3YDnNLOrvxB0Rlbt0yNYBw9LObw+hfkz/gNqa1xytjSbstPOQ5f8SRNm
         93tw==
X-Forwarded-Encrypted: i=1; AJvYcCVthja/0EhEWhr6zrzxNGzz57LoDt++d0zV2S9PAal7TTHigN6HsrF/0wNWJ+PD32L2Jg8c4idr3eloJSEuqUy2HgqRJ+07WW3EUACPPb8=
X-Gm-Message-State: AOJu0YynHjrA+h22hIPkvpXtERcWKn6LjXsr0kKp8TeEl8pUHq9k9+in
	pt2Lg+uZNsVvIY38ljJoMPUlw52cpgd4bg8bSvTKdf/aTAkADc98t22PpE78u1oeRuXejgZOLL1
	+KHdsmJegqIXGo/TchYR24JMTaF5kDghlcc2TNGQ6Bdf9fSuc6LTZj4e0xVFYXKMB
X-Received: by 2002:a05:600c:4e91:b0:418:5ac:39cf with SMTP id f17-20020a05600c4e9100b0041805ac39cfmr12538410wmq.35.1713358546502;
        Wed, 17 Apr 2024 05:55:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgRdFaiY4NmuzHEUxTQUFURm0PrS8rI8Zjr3vdia5opWPI7Yw4qoifrDP0FbuT6siXd9BcNw==
X-Received: by 2002:a05:600c:4e91:b0:418:5ac:39cf with SMTP id f17-20020a05600c4e9100b0041805ac39cfmr12538402wmq.35.1713358546112;
        Wed, 17 Apr 2024 05:55:46 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o13-20020a05600c4fcd00b00417f65fb982sm2814367wmq.6.2024.04.17.05.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 05:55:45 -0700 (PDT)
Date: Wed, 17 Apr 2024 14:55:44 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Andrea Righi <andrea.righi@canonical.com>
Cc: Ricardo Ribalda <ribalda@google.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux.dev, stevensd@chromium.org
Subject: Re: ACPI timeouts when enabling KASAN
Message-ID: <20240417145544.38d7b482@imammedo.users.ipa.redhat.com>
In-Reply-To: <Zh5p7ILwQYEoUR8l@gpd>
References: <CANiDSCtJKZDwSpy3RWW7FPQiJf+LqxrZJs=N7KrvCz0EFjh2wQ@mail.gmail.com>
	<20240414043707-mutt-send-email-mst@kernel.org>
	<20240415145153.21075173@imammedo.users.ipa.redhat.com>
	<CAJZ5v0j3BVUKDFE-_Tdykt42zCiDfYMpSYN54JUqdr2O8a__1w@mail.gmail.com>
	<CANiDSCuvDQWam0v1b3adA=j6w+dA263QruBonsA6TJBvO9XsWQ@mail.gmail.com>
	<20240416133309.6d09ac3b@imammedo.users.ipa.redhat.com>
	<CANiDSCv=E4j0C3R_pCYMxqxe8Xep6LKQGAqJ3PC0x1kFAMq5mg@mail.gmail.com>
	<Zh5p7ILwQYEoUR8l@gpd>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Apr 2024 14:07:08 +0200
Andrea Righi <andrea.righi@canonical.com> wrote:

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

it might be interesting to find out why q35 is slower (it shouldn't be)
With above config one can put all devices on hostbridge as integrated endpoints
which roughly will be the same as PCI topo in 'pc' machine)

another thing that might help is adding '-cpu max' instead of default
qemu64 cpu model.

> Thanks,
> -Andrea
> 

