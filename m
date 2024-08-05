Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED0514386C;
	Mon,  5 Aug 2024 06:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722839974; cv=none; b=R5xcCYkJZ9JZUXM5g6F70A0KwavcfbB+ahOLN2c0v6h05JU4ZsiTkUCFzs4jCgCI7NPWV/8KAqZg1SZIRXEzUyfTVHxiSFrR34L58wSShjC3PmddRXoCkBhM01PJlUdAPZ2n524oXehI14rENTyAgF/Tq3Hsw/M55zggs4vujas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722839974; c=relaxed/simple;
	bh=Hp+akOIA5r7pKUvBUtgBx9Zv5qT2Ir2O//4P0GbFEq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kOkJKUxkfvMf9eLnhZ94vUYFBB8IM6fYwMWH1tKNpeyK3QYfW1xZ0banMzTRCAWhe4DXus9eQjp4abQYru+u7PbBTy3ukPjZujuW2iJactVc19XPNWu8+Y8CfAx1ydJB/mDbgaJaLSU6z4INn+vNHu0qnd8Ln4WQ+gmEOrR4bwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0PQOh02; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0PQOh02"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7a9185e1c0so931187966b.1;
        Sun, 04 Aug 2024 23:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722839971; x=1723444771; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hp+akOIA5r7pKUvBUtgBx9Zv5qT2Ir2O//4P0GbFEq0=;
        b=V0PQOh02FVSHRHUCeWbDuciiniOe+O3RkctV0QJ/9emsrqjco7EVqbS+ltdjneNLcQ
         Lp3SA5k+7cy79RRbWqb95yzEbaHVyYf/ZyINK4hMQ55i7ra0ZFKj5Iu0bBYFcGAhb4lS
         ixhc/MZ15jbG5Rt5InmaEo5+qvy3w06Ja8bL58dZ2XQ59D/vqM+bU84z7UCXUU1nNVvN
         Megokx0KaCxdXi0crOlYjGIC89RoheSE8hoW6e+qfa5JTHXM/SGrNJRjXWRMRspr9n/q
         ZMUdPDCd0me6K2qu1zerNZYzJO9IzbFCrIxQophFd7RJzlnpRJjMjnAnEtXu7fbR90go
         atBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722839971; x=1723444771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hp+akOIA5r7pKUvBUtgBx9Zv5qT2Ir2O//4P0GbFEq0=;
        b=Lae5vaGP6DjL6EC1tunJJB45maC/9iLkbyBFouUS48RELovsK6KlZp2Gmmf//7k5mJ
         pD4nAStD8iXWPD+wsl95QE7IpPMhhwB0cwvBh/AcgW1IBS8fpD4jbWLjonJwLGcmU/S8
         399RxrBDcxJ/tOuzmDt8MZyc7PhPnu4+LpB/3/1QBhMEdQR3+1i4vf+Gt42iBrVPM5Ix
         v/i2rR32nBfjmh6p+/bpMQgBrHxjOzDgljOaWuHLiHiSpHqIbAkWWrwzhLv3Fo64UhWD
         Yx3CTSXd1VQh1FZU1PWepic7hMtm5apVR6FKgqoWRZX+ETopy8fSdVuxiiliB51Ysbk0
         jGdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUm92WUzHD/30yzqmGf1TmS3TxDjugNN3hnxw+5N9BZiHQ+Eg/V34esIeYcYkRr+aiW1cXVCKTge1U6lowGks=@lists.linux.dev, AJvYcCUhG75ensYcbfPy/Gj+rLGCyHXf3C4mw28kCeXU3iRHvzK3w2fyljWkYQqRt/dgtfPJJ7RbOwuZ0BogQg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwLASgsEu5CLer3mIZnrMTFlHmTX+i/zYId4qJ5to7ED3bByCiL
	QJ7Z1/G+Qg20SIRf37U4okMdPKbcUHvqH12mLIuBGjxqjzvTyZF7SzRSdl9VZLdu96HUz/4edc3
	t7qyhw4PZdddIqdE8zq+AW61vBFk=
X-Google-Smtp-Source: AGHT+IHZKPc6hfq2+btXaQ5oS/nApElkaZfbe6yjBvGYeX2+PIMlwiIHY20xhepwtJAtoPF5hDV6P/eLwPk4IsLmXpU=
X-Received: by 2002:a17:907:60cd:b0:a7d:c46b:2241 with SMTP id
 a640c23a62f3a-a7dc4fae424mr899245066b.29.1722839970855; Sun, 04 Aug 2024
 23:39:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAGRfhukVR4V9GFmdV71QfM2OLW3G=BQoOM1U1cK0ENFZvLTLyw@mail.gmail.com>
 <CACGkMEvpB0zP+okrst-_mAxKq2eVwpdxQ5WTA07FBzRrs3uGaA@mail.gmail.com>
In-Reply-To: <CACGkMEvpB0zP+okrst-_mAxKq2eVwpdxQ5WTA07FBzRrs3uGaA@mail.gmail.com>
From: Blake Sperling <breakingspell@gmail.com>
Date: Mon, 5 Aug 2024 01:38:54 -0500
Message-ID: <CAGRfhukK6CWpyViK-O67OCXu9=7SGnOwSg=Lv91jum8dF-RKKg@mail.gmail.com>
Subject: Re: [REGRESSION] [PATCH v2] net: missing check virtio
To: Jason Wang <jasowang@redhat.com>
Cc: arefev@swemel.ru, edumazet@google.com, eperezma@redhat.com, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, mst@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com, stable@vger.kernel.org, 
	regressions@lists.linux.dev, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jason,

Willem's patch works, right on the mark. Confirmed the guest
performance is back to normal.

Thanks, and sorry for the noise!

On Mon, Aug 5, 2024 at 1:17=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Mon, Aug 5, 2024 at 2:10=E2=80=AFPM Blake Sperling <breakingspell@gmai=
l.com> wrote:
> >
> > Hello, I noticed a regression from v.6.6.43 to v6.6.44 caused by this c=
ommit.
> >
> > When using virtio NIC with a QEMU/KVM Windows guest, network traffic fr=
om the VM stalls in the outbound (upload) direction.This affects remote acc=
ess and file shares most noticeably, and the inbound (download) direction d=
oes not have the issue.
> >
> > iperf3 will show consistent results, 0 bytes/sec when initiating a test=
 within the guest to a server on LAN, and reverse will be full speed. Nothi=
ng out of the ordinary in host dmesg or guest Event Viewer while the behavi=
or is being displayed.
> >
> > Crucially, this only seems to affect Windows guests, Ubuntu guest with =
the same NIC configuration tests fine both directions.
> > I wonder if NetKVM guest drivers may be related, the current latest ver=
sion of the drivers (v248) did not make a difference, but it is several mon=
ths old.
> >
> > Let me know if there are any further tests or info I can provide, thank=
s!
>
> Does Willem's patch fix the issue?
>
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=
=3D89add40066f9ed9abe5f7f886fe5789ff7e0c50e
>
> Thanks
>


--=20

-Blake Sperling
