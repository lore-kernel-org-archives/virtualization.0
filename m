Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04E679D8
	for <virtualization@lists.linux.dev>; Mon,  5 Feb 2024 01:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707097554; cv=none; b=UFVYaOzA5eFprzZxUQgBlp0d5hnCY9fZVR9DNasMfNPqhNrCKMA15mgzg369EDA/C6JxvH5Kw8NRtVu7tzAcGk49bqNYn/qInQwDBhJ7+6+yOKlT7fmisd3DbUSEC2eLdl2zVYtTaCMjPNSjLts31TvyJQJhWH5WjEsayDj68KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707097554; c=relaxed/simple;
	bh=4QdQrnzQ2JRP8hTKJjhWdv85RFCeS5uR+yrlWviTv1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZFFfd46krdf1R5Ghw90PjDLLPL0S5iH1780nwM2WQJM6H3LiSdPjmBlEzDAfzFrvM6QHsepb0DkQopt2T4S5OAllJyH9ddhg1omN4t8UvJCPLbuEm49zBr7AkPj+hcF62c21iKEBvXoycgdpql5w4faPCE0NsG6EWt5jp9fL8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a2F4ZDWO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2F4ZDWO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707097551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4QdQrnzQ2JRP8hTKJjhWdv85RFCeS5uR+yrlWviTv1M=;
	b=a2F4ZDWO0hnlp50AUbJ0XckLylFUgTUhXoBjdKbfTmtIxNRyRlW3Auo4iS60rnT89ktOEo
	5Os2pmtqp6vFwE74mNIoxs6Dr1njLxi9I+FkF9Lm3bZr4CjGHVNlXljoW5wPbYtcGouCUH
	yvnFXIGLp0oIgoB6w9BygRol3lk+5lw=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-3RYzze4YNf6eTKpbxr3Ciw-1; Sun, 04 Feb 2024 20:45:50 -0500
X-MC-Unique: 3RYzze4YNf6eTKpbxr3Ciw-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-59a2129fe88so5908919eaf.3
        for <virtualization@lists.linux.dev>; Sun, 04 Feb 2024 17:45:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707097549; x=1707702349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4QdQrnzQ2JRP8hTKJjhWdv85RFCeS5uR+yrlWviTv1M=;
        b=ilvCkIJqhJBMNQwWbBwyl4DayA+TY6IsUz7vXBrL8omlpQxefPGsCSzCln2zWb48fY
         P8NetoWa0xT/UWiMQ+XnphRDk2o6uVB7aLjr+j1UL/62EDJKE1zSX351YeVqy2Y959MF
         fTw97ljt7d/2tr2aSGb0xXo86RP3wQpiaOsURIDp6PhWQzJ7pBzaTWl34vxpu304IEkn
         B0c+wfScaW3xgLW1zX2XzJlE9A06Wly4fpn6y1VEJhHpgNYy6G4OrkdIn8O9l//BhYQJ
         weRR6ACAqBt8xSb1BK+U55zPLDXauLFskahIgUmbft+GbHM3xHZWMlHr8YetDOtiYymo
         oAGw==
X-Gm-Message-State: AOJu0YythDQAHNYKmf6GDoByZOfIsqm0CInHmqPILqkOuyDScqpf7Ve0
	PrgJ7+LlPpYgEvke2sJR3m2m4AyLLmbPjzTLBtNW3/g+iNe88CPq3bpv6/sY/qfkXvjQDGUG0Nc
	loyO7aZRJiPxTeRKikymJUQTNn2RA0McHriakPiwiLwk8f7iyFnv6oR/72o0/Hhl/iLx3GBODEj
	FGfyDzS59gHtR6IX+TIAHTJcq22hMYmDv2E9pWAgw=
X-Received: by 2002:a05:6358:9da3:b0:175:f2c1:d649 with SMTP id d35-20020a0563589da300b00175f2c1d649mr7242993rwo.25.1707097549643;
        Sun, 04 Feb 2024 17:45:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqwyvJvpBl6E8NjHMKDiFV4avhR9M89w/d2RoFIpIA/tCKv9Hl3Qunp/+IitCo0r5OKTucW3sRCFoRIPIOxeU=
X-Received: by 2002:a05:6358:9da3:b0:175:f2c1:d649 with SMTP id
 d35-20020a0563589da300b00175f2c1d649mr7242977rwo.25.1707097549374; Sun, 04
 Feb 2024 17:45:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CH0PR12MB85809CB7678CADCC892B2259C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <20240130104107-mutt-send-email-mst@kernel.org> <CH0PR12MB8580CCF10308B9935810C21DC97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <20240130105246-mutt-send-email-mst@kernel.org> <CH0PR12MB858067B9DB6BCEE10519F957C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <CAL+tcoCsT6UJ=2zxL-=0n7sQ2vPC5ybnQk9bGhF6PexZN=-29Q@mail.gmail.com>
 <20240201202106.25d6dc93@kernel.org> <CAL+tcoCs6x7=rBj50g2cMjwLjLOKs9xy1ZZBwSQs8bLfzm=B7Q@mail.gmail.com>
 <20240202080126.72598eef@kernel.org> <CACGkMEu0x9zr09DChJtnTP4R-Tot=5gAYb3Tx2V1EMbEk3oEGw@mail.gmail.com>
 <20240204070920-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240204070920-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 5 Feb 2024 09:45:38 +0800
Message-ID: <CACGkMEsphvgtvaFFob3OjJ-UuuDEVgqyg3pahaGvGZkAsioAFg@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio_net: Add TX stop and wake counters
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>, 
	Daniel Jurgens <danielj@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"abeni@redhat.com" <abeni@redhat.com>, Parav Pandit <parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 4, 2024 at 8:39=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Sun, Feb 04, 2024 at 09:20:18AM +0800, Jason Wang wrote:
> > On Sat, Feb 3, 2024 at 12:01=E2=80=AFAM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > >
> > > On Fri, 2 Feb 2024 14:52:59 +0800 Jason Xing wrote:
> > > > > Can you say more? I'm curious what's your use case.
> > > >
> > > > I'm not working at Nvidia, so my point of view may differ from thei=
rs.
> > > > From what I can tell is that those two counters help me narrow down
> > > > the range if I have to diagnose/debug some issues.
> > >
> > > right, i'm asking to collect useful debugging tricks, nothing against
> > > the patch itself :)
> > >
> > > > 1) I sometimes notice that if some irq is held too long (say, one
> > > > simple case: output of printk printed to the console), those two
> > > > counters can reflect the issue.
> > > > 2) Similarly in virtio net, recently I traced such counters the
> > > > current kernel does not have and it turned out that one of the outp=
ut
> > > > queues in the backend behaves badly.
> > > > ...
> > > >
> > > > Stop/wake queue counters may not show directly the root cause of th=
e
> > > > issue, but help us 'guess' to some extent.
> > >
> > > I'm surprised you say you can detect stall-related issues with this.
> > > I guess virtio doesn't have BQL support, which makes it special.
> >
> > Yes, virtio-net has a legacy orphan mode, this is something that needs
> > to be dropped in the future. This would make BQL much more easier to
> > be implemented.
>
>
> It's not that we can't implement BQL,

Well, I don't say we can't, I say it's not easy as we need to deal
with the switching between two modes[1]. If we just have one mode like
TX interrupt, we don't need to care about that.

> it's that it does not seem to
> be benefitial - has been discussed many times.

Virtio doesn't differ from other NIC too much, for example gve supports bql=
.

1) There's no numbers in [1]
2) We only benchmark vhost-net but not others, for example, vhost-user
and hardware implementations
3) We don't have interrupt coalescing in 2018 but now we have with DIM

Thanks

[1] https://lore.kernel.org/netdev/20181205225323.12555-1-mst@redhat.com/


>
> > > Normal HW drivers with BQL almost never stop the queue by themselves.
> > > I mean - if they do, and BQL is active, then the system is probably
> > > misconfigured (queue is too short). This is what we use at Meta to
> > > detect stalls in drivers with BQL:
> > >
> > > https://lore.kernel.org/all/20240131102150.728960-3-leitao@debian.org=
/
> > >
> > > Daniel, I think this may be a good enough excuse to add per-queue sta=
ts
> > > to the netdev genl family, if you're up for that. LMK if you want mor=
e
> > > info, otherwise I guess ethtool -S is fine for now.
> > >
> >
> > Thanks
>

