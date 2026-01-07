Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFFA352FB1
	for <virtualization@lists.linux.dev>; Wed,  7 Jan 2026 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767801695; cv=none; b=KzohdHJrht0qYJm+5OKyh0W8ay+08iIpPbfsro89fKIoFQ1I20WhgzaC5UsoRzt6s4r3P8i9aZGbEIKOxxE98w3zZEDgzJXQmbNIg1kX2jbpYqQhk9XJEU6+gVqOYAyHjgP47gwcVeHiLJ0Bx5gHI23ucnivFxfhBZUlPyLOR54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767801695; c=relaxed/simple;
	bh=MdOcdyzquYrZDcCkvAdD4u7MwXhRoEn3mysqAcqq4vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8InAp57h5ucfHi80CmIyOOvy4dmxZIe0ZRGUEjIo0EvD7z8f+HW6cD3fZF3p9USVyeR+6JwJb+2s/0TuW5+uug0NGFmQa2Qu8gu1CXSB8kt38sC2kWmq9TBDNFcCOngD5uFid9HDZTs6altHi5k5IOSEANqwq4FMDxDvyGhAos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CLVUfVNU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CLVUfVNU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767801683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+GCGBIzPMtbCjCRcA/11dyPDvN/EIpJyJO7gZQLRTXU=;
	b=CLVUfVNUUP+uMxScZFudZeb4ySwMw13brVMG2Fw1fP3Yn1RKgQGHx4Phm1B0zplThSv8pn
	Un0AMIeYJ8e3DhoO6ClHV70oVY9ZJPMFgtNnimSdxUxwMhvT8Izm5z4KnifRfh5/JOQNUN
	r4MJy06QNTNDTORDr9C0tk5B/aWfxzs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-WLshuTs5NRG4wmsWhBXtmQ-1; Wed, 07 Jan 2026 11:01:20 -0500
X-MC-Unique: WLshuTs5NRG4wmsWhBXtmQ-1
X-Mimecast-MFC-AGG-ID: WLshuTs5NRG4wmsWhBXtmQ_1767801679
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b802d6ed5b0so269407166b.1
        for <virtualization@lists.linux.dev>; Wed, 07 Jan 2026 08:01:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767801678; x=1768406478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+GCGBIzPMtbCjCRcA/11dyPDvN/EIpJyJO7gZQLRTXU=;
        b=Nc7ppiDp39IQWrO6St4MEA0PZArFTDvcsgIjBAEETLmpEqOgMApIW+bVs2PLZSDhoY
         fXqD7I3kewDsqpaio4c1RW8JhiKaYm9Gf5cgPvxd4dxdj2otB8tH1p21ix77+T/FBfyt
         tLzs0XXEgRO8PHhsPxAPV0LQzHun5Q/HkGBYQJ5TEW+VTdGV2aH+VwNTbB7/XsC8DExD
         DKvrTZjmTlChwTwXX4Vh7EitboXIfmetyZlajrFdQM/XueZpF+qLYAsLJu12OAzg16JG
         VaRtMuppYxpWurYOwWGsnHkLFSfe1IUEtu6Y2c8DSvmhSX5Cx2ZccTPAM6na+aPxd1Q8
         K55Q==
X-Forwarded-Encrypted: i=1; AJvYcCXem1K+W8/JcHoqT6gXhwLCICvj413oOl6+CpnGydPNed9CH1zLZqGSHuEyTJ32ddYTkJL8ZoO+jaxyS11gKA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2DNzeqZWW8UlcknsLmnmvjaqspTMkHu/Gu4lEGPkVzZ6l9f5E
	RAd0pEqpfW+Va5FlBEbTBVsGtyhFbdrtGr35kZDEPUaD7TlRzGB5QfZVLMsd5rEgJq8kxhUUiQ8
	ULtVmezgw++oEBapD+LxxJQ8fg0yzHgaG07Rjs0Vwiw8YPPjZeO/lbXkte0iQ3b0PvvVIeaYtWJ
	BUSjXsam7hu+ACa4BzZKk4bih9kIc89fW8BbzFDojEPcE=
X-Gm-Gg: AY/fxX4bs2ZpuM3I117AG9rniQE2SUog6JT2+hOF0xGv9p5gro8WQEk5ZnSOyK4J4t6
	wnMPd2yG4Ledu4j4n7N78HVavyMXXW6BcKNSU4BmWboXA0nzu/+1vryT5ZBsHFmJujzxTDUGLbW
	v+50aaVXU4M18qy61jWJQE155m2v7T01wC8mmvCYf7G2vCPPuO+jNnkEJjUOB7nRAK/rOl6ZFq1
	Cz2m91Jw3DIwj8onDumyoXz
X-Received: by 2002:a17:907:744:b0:b3a:8070:e269 with SMTP id a640c23a62f3a-b8444cdaca3mr324248066b.14.1767801676928;
        Wed, 07 Jan 2026 08:01:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyCAq53fyeByL4uwfhi/No4YQ7czygIKiwAQVVyDJqhoFue0IDP5c7aLvHfVLZvRrOyLo5oxdZcQ/tUxmoZNg=
X-Received: by 2002:a17:907:744:b0:b3a:8070:e269 with SMTP id
 a640c23a62f3a-b8444cdaca3mr324238066b.14.1767801675603; Wed, 07 Jan 2026
 08:01:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <aQJRnX7OpFRY/1+H@fedora> <aQkgsuxa2UaL_qdt@bywater>
 <aTsE1VIk4V/A49HE@fedora> <aT7XAsTWr0_yyfx_@bywater> <aVLOPMmpvArnVAHZ@fedora>
 <aVLq1ibPcPHk-7Qv@bywater> <e5bc1353-ed3e-478b-a26e-0bb9a50b3863@oss.qualcomm.com>
 <4cf222cb-e6e3-4d09-a7d8-bc64b8e148bd@hartkopp.net> <aV1zB_fYQE_OBZm2@bywater>
 <8134fcf0-9a9d-41be-bcc3-80db23932f9b@hartkopp.net>
In-Reply-To: <8134fcf0-9a9d-41be-bcc3-80db23932f9b@hartkopp.net>
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Date: Wed, 7 Jan 2026 17:01:04 +0100
X-Gm-Features: AQt7F2rsYl9GEMuxAghLtvGU8Co9nXZ_2-3hri17K1baiVrKZlfsg5jLK74bXDM
Message-ID: <CAHYGQ0yTNTf3T=FM7B3NcG_BFmUSDS62cO0s=x2Bb7U1j=bq5A@mail.gmail.com>
Subject: Re: [PATCH v6] can: virtio: Add virtio CAN driver
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Francesco Valla <francesco@valla.it>, Harald Mommer <harald.mommer@oss.qualcomm.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-can@vger.kernel.org, 
	virtualization@lists.linux.dev, Wolfgang Grandegger <wg@grandegger.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1XUCjo1ffZWfxClzArm9Qg04BO1nv7EDkcpBxXOVHI4_1767801679
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 4:45=E2=80=AFPM Oliver Hartkopp <socketcan@hartkopp.=
net> wrote:
>
> Hi Francesco,
>
> On 06.01.26 21:39, Francesco Valla wrote:
> > Hello Harald, Oliver,
> >
> > On Tue, Jan 06, 2026 at 08:43:42PM +0100, Oliver Hartkopp wrote:
> >>
> >>
> >> On 06.01.26 17:50, Harald Mommer wrote:
> >>>> With the plain 'cangen' you are not really flooding the interface, s=
ince
> >>>> you are only sending a random CAN frame every 200ms. The only way I =
can
> >>>> reproduce this behaviour in a consistent manner is running from the =
host:
> >>>>
> >>>>       while true; do cansend vcan0 134#00; done
> >>>>
> >>>> which seems to generate the maximum amount of traffic.
> >>>>
> >>>> This is not of course a realistic bus load, but is leading the syste=
m
> >>>> (at least on my setup) to a corner case somewhere.
> >>>
> >>> I have no idea how long the shell needs for a loop, always used cange=
n -g 0 to stress the setup which is most probably faster than the shell int=
erpreter, and sometimes did this for both directions (RX and TX).
> >>>
> >>> Full load is a realistic setup. And even if it was not, if something =
stopped working or worse crashes torturing the setup this was a problem.
> >>>
> >>
> >> Yes. cangen -g 0 -i <interface> creates full load - even on real CAN
> >> interfaces. You can also generate fixed content if you want to omit th=
e
> >> generation of randomized content. 'cangen -?' prints a help text.
> >>
> >
> > I agree with both of you - I was simply arguing that a plain 'cangen'
> > with no parameters is not really loading the interface.
> >
> > For some reason, I was only able to trigger the unwanted behavior with
> > cansend in a while loop and not with cangen -g 0, even with fixed ID an=
d
> > payload. However, I suspect the issue is a matter of timing and
> > coincidences rather than load level.
>
> Yes, the difference is, that you open a new CAN socket each time with
> cansend, while cangen opens one socket and pushes lots of frames into it.
>
> Btw. this should not lead to a stuck CAN interface.
>
> Is the interface usable from another terminal (with cansend/candump) or
> how does this 'stuck interface' look like?
>

I reported the issue here:
https://github.com/rust-vmm/vhost-device/issues/923. It seems it is
the device implementation. I am working on a fix.

Matias

