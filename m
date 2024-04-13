Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F08D1CD06
	for <virtualization@lists.linux.dev>; Sat, 13 Apr 2024 07:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712993970; cv=none; b=bo7FhzMX17XaeuNX9U2rRnwE834Z+Kvx8Xlg8p1efjXhtdbuNM0DrufZNIa9Kl8wEZHhuFD5wmDJQ/JhBWghxPA8T4wAjj06aMDV1M+yE2+AoN/noTjWkHWGdwGRrwsYuexVqGvvqDTW6X/AhbLW80XtKxDHAfzCefupqPqzFV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712993970; c=relaxed/simple;
	bh=THA54mTHnxlwGRcOfqJBJ5oecxOmGAHiv7CzGirlZRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N/iSlkSQqjscrVgEkIIPtxrBUnckc4tjPIqVqeD4oTfUcHc+Yz3bQsVjWyddTYa/INVFJV2/IunkOOeCq77Ao4NYMbnSg07FKxmC2diXE8EYdL8ZUHRG3Xj/o5CIB7El8k2B0YigtEoFokrz2cfUYaNkc8yxB8XMVkMlE3KNi+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=f68YJwP6; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f68YJwP6"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78d61a6229bso100896785a.0
        for <virtualization@lists.linux.dev>; Sat, 13 Apr 2024 00:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712993967; x=1713598767; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qMyf5Oj5lrQbMkI22lImwyVKQFhh8ozHX3TjsQhzrkQ=;
        b=f68YJwP6fCGda8hGwegdloH/QrTwxVDxqFRt4nLXp/gP5sml8ND4XR2R/Cxi+t0GqW
         Jw5tUqNlDPA72qmSP7ymqooOuYSP8QKsysZWxZ7WDnwsNGDSGYSoFkDzl9Rslci6X4Nr
         zPgJs4RXEvs3C00Rnge+YZ8RlpRR5tQhkBVvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712993967; x=1713598767;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qMyf5Oj5lrQbMkI22lImwyVKQFhh8ozHX3TjsQhzrkQ=;
        b=MG3zhnL2QNb7SJ+X72my17maymg0/GUX0VM63K/ZqoaOidSa+3mL7gFbWjy5XJ8IZt
         AEYUa8fkGWyBsbIKr/YRUkTeuHizKUM/BmP9Aa8+G4OYM4JMP5UKiEwWgMaI6ej3NF3P
         +qFkxV9+FHm9y784Ha+lwZ9osNuk32ktGz8ySc8CY0sFZXLNn2BiY2El3JXyNl0SoT1c
         ynkSxWx4/XM8TFbvNZ44XkDCoXQic211KVsJNaTpEX2FWBx74d5k8/40yg4N5IxqtZJG
         6Qaetd8Xx8SYDNoddGXg2oL6QxR56g9cQhBxOmQpiwisctNwmYiG8Vk/N6BXy2j7TNv+
         0GIw==
X-Gm-Message-State: AOJu0YzDBNj3u4wC67iOQQ0vB1QTHoTpUMkUYFTt2vWqbOhQ7yeJVjG+
	HZ87GgdDWVDxc7rWj3qX1LhxHdoCb/QZOdpOWH+FyGXM3ITfXs001Az+YIyN3drfv18gt3ufhpc
	=
X-Google-Smtp-Source: AGHT+IHiKF7SVMhXzburMOPlF1MuV4DNNdphgxgSmWVYc2m2OCnNJNwW96bl+yUdfed4eno67tPPlA==
X-Received: by 2002:ac8:5dc7:0:b0:436:5f58:84d5 with SMTP id e7-20020ac85dc7000000b004365f5884d5mr6301144qtx.21.1712993967163;
        Sat, 13 Apr 2024 00:39:27 -0700 (PDT)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com. [209.85.219.43])
        by smtp.gmail.com with ESMTPSA id w14-20020ac84d0e000000b004364e61ce09sm3172639qtv.66.2024.04.13.00.39.26
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Apr 2024 00:39:26 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-69b224e025dso7644236d6.1
        for <virtualization@lists.linux.dev>; Sat, 13 Apr 2024 00:39:26 -0700 (PDT)
X-Received: by 2002:a0c:ea27:0:b0:69b:bec:562e with SMTP id
 t7-20020a0cea27000000b0069b0bec562emr4999252qvp.12.1712993965596; Sat, 13 Apr
 2024 00:39:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CANiDSCtJKZDwSpy3RWW7FPQiJf+LqxrZJs=N7KrvCz0EFjh2wQ@mail.gmail.com>
 <Zhoeec0lfVEPmGj0@gpd>
In-Reply-To: <Zhoeec0lfVEPmGj0@gpd>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Sat, 13 Apr 2024 09:39:09 +0200
X-Gmail-Original-Message-ID: <CANiDSCuikv8Lw3x27qQnyNh=tBSkmcvYkUjaqL=8uMqLmn2A6w@mail.gmail.com>
Message-ID: <CANiDSCuikv8Lw3x27qQnyNh=tBSkmcvYkUjaqL=8uMqLmn2A6w@mail.gmail.com>
Subject: Re: ACPI timeouts when enabling KASAN
To: Andrea Righi <andrea.righi@canonical.com>
Cc: virtualization@lists.linux.dev, stevensd@chromium.org, 
	"mst@redhat.com" <mst@redhat.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 13 Apr 2024 at 07:56, Andrea Righi <andrea.righi@canonical.com> wrote:
>
> On Fri, Apr 12, 2024 at 11:43:22PM +0200, Ricardo Ribalda wrote:
> > Hi
>
> Hi Ricardo,

Hi Andrea!

>
> >
> > I am using virtme to do some CI around linux-media.
> >
> > Everything works as expected, but when I enable KASAN, I am starting
> > to get a lot of timeouts when the Method _PRT is executed. Eg:
> >
> > [   56.335875] ACPI Error: Aborting method \_SB.PCI0._PRT due to
> > previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
> > [   56.529826] ACPI Error: Method execution failed \_SB.PCI0._PRT due
> > to previous error (AE_AML_LOOP_TIMEOUT) (20230628/uteval-68)
> > [   56.532391] virtio-pci 0000:00:02.0: can't derive routing for PCI INT A
> > [   56.532823] virtio-pci 0000:00:02.0: PCI INT A: no GSI
> > [   86.877471] ACPI Error: Aborting method \_SB.PCI0._PRT due to
> > previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
> > [   87.073854] ACPI Error: Method execution failed \_SB.PCI0._PRT due
> > to previous error (AE_AML_LOOP_TIMEOUT) (20230628/uteval-68)
> > [   87.075550] virtio-pci 0000:00:04.0: can't derive routing for PCI INT A
> > [   87.075810] virtio-pci 0000:00:04.0: PCI INT A: no GSI
> >
> > 0000:00:04.0 and 0000:00:02.0 are virtio devices (console and 9p-filesystem)
> >
> > If I increase the timeout (ACPI_MAX_LOOP_TIMEOUT), then the Method is
> > always executed, but it is very annoying that I have to wait more than
> > 5 minutes to start the vm.
> >
> > Despite not having kvm enabled, the machine is quite decent, so I
> > would expect that it could run that method relatively fast.
> >
> > Do you have any hint of what I should be looking at?
>
> I'm wondering if it's a microvm-related issue...
>
> Can you try to add --disable-microvm to your virtme command line and see
> if it makes any difference?

I get the same results :(. BTW, this is the service that I think it is
taking lots of time:


            Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                Local0 = Package (0x80){}
                Local1 = Zero
                While ((Local1 < 0x80))
                {
                    Local2 = (Local1 >> 0x02)
                    Local3 = ((Local1 + Local2) & 0x03)
                    If ((Local3 == Zero))
                    {
                        Local4 = Package (0x04)
                            {
                                Zero,
                                Zero,
                                LNKD,
                                Zero
                            }
                    }

                    If ((Local3 == One))
                    {
                        If ((Local1 == 0x04))
                        {
                            Local4 = Package (0x04)
                                {
                                    Zero,
                                    Zero,
                                    LNKS,
                                    Zero
                                }
                        }
                        Else
                        {
                            Local4 = Package (0x04)
                                {
                                    Zero,
                                    Zero,
                                    LNKA,
                                    Zero
                                }
                        }
                    }

                    If ((Local3 == 0x02))
                    {
                        Local4 = Package (0x04)
                            {
                                Zero,
                                Zero,
                                LNKB,
                                Zero
                            }
                    }

                    If ((Local3 == 0x03))
                    {
                        Local4 = Package (0x04)
                            {
                                Zero,
                                Zero,
                                LNKC,
                                Zero
                            }
                    }

                    Local4 [Zero] = ((Local2 << 0x10) | 0xFFFF)
                    Local4 [One] = (Local1 & 0x03)
                    Local0 [Local1] = Local4
                    Local1++
                }

                Return (Local0)
            }
        }
>
> Thanks,
> -Andrea
>
> >
> > Thanks!
> >
> > ```
> > # virtme-ng --version
> > virtme-ng 1.23
> > # qemu-system-amd64 --version
> > QEMU emulator version 8.2.1 (Debian 1:8.2.1+ds-2)
> > Copyright (c) 2003-2023 Fabrice Bellard and the QEMU Project developers
> > # git describe
> > v6.9-rc3-208-g586b5dfb51b96
> >
> > # virtme-configkernel --defconfig --arch x86_64
> > # scripts/config -e KASAN
> > # make olddefconfig
> > # make all -j 256
> > # virtme-run --kdir . --mods=auto --show-command --show-boot-console
> > --verbose  --cpus 2 --memory 4G --script-sh "echo HelloWorld"
> > ```
> >
> >
> >
> > --
> > Ricardo Ribalda
> > Software Engineer
> > ribalda@google.com



-- 
Ricardo Ribalda
