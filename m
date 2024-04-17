Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6F247F48
	for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 04:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713328580; cv=none; b=QKxfJ5oG+q+mdeecJQeMOHcAmyftkDL6LPU5QgIGnWxZJM6Jy07I4M5UA63xZRjsYJaLpxyKdw7ywljki/iWXzUZGgMUh2scqhrkD9dj+/wJASUNN8Ej+JlpDsJ6rK/fmoCaNh+qC4Q87PbJmQlfS6QfXHZdclEhn53iaSnFBWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713328580; c=relaxed/simple;
	bh=07AmZo3EeffGWAJRhafnqkERI9t97s5fvtC2DEmMUtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N7XzS3M4MpgU85mdy+ShXnf036VVpr4MSsvByrIlMzfalXlM7ZKAs+Hl9CDVEM+jo3mojEMY8sNsvwIXlJVwGUOb/tyv6VOrWbI+KgQsq6Lix/RZm41x1xVbT/v5yByOdFB0C5nHQsK1Obl8d6t9EWbGeHGRl7Nj28siY5P2ULA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XAKQ2TKY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XAKQ2TKY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713328577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IqKFHdI2odwaw7PHtETZldCfD0Dqi9Slkq7HCXLMMmM=;
	b=XAKQ2TKYdG3HsQp+3ukjHHdqmi/h9MJx2KPgEvqEg7O+so+dKnGOyy1KtI1cAL8Z9GGjyf
	x1HX51CJiNAvg1TCS/tXrZR3hImy1p1O40NfCPSZWpTAN0n99BVXgWtHkIxF6Y9TpevqA1
	srl/hvqY73mfLbPuImmp3wirDbQ0o+g=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-usfaK7YEMdSbAZasvUisLg-1; Wed, 17 Apr 2024 00:36:15 -0400
X-MC-Unique: usfaK7YEMdSbAZasvUisLg-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6ef9edf9910so4496748b3a.1
        for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 21:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713328575; x=1713933375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IqKFHdI2odwaw7PHtETZldCfD0Dqi9Slkq7HCXLMMmM=;
        b=eAES2o4iihYinFiN6Ee1B5tKgJfgDOfFzrQ8MIT1Up0hnuLsZc85N+AMekukgX0JXw
         t6EhplA5EVLZbr2O3z/aO1vkp6TcLscWG0o1YeoyRcz9ewTYY9Dm5/c6FPJI1uc1G5N7
         M08U9UTFEaGQ7MiI1CVm9fpNmVhaPRtuy5zEHDIwmnAlM/eLtXg6LZtQhOPja9hgjD7W
         hII/p/QNuUTlxZ6M0A2MndjsT3qWbhGP/5f/qHc7tanKGpr9Cf4QDHWQIkTpgSkFUB5n
         4ls1EiR3UoJcNswqiIrrvAFpg+fWwE1w6l/v2MrH5yfWjnlHxKvx/xFUCYQvFhEHVmji
         hZjw==
X-Forwarded-Encrypted: i=1; AJvYcCWkYK97UWJlT1WbMdHfvZtqc2vMSjw2EVyAeUUnlx2ajr45vTQWZ7ARhiCcAx1YoqxPZwMQQmyGqRQ2CdCH0LWkwfMozNi/2N0597ASSIE=
X-Gm-Message-State: AOJu0YxZvctdGPlop1QhfNK0tiQUduDKaLc9/3gDMW+9YuNoD5OodOEZ
	H+l+mp3aSzwTXqRKQtY9OAOBFBFnLtbxHfkbsJDeN1B08Ex10UumQ7bWWmjmATEnK+ZH+3p7J3z
	ek3Dv0IGoz/pVVz/6RE3KThcsxHZXcvXNKlwSAfAWtv1+mUWQtAuJ8op7URqlNJYTqeC/bk4R85
	N3ujEf/LwqtG6tK+nJ7gYSD0T41LcT5+uR0xfINuY=
X-Received: by 2002:a05:6a21:3996:b0:1aa:2285:2cd0 with SMTP id ad22-20020a056a21399600b001aa22852cd0mr8664712pzc.23.1713328574823;
        Tue, 16 Apr 2024 21:36:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEthYd/NR7I6LztjY+R/ZunydFmwxQEGRLNW/tO7Y1pLsWdaDy6vNPLnV0mjO0aqBq4fAhomkkRrDH7gafDGrA=
X-Received: by 2002:a05:6a21:3996:b0:1aa:2285:2cd0 with SMTP id
 ad22-20020a056a21399600b001aa22852cd0mr8664694pzc.23.1713328574549; Tue, 16
 Apr 2024 21:36:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240412151314.3365034-1-jiri@resnulli.us> <20240412180428.35b83923@kernel.org>
 <ZhqHadH3G5kfGO8H@nanopsycho> <20240415102659.7f72ae8d@kernel.org>
 <Zh5Kn5OnDdzgB6Rm@nanopsycho> <Zh53DaJkqxPC4_ZX@nanopsycho>
In-Reply-To: <Zh53DaJkqxPC4_ZX@nanopsycho>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 17 Apr 2024 12:36:03 +0800
Message-ID: <CACGkMEu5VDMiFQdGbkn3H82SGDB4BE1Br8SV_hjdsPxZAH=Z9A@mail.gmail.com>
Subject: Re: [patch net-next 0/6] selftests: virtio_net: introduce initial
 testing infrastructure
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com, mst@redhat.com, 
	xuanzhuo@linux.alibaba.com, shuah@kernel.org, petrm@nvidia.com, 
	liuhangbin@gmail.com, vladimir.oltean@nxp.com, bpoirier@nvidia.com, 
	idosch@nvidia.com, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 9:03=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Tue, Apr 16, 2024 at 11:53:35AM CEST, jiri@resnulli.us wrote:
> >Mon, Apr 15, 2024 at 07:26:59PM CEST, kuba@kernel.org wrote:
> >>On Sat, 13 Apr 2024 15:23:53 +0200 Jiri Pirko wrote:
> >>> That is a goal. Currently I do it with:
> >>> vng --qemu-opts=3D"-nic tap,id=3Dnd0,ifname=3Dxtap0,model=3Dvirtio-ne=
t-pci,script=3Dno,downscript=3Dno,mac=3D52:54:00:12:34:57 -nic tap,id=3Dnd1=
,ifname=3Dxtap1,model=3Dvirtio-net-pci,script=3Dno,downscript=3Dno,mac=3D52=
:54:00:12:34:58"
> >>>
> >>> and setting loop manually with tc-matchall-mirred
> >>>
> >>> Implementing virtio loop instantiation in vng is on the todo list for
> >>> this.
> >>
> >>Just to be clear - I think the loop configuration is better off outside
> >>vng. It may need SUID and such. We just need to make vng spawn the two
> >>interfaces with a less verbose syntax. --network-count 2 ?
> >
> >Well, you ask vng for network device by:
> >--net=3Duser/bridge
> >
> >Currently putting the option multiple times is ignored, but I don't see
> >why that can't work.
> >
> >Regarding the loop configuration, I would like to make this as
> >convenient for the user as possible, I was thinking about something like
> >--net=3Dloop which would create the tc-based loop.
> >
> >How to do this without root, I'm not sure. Perhaps something similar
> >like qemu-bridge-helper could be used.
>
> Ha, qemu knows how to solve this already:
>        -netdev hubport,id=3Did,hubid=3Dhubid[,netdev=3Dnd]
>               Create a hub port on the emulated hub with ID hubid.
>
>               The hubport netdev lets you connect a NIC to a QEMU emulate=
d hub
>               instead of a single netdev. Alternatively, you can also  co=
nnect
>               the  hubport to another netdev with ID nd by using the netd=
ev=3Dnd
>               option.
>
> I cooked-up a testing vng patch, so the user can pass "--net=3Dloop":
> https://github.com/arighi/virtme-ng/commit/84a26ba92c9834c09d16fc1a4dc3a6=
9c4d758236
>

Note: another way, there's a vdpa(virto)-net simulator which can only
do loopback. The advantage is that you don't even need Qemu.

Thanks

>

