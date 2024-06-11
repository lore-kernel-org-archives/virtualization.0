Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FD1134BC
	for <virtualization@lists.linux.dev>; Tue, 11 Jun 2024 02:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718071584; cv=none; b=B/ixcPo8moJbUOok1H1cLHUVkDTgyPX26l/44vOSup58oZc5eEwvW3YIy1+4y1dTQtq75vc1EoVNluaFaA33EEASBAeHt6NLV2mqv92d6Omt/2LsBdaCvfdAEfyJ9Y/EpdXhieYR2CUHVGdwzvB5plIRFzW0Z9AhXbA74V+Pj88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718071584; c=relaxed/simple;
	bh=tuff/6OuEt+2hme3SS1LRX+ueYVQOYk0iMP38yw56OQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kSy9vN95UqzhM9UoyPFFvnQ5H1O+aWTiSPOcEBe7kvRuiivRmxUYXfwJODFJ/EnRfyReyBq8EU4HIYWNSQdWjlJjw296U82qfH7eJwfetVvxuKWhMgV1eWzTT2MsZFJbd6igjfEEEiUGSjSZsTSML9rJhp0qrY/A4lnkLeRJL+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YV+QPo6P; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YV+QPo6P"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a68b41ef3f6so560105266b.1
        for <virtualization@lists.linux.dev>; Mon, 10 Jun 2024 19:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718071581; x=1718676381; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tuff/6OuEt+2hme3SS1LRX+ueYVQOYk0iMP38yw56OQ=;
        b=YV+QPo6PHTRb3HO0w5AeYUOYIHKrm9+ayBwhJjRTfTJ164OBzuTx4XJv9Ab3b3Kmb9
         tS52zHplX2VYJ/7N5WjPrUyXebZRHLaUyltmQzlMu7g4MJgLE/rPOcT4wyLKVNo24zcx
         HBcq3KYraK9rMCvt4H0D7fbX6f6pNBtmjixzJlCAv38b9df7ntWZDAcnDt5/w2tmzuiB
         NxcWYPCyWLVwpi+p668MVXm/7V3AW0yM/fSQcC0K0d2Pfzpi7OeGOcB6vjwykH26jU7r
         C/PpTIt4sx9PmS/EJ+1f4hZCRhoMNDe+eQBHEMMUFE/WRmyPugQ9btBcEZ6MC2K2w1xM
         s0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718071581; x=1718676381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tuff/6OuEt+2hme3SS1LRX+ueYVQOYk0iMP38yw56OQ=;
        b=cPz5S3hSUIWSAyn8Q8W7kJFknLnxCv7LArFoDcVx2rCTnzwevb/O+EZrpPRyHE9ukG
         O9bGxunQ+MrHnF08i8DCDoexQMIOB92TuJpHY6S1pOHH3ueuyYPueTrIcN8bP1GZ3ItB
         tpf3W7sWa54BsWS6Ns7ZAPk5Xc/35hfs8oH6jXiXskDkGChQD2oQwnH9OjuxOz8IbveO
         lB05/iYZzoHND7pNgbfLsfBSscyUoocbz/EYe3sd8i3G/A1vUkKL8ONar7l3c3TiwJ9x
         u0kn54erJsWs+PH2iSSw+gcc2iQovYcSahuZcpKhUrqy26ZUSH6+XzfhZdE529z7gdCH
         3hRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNEiRyXexB0BfuOihXKljq5jJDdJ5FXBGh5i2YTIrwPx3OWapExtsEdpKr16T6ajxqpLddxme9KoXjIN93k5lUJdMBMqrbQtnj0o/oEys=
X-Gm-Message-State: AOJu0Yz5P+W7PFYrGauQoSkJvGESTCA3j9efkQPVHM/vX2Y2P8/3XGFG
	cZGr6RmJysEUrJ92gKgrMa1faxfWjMH6smYRTBCumclHNwgd0cqXPYTcBOna22XdQli3LmlK3+a
	Lq+TgbaUyCFwaSdMQstS0qL267jQ=
X-Google-Smtp-Source: AGHT+IHJ8AjC2nQdCHkvEIiAg5SYB3Vy4VBsSouM+tmUNPm4sUIJZMgWBTWyiI1mjy8d9yBV3+j6xZozdhfUDe7nhgY=
X-Received: by 2002:a17:907:7f87:b0:a6f:20af:49cb with SMTP id
 a640c23a62f3a-a6f20af4f9dmr298552066b.48.1718071580627; Mon, 10 Jun 2024
 19:06:20 -0700 (PDT)
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
 <CAL+tcoBXB97rCp2ghvVGkZAuC+2a4mnMnjsywRLK+nL0+n+s2A@mail.gmail.com>
 <CH0PR12MB85804D451A889448D3427132C9FB2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <CAL+tcoDkpZva=aStFKWTO6_8VK2iu9CeSeW2aeC+2QTXR2nD=Q@mail.gmail.com> <20240610105717.7fbb1caa@kernel.org>
In-Reply-To: <20240610105717.7fbb1caa@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 11 Jun 2024 10:05:41 +0800
Message-ID: <CAL+tcoB3tCw+CypLSaqcFs8CASJDCLPchQs1xcyC9eS+1hYDxQ@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio_net: Add TX stop and wake counters
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dan Jurgens <danielj@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jasowang@redhat.com" <jasowang@redhat.com>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"abeni@redhat.com" <abeni@redhat.com>, Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 1:57=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 8 Jun 2024 08:41:44 +0800 Jason Xing wrote:
> > > > Sorry to revive this thread. I wonder why not use this patch like m=
lnx driver
> > > > does instead of adding statistics into the yaml file? Are we gradua=
lly using or
> > > > adding more fields into the yaml file to replace the 'ethtool -S' c=
ommand?
> > > >
> > >
> > > It's trivial to have the stats in ethtool as well. But I noticed
> > > the stats series intentionally removed some stats from ethtool. So
> > > I didn't put it both places.
> >
> > Thank you for the reply. I thought there was some particular reason
> > :-)
>
> Yes, we don't want duplication. We have a long standing (and
> documented) policy against duplicating normal stats in custom stat
> APIs, otherwise vendors pile everything into the custom stats.

Thanks, Jakub. I see :)
