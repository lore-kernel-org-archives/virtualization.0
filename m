Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F86135A69
	for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 17:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719337485; cv=none; b=UmyMm/ONrOfhgioZ4svqzw583JSu1hSRuN3yPVUeQxpS3IOdTH4jCgAlFFlWhY5s+A6ate2MD9OOmIYvH+v67LnqfEaplss97bdcIt8Xml+q8JLT5Z6o80ba6DbRUVrvrxUCpAmfdJvHMaaO+84CVlsU96iExXW4tgZwsBq6WOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719337485; c=relaxed/simple;
	bh=yMA6UE6weehFHS2vhpCm6pr6A4vLSml8kZ5bPa6RH+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IpIVMzC8kkV7YMt42wnJRkxLJ+o8uE22lEuJPFsSF1+2kXXlnqXiSQtxQfq0bhRVSysLkewAG+8tIFyZW7bIhqf4den9woq5CQnHppkDYL4M7DV1PJXNp+n7iIxNKMirHDUMxEeeDYGaqsRnaXQu51lxbu79byKoh0gNIWOwQ/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBeLg5Nl; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBeLg5Nl"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52cdd03d6aaso3692447e87.0
        for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 10:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719337482; x=1719942282; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAC2o+wo388yK5rwpnKsBafa76gLqC7NxDi/njKmEYk=;
        b=ZBeLg5NlzcPYi80lRQF7yZisjEPSkKns0O1pvp/EwjfJTDBlB5kBDMUr5Mjd4sHbql
         xOsTIftLnYz1yflnHH3MMJQL0nFTvu3LuI2CRV4sGcPdZuOYbDlIIzAxPUiiTM2OapnV
         aNl3/qGab8Y0Sf8kEj3NKjKsjEAPKROt0ZZKPyhBlWHlptR1lkG7Owef/rSXqR8QY56G
         4PpKonwb9/uiFjPi3/U9mSuwOelQ88LvB/HpQwI2zPGsU+gc1dUkurAWYchTKQ75rG9o
         co8rQQGw4Td0kUqKHYaOigFfEyX0cktBlJXuBXgGHHV9BnlNxYb0oE9pSFegle0HPAGt
         qN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719337482; x=1719942282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wAC2o+wo388yK5rwpnKsBafa76gLqC7NxDi/njKmEYk=;
        b=wSSFapIx3BkfAyJ66vAO5fsBTGgHRpP1SnYPP9OLK/6ZHbztgOEftfbMWBHPE8Uie1
         RZjncymQ0WvBX5xuphWFfjGtDDQ3pEps/kVpo9zWQHy2Tcc1NwmLHvRh4nvAoZzT6Ihq
         XzpRydBUO4XZJ3BzCNVwflbkJYCVS0FrmyAZIXsyYTN/iTdVXx9fK7AgCNvejlzdcl+n
         coFOSLW0OTVNTHy1LkrlkgRG8c+47olAU139uigQ+GbVS4/Vwkszy/jQEA8V0ccVBcFV
         y18J0nBI80RT5wp/ANjQbCm2pJzBj2ncPLUwTNpHmvIIDdE5Oakm43EFWPn+AzonBQLY
         0usQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+5zY1zebjqOxoJYbvsYDO8xZExUYoAmhr4vg7rQxQKmXv6sykPceRNTWfm8XZnEf2yR33NrhHeZiECpcKnQCq/B/lBA2XLgH77EdwtMo=
X-Gm-Message-State: AOJu0YzmnW4vQhI/3aKi79roRGLUmCt2nDad9H8k9tvmb+Yb2X9j+bJ1
	5RdMifCJlBB5maOQFN9lvQcrEs8rTelQytfyXhzULrNuxuOYJ4IKhyykMX8K0eQh47BhB0cwfRo
	GCxOCHSptGBAX+9DTovuWAjUdfoU=
X-Google-Smtp-Source: AGHT+IEqK0IgdrEEupBY2bIgxT3Ga6NtkBVHoj/WUSUZdXM/ZmJIKxvQvNg1rRDFcyfz9VhEaZNStJy71RAKP7jU6tM=
X-Received: by 2002:a05:6512:12c3:b0:52c:82fa:ef7b with SMTP id
 2adb3069b0e04-52ce067270amr6326648e87.44.1719337482097; Tue, 25 Jun 2024
 10:44:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <6wn6ikteeanqmds2i7ar4wvhgj42pxpo2ejwbzz5t2i5cw3kov@omiadvu6dv6n>
 <5b3b1b08-1dc2-4110-98d4-c3bb5f090437@amazon.com> <554ae947-f06e-4b69-b274-47e8a78ae962@amazon.com>
 <14e68dd8-b2fa-496f-8dfc-a883ad8434f5@redhat.com> <c5wziphzhyoqb2mwzd2rstpotjqr3zky6hrgysohwsum4wvgi7@qmboatooyddd>
 <CABgObfasyA7U5Fg5r0gGoFAw73nwGJnWBYmG8vqf0hC2E8SPFw@mail.gmail.com>
 <sejux5gvpakaopre6mk3fyudi2f56hiuxuevfzay3oohg773kd@5odm3x3fryuq>
 <CABgObfb-KrmJzr4YBtuN3+_HLm3S1hmjO7uEy0+AxSDeWE3uWg@mail.gmail.com>
 <l5oxnxkg7owmwuadknttnnl2an37wt3u5kgfjb5563f7llbgwj@bvwfv5d7wrq4>
 <3b6a1f23-bf0e-416d-8880-4556b87b5137@amazon.com> <hyrgztjkjmftnpra2o2skonfs6bwf2sqrncwtec3e4ckupe5ea@76whtcp3zapf>
In-Reply-To: <hyrgztjkjmftnpra2o2skonfs6bwf2sqrncwtec3e4ckupe5ea@76whtcp3zapf>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Tue, 25 Jun 2024 23:44:30 +0600
Message-ID: <CAFfO_h5_uAwdNJB=fjrxb_pPiwRDQxaZn=OvR3yrYd+c18tUdQ@mail.gmail.com>
Subject: Re: How to implement message forwarding from one CID to another in
 vhost driver
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Alexander Graf <graf@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Alexander Graf <agraf@csgraf.de>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Stefano,

On Wed, May 29, 2024 at 4:56=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Wed, May 29, 2024 at 12:43:57PM GMT, Alexander Graf wrote:
> >
> >On 29.05.24 10:04, Stefano Garzarella wrote:
> >>
> >>On Tue, May 28, 2024 at 06:38:24PM GMT, Paolo Bonzini wrote:
> >>>On Tue, May 28, 2024 at 5:53=E2=80=AFPM Stefano Garzarella
> >>><sgarzare@redhat.com> wrote:
> >>>>
> >>>>On Tue, May 28, 2024 at 05:49:32PM GMT, Paolo Bonzini wrote:
> >>>>>On Tue, May 28, 2024 at 5:41=E2=80=AFPM Stefano Garzarella
> >>>><sgarzare@redhat.com> wrote:
> >>>>>> >I think it's either that or implementing virtio-vsock in userspac=
e
> >>>>>> >(https://lore.kernel.org/qemu-devel/30baeb56-64d2-4ea3-8e53-6a5c5=
0999979@redhat.com/,
> >>>>>> >search for "To connect host<->guest").
> >>>>>>
> >>>>>> For in this case AF_VSOCK can't be used in the host, right?
> >>>>>> So it's similar to vhost-user-vsock.
> >>>>>
> >>>>>Not sure if I understand but in this case QEMU knows which CIDs are
> >>>>>forwarded to the host (either listen on vsock and connect to the hos=
t,
> >>>>>or vice versa), so there is no kernel and no VMADDR_FLAG_TO_HOST
> >>>>>involved.
> >>>>
> >>>>I meant that the application in the host that wants to connect to the
> >>>>guest cannot use AF_VSOCK in the host, but must use the one where QEM=
U
> >>>>is listening (e.g. AF_INET, AF_UNIX), right?
> >>>>
> >>>>I think one of Alex's requirements was that the application in the ho=
st
> >>>>continue to use AF_VSOCK as in their environment.
> >>>
> >>>Can the host use VMADDR_CID_LOCAL for host-to-host communication?
> >>
> >>Yep!
> >>
> >>>If
> >>>so, the proposed "-object vsock-forward" syntax can connect to it and
> >>>it should work as long as the application on the host does not assume
> >>>that it is on CID 3.
> >>
> >>Right, good point!
> >>We can also support something similar in vhost-user-vsock, where instea=
d
> >>of using AF_UNIX and firecracker's hybrid vsock, we can redirect
> >>everything to VMADDR_CID_LOCAL.
> >>
> >>Alex what do you think? That would simplify things a lot to do.
> >>The only difference is that the application in the host has to talk to
> >>VMADDR_CID_LOCAL (1).
> >
> >
> >The application in the host would see an incoming connection from CID
> >1 (which is probably fine) and would still be able to establish
> >outgoing connections to the actual VM's CID as long as the Enclave
> >doesn't check for the peer CID (I haven't seen anyone check yet). So
> >yes, indeed, this should work.
> >
> >The only case where I can see it breaking is when you run multiple
> >Enclave VMs in parallel. In that case, each would try to listen to CID
> >3 and the second that does would fail. But it's a well solvable
> >problem: We could (in addition to the simple in-QEMU case) build an
> >external daemon that does the proxying and hence owns CID3.
>
> Well, we can modify vhost-user-vsock for that. It's already a daemon,
> already supports different VMs per single daemon but as of now they have
> to have different CIDs.
>
> >
> >So the immediate plan would be to:
> >
> >  1) Build a new vhost-vsock-forward object model that connects to
> >vhost as CID 3 and then forwards every packet from CID 1 to the
> >Enclave-CID and every packet that arrives on to CID 3 to CID 2.
>
> This though requires writing completely from scratch the virtio-vsock
> emulation in QEMU. If you have time that would be great, otherwise if
> you want to do a PoC, my advice is to start with vhost-user-vsock which
> is already there.
>

Can you give me some more details about how I can implement the
daemon? I would appreciate some pointers to code too.

Right now, the "nitro-enclave" machine type (wip) in QEMU
automatically spawns a VHOST_VSOCK device with the CID equal to the
"guest-cid" machine option. I think this is equivalent to using the
"-device vhost-vsock-device,guest-cid=3DN" option explicitly. Does that
need any change? I guess instead of "vhost-vsock-device", the
vhost-vsock device needs to be equivalent to "-device
vhost-user-vsock-device,guest-cid=3DN"?

The applications inside the nitro-enclave VM will still connect and
talk to CID 3. So on the daemon side, do we need to spawn a device
that has CID 3 and then forward everything this device receives to CID
1 (VMADDR_CID_LOCAL) same port and everything it receives from CID 1
to the "guest-cid"? The applications that will be running in the host
need to be changed so that instead of connecting to the "guest-cid" of
the nitro-enclave VM, they will instead connect to VMADDR_CID_LOCAL.
Is my understanding correct?

BTW is there anything related to the "VMADDR_FLAG_TO_HOST" flag that
needs to be checked? I remember some discussion about it.

It would be great if you could give me some details about how I can
achieve the CID 3 <-> CID 2 communication using the vhost-user-vsock.
Is this https://github.com/stefano-garzarella/vhost-user-vsock where I
would need to add support for forwarding everything to
VMADDR_CID_LOCAL via an option maybe?

Thanks and Regards,
Dorjoy
