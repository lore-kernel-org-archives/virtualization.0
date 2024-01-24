Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7071A27E
	for <virtualization@lists.linux.dev>; Wed, 24 Jan 2024 10:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706093295; cv=none; b=GrRnTNg+MOMeWv+WMol9ceWfW7glYeJ/EllyJbhW7o7ZKgTc2e+EJJrH5A54qVD4Xc79kJNAJHd9GiHwxPWH9ltBDziKx/4Q6VHE69TM/1L3QDHLqns5p5GhUOL632MyAo/1yMv5t3QGXC5vCeo3nfqDZCgF07/aDhVNSQy8chk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706093295; c=relaxed/simple;
	bh=vUYNgyEiiBGTAOVgJfsG/RvhaXLEgRGTV9YrpqQM93E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SLUZ/ZL7pdGi8pNRwEqdzXh7EYhf0IaOW/J2zPnd1hvQdlDicDynH7IZR7Je6PcfBUSRN9xSr0HDn4pmJbSO0toMPJiV1ciix2wHp9INKSce1/QKsuJ8xv8Z2WVOMg6KQ+udH6bNWs6Rwv+IrJ+NSaQcQa3gzvJ3OGIdwH48LxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zzyYaPQV; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zzyYaPQV"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-68687ff4038so21911036d6.1
        for <virtualization@lists.linux.dev>; Wed, 24 Jan 2024 02:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706093292; x=1706698092; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X39Ts6MX+MiqoaGcJ6Oz7csIP4OtBMZYPm9qrUenbDM=;
        b=zzyYaPQV3SZauja284sgj5s9t3xHPHFBLpUVi3IXc2edcoDKvo1EZYy9efW/DR4GHv
         FKeHJmODAvuvAKojNE3YmaGGQRg5vUmdhg1UxixrLttRoX6/C4C3TUopzoQtMxHk5+En
         SlcPYe1aQT70RJlfFz7RDKRhsj1GYQtqR6mTyXferrRjYws7ICIVu9ei9foT7C2S6cY3
         pIl3oN2GiMfZI+xTQmFWwXCUq41HRt6hKjIXbxjjtoCypzdf3RNKYEdxkKw7x3gVZ0xP
         FJYaNN7m5Px6oeulqy8SVDpY+1KVNTmW2T+r8OK73UTTHbLzZj7s0xCVdsN6fW5eSSlY
         aVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706093292; x=1706698092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X39Ts6MX+MiqoaGcJ6Oz7csIP4OtBMZYPm9qrUenbDM=;
        b=NotcuD+AI+UEm8ebYNCDdAsHRDe0f0X80Tes3g7R4wSO8OrFGsPFlySuRm4bx2w5Px
         dN8NgVGCSPaisGE1x2zuIJ3Ofk6Ww6o75Mj26MBUYUcWXp+awgHIuA9iy6C8JRdJZbeV
         YyPwMXU5hgNtbameMkNFjmSdahAJ9WEYtfW/1acjDIKTNHTko02CF85+GMqNZuPliaOc
         ymEslc+L7/B1v6Pbgu6PoCt7eGqUm4L3AwwzkuiPmpag//WEDukAJxbjaZaIdNIUo3g/
         IiC1q5rbx6HzzhjFWIenu1gLlyHmywXXKB8wTa4otvprsolRAtH6e0G5EKA0zWhEYxY8
         YVxA==
X-Gm-Message-State: AOJu0YxejQ44LsUKjAwlgD4Tc97PM2hrVUXlyYXJ5fwpS2Zwo6+VOwXp
	C0m23bOWKdxdnaejHs0Rw1OYT8HJewCEzRJ1+DZbI0xdm55zqJuqJ8lxSGZfuLYKwtJKTVvdy6S
	zp1EhnxgJ5Nfh98GaXNtEN9ETxNzJb0QBzE/5
X-Google-Smtp-Source: AGHT+IG/GIxnoyhhLGaRwHzJnw2CsYDhw/Wa9qcMoyzCYt60ApWQxGfmvif7M11I8JdtLap1q9TWl31q5SAh8dAPA98=
X-Received: by 2002:a05:6214:1d04:b0:682:85f5:f009 with SMTP id
 e4-20020a0562141d0400b0068285f5f009mr3313074qvd.130.1706093292445; Wed, 24
 Jan 2024 02:48:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <000000000000fd588e060de27ef4@google.com> <20240102080315-mutt-send-email-mst@kernel.org>
 <20240104204531.GB954424@fedora>
In-Reply-To: <20240104204531.GB954424@fedora>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 24 Jan 2024 11:47:32 +0100
Message-ID: <CAG_fn=XmxeUePHFth5asQvHvo3=QSL4tB4yS5_3UVHWYJ=VRnw@mail.gmail.com>
Subject: Re: [syzbot] [virtualization?] KMSAN: uninit-value in virtqueue_add (4)
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: syzbot <syzbot+d7521c1e3841ed075a42@syzkaller.appspotmail.com>, 
	jasowang@redhat.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com, bonzini@redhat.com, 
	"Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 9:45=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.com=
> wrote:
>
> On Tue, Jan 02, 2024 at 08:03:46AM -0500, Michael S. Tsirkin wrote:
> > On Mon, Jan 01, 2024 at 05:38:24AM -0800, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    fbafc3e621c3 Merge tag 'for_linus' of git://git.kerne=
l.org..
> > > git tree:       upstream
> > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D173df3e9e=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3De0c7078a6=
b901aa3
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd7521c1e384=
1ed075a42
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for=
 Debian) 2.40
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1300b4a=
1e80000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D130b0379e=
80000
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/1520f7b6daa4=
/disk-fbafc3e6.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/8b490af009d5/vm=
linux-fbafc3e6.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/202ca200f4=
a4/bzImage-fbafc3e6.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> > > Reported-by: syzbot+d7521c1e3841ed075a42@syzkaller.appspotmail.com
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>
> Hi Alexander,
> Please take a look at this KMSAN failure. The uninitialized memory was
> created for the purpose of writing a coredump. vring_map_one_sg() should
> have direction=3DDMA_TO_DEVICE.
>
Hi Stefan,

I took a closer look, and am pretty confident this is a false positive.
I tried adding memset(..., 0xab, PAGE_SIZE << order) to alloc_pages()
and never saw
the 0xab pattern in the buffers for which KMSAN reported an error.

This probably isn't an error in 88938359e2df ("virtio: kmsan:
check/unpoison scatterlist in
vring_map_one_sg()"), which by itself should be doing a sane thing:
report an error if an
uninitialized buffer is passed to it. It is more likely that we're
missing some initialization that
happens in coredump.c

Does anyone have an idea where coredump.c is supposed to be
initializing these pages?
Maybe there are some inline assembly functions involved in copying the data=
?
