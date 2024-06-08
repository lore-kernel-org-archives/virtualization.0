Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D794F81E
	for <virtualization@lists.linux.dev>; Sat,  8 Jun 2024 00:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717807345; cv=none; b=Go16x1010xi/oA6y0WUP9KmtZOmc8BPc4QPxDXUT2IewAjG0s7HYgacsREiQEjfQ4halsR1OfUlrBtKbVLabgUZVSPw56PvDv2Q6Jta8ZsbAU5oLohfjTKZACoMbCQsS6eGpAm+erYxXJsouxirX29EtOBoHUFWmwykD5y6EM+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717807345; c=relaxed/simple;
	bh=7CdzY8u60hVre4UuCBwjSH/y9SSMvN9FtIZmohj0aa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qcrth41Bp2Uq7dPqk7SOqjj2Oj6LJ86pkjVQ5+BbnFMzFfRPBnpXysoDqBI5GEtXWTBYDJrA2XhEV08jJn1d6+QlbPSZz69/+Vmnx7m58sOYSdUgf6Jt7GxNZZgvG09Tsn1kB218ca+ASyogJPCBSVfM1gOadon/H4Dqt+BCb0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USirMeIa; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USirMeIa"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a689ad8d1f6so330971166b.2
        for <virtualization@lists.linux.dev>; Fri, 07 Jun 2024 17:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717807342; x=1718412142; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CdzY8u60hVre4UuCBwjSH/y9SSMvN9FtIZmohj0aa8=;
        b=USirMeIa444m8xsB0Ky2Y07rm3V6gVqU6/nzCoMp3gpPIrjiUk7Zf82cXYm9EbgJ1a
         LLn5X1nr3c5NSdEZSeFCHkDDPxpVoM3IQx/1r5ZAl1VNmG7RIFFIZwxH77muXAClIwwp
         HO2lJCzx8yyvwey2bzak+d7bMJhaGWFiP3q26xZcMI8spxsuo5WS8DBnT6j+PM5a5zfM
         NrHAs7bW+NtI530pUYMSlIIijQGwvpYv5+LmyuOOtIdTyAolsa+DERB3zbW7mvq+z+li
         7Gwvosy/lEbN51KCdUfER8Ha8pam1tYHR+vdP1OhPNQ8cSMSv1ZeMOuV3OFSxzwj/pcc
         HZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717807342; x=1718412142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7CdzY8u60hVre4UuCBwjSH/y9SSMvN9FtIZmohj0aa8=;
        b=pnv0abeBQq0eZ0Nm9TjXlyloYDWgT5gBTZL+z8GTFuVD+czQ9tFw8Sr7XLpylyf8E3
         pckBU7R3ZQXaOG4UwNoe4g3hiQ0D9lsNjkRrqKB/4XIwoU2GQurm11AozOk81NuK57pr
         RV+dCbGVbH8u5AT5+/C/U7a1nkAwcS5mPrw8Mrf9lE17zgYqA0ySn9+aDhZ4oDUzaIbH
         yUuIfLMT/BfP0EnrHT6w7mSvWwvAwBbEMwqY5FmKnZRKm58MEuoMdjT3xX9DIDThpfA5
         WO0EC54WnuDfaj7+FVbNyulj5oBachgUeHXUvvGDr0MxR2S0vaDyKrMxsT73mxw+xCcU
         UiXA==
X-Forwarded-Encrypted: i=1; AJvYcCWdVAIiIxyu72cAjCCyQvXLClvk+72YAvGhZM7S9cRv76jSon094J5YvOOqMbWMuAkAKceNKuqZYv5s5E0tSRGpsG6uz/g6o4VkIM4lRGo=
X-Gm-Message-State: AOJu0Yw2q4B5C0We5KmZGRTAV5Ov8G7P1rAGVLQlWsJMuBJD1gyMzK8x
	YZWea7WIlMBLlLUkQ/YYcsJC9yc0/qrsW3YII0KOYHQqY1Ofce6BHorV7KftJj4LoSjqbnnogVX
	HPO33YJeUjtgAp3s5HEWrlg1/g7Zr9g==
X-Google-Smtp-Source: AGHT+IEHWIDAolb0vOIBfsYcRRrGiN8TUODMF8KNwk7mL5ys88vHxhm2QSUBT863nTuguHxrsKwWwyX1lfIQk5ot9Ts=
X-Received: by 2002:a17:907:3584:b0:a68:90d5:1580 with SMTP id
 a640c23a62f3a-a6cd7a884demr255657066b.46.1717807341921; Fri, 07 Jun 2024
 17:42:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240130142521.18593-1-danielj@nvidia.com> <20240130095645-mutt-send-email-mst@kernel.org>
 <CH0PR12MB85809CB7678CADCC892B2259C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <20240130104107-mutt-send-email-mst@kernel.org> <CH0PR12MB8580CCF10308B9935810C21DC97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <20240130105246-mutt-send-email-mst@kernel.org> <CH0PR12MB858067B9DB6BCEE10519F957C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <CAL+tcoCsT6UJ=2zxL-=0n7sQ2vPC5ybnQk9bGhF6PexZN=-29Q@mail.gmail.com>
 <20240201202106.25d6dc93@kernel.org> <CAL+tcoCs6x7=rBj50g2cMjwLjLOKs9xy1ZZBwSQs8bLfzm=B7Q@mail.gmail.com>
 <20240202080126.72598eef@kernel.org> <CH0PR12MB858044D0E5AB3AC651AE0987C9422@CH0PR12MB8580.namprd12.prod.outlook.com>
 <CAL+tcoBXB97rCp2ghvVGkZAuC+2a4mnMnjsywRLK+nL0+n+s2A@mail.gmail.com> <CH0PR12MB85804D451A889448D3427132C9FB2@CH0PR12MB8580.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB85804D451A889448D3427132C9FB2@CH0PR12MB8580.namprd12.prod.outlook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 8 Jun 2024 08:41:44 +0800
Message-ID: <CAL+tcoDkpZva=aStFKWTO6_8VK2iu9CeSeW2aeC+2QTXR2nD=Q@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio_net: Add TX stop and wake counters
To: Dan Jurgens <danielj@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jasowang@redhat.com" <jasowang@redhat.com>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"abeni@redhat.com" <abeni@redhat.com>, Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 8:37=E2=80=AFPM Dan Jurgens <danielj@nvidia.com> wro=
te:
>
> > From: Jason Xing <kerneljasonxing@gmail.com>
> > Sent: Friday, June 7, 2024 4:16 AM
> > To: Dan Jurgens <danielj@nvidia.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>; Michael S. Tsirkin <mst@redhat.co=
m>;
> > netdev@vger.kernel.org; jasowang@redhat.com;
> > xuanzhuo@linux.alibaba.com; virtualization@lists.linux.dev;
> > davem@davemloft.net; edumazet@google.com; abeni@redhat.com; Parav
> > Pandit <parav@nvidia.com>
> > Subject: Re: [PATCH net-next] virtio_net: Add TX stop and wake counters
> >
> > On Sat, Feb 3, 2024 at 12:46=E2=80=AFAM Daniel Jurgens <danielj@nvidia.=
com> wrote:
> > >
> > > > From: Jakub Kicinski <kuba@kernel.org>
> > > > Sent: Friday, February 2, 2024 10:01 AM
> > > > Subject: Re: [PATCH net-next] virtio_net: Add TX stop and wake
> > > > counters
> > > >
> > > > On Fri, 2 Feb 2024 14:52:59 +0800 Jason Xing wrote:
> > > > > > Can you say more? I'm curious what's your use case.
> > > > >
> > > > > I'm not working at Nvidia, so my point of view may differ from th=
eirs.
> > > > > From what I can tell is that those two counters help me narrow
> > > > > down the range if I have to diagnose/debug some issues.
> > > >
> > > > right, i'm asking to collect useful debugging tricks, nothing
> > > > against the patch itself :)
> > > >
> > > > > 1) I sometimes notice that if some irq is held too long (say, one
> > > > > simple case: output of printk printed to the console), those two
> > > > > counters can reflect the issue.
> > > > > 2) Similarly in virtio net, recently I traced such counters the
> > > > > current kernel does not have and it turned out that one of the
> > > > > output queues in the backend behaves badly.
> > > > > ...
> > > > >
> > > > > Stop/wake queue counters may not show directly the root cause of
> > > > > the issue, but help us 'guess' to some extent.
> > > >
> > > > I'm surprised you say you can detect stall-related issues with this=
.
> > > > I guess virtio doesn't have BQL support, which makes it special.
> > > > Normal HW drivers with BQL almost never stop the queue by themselve=
s.
> > > > I mean - if they do, and BQL is active, then the system is probably
> > > > misconfigured (queue is too short). This is what we use at Meta to
> > > > detect stalls in drivers with BQL:
> > > >
> > > > https://lore.kernel.org/all/20240131102150.728960-3-leitao@debian.o=
r
> > > > g/
> > > >
> > > > Daniel, I think this may be a good enough excuse to add per-queue
> > > > stats to the netdev genl family, if you're up for that. LMK if you
> > > > want more info, otherwise I guess ethtool -S is fine for now.
> > >
> > > For now, I would like to go with ethtool -S. But I can take on the ne=
tdev
> > level as a background task. Are you suggesting adding them to
> > rtnl_link_stats64?
> >
> > Hello Daniel, Jakub,
> >
> > Sorry to revive this thread. I wonder why not use this patch like mlnx =
driver
> > does instead of adding statistics into the yaml file? Are we gradually =
using or
> > adding more fields into the yaml file to replace the 'ethtool -S' comma=
nd?
> >
>
> It's trivial to have the stats in ethtool as well. But I noticed the stat=
s series intentionally removed some stats from ethtool. So I didn't put it =
both places.

Thank you for the reply. I thought there was some particular reason :-)
