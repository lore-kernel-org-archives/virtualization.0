Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C6F71743
	for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 12:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185749; cv=none; b=khFxEfn/JzqaImvYpJkqiHL2RC/0sryMPb5t5Bbo5sllqfTOVhp+huJ1eleOKrTwVNKszJp/diWDkg4waDLuIsGS8F719zxdr6Fif0EGICNzK8tQlW4i3FRaWXr45BH+/t29nYjywKzQFM1h76HnyQ5+hmcbf/1tUTi0t3CqTcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185749; c=relaxed/simple;
	bh=poqX5X3rVervt+Md337iHLbWmQ5knMBSO1lx2KccxNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KqE1RQTFlUdR/StDokY5Q0ZRHGRU5sHaXRE3fvgmXtUbbN/PGyuUhB9H9HkdqN7P1uFF2ZAOQI3wgzVVTus4Ht1100LmSww5oilk0xpO/7E3hyVIMSLBoTU+Z7Z2BWt/cDQOmOSqXSQ2lEMiLRdpLmakE3KARwkaKfq6loxg5Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xa9/0QrG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xa9/0QrG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178F9C32783
	for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 12:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185749;
	bh=poqX5X3rVervt+Md337iHLbWmQ5knMBSO1lx2KccxNU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xa9/0QrG3omCTXwWhsldSy3ahVmF0XPt3HL9D/2Rd6IpN1ImMsbJlbeOtsyobD5lD
	 eAFitHCGIbsHuBSU0lx+FaDQF771IrNhFZE5qFSeWBHyySmoebgFwrJizmSDN4KTaO
	 Epfl8qtVywf7fnavtEw6hFm256OVRlb2YGU3sp9K07d/EioQtxQk/z9WqUbDvlhvB7
	 UY9YURL0fuAHttXLhEmknIwM2u5iE+wYA4fCDmkhlqLbHM/fK3VXs8xdjtXFEbNTNe
	 inO4hvAlls76R++e2rOPcXbXmhtv0XWOHQUvF0e6RagHDzyukLrJthQAX7NT0KLjwc
	 L1n8g2UW7S7SQ==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-22ec8db3803so290529fac.1
        for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 05:55:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+XfFp6RWnO27d1Kn5SHygj6ZXAzvtDPgiaMhU+LmkxTr6+XtE867ajNu9jGNVmtMEf0zchAGS6+gjGRFmmevSvZSQH1Ch0/tsKhVS9Mw=
X-Gm-Message-State: AOJu0YwId2tszK+U19iV9qmR2t98hLgGnktAcsKtdoEoMHWo9zGxB0gf
	mj1Ok1axeCWg2mqdevqtlO3xYAK+MgBAmB/0RlIsAvqeIdkZT98fBiPgBdpFbqEhqCMAXX4kCX+
	kxOdbcPxMW0kAIKMEPjM2PMqXLZo=
X-Google-Smtp-Source: AGHT+IF/tdMzZU2a8I7AYHFYkzA/W/hUnA/yyO/83cSuAK5hmCBPQ4M0y9QO7S7nR0QKGpcVh42OyYq+qrdVvSIhH3o=
X-Received: by 2002:a05:6871:a00a:b0:233:6391:6180 with SMTP id
 vp10-20020a056871a00a00b0023363916180mr11785275oab.1.1713185748326; Mon, 15
 Apr 2024 05:55:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CANiDSCtJKZDwSpy3RWW7FPQiJf+LqxrZJs=N7KrvCz0EFjh2wQ@mail.gmail.com>
 <20240414043707-mutt-send-email-mst@kernel.org> <20240415145153.21075173@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240415145153.21075173@imammedo.users.ipa.redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Apr 2024 14:55:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j3BVUKDFE-_Tdykt42zCiDfYMpSYN54JUqdr2O8a__1w@mail.gmail.com>
Message-ID: <CAJZ5v0j3BVUKDFE-_Tdykt42zCiDfYMpSYN54JUqdr2O8a__1w@mail.gmail.com>
Subject: Re: ACPI timeouts when enabling KASAN
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ricardo Ribalda <ribalda@google.com>, 
	Andrea Righi <andrea.righi@canonical.com>, virtualization@lists.linux.dev, 
	stevensd@chromium.org, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 2:52=E2=80=AFPM Igor Mammedov <imammedo@redhat.com>=
 wrote:
>
> On Sun, 14 Apr 2024 04:37:24 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>
> > On Fri, Apr 12, 2024 at 11:43:22PM +0200, Ricardo Ribalda wrote:
> > > Hi
> > >
> > > I am using virtme to do some CI around linux-media.
> > >
> > > Everything works as expected, but when I enable KASAN, I am starting
> > > to get a lot of timeouts when the Method _PRT is executed. Eg:
> > >
> > > [   56.335875] ACPI Error: Aborting method \_SB.PCI0._PRT due to
> > > previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
> > > [   56.529826] ACPI Error: Method execution failed \_SB.PCI0._PRT due
> > > to previous error (AE_AML_LOOP_TIMEOUT) (20230628/uteval-68)
> > > [   56.532391] virtio-pci 0000:00:02.0: can't derive routing for PCI =
INT A
> > > [   56.532823] virtio-pci 0000:00:02.0: PCI INT A: no GSI
> > > [   86.877471] ACPI Error: Aborting method \_SB.PCI0._PRT due to
> > > previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
> > > [   87.073854] ACPI Error: Method execution failed \_SB.PCI0._PRT due
> > > to previous error (AE_AML_LOOP_TIMEOUT) (20230628/uteval-68)
> > > [   87.075550] virtio-pci 0000:00:04.0: can't derive routing for PCI =
INT A
> > > [   87.075810] virtio-pci 0000:00:04.0: PCI INT A: no GSI
> > >
> > > 0000:00:04.0 and 0000:00:02.0 are virtio devices (console and 9p-file=
system)
> > >
> > > If I increase the timeout (ACPI_MAX_LOOP_TIMEOUT), then the Method is
> > > always executed, but it is very annoying that I have to wait more tha=
n
> > > 5 minutes to start the vm.
> > >
> > > Despite not having kvm enabled, the machine is quite decent, so I
> > > would expect that it could run that method relatively fast.
> > >
> > > Do you have any hint of what I should be looking at?
>
> The way QEMU generates _PRT haven't been changed for ages,
> it's not likely to be a culprit.
>
> CCing Rafael who might have an idea why ACPI misbehaves.

It looks like the method evaluation time increases with KASAN enabled
and it gets aborted due to exceeding the evaluation time limit.

Thanks!
