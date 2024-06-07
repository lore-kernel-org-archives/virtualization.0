Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A886215B125
	for <virtualization@lists.linux.dev>; Fri,  7 Jun 2024 09:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717751806; cv=none; b=AkvsBscusrM2M2LGpWQXJsu4yglJm5+Vwse9qMAv3X3ryxknxcw/BFF+EhTVGvQ/PVZq+fqpmlQC+RWGjQppyOoIXNECKaKD/asrLlqxkel/T7BVuzjK0iXgAEZUq+WqT0Ef9c2/lxjp72AP3PCiAaYg+eqsvdv6FUEbJlItyXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717751806; c=relaxed/simple;
	bh=QzOHaJ+VpQtbU98T3t6z1j5z/fDMO7o6RSHzV4knFvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ETr+604DAuYARzUIy5AcipjTOBoEdCw8gGMamuwryG+JLJr5juoSR+nDIaz9XcVBOpx5auDDye4PYNT4A3kKnRRFPIC5xDyVxCU+PFdPkKUagkto5xMDQYj4Fq7JCJHeF15Y8tBgwFVgv04wNaLlmdnep9FBLLeC2FpHGm+o10w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GuFmQlhf; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuFmQlhf"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6266ffdba8so175696866b.1
        for <virtualization@lists.linux.dev>; Fri, 07 Jun 2024 02:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717751803; x=1718356603; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzOHaJ+VpQtbU98T3t6z1j5z/fDMO7o6RSHzV4knFvs=;
        b=GuFmQlhf664/uI4xaDr8xzT+glMDwXct+78wmM5X4rZ7FU/GzxZV+p0k1VcOKuoUoJ
         GsOhMvHIxNm6kTdlsVwthLyNrr/nlZxMrZQubFV0Cgz3d5+Tjl+SN9YvOBASO6RjDniV
         +L8tnoLee7aUFjB7dyb/G0PWk7Ze0/gK8S/PewElJVIhhGpGffXCqAmVFAdkyetzZydl
         dSYFuPb4/rgl5w0QLgs+R+MmzvL4f2SFj6mJv/HoVn9T1fPhH9FXfAfvdq3JVK1YBqO6
         dY9UiwgDxXfCPgIqHAJartUXbF117ci4Dz5gRfwinVRcZrmGyliX3XnC2MsRibHVBj/c
         R3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717751803; x=1718356603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QzOHaJ+VpQtbU98T3t6z1j5z/fDMO7o6RSHzV4knFvs=;
        b=OkH2x84LUVAVWVpR+O60fNvEaCOqpjGdG2g3xZJTSiHN5R4t2GkjgCZsl8Bp/Ngfp8
         Sp8QpkLgh5yF9uv3CndudQyuU63H1eO82deed3ZaHKMssI1FfYhXLfm2erSQt7EHM/0b
         iraNjQ968YtSh+J5dW8sXOkxR+qTCmbppenYJ75nQyjSBiaVEuqq1GA4C+8g2CD7HnVq
         tuRR6pLel3sZ7zWai1Ey8CUEpKMsoeugbVnKyA6ZnVkBN3UIvC/cjUy3bFaygqj/mzn4
         6GEQUAyb9La1XuGd8nOKseLrUgHbO2WS+duePQvqFpVeTw5kS3Se3j/fcZ6op65JegCX
         +bVA==
X-Forwarded-Encrypted: i=1; AJvYcCVc7EqlNTjTfgrHXdvwDf1RXtqlTT/+Rx5O3iKU1kyd1XvIjHhxP9cWMxGcWO0oRun10ME5I0GtN1wqIL7ZYKGYX6HCtlyPef483kcP01Y=
X-Gm-Message-State: AOJu0Ywcy6dTTI0FLcwJ2MYIbSQZYrqYIDMHR+b/T2ImqRqF0R4wtq5J
	4SKk6D6ygTqVWA9WUMDuVDVLQ3ESksuzL6V9tB6WfZ4OCX9qpjQdXKuj5tR5nvM6g3urg9m6hab
	1EYRIRc5WiBSUgtkYRn98ynmxW6s=
X-Google-Smtp-Source: AGHT+IHoguKxRM7exkyMVrRtyhDuFXR6LPgRouKgmIvnNKxWFlca3whZ14HFA5//zRqMaFuM1JDi7nmgTPLIYsEFH00=
X-Received: by 2002:a17:907:6ea6:b0:a68:f83b:22fa with SMTP id
 a640c23a62f3a-a6cd5613cfdmr157790966b.11.1717751802811; Fri, 07 Jun 2024
 02:16:42 -0700 (PDT)
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
In-Reply-To: <CH0PR12MB858044D0E5AB3AC651AE0987C9422@CH0PR12MB8580.namprd12.prod.outlook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 7 Jun 2024 17:16:05 +0800
Message-ID: <CAL+tcoBXB97rCp2ghvVGkZAuC+2a4mnMnjsywRLK+nL0+n+s2A@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio_net: Add TX stop and wake counters
To: Daniel Jurgens <danielj@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jasowang@redhat.com" <jasowang@redhat.com>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"abeni@redhat.com" <abeni@redhat.com>, Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 3, 2024 at 12:46=E2=80=AFAM Daniel Jurgens <danielj@nvidia.com>=
 wrote:
>
> > From: Jakub Kicinski <kuba@kernel.org>
> > Sent: Friday, February 2, 2024 10:01 AM
> > Subject: Re: [PATCH net-next] virtio_net: Add TX stop and wake counters
> >
> > On Fri, 2 Feb 2024 14:52:59 +0800 Jason Xing wrote:
> > > > Can you say more? I'm curious what's your use case.
> > >
> > > I'm not working at Nvidia, so my point of view may differ from theirs=
.
> > > From what I can tell is that those two counters help me narrow down
> > > the range if I have to diagnose/debug some issues.
> >
> > right, i'm asking to collect useful debugging tricks, nothing against t=
he patch
> > itself :)
> >
> > > 1) I sometimes notice that if some irq is held too long (say, one
> > > simple case: output of printk printed to the console), those two
> > > counters can reflect the issue.
> > > 2) Similarly in virtio net, recently I traced such counters the
> > > current kernel does not have and it turned out that one of the output
> > > queues in the backend behaves badly.
> > > ...
> > >
> > > Stop/wake queue counters may not show directly the root cause of the
> > > issue, but help us 'guess' to some extent.
> >
> > I'm surprised you say you can detect stall-related issues with this.
> > I guess virtio doesn't have BQL support, which makes it special.
> > Normal HW drivers with BQL almost never stop the queue by themselves.
> > I mean - if they do, and BQL is active, then the system is probably
> > misconfigured (queue is too short). This is what we use at Meta to dete=
ct
> > stalls in drivers with BQL:
> >
> > https://lore.kernel.org/all/20240131102150.728960-3-leitao@debian.org/
> >
> > Daniel, I think this may be a good enough excuse to add per-queue stats=
 to
> > the netdev genl family, if you're up for that. LMK if you want more inf=
o,
> > otherwise I guess ethtool -S is fine for now.
>
> For now, I would like to go with ethtool -S. But I can take on the netdev=
 level as a background task. Are you suggesting adding them to rtnl_link_st=
ats64?

Hello Daniel, Jakub,

Sorry to revive this thread. I wonder why not use this patch like mlnx
driver does instead of adding statistics into the yaml file? Are we
gradually using or adding more fields into the yaml file to replace
the 'ethtool -S' command?

Thanks,
Jason
