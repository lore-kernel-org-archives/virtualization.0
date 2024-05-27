Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96575C129
	for <virtualization@lists.linux.dev>; Mon, 27 May 2024 03:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716781349; cv=none; b=RWASqV/z7XQ+pLDIbv+IuRx914LJYz6OHLC6rAgqmin/vBV1C/crk+EltlOoUO02Rpvq4E3olj/MJH8lnxPAwnUzM1N0AbyCtBopr1bTecwA1KOCkm1C/+aBxzncGy3gyEUjkCO+K/xxoyxWYnEDmlG8OMsIvKycYgPDo9vPQME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716781349; c=relaxed/simple;
	bh=9JhHeiZ9fOYcxEd9/L7NL2iPzeWxkKhXRJPssf1Lhv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vj6/cbl9fdrHVa0wJsAKbCk2UGtoNxE14+FPrUi4FXfewfYNqcSwPP2URYc/zWOIv6s6gFY/oXrGbjaEoaixLjxowxVr3lwaHYwFr+aEuJVspxOvGrIzl1FlQFfuz1DlrRi9TodKKr3iNY+9Omx3CLXTpBZDXGqLGY3n7na6MXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K9LdJiQA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K9LdJiQA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716781346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q1G1TXr3mQFj361bybeNtAM3UF+HS5/GK6HdcRE4LH8=;
	b=K9LdJiQAPQG78OzxzzN55WrohFYCQxbOd03870gUwdj2U/NR+on5YPV7T5v51PG/d0QlCb
	nOoONoXdvTQCovHWFcCkAKPdMFynYxj5WrCqnVSe8sHSemN2HXfdKoL5XMxAxHDrf0Hc8n
	xsz/z8wBD+ErzrBJc7dmfMAl09W6w1U=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-TqNRH9xEPFaWmpeMGBX2LA-1; Sun, 26 May 2024 23:42:25 -0400
X-MC-Unique: TqNRH9xEPFaWmpeMGBX2LA-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6fd6f37e918so1120352b3a.3
        for <virtualization@lists.linux.dev>; Sun, 26 May 2024 20:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716781343; x=1717386143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q1G1TXr3mQFj361bybeNtAM3UF+HS5/GK6HdcRE4LH8=;
        b=jwT5hC/WuW95u8D40aAkd179CC0qoMzeuDSnLpyookajK1KiWKFaIfwkHv1tBYuhDe
         ATucL8uJOZVuBEaNJySWuWtgQhFC5xm+uI4WbBQkEIbr7bfxZZrrcW74fmUeMWZfDA4k
         xKfLFUGQ4j1jCYpt8zdt6SwZfEJlz1KMvp1Q/3+WJtj+UhhUvjGWZftE2/JTxfv8Azaf
         XWAN0QsYZubMNmBXCLCzBAMooHIPyMEfB/rJ1z5udtAD6CxdOBHI6SK64V5XJrIlaORL
         kpr4RhRm/Mq4bJ/qk/FfdyS3vt7fMghXwhfTodbenF0NTk4IOPg9s937WO+v4huoaMom
         hTmg==
X-Forwarded-Encrypted: i=1; AJvYcCWvKsCCyp8QHLa1uoTiaPJ+tjgbYtMpJ2ej8DXoScYpP2vdtCX70ocYTHLJiL1WopNRjrkjD2J2KW9kDXb9KdqKQOna+pOQgx7V/LakCis=
X-Gm-Message-State: AOJu0YzvEG10lPG4Rsj+8fqEEIkvXSXYS3R2lWx27pwd7+TeAGCw3TVh
	9NY+lP3S96no3BwFlqcjlaWNo6ueVQo8c6U8UYxaq7O63mkmkP9o2YLsbukYPIGHhPlXWZPgeUB
	t0Q/3tLCWnRiTnC8ODpLpCW9/FfTUwT4uYSwO3xFVXglUTwDFH9L3ND3f0eZx2/FVw8tdQ3+qA1
	X2BgawrOB5QvvPcrXOND62SQn3QZH6pgUya7q8frFpx0Z3qDw=
X-Received: by 2002:a05:6a20:100f:b0:1af:adbf:2a16 with SMTP id adf61e73a8af0-1b212f3490emr7508509637.43.1716781343577;
        Sun, 26 May 2024 20:42:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFybCZv23Y7GXVDMeC7chDqiMFhio61O2YMrgc104tFi3NC+o27SBwMZyMBIWybqNYXnz1HGzreZpP/TYbQTko=
X-Received: by 2002:a05:6a20:100f:b0:1af:adbf:2a16 with SMTP id
 adf61e73a8af0-1b212f3490emr7508493637.43.1716781343116; Sun, 26 May 2024
 20:42:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240520010302.68611-1-jasowang@redhat.com> <8ff81e78d13975c852800dbae2aca7342e8b6fea.camel@redhat.com>
In-Reply-To: <8ff81e78d13975c852800dbae2aca7342e8b6fea.camel@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 27 May 2024 11:42:12 +0800
Message-ID: <CACGkMEtqRqj9hNki3TaCqAwUC9yY-kUYxmTKoM2b62D44PeDMA@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio-net: synchronize operstate with admin
 state on up/down
To: Paolo Abeni <pabeni@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>, 
	Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 4:14=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Mon, 2024-05-20 at 09:03 +0800, Jason Wang wrote:
> > This patch synchronize operstate with admin state per RFC2863.
> >
> > This is done by trying to toggle the carrier upon open/close and
> > synchronize with the config change work. This allows propagate status
> > correctly to stacked devices like:
> >
> > ip link add link enp0s3 macvlan0 type macvlan
> > ip link set link enp0s3 down
> > ip link show
> >
> > Before this patch:
> >
> > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN m=
ode DEFAULT group default qlen 1000
> >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > ......
> > 5: macvlan0@enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1500 q=
disc noqueue state UP mode DEFAULT group default qlen 1000
> >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> >
> > After this patch:
> >
> > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN m=
ode DEFAULT group default qlen 1000
> >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > ...
> > 5: macvlan0@enp0s3: <NO-CARRIER,BROADCAST,MULTICAST,UP,M-DOWN> mtu 1500=
 qdisc noqueue state LOWERLAYERDOWN mode DEFAULT group default qlen 1000
> >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> >
> > Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
> > Cc: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> ## Form letter - net-next-closed
>
> The merge window for v6.10 has begun and we have already posted our
> pull
> request. Therefore net-next is closed for new drivers, features, code
> refactoring and optimizations. We are currently accepting bug fixes
> only.
>
> Please repost when net-next reopens after May 26th.

Will repost thanks.

>
> RFC patches sent for review only are obviously welcome at any time.
>
> See:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#devel=
opment-cycle

Thanks for the pointer, I've done a short path by just looking at if
there's a patch with net-next posted in netdev :(

> --
> pw-bot: defer
>
>

