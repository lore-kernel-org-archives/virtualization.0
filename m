Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB11B24467F
	for <virtualization@lists.linux.dev>; Thu, 14 Aug 2025 06:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755154164; cv=none; b=CeGyJrDzbDRY0gQcxEHPUhAlTOIzAqTq7cQlAyMPLypiHLtpJDZ6nki1s0G+HbShptdXixx934VPiAkIt0Vl7LU/Hs5fgN3dRsYhfYQ5dakl0wPRiXwtpcRl99rUhyYzyLQXCfx5Mr8xXIizgwplMKtAzMCr+BD/00hPcnYOaAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755154164; c=relaxed/simple;
	bh=LO798oR9V7f4QGUYhH0qU7QUeCyLYr6WhbregzpYOT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C9t+QtX4f0amG89yW/iEHM04cT/KVH9hkkzdnayMQMPduENxT1R6BrT5WXX5FawH3n6PltSFyl5igjd5oMNrNpWOyLbcVGhxm2SNzFnXdqetz5orZX01KXvJCoWqr8QsU2h6rUISK9LbE3tt0sGxguq3GbiGYcHDJIwRnlijxiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i7Y7QaGO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i7Y7QaGO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755154161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LO798oR9V7f4QGUYhH0qU7QUeCyLYr6WhbregzpYOT4=;
	b=i7Y7QaGOFthNHMO8mKK1wXBRxVRLkGlP+qUViNQvWkGN5Y1i28KUc8mL5cv5XYjNjWt9Bc
	sSvPqW08NRr+W9tEHdNWENfjPRyFPgZ8cKFfdWP+cjy5M09GgXuVDEho82kn+v7dSf9Sgj
	ujCVgMBsBcKcEoHrLduRWAtseSrgNYU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-PbqKg2diN4uP5n04fwnIZw-1; Thu, 14 Aug 2025 02:49:20 -0400
X-MC-Unique: PbqKg2diN4uP5n04fwnIZw-1
X-Mimecast-MFC-AGG-ID: PbqKg2diN4uP5n04fwnIZw_1755154159
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32326bf571bso1124638a91.2
        for <virtualization@lists.linux.dev>; Wed, 13 Aug 2025 23:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755154159; x=1755758959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LO798oR9V7f4QGUYhH0qU7QUeCyLYr6WhbregzpYOT4=;
        b=TUbIRAf05mA24vWir5auHGqyrUxhR6oezfwIDdKkcKq6EQ44i4bq/trNKy/R8EZPDj
         5HpVEsq1MFWXvbf/zrbZr4z4RKl1wh5u6FdTvK3LQRns0iRHOiuNilkjEDb5NsQiPnVR
         k6kT1J4HkkB/pcdEdbnyKh+79SZEYAr6Lmqk78wrD9XYPtA+bHE6OAp4k75Dz57iopW6
         7nKEtllhcZn902nED5/1gT1vol7aP7JQxz73Fms1BGjxDPsQcAJHBZWrWrxr1kCVpDcu
         uAieUkUu7i0XDjlI9PB32uu2fx3w9a1m/seZB+4PwLERdadkYcu/vrcJqDJHDk3w3/0q
         1Heg==
X-Forwarded-Encrypted: i=1; AJvYcCV0Md28OFfRjqVpE/1wpgHMXjFq6++T5+0SFv+aiqZEF3jtam7cUcnM+Gan/zIdZx9+Fyi2ROCbN2GXC4EvLQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWiiUZo4+EkrUbZyIGK39Q0rGa7V8Q7noi5JFmMLjxjx+g+iiR
	0EUUwzzMzCrpEmU+Znu6rxygK/ryjXYF4FskQyGuGf1wTG9fPC1sXNG0xNrMC+pyGwdSu+onIEi
	8tTvtOp4enV2+I+vESdjSSRPO293cjY6Cl2hwg9yBfRX78MwWMqcfR4/RITTLrtg93oqVV/lOUM
	DOmzML5vtui6s8l4oQxTv0FibaBYzG9EwoH4o4LkgTIyg=
X-Gm-Gg: ASbGncvPQ4j3ER8QapV54zWW5dvNv1vavXFyu86wV4RouU1qS0LqJlhJkvSM+lgPyjC
	sp8yKxNtxck+/ZyXIcIFSd64YBQgDgeKlNf5WLTbvxzANh2ELyZ46fNt+k2WF0UchBjXvkoABVo
	o+RoNlShGwant9gutte9w5
X-Received: by 2002:a17:90b:498f:b0:321:2f06:d3ab with SMTP id 98e67ed59e1d1-32327a4e233mr3543180a91.21.1755154158744;
        Wed, 13 Aug 2025 23:49:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfLKZeY97GZlPTXdXucawAzu0OViVj6oxVpjVN7y1DF4VOB66N8oBnN4DpVarN31Ap+tTgIom2fZx76AzHL14=
X-Received: by 2002:a17:90b:498f:b0:321:2f06:d3ab with SMTP id
 98e67ed59e1d1-32327a4e233mr3543146a91.21.1755154158349; Wed, 13 Aug 2025
 23:49:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CGME20250814054321epcas5p1dd83614241a15c78645e7f08d5e959c3@epcas5p1.samsung.com>
 <CACGkMEs+RCx=9kun2KwMutmN4oEkxzW4KDNW=gwXNZD=gpetrg@mail.gmail.com> <20250814054333.1313117-1-junnan01.wu@samsung.com>
In-Reply-To: <20250814054333.1313117-1-junnan01.wu@samsung.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 14 Aug 2025 14:49:06 +0800
X-Gm-Features: Ac12FXy3pyAswh9ZdliC9-DhQ4V7aojBduteSBRgUSTtF5UgkCnNR9fkZIKr2ws
Message-ID: <CACGkMEuCaOs_towX_CGUdnpDJBPrN9vZ3=s84RKJ3PsRX5s7OQ@mail.gmail.com>
Subject: Re: [PATCH net] virtio_net: adjust the execution order of function
 `virtnet_close` during freeze
To: Junnan Wu <junnan01.wu@samsung.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	eperezma@redhat.com, kuba@kernel.org, lei19.wang@samsung.com, 
	linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, q1.huang@samsung.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com, ying123.xu@samsung.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xFCpFVSUPHABA0Y_bQChogSBE-kE5KvLEw_3YtVqCqo_1755154159
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 2:44=E2=80=AFPM Junnan Wu <junnan01.wu@samsung.com>=
 wrote:
>
> On Thu, 14 Aug 2025 12:01:18 +0800 Jason Wang wrote:
> > On Thu, Aug 14, 2025 at 10:36=E2=80=AFAM Junnan Wu <junnan01.wu@samsung=
.com> wrote:
> > >
> > > On Wed, 13 Aug 2025 17:23:07 -0700 Jakub Kicinski wrote:
> > > > Sounds like a fix people may want to backport. Could you repost wit=
h
> > > > an appropriate Fixes tag added, pointing to the earliest commit whe=
re
> > > > the problem can be observed?
> > >
> > > This issue is caused by commit "7b0411ef4aa69c9256d6a2c289d0a2b320414=
633"
> > > After this patch, during `virtnet_poll`, function `virtnet_poll_clean=
tx`
> > > will be invoked, which will wakeup tx queue and clear queue state.
> > > If you agree with it, I will repost with this Fixes tag later.
> > >
> > > Fixes: 7b0411ef4aa6 ("virtio-net: clean tx descriptors from rx napi")
> >
> > Could you please explain why it is specific to RX NAPI but not TX?
> >
> > Thanks
>
> This issue appears in suspend flow, if a TCP connection in host VM is sti=
ll
> sending packet before driver suspend is completed, it will tigger RX napi=
 schedule,
> Finally "use after free" happens when tcp ack timer is up.
>
> And in suspend flow, the action to send packet is already stopped in gues=
t VM,

The TX interrupt and NAPI is not disabled yet. Or anything I miss here?

> therefore TX napi will not be scheduled.
>

Thanks

